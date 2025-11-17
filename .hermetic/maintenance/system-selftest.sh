#!/bin/bash
# Hermetic System Self-Test
# Comprehensive health check and validation

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test results
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_WARNINGS=0

# Test function
test_component() {
    local name="$1"
    local test_command="$2"
    local critical="${3:-false}"

    ((TESTS_RUN++))

    echo -n "  Testing $name... "

    if eval "$test_command" &>/dev/null; then
        echo -e "${GREEN}✓${NC}"
        ((TESTS_PASSED++))
        return 0
    else
        if [ "$critical" = "true" ]; then
            echo -e "${RED}✗ FAILED${NC}"
            ((TESTS_FAILED++))
        else
            echo -e "${YELLOW}⚠ WARNING${NC}"
            ((TESTS_WARNINGS++))
        fi
        return 1
    fi
}

# Banner
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}        🔮 HERMETIC SYSTEM SELF-TEST 🔮                     ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Test 1: Directory Structure
echo -e "${YELLOW}━━━ Testing Directory Structure ━━━${NC}"
test_component "Analytics directory" "[ -d '$HERMETIC_HOME/analytics' ]" true
test_component "Automation directory" "[ -d '$HERMETIC_HOME/automation' ]" true
test_component "Intelligence directory" "[ -d '$HERMETIC_HOME/intelligence' ]" true
test_component "Health directory" "[ -d '$HERMETIC_HOME/health' ]" true
test_component "Docs directory" "[ -d '$HERMETIC_HOME/docs' ]" true
test_component "Plugins directory" "[ -d '$HERMETIC_HOME/plugins' ]" false
test_component "Community directory" "[ -d '$HERMETIC_HOME/community' ]" false
echo ""

# Test 2: Core Scripts
echo -e "${YELLOW}━━━ Testing Core Scripts ━━━${NC}"
test_component "usage-tracker.sh" "[ -f '$HERMETIC_HOME/analytics/usage-tracker.sh' ]" true
test_component "context-detector.sh" "[ -f '$HERMETIC_HOME/automation/context-detector.sh' ]" true
test_component "health-monitor.sh" "[ -f '$HERMETIC_HOME/health/health-monitor.sh' ]" true
test_component "shell-integration.sh" "[ -f '$HERMETIC_HOME/automation/shell-integration.sh' ]" true

# Test executability
test_component "usage-tracker executable" "[ -x '$HERMETIC_HOME/analytics/usage-tracker.sh' ]" true
test_component "context-detector executable" "[ -x '$HERMETIC_HOME/automation/context-detector.sh' ]" true
test_component "health-monitor executable" "[ -x '$HERMETIC_HOME/health/health-monitor.sh' ]" true
echo ""

# Test 3: Python Scripts
echo -e "${YELLOW}━━━ Testing Intelligence Scripts ━━━${NC}"
test_component "Python 3 available" "command -v python3" true
test_component "pattern-recognition.py" "[ -f '$HERMETIC_HOME/intelligence/pattern-recognition.py' ]" false
test_component "ai-insights.py" "[ -f '$HERMETIC_HOME/intelligence/ai-insights.py' ]" false
test_component "dashboard-generator.sh" "[ -f '$HERMETIC_HOME/intelligence/dashboard-generator.sh' ]" false
echo ""

# Test 4: Documentation
echo -e "${YELLOW}━━━ Testing Documentation ━━━${NC}"
test_component "QUICKSTART.md" "[ -f '$HERMETIC_HOME/docs/QUICKSTART.md' ]" true
test_component "SYSTEM-MANIFEST.md" "[ -f '$HERMETIC_HOME/docs/SYSTEM-MANIFEST.md' ]" true
test_component "ACTIVATION-INSTRUCTIONS.md" "[ -f '$HERMETIC_HOME/ACTIVATION-INSTRUCTIONS.md' ]" true
test_component "Manifesto" "[ -f '$HERMETIC_HOME/manifesto.md' ]" true
echo ""

# Test 5: Claude Code Integration
echo -e "${YELLOW}━━━ Testing Claude Code Integration ━━━${NC}"
test_component ".claude directory" "[ -d '$HERMETIC_HOME/../.claude' ]" true
test_component "Agents directory" "[ -d '$HERMETIC_HOME/../.claude/agents' ]" true
test_component "Commands directory" "[ -d '$HERMETIC_HOME/../.claude/commands' ]" true
test_component "Skills directory" "[ -d '$HERMETIC_HOME/../.claude/skills' ]" true

# Count agents, commands, skills
agent_count=$(find "$HERMETIC_HOME/../.claude/agents" -name "*.md" 2>/dev/null | wc -l)
command_count=$(find "$HERMETIC_HOME/../.claude/commands" -name "*.md" 2>/dev/null | wc -l)
skill_count=$(find "$HERMETIC_HOME/../.claude/skills" -name "*.md" 2>/dev/null | wc -l)

test_component "Agent files (expected ~100+)" "[ $agent_count -ge 100 ]" false
test_component "Command files (expected ~18)" "[ $command_count -ge 15 ]" false
test_component "Skill files (expected ~12)" "[ $skill_count -ge 10 ]" false
echo ""

# Test 6: Shell Integration
echo -e "${YELLOW}━━━ Testing Shell Integration ━━━${NC}"
test_component "HERMETIC_HOME set" "[ ! -z '$HERMETIC_HOME' ]" true
test_component "hm command available" "command -v hm" false

if command -v hm &>/dev/null; then
    test_component "hm help works" "hm help &>/dev/null" false
    test_component "hm stats works" "hm stats &>/dev/null" false
else
    echo "  ${YELLOW}Note: hm command not in PATH. Run: source $HERMETIC_HOME/automation/shell-integration.sh${NC}"
fi
echo ""

# Test 7: Data Files
echo -e "${YELLOW}━━━ Testing Data Integrity ━━━${NC}"

if [ -f "$HERMETIC_HOME/analytics/usage.csv" ]; then
    lines=$(wc -l < "$HERMETIC_HOME/analytics/usage.csv")
    test_component "Usage log has data (${lines} lines)" "[ $lines -gt 1 ]" false
else
    echo "  ${YELLOW}⚠${NC} usage.csv not created yet (run hm start-day)"
    ((TESTS_WARNINGS++))
fi

if [ -f "$HERMETIC_HOME/health/health-history.csv" ]; then
    lines=$(wc -l < "$HERMETIC_HOME/health/health-history.csv")
    test_component "Health log has data (${lines} lines)" "[ $lines -gt 1 ]" false
else
    echo "  ${YELLOW}⚠${NC} health-history.csv not created yet (normal for new install)"
    ((TESTS_WARNINGS++))
fi
echo ""

# Test 8: Permissions
echo -e "${YELLOW}━━━ Testing File Permissions ━━━${NC}"

check_perms() {
    local file="$1"
    if [ -f "$file" ] && [ -x "$file" ]; then
        return 0
    else
        return 1
    fi
}

test_component "Scripts are executable" "check_perms '$HERMETIC_HOME/analytics/usage-tracker.sh'" false
echo ""

# Test 9: Dependencies
echo -e "${YELLOW}━━━ Testing Dependencies ━━━${NC}"
test_component "bash available" "command -v bash" true
test_component "git available" "command -v git" false
test_component "python3 available" "command -v python3" false
test_component "jq available" "command -v jq" false
test_component "curl available" "command -v curl" false

if ! command -v jq &>/dev/null; then
    echo "  ${YELLOW}Note: jq needed for plugin system. Install: sudo apt install jq${NC}"
fi
echo ""

# Test 10: Integration Readiness
echo -e "${YELLOW}━━━ Testing Integration Readiness ━━━${NC}"

# Check for git hooks installer
test_component "Git hooks installer" "[ -f '$HERMETIC_HOME/integrations/git-hooks-installer.sh' ]" false

# Check if in a git repo
if git rev-parse --git-dir &>/dev/null; then
    echo "  ${GREEN}✓${NC} Currently in git repository"

    # Check if hooks installed
    if [ -f ".git/hooks/pre-commit" ] && grep -q "Hermetic" ".git/hooks/pre-commit" 2>/dev/null; then
        echo "  ${GREEN}✓${NC} Hermetic git hooks installed in this repo"
    else
        echo "  ${YELLOW}⚠${NC} Hermetic git hooks not installed (run: $HERMETIC_HOME/integrations/git-hooks-installer.sh install)"
    fi
else
    echo "  ${YELLOW}⚠${NC} Not in git repository (git integration not applicable)"
fi
echo ""

# Test 11: Plugin System
echo -e "${YELLOW}━━━ Testing Plugin System ━━━${NC}"
test_component "Plugin manager" "[ -f '$HERMETIC_HOME/plugins/plugin-manager.sh' ]" false
test_component "Plugin README" "[ -f '$HERMETIC_HOME/plugins/README.md' ]" false
test_component "Example plugins" "[ -d '$HERMETIC_HOME/plugins/examples' ]" false

if [ -f "$HERMETIC_HOME/plugins/.active" ]; then
    active_count=$(wc -l < "$HERMETIC_HOME/plugins/.active")
    echo "  ${BLUE}ℹ${NC} Active plugins: $active_count"
fi
echo ""

# Test 12: Advanced Features
echo -e "${YELLOW}━━━ Testing Advanced Features ━━━${NC}"

if [ -f "$HERMETIC_HOME/intelligence/pattern-recognition.py" ]; then
    test_component "Pattern recognition syntax" "python3 -m py_compile '$HERMETIC_HOME/intelligence/pattern-recognition.py'" false
fi

if [ -f "$HERMETIC_HOME/intelligence/ai-insights.py" ]; then
    test_component "AI insights syntax" "python3 -m py_compile '$HERMETIC_HOME/intelligence/ai-insights.py'" false
fi

test_component "Dashboard generator" "[ -x '$HERMETIC_HOME/intelligence/dashboard-generator.sh' ]" false
echo ""

# Summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}                      TEST SUMMARY                          ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  Tests Run:     $TESTS_RUN"
echo -e "  ${GREEN}Passed:${NC}        $TESTS_PASSED"
echo -e "  ${YELLOW}Warnings:${NC}      $TESTS_WARNINGS"
echo -e "  ${RED}Failed:${NC}        $TESTS_FAILED"
echo ""

# Overall status
if [ $TESTS_FAILED -eq 0 ]; then
    if [ $TESTS_WARNINGS -eq 0 ]; then
        echo -e "${GREEN}✅ SYSTEM STATUS: EXCELLENT${NC}"
        echo "   All tests passed! System fully operational."
    else
        echo -e "${YELLOW}⚠️  SYSTEM STATUS: GOOD${NC}"
        echo "   Core functionality working. Some optional features missing."
    fi
else
    echo -e "${RED}❌ SYSTEM STATUS: ISSUES DETECTED${NC}"
    echo "   Critical components missing or non-functional."
    echo "   Run: cat $HERMETIC_HOME/ACTIVATION-INSTRUCTIONS.md"
fi

echo ""
echo "For detailed diagnostics, run:"
echo "  hm health              # Check current health"
echo "  hm context             # Check context detection"
echo "  hm stats               # View usage statistics"
echo ""

# Exit code based on critical failures
if [ $TESTS_FAILED -gt 0 ]; then
    exit 1
else
    exit 0
fi
