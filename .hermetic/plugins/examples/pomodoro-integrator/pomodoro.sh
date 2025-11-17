#!/bin/bash
# Hermetic Pomodoro Timer
# Simple terminal-based pomodoro timer integrated with Hermetic system

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
POMODORO_LOG="$HERMETIC_HOME/analytics/pomodoro.csv"
POMODORO_STATE="$HERMETIC_HOME/.pomodoro-state"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Default durations (in minutes)
WORK_DURATION=25
SHORT_BREAK=5
LONG_BREAK=15

# Load config if exists
if [ -f ".hermetic-pomodoro.json" ]; then
    WORK_DURATION=$(jq -r '.work_duration // 25' .hermetic-pomodoro.json)
    SHORT_BREAK=$(jq -r '.short_break // 5' .hermetic-pomodoro.json)
    LONG_BREAK=$(jq -r '.long_break // 15' .hermetic-pomodoro.json)
fi

# Initialize log file
if [ ! -f "$POMODORO_LOG" ]; then
    echo "timestamp,type,task,duration,effectiveness" > "$POMODORO_LOG"
fi

# Start a pomodoro
start_pomodoro() {
    local task="$1"
    local duration="${2:-$WORK_DURATION}"

    if [ -z "$task" ]; then
        echo -e "${RED}Error: Please specify task${NC}"
        echo "Usage: hm pomodoro start \"task description\" [duration]"
        return 1
    fi

    echo -e "${BLUE}🍅 Starting Pomodoro${NC}"
    echo "Task: $task"
    echo "Duration: $duration minutes"
    echo ""

    # Save state
    echo "task=$task" > "$POMODORO_STATE"
    echo "start=$(date +%s)" >> "$POMODORO_STATE"
    echo "duration=$duration" >> "$POMODORO_STATE"

    # Log start
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp,start,$task,$duration," >> "$POMODORO_LOG"

    echo -e "${GREEN}✓${NC} Timer started. Focus on: $task"
    echo ""
    echo "Commands:"
    echo "  hm pomodoro status  - Check time remaining"
    echo "  hm pomodoro complete [rating] - Mark as complete"
    echo "  hm pomodoro cancel - Cancel this pomodoro"
}

# Check pomodoro status
status_pomodoro() {
    if [ ! -f "$POMODORO_STATE" ]; then
        echo "No active pomodoro"
        return
    fi

    source "$POMODORO_STATE"

    local now=$(date +%s)
    local elapsed=$(( (now - start) / 60 ))
    local remaining=$(( duration - elapsed ))

    if [ $remaining -le 0 ]; then
        echo -e "${YELLOW}⏰ Pomodoro time is up!${NC}"
        echo "Task: $task"
        echo "Duration: $duration minutes"
        echo ""
        echo "Complete it with: hm pomodoro complete [1-5]"
    else
        echo -e "${BLUE}🍅 Pomodoro in progress${NC}"
        echo "Task: $task"
        echo "Elapsed: $elapsed minutes"
        echo "Remaining: $remaining minutes"

        # Progress bar
        local progress=$(( elapsed * 20 / duration ))
        printf "Progress: ["
        for i in $(seq 1 20); do
            if [ $i -le $progress ]; then
                printf "="
            else
                printf " "
            fi
        done
        printf "] %d%%\n" $(( elapsed * 100 / duration ))
    fi
}

# Complete a pomodoro
complete_pomodoro() {
    if [ ! -f "$POMODORO_STATE" ]; then
        echo "No active pomodoro to complete"
        return
    fi

    source "$POMODORO_STATE"

    local effectiveness="${1:-3}"

    # Validate rating
    if [ "$effectiveness" -lt 1 ] || [ "$effectiveness" -gt 5 ]; then
        echo -e "${RED}Error: Effectiveness must be 1-5${NC}"
        return 1
    fi

    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp,complete,$task,$duration,$effectiveness" >> "$POMODORO_LOG"

    echo -e "${GREEN}✅ Pomodoro completed!${NC}"
    echo "Task: $task"
    echo "Duration: $duration minutes"
    echo "Effectiveness: $effectiveness/5"
    echo ""

    # Remove state
    rm "$POMODORO_STATE"

    # Suggest break
    echo -e "${BLUE}Take a break:${NC}"
    echo "  hm pomodoro break  - Start $SHORT_BREAK minute break"
    echo ""
    echo "Quick break tips:"
    echo "  • Stand and stretch"
    echo "  • Drink water"
    echo "  • Look away from screen"
    echo "  • Quick walk if possible"
}

# Start a break
start_break() {
    local break_type="${1:-short}"
    local duration=$SHORT_BREAK

    if [ "$break_type" = "long" ]; then
        duration=$LONG_BREAK
    fi

    echo -e "${BLUE}☕ Break Time${NC}"
    echo "Duration: $duration minutes"
    echo ""
    echo "Suggestions:"
    echo "  • Physical movement (stretch, walk)"
    echo "  • Hydration (drink water)"
    echo "  • Eye rest (look at distance)"
    echo "  • Quick reflection (what did I learn?)"
    echo ""
    echo "Do NOT:"
    echo "  • Check email or slack"
    echo "  • Browse social media"
    echo "  • Start another task"
    echo ""

    # Simple countdown
    echo "Break ends at: $(date -d "+$duration minutes" '+%H:%M')"

    # Save break state for tracking
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp,break,$break_type,$duration," >> "$POMODORO_LOG"
}

# Cancel pomodoro
cancel_pomodoro() {
    if [ ! -f "$POMODORO_STATE" ]; then
        echo "No active pomodoro to cancel"
        return
    fi

    source "$POMODORO_STATE"

    echo -e "${YELLOW}Pomodoro cancelled:${NC} $task"

    # Log cancellation
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp,cancel,$task,$duration,0" >> "$POMODORO_LOG"

    rm "$POMODORO_STATE"
}

# Show daily summary
summary_pomodoro() {
    if [ ! -f "$POMODORO_LOG" ]; then
        echo "No pomodoro data yet"
        return
    fi

    local today=$(date '+%Y-%m-%d')
    local completed=$(grep "^$today.*,complete," "$POMODORO_LOG" | wc -l)

    if [ $completed -eq 0 ]; then
        echo "No pomodoros completed today yet"
        return
    fi

    echo -e "${BLUE}📊 Pomodoro Summary - $today${NC}"
    echo ""

    # Count
    echo "Completed: $completed pomodoros"

    # Total time
    local total_time=$(grep "^$today.*,complete," "$POMODORO_LOG" | awk -F',' '{sum+=$4} END {print sum}')
    echo "Focused time: $total_time minutes"

    # Average effectiveness
    local avg_eff=$(grep "^$today.*,complete," "$POMODORO_LOG" | awk -F',' '{sum+=$5; count++} END {if(count>0) printf "%.1f", sum/count; else print "N/A"}')
    echo "Avg effectiveness: $avg_eff/5"

    echo ""
    echo "Top tasks:"
    grep "^$today.*,complete," "$POMODORO_LOG" | awk -F',' '{print "  • " $3 " (" $5 "/5)"}' | sort | uniq
}

# Main command router
case "${1:-help}" in
    start)
        start_pomodoro "$2" "$3"
        ;;
    status)
        status_pomodoro
        ;;
    complete)
        complete_pomodoro "$2"
        ;;
    break)
        start_break "${2:-short}"
        ;;
    longbreak)
        start_break "long"
        ;;
    cancel)
        cancel_pomodoro
        ;;
    summary)
        summary_pomodoro
        ;;
    help|*)
        echo "Hermetic Pomodoro Timer"
        echo ""
        echo "Usage: hm pomodoro <command> [options]"
        echo ""
        echo "Commands:"
        echo "  start <task> [duration]  - Start a pomodoro"
        echo "  status                   - Check current pomodoro"
        echo "  complete [rating]        - Complete pomodoro (rate 1-5)"
        echo "  cancel                   - Cancel current pomodoro"
        echo "  break                    - Start short break"
        echo "  longbreak                - Start long break"
        echo "  summary                  - Show today's summary"
        echo ""
        echo "Examples:"
        echo "  hm pomodoro start \"implement auth API\""
        echo "  hm pomodoro complete 5"
        echo "  hm pomodoro break"
        echo ""
        ;;
esac
