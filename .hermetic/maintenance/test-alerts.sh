#!/usr/bin/env bash
# test-alerts.sh - Alert System Testing Utility
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
ALERT_SCRIPT="${HERMETIC_ROOT}/maintenance/hermetic-alerts.sh"

# Convert Windows paths if running in Git Bash
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_basic_alert() {
    echo -e "${BLUE}Testing basic INFO alert...${NC}"
    bash "$ALERT_SCRIPT" "Test alert: System operational" INFO test
    echo -e "${GREEN}✓ Basic alert test complete${NC}\n"
}

test_severity_levels() {
    echo -e "${BLUE}Testing all severity levels...${NC}"

    echo "  • INFO level..."
    bash "$ALERT_SCRIPT" "Test INFO: This is an informational message" INFO test
    sleep 1

    echo "  • WARNING level..."
    bash "$ALERT_SCRIPT" "Test WARNING: This is a warning message" WARNING test
    sleep 1

    echo "  • CRITICAL level..."
    bash "$ALERT_SCRIPT" "Test CRITICAL: This is a critical message" CRITICAL test

    echo -e "${GREEN}✓ Severity level tests complete${NC}\n"
}

test_throttling() {
    echo -e "${BLUE}Testing throttling behavior...${NC}"

    echo "  • Sending 3 identical messages rapidly..."
    bash "$ALERT_SCRIPT" "Test throttle: Identical message" INFO test
    sleep 1
    bash "$ALERT_SCRIPT" "Test throttle: Identical message" INFO test
    sleep 1
    bash "$ALERT_SCRIPT" "Test throttle: Identical message" INFO test

    echo -e "${YELLOW}  Note: Second and third should be throttled${NC}"
    echo -e "${GREEN}✓ Throttling test complete${NC}\n"
}

test_different_sources() {
    echo -e "${BLUE}Testing different sources...${NC}"

    local sources=("backup" "mcp" "session" "n8n" "dashboard")

    for source in "${sources[@]}"; do
        echo "  • Testing source: $source"
        bash "$ALERT_SCRIPT" "Test from $source system" INFO "$source"
        sleep 1
    done

    echo -e "${GREEN}✓ Source tests complete${NC}\n"
}

test_message_formatting() {
    echo -e "${BLUE}Testing message formatting...${NC}"

    # Test with special characters
    bash "$ALERT_SCRIPT" "Test with special chars: !@#\$%^&*()" INFO test
    sleep 1

    # Test with multiline
    bash "$ALERT_SCRIPT" "Test multiline message:
Line 1: System status
Line 2: All operational
Line 3: No issues detected" INFO test

    echo -e "${GREEN}✓ Formatting tests complete${NC}\n"
}

run_all_tests() {
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  Hermetic Alert System - Comprehensive Test Suite${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}\n"

    test_basic_alert
    test_severity_levels
    test_throttling
    test_different_sources
    test_message_formatting

    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  All tests complete!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}\n"

    echo -e "${BLUE}To view alert history:${NC}"
    echo "  bash view-alerts.sh recent"
    echo ""
    echo -e "${BLUE}To configure alert channels:${NC}"
    echo "  bash setup-alerts.sh"
    echo ""
}

# ============================================================================
# INTERACTIVE MENU
# ============================================================================

show_menu() {
    cat << EOF

═══════════════════════════════════════════════════
  Hermetic Alert System - Test Utility
═══════════════════════════════════════════════════

1. Run all tests
2. Test basic alert
3. Test severity levels (INFO/WARNING/CRITICAL)
4. Test throttling behavior
5. Test different sources
6. Test message formatting
7. Send custom test alert
8. View recent alerts
9. Exit

EOF
}

interactive_mode() {
    while true; do
        show_menu
        read -p "Select option (1-9): " choice

        case "$choice" in
            1) run_all_tests ;;
            2) test_basic_alert ;;
            3) test_severity_levels ;;
            4) test_throttling ;;
            5) test_different_sources ;;
            6) test_message_formatting ;;
            7)
                read -p "Enter message: " msg
                read -p "Enter severity (INFO/WARNING/CRITICAL): " sev
                bash "$ALERT_SCRIPT" "$msg" "${sev:-INFO}" test
                echo -e "${GREEN}✓ Alert sent${NC}\n"
                ;;
            8)
                if command -v view-alerts.sh &> /dev/null; then
                    bash "${HERMETIC_ROOT}/maintenance/view-alerts.sh" recent
                else
                    echo -e "${YELLOW}view-alerts.sh not found${NC}"
                fi
                ;;
            9)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid option${NC}"
                ;;
        esac

        read -p "Press Enter to continue..."
    done
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    if [[ ! -f "$ALERT_SCRIPT" ]]; then
        echo -e "${RED}Error: hermetic-alerts.sh not found${NC}"
        echo "Expected location: $ALERT_SCRIPT"
        exit 1
    fi

    if [[ $# -eq 0 ]]; then
        interactive_mode
    else
        case "$1" in
            all) run_all_tests ;;
            basic) test_basic_alert ;;
            severity) test_severity_levels ;;
            throttle) test_throttling ;;
            sources) test_different_sources ;;
            format) test_message_formatting ;;
            *)
                echo "Usage: bash test-alerts.sh [all|basic|severity|throttle|sources|format]"
                echo "Run without arguments for interactive mode"
                exit 1
                ;;
        esac
    fi
}

main "$@"
