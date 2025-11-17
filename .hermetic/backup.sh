#!/usr/bin/env bash
# backup.sh - Core Hermetic Backup Script
# Creates compressed archives of .hermetic directory

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
BACKUP_DIR="${HOME}/hermetic-backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="hermetic-backup-${TIMESTAMP}.tar.gz"

# Convert Windows paths if needed
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
    BACKUP_DIR=$(cygpath -u "$BACKUP_DIR" 2>/dev/null || echo "$BACKUP_DIR")
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "Starting backup..."
echo "Source: $HERMETIC_ROOT"
echo "Destination: $BACKUP_DIR/$BACKUP_FILE"

# Create archive
cd "$(dirname "$HERMETIC_ROOT")"
tar -czf "${BACKUP_DIR}/${BACKUP_FILE}" \
    --exclude='.hermetic/maintenance/*.log' \
    --exclude='.hermetic/maintenance/*.pid' \
    --exclude='.hermetic/maintenance/mcp-status' \
    --exclude='.hermetic/archives' \
    "$(basename "$HERMETIC_ROOT")"

if [[ -f "${BACKUP_DIR}/${BACKUP_FILE}" ]]; then
    size=$(du -h "${BACKUP_DIR}/${BACKUP_FILE}" | cut -f1)
    echo "✓ Backup complete: ${BACKUP_FILE} (${size})"
    echo "hermetic-backup-${TIMESTAMP}.tar.gz"
    exit 0
else
    echo "✗ Backup failed"
    exit 1
fi
