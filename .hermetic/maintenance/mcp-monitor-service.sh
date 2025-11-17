#!/usr/bin/env bash
# mcp-monitor-service.sh - MCP Background Monitoring Service
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
HEALTH_CHECK_SCRIPT="${HERMETIC_ROOT}/maintenance/mcp-health-check.sh"
PID_FILE="${HERMETIC_ROOT}/maintenance/mcp-monitor.pid"
LOG_FILE="${HERMETIC_ROOT}/maintenance/mcp-monitor.log"

# Convert Windows paths
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# Check interval (seconds)
CHECK_INTERVAL=${MCP_CHECK_INTERVAL:-300}  # Default: 5 minutes

# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] ${message}" >> "$LOG_FILE"
}

is_running() {
    if [[ -f "$PID_FILE" ]]; then
        local pid=$(cat "$PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            return 0
        fi
    fi
    return 1
}

start_service() {
    if is_running; then
        echo -e "${YELLOW}Service already running (PID: $(cat "$PID_FILE"))${NC}"
        return 1
    fi

    echo -e "${GREEN}Starting MCP Monitor Service...${NC}"
    echo "Check interval: ${CHECK_INTERVAL}s"

    # Run in background
    nohup bash "$0" --daemon >> "$LOG_FILE" 2>&1 &
    local pid=$!
    echo $pid > "$PID_FILE"

    sleep 1

    if is_running; then
        echo -e "${GREEN}✓ Service started (PID: $pid)${NC}"
        log "Service started (PID: $pid)"
        return 0
    else
        echo -e "${RED}✗ Failed to start service${NC}"
        return 1
    fi
}

stop_service() {
    if ! is_running; then
        echo -e "${YELLOW}Service not running${NC}"
        return 1
    fi

    local pid=$(cat "$PID_FILE")
    echo -e "${BLUE}Stopping MCP Monitor Service (PID: $pid)...${NC}"

    kill "$pid" 2>/dev/null || true
    sleep 2

    if is_running; then
        kill -9 "$pid" 2>/dev/null || true
        sleep 1
    fi

    rm -f "$PID_FILE"

    if is_running; then
        echo -e "${RED}✗ Failed to stop service${NC}"
        return 1
    else
        echo -e "${GREEN}✓ Service stopped${NC}"
        log "Service stopped"
        return 0
    fi
}

daemon_loop() {
    log "Daemon started, check interval: ${CHECK_INTERVAL}s"

    while true; do
        bash "$HEALTH_CHECK_SCRIPT" >> "$LOG_FILE" 2>&1 || log "Health check failed"
        sleep "$CHECK_INTERVAL"
    done
}

show_status() {
    if is_running; then
        local pid=$(cat "$PID_FILE")
        echo -e "${GREEN}Status: Running${NC}"
        echo "PID: $pid"
        echo "Check Interval: ${CHECK_INTERVAL}s"
        echo "Log File: $LOG_FILE"
    else
        echo -e "${YELLOW}Status: Stopped${NC}"
    fi
}

# ============================================================================
# MAIN
# ============================================================================

case "${1:-}" in
    --daemon)
        daemon_loop
        ;;
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    restart)
        stop_service
        sleep 1
        start_service
        ;;
    status)
        show_status
        ;;
    logs)
        tail -f "$LOG_FILE"
        ;;
    *)
        cat << EOF
MCP Monitor Service

Usage:
  bash mcp-monitor-service.sh start      Start service
  bash mcp-monitor-service.sh stop       Stop service
  bash mcp-monitor-service.sh restart    Restart service
  bash mcp-monitor-service.sh status     Show status
  bash mcp-monitor-service.sh logs       Follow logs

Environment:
  MCP_CHECK_INTERVAL   Check interval in seconds (default: 300)

EOF
        exit 1
        ;;
esac
