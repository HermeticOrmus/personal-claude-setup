#!/usr/bin/env bash
# stop-automation.sh - Stop All Automation Services
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

stop_service() {
    local name="$1"
    local pid_file="$2"

    if [[ ! -f "$pid_file" ]]; then
        log WARNING "$name: Not running (no PID file)"
        return 0
    fi

    local pid=$(cat "$pid_file")

    if ! kill -0 "$pid" 2>/dev/null; then
        log WARNING "$name: Process not found (stale PID file)"
        rm -f "$pid_file"
        return 0
    fi

    log INFO "Stopping $name (PID: $pid)..."

    # Graceful shutdown
    kill "$pid" 2>/dev/null || true

    # Wait up to 10 seconds
    local waited=0
    while kill -0 "$pid" 2>/dev/null && [[ $waited -lt 10 ]]; do
        sleep 1
        ((waited++))
    done

    # Force kill if still running
    if kill -0 "$pid" 2>/dev/null; then
        log WARNING "$name: Forcing shutdown..."
        kill -9 "$pid" 2>/dev/null || true
        sleep 1
    fi

    # Verify stopped
    if kill -0 "$pid" 2>/dev/null; then
        log ERROR "✗ $name: Failed to stop"
        return 1
    else
        rm -f "$pid_file"
        log INFO "✓ $name stopped"
        return 0
    fi
}

cleanup_orphaned_processes() {
    log INFO "Checking for orphaned processes..."

    local maintenance_procs=$(pgrep -f "bash.*maintenance.*\\.sh" 2>/dev/null || true)

    if [[ -n "$maintenance_procs" ]]; then
        local count=$(echo "$maintenance_procs" | wc -l)
        log WARNING "Found ${count} orphaned process(es)"

        echo "$maintenance_procs" | while read pid; do
            local cmd=$(ps -p "$pid" -o cmd= 2>/dev/null || echo "unknown")
            log INFO "Killing orphaned process: $pid ($cmd)"
            kill "$pid" 2>/dev/null || true
        done

        sleep 2
    else
        log INFO "No orphaned processes found"
    fi
}

main() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Stopping Hermetic Automation Services${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    local stopped=0
    local failed=0

    # Stop MCP Monitor
    if stop_service "MCP Monitor" "${HERMETIC_ROOT}/maintenance/mcp-monitor.pid"; then
        ((stopped++))
    else
        ((failed++))
    fi

    # Stop n8n Sync
    if stop_service "n8n Sync" "${HERMETIC_ROOT}/maintenance/n8n-sync.pid"; then
        ((stopped++))
    else
        ((failed++))
    fi

    # Cleanup
    cleanup_orphaned_processes

    # Clean orphaned PID files
    find "${HERMETIC_ROOT}/maintenance" -name "*.pid" -type f -delete 2>/dev/null || true

    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"

    if [[ $failed -eq 0 ]]; then
        log INFO "All services stopped successfully (${stopped} stopped)"

        if [[ -x "$ALERT_SCRIPT" ]]; then
            bash "$ALERT_SCRIPT" "Automation services stopped: ${stopped} services" INFO dashboard
        fi
    else
        log WARNING "Stopped ${stopped} services, ${failed} failed"

        if [[ -x "$ALERT_SCRIPT" ]]; then
            bash "$ALERT_SCRIPT" "Automation shutdown: ${stopped} stopped, ${failed} failed" WARNING dashboard
        fi
    fi

    echo ""
}

main "$@"
