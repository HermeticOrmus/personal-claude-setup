#!/usr/bin/env bash
# n8n-workflow-sync.sh - Bidirectional n8n Workflow Synchronization
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
WORKFLOWS_DIR="${HERMETIC_ROOT}/n8n-workflows"
SYNC_STATE="${HERMETIC_ROOT}/maintenance/n8n-sync-state.json"
ALERT_SCRIPT="${HERMETIC_ROOT}/maintenance/hermetic-alerts.sh"

N8N_API_KEY="${N8N_API_KEY:-}"
N8N_BASE_URL="${N8N_BASE_URL:-http://localhost:5678}"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

mkdir -p "$WORKFLOWS_DIR"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'

log() {
    local level="$1"; shift
    echo -e "[${level}] $@"
}

check_n8n_connection() {
    if [[ -z "$N8N_API_KEY" ]]; then
        log ERROR "N8N_API_KEY not set"
        return 1
    fi

    if ! curl -s -f -H "X-N8N-API-KEY: $N8N_API_KEY" "${N8N_BASE_URL}/api/v1/workflows" > /dev/null 2>&1; then
        log ERROR "Cannot connect to n8n at $N8N_BASE_URL"
        return 1
    fi

    return 0
}

calculate_checksum() {
    local file="$1"
    sha256sum "$file" | cut -d' ' -f1
}

sync_from_n8n() {
    log INFO "Syncing workflows from n8n..."

    local workflows=$(curl -s -H "X-N8N-API-KEY: $N8N_API_KEY" "${N8N_BASE_URL}/api/v1/workflows")
    local count=$(echo "$workflows" | jq '.data | length')

    log INFO "Found $count workflows in n8n"

    echo "$workflows" | jq -c '.data[]' | while read -r workflow; do
        local id=$(echo "$workflow" | jq -r '.id')
        local name=$(echo "$workflow" | jq -r '.name')
        local safe_name=$(echo "$name" | tr ' ' '-' | tr -cd '[:alnum:]-_')

        local workflow_file="${WORKFLOWS_DIR}/${safe_name}_${id}.json"

        echo "$workflow" | jq '.' > "$workflow_file"
        log INFO "  ✓ Synced: $name"
    done

    log INFO "Sync from n8n complete"
}

sync_to_n8n() {
    log INFO "Syncing workflows to n8n..."

    local updated=0

    for workflow_file in "${WORKFLOWS_DIR}"/*.json; do
        [[ -f "$workflow_file" ]] || continue

        local workflow=$(cat "$workflow_file")
        local id=$(echo "$workflow" | jq -r '.id')
        local name=$(echo "$workflow" | jq -r '.name')

        # Update existing workflow
        local response=$(curl -s -X PUT \
            -H "X-N8N-API-KEY: $N8N_API_KEY" \
            -H "Content-Type: application/json" \
            -d "$workflow" \
            "${N8N_BASE_URL}/api/v1/workflows/${id}" 2>&1)

        if echo "$response" | jq -e '.id' > /dev/null 2>&1; then
            log INFO "  ✓ Updated: $name"
            ((updated++))
        else
            log WARNING "  ✗ Failed to update: $name"
        fi
    done

    log INFO "Updated $updated workflows in n8n"
}

main() {
    if ! check_n8n_connection; then
        log ERROR "n8n connection failed"
        exit 1
    fi

    case "${1:-both}" in
        pull) sync_from_n8n ;;
        push) sync_to_n8n ;;
        both)
            sync_from_n8n
            sync_to_n8n
            ;;
        *)
            echo "Usage: bash n8n-workflow-sync.sh [pull|push|both]"
            exit 1
            ;;
    esac

    if [[ -x "$ALERT_SCRIPT" ]]; then
        bash "$ALERT_SCRIPT" "n8n workflow sync complete" INFO n8n
    fi
}

main "$@"
