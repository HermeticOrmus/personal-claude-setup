#!/usr/bin/env bash
# start-automation.sh - Start All Automation Services
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
ALERT_SCRIPT="${HERMETIC_ROOT}/maintenance/hermetic-alerts.sh"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'

log() {
    local level="$1"; shift
    case "$level" in
        INFO) echo -e "${GREEN}[INFO]${NC} $@" ;;
        WARNING) echo -e "${YELLOW}[WARNING]${NC} $@" ;;
        ERROR) echo -e "${RED}[ERROR]${NC} $@" ;;
    esac
}

start_service() {
    local name="$1"
    local script="$2"

    if [[ ! -f "$script" ]]; then
        log WARNING "$name: Script not found - $script"
        return 1
    fi

    log INFO "Starting $name..."

    if bash "$script" start 2>&1 | grep -q "already running"; then
        log WARNING "$name: Already running"
        return 0
    fi

    if bash "$script" start > /dev/null 2>&1; then
        log INFO "✓ $name started"
        return 0
    else
        log ERROR "✗ $name failed to start"
        return 1
    fi
}

main() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Starting Hermetic Automation Services${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    local started=0
    local failed=0

    # Start MCP Monitor
    if start_service "MCP Monitor" "${HERMETIC_ROOT}/maintenance/mcp-monitor-service.sh"; then
        ((started++))
    else
        ((failed++))
    fi

    # Start n8n Sync
    if [[ -n "${N8N_API_KEY:-}" ]]; then
        if start_service "n8n Sync" "${HERMETIC_ROOT}/maintenance/n8n-auto-sync-service.sh"; then
            ((started++))
        else
            ((failed++))
        fi
    else
        log WARNING "n8n Sync: Skipped (N8N_API_KEY not set)"
    fi

    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"

    if [[ $failed -eq 0 ]]; then
        log INFO "All services started successfully (${started} running)"

        if [[ -x "$ALERT_SCRIPT" ]]; then
            bash "$ALERT_SCRIPT" "Automation services started: ${started} running" INFO dashboard
        fi
    else
        log WARNING "Started ${started} services, ${failed} failed"

        if [[ -x "$ALERT_SCRIPT" ]]; then
            bash "$ALERT_SCRIPT" "Automation startup: ${started} started, ${failed} failed" WARNING dashboard
        fi
    fi

    echo ""
    log INFO "View status: bash automation-dashboard.sh"
    echo ""
}

main "$@"
