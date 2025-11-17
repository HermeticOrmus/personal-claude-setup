#!/bin/bash
# Hermetic Context Detector
# Detects current work context and suggests appropriate agents/commands

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Detect if in git repository
in_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

# Detect file types in current directory
detect_file_context() {
    local context=""

    if ls *.py &>/dev/null; then
        context="python"
    elif ls *.js *.ts &>/dev/null; then
        context="javascript"
    elif ls *.go &>/dev/null; then
        context="golang"
    elif ls *.rs &>/dev/null; then
        context="rust"
    elif ls *.java &>/dev/null; then
        context="java"
    fi

    echo "$context"
}

# Detect current branch type (feature, bugfix, etc.)
detect_branch_type() {
    if ! in_git_repo; then
        echo "none"
        return
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    case "$branch" in
        feature/*|feat/*)
            echo "feature"
            ;;
        bugfix/*|fix/*)
            echo "bugfix"
            ;;
        hotfix/*)
            echo "hotfix"
            ;;
        release/*)
            echo "release"
            ;;
        *)
            echo "other"
            ;;
    esac
}

# Detect time of day
detect_time_context() {
    local hour=$(date +%H)

    if [ $hour -ge 6 ] && [ $hour -lt 12 ]; then
        echo "morning"
    elif [ $hour -ge 12 ] && [ $hour -lt 17 ]; then
        echo "afternoon"
    elif [ $hour -ge 17 ] && [ $hour -lt 22 ]; then
        echo "evening"
    else
        echo "late-night"
    fi
}

# Detect if working on weekend
is_weekend() {
    local day=$(date +%u)  # 1=Monday, 7=Sunday
    [ $day -ge 6 ]
}

# Suggest agents based on context
suggest_agents() {
    local file_context=$(detect_file_context)
    local branch_type=$(detect_branch_type)
    local suggestions=()

    case "$file_context" in
        python|javascript|golang|rust|java)
            suggestions+=("neptune (backend architecture)")
            suggestions+=("uranus (AI/ML if applicable)")
            ;;
    esac

    case "$branch_type" in
        feature)
            suggestions+=("hera (brand alignment)")
            suggestions+=("metis (UX research)")
            ;;
        bugfix|hotfix)
            suggestions+=("Apply debug-like-master skill")
            suggestions+=("/cause-effect to trace root cause")
            ;;
        release)
            suggestions+=("ganymede (API testing)")
            suggestions+=("/verify before release")
            suggestions+=("/align ethics check")
            ;;
    esac

    if [ ${#suggestions[@]} -gt 0 ]; then
        echo "💡 Context-aware suggestions:"
        printf '%s\n' "${suggestions[@]}" | sed 's/^/  - /'
    fi
}

# Suggest commands based on context
suggest_commands() {
    local time_context=$(detect_time_context)
    local branch_type=$(detect_branch_type)
    local suggestions=()

    # Time-based suggestions
    case "$time_context" in
        morning)
            suggestions+=("/gnosis to clarify today's work")
            ;;
        late-night)
            suggestions+=("⚠️  Consider /rhythm - working late impacts sustainability")
            ;;
    esac

    # Weekend warning
    if is_weekend; then
        local day=$(date +%A)
        if [ "$day" = "Sunday" ]; then
            suggestions+=("🌟 Today is Sabbath - use sabbath-guide agent for integration")
        else
            suggestions+=("⚠️  Weekend work - ensure /rhythm and /balance are honored")
        fi
    fi

    # Branch-based suggestions
    case "$branch_type" in
        feature)
            suggestions+=("/align to check ethical implications")
            ;;
        release)
            suggestions+=("/illuminate for complete system understanding")
            ;;
    esac

    if [ ${#suggestions[@]} -gt 0 ]; then
        echo "⚡ Command suggestions:"
        printf '%s\n' "${suggestions[@]}" | sed 's/^/  - /'
    fi
}

# Check for anti-patterns
check_antipatterns() {
    local warnings=()

    # Check for 7+ consecutive days of commits
    if in_git_repo; then
        local days_active=0
        for i in {0..6}; do
            local date=$(date -d "$i days ago" +%Y-%m-%d 2>/dev/null || date -v-${i}d +%Y-%m-%d 2>/dev/null)
            if [ -n "$(git log --since="$date 00:00" --until="$date 23:59" --oneline 2>/dev/null)" ]; then
                ((days_active++))
            fi
        done

        if [ $days_active -ge 7 ]; then
            warnings+=("🚨 RHYTHM VIOLATION: 7+ consecutive days of commits - Sabbath needed!")
        fi
    fi

    # Check for late-night work patterns
    if [ "$(detect_time_context)" = "late-night" ]; then
        warnings+=("⚠️  Working late night - ensure this is sustainable")
    fi

    # Check for TODO or FIXME in recent commits
    if in_git_repo; then
        if git log -1 --pretty=%B | grep -iE 'TODO|FIXME|HACK' &>/dev/null; then
            warnings+=("💡 Technical debt added - consider creating task to address")
        fi
    fi

    if [ ${#warnings[@]} -gt 0 ]; then
        echo "🛡️  Anti-pattern checks:"
        printf '%s\n' "${warnings[@]}" | sed 's/^/  - /'
    fi
}

# Full context report
context_report() {
    echo "🔮 Hermetic Context Report"
    echo "=========================="
    echo ""
    echo "📍 Location: $(pwd)"
    echo "🕐 Time: $(date '+%A, %B %d, %Y - %I:%M %p')"
    echo "💻 Language: $(detect_file_context)"
    echo "🌿 Branch type: $(detect_branch_type)"
    echo ""
    suggest_agents
    echo ""
    suggest_commands
    echo ""
    check_antipatterns
}

# Export functions
export -f detect_file_context detect_branch_type detect_time_context
export -f is_weekend suggest_agents suggest_commands check_antipatterns context_report

# If run directly, show context report
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    case "${1:-report}" in
        report)
            context_report
            ;;
        agents)
            suggest_agents
            ;;
        commands)
            suggest_commands
            ;;
        check)
            check_antipatterns
            ;;
        *)
            echo "Usage: $0 {report|agents|commands|check}"
            exit 1
            ;;
    esac
fi
