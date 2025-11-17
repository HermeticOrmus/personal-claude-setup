#!/bin/bash
# Hermetic Backup and Restore System
# Safely backup and restore your Hermetic configuration and data

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
BACKUP_DIR="${HERMETIC_BACKUP_DIR:-$HOME/.hermetic-backups}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Create backup
create_backup() {
    local backup_name="${1:-backup-$(date +%Y%m%d-%H%M%S)}"
    local backup_path="$BACKUP_DIR/$backup_name"

    echo -e "${BLUE}📦 Creating Hermetic backup: $backup_name${NC}"
    echo ""

    # Create backup directory
    mkdir -p "$backup_path"

    # Backup critical directories
    echo "  Backing up analytics..."
    cp -r "$HERMETIC_HOME/analytics" "$backup_path/" 2>/dev/null || mkdir -p "$backup_path/analytics"

    echo "  Backing up health data..."
    cp -r "$HERMETIC_HOME/health" "$backup_path/" 2>/dev/null || mkdir -p "$backup_path/health"

    echo "  Backing up intelligence data..."
    cp -r "$HERMETIC_HOME/intelligence" "$backup_path/" 2>/dev/null || mkdir -p "$backup_path/intelligence"

    echo "  Backing up community contributions..."
    cp -r "$HERMETIC_HOME/community" "$backup_path/" 2>/dev/null || mkdir -p "$backup_path/community"

    echo "  Backing up plugins..."
    cp -r "$HERMETIC_HOME/plugins" "$backup_path/" 2>/dev/null || mkdir -p "$backup_path/plugins"

    echo "  Backing up configuration..."
    [ -f "$HERMETIC_HOME/.hermeticrc" ] && cp "$HERMETIC_HOME/.hermeticrc" "$backup_path/"

    # Create manifest
    cat > "$backup_path/MANIFEST.txt" <<EOF
Hermetic Backup Manifest
========================

Backup Name: $backup_name
Created: $(date '+%Y-%m-%d %H:%M:%S')
System Version: 2.0.0

Contents:
$(du -sh "$backup_path"/* | awk '{print "  " $2 ": " $1}')

Total Size: $(du -sh "$backup_path" | awk '{print $1}')

Restore with:
  $0 restore $backup_name
EOF

    echo ""
    echo -e "${GREEN}✅ Backup created successfully!${NC}"
    echo "   Location: $backup_path"
    echo "   Size: $(du -sh "$backup_path" | awk '{print $1}')"
    echo ""
    echo "View manifest:"
    echo "  cat $backup_path/MANIFEST.txt"
}

# List backups
list_backups() {
    echo -e "${BLUE}📚 Available Hermetic Backups${NC}"
    echo ""

    if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        echo "  No backups found."
        echo ""
        echo "Create backup:"
        echo "  $0 create [name]"
        return
    fi

    # List all backups with details
    for backup in "$BACKUP_DIR"/*/; do
        backup_name=$(basename "$backup")
        if [ -f "$backup/MANIFEST.txt" ]; then
            created=$(grep "Created:" "$backup/MANIFEST.txt" | cut -d: -f2- | xargs)
            size=$(du -sh "$backup" | awk '{print $1}')
            echo -e "  ${GREEN}●${NC} $backup_name"
            echo "    Created: $created"
            echo "    Size: $size"
            echo ""
        fi
    done

    echo "Restore backup:"
    echo "  $0 restore <backup-name>"
}

# Restore backup
restore_backup() {
    local backup_name="$1"
    local backup_path="$BACKUP_DIR/$backup_name"

    if [ -z "$backup_name" ]; then
        echo -e "${RED}❌ Please specify backup name${NC}"
        echo ""
        list_backups
        return 1
    fi

    if [ ! -d "$backup_path" ]; then
        echo -e "${RED}❌ Backup not found: $backup_name${NC}"
        return 1
    fi

    echo -e "${YELLOW}⚠️  WARNING: This will overwrite current data!${NC}"
    echo ""
    echo "Backup to restore:"
    echo "  Name: $backup_name"
    echo "  Path: $backup_path"
    if [ -f "$backup_path/MANIFEST.txt" ]; then
        grep "Created:" "$backup_path/MANIFEST.txt"
        grep "Total Size:" "$backup_path/MANIFEST.txt"
    fi
    echo ""
    read -p "Continue with restore? (yes/no) " -r
    echo
    if [[ ! $REPLY =~ ^yes$ ]]; then
        echo "Restore cancelled."
        return 0
    fi

    echo -e "${BLUE}📦 Restoring from backup: $backup_name${NC}"
    echo ""

    # Create current backup before restoring
    echo "  Creating safety backup of current state..."
    create_backup "pre-restore-$(date +%Y%m%d-%H%M%S)" > /dev/null 2>&1

    # Restore directories
    echo "  Restoring analytics..."
    rm -rf "$HERMETIC_HOME/analytics"
    cp -r "$backup_path/analytics" "$HERMETIC_HOME/" 2>/dev/null

    echo "  Restoring health data..."
    rm -rf "$HERMETIC_HOME/health"
    cp -r "$backup_path/health" "$HERMETIC_HOME/" 2>/dev/null

    echo "  Restoring intelligence data..."
    rm -rf "$HERMETIC_HOME/intelligence"
    cp -r "$backup_path/intelligence" "$HERMETIC_HOME/" 2>/dev/null

    echo "  Restoring community data..."
    rm -rf "$HERMETIC_HOME/community"
    cp -r "$backup_path/community" "$HERMETIC_HOME/" 2>/dev/null

    echo "  Restoring plugins..."
    # Don't delete entire plugins dir, just restore backed up ones
    cp -r "$backup_path/plugins"/* "$HERMETIC_HOME/plugins/" 2>/dev/null

    echo "  Restoring configuration..."
    [ -f "$backup_path/.hermeticrc" ] && cp "$backup_path/.hermeticrc" "$HERMETIC_HOME/"

    echo ""
    echo -e "${GREEN}✅ Restore completed successfully!${NC}"
    echo ""
    echo "Verify restored data:"
    echo "  hm stats"
    echo "  hm health"
}

# Export for sharing
export_for_sharing() {
    local export_name="hermetic-export-$(date +%Y%m%d)"
    local export_path="$BACKUP_DIR/$export_name"

    echo -e "${BLUE}📤 Creating shareable export${NC}"
    echo ""

    mkdir -p "$export_path"

    # Export anonymized usage patterns
    if [ -f "$HERMETIC_HOME/intelligence/patterns.json" ]; then
        echo "  Exporting patterns (anonymized)..."
        jq 'del(.user_info) | .shared=true | .export_date=now|strftime("%Y-%m-%d")' \
            "$HERMETIC_HOME/intelligence/patterns.json" > "$export_path/patterns.json" 2>/dev/null
    fi

    # Export custom plugins
    if [ -d "$HERMETIC_HOME/plugins" ]; then
        echo "  Exporting custom plugins..."
        cp -r "$HERMETIC_HOME/plugins" "$export_path/"
        # Remove system plugins, keep only custom
        rm -rf "$export_path/plugins/examples" 2>/dev/null
    fi

    # Export community contributions
    if [ -d "$HERMETIC_HOME/community/shared" ]; then
        echo "  Exporting community contributions..."
        cp -r "$HERMETIC_HOME/community/shared" "$export_path/community"
    fi

    # Create README
    cat > "$export_path/README.md" <<EOF
# Hermetic System Export

**Exported**: $(date '+%Y-%m-%d %H:%M:%S')
**System Version**: 2.0.0

## Contents

This export contains:
- Usage patterns (anonymized)
- Custom plugins
- Community contributions

## Import

To import into your Hermetic system:

\`\`\`bash
# Copy patterns
cp patterns.json ~/.hermetic/intelligence/

# Import plugins
cp -r plugins/* ~/.hermetic/plugins/

# Import community content
cp -r community/* ~/.hermetic/community/shared/
\`\`\`

## Shared with Gold Hat Philosophy

This export is shared to help others learn and grow.
Use it to empower, not extract.

*"Build what elevates. Reject what degrades."*
EOF

    # Create archive
    echo "  Creating archive..."
    cd "$BACKUP_DIR"
    tar -czf "$export_name.tar.gz" "$export_name" 2>/dev/null
    cd - > /dev/null

    echo ""
    echo -e "${GREEN}✅ Export created!${NC}"
    echo "   Archive: $BACKUP_DIR/$export_name.tar.gz"
    echo "   Size: $(du -sh "$BACKUP_DIR/$export_name.tar.gz" | awk '{print $1}')"
    echo ""
    echo "Share this file with the community!"
}

# Import from shared export
import_shared() {
    local import_file="$1"

    if [ ! -f "$import_file" ]; then
        echo -e "${RED}❌ File not found: $import_file${NC}"
        return 1
    fi

    echo -e "${BLUE}📥 Importing shared Hermetic data${NC}"
    echo ""

    # Extract archive
    local temp_dir=$(mktemp -d)
    echo "  Extracting..."
    tar -xzf "$import_file" -C "$temp_dir" 2>/dev/null

    # Find extracted directory
    local extracted=$(find "$temp_dir" -mindepth 1 -maxdepth 1 -type d | head -1)

    if [ -z "$extracted" ]; then
        echo -e "${RED}❌ Invalid archive${NC}"
        rm -rf "$temp_dir"
        return 1
    fi

    # Import patterns
    if [ -f "$extracted/patterns.json" ]; then
        echo "  Importing patterns..."
        cp "$extracted/patterns.json" "$HERMETIC_HOME/intelligence/imported-patterns.json"
    fi

    # Import plugins
    if [ -d "$extracted/plugins" ]; then
        echo "  Importing plugins..."
        mkdir -p "$HERMETIC_HOME/plugins/imported"
        cp -r "$extracted/plugins"/* "$HERMETIC_HOME/plugins/imported/" 2>/dev/null
    fi

    # Import community content
    if [ -d "$extracted/community" ]; then
        echo "  Importing community content..."
        mkdir -p "$HERMETIC_HOME/community/imported"
        cp -r "$extracted/community"/* "$HERMETIC_HOME/community/imported/" 2>/dev/null
    fi

    # Show README if exists
    if [ -f "$extracted/README.md" ]; then
        echo ""
        echo "📖 Import Info:"
        cat "$extracted/README.md" | head -20
    fi

    # Cleanup
    rm -rf "$temp_dir"

    echo ""
    echo -e "${GREEN}✅ Import completed!${NC}"
    echo ""
    echo "Review imported content:"
    echo "  Patterns: $HERMETIC_HOME/intelligence/imported-patterns.json"
    echo "  Plugins: $HERMETIC_HOME/plugins/imported/"
    echo "  Community: $HERMETIC_HOME/community/imported/"
}

# Auto-backup (for cron)
auto_backup() {
    # Only create backup if there's been activity
    if [ -f "$HERMETIC_HOME/analytics/usage.csv" ]; then
        local last_backup=$(ls -t "$BACKUP_DIR" 2>/dev/null | head -1)
        local last_entry=$(tail -1 "$HERMETIC_HOME/analytics/usage.csv" | cut -d',' -f1)

        # Create backup if none exists or if there's new activity since last backup
        if [ -z "$last_backup" ]; then
            create_backup "auto-$(date +%Y%m%d)" >/dev/null 2>&1
            echo "Auto-backup created" | logger -t hermetic
        fi
    fi
}

# Cleanup old backups
cleanup_old() {
    local keep_days=${1:-30}

    echo -e "${BLUE}🧹 Cleaning up old backups (keeping last $keep_days days)${NC}"
    echo ""

    local count=0
    find "$BACKUP_DIR" -maxdepth 1 -type d -mtime +$keep_days -exec rm -rf {} \; 2>/dev/null
    find "$BACKUP_DIR" -maxdepth 1 -name "*.tar.gz" -mtime +$keep_days | while read file; do
        echo "  Removing: $(basename "$file")"
        rm "$file"
        ((count++))
    done

    echo ""
    if [ $count -eq 0 ]; then
        echo "  No old backups to remove"
    else
        echo -e "${GREEN}✅ Removed $count old backup(s)${NC}"
    fi
}

# Main
case "${1:-list}" in
    create)
        create_backup "$2"
        ;;
    list)
        list_backups
        ;;
    restore)
        restore_backup "$2"
        ;;
    export)
        export_for_sharing
        ;;
    import)
        import_shared "$2"
        ;;
    auto)
        auto_backup
        ;;
    cleanup)
        cleanup_old "${2:-30}"
        ;;
    *)
        echo "Hermetic Backup & Restore System"
        echo ""
        echo "Usage: $0 <command> [args]"
        echo ""
        echo "Commands:"
        echo "  create [name]       Create new backup"
        echo "  list                List all backups"
        echo "  restore <name>      Restore from backup"
        echo "  export              Create shareable export"
        echo "  import <file>       Import shared data"
        echo "  auto                Auto-backup (for cron)"
        echo "  cleanup [days]      Remove backups older than N days (default: 30)"
        echo ""
        echo "Examples:"
        echo "  $0 create                    # Create timestamped backup"
        echo "  $0 create before-update      # Create named backup"
        echo "  $0 list                      # Show all backups"
        echo "  $0 restore backup-20251029   # Restore specific backup"
        echo "  $0 export                    # Create shareable export"
        echo "  $0 cleanup 60                # Remove backups older than 60 days"
        echo ""
        echo "Backup location: $BACKUP_DIR"
        exit 1
        ;;
esac
