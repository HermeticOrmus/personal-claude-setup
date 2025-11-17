#!/usr/bin/env bash
# automated-backup-wrapper.sh - Automated Backup System
# Part of the Hermetic Automation Infrastructure
#
# Sacred Purpose: Preserve wisdom through time
# Hermetic Principle: Rhythm - "Regular cycles protect against entropy"

set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================

HERMETIC_ROOT="${HOME}/.hermetic"
BACKUP_SCRIPT="${HERMETIC_ROOT}/backup.sh"
STATUS_FILE="${HERMETIC_ROOT}/maintenance/backup-status.json"
LOG_FILE="${HERMETIC_ROOT}/maintenance/backup.log"
ALERT_SCRIPT="${HERMETIC_ROOT}/maintenance/hermetic-alerts.sh"

# Convert Windows paths if running in Git Bash
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# Ensure directories exist
mkdir -p "${HERMETIC_ROOT}/maintenance"

# Backup retention (days)
RETENTION_DAYS=30

# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================================
# LOGGING
# ============================================================================

log() {
    local level="$1"
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[${timestamp}] [${level}] ${message}" >> "$LOG_FILE"

    case "$level" in
        INFO)    echo -e "${GREEN}[INFO]${NC} ${message}" ;;
        WARNING) echo -e "${YELLOW}[WARNING]${NC} ${message}" ;;
        ERROR)   echo -e "${RED}[ERROR]${NC} ${message}" ;;
        *)       echo "${message}" ;;
    esac
}

# ============================================================================
# STATUS TRACKING
# ============================================================================

update_status() {
    local status="$1"
    local message="$2"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

    local status_json=$(jq -n \
        --arg status "$status" \
        --arg msg "$message" \
        --arg ts "$timestamp" \
        '{
            status: $status,
            lastRun: $ts,
            message: $msg,
            timestamp: $ts
        }')

    echo "$status_json" > "$STATUS_FILE"
}

finalize_status() {
    local status="$1"
    local message="$2"
    local duration="$3"
    local backup_file="${4:-}"

    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

    local status_json=$(jq -n \
        --arg status "$status" \
        --arg msg "$message" \
        --arg ts "$timestamp" \
        --arg dur "$duration" \
        --arg file "$backup_file" \
        '{
            status: $status,
            lastRun: $ts,
            message: $msg,
            duration: $dur,
            backupFile: $file,
            timestamp: $ts
        }')

    echo "$status_json" > "$STATUS_FILE"

    # Also update history
    local history_file="${HERMETIC_ROOT}/maintenance/backup-history.jsonl"
    echo "$status_json" >> "$history_file"
}

# ============================================================================
# ALERT SYSTEM INTEGRATION
# ============================================================================

send_alert() {
    local message="$1"
    local severity="${2:-INFO}"

    if [[ -x "$ALERT_SCRIPT" ]]; then
        bash "$ALERT_SCRIPT" "$message" "$severity" "backup"
    else
        log WARNING "Alert script not found or not executable: $ALERT_SCRIPT"
    fi
}

# ============================================================================
# BACKUP EXECUTION
# ============================================================================

perform_backup() {
    log INFO "Starting backup process..."
    update_status "running" "Backup in progress..."

    local start_time=$(date +%s)

    if [[ ! -f "$BACKUP_SCRIPT" ]]; then
        local error_msg="Backup script not found: $BACKUP_SCRIPT"
        log ERROR "$error_msg"
        finalize_status "error" "$error_msg" "0s" ""
        send_alert "Backup failed: Script not found" "CRITICAL"
        return 1
    fi

    # Run backup script and capture output
    local backup_output
    local backup_exit_code=0

    backup_output=$(bash "$BACKUP_SCRIPT" 2>&1) || backup_exit_code=$?

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local duration_formatted="${duration}s"

    if [[ $backup_exit_code -eq 0 ]]; then
        # Extract backup filename from output
        local backup_file=$(echo "$backup_output" | grep -o 'hermetic-backup-[0-9]*\.tar\.gz' | head -1)

        log INFO "Backup completed successfully in ${duration_formatted}"
        log INFO "Backup file: ${backup_file}"

        finalize_status "success" "Backup completed successfully" "$duration_formatted" "$backup_file"
        send_alert "Backup completed successfully in ${duration_formatted}" "INFO"

        # Cleanup old backups
        cleanup_old_backups
    else
        log ERROR "Backup failed with exit code: ${backup_exit_code}"
        log ERROR "Output: ${backup_output}"

        finalize_status "error" "Backup failed: exit code ${backup_exit_code}" "$duration_formatted" ""
        send_alert "Backup failed with exit code ${backup_exit_code}" "CRITICAL"
        return 1
    fi
}

# ============================================================================
# CLEANUP
# ============================================================================

cleanup_old_backups() {
    log INFO "Checking for old backups to remove (retention: ${RETENTION_DAYS} days)..."

    local backup_dir="${HOME}/hermetic-backups"

    if [[ ! -d "$backup_dir" ]]; then
        log WARNING "Backup directory not found: $backup_dir"
        return
    fi

    # Find and remove backups older than retention period
    local removed_count=0
    while IFS= read -r -d '' backup_file; do
        rm -f "$backup_file"
        log INFO "Removed old backup: $(basename "$backup_file")"
        ((removed_count++))
    done < <(find "$backup_dir" -name "hermetic-backup-*.tar.gz" -type f -mtime +${RETENTION_DAYS} -print0 2>/dev/null)

    if [[ $removed_count -gt 0 ]]; then
        log INFO "Cleaned up ${removed_count} old backup(s)"
    else
        log INFO "No old backups to remove"
    fi
}

# ============================================================================
# PRE-FLIGHT CHECKS
# ============================================================================

check_disk_space() {
    log INFO "Checking disk space..."

    local available_space
    if [[ "$OSTYPE" == "darwin"* ]]; then
        available_space=$(df -h "${HOME}" | awk 'NR==2 {print $4}')
    else
        available_space=$(df -h "${HOME}" | awk 'NR==2 {print $4}')
    fi

    log INFO "Available disk space: ${available_space}"

    # TODO: Add threshold checking if needed
}

check_dependencies() {
    log INFO "Checking dependencies..."

    local missing_deps=()

    command -v tar &> /dev/null || missing_deps+=("tar")
    command -v gzip &> /dev/null || missing_deps+=("gzip")
    command -v jq &> /dev/null || missing_deps+=("jq")

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log ERROR "Missing dependencies: ${missing_deps[*]}"
        return 1
    fi

    log INFO "All dependencies present"
    return 0
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    log INFO "═══════════════════════════════════════════════════"
    log INFO "  Hermetic Automated Backup System"
    log INFO "═══════════════════════════════════════════════════"

    # Pre-flight checks
    if ! check_dependencies; then
        update_status "error" "Missing dependencies"
        send_alert "Backup failed: Missing dependencies" "CRITICAL"
        exit 1
    fi

    check_disk_space

    # Perform backup
    if perform_backup; then
        log INFO "Backup process completed successfully"
        exit 0
    else
        log ERROR "Backup process failed"
        exit 1
    fi
}

# Handle script arguments
if [[ $# -gt 0 ]]; then
    case "$1" in
        --status)
            if [[ -f "$STATUS_FILE" ]]; then
                cat "$STATUS_FILE" | jq '.'
            else
                echo '{"status": "never_run", "message": "No backup has been performed yet"}'
            fi
            exit 0
            ;;
        --cleanup)
            cleanup_old_backups
            exit 0
            ;;
        --help)
            cat << EOF
Automated Backup Wrapper

Usage:
  bash automated-backup-wrapper.sh          Run backup
  bash automated-backup-wrapper.sh --status Show current status
  bash automated-backup-wrapper.sh --cleanup Clean old backups
  bash automated-backup-wrapper.sh --help   Show this help

Configuration:
  Retention: ${RETENTION_DAYS} days
  Log file: ${LOG_FILE}
  Status file: ${STATUS_FILE}

EOF
            exit 0
            ;;
        *)
            log ERROR "Unknown argument: $1"
            exit 1
            ;;
    esac
fi

main
