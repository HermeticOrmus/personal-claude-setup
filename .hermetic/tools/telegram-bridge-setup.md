# Claude Code Telegram Bridge Setup

> **Mission**: Control Claude Code from your phone via Telegram
> **Principle**: Correspondence - connecting mobile → cloud → local systems

---

## 🎯 Architecture

```
Your Phone
    ↓ (Telegram message)
Telegram Bot
    ↓ (webhook)
n8n Cloud Workflow
    ↓ (HTTP request)
Local Bridge Server (port 3737)
    ↓ (spawns process)
Claude Code CLI
```

---

## Phase 1: Create Telegram Bot

### Step 1: Talk to BotFather

1. Open **Telegram** app
2. Search for `@BotFather`
3. Send: `/newbot`
4. **Name**: `Claude Code Controller` (display name)
5. **Username**: `hermetic_claude_bot` (must end in 'bot')
6. **Copy the token** - looks like: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`

### Step 2: Get Your Chat ID

1. Send a message to your new bot
2. Go to: `https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates`
3. Find `"chat":{"id":` - copy that number
4. This is your **Chat ID** (will be a large number)

**Save these:**
- ✅ Bot Token
- ✅ Your Chat ID

---

## Phase 2: Expose Local Webhook (Tunnel)

Since n8n Cloud needs to reach your computer, you need a tunnel.

### Option A: Use ngrok (Recommended)

1. **Install ngrok**: https://ngrok.com/download
2. **Sign up** for free account
3. **Authenticate**: `ngrok authtoken YOUR_AUTH_TOKEN`
4. **Start tunnel**:
   ```bash
   ngrok http 3737
   ```
5. **Copy the URL** - looks like: `https://abc123.ngrok.io`

### Option B: Use Cloudflare Tunnel

1. **Install cloudflared**: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/
2. **Start tunnel**:
   ```bash
   cloudflared tunnel --url http://localhost:3737
   ```
3. **Copy the URL** provided

**Save this:**
- ✅ Tunnel URL (e.g., `https://abc123.ngrok.io`)

---

## Phase 3: Configure Security Token

**IMPORTANT**: Change the default security token!

### Edit the startup script:

Open: `C:\Users\ormus\.hermetic\tools\start-claude-bridge.bat`

Change this line to something unique:
```batch
set BRIDGE_TOKEN=YOUR-SECRET-TOKEN-HERE-MAKE-IT-RANDOM
```

**Example**:
```batch
set BRIDGE_TOKEN=hermetic-d74f9c2a-b5e8-4a3d-9f1e-7c8a6b4e2d1a
```

**Save this:**
- ✅ Your BRIDGE_TOKEN

---

## Phase 4: Start the Bridge

### Method 1: Double-click
1. Navigate to: `C:\Users\ormus\.hermetic\tools\`
2. Double-click: `start-claude-bridge.bat`
3. Window stays open = bridge is running

### Method 2: Command line
```bash
cd C:\Users\ormus\.hermetic\tools
node claude-telegram-bridge.js
```

You should see:
```
🔱 Claude Code Telegram Bridge started on port 3737
📡 Listening for commands from n8n
✨ Ready to receive Telegram commands!
```

**Keep this window open** - closing it stops the bridge.

---

## Phase 5: Create n8n Workflow

### Step 1: Log into n8n Cloud

Go to: https://ormus.app.n8n.cloud

### Step 2: Create New Workflow

1. Click **"New workflow"**
2. Name it: `Telegram → Claude Code Bridge`

### Step 3: Add Telegram Trigger

1. **Add node** → Search "Telegram Trigger"
2. **Create Credentials**:
   - Access Token: `YOUR_TELEGRAM_BOT_TOKEN`
   - Click **"Create"**
3. **Updates**: Choose "Message"
4. Click **"Listen for events"** to test
5. Send a message to your bot
6. Should see the message appear in n8n

### Step 4: Add Function Node (Message Parser)

1. **Add node** → Search "Code"
2. **Language**: JavaScript
3. **Code**:

```javascript
// Extract the message text from Telegram
const telegramMessage = $input.item.json.message.text;

// Prepare payload for Claude Code bridge
return {
  json: {
    prompt: telegramMessage,
    token: "YOUR_BRIDGE_TOKEN_HERE",
    source: "telegram",
    timestamp: new Date().toISOString()
  }
};
```

**Replace `YOUR_BRIDGE_TOKEN_HERE`** with your actual token!

### Step 5: Add HTTP Request Node

1. **Add node** → Search "HTTP Request"
2. **Method**: POST
3. **URL**: `YOUR_TUNNEL_URL/execute`
   - Example: `https://abc123.ngrok.io/execute`
4. **Authentication**: None
5. **Body Content Type**: JSON
6. **Specify Body**: Using JSON
7. **JSON**: Leave empty (will use data from previous node)
8. **Options** → Timeout: 30000 (30 seconds)

### Step 6: Add Response Node (Optional - sends confirmation)

1. **Add node** → Search "HTTP Request" again
2. **Method**: POST
3. **URL**: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/sendMessage`
4. **Body Content Type**: JSON
5. **Specify Body**: Using JSON
6. **JSON**:

```json
{
  "chat_id": "YOUR_CHAT_ID",
  "text": "✅ Command received! Claude Code is processing: {{ $('Code').item.json.prompt }}"
}
```

**Replace:**
- `YOUR_BOT_TOKEN` with your Telegram bot token
- `YOUR_CHAT_ID` with your chat ID

### Step 7: Activate Workflow

1. Click **"Active"** toggle (top right)
2. Workflow is now live!

---

## 🧪 Testing

### Test 1: Health Check

```bash
curl http://localhost:3737/health
```

Should return:
```json
{
  "status": "healthy",
  "service": "Claude Code Telegram Bridge"
}
```

### Test 2: Direct Bridge Test

```bash
curl -X POST http://localhost:3737/execute \
  -H "Content-Type: application/json" \
  -d "{\"token\":\"YOUR_BRIDGE_TOKEN\",\"prompt\":\"What is 2+2?\"}"
```

Should trigger Claude Code!

### Test 3: Full Flow

1. **Send message to your Telegram bot**: "What is the capital of France?"
2. **Check n8n workflow**: Should show execution in history
3. **Check bridge logs**: `C:\Users\ormus\.hermetic\tools\claude-bridge.log`
4. **Check results**: Claude Code should execute the query

---

## 📝 Usage Examples

**Simple queries:**
```
What files are in my projects directory?
```

**Code tasks:**
```
Create a Python script that calculates Fibonacci numbers
```

**File operations:**
```
Read the contents of my CLAUDE.md file
```

**Research:**
```
Search the web for the latest AI developments
```

**Complex tasks:**
```
Analyze my GitHub repository and create a project roadmap
```

---

## 🔐 Security Notes

### Important Protections:

1. **Token Authentication**: Bridge requires valid token
2. **No Direct Internet Exposure**: Tunnel handles HTTPS/SSL
3. **Local Execution**: Claude Code runs with your user permissions
4. **Audit Trail**: All commands logged to `claude-bridge.log`

### Best Practices:

- ✅ Use strong, random BRIDGE_TOKEN
- ✅ Don't share your Telegram bot token
- ✅ Keep tunnel URLs private
- ✅ Monitor the log file regularly
- ✅ Stop bridge when not in use

---

## 🐛 Troubleshooting

### Bridge won't start
- Check Node.js is installed: `node --version`
- Check port 3737 isn't in use: `netstat -an | findstr 3737`

### n8n can't reach bridge
- Is tunnel running? Check ngrok/cloudflared window
- Test tunnel URL in browser: `https://YOUR_TUNNEL/health`
- Check firewall settings

### Claude Code doesn't execute
- Check bridge logs: `C:\Users\ormus\.hermetic\tools\claude-bridge.log`
- Verify Claude Code CLI works: `claude -p "test"`
- Check PATH includes Claude Code

### Workflow fails
- Check n8n execution logs
- Verify BRIDGE_TOKEN matches in both places
- Test HTTP request node separately

---

## 🎨 Advanced: Auto-Start on Boot

### Windows Task Scheduler

1. Open **Task Scheduler**
2. **Create Basic Task**
3. **Trigger**: At log on
4. **Action**: Start a program
5. **Program**: `C:\Users\ormus\.hermetic\tools\start-claude-bridge.bat`
6. Save

Now bridge starts automatically when you log in!

---

## 🌟 Hermetic Integration

This bridge embodies:

### Principle of Correspondence
Mobile device ↔ Cloud automation ↔ Local AI = unified system

### Principle of Vibration
Immediate response, constant availability, seamless flow

### Principle of Rhythm
Available when you need it, dormant when you don't

### Gold Hat Philosophy
- **Transparent**: All code visible, auditable
- **Empowering**: Full control over execution
- **Sovereign**: Runs on your infrastructure
- **Secure**: Token-based authentication, local execution

---

## 📚 File Locations

- Bridge script: `C:\Users\ormus\.hermetic\tools\claude-telegram-bridge.js`
- Startup script: `C:\Users\ormus\.hermetic\tools\start-claude-bridge.bat`
- Logs: `C:\Users\ormus\.hermetic\tools\claude-bridge.log`
- This guide: `C:\Users\ormus\.hermetic\tools\telegram-bridge-setup.md`

---

## 🎯 Next Level Enhancements

### Future Ideas:

1. **Voice Commands**: Use Telegram voice notes → speech-to-text → Claude
2. **Image Analysis**: Send photos → Claude analyzes with vision
3. **Scheduled Commands**: n8n cron → automatic daily reports
4. **Multi-User**: Support team members with individual tokens
5. **Response Streaming**: Get partial results back via Telegram
6. **Context Memory**: Maintain conversation state across messages

---

**Built with Sacred Intention**
*Hermetic Ormus - Gold Hat Technology*
