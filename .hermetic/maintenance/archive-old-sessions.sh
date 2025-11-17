#!/usr/bin/env bash
# archive-old-sessions.sh - Archive Old Claude Sessions
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
SESSIONS_DIR="${HOME}/.claude/sessions"
ARCHIVE_BASE="${HERMETIC_ROOT}/archives/sessions"
CONFIG_FILE="${HERMETIC_ROOT}/maintenance/session-archival-config.json"
ALERT_SCRIPT="${HERMETIC_ROOT}/maintenance/hermetic-alerts.sh"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
    SESSIONS_DIR=$(cygpath -u "$SESSIONS_DIR" 2>/dev/null || echo "$SESSIONS_DIR")
fi

mkdir -p "$ARCHIVE_BASE"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

RETENTION_DAYS=${SESSION_RETENTION_DAYS:-30}

log() {
    local level="$1"; shift
    local message="$@"
    case "$level" in
        INFO) echo -e "${GREEN}[INFO]${NC} ${message}" ;;
        WARNING) echo -e "${YELLOW}[WARNING]${NC} ${message}" ;;
        ERROR) echo -e "${RED}[ERROR]${NC} ${message}" ;;
    esac
}

get_session_age_days() {
    local session_dir="$1"
    local session_mtime=$(stat -c %Y "$session_dir" 2>/dev/null || stat -f %m "$session_dir" 2>/dev/null || echo 0)
    local now=$(date +%s)
    echo $(( (now - session_mtime) / 86400 ))
}

archive_session() {
    local session_dir="$1"
    local session_name=$(basename "$session_dir")
    local year=$(date +%Y)
    local month=$(date +%m)

    local archive_dir="${ARCHIVE_BASE}/${year}/${month}"
    mkdir -p "$archive_dir"

    local archive_file="${archive_dir}/${session_name}.tar.gz"

    log INFO "Archiving: $session_name"

    if tar -czf "$archive_file" -C "$(dirname "$session_dir")" "$session_name" 2>/dev/null; then
        rm -rf "$session_dir"
        log INFO "✓ Archived to: $archive_file"
        echo "$archive_file"
        return 0
    else
        log ERROR "Failed to archive: $session_name"
        return 1
    fi
}

update_archive_index() {
    local index_file="${ARCHIVE_BASE}/index.json"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

    local archives=()
    while IFS= read -r -d '' archive; do
        local name=$(basename "$archive" .tar.gz)
        local size=$(du -h "$archive" | cut -f1)
        local date=$(stat -c %y "$archive" 2>/dev/null || stat -f %Sm -t "%Y-%m-%d %H:%M:%S" "$archive" 2>/dev/null)

        archives+=("{\"name\":\"$name\",\"path\":\"$archive\",\"size\":\"$size\",\"date\":\"$date\"}")
    done < <(find "$ARCHIVE_BASE" -name "*.tar.gz" -type f -print0 2>/dev/null)

    local archives_json=$(printf '%s\n' "${archives[@]}" | jq -s '.')

    jq -n \
        --arg ts "$timestamp" \
        --argjson archives "$archives_json" \
        '{lastUpdated: $ts, archives: $archives}' > "$index_file"
}

main() {
    log INFO "Starting session archival (retention: ${RETENTION_DAYS} days)..."

    if [[ ! -d "$SESSIONS_DIR" ]]; then
        log WARNING "Sessions directory not found: $SESSIONS_DIR"
        exit 0
    fi

    local archived_count=0
    local failed_count=0

    while IFS= read -r -d '' session_dir; do
        local age=$(get_session_age_days "$session_dir")

        if [[ $age -gt $RETENTION_DAYS ]]; then
            if archive_session "$session_dir"; then
                ((archived_count++))
            else
                ((failed_count++))
            fi
        fi
    done < <(find "$SESSIONS_DIR" -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null)

    update_archive_index

    log INFO "Complete: ${archived_count} archived, ${failed_count} failed"

    if [[ -x "$ALERT_SCRIPT" ]]; then
        bash "$ALERT_SCRIPT" "Session archival: ${archived_count} sessions archived" INFO session
    fi
}

main "$@"
