#!/usr/bin/env bash
# deploy-workflow.sh - Deploy n8n Workflow to Production

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
N8N_API_KEY="${N8N_API_KEY:-}"
N8N_BASE_URL="${N8N_BASE_URL:-http://localhost:5678}"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

GREEN='\033[0;32m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'

deploy_workflow() {
    local workflow_file="$1"

    echo -e "${BLUE}Deploying workflow: $(basename "$workflow_file")${NC}"

    if [[ ! -f "$workflow_file" ]]; then
        echo -e "${RED}File not found: $workflow_file${NC}"
        return 1
    fi

    local workflow=$(cat "$workflow_file")
    local id=$(echo "$workflow" | jq -r '.id')
    local name=$(echo "$workflow" | jq -r '.name')

    # Validate
    if ! echo "$workflow" | jq -e '.nodes' > /dev/null 2>&1; then
        echo -e "${RED}Invalid workflow structure${NC}"
        return 1
    fi

    # Backup current version
    local backup_dir="${HERMETIC_ROOT}/maintenance/n8n-backups"
    mkdir -p "$backup_dir"
    local timestamp=$(date +%Y%m%d-%H%M%S)
    cp "$workflow_file" "${backup_dir}/${name}-${timestamp}.json"

    # Deploy
    local response=$(curl -s -X PUT \
        -H "X-N8N-API-KEY: $N8N_API_KEY" \
        -H "Content-Type: application/json" \
        -d "$workflow" \
        "${N8N_BASE_URL}/api/v1/workflows/${id}")

    if echo "$response" | jq -e '.id' > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Deployed successfully${NC}"

        # Activate workflow
        curl -s -X POST \
            -H "X-N8N-API-KEY: $N8N_API_KEY" \
            "${N8N_BASE_URL}/api/v1/workflows/${id}/activate" > /dev/null

        echo -e "${GREEN}✓ Activated${NC}"
        return 0
    else
        echo -e "${RED}✗ Deployment failed${NC}"
        echo "$response" | jq '.'
        return 1
    fi
}

main() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: bash deploy-workflow.sh WORKFLOW_FILE"
        exit 1
    fi

    deploy_workflow "$1"
}

main "$@"
