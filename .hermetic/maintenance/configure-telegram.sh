#!/usr/bin/env bash
# configure-telegram.sh - Quick Telegram Configuration Script

set -euo pipefail

HERMETIC_ROOT="${HOME}/.hermetic"
CONFIG_FILE="${HERMETIC_ROOT}/maintenance/alerts-config.json"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    HERMETIC_ROOT=$(cygpath -u "$HERMETIC_ROOT" 2>/dev/null || echo "$HERMETIC_ROOT")
fi

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Quick Telegram Configuration${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Get bot token
echo -e "${CYAN}Step 1: Bot Token${NC}"
echo "Paste your Telegram bot token:"
read -r bot_token
echo ""

# Get chat ID
echo -e "${CYAN}Step 2: Chat ID${NC}"
echo "Enter your Telegram chat ID:"
read -r chat_id
echo ""

# Choose severity filter
echo -e "${CYAN}Step 3: Severity Filter${NC}"
echo "Which alerts should trigger Telegram notifications?"
echo "  1. All (INFO, WARNING, CRITICAL)"
echo "  2. WARNING and CRITICAL only (recommended)"
echo "  3. CRITICAL only"
echo ""
read -p "Select option (1-3): " severity_choice

case "$severity_choice" in
    1) severity_filter='["INFO","WARNING","CRITICAL"]' ;;
    2) severity_filter='["WARNING","CRITICAL"]' ;;
    3) severity_filter='["CRITICAL"]' ;;
    *) severity_filter='["WARNING","CRITICAL"]' ;;
esac

echo ""
echo -e "${YELLOW}Configuring...${NC}"

# Update config file
jq ".telegram.enabled = true | .telegram.chatId = \"$chat_id\" | .telegram.severityFilter = $severity_filter" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

# Add to bash profile
BASHRC="${HOME}/.bashrc"
if ! grep -q "TELEGRAM_BOT_TOKEN" "$BASHRC" 2>/dev/null; then
    echo "" >> "$BASHRC"
    echo "# Telegram bot token for Hermetic alerts" >> "$BASHRC"
    echo "export TELEGRAM_BOT_TOKEN='$bot_token'" >> "$BASHRC"
    echo -e "${GREEN}✓ Added TELEGRAM_BOT_TOKEN to ~/.bashrc${NC}"
else
    echo -e "${YELLOW}⚠ TELEGRAM_BOT_TOKEN already in ~/.bashrc (not modified)${NC}"
fi

# Export for current session
export TELEGRAM_BOT_TOKEN="$bot_token"

echo -e "${GREEN}✓ Configuration saved${NC}"
echo ""

# Test the connection
echo -e "${CYAN}Testing Telegram connection...${NC}"

test_response=$(curl -s -X POST \
    "https://api.telegram.org/bot${bot_token}/sendMessage" \
    -d "chat_id=${chat_id}" \
    -d "text=✅ Hermetic Alerts Configured Successfully! You will now receive automation alerts." \
    -d "parse_mode=Markdown" 2>&1)

if echo "$test_response" | jq -e '.ok' > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Test message sent successfully!${NC}"
    echo -e "${GREEN}✓ Check your Telegram for the confirmation message${NC}"
else
    echo -e "${YELLOW}⚠ Test message may have failed${NC}"
    echo "Response: $(echo "$test_response" | jq -r '.description // "Unknown error"')"
fi

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Configuration Complete!${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

echo -e "${CYAN}Current Configuration:${NC}"
echo "  Enabled: $(jq -r '.telegram.enabled' "$CONFIG_FILE")"
echo "  Chat ID: $chat_id"
echo "  Severity Filter: $(jq -r '.telegram.severityFilter | join(", ")' "$CONFIG_FILE")"
echo ""

echo -e "${CYAN}Send Test Alert:${NC}"
echo "  bash hermetic-alerts.sh \"Test from Hermetic\" INFO test"
echo ""
echo -e "${CYAN}For this session:${NC}"
echo "  Environment variable is already set"
echo ""
echo -e "${CYAN}For new sessions:${NC}"
echo "  Run: source ~/.bashrc"
echo "  Or close and reopen your terminal"
echo ""
