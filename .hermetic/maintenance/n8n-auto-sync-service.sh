#!/usr/bin/env bash
# n8n-auto-sync-service.sh - Continuous n8n Sync Service

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
SYNC_SCRIPT="${HERMETIC_ROOT}/maintenance/n8n-workflow-sync.sh"
PID_FILE="${HERMETIC_ROOT}/maintenance/n8n-sync.pid"
LOG_FILE="${HERMETIC_ROOT}/maintenance/n8n-sync.log"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

SYNC_INTERVAL=${N8N_SYNC_INTERVAL:-900}  # 15 minutes

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

is_running() {
    [[ -f "$PID_FILE" ]] && kill -0 $(cat "$PID_FILE") 2>/dev/null
}

start_service() {
    if is_running; then
        echo -e "${YELLOW}Service already running${NC}"
        return 1
    fi

    echo -e "${GREEN}Starting n8n sync service...${NC}"
    nohup bash "$0" --daemon >> "$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"
    echo -e "${GREEN}✓ Started (PID: $(cat "$PID_FILE"))${NC}"
}

stop_service() {
    if ! is_running; then
        echo -e "${YELLOW}Service not running${NC}"
        return 1
    fi

    local pid=$(cat "$PID_FILE")
    kill "$pid" 2>/dev/null || true
    sleep 2
    [[ -f "$PID_FILE" ]] && rm -f "$PID_FILE"
    echo -e "${GREEN}✓ Stopped${NC}"
}

daemon_loop() {
    while true; do
        bash "$SYNC_SCRIPT" both >> "$LOG_FILE" 2>&1 || true
        sleep "$SYNC_INTERVAL"
    done
}

case "${1:-}" in
    --daemon) daemon_loop ;;
    start) start_service ;;
    stop) stop_service ;;
    restart) stop_service; sleep 1; start_service ;;
    status) is_running && echo "Running" || echo "Stopped" ;;
    sync) bash "$SYNC_SCRIPT" both ;;
    logs) tail -f "$LOG_FILE" ;;
    *)
        echo "Usage: bash n8n-auto-sync-service.sh {start|stop|restart|status|sync|logs}"
        exit 1
        ;;
esac
