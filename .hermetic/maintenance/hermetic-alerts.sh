#!/usr/bin/env bash
# hermetic-alerts.sh - Unified Alert System
# Part of the Hermetic Automation Infrastructure
#
# Sacred Purpose: Bring the invisible to light through mindful notification
# Hermetic Principle: Mentalism - "Make the system's thoughts visible"
#
# Usage:
#   bash hermetic-alerts.sh "Message" [SEVERITY] [SOURCE]
#   SEVERITY: INFO (default), WARNING, CRITICAL
#   SOURCE: backup, mcp, session, n8n, dashboard (default: manual)

set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================

HERMETIC_ROOT="${HOME}/.hermetic"
CONFIG_FILE="${HERMETIC_ROOT}/maintenance/alerts-config.json"
ALERT_HISTORY="${HERMETIC_ROOT}/maintenance/alert-history.jsonl"
THROTTLE_STATE="${HERMETIC_ROOT}/maintenance/alert-throttle-state.json"

# Ensure directories exist
mkdir -p "${HERMETIC_ROOT}/maintenance"

# Convert Windows paths if running in Git Bash
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# ANSI Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

log() {
    local level="$1"
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    case "$level" in
        INFO)    echo -e "${GREEN}[INFO]${NC} ${timestamp} - ${message}" ;;
        WARNING) echo -e "${YELLOW}[WARNING]${NC} ${timestamp} - ${message}" ;;
        ERROR)   echo -e "${RED}[ERROR]${NC} ${timestamp} - ${message}" ;;
        CRITICAL) echo -e "${RED}[CRITICAL]${NC} ${timestamp} - ${message}" ;;
        *)       echo "${timestamp} - ${message}" ;;
    esac
}

get_severity_code() {
    case "$1" in
        INFO) echo 0 ;;
        WARNING) echo 1 ;;
        CRITICAL) echo 2 ;;
        *) echo 0 ;;
    esac
}

# ============================================================================
# THROTTLING LOGIC
# ============================================================================

should_throttle() {
    local message="$1"
    local severity="$2"
    local source="$3"

    # CRITICAL alerts bypass throttling
    if [[ "$severity" == "CRITICAL" ]]; then
        return 1  # Don't throttle
    fi

    # Check if throttling is enabled
    if [[ ! -f "$CONFIG_FILE" ]]; then
        return 1  # No config, don't throttle
    fi

    local throttle_enabled=$(jq -r '.throttling.enabled // true' "$CONFIG_FILE")
    if [[ "$throttle_enabled" != "true" ]]; then
        return 1  # Throttling disabled
    fi

    local cooldown_minutes=$(jq -r '.throttling.cooldownMinutes // 60' "$CONFIG_FILE")
    local max_per_hour=$(jq -r '.throttling.maxAlertsPerHour // 10' "$CONFIG_FILE")
    local now=$(date +%s)

    # Initialize throttle state if it doesn't exist
    if [[ ! -f "$THROTTLE_STATE" ]]; then
        echo '{"alerts": []}' > "$THROTTLE_STATE"
    fi

    # Create message hash for cooldown tracking
    local message_hash=$(echo -n "${source}:${message}" | md5sum | cut -d' ' -f1)

    # Check cooldown for this specific message
    local last_sent=$(jq -r ".alerts[] | select(.hash == \"$message_hash\") | .timestamp // 0" "$THROTTLE_STATE" | tail -1)
    if [[ -n "$last_sent" && "$last_sent" != "0" ]]; then
        local elapsed=$(( (now - last_sent) / 60 ))
        if [[ $elapsed -lt $cooldown_minutes ]]; then
            log INFO "Alert throttled (cooldown): ${cooldown_minutes}m since last similar alert"
            return 0  # Throttle
        fi
    fi

    # Check rate limit (alerts in last hour)
    local hour_ago=$((now - 3600))
    local recent_count=$(jq "[.alerts[] | select(.timestamp > $hour_ago)] | length" "$THROTTLE_STATE")

    if [[ $recent_count -ge $max_per_hour ]]; then
        log WARNING "Alert throttled (rate limit): ${recent_count}/${max_per_hour} alerts in last hour"
        return 0  # Throttle
    fi

    # Record this alert
    local new_alert=$(jq -n \
        --arg hash "$message_hash" \
        --arg ts "$now" \
        --arg sev "$severity" \
        --arg src "$source" \
        '{hash: $hash, timestamp: ($ts | tonumber), severity: $sev, source: $src}')

    jq ".alerts += [$new_alert]" "$THROTTLE_STATE" > "${THROTTLE_STATE}.tmp"
    mv "${THROTTLE_STATE}.tmp" "$THROTTLE_STATE"

    # Clean old entries (older than 24 hours)
    local day_ago=$((now - 86400))
    jq ".alerts = [.alerts[] | select(.timestamp > $day_ago)]" "$THROTTLE_STATE" > "${THROTTLE_STATE}.tmp"
    mv "${THROTTLE_STATE}.tmp" "$THROTTLE_STATE"

    return 1  # Don't throttle
}

# ============================================================================
# ALERT CHANNELS
# ============================================================================

send_to_telegram() {
    local message="$1"
    local severity="$2"

    if [[ ! -f "$CONFIG_FILE" ]]; then
        log WARNING "No config file found, skipping Telegram"
        return 1
    fi

    local enabled=$(jq -r '.telegram.enabled // false' "$CONFIG_FILE")
    if [[ "$enabled" != "true" ]]; then
        return 0
    fi

    # Check severity filter
    local severity_filter=$(jq -r '.telegram.severityFilter[]? // empty' "$CONFIG_FILE")
    if [[ -n "$severity_filter" ]]; then
        if ! echo "$severity_filter" | grep -q "$severity"; then
            log INFO "Telegram: Severity $severity not in filter"
            return 0
        fi
    fi

    local chat_id=$(jq -r '.telegram.chatId' "$CONFIG_FILE")
    local bot_token="${TELEGRAM_BOT_TOKEN:-}"

    if [[ -z "$bot_token" ]]; then
        log WARNING "TELEGRAM_BOT_TOKEN not set in environment"
        return 1
    fi

    if [[ -z "$chat_id" || "$chat_id" == "null" ]]; then
        log WARNING "Telegram chatId not configured"
        return 1
    fi

    # Format message with emoji
    local emoji="ℹ️"
    case "$severity" in
        WARNING) emoji="⚠️" ;;
        CRITICAL) emoji="🚨" ;;
    esac

    local formatted_message="${emoji} *${severity}*\n\n${message}"

    # Send via Telegram API
    local response=$(curl -s -X POST \
        "https://api.telegram.org/bot${bot_token}/sendMessage" \
        -d "chat_id=${chat_id}" \
        -d "text=${formatted_message}" \
        -d "parse_mode=Markdown" 2>&1)

    if echo "$response" | jq -e '.ok' > /dev/null 2>&1; then
        log INFO "✓ Sent to Telegram"
        return 0
    else
        log ERROR "Failed to send to Telegram: $(echo "$response" | jq -r '.description // "Unknown error"')"
        return 1
    fi
}

send_to_discord() {
    local message="$1"
    local severity="$2"

    if [[ ! -f "$CONFIG_FILE" ]]; then
        log WARNING "No config file found, skipping Discord"
        return 1
    fi

    local enabled=$(jq -r '.discord.enabled // false' "$CONFIG_FILE")
    if [[ "$enabled" != "true" ]]; then
        return 0
    fi

    # Check severity filter
    local severity_filter=$(jq -r '.discord.severityFilter[]? // empty' "$CONFIG_FILE")
    if [[ -n "$severity_filter" ]]; then
        if ! echo "$severity_filter" | grep -q "$severity"; then
            log INFO "Discord: Severity $severity not in filter"
            return 0
        fi
    fi

    local webhook_url=$(jq -r '.discord.webhookUrl' "$CONFIG_FILE")

    if [[ -z "$webhook_url" || "$webhook_url" == "null" ]]; then
        log WARNING "Discord webhookUrl not configured"
        return 1
    fi

    # Color based on severity
    local color="3447003"  # Blue for INFO
    case "$severity" in
        WARNING) color="16776960" ;;  # Yellow
        CRITICAL) color="15158332" ;;  # Red
    esac

    # Create Discord embed
    local payload=$(jq -n \
        --arg msg "$message" \
        --arg sev "$severity" \
        --arg color "$color" \
        --arg ts "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)" \
        '{
            embeds: [{
                title: ("Hermetic Alert: " + $sev),
                description: $msg,
                color: ($color | tonumber),
                timestamp: $ts,
                footer: {
                    text: "Hermetic Automation System"
                }
            }]
        }')

    # Send via Discord webhook
    local response=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -d "$payload" \
        "$webhook_url" 2>&1)

    if [[ -z "$response" ]]; then
        log INFO "✓ Sent to Discord"
        return 0
    else
        log ERROR "Failed to send to Discord: $response"
        return 1
    fi
}

# ============================================================================
# MAIN ALERT FUNCTION
# ============================================================================

send_alert() {
    local message="$1"
    local severity="${2:-INFO}"
    local source="${3:-manual}"

    # Validate severity
    case "$severity" in
        INFO|WARNING|CRITICAL) ;;
        *)
            log ERROR "Invalid severity: $severity (use INFO, WARNING, or CRITICAL)"
            return 1
            ;;
    esac

    # Check throttling
    if should_throttle "$message" "$severity" "$source"; then
        return 0  # Throttled, but not an error
    fi

    # Log to history
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)
    local severity_code=$(get_severity_code "$severity")

    local history_entry=$(jq -n \
        --arg ts "$timestamp" \
        --arg msg "$message" \
        --arg sev "$severity" \
        --arg code "$severity_code" \
        --arg src "$source" \
        '{
            timestamp: $ts,
            message: $msg,
            severity: $sev,
            severityCode: ($code | tonumber),
            source: $src
        }')

    echo "$history_entry" >> "$ALERT_HISTORY"

    # Send to configured channels
    local sent_count=0

    send_to_telegram "$message" "$severity" && ((sent_count++)) || true
    send_to_discord "$message" "$severity" && ((sent_count++)) || true

    # Always log locally
    log "$severity" "$message (source: $source)"

    if [[ $sent_count -eq 0 ]]; then
        log INFO "Alert logged locally only (no channels configured)"
    fi

    return 0
}

# ============================================================================
# CLI INTERFACE
# ============================================================================

show_usage() {
    cat << EOF
Hermetic Alert System

Usage:
  bash hermetic-alerts.sh MESSAGE [SEVERITY] [SOURCE]

Arguments:
  MESSAGE   Alert message text (required)
  SEVERITY  Alert severity: INFO (default), WARNING, CRITICAL
  SOURCE    Alert source: backup, mcp, session, n8n, dashboard (default: manual)

Examples:
  bash hermetic-alerts.sh "Backup completed successfully"
  bash hermetic-alerts.sh "MCP server not responding" WARNING mcp
  bash hermetic-alerts.sh "Disk space critical" CRITICAL backup

Configuration:
  Edit: ${CONFIG_FILE}
  - Enable/disable Telegram and Discord
  - Set severity filters per channel
  - Configure throttling settings

History:
  View alert history: bash view-alerts.sh recent
  Alert log location: ${ALERT_HISTORY}

EOF
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    if [[ $# -eq 0 ]]; then
        show_usage
        exit 0
    fi

    local message="$1"
    local severity="${2:-INFO}"
    local source="${3:-manual}"

    send_alert "$message" "$severity" "$source"
}

main "$@"
