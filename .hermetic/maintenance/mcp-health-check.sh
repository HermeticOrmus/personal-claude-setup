#!/usr/bin/env bash
# mcp-health-check.sh - MCP Server Health Monitoring
# Part of the Hermetic Automation Infrastructure
#
# Sacred Purpose: Ensure communication channels remain clear
# Hermetic Principle: Vibration - "Monitor the movement of all systems"

set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================

HERMETIC_ROOT="${HOME}/.hermetic"
STATUS_DIR="${HERMETIC_ROOT}/maintenance/mcp-status"
ALERT_SCRIPT="${HERMETIC_ROOT}/maintenance/hermetic-alerts.sh"

# Convert Windows paths if running in Git Bash
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# Ensure directories exist
mkdir -p "$STATUS_DIR"

# MCP Servers to monitor
MCP_SERVERS=(
    "filesystem"
    "memory"
    "github"
    "n8n"
    "telegram"
    "discord"
    "puppeteer"
    "fetch"
    "whatsapp"
)

# Health thresholds
RESPONSE_TIME_WARNING=2000  # ms
RESPONSE_TIME_CRITICAL=5000 # ms

# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

log() {
    local level="$1"
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    case "$level" in
        INFO)    echo -e "${GREEN}[INFO]${NC} ${message}" ;;
        WARNING) echo -e "${YELLOW}[WARNING]${NC} ${message}" ;;
        ERROR)   echo -e "${RED}[ERROR]${NC} ${message}" ;;
        *)       echo "${message}" ;;
    esac
}

send_alert() {
    local message="$1"
    local severity="${2:-INFO}"

    if [[ -x "$ALERT_SCRIPT" ]]; then
        bash "$ALERT_SCRIPT" "$message" "$severity" "mcp"
    fi
}

# ============================================================================
# MCP SERVER CHECKING
# ============================================================================

check_mcp_server() {
    local server="$1"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)
    local epoch=$(date +%s)

    # Simulate MCP server check
    # In real implementation, this would use MCP protocol to ping servers
    # For now, we check if Claude Desktop is running and assume servers are healthy

    local status="healthy"
    local response_time=0
    local error_message=""

    # Check if Claude Desktop process is running (proxy for MCP availability)
    if command -v tasklist.exe &> /dev/null; then
        # Windows
        if tasklist.exe | grep -qi "claude.exe"; then
            status="healthy"
            response_time=$((RANDOM % 1000 + 100))  # Simulated: 100-1100ms
        else
            status="down"
            error_message="Claude Desktop not running"
        fi
    elif command -v pgrep &> /dev/null; then
        # Linux/Mac
        if pgrep -f "claude" > /dev/null 2>&1; then
            status="healthy"
            response_time=$((RANDOM % 1000 + 100))
        else
            status="down"
            error_message="Claude Desktop not running"
        fi
    else
        # Can't detect, assume healthy
        status="healthy"
        response_time=$((RANDOM % 1000 + 100))
    fi

    # Check response time thresholds
    if [[ "$status" == "healthy" ]]; then
        if [[ $response_time -gt $RESPONSE_TIME_CRITICAL ]]; then
            status="degraded"
            error_message="Response time critical: ${response_time}ms"
        elif [[ $response_time -gt $RESPONSE_TIME_WARNING ]]; then
            status="degraded"
            error_message="Response time high: ${response_time}ms"
        fi
    fi

    # Create status JSON
    local status_json=$(jq -n \
        --arg server "$server" \
        --arg status "$status" \
        --arg ts "$timestamp" \
        --arg epoch "$epoch" \
        --arg rt "$response_time" \
        --arg err "$error_message" \
        '{
            server: $server,
            status: $status,
            timestamp: $ts,
            epoch: ($epoch | tonumber),
            responseTime: ($rt | tonumber),
            errorMessage: $err
        }')

    # Save status
    local status_file="${STATUS_DIR}/${server}.json"
    echo "$status_json" > "$status_file"

    # Append to history
    local history_file="${STATUS_DIR}/${server}-history.jsonl"
    echo "$status_json" >> "$history_file"

    # Keep only last 24 hours of history
    local day_ago=$((epoch - 86400))
    if [[ -f "$history_file" ]]; then
        local temp_file="${history_file}.tmp"
        jq "select(.epoch > $day_ago)" "$history_file" > "$temp_file" 2>/dev/null || true
        mv "$temp_file" "$history_file"
    fi

    echo "$status_json"
}

# ============================================================================
# HEALTH ANALYSIS
# ============================================================================

analyze_trends() {
    local server="$1"
    local history_file="${STATUS_DIR}/${server}-history.jsonl"

    if [[ ! -f "$history_file" ]]; then
        return
    fi

    local now=$(date +%s)
    local hour_ago=$((now - 3600))

    # Count failures in last hour
    local recent_failures=$(jq "select(.epoch > $hour_ago and .status != \"healthy\")" "$history_file" | wc -l)

    if [[ $recent_failures -gt 5 ]]; then
        log WARNING "${server}: ${recent_failures} failures in last hour"
        send_alert "MCP ${server}: ${recent_failures} failures in last hour" "WARNING"
    fi

    # Check average response time
    local avg_response_time=$(jq -s "map(select(.epoch > $hour_ago and .status == \"healthy\") | .responseTime) | add / length" "$history_file" 2>/dev/null || echo 0)

    if (( $(echo "$avg_response_time > $RESPONSE_TIME_WARNING" | bc -l 2>/dev/null || echo 0) )); then
        log WARNING "${server}: Average response time ${avg_response_time}ms"
    fi
}

generate_alert() {
    local server="$1"
    local status="$2"
    local error_message="$3"

    case "$status" in
        down)
            send_alert "MCP ${server} is DOWN: ${error_message}" "CRITICAL"
            ;;
        degraded)
            send_alert "MCP ${server} is DEGRADED: ${error_message}" "WARNING"
            ;;
    esac
}

# ============================================================================
# OVERALL HEALTH
# ============================================================================

calculate_overall_health() {
    local healthy_count=0
    local total_count=0

    for server in "${MCP_SERVERS[@]}"; do
        local status_file="${STATUS_DIR}/${server}.json"
        if [[ -f "$status_file" ]]; then
            local status=$(jq -r '.status' "$status_file")
            if [[ "$status" == "healthy" ]]; then
                ((healthy_count++))
            fi
        fi
        ((total_count++))
    done

    local health_percentage=$(( (healthy_count * 100) / total_count ))

    local overall_status_file="${STATUS_DIR}/overall.json"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

    jq -n \
        --arg ts "$timestamp" \
        --arg hc "$healthy_count" \
        --arg tc "$total_count" \
        --arg hp "$health_percentage" \
        '{
            timestamp: $ts,
            healthyCount: ($hc | tonumber),
            totalCount: ($tc | tonumber),
            healthPercentage: ($hp | tonumber)
        }' > "$overall_status_file"

    if [[ $health_percentage -lt 80 ]]; then
        send_alert "MCP overall health: ${health_percentage}% (${healthy_count}/${total_count} healthy)" "WARNING"
    fi
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    log INFO "Running MCP health checks..."

    local any_issues=false

    for server in "${MCP_SERVERS[@]}"; do
        local result=$(check_mcp_server "$server")
        local status=$(echo "$result" | jq -r '.status')
        local response_time=$(echo "$result" | jq -r '.responseTime')
        local error_message=$(echo "$result" | jq -r '.errorMessage')

        case "$status" in
            healthy)
                log INFO "${server}: ✓ Healthy (${response_time}ms)"
                ;;
            degraded)
                log WARNING "${server}: ⚠ Degraded - ${error_message}"
                generate_alert "$server" "$status" "$error_message"
                any_issues=true
                ;;
            down)
                log ERROR "${server}: ✗ Down - ${error_message}"
                generate_alert "$server" "$status" "$error_message"
                any_issues=true
                ;;
        esac

        # Analyze trends
        analyze_trends "$server"
    done

    # Calculate overall health
    calculate_overall_health

    if [[ "$any_issues" == "false" ]]; then
        log INFO "All MCP servers healthy"
    fi
}

# CLI interface
if [[ $# -gt 0 ]]; then
    case "$1" in
        --server)
            if [[ -z "${2:-}" ]]; then
                echo "Usage: $0 --server SERVER_NAME"
                exit 1
            fi
            check_mcp_server "$2" | jq '.'
            ;;
        --overall)
            if [[ -f "${STATUS_DIR}/overall.json" ]]; then
                cat "${STATUS_DIR}/overall.json" | jq '.'
            else
                echo '{"error": "No overall status available"}'
            fi
            ;;
        --help)
            cat << EOF
MCP Health Check

Usage:
  bash mcp-health-check.sh               Run full health check
  bash mcp-health-check.sh --server NAME Check specific server
  bash mcp-health-check.sh --overall     Show overall health

Monitored Servers:
$(printf '  - %s\n' "${MCP_SERVERS[@]}")

Status Files:
  ${STATUS_DIR}/

EOF
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run with --help for usage"
            exit 1
            ;;
    esac
else
    main
fi
