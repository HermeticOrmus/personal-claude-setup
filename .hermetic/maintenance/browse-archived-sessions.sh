#!/usr/bin/env bash
# browse-archived-sessions.sh - Browse and Restore Archived Sessions

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
ARCHIVE_BASE="${HERMETIC_ROOT}/archives/sessions"
SESSIONS_DIR="${HOME}/.claude/sessions"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
    SESSIONS_DIR=$(cygpath -u "$SESSIONS_DIR" 2>/dev/null || echo "$SESSIONS_DIR")
fi

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

list_archives() {
    echo -e "${BLUE}Archived Sessions${NC}\n"

    if [[ ! -d "$ARCHIVE_BASE" ]]; then
        echo -e "${YELLOW}No archives found${NC}"
        return
    fi

    find "$ARCHIVE_BASE" -name "*.tar.gz" -type f -printf "%T@ %p\n" 2>/dev/null | sort -rn | head -20 | while read timestamp filepath; do
        local filename=$(basename "$filepath" .tar.gz)
        local size=$(du -h "$filepath" | cut -f1)
        local date=$(date -d "@${timestamp}" '+%Y-%m-%d %H:%M' 2>/dev/null || echo "N/A")
        echo -e "  ${GREEN}●${NC} ${filename} (${size}, ${date})"
    done
    echo ""
}

search_archives() {
    local query="$1"
    echo -e "${BLUE}Search results for: ${query}${NC}\n"

    find "$ARCHIVE_BASE" -name "*${query}*.tar.gz" -type f -printf "%T@ %p\n" 2>/dev/null | sort -rn | while read timestamp filepath; do
        local filename=$(basename "$filepath" .tar.gz)
        local size=$(du -h "$filepath" | cut -f1)
        echo -e "  ${GREEN}●${NC} ${filename} (${size})"
    done
    echo ""
}

restore_archive() {
    local archive_name="$1"
    local archive_file=$(find "$ARCHIVE_BASE" -name "${archive_name}.tar.gz" -type f 2>/dev/null | head -1)

    if [[ -z "$archive_file" ]]; then
        echo -e "${RED}Archive not found: ${archive_name}${NC}"
        return 1
    fi

    echo -e "${BLUE}Restoring: ${archive_name}${NC}"

    mkdir -p "$SESSIONS_DIR"

    if tar -xzf "$archive_file" -C "$SESSIONS_DIR" 2>/dev/null; then
        echo -e "${GREEN}✓ Restored to: ${SESSIONS_DIR}/${archive_name}${NC}"
        return 0
    else
        echo -e "${RED}✗ Failed to restore${NC}"
        return 1
    fi
}

show_info() {
    local archive_name="$1"
    local archive_file=$(find "$ARCHIVE_BASE" -name "${archive_name}.tar.gz" -type f 2>/dev/null | head -1)

    if [[ -z "$archive_file" ]]; then
        echo -e "${RED}Archive not found${NC}"
        return 1
    fi

    echo -e "${BLUE}Archive Information${NC}\n"
    echo "  Name: ${archive_name}"
    echo "  Path: ${archive_file}"
    echo "  Size: $(du -h "$archive_file" | cut -f1)"
    echo "  Date: $(stat -c %y "$archive_file" 2>/dev/null || stat -f %Sm "$archive_file" 2>/dev/null)"
    echo ""
    echo -e "${CYAN}Contents:${NC}"
    tar -tzf "$archive_file" 2>/dev/null | head -20
    echo ""
}

show_stats() {
    echo -e "${BLUE}Archive Statistics${NC}\n"

    local total=$(find "$ARCHIVE_BASE" -name "*.tar.gz" -type f 2>/dev/null | wc -l)
    local size=$(du -sh "$ARCHIVE_BASE" 2>/dev/null | cut -f1 || echo "0")

    echo "  Total Archives: ${CYAN}${total}${NC}"
    echo "  Total Size: ${CYAN}${size}${NC}"
    echo ""
}

case "${1:-}" in
    list) list_archives ;;
    search) search_archives "${2:-}" ;;
    restore) restore_archive "${2:-}" ;;
    info) show_info "${2:-}" ;;
    stats) show_stats ;;
    *)
        echo "Browse Archived Sessions"
        echo ""
        echo "Usage:"
        echo "  bash browse-archived-sessions.sh list              List recent archives"
        echo "  bash browse-archived-sessions.sh search QUERY      Search archives"
        echo "  bash browse-archived-sessions.sh restore NAME      Restore archive"
        echo "  bash browse-archived-sessions.sh info NAME         Show archive info"
        echo "  bash browse-archived-sessions.sh stats             Show statistics"
        ;;
esac
