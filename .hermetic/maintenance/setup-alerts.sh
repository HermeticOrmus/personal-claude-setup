#!/usr/bin/env bash
# setup-alerts.sh - Interactive Alert System Configuration
# Part of the Hermetic Automation Infrastructure

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
CONFIG_FILE="${HERMETIC_ROOT}/maintenance/alerts-config.json"

# Convert Windows paths if running in Git Bash
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ============================================================================
# TELEGRAM SETUP
# ============================================================================

setup_telegram() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Telegram Alert Setup${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${CYAN}Step 1: Create a Telegram Bot${NC}"
    echo "  1. Open Telegram and search for @BotFather"
    echo "  2. Send: /newbot"
    echo "  3. Follow prompts to name your bot"
    echo "  4. Copy the API token provided"
    echo ""

    read -p "Do you have a bot token? (y/n): " has_token
    if [[ "$has_token" != "y" ]]; then
        echo -e "${YELLOW}Please create a bot first and run this setup again${NC}"
        return
    fi

    read -p "Enter your bot token: " bot_token
    echo ""

    echo -e "${CYAN}Step 2: Get Your Chat ID${NC}"
    echo "  1. Send a message to your bot in Telegram"
    echo "  2. Visit: https://api.telegram.org/bot${bot_token}/getUpdates"
    echo "  3. Look for 'chat':{'id': YOUR_ID}"
    echo "  4. Copy your chat ID (it's a number)"
    echo ""

    read -p "Enter your chat ID: " chat_id
    echo ""

    echo -e "${CYAN}Step 3: Set Bot Token as Environment Variable${NC}"
    echo ""
    echo -e "${YELLOW}Add this to your shell profile (~/.bashrc or ~/.bash_profile):${NC}"
    echo "  export TELEGRAM_BOT_TOKEN='$bot_token'"
    echo ""
    echo "Then run: source ~/.bashrc"
    echo ""

    read -p "Have you set the environment variable? (y/n): " env_set

    # Configure severity filter
    echo ""
    echo -e "${CYAN}Step 4: Configure Severity Filter${NC}"
    echo "Which severity levels should trigger Telegram alerts?"
    echo "  1. All (INFO, WARNING, CRITICAL)"
    echo "  2. WARNING and CRITICAL only"
    echo "  3. CRITICAL only"
    echo ""

    read -p "Select option (1-3): " severity_choice

    local severity_filter
    case "$severity_choice" in
        1) severity_filter='["INFO","WARNING","CRITICAL"]' ;;
        2) severity_filter='["WARNING","CRITICAL"]' ;;
        3) severity_filter='["CRITICAL"]' ;;
        *) severity_filter='["WARNING","CRITICAL"]' ;;
    esac

    # Update config
    jq ".telegram.enabled = true | .telegram.chatId = \"$chat_id\" | .telegram.severityFilter = $severity_filter" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

    echo ""
    echo -e "${GREEN}✓ Telegram configuration saved${NC}"
    echo ""
    echo -e "${CYAN}Test your setup:${NC}"
    echo "  bash hermetic-alerts.sh \"Test message\" INFO test"
    echo ""
}

# ============================================================================
# DISCORD SETUP
# ============================================================================

setup_discord() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Discord Alert Setup${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${CYAN}Step 1: Create a Discord Webhook${NC}"
    echo "  1. Open Discord and go to your server"
    echo "  2. Server Settings → Integrations → Webhooks"
    echo "  3. Click 'New Webhook'"
    echo "  4. Name it 'Hermetic Alerts'"
    echo "  5. Select the channel for alerts"
    echo "  6. Copy the webhook URL"
    echo ""

    read -p "Do you have a webhook URL? (y/n): " has_webhook
    if [[ "$has_webhook" != "y" ]]; then
        echo -e "${YELLOW}Please create a webhook first and run this setup again${NC}"
        return
    fi

    read -p "Enter your webhook URL: " webhook_url
    echo ""

    # Configure severity filter
    echo -e "${CYAN}Step 2: Configure Severity Filter${NC}"
    echo "Which severity levels should trigger Discord alerts?"
    echo "  1. All (INFO, WARNING, CRITICAL)"
    echo "  2. WARNING and CRITICAL only"
    echo "  3. CRITICAL only"
    echo ""

    read -p "Select option (1-3): " severity_choice

    local severity_filter
    case "$severity_choice" in
        1) severity_filter='["INFO","WARNING","CRITICAL"]' ;;
        2) severity_filter='["WARNING","CRITICAL"]' ;;
        3) severity_filter='["CRITICAL"]' ;;
        *) severity_filter='["CRITICAL"]' ;;
    esac

    # Update config
    jq ".discord.enabled = true | .discord.webhookUrl = \"$webhook_url\" | .discord.severityFilter = $severity_filter" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

    echo ""
    echo -e "${GREEN}✓ Discord configuration saved${NC}"
    echo ""
    echo -e "${CYAN}Test your setup:${NC}"
    echo "  bash hermetic-alerts.sh \"Test message\" CRITICAL test"
    echo ""
}

# ============================================================================
# THROTTLING SETUP
# ============================================================================

configure_throttling() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Throttling Configuration${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    echo "Throttling prevents alert fatigue by limiting alert frequency."
    echo ""

    read -p "Enable throttling? (y/n): " enable_throttle
    local throttle_enabled="false"
    [[ "$enable_throttle" == "y" ]] && throttle_enabled="true"

    if [[ "$throttle_enabled" == "true" ]]; then
        echo ""
        read -p "Cooldown period for identical messages (minutes, default: 60): " cooldown
        cooldown=${cooldown:-60}

        read -p "Maximum alerts per hour (default: 10): " max_per_hour
        max_per_hour=${max_per_hour:-10}

        jq ".throttling.enabled = true | .throttling.cooldownMinutes = $cooldown | .throttling.maxAlertsPerHour = $max_per_hour" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
    else
        jq ".throttling.enabled = false" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
    fi

    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

    echo ""
    echo -e "${GREEN}✓ Throttling configuration saved${NC}"
    echo ""
}

# ============================================================================
# STATUS DISPLAY
# ============================================================================

show_current_config() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Current Alert Configuration${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo -e "${YELLOW}No configuration found${NC}"
        return
    fi

    local telegram_enabled=$(jq -r '.telegram.enabled' "$CONFIG_FILE")
    local discord_enabled=$(jq -r '.discord.enabled' "$CONFIG_FILE")
    local throttle_enabled=$(jq -r '.throttling.enabled' "$CONFIG_FILE")

    echo -e "${CYAN}Telegram:${NC}"
    if [[ "$telegram_enabled" == "true" ]]; then
        echo -e "  Status: ${GREEN}Enabled${NC}"
        echo "  Chat ID: $(jq -r '.telegram.chatId' "$CONFIG_FILE")"
        echo "  Severity Filter: $(jq -r '.telegram.severityFilter | join(", ")' "$CONFIG_FILE")"
    else
        echo -e "  Status: ${YELLOW}Disabled${NC}"
    fi
    echo ""

    echo -e "${CYAN}Discord:${NC}"
    if [[ "$discord_enabled" == "true" ]]; then
        echo -e "  Status: ${GREEN}Enabled${NC}"
        echo "  Webhook: Configured"
        echo "  Severity Filter: $(jq -r '.discord.severityFilter | join(", ")' "$CONFIG_FILE")"
    else
        echo -e "  Status: ${YELLOW}Disabled${NC}"
    fi
    echo ""

    echo -e "${CYAN}Throttling:${NC}"
    if [[ "$throttle_enabled" == "true" ]]; then
        echo -e "  Status: ${GREEN}Enabled${NC}"
        echo "  Cooldown: $(jq -r '.throttling.cooldownMinutes' "$CONFIG_FILE") minutes"
        echo "  Max per hour: $(jq -r '.throttling.maxAlertsPerHour' "$CONFIG_FILE")"
    else
        echo -e "  Status: ${YELLOW}Disabled${NC}"
    fi
    echo ""
}

# ============================================================================
# INTERACTIVE MENU
# ============================================================================

show_menu() {
    cat << EOF

═══════════════════════════════════════════════════
  Hermetic Alert System - Setup
═══════════════════════════════════════════════════

1. Setup Telegram alerts
2. Setup Discord alerts
3. Configure throttling
4. View current configuration
5. Test alert system
6. Exit

EOF
}

interactive_mode() {
    while true; do
        show_menu
        read -p "Select option (1-6): " choice

        case "$choice" in
            1) setup_telegram ;;
            2) setup_discord ;;
            3) configure_throttling ;;
            4) show_current_config ;;
            5)
                if [[ -f "${HERMETIC_ROOT}/maintenance/test-alerts.sh" ]]; then
                    bash "${HERMETIC_ROOT}/maintenance/test-alerts.sh" all
                else
                    echo -e "${YELLOW}test-alerts.sh not found${NC}"
                fi
                ;;
            6)
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
    # Ensure config file exists
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo -e "${YELLOW}Creating default configuration...${NC}"
        cat > "$CONFIG_FILE" << 'EOF'
{
  "telegram": {
    "enabled": false,
    "chatId": "",
    "severityFilter": ["WARNING", "CRITICAL"],
    "description": "Telegram alerts via bot API. Set TELEGRAM_BOT_TOKEN env var."
  },
  "discord": {
    "enabled": false,
    "webhookUrl": "",
    "severityFilter": ["CRITICAL"],
    "description": "Discord alerts via webhook."
  },
  "throttling": {
    "enabled": true,
    "cooldownMinutes": 60,
    "maxAlertsPerHour": 10,
    "description": "Prevents alert fatigue. CRITICAL alerts bypass throttling."
  }
}
EOF
    fi

    if [[ $# -eq 0 ]]; then
        interactive_mode
    else
        case "$1" in
            telegram) setup_telegram ;;
            discord) setup_discord ;;
            throttling) configure_throttling ;;
            status) show_current_config ;;
            *)
                echo "Usage: bash setup-alerts.sh [telegram|discord|throttling|status]"
                echo "Run without arguments for interactive mode"
                exit 1
                ;;
        esac
    fi
}

main "$@"
