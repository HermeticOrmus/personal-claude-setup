#!/bin/bash
# Hermetic Git Hooks Installer
# Automatically install Hermetic-aware git hooks in any repository

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

install_hooks() {
    local repo_path="${1:-.}"

    # Check if in git repo
    if [ ! -d "$repo_path/.git" ]; then
        echo -e "${RED}❌ Not a git repository: $repo_path${NC}"
        return 1
    fi

    echo -e "${GREEN}🔧 Installing Hermetic git hooks in: $repo_path${NC}"
    echo ""

    # Create hooks directory
    mkdir -p "$repo_path/.git/hooks"

    # Pre-commit hook
    cat > "$repo_path/.git/hooks/pre-commit" <<'HOOK_EOF'
#!/bin/bash
# Hermetic Pre-Commit Hook

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Source context detector if available
if [ -f "$HERMETIC_HOME/automation/context-detector.sh" ]; then
    source "$HERMETIC_HOME/automation/context-detector.sh"

    echo "🔮 Hermetic Pre-Commit Checks..."
    echo ""

    # Check for anti-patterns in code
    check_antipatterns

    echo ""
fi

# Check for secrets
echo "🔒 Checking for potential secrets..."
if git diff --cached --name-only | xargs grep -i 'api[_-]key\|password\|secret\|token' 2>/dev/null; then
    echo ""
    echo "⚠️  WARNING: Potential secrets detected in staged files!"
    echo "   Review carefully before committing."
    echo ""
    read -p "Continue with commit? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check for TODO/FIXME
if git diff --cached | grep -E '^\+.*TODO|^\+.*FIXME|^\+.*HACK' &>/dev/null; then
    echo ""
    echo "💡 New TODO/FIXME/HACK added"
    echo "   Consider creating a task to address this."
fi

exit 0
HOOK_EOF

    chmod +x "$repo_path/.git/hooks/pre-commit"
    echo -e "${GREEN}✅ Pre-commit hook installed${NC}"

    # Post-commit hook
    cat > "$repo_path/.git/hooks/post-commit" <<'HOOK_EOF'
#!/bin/bash
# Hermetic Post-Commit Hook

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Log commit activity
if [ -f "$HERMETIC_HOME/analytics/usage-tracker.sh" ]; then
    source "$HERMETIC_HOME/analytics/usage-tracker.sh"

    # Get commit message
    commit_msg=$(git log -1 --pretty=%B)

    # Determine context from commit message
    context="general"
    if echo "$commit_msg" | grep -qi 'feat\|feature'; then
        context="feature-development"
    elif echo "$commit_msg" | grep -qi 'fix\|bug'; then
        context="bug-fix"
    elif echo "$commit_msg" | grep -qi 'refactor'; then
        context="refactoring"
    elif echo "$commit_msg" | grep -qi 'test'; then
        context="testing"
    elif echo "$commit_msg" | grep -qi 'doc'; then
        context="documentation"
    fi

    # Log the commit
    echo "$(date '+%Y-%m-%d %H:%M:%S'),commit,git-commit,$context," >> "$HERMETIC_HOME/analytics/usage.csv"
fi

exit 0
HOOK_EOF

    chmod +x "$repo_path/.git/hooks/post-commit"
    echo -e "${GREEN}✅ Post-commit hook installed${NC}"

    # Pre-push hook
    cat > "$repo_path/.git/hooks/pre-push" <<'HOOK_EOF'
#!/bin/bash
# Hermetic Pre-Push Hook

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

echo "🔮 Hermetic Pre-Push Checks..."
echo ""

# Source context detector if available
if [ -f "$HERMETIC_HOME/automation/context-detector.sh" ]; then
    source "$HERMETIC_HOME/automation/context-detector.sh"

    # Check for rhythm violations
    check_antipatterns
fi

# Prompt for alignment check
echo ""
echo "🎯 Ethics Alignment Check:"
echo "   Does this code serve genuine human needs?"
echo "   Does it empower rather than extract?"
echo ""
read -p "Alignment confirmed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Push cancelled. Review alignment with /align command in Claude Code."
    exit 1
fi

# Suggest verification
echo ""
echo "💡 Reminder: Run /verify before pushing to production"

exit 0
HOOK_EOF

    chmod +x "$repo_path/.git/hooks/pre-push"
    echo -e "${GREEN}✅ Pre-push hook installed${NC}"

    # Commit-msg hook
    cat > "$repo_path/.git/hooks/commit-msg" <<'HOOK_EOF'
#!/bin/bash
# Hermetic Commit-Msg Hook

commit_msg_file=$1
commit_msg=$(cat "$commit_msg_file")

# Check if commit message includes Hermetic attribution (for conscious commits)
if echo "$commit_msg" | grep -q "Hermetic:"; then
    # Commit message already has Hermetic context, good!
    exit 0
fi

# For major commits, suggest adding context
if [ ${#commit_msg} -gt 100 ]; then
    # This is a substantial commit
    echo ""
    echo "💡 Substantial commit detected!"
    echo "   Consider adding Hermetic context:"
    echo "   Hermetic: [Principle Applied] - [Brief note]"
    echo ""
    echo "   Example:"
    echo "   Hermetic: Mentalism - Clarified architecture before implementing"
    echo ""
fi

exit 0
HOOK_EOF

    chmod +x "$repo_path/.git/hooks/commit-msg"
    echo -e "${GREEN}✅ Commit-msg hook installed${NC}"

    echo ""
    echo -e "${GREEN}🎉 All Hermetic git hooks installed successfully!${NC}"
    echo ""
    echo "Hooks installed:"
    echo "  • pre-commit  - Checks for secrets, anti-patterns"
    echo "  • post-commit - Logs commit activity"
    echo "  • pre-push    - Alignment check, rhythm verification"
    echo "  • commit-msg  - Suggests Hermetic context for major commits"
    echo ""
    echo "To disable a hook, simply remove or rename it in .git/hooks/"
}

# Uninstall hooks
uninstall_hooks() {
    local repo_path="${1:-.}"

    if [ ! -d "$repo_path/.git" ]; then
        echo -e "${RED}❌ Not a git repository: $repo_path${NC}"
        return 1
    fi

    echo "🗑️  Removing Hermetic git hooks..."

    rm -f "$repo_path/.git/hooks/pre-commit"
    rm -f "$repo_path/.git/hooks/post-commit"
    rm -f "$repo_path/.git/hooks/pre-push"
    rm -f "$repo_path/.git/hooks/commit-msg"

    echo -e "${GREEN}✅ Hermetic git hooks removed${NC}"
}

# Install in all git repos in a directory
install_recursive() {
    local base_path="${1:-.}"

    echo "🔍 Searching for git repositories in: $base_path"
    echo ""

    local count=0
    while IFS= read -r -d '' git_dir; do
        repo_dir=$(dirname "$git_dir")
        echo "Found: $repo_dir"
        install_hooks "$repo_dir"
        echo ""
        ((count++))
    done < <(find "$base_path" -name ".git" -type d -print0 2>/dev/null)

    echo ""
    echo -e "${GREEN}✅ Installed hooks in $count repositories${NC}"
}

# Check hook status
check_status() {
    local repo_path="${1:-.}"

    if [ ! -d "$repo_path/.git" ]; then
        echo -e "${RED}❌ Not a git repository: $repo_path${NC}"
        return 1
    fi

    echo "📊 Hermetic Git Hooks Status"
    echo ""

    local hooks=("pre-commit" "post-commit" "pre-push" "commit-msg")
    for hook in "${hooks[@]}"; do
        if [ -x "$repo_path/.git/hooks/$hook" ]; then
            echo -e "  ✅ $hook - ${GREEN}installed${NC}"
        else
            echo -e "  ❌ $hook - ${RED}not installed${NC}"
        fi
    done
}

# Main
case "${1:-install}" in
    install)
        install_hooks "$2"
        ;;
    uninstall)
        uninstall_hooks "$2"
        ;;
    recursive)
        install_recursive "$2"
        ;;
    status)
        check_status "$2"
        ;;
    *)
        echo "Hermetic Git Hooks Installer"
        echo ""
        echo "Usage: $0 <command> [path]"
        echo ""
        echo "Commands:"
        echo "  install [path]     Install hooks in repository (default: current dir)"
        echo "  uninstall [path]   Remove hooks from repository"
        echo "  recursive [path]   Install in all git repos under path"
        echo "  status [path]      Check hook installation status"
        echo ""
        echo "Examples:"
        echo "  $0 install                    # Install in current repo"
        echo "  $0 install ~/projects/myapp   # Install in specific repo"
        echo "  $0 recursive ~/projects       # Install in all repos under ~/projects"
        echo "  $0 status                     # Check current repo status"
        exit 1
        ;;
esac
