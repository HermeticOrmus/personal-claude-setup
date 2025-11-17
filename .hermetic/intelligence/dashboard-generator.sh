#!/bin/bash
# Hermetic Visual Dashboard Generator
# Creates beautiful ASCII art dashboards from analytics data

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
USAGE_LOG="$HERMETIC_HOME/analytics/usage.csv"
HEALTH_LOG="$HERMETIC_HOME/health/health-history.csv"

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Draw a bar chart
draw_bar() {
    local value=$1
    local max=$2
    local width=${3:-50}
    local char="${4:-█}"

    local bars=$(echo "scale=0; $value * $width / $max" | bc 2>/dev/null || echo "0")

    printf "%s" "$char"
    for ((i=1; i<bars; i++)); do
        printf "%s" "$char"
    done
}

# Create sparkline
sparkline() {
    local -a data=("$@")
    local chars="▁▂▃▄▅▆▇█"

    # Find min and max
    local min=${data[0]}
    local max=${data[0]}
    for val in "${data[@]}"; do
        (( $(echo "$val < $min" | bc -l) )) && min=$val
        (( $(echo "$val > $max" | bc -l) )) && max=$val
    done

    local range=$(echo "$max - $min" | bc -l)
    if (( $(echo "$range == 0" | bc -l) )); then
        range=1
    fi

    # Generate sparkline
    for val in "${data[@]}"; do
        local normalized=$(echo "($val - $min) / $range * 7" | bc -l)
        local index=$(printf "%.0f" "$normalized")
        printf "%s" "${chars:$index:1}"
    done
}

# Main dashboard
show_dashboard() {
    clear

    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                    🔮 HERMETIC CONSCIOUSNESS DASHBOARD 🔮                    ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # System status
    echo -e "${YELLOW}━━━ SYSTEM STATUS ━━━${NC}"
    echo ""

    local total_uses=$(tail -n +2 "$USAGE_LOG" 2>/dev/null | wc -l)
    local total_agents=$(grep ",agent," "$USAGE_LOG" 2>/dev/null | cut -d',' -f3 | sort -u | wc -l)
    local total_commands=$(grep ",command," "$USAGE_LOG" 2>/dev/null | cut -d',' -f3 | sort -u | wc -l)
    local total_skills=$(grep ",skill," "$USAGE_LOG" 2>/dev/null | cut -d',' -f3 | sort -u | wc -l)

    printf "  Total Invocations: ${GREEN}%d${NC}\n" "$total_uses"
    printf "  Unique Agents:     ${BLUE}%d${NC} / 103\n" "$total_agents"
    printf "  Unique Commands:   ${PURPLE}%d${NC} / 18\n" "$total_commands"
    printf "  Unique Skills:     ${CYAN}%d${NC} / 12\n" "$total_skills"
    echo ""

    # Health trend
    echo -e "${YELLOW}━━━ HEALTH TREND (Last 7 Days) ━━━${NC}"
    echo ""

    if [ -f "$HEALTH_LOG" ]; then
        local health_scores=($(tail -7 "$HEALTH_LOG" 2>/dev/null | cut -d',' -f7))
        if [ ${#health_scores[@]} -gt 0 ]; then
            printf "  "
            sparkline "${health_scores[@]}"
            printf "  (Current: ${GREEN}%d${NC}/100)\n" "${health_scores[-1]}"
        else
            echo "  No health data yet"
        fi
    fi
    echo ""

    # Top agents
    echo -e "${YELLOW}━━━ TOP 5 AGENTS ━━━${NC}"
    echo ""

    grep ",agent," "$USAGE_LOG" 2>/dev/null | cut -d',' -f3 | sort | uniq -c | sort -rn | head -5 | \
    while read count agent; do
        printf "  %-20s " "$agent"
        draw_bar "$count" 50 30 "▓"
        printf " ${GREEN}%d${NC}\n" "$count"
    done
    echo ""

    # Top commands
    echo -e "${YELLOW}━━━ TOP 5 COMMANDS ━━━${NC}"
    echo ""

    grep ",command," "$USAGE_LOG" 2>/dev/null | cut -d',' -f3 | sort | uniq -c | sort -rn | head -5 | \
    while read count command; do
        printf "  %-20s " "$command"
        draw_bar "$count" 30 30 "▓"
        printf " ${PURPLE}%d${NC}\n" "$count"
    done
    echo ""

    # Effectiveness rating
    echo -e "${YELLOW}━━━ EFFECTIVENESS RATING ━━━${NC}"
    echo ""

    local avg_effectiveness=$(awk -F',' '$5 != "" { sum += $5; count++ } END { if (count > 0) printf "%.2f", sum/count; else print "0" }' "$USAGE_LOG")

    if [ "$(echo "$avg_effectiveness > 0" | bc)" -eq 1 ]; then
        printf "  Average: ${GREEN}%.2f${NC} / 5.0  " "$avg_effectiveness"
        local stars=$(printf "%.0f" "$avg_effectiveness")
        for ((i=0; i<stars; i++)); do printf "⭐"; done
        echo ""
    else
        echo "  No ratings yet - use 'hm rate' to track effectiveness"
    fi
    echo ""

    # Daily activity
    echo -e "${YELLOW}━━━ DAILY ACTIVITY (Last 7 Days) ━━━${NC}"
    echo ""

    for i in {6..0}; do
        local date=$(date -d "$i days ago" +%Y-%m-%d 2>/dev/null || date -v-${i}d +%Y-%m-%d 2>/dev/null)
        local day_name=$(date -d "$i days ago" +%a 2>/dev/null || date -v-${i}d +%a 2>/dev/null)
        local count=$(grep "^$date" "$USAGE_LOG" 2>/dev/null | wc -l)

        printf "  ${CYAN}%s${NC} %-10s " "$day_name" "($date)"
        if [ $count -gt 0 ]; then
            draw_bar "$count" 20 20 "█"
            printf " ${GREEN}%d${NC}\n" "$count"
        else
            echo "━━━━━━━━━━━━━━━━━━━━ ${RED}0${NC}"
        fi
    done
    echo ""

    # Recommendations
    echo -e "${YELLOW}━━━ INTELLIGENT RECOMMENDATIONS ━━━${NC}"
    echo ""

    # Check if Python is available and run pattern recognition
    if command -v python3 &>/dev/null && [ -f "$HERMETIC_HOME/intelligence/pattern-recognition.py" ]; then
        python3 "$HERMETIC_HOME/intelligence/pattern-recognition.py" suggest 2>/dev/null | head -3
    else
        # Fallback recommendations
        if [ $total_uses -lt 5 ]; then
            echo "  💡 Low usage - Start with /gnosis and 3 core agents"
        fi

        if [ $total_agents -lt 5 ]; then
            echo "  💡 Try more agents - Expand your toolkit"
        fi

        local day=$(date +%u)
        if [ $day -eq 7 ]; then
            echo "  🌟 Today is Sabbath - Use sabbath-guide for integration"
        fi
    fi
    echo ""

    # Footer
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC} Updated: $(date '+%Y-%m-%d %H:%M:%S')                                                     ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Commands: hm stats | hm health | hm context | hm help"
}

# Compact dashboard
show_compact() {
    local total_uses=$(tail -n +2 "$USAGE_LOG" 2>/dev/null | wc -l)
    local avg_effectiveness=$(awk -F',' '$5 != "" { sum += $5; count++ } END { if (count > 0) printf "%.2f", sum/count; else print "0" }' "$USAGE_LOG")
    local health_score=$(tail -1 "$HEALTH_LOG" 2>/dev/null | cut -d',' -f7)

    echo "🔮 Hermetic Status: ${total_uses} uses | ⭐ ${avg_effectiveness}/5.0 | 💚 ${health_score}/100"
}

# Weekly report
show_weekly() {
    clear

    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                        📈 WEEKLY HERMETIC REPORT 📈                        ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    local week_start=$(date -d "7 days ago" +%Y-%m-%d 2>/dev/null || date -v-7d +%Y-%m-%d 2>/dev/null)
    local week_end=$(date +%Y-%m-%d)

    echo "📅 Period: $week_start to $week_end"
    echo ""

    # Weekly stats
    echo -e "${YELLOW}━━━ WEEKLY SUMMARY ━━━${NC}"
    echo ""

    local week_uses=$(awk -F',' -v start="$week_start" '$1 >= start' "$USAGE_LOG" 2>/dev/null | wc -l)
    local active_days=$(awk -F',' -v start="$week_start" '$1 >= start { print substr($1,1,10) }' "$USAGE_LOG" 2>/dev/null | sort -u | wc -l)

    printf "  Total Uses:   ${GREEN}%d${NC}\n" "$week_uses"
    printf "  Active Days:  ${BLUE}%d${NC} / 7\n" "$active_days"
    printf "  Avg per Day:  ${PURPLE}%.1f${NC}\n" "$(echo "scale=1; $week_uses / 7" | bc)"
    echo ""

    # Most productive day
    echo -e "${YELLOW}━━━ MOST PRODUCTIVE DAY ━━━${NC}"
    echo ""

    awk -F',' -v start="$week_start" '
        $1 >= start {
            date = substr($1, 1, 10)
            count[date]++
        }
        END {
            max = 0
            for (d in count) {
                if (count[d] > max) {
                    max = count[d]
                    maxday = d
                }
            }
            if (max > 0) printf "  %s with %d invocations\n", maxday, max
        }
    ' "$USAGE_LOG" 2>/dev/null
    echo ""

    # Growth indicator
    echo -e "${YELLOW}━━━ GROWTH TRAJECTORY ━━━${NC}"
    echo ""

    local prev_week_start=$(date -d "14 days ago" +%Y-%m-%d 2>/dev/null || date -v-14d +%Y-%m-%d 2>/dev/null)
    local prev_week_uses=$(awk -F',' -v start="$prev_week_start" -v end="$week_start" '$1 >= start && $1 < end' "$USAGE_LOG" 2>/dev/null | wc -l)

    if [ $prev_week_uses -gt 0 ]; then
        local growth=$(echo "scale=1; ($week_uses - $prev_week_uses) * 100 / $prev_week_uses" | bc)
        if (( $(echo "$growth > 0" | bc -l) )); then
            echo -e "  ${GREEN}↑ +${growth}%${NC} compared to previous week"
        elif (( $(echo "$growth < 0" | bc -l) )); then
            echo -e "  ${RED}↓ ${growth}%${NC} compared to previous week"
        else
            echo "  → Stable (same as previous week)"
        fi
    else
        echo "  First week of tracking!"
    fi
    echo ""

    # Sabbath check
    echo -e "${YELLOW}━━━ SABBATH OBSERVANCE ━━━${NC}"
    echo ""

    local sunday_date=$(date -d "last sunday" +%Y-%m-%d 2>/dev/null || date -v-sunday +%Y-%m-%d 2>/dev/null)
    local sunday_uses=$(grep "^$sunday_date" "$USAGE_LOG" 2>/dev/null | wc -l)

    if [ $sunday_uses -eq 0 ]; then
        echo -e "  ${GREEN}✅ Sabbath honored${NC} - No work on Sunday"
    elif [ $sunday_uses -lt 3 ]; then
        echo -e "  ${YELLOW}⚠️  Light activity${NC} on Sunday ($sunday_uses uses)"
    else
        echo -e "  ${RED}❌ Sabbath not honored${NC} - $sunday_uses uses on Sunday"
        echo "     Consider using sabbath-guide for proper integration"
    fi
    echo ""
}

# Export functions
export -f draw_bar sparkline show_dashboard show_compact show_weekly

# Main
case "${1:-full}" in
    full)
        show_dashboard
        ;;
    compact)
        show_compact
        ;;
    weekly)
        show_weekly
        ;;
    watch)
        # Auto-refresh every 5 seconds
        watch -n 5 -c "$0 full"
        ;;
    *)
        echo "Usage: $0 {full|compact|weekly|watch}"
        exit 1
        ;;
esac
