#!/bin/bash
# Hermetic System Usage Tracker
# Logs all agent, command, and skill usage for analytics

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
USAGE_LOG="$HERMETIC_HOME/analytics/usage.csv"
DAILY_LOG="$HERMETIC_HOME/analytics/daily-log.md"

# Create log file with headers if it doesn't exist
if [ ! -f "$USAGE_LOG" ]; then
    echo "timestamp,type,name,context,effectiveness" > "$USAGE_LOG"
fi

# Log agent usage
log_agent() {
    local agent_name="$1"
    local context="${2:-general}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "$timestamp,agent,$agent_name,$context," >> "$USAGE_LOG"
    echo "🤖 Used agent: $agent_name (context: $context)" >> "$DAILY_LOG"
}

# Log command usage
log_command() {
    local command_name="$1"
    local context="${2:-general}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "$timestamp,command,$command_name,$context," >> "$USAGE_LOG"
    echo "⚡ Invoked command: $command_name (context: $context)" >> "$DAILY_LOG"
}

# Log skill usage
log_skill() {
    local skill_name="$1"
    local context="${2:-general}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "$timestamp,skill,$skill_name,$context," >> "$USAGE_LOG"
    echo "🎯 Applied skill: $skill_name (context: $context)" >> "$DAILY_LOG"
}

# Rate effectiveness (1-5)
rate_effectiveness() {
    local type="$1"
    local name="$2"
    local rating="$3"

    # Find and update the last matching entry
    local temp_file=$(mktemp)
    awk -v type="$type" -v name="$name" -v rating="$rating" '
        BEGIN { FS=OFS="," }
        $2 == type && $3 == name && $5 == "" {
            $5 = rating
            found = 1
        }
        { print }
        END { if (!found) exit 1 }
    ' "$USAGE_LOG" > "$temp_file" && mv "$temp_file" "$USAGE_LOG"
}

# Show usage stats
show_stats() {
    echo "=== Hermetic System Usage Statistics ==="
    echo ""
    echo "Total invocations:"
    tail -n +2 "$USAGE_LOG" | wc -l
    echo ""
    echo "By type:"
    tail -n +2 "$USAGE_LOG" | cut -d',' -f2 | sort | uniq -c | sort -rn
    echo ""
    echo "Most used agents:"
    grep ",agent," "$USAGE_LOG" | cut -d',' -f3 | sort | uniq -c | sort -rn | head -5
    echo ""
    echo "Most used commands:"
    grep ",command," "$USAGE_LOG" | cut -d',' -f3 | sort | uniq -c | sort -rn | head -5
    echo ""
    echo "Average effectiveness:"
    awk -F',' '$5 != "" { sum += $5; count++ } END { if (count > 0) print sum/count; else print "No ratings yet" }' "$USAGE_LOG"
}

# Start new day log
new_day() {
    echo "" >> "$DAILY_LOG"
    echo "# $(date '+%A, %B %d, %Y')" >> "$DAILY_LOG"
    echo "Morning intention: What do I want to accomplish today?" >> "$DAILY_LOG"
    echo "" >> "$DAILY_LOG"
}

# Export functions
export -f log_agent log_command log_skill rate_effectiveness show_stats new_day

# If run directly, show stats
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    case "${1:-stats}" in
        stats)
            show_stats
            ;;
        agent)
            log_agent "$2" "$3"
            ;;
        command)
            log_command "$2" "$3"
            ;;
        skill)
            log_skill "$2" "$3"
            ;;
        rate)
            rate_effectiveness "$2" "$3" "$4"
            ;;
        new-day)
            new_day
            ;;
        *)
            echo "Usage: $0 {stats|agent|command|skill|rate|new-day}"
            exit 1
            ;;
    esac
fi
