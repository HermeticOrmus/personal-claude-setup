#!/bin/bash
# Hermetic System Health Monitor
# Monitors system effectiveness and health

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
HEALTH_LOG="$HERMETIC_HOME/health/health-history.csv"
USAGE_LOG="$HERMETIC_HOME/analytics/usage.csv"

# Initialize health log
if [ ! -f "$HEALTH_LOG" ]; then
    echo "date,daily_uses,unique_agents,unique_commands,unique_skills,avg_effectiveness,health_score" > "$HEALTH_LOG"
fi

# Calculate daily usage
calculate_daily_usage() {
    local date="${1:-$(date +%Y-%m-%d)}"

    if [ ! -f "$USAGE_LOG" ]; then
        echo "0"
        return
    fi

    grep "^$date" "$USAGE_LOG" | wc -l
}

# Calculate unique agents used
calculate_unique_agents() {
    local date="${1:-$(date +%Y-%m-%d)}"

    if [ ! -f "$USAGE_LOG" ]; then
        echo "0"
        return
    fi

    grep "^$date.*,agent," "$USAGE_LOG" | cut -d',' -f3 | sort -u | wc -l
}

# Calculate unique commands used
calculate_unique_commands() {
    local date="${1:-$(date +%Y-%m-%d)}"

    if [ ! -f "$USAGE_LOG" ]; then
        echo "0"
        return
    fi

    grep "^$date.*,command," "$USAGE_LOG" | cut -d',' -f3 | sort -u | wc -l
}

# Calculate unique skills used
calculate_unique_skills() {
    local date="${1:-$(date +%Y-%m-%d)}"

    if [ ! -f "$USAGE_LOG" ]; then
        echo "0"
        return
    fi

    grep "^$date.*,skill," "$USAGE_LOG" | cut -d',' -f3 | sort -u | wc -l
}

# Calculate average effectiveness
calculate_avg_effectiveness() {
    local date="${1:-$(date +%Y-%m-%d)}"

    if [ ! -f "$USAGE_LOG" ]; then
        echo "0"
        return
    fi

    awk -F',' -v date="$date" '
        $1 ~ "^"date && $5 != "" { sum += $5; count++ }
        END { if (count > 0) printf "%.2f", sum/count; else print "0" }
    ' "$USAGE_LOG"
}

# Calculate health score (0-100)
calculate_health_score() {
    local daily_uses=$1
    local unique_agents=$2
    local unique_commands=$3
    local unique_skills=$4
    local avg_effectiveness=$5

    # Scoring algorithm
    # - Daily usage: 30 points (target 5-10 uses)
    # - Diversity: 30 points (using variety of agents/commands/skills)
    # - Effectiveness: 40 points (average rating)

    local usage_score=0
    if [ $daily_uses -ge 5 ] && [ $daily_uses -le 10 ]; then
        usage_score=30
    elif [ $daily_uses -gt 10 ]; then
        usage_score=$((30 - (daily_uses - 10) * 2))  # Penalty for overuse
        [ $usage_score -lt 0 ] && usage_score=0
    else
        usage_score=$((daily_uses * 6))  # 6 points per use up to 5
    fi

    local diversity_score=$((unique_agents * 5 + unique_commands * 5 + unique_skills * 10))
    [ $diversity_score -gt 30 ] && diversity_score=30

    local effectiveness_score=0
    if [ "$(echo "$avg_effectiveness > 0" | bc)" -eq 1 ]; then
        effectiveness_score=$(echo "$avg_effectiveness * 8" | bc | cut -d'.' -f1)
    fi

    local total=$((usage_score + diversity_score + effectiveness_score))
    echo $total
}

# Record today's health
record_daily_health() {
    local date=$(date +%Y-%m-%d)

    local daily_uses=$(calculate_daily_usage "$date")
    local unique_agents=$(calculate_unique_agents "$date")
    local unique_commands=$(calculate_unique_commands "$date")
    local unique_skills=$(calculate_unique_skills "$date")
    local avg_effectiveness=$(calculate_avg_effectiveness "$date")
    local health_score=$(calculate_health_score $daily_uses $unique_agents $unique_commands $unique_skills $avg_effectiveness)

    echo "$date,$daily_uses,$unique_agents,$unique_commands,$unique_skills,$avg_effectiveness,$health_score" >> "$HEALTH_LOG"
}

# Show health dashboard
show_dashboard() {
    echo "🏥 Hermetic System Health Dashboard"
    echo "===================================="
    echo ""

    local date=$(date +%Y-%m-%d)
    local daily_uses=$(calculate_daily_usage "$date")
    local unique_agents=$(calculate_unique_agents "$date")
    local unique_commands=$(calculate_unique_commands "$date")
    local unique_skills=$(calculate_unique_skills "$date")
    local avg_effectiveness=$(calculate_avg_effectiveness "$date")
    local health_score=$(calculate_health_score $daily_uses $unique_agents $unique_commands $unique_skills $avg_effectiveness)

    echo "📅 Today: $(date '+%A, %B %d, %Y')"
    echo ""
    echo "📊 Usage Metrics:"
    echo "  - Total invocations: $daily_uses"
    echo "  - Unique agents: $unique_agents"
    echo "  - Unique commands: $unique_commands"
    echo "  - Unique skills: $unique_skills"
    echo ""
    echo "⭐ Effectiveness:"
    echo "  - Average rating: $avg_effectiveness / 5.0"
    echo ""
    echo "💚 Health Score: $health_score / 100"

    if [ $health_score -ge 80 ]; then
        echo "  Status: 🟢 Excellent - System thriving!"
    elif [ $health_score -ge 60 ]; then
        echo "  Status: 🟡 Good - System functional"
    elif [ $health_score -ge 40 ]; then
        echo "  Status: 🟠 Fair - Needs attention"
    else
        echo "  Status: 🔴 Poor - Requires intervention"
    fi

    echo ""
    echo "💡 Recommendations:"

    if [ $daily_uses -lt 3 ]; then
        echo "  - ⚠️  Low usage - System not being utilized"
    elif [ $daily_uses -gt 15 ]; then
        echo "  - ⚠️  High usage - Risk of dependency or overcomplication"
    fi

    if [ $unique_agents -lt 3 ]; then
        echo "  - 💡 Try more agents - Expand your toolkit"
    fi

    if [ $unique_commands -eq 0 ]; then
        echo "  - 💡 Use slash commands - /gnosis, /align, /verify"
    fi

    if [ $unique_skills -eq 0 ]; then
        echo "  - 💡 Apply Hermetic skills - debug-like-master, ship-sustainably"
    fi

    if [ "$(echo "$avg_effectiveness < 3.0" | bc)" -eq 1 ] && [ "$(echo "$avg_effectiveness > 0" | bc)" -eq 1 ]; then
        echo "  - 🚨 Low effectiveness - Review and optimize usage patterns"
    fi
}

# Weekly health report
weekly_report() {
    echo "📈 Hermetic Weekly Health Report"
    echo "================================="
    echo ""

    if [ ! -f "$HEALTH_LOG" ]; then
        echo "No health data available yet."
        return
    fi

    local week_start=$(date -d "7 days ago" +%Y-%m-%d 2>/dev/null || date -v-7d +%Y-%m-%d 2>/dev/null)

    echo "📅 Week: $week_start to $(date +%Y-%m-%d)"
    echo ""

    awk -F',' -v start="$week_start" '
        NR > 1 && $1 >= start {
            days++
            total_uses += $2
            total_agents += $3
            total_commands += $4
            total_skills += $5
            if ($6 > 0) {
                total_effectiveness += $6
                effectiveness_count++
            }
            total_health += $7
        }
        END {
            print "📊 Weekly Summary:"
            printf "  - Active days: %d / 7\n", days
            printf "  - Avg daily uses: %.1f\n", total_uses / (days > 0 ? days : 1)
            printf "  - Avg agents per day: %.1f\n", total_agents / (days > 0 ? days : 1)
            printf "  - Avg commands per day: %.1f\n", total_commands / (days > 0 ? days : 1)
            printf "  - Avg skills per day: %.1f\n", total_skills / (days > 0 ? days : 1)
            print ""
            if (effectiveness_count > 0) {
                printf "⭐ Avg effectiveness: %.2f / 5.0\n", total_effectiveness / effectiveness_count
            } else {
                print "⭐ Avg effectiveness: No ratings yet"
            }
            printf "💚 Avg health score: %.0f / 100\n", total_health / (days > 0 ? days : 1)
        }
    ' "$HEALTH_LOG"
}

# Export functions
export -f calculate_daily_usage calculate_unique_agents calculate_unique_commands
export -f calculate_unique_skills calculate_avg_effectiveness calculate_health_score
export -f record_daily_health show_dashboard weekly_report

# If run directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    case "${1:-dashboard}" in
        dashboard)
            show_dashboard
            ;;
        record)
            record_daily_health
            echo "✅ Health recorded for today"
            ;;
        weekly)
            weekly_report
            ;;
        *)
            echo "Usage: $0 {dashboard|record|weekly}"
            exit 1
            ;;
    esac
fi
