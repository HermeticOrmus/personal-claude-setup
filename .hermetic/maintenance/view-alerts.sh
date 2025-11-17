#!/usr/bin/env bash
# view-alerts.sh - Alert History Dashboard
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
ALERT_HISTORY="${HERMETIC_ROOT}/maintenance/alert-history.jsonl"

# Convert Windows paths if running in Git Bash
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ============================================================================
# DISPLAY FUNCTIONS
# ============================================================================

format_alert() {
    local line="$1"

    local timestamp=$(echo "$line" | jq -r '.timestamp' | cut -d'T' -f1-2 | tr 'T' ' ')
    local message=$(echo "$line" | jq -r '.message')
    local severity=$(echo "$line" | jq -r '.severity')
    local source=$(echo "$line" | jq -r '.source')

    local color="$NC"
    case "$severity" in
        INFO) color="$GREEN" ;;
        WARNING) color="$YELLOW" ;;
        CRITICAL) color="$RED" ;;
    esac

    echo -e "${color}[$severity]${NC} ${timestamp} [${source}] ${message}"
}

show_statistics() {
    if [[ ! -f "$ALERT_HISTORY" ]]; then
        echo -e "${YELLOW}No alert history found${NC}"
        return
    fi

    local total=$(wc -l < "$ALERT_HISTORY")
    local info=$(grep -c '"severity":"INFO"' "$ALERT_HISTORY" || echo 0)
    local warning=$(grep -c '"severity":"WARNING"' "$ALERT_HISTORY" || echo 0)
    local critical=$(grep -c '"severity":"CRITICAL"' "$ALERT_HISTORY" || echo 0)

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Alert Statistics${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  Total Alerts: ${CYAN}${total}${NC}"
    echo -e "  ${GREEN}INFO:${NC}     $info"
    echo -e "  ${YELLOW}WARNING:${NC}  $warning"
    echo -e "  ${RED}CRITICAL:${NC} $critical"
    echo ""

    # Source breakdown
    echo -e "${BLUE}By Source:${NC}"
    jq -r '.source' "$ALERT_HISTORY" | sort | uniq -c | while read count source; do
        echo -e "  ${source}: ${CYAN}${count}${NC}"
    done
    echo ""
}

show_recent() {
    local count="${1:-20}"

    if [[ ! -f "$ALERT_HISTORY" ]]; then
        echo -e "${YELLOW}No alert history found${NC}"
        return
    fi

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Recent Alerts (last ${count})${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    tail -n "$count" "$ALERT_HISTORY" | while IFS= read -r line; do
        format_alert "$line"
    done
    echo ""
}

show_by_severity() {
    local severity="$1"

    if [[ ! -f "$ALERT_HISTORY" ]]; then
        echo -e "${YELLOW}No alert history found${NC}"
        return
    fi

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  ${severity} Alerts${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    grep "\"severity\":\"${severity}\"" "$ALERT_HISTORY" | while IFS= read -r line; do
        format_alert "$line"
    done
    echo ""
}

show_by_source() {
    local source="$1"

    if [[ ! -f "$ALERT_HISTORY" ]]; then
        echo -e "${YELLOW}No alert history found${NC}"
        return
    fi

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Alerts from: ${source}${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    grep "\"source\":\"${source}\"" "$ALERT_HISTORY" | while IFS= read -r line; do
        format_alert "$line"
    done
    echo ""
}

show_throttle_status() {
    local throttle_state="${HERMETIC_ROOT}/maintenance/alert-throttle-state.json"

    if [[ ! -f "$throttle_state" ]]; then
        echo -e "${YELLOW}No throttle state found${NC}"
        return
    fi

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Throttle Status${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    local now=$(date +%s)
    local hour_ago=$((now - 3600))

    local recent_count=$(jq "[.alerts[] | select(.timestamp > $hour_ago)] | length" "$throttle_state")
    local max_per_hour=$(jq -r '.throttling.maxAlertsPerHour // 10' "${HERMETIC_ROOT}/maintenance/alerts-config.json")

    echo -e "  Alerts in last hour: ${CYAN}${recent_count}${NC} / ${max_per_hour}"

    if [[ $recent_count -ge $max_per_hour ]]; then
        echo -e "  Status: ${RED}THROTTLING ACTIVE${NC}"
    else
        echo -e "  Status: ${GREEN}Normal${NC}"
    fi
    echo ""

    echo -e "${BLUE}Recent throttled messages:${NC}"
    jq -r ".alerts[] | select(.timestamp > $hour_ago) | \"\(.source) - \(.severity)\"" "$throttle_state" | head -5 || echo "  None"
    echo ""
}

search_alerts() {
    local query="$1"

    if [[ ! -f "$ALERT_HISTORY" ]]; then
        echo -e "${YELLOW}No alert history found${NC}"
        return
    fi

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Search results for: ${query}${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    grep -i "$query" "$ALERT_HISTORY" | while IFS= read -r line; do
        format_alert "$line"
    done
    echo ""
}

export_alerts() {
    local format="${1:-json}"
    local output_file="${2:-alerts-export-$(date +%Y%m%d-%H%M%S)}"

    if [[ ! -f "$ALERT_HISTORY" ]]; then
        echo -e "${YELLOW}No alert history found${NC}"
        return
    fi

    case "$format" in
        json)
            output_file="${output_file}.json"
            cat "$ALERT_HISTORY" > "$output_file"
            ;;
        csv)
            output_file="${output_file}.csv"
            echo "timestamp,severity,source,message" > "$output_file"
            jq -r '[.timestamp, .severity, .source, .message] | @csv' "$ALERT_HISTORY" >> "$output_file"
            ;;
        txt)
            output_file="${output_file}.txt"
            while IFS= read -r line; do
                format_alert "$line"
            done < "$ALERT_HISTORY" > "$output_file"
            ;;
        *)
            echo -e "${RED}Unknown format: $format${NC}"
            return 1
            ;;
    esac

    echo -e "${GREEN}✓ Exported to: ${output_file}${NC}"
}

# ============================================================================
# CLI INTERFACE
# ============================================================================

show_usage() {
    cat << EOF
View Alert History

Usage:
  bash view-alerts.sh COMMAND [OPTIONS]

Commands:
  stats              Show alert statistics
  recent [N]         Show N recent alerts (default: 20)
  severity LEVEL     Show alerts by severity (INFO/WARNING/CRITICAL)
  source NAME        Show alerts by source (backup/mcp/session/n8n/dashboard)
  throttle           Show throttling status
  search QUERY       Search alert messages
  export [FORMAT]    Export alerts (json/csv/txt, default: json)

Examples:
  bash view-alerts.sh stats
  bash view-alerts.sh recent 50
  bash view-alerts.sh severity CRITICAL
  bash view-alerts.sh source backup
  bash view-alerts.sh search "disk"
  bash view-alerts.sh export csv alerts-backup

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

    local command="$1"
    shift

    case "$command" in
        stats)
            show_statistics
            ;;
        recent)
            show_recent "${1:-20}"
            ;;
        severity)
            if [[ $# -eq 0 ]]; then
                echo -e "${RED}Error: Severity required${NC}"
                show_usage
                exit 1
            fi
            show_by_severity "$1"
            ;;
        source)
            if [[ $# -eq 0 ]]; then
                echo -e "${RED}Error: Source required${NC}"
                show_usage
                exit 1
            fi
            show_by_source "$1"
            ;;
        throttle)
            show_throttle_status
            ;;
        search)
            if [[ $# -eq 0 ]]; then
                echo -e "${RED}Error: Search query required${NC}"
                show_usage
                exit 1
            fi
            search_alerts "$1"
            ;;
        export)
            export_alerts "${1:-json}" "${2:-}"
            ;;
        *)
            echo -e "${RED}Unknown command: $command${NC}"
            show_usage
            exit 1
            ;;
    esac
}

main "$@"
