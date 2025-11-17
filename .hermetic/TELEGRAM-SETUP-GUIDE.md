# Telegram Alerts Setup Guide

## 🚀 Quick Setup (5 minutes)

### Step 1: Create Your Bot in Telegram

1. **Open Telegram** on your phone or desktop
2. **Search for** `@BotFather` (official Telegram bot for creating bots)
3. **Send this command**: `/newbot`
4. **Answer the questions**:
   - **Name**: "Hermetic Alerts" (or any name you like)
   - **Username**: Must end in 'bot', e.g., `hermetic_alerts_bot`

5. **BotFather will reply with your token**:
   ```
   Done! Congratulations on your new bot. You will find it at t.me/hermetic_alerts_bot

   Use this token to access the HTTP API:
   123456789:ABCdefGHIjklMNOpqrsTUVwxyz1234567890
   ```

✅ **Copy this token** - you'll need it in Step 3

---

### Step 2: Get Your Chat ID

**Method 1: Quick Web Method**

1. **Send any message** to your new bot in Telegram (click the link BotFather gave you)
2. **Open this URL** in your browser (replace `YOUR_BOT_TOKEN` with your actual token):
   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
   ```
   Example:
   ```
   https://api.telegram.org/bot123456789:ABCdefGHIjklMNOpqrsTUVwxyz1234567890/getUpdates
   ```

3. **Look for** `"chat":{"id":` in the JSON response
   ```json
   {
     "ok": true,
     "result": [{
       "message": {
         "chat": {
           "id": 987654321,  ← This is your Chat ID
           "first_name": "Your Name"
         }
       }
     }]
   }
   ```

4. **Copy the number** after `"id":` - that's your Chat ID

**Method 2: Using a Bot**

1. Search for `@userinfobot` in Telegram
2. Send it `/start`
3. It will reply with your User ID (same as Chat ID)

✅ **Note down your Chat ID** - you'll need it in Step 3

---

### Step 3: Run the Configuration Script

Now that you have both credentials, run:

```bash
cd ~/.hermetic/maintenance
bash configure-telegram.sh
```

**The script will ask for**:
1. Your bot token
2. Your chat ID
3. Which severity levels to send (recommended: WARNING and CRITICAL only)

**The script will**:
- Save your configuration
- Add TELEGRAM_BOT_TOKEN to your environment
- Send a test message to verify it works

---

## 📱 What You'll Get

Once configured, you'll receive Telegram messages for:

- **INFO**: Routine notifications (backups complete, services started)
- **WARNING**: Issues that need attention (degraded MCP servers, high disk usage)
- **CRITICAL**: Urgent problems (backup failures, system down)

### Example Alert Messages

**INFO Alert**:
```
ℹ️ *INFO*

Backup completed successfully in 1s
```

**WARNING Alert**:
```
⚠️ *WARNING*

MCP github is DEGRADED: Response time high: 2500ms
```

**CRITICAL Alert**:
```
🚨 *CRITICAL*

MCP telegram is DOWN: Connection refused
```

---

## 🛡️ Security Notes

### Your Bot Token is Sensitive
- **Treat it like a password** - don't share it publicly
- **It's stored in** `~/.bashrc` as an environment variable
- **Only your bot** can send messages, others can't use your token to spam you

### Your Chat ID is Private
- **Only you have this number**
- **Only your bot** can send messages to this chat ID
- **Others can't message you** through your bot without your chat ID

---

## 🎯 Severity Filter Recommendations

### Option 1: All Alerts (High Volume)
```
Severity Filter: INFO, WARNING, CRITICAL
```
**Good for**: Initial testing, wanting full visibility
**Expect**: Many messages (10+ per day)

### Option 2: Important Only (Recommended)
```
Severity Filter: WARNING, CRITICAL
```
**Good for**: Production use, balanced notifications
**Expect**: Few messages (2-5 per day only when issues occur)

### Option 3: Critical Only (Minimal)
```
Severity Filter: CRITICAL
```
**Good for**: Only urgent problems, minimal distraction
**Expect**: Rare messages (only when something is seriously wrong)

---

## ✅ Testing Your Setup

After configuration, test with:

```bash
# Send test INFO message
bash hermetic-alerts.sh "Test: Everything is working!" INFO test

# Send test WARNING
bash hermetic-alerts.sh "Test: This is a warning" WARNING test

# Send test CRITICAL
bash hermetic-alerts.sh "Test: This is critical" CRITICAL test
```

Check your Telegram - you should receive the messages based on your severity filter.

---

## 🔧 Troubleshooting

### "Test message failed"

**Check your bot token**:
```bash
echo $TELEGRAM_BOT_TOKEN
```
Should show your token. If empty:
```bash
source ~/.bashrc
```

**Verify token is correct**:
Visit: `https://api.telegram.org/botYOUR_TOKEN/getMe`
Should return bot info.

### "Chat ID not found"

**Make sure you**:
1. Sent at least one message to your bot first
2. Used the correct URL with your token
3. Copied the number exactly (no quotes or brackets)

### "No alerts received"

**Check severity filter**:
```bash
cat ~/.hermetic/maintenance/alerts-config.json | jq '.telegram'
```

If you sent INFO but filter is `["WARNING","CRITICAL"]`, INFO won't be sent.

**Send a message that matches your filter**:
```bash
# If your filter includes WARNING
bash hermetic-alerts.sh "Test warning" WARNING test
```

---

## 📊 Alert Throttling

The system has smart throttling to prevent alert fatigue:

- **Cooldown**: Same message won't repeat within 60 minutes
- **Rate Limit**: Maximum 10 alerts per hour
- **CRITICAL Bypass**: CRITICAL alerts bypass throttling

This means:
- You won't get spammed
- Important alerts always get through
- System respects your attention

---

## 🎨 Customization

### Change Severity Filter

Edit: `~/.hermetic/maintenance/alerts-config.json`

```json
{
  "telegram": {
    "enabled": true,
    "chatId": "987654321",
    "severityFilter": ["CRITICAL"],  ← Change this
    "description": "..."
  }
}
```

Options: `["INFO"]`, `["WARNING"]`, `["CRITICAL"]` or any combination

### Change Throttling Settings

```json
{
  "throttling": {
    "enabled": true,
    "cooldownMinutes": 60,     ← Change cooldown
    "maxAlertsPerHour": 10,    ← Change rate limit
    "description": "..."
  }
}
```

### Disable Telegram (Keep Configuration)

```json
{
  "telegram": {
    "enabled": false,  ← Change to false
    ...
  }
}
```

---

## 🌟 Integration with Automation

Once configured, all automation systems will send Telegram alerts:

✅ **Backup System**: Success/failure notifications
✅ **MCP Monitoring**: Server health alerts
✅ **Session Archival**: Completion notifications
✅ **n8n Sync**: Sync status updates
✅ **Dashboard**: Service start/stop notifications

**Example Real Alerts**:
```
🚨 Backup failed with exit code 1

⚠️ MCP overall health: 66% (6/9 healthy)

ℹ️ Session archival: 5 sessions archived

ℹ️ Automation services started: 2 running
```

---

## 📞 Need Help?

**View current configuration**:
```bash
cat ~/.hermetic/maintenance/alerts-config.json | jq '.telegram'
```

**View alert history**:
```bash
bash view-alerts.sh recent 20
```

**Test the alert system**:
```bash
bash test-alerts.sh all
```

---

## 🎉 You're All Set!

Once configured, you'll have:
- ✅ Real-time alerts on your phone
- ✅ Smart throttling to prevent spam
- ✅ Configurable severity levels
- ✅ Full integration with all automation systems

**Start receiving alerts immediately** - the system is already running and will notify you when things happen!

---

**Built with Sacred Technology principles**
**Respects your attention through smart throttling**

**— Hermetic Ormus**
