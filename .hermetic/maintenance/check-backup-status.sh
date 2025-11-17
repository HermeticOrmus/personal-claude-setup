#!/usr/bin/env bash
# check-backup-status.sh - Backup Status Monitor
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
STATUS_FILE="${HERMETIC_ROOT}/maintenance/backup-status.json"
HISTORY_FILE="${HERMETIC_ROOT}/maintenance/backup-history.jsonl"

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

show_current_status() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Backup System Status${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    if [[ ! -f "$STATUS_FILE" ]]; then
        echo -e "${YELLOW}No backup status found${NC}"
        echo "Run: bash automated-backup-wrapper.sh"
        return
    fi

    local status=$(jq -r '.status' "$STATUS_FILE")
    local message=$(jq -r '.message' "$STATUS_FILE")
    local last_run=$(jq -r '.lastRun' "$STATUS_FILE")
    local duration=$(jq -r '.duration // "N/A"' "$STATUS_FILE")
    local backup_file=$(jq -r '.backupFile // "N/A"' "$STATUS_FILE")

    # Format timestamp
    local last_run_formatted=$(date -d "$last_run" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "$last_run")

    # Status color
    local status_color="$NC"
    case "$status" in
        success) status_color="$GREEN" ;;
        running) status_color="$YELLOW" ;;
        error) status_color="$RED" ;;
    esac

    echo -e "  Status: ${status_color}${status}${NC}"
    echo -e "  Message: ${message}"
    echo -e "  Last Run: ${last_run_formatted}"
    echo -e "  Duration: ${duration}"
    if [[ "$backup_file" != "N/A" ]]; then
        echo -e "  Backup File: ${backup_file}"
    fi
    echo ""
}

show_history() {
    local count="${1:-10}"

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Backup History (last ${count})${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    if [[ ! -f "$HISTORY_FILE" ]]; then
        echo -e "${YELLOW}No backup history found${NC}"
        return
    fi

    tail -n "$count" "$HISTORY_FILE" | while IFS= read -r line; do
        local status=$(echo "$line" | jq -r '.status')
        local timestamp=$(echo "$line" | jq -r '.lastRun' | cut -d'T' -f1-2 | tr 'T' ' ')
        local duration=$(echo "$line" | jq -r '.duration // "N/A"')
        local message=$(echo "$line" | jq -r '.message')

        local status_color="$NC"
        case "$status" in
            success) status_color="$GREEN" ;;
            error) status_color="$RED" ;;
        esac

        echo -e "${status_color}[${status}]${NC} ${timestamp} (${duration}) - ${message}"
    done
    echo ""
}

show_statistics() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Backup Statistics${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    if [[ ! -f "$HISTORY_FILE" ]]; then
        echo -e "${YELLOW}No backup history found${NC}"
        return
    fi

    local total=$(wc -l < "$HISTORY_FILE")
    local successful=$(grep -c '"status":"success"' "$HISTORY_FILE" || echo 0)
    local failed=$(grep -c '"status":"error"' "$HISTORY_FILE" || echo 0)

    local success_rate=0
    if [[ $total -gt 0 ]]; then
        success_rate=$(( (successful * 100) / total ))
    fi

    echo -e "  Total Backups: ${CYAN}${total}${NC}"
    echo -e "  ${GREEN}Successful:${NC} ${successful}"
    echo -e "  ${RED}Failed:${NC} ${failed}"
    echo -e "  Success Rate: ${CYAN}${success_rate}%${NC}"
    echo ""

    # Average duration
    if command -v bc &> /dev/null; then
        local avg_duration=$(jq -r 'select(.status == "success") | .duration' "$HISTORY_FILE" | sed 's/s//' | awk '{sum+=$1; count++} END {if(count>0) print sum/count; else print 0}')
        echo -e "  Average Duration: ${CYAN}${avg_duration}s${NC}"
        echo ""
    fi
}

show_backup_files() {
    local backup_dir="${HOME}/hermetic-backups"

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Available Backup Files${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    if [[ ! -d "$backup_dir" ]]; then
        echo -e "${YELLOW}Backup directory not found: ${backup_dir}${NC}"
        return
    fi

    local backup_count=$(find "$backup_dir" -name "hermetic-backup-*.tar.gz" -type f 2>/dev/null | wc -l)

    if [[ $backup_count -eq 0 ]]; then
        echo -e "${YELLOW}No backup files found${NC}"
        return
    fi

    echo -e "  Location: ${backup_dir}"
    echo -e "  Total Files: ${CYAN}${backup_count}${NC}"
    echo ""

    find "$backup_dir" -name "hermetic-backup-*.tar.gz" -type f -printf "%T@ %p\n" 2>/dev/null | sort -rn | head -10 | while read timestamp filepath; do
        local filename=$(basename "$filepath")
        local filesize=$(du -h "$filepath" | cut -f1)
        local filedate=$(date -d "@${timestamp}" '+%Y-%m-%d %H:%M' 2>/dev/null || echo "N/A")

        echo -e "  ${GREEN}●${NC} ${filename} (${filesize}, ${filedate})"
    done
    echo ""
}

show_tips() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Backup Tips & Commands${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${CYAN}Run Manual Backup:${NC}"
    echo "  bash automated-backup-wrapper.sh"
    echo ""

    echo -e "${CYAN}View Detailed Status:${NC}"
    echo "  bash automated-backup-wrapper.sh --status"
    echo ""

    echo -e "${CYAN}Clean Old Backups:${NC}"
    echo "  bash automated-backup-wrapper.sh --cleanup"
    echo ""

    echo -e "${CYAN}Restore from Backup:${NC}"
    echo "  cd ~"
    echo "  tar -xzf ~/hermetic-backups/hermetic-backup-TIMESTAMP.tar.gz"
    echo ""

    echo -e "${CYAN}Setup Automated Schedule:${NC}"
    echo "  Run as Administrator:"
    echo "  powershell -File .hermetic/maintenance/setup-automated-backups.ps1"
    echo ""
}

# ============================================================================
# MAIN
# ============================================================================

show_usage() {
    cat << EOF
Check Backup Status

Usage:
  bash check-backup-status.sh [COMMAND]

Commands:
  status      Show current backup status (default)
  history     Show backup history
  stats       Show backup statistics
  files       List available backup files
  tips        Show backup tips and commands

Examples:
  bash check-backup-status.sh
  bash check-backup-status.sh history
  bash check-backup-status.sh stats

EOF
}

main() {
    local command="${1:-status}"

    case "$command" in
        status)
            show_current_status
            ;;
        history)
            show_history "${2:-10}"
            ;;
        stats)
            show_statistics
            ;;
        files)
            show_backup_files
            ;;
        tips)
            show_tips
            ;;
        --help|help)
            show_usage
            ;;
        *)
            echo -e "${RED}Unknown command: $command${NC}"
            show_usage
            exit 1
            ;;
    esac
}

main "$@"
