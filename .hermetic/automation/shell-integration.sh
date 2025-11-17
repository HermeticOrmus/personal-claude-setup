#!/bin/bash
# Hermetic Shell Integration
# Source this in your .bashrc or .zshrc to enable quick commands

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Load tracker and context detector
source "$HERMETIC_HOME/analytics/usage-tracker.sh" 2>/dev/null
source "$HERMETIC_HOME/automation/context-detector.sh" 2>/dev/null

# Quick command: hm (Hermetic Machine)
hm() {
    case "$1" in
        # Daily rituals
        start-day)
            echo "🌅 Starting new day..."
            new_day
            context_report
            echo ""
            echo "💭 Set your intention for today:"
            ;;

        check-in)
            echo "⏱️  Midday check-in..."
            show_stats
            echo ""
            echo "💡 Are you stuck? Try: hm unstuck"
            ;;

        close-day)
            echo "🌙 Closing day..."
            record_daily_health
            show_dashboard
            echo ""
            echo "📝 Remember to rate today's effectiveness:"
            echo "   hm rate agent <name> <1-5>"
            ;;

        sabbath)
            echo "🌟 Weekly Sabbath Integration"
            weekly_report
            echo ""
            echo "🙏 Honor the rhythm. Rest and integrate."
            ;;

        # Quick actions
        stats)
            show_stats
            ;;

        health)
            show_dashboard
            ;;

        context)
            context_report
            ;;

        agent)
            log_agent "$2" "${3:-general}"
            echo "🤖 Logged agent usage: $2"
            ;;

        cmd|command)
            log_command "$2" "${3:-general}"
            echo "⚡ Logged command usage: $2"
            ;;

        skill)
            log_skill "$2" "${3:-general}"
            echo "🎯 Logged skill usage: $2"
            ;;

        rate)
            rate_effectiveness "$2" "$3" "$4"
            echo "⭐ Rated $2 '$3' with $4 stars"
            ;;

        # Helpers
        unstuck)
            echo "🔓 When stuck, try:"
            echo "  1. /gnosis <your stuck point>"
            echo "  2. apply-vibration skill"
            echo "  3. Take a 15-minute walk"
            echo "  4. Consult debug-like-master skill"
            ;;

        # Maintenance
        troubleshoot|fix)
            "$HERMETIC_HOME/maintenance/troubleshoot.sh"
            ;;

        selftest|test)
            "$HERMETIC_HOME/maintenance/system-selftest.sh"
            ;;

        backup)
            "$HERMETIC_HOME/maintenance/backup-restore.sh" "${@:2}"
            ;;

        help)
            echo "Hermetic Machine (hm) Commands:"
            echo ""
            echo "Daily Rituals:"
            echo "  hm start-day    - Morning ritual"
            echo "  hm check-in     - Midday check"
            echo "  hm close-day    - Evening closure"
            echo "  hm sabbath      - Weekly review"
            echo ""
            echo "Quick Actions:"
            echo "  hm stats        - Usage statistics"
            echo "  hm health       - Health dashboard"
            echo "  hm context      - Context report"
            echo ""
            echo "Logging:"
            echo "  hm agent <name> [context]   - Log agent use"
            echo "  hm cmd <name> [context]     - Log command use"
            echo "  hm skill <name> [context]   - Log skill use"
            echo "  hm rate <type> <name> <1-5> - Rate effectiveness"
            echo ""
            echo "Maintenance:"
            echo "  hm troubleshoot     - Diagnose and fix issues"
            echo "  hm selftest         - Run system health test"
            echo "  hm backup [args]    - Backup/restore system"
            echo ""
            echo "Helpers:"
            echo "  hm unstuck      - Suggestions when stuck"
            echo "  hm help         - This message"
            ;;

        *)
            echo "Unknown command: $1"
            echo "Try: hm help"
            ;;
    esac
}

# Auto-context on cd (optional - can be disabled if annoying)
# Uncomment to enable
# _hm_auto_context() {
#     if [ "$PWD" != "$HERMETIC_LAST_PWD" ]; then
#         HERMETIC_LAST_PWD="$PWD"
#         # Only show if in a project directory
#         if in_git_repo || [ -f "package.json" ] || [ -f "requirements.txt" ] || [ -f "go.mod" ]; then
#             echo ""
#             suggest_agents
#             echo ""
#         fi
#     fi
# }
# chpwd_functions+=(_hm_auto_context)  # for zsh
# PROMPT_COMMAND="_hm_auto_context; $PROMPT_COMMAND"  # for bash

# Hermetic prompt indicator (shows if in active project)
_hm_prompt() {
    if in_git_repo; then
        local branch_type=$(detect_branch_type)
        case "$branch_type" in
            feature) echo "✨" ;;
            bugfix|hotfix) echo "🔧" ;;
            release) echo "🚀" ;;
            *) echo "⚡" ;;
        esac
    fi
}

# Add to prompt (optional)
# PS1="$(_hm_prompt) $PS1"  # Add this to your PS1 if desired

# Completion for hm command (bash)
_hm_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local commands="start-day check-in close-day sabbath stats health context agent cmd command skill rate troubleshoot fix selftest test backup unstuck help"
    COMPREPLY=($(compgen -W "$commands" -- "$cur"))
}
complete -F _hm_completion hm 2>/dev/null

echo "✅ Hermetic shell integration loaded"
echo "   Try: hm help"
