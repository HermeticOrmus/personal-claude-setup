#!/usr/bin/env bash
# automation-dashboard.sh - Real-Time Automation Monitoring Dashboard
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# Colors
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; MAGENTA='\033[0;35m'; NC='\033[0m'

check_backup_system() {
    local status_file="${HERMETIC_ROOT}/maintenance/backup-status.json"
    if [[ -f "$status_file" ]]; then
        local status=$(jq -r '.status' "$status_file" 2>/dev/null || echo "unknown")
        case "$status" in
            success) echo "20,healthy,Backup system operational" ;;
            running) echo "15,running,Backup in progress" ;;
            error) echo "0,error,Backup failed" ;;
            *) echo "10,unknown,No recent backup" ;;
        esac
    else
        echo "0,unknown,No backup status"
    fi
}

check_mcp_monitoring() {
    local overall="${HERMETIC_ROOT}/maintenance/mcp-status/overall.json"
    if [[ -f "$overall" ]]; then
        local health_pct=$(jq -r '.healthPercentage' "$overall" 2>/dev/null || echo 0)
        local health_score=$(( health_pct * 20 / 100 ))

        if [[ $health_pct -ge 80 ]]; then
            echo "${health_score},healthy,${health_pct}% healthy"
        elif [[ $health_pct -ge 50 ]]; then
            echo "${health_score},degraded,${health_pct}% healthy"
        else
            echo "${health_score},error,${health_pct}% healthy"
        fi
    else
        echo "0,unknown,No MCP status"
    fi
}

check_session_archival() {
    local index="${HERMETIC_ROOT}/archives/sessions/index.json"
    if [[ -f "$index" ]]; then
        local last_updated=$(jq -r '.lastUpdated' "$index" 2>/dev/null || echo "")
        if [[ -n "$last_updated" ]]; then
            echo "15,healthy,Archival active"
        else
            echo "10,unknown,Status unclear"
        fi
    else
        echo "5,unknown,Not yet run"
    fi
}

check_n8n_sync() {
    if [[ -n "${N8N_API_KEY:-}" ]]; then
        local workflows_dir="${HERMETIC_ROOT}/n8n-workflows"
        if [[ -d "$workflows_dir" ]]; then
            local count=$(find "$workflows_dir" -name "*.json" -type f 2>/dev/null | wc -l)
            echo "15,healthy,${count} workflows"
        else
            echo "10,unknown,Not synced yet"
        fi
    else
        echo "0,disabled,N8N_API_KEY not set"
    fi
}

check_alert_system() {
    local config="${HERMETIC_ROOT}/maintenance/alerts-config.json"
    local history="${HERMETIC_ROOT}/maintenance/alert-history.jsonl"

    if [[ -f "$config" ]] && [[ -f "$history" ]]; then
        local recent_count=$(tail -10 "$history" 2>/dev/null | wc -l || echo 0)
        echo "15,healthy,${recent_count} recent alerts"
    else
        echo "10,unknown,Not configured"
    fi
}

check_disk_space() {
    local available
    if [[ "$OSTYPE" == "darwin"* ]]; then
        available=$(df -h "$HOME" | awk 'NR==2 {print $4}' | sed 's/Gi//')
    else
        available=$(df -h "$HOME" | awk 'NR==2 {print $4}' | sed 's/G//')
    fi

    local avail_num=$(echo "$available" | sed 's/[^0-9.]//g')

    if (( $(echo "$avail_num > 20" | bc -l 2>/dev/null || echo 1) )); then
        echo "15,healthy,${available}GB free"
    elif (( $(echo "$avail_num > 10" | bc -l 2>/dev/null || echo 1) )); then
        echo "10,warning,${available}GB free"
    else
        echo "0,critical,${available}GB free"
    fi
}

calculate_health() {
    local backup=$(check_backup_system | cut -d',' -f1)
    local mcp=$(check_mcp_monitoring | cut -d',' -f1)
    local session=$(check_session_archival | cut -d',' -f1)
    local n8n=$(check_n8n_sync | cut -d',' -f1)
    local alerts=$(check_alert_system | cut -d',' -f1)
    local disk=$(check_disk_space | cut -d',' -f1)

    echo $(( backup + mcp + session + n8n + alerts + disk ))
}

draw_health_bar() {
    local health="$1"
    local bar_length=40
    local filled=$(( health * bar_length / 100 ))

    local color="$RED"
    [[ $health -ge 60 ]] && color="$YELLOW"
    [[ $health -ge 80 ]] && color="$GREEN"

    printf "${color}"
    for ((i=0; i<filled; i++)); do printf "█"; done
    printf "${NC}"
    for ((i=filled; i<bar_length; i++)); do printf "░"; done
}

draw_dashboard() {
    clear
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Hermetic Automation Dashboard${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    # System Health
    local health=$(calculate_health)
    echo -e "${CYAN}Overall System Health${NC}"
    printf "  "
    draw_health_bar "$health"
    printf " ${CYAN}${health}%%${NC}\n"
    echo ""

    # Component Status
    echo -e "${CYAN}Component Status${NC}"

    local backup_info=$(check_backup_system)
    local backup_score=$(echo "$backup_info" | cut -d',' -f1)
    local backup_status=$(echo "$backup_info" | cut -d',' -f2)
    local backup_msg=$(echo "$backup_info" | cut -d',' -f3)

    local color="$GREEN"
    [[ "$backup_status" == "error" ]] && color="$RED"
    [[ "$backup_status" == "unknown" ]] && color="$YELLOW"

    echo -e "  ${color}●${NC} Backup System         ${backup_msg}"

    local mcp_info=$(check_mcp_monitoring)
    local mcp_status=$(echo "$mcp_info" | cut -d',' -f2)
    local mcp_msg=$(echo "$mcp_info" | cut -d',' -f3)

    color="$GREEN"
    [[ "$mcp_status" == "degraded" ]] && color="$YELLOW"
    [[ "$mcp_status" == "error" ]] && color="$RED"

    echo -e "  ${color}●${NC} MCP Monitoring        ${mcp_msg}"

    local session_info=$(check_session_archival)
    local session_msg=$(echo "$session_info" | cut -d',' -f3)
    echo -e "  ${GREEN}●${NC} Session Archival      ${session_msg}"

    local n8n_info=$(check_n8n_sync)
    local n8n_status=$(echo "$n8n_info" | cut -d',' -f2)
    local n8n_msg=$(echo "$n8n_info" | cut -d',' -f3)

    color="$GREEN"
    [[ "$n8n_status" == "disabled" ]] && color="$YELLOW"

    echo -e "  ${color}●${NC} n8n Workflow Sync     ${n8n_msg}"

    local alert_info=$(check_alert_system)
    local alert_msg=$(echo "$alert_info" | cut -d',' -f3)
    echo -e "  ${GREEN}●${NC} Alert System          ${alert_msg}"

    local disk_info=$(check_disk_space)
    local disk_status=$(echo "$disk_info" | cut -d',' -f2)
    local disk_msg=$(echo "$disk_info" | cut -d',' -f3)

    color="$GREEN"
    [[ "$disk_status" == "warning" ]] && color="$YELLOW"
    [[ "$disk_status" == "critical" ]] && color="$RED"

    echo -e "  ${color}●${NC} Disk Space            ${disk_msg}"

    echo ""
    echo -e "${CYAN}Quick Actions${NC}"
    echo "  [1] View backup status        [2] View MCP status"
    echo "  [3] View alert history        [4] Test alerts"
    echo "  [5] Restart services          [6] View system resources"
    echo "  [q] Quit"
    echo ""
    echo -e "${CYAN}Auto-refresh: 30s | $(date '+%Y-%m-%d %H:%M:%S')${NC}"
}

interactive_mode() {
    while true; do
        draw_dashboard
        read -t 30 -n 1 choice 2>/dev/null || continue

        case "$choice" in
            1) bash "${HERMETIC_ROOT}/maintenance/check-backup-status.sh" status; read -p "Press Enter..." ;;
            2) bash "${HERMETIC_ROOT}/maintenance/mcp-status-dashboard.sh" --once; read -p "Press Enter..." ;;
            3) bash "${HERMETIC_ROOT}/maintenance/view-alerts.sh" recent 20; read -p "Press Enter..." ;;
            4) bash "${HERMETIC_ROOT}/maintenance/test-alerts.sh" basic; read -p "Press Enter..." ;;
            5) bash "${HERMETIC_ROOT}/maintenance/stop-automation.sh"; bash "${HERMETIC_ROOT}/maintenance/start-automation.sh"; read -p "Press Enter..." ;;
            6) echo ""; df -h; echo ""; ps aux | grep -E "bash.*maintenance" | grep -v grep; read -p "Press Enter..." ;;
            q|Q) exit 0 ;;
        esac
    done
}

case "${1:-}" in
    --once) draw_dashboard ;;
    *) interactive_mode ;;
esac
