#!/bin/bash
# Hermetic Troubleshooting & Diagnostic System
# Detect, explain, and fix common issues

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Issue tracking
ISSUES_FOUND=0
ISSUES_FIXED=0
ISSUES_MANUAL=0

# Issue registry
declare -A ISSUES
declare -A FIXES
declare -A EXPLANATIONS

# Diagnostic function
diagnose() {
    local issue_id="$1"
    local check_command="$2"
    local severity="$3"  # critical, warning, info

    if ! eval "$check_command" &>/dev/null; then
        ((ISSUES_FOUND++))

        case "$severity" in
            critical)
                echo -e "  ${RED}✗${NC} CRITICAL: ${ISSUES[$issue_id]}"
                ;;
            warning)
                echo -e "  ${YELLOW}⚠${NC} WARNING: ${ISSUES[$issue_id]}"
                ;;
            info)
                echo -e "  ${CYAN}ℹ${NC} INFO: ${ISSUES[$issue_id]}"
                ;;
        esac

        if [ ! -z "${EXPLANATIONS[$issue_id]}" ]; then
            echo -e "     ${BLUE}Why:${NC} ${EXPLANATIONS[$issue_id]}"
        fi

        return 1
    fi

    return 0
}

# Auto-fix function
auto_fix() {
    local issue_id="$1"
    local fix_command="$2"
    local verify_command="$3"

    echo -e "\n  ${BLUE}→${NC} Attempting to fix: ${ISSUES[$issue_id]}"

    if eval "$fix_command" &>/dev/null; then
        if eval "$verify_command" &>/dev/null; then
            echo -e "  ${GREEN}✓${NC} Fixed successfully!"
            ((ISSUES_FIXED++))
            return 0
        else
            echo -e "  ${YELLOW}⚠${NC} Fix applied but verification failed"
            ((ISSUES_MANUAL++))
            return 1
        fi
    else
        echo -e "  ${RED}✗${NC} Auto-fix failed"
        echo -e "  ${BLUE}Manual fix:${NC} ${FIXES[$issue_id]}"
        ((ISSUES_MANUAL++))
        return 1
    fi
}

# Banner
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}     🔧 HERMETIC TROUBLESHOOTING DIAGNOSTIC 🔧             ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Register all known issues
ISSUES["dir_analytics"]="Analytics directory missing"
EXPLANATIONS["dir_analytics"]="Analytics tracks your usage patterns for insights"
FIXES["dir_analytics"]="mkdir -p '$HERMETIC_HOME/analytics'"

ISSUES["dir_automation"]="Automation directory missing"
EXPLANATIONS["dir_automation"]="Automation provides context detection and shell integration"
FIXES["dir_automation"]="mkdir -p '$HERMETIC_HOME/automation'"

ISSUES["dir_intelligence"]="Intelligence directory missing"
EXPLANATIONS["dir_intelligence"]="Intelligence houses AI-powered pattern recognition"
FIXES["dir_intelligence"]="mkdir -p '$HERMETIC_HOME/intelligence'"

ISSUES["dir_health"]="Health directory missing"
EXPLANATIONS["dir_health"]="Health monitoring prevents burnout and tracks wellbeing"
FIXES["dir_health"]="mkdir -p '$HERMETIC_HOME/health'"

ISSUES["script_usage_tracker"]="usage-tracker.sh not found"
EXPLANATIONS["script_usage_tracker"]="Usage tracker logs all agent/command/skill usage for learning"
FIXES["script_usage_tracker"]="Reinstall from source or restore from backup"

ISSUES["script_context_detector"]="context-detector.sh not found"
EXPLANATIONS["script_context_detector"]="Context detector provides smart suggestions based on your work"
FIXES["script_context_detector"]="Reinstall from source or restore from backup"

ISSUES["script_health_monitor"]="health-monitor.sh not found"
EXPLANATIONS["script_health_monitor"]="Health monitor calculates your wellbeing score and prevents burnout"
FIXES["script_health_monitor"]="Reinstall from source or restore from backup"

ISSUES["script_shell_integration"]="shell-integration.sh not found"
EXPLANATIONS["script_shell_integration"]="Shell integration provides the 'hm' command interface"
FIXES["script_shell_integration"]="Reinstall from source or restore from backup"

ISSUES["exec_usage_tracker"]="usage-tracker.sh not executable"
EXPLANATIONS["exec_usage_tracker"]="Scripts must be executable to run"
FIXES["exec_usage_tracker"]="chmod +x '$HERMETIC_HOME/analytics/usage-tracker.sh'"

ISSUES["exec_context_detector"]="context-detector.sh not executable"
EXPLANATIONS["exec_context_detector"]="Scripts must be executable to run"
FIXES["exec_context_detector"]="chmod +x '$HERMETIC_HOME/automation/context-detector.sh'"

ISSUES["exec_health_monitor"]="health-monitor.sh not executable"
EXPLANATIONS["exec_health_monitor"]="Scripts must be executable to run"
FIXES["exec_health_monitor"]="chmod +x '$HERMETIC_HOME/health/health-monitor.sh'"

ISSUES["shell_not_integrated"]="hm command not available in shell"
EXPLANATIONS["shell_not_integrated"]="Shell integration hasn't been sourced in your shell profile"
FIXES["shell_not_integrated"]="Add to ~/.bashrc or ~/.zshrc: source $HERMETIC_HOME/automation/shell-integration.sh"

ISSUES["python_missing"]="Python 3 not installed"
EXPLANATIONS["python_missing"]="Python 3 is required for intelligence features (pattern recognition, AI insights)"
FIXES["python_missing"]="Install Python 3: sudo apt install python3 (Ubuntu) or brew install python3 (macOS)"

ISSUES["jq_missing"]="jq not installed"
EXPLANATIONS["jq_missing"]="jq is needed for JSON processing in plugin system"
FIXES["jq_missing"]="Install jq: sudo apt install jq (Ubuntu) or brew install jq (macOS)"

ISSUES["git_missing"]="git not installed"
EXPLANATIONS["git_missing"]="Git is needed for version control integration and hooks"
FIXES["git_missing"]="Install git: sudo apt install git (Ubuntu) or brew install git (macOS)"

ISSUES["no_usage_data"]="No usage data logged yet"
EXPLANATIONS["no_usage_data"]="System learns from your usage patterns - start using agents/commands"
FIXES["no_usage_data"]="Run: hm start-day to begin tracking"

ISSUES["no_health_data"]="No health data logged yet"
EXPLANATIONS["no_health_data"]="Health monitoring requires at least one day of usage"
FIXES["no_health_data"]="Run: hm health-checkin to log your first check-in"

ISSUES["hermetic_home_not_set"]="HERMETIC_HOME not set in environment"
EXPLANATIONS["hermetic_home_not_set"]="HERMETIC_HOME should point to ~/.hermetic for proper operation"
FIXES["hermetic_home_not_set"]="Add to ~/.bashrc or ~/.zshrc: export HERMETIC_HOME=\$HOME/.hermetic"

# Diagnostic Section 1: Critical Directory Structure
echo -e "${YELLOW}━━━ Checking Critical Directory Structure ━━━${NC}"

if diagnose "dir_analytics" "[ -d '$HERMETIC_HOME/analytics' ]" "critical"; then
    echo -e "  ${GREEN}✓${NC} Analytics directory exists"
else
    auto_fix "dir_analytics" "mkdir -p '$HERMETIC_HOME/analytics'" "[ -d '$HERMETIC_HOME/analytics' ]"
fi

if diagnose "dir_automation" "[ -d '$HERMETIC_HOME/automation' ]" "critical"; then
    echo -e "  ${GREEN}✓${NC} Automation directory exists"
else
    auto_fix "dir_automation" "mkdir -p '$HERMETIC_HOME/automation'" "[ -d '$HERMETIC_HOME/automation' ]"
fi

if diagnose "dir_intelligence" "[ -d '$HERMETIC_HOME/intelligence' ]" "critical"; then
    echo -e "  ${GREEN}✓${NC} Intelligence directory exists"
else
    auto_fix "dir_intelligence" "mkdir -p '$HERMETIC_HOME/intelligence'" "[ -d '$HERMETIC_HOME/intelligence' ]"
fi

if diagnose "dir_health" "[ -d '$HERMETIC_HOME/health' ]" "critical"; then
    echo -e "  ${GREEN}✓${NC} Health directory exists"
else
    auto_fix "dir_health" "mkdir -p '$HERMETIC_HOME/health'" "[ -d '$HERMETIC_HOME/health' ]"
fi

echo ""

# Diagnostic Section 2: Core Scripts
echo -e "${YELLOW}━━━ Checking Core Scripts ━━━${NC}"

diagnose "script_usage_tracker" "[ -f '$HERMETIC_HOME/analytics/usage-tracker.sh' ]" "critical"
diagnose "script_context_detector" "[ -f '$HERMETIC_HOME/automation/context-detector.sh' ]" "critical"
diagnose "script_health_monitor" "[ -f '$HERMETIC_HOME/health/health-monitor.sh' ]" "critical"
diagnose "script_shell_integration" "[ -f '$HERMETIC_HOME/automation/shell-integration.sh' ]" "critical"

echo ""

# Diagnostic Section 3: File Permissions
echo -e "${YELLOW}━━━ Checking File Permissions ━━━${NC}"

if diagnose "exec_usage_tracker" "[ -x '$HERMETIC_HOME/analytics/usage-tracker.sh' ]" "warning"; then
    echo -e "  ${GREEN}✓${NC} usage-tracker.sh is executable"
else
    auto_fix "exec_usage_tracker" \
        "chmod +x '$HERMETIC_HOME/analytics/usage-tracker.sh'" \
        "[ -x '$HERMETIC_HOME/analytics/usage-tracker.sh' ]"
fi

if diagnose "exec_context_detector" "[ -x '$HERMETIC_HOME/automation/context-detector.sh' ]" "warning"; then
    echo -e "  ${GREEN}✓${NC} context-detector.sh is executable"
else
    auto_fix "exec_context_detector" \
        "chmod +x '$HERMETIC_HOME/automation/context-detector.sh'" \
        "[ -x '$HERMETIC_HOME/automation/context-detector.sh' ]"
fi

if diagnose "exec_health_monitor" "[ -x '$HERMETIC_HOME/health/health-monitor.sh' ]" "warning"; then
    echo -e "  ${GREEN}✓${NC} health-monitor.sh is executable"
else
    auto_fix "exec_health_monitor" \
        "chmod +x '$HERMETIC_HOME/health/health-monitor.sh'" \
        "[ -x '$HERMETIC_HOME/health/health-monitor.sh' ]"
fi

echo ""

# Diagnostic Section 4: Environment & Shell Integration
echo -e "${YELLOW}━━━ Checking Environment & Shell Integration ━━━${NC}"

if diagnose "hermetic_home_not_set" "[ ! -z '$HERMETIC_HOME' ]" "warning"; then
    echo -e "  ${GREEN}✓${NC} HERMETIC_HOME is set: $HERMETIC_HOME"
else
    echo -e "  ${BLUE}Manual fix required:${NC} ${FIXES['hermetic_home_not_set']}"
    ((ISSUES_MANUAL++))
fi

if diagnose "shell_not_integrated" "command -v hm" "warning"; then
    echo -e "  ${GREEN}✓${NC} hm command is available"
else
    echo -e "  ${BLUE}Manual fix required:${NC} ${FIXES['shell_not_integrated']}"
    echo -e "  ${BLUE}Quick fix for current session:${NC} source $HERMETIC_HOME/automation/shell-integration.sh"
    ((ISSUES_MANUAL++))
fi

echo ""

# Diagnostic Section 5: Dependencies
echo -e "${YELLOW}━━━ Checking Dependencies ━━━${NC}"

if diagnose "python_missing" "command -v python3" "warning"; then
    echo -e "  ${GREEN}✓${NC} Python 3 is installed: $(python3 --version 2>&1 | head -1)"
else
    echo -e "  ${BLUE}Manual fix required:${NC} ${FIXES['python_missing']}"
    ((ISSUES_MANUAL++))
fi

if diagnose "jq_missing" "command -v jq" "info"; then
    echo -e "  ${GREEN}✓${NC} jq is installed: $(jq --version 2>&1)"
else
    echo -e "  ${BLUE}Manual fix required:${NC} ${FIXES['jq_missing']}"
    ((ISSUES_MANUAL++))
fi

if diagnose "git_missing" "command -v git" "info"; then
    echo -e "  ${GREEN}✓${NC} git is installed: $(git --version 2>&1 | head -1)"
else
    echo -e "  ${BLUE}Manual fix required:${NC} ${FIXES['git_missing']}"
    ((ISSUES_MANUAL++))
fi

echo ""

# Diagnostic Section 6: Data Integrity
echo -e "${YELLOW}━━━ Checking Data Integrity ━━━${NC}"

if [ -f "$HERMETIC_HOME/analytics/usage.csv" ]; then
    lines=$(wc -l < "$HERMETIC_HOME/analytics/usage.csv" 2>/dev/null || echo 0)
    echo -e "  ${GREEN}✓${NC} Usage data exists ($lines entries)"
else
    diagnose "no_usage_data" "false" "info"
    echo -e "  ${BLUE}Getting started:${NC} ${FIXES['no_usage_data']}"
fi

if [ -f "$HERMETIC_HOME/health/health-history.csv" ]; then
    lines=$(wc -l < "$HERMETIC_HOME/health/health-history.csv" 2>/dev/null || echo 0)
    echo -e "  ${GREEN}✓${NC} Health data exists ($lines entries)"
else
    diagnose "no_health_data" "false" "info"
    echo -e "  ${BLUE}Getting started:${NC} ${FIXES['no_health_data']}"
fi

echo ""

# Diagnostic Section 7: Advanced Features
echo -e "${YELLOW}━━━ Checking Advanced Features ━━━${NC}"

# Check Python scripts
if [ -f "$HERMETIC_HOME/intelligence/pattern-recognition.py" ]; then
    if command -v python3 &>/dev/null; then
        if python3 -m py_compile "$HERMETIC_HOME/intelligence/pattern-recognition.py" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} pattern-recognition.py syntax valid"
        else
            echo -e "  ${YELLOW}⚠${NC} pattern-recognition.py has syntax errors"
            ((ISSUES_FOUND++))
            ((ISSUES_MANUAL++))
        fi
    fi
else
    echo -e "  ${CYAN}ℹ${NC} pattern-recognition.py not installed (optional)"
fi

if [ -f "$HERMETIC_HOME/intelligence/ai-insights.py" ]; then
    if command -v python3 &>/dev/null; then
        if python3 -m py_compile "$HERMETIC_HOME/intelligence/ai-insights.py" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} ai-insights.py syntax valid"
        else
            echo -e "  ${YELLOW}⚠${NC} ai-insights.py has syntax errors"
            ((ISSUES_FOUND++))
            ((ISSUES_MANUAL++))
        fi
    fi
else
    echo -e "  ${CYAN}ℹ${NC} ai-insights.py not installed (optional)"
fi

# Check plugin system
if [ -f "$HERMETIC_HOME/plugins/plugin-manager.sh" ]; then
    echo -e "  ${GREEN}✓${NC} Plugin system installed"

    if [ -f "$HERMETIC_HOME/plugins/.active" ]; then
        active=$(wc -l < "$HERMETIC_HOME/plugins/.active")
        echo -e "     ${BLUE}Active plugins:${NC} $active"
    fi
else
    echo -e "  ${CYAN}ℹ${NC} Plugin system not installed (optional)"
fi

echo ""

# Diagnostic Section 8: Git Integration
echo -e "${YELLOW}━━━ Checking Git Integration ━━━${NC}"

if git rev-parse --git-dir &>/dev/null; then
    echo -e "  ${GREEN}✓${NC} Currently in git repository"

    if [ -f ".git/hooks/pre-commit" ] && grep -q "Hermetic" ".git/hooks/pre-commit" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Hermetic git hooks installed"
    else
        echo -e "  ${YELLOW}⚠${NC} Hermetic git hooks not installed"
        echo -e "     ${BLUE}Install:${NC} $HERMETIC_HOME/integrations/git-hooks-installer.sh install"
    fi
else
    echo -e "  ${CYAN}ℹ${NC} Not in git repository (git integration not applicable)"
fi

echo ""

# Summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}                   DIAGNOSTIC SUMMARY                       ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  Issues Found:      $ISSUES_FOUND"
echo -e "  ${GREEN}Auto-Fixed:${NC}        $ISSUES_FIXED"
echo -e "  ${YELLOW}Manual Fix Needed:${NC} $ISSUES_MANUAL"
echo ""

# Overall health
if [ $ISSUES_FOUND -eq 0 ]; then
    echo -e "${GREEN}✅ SYSTEM HEALTH: EXCELLENT${NC}"
    echo "   No issues detected. System fully operational!"
elif [ $ISSUES_FOUND -eq $ISSUES_FIXED ]; then
    echo -e "${GREEN}✅ SYSTEM HEALTH: RESTORED${NC}"
    echo "   All issues automatically fixed. System operational!"
elif [ $ISSUES_MANUAL -gt 0 ] && [ $((ISSUES_FOUND - ISSUES_MANUAL)) -le 2 ]; then
    echo -e "${YELLOW}⚠️  SYSTEM HEALTH: MINOR ISSUES${NC}"
    echo "   A few manual fixes needed. Review messages above."
else
    echo -e "${RED}❌ SYSTEM HEALTH: ATTENTION NEEDED${NC}"
    echo "   Multiple issues require attention. Review messages above."
fi

echo ""
echo "Next steps:"
echo "  hm selftest              # Run comprehensive system test"
echo "  hm health                # Check current health status"
echo "  hm start-day             # Begin using the system"
echo ""

# Exit code based on issue severity
if [ $ISSUES_FOUND -eq 0 ] || [ $ISSUES_FOUND -eq $ISSUES_FIXED ]; then
    exit 0
else
    exit 1
fi
