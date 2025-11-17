#!/usr/bin/env bash
# mcp-status-dashboard.sh - MCP Status Dashboard
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
STATUS_DIR="${HERMETIC_ROOT}/maintenance/mcp-status"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Unicode symbols
HEALTHY="●"
DEGRADED="◐"
WARNING="◑"
DOWN="✗"
UNKNOWN="○"

draw_dashboard() {
    clear
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  MCP Server Status Dashboard${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    local servers=("filesystem" "memory" "github" "n8n" "telegram" "discord" "puppeteer" "fetch" "whatsapp")

    for server in "${servers[@]}"; do
        local status_file="${STATUS_DIR}/${server}.json"
        if [[ -f "$status_file" ]]; then
            local status=$(jq -r '.status' "$status_file")
            local response_time=$(jq -r '.responseTime // 0' "$status_file")
            local timestamp=$(jq -r '.timestamp' "$status_file" | cut -d'T' -f2 | cut -d'.' -f1)

            local symbol="$UNKNOWN"
            local color="$NC"
            case "$status" in
                healthy) symbol="$HEALTHY"; color="$GREEN" ;;
                degraded) symbol="$DEGRADED"; color="$YELLOW" ;;
                down) symbol="$DOWN"; color="$RED" ;;
            esac

            printf "  ${color}${symbol}${NC} %-12s ${color}%-10s${NC}  ${response_time}ms  (${timestamp})\n" "$server" "$status"
        else
            printf "  ${UNKNOWN} %-12s ${YELLOW}%-10s${NC}\n" "$server" "no data"
        fi
    done

    echo ""

    # Overall health
    if [[ -f "${STATUS_DIR}/overall.json" ]]; then
        local health_pct=$(jq -r '.healthPercentage' "${STATUS_DIR}/overall.json")
        local healthy_count=$(jq -r '.healthyCount' "${STATUS_DIR}/overall.json")
        local total_count=$(jq -r '.totalCount' "${STATUS_DIR}/overall.json")

        local health_color="$GREEN"
        [[ $health_pct -lt 80 ]] && health_color="$YELLOW"
        [[ $health_pct -lt 50 ]] && health_color="$RED"

        echo -e "  Overall Health: ${health_color}${health_pct}%${NC} (${healthy_count}/${total_count} healthy)"
    fi

    echo ""
    echo -e "${CYAN}Press Ctrl+C to exit | Auto-refresh: 5s${NC}"
}

# Main loop
if [[ "${1:-}" == "--once" ]]; then
    draw_dashboard
else
    while true; do
        draw_dashboard
        sleep 5
    done
fi
