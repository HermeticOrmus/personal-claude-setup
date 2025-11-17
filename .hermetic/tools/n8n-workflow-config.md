# n8n Workflow Configuration
## Telegram → Claude Code Bridge

> **Mission**: Control Claude Code from Telegram on your phone
> **Status**: Ready to configure

---

## 📋 Your Credentials

All configured and ready:

| Credential | Value |
|------------|-------|
| **Telegram Bot Token** | `8005622076:AAGwEKcZHWokqyHY8c711D1Rs9r97dbEErs` |
| **Your Chat ID** | `1540112442` |
| **Bridge Security Token** | `hermetic-c516aa513b7fc1295d12a0f310389244` |
| **Tunnel URL** | `https://wrap-trivia-arms-commissioners.trycloudflare.com` |

---

## 🎯 n8n Workflow Setup

### Step 1: Open n8n Cloud

Go to: **https://ormus.app.n8n.cloud**

---

### Step 2: Create New Workflow

1. Click **"New workflow"**
2. **Name**: `Telegram → Claude Code Bridge`
3. Click **"Save"**

---

### Step 3: Add Telegram Trigger Node

1. Click **"+"** to add node
2. Search: **"Telegram Trigger"**
3. Click on it

#### Configure Telegram Trigger:

**Credentials:**
- Click **"Create New Credential"**
- **Access Token**: `8005622076:AAGwEKcZHWokqyHY8c711D1Rs9r97dbEErs`
- Click **"Save"**

**Settings:**
- **Updates**: Select **"Message"**
- Click **"Listen for Test Event"** button
- Send a message to @ormus_claude_bot in Telegram
- Should see the message appear in n8n

---

### Step 4: Add Code Node (Parse Message)

1. Click **"+"** after Telegram Trigger
2. Search: **"Code"**
3. Select **"Code"** node

#### Configure Code Node:

**Settings:**
- **Mode**: Run Once for All Items
- **Language**: JavaScript

**Code to paste:**

```javascript
// Extract message from Telegram
const message = $input.item.json.message;
const text = message.text || '';

// Prepare payload for Claude Code bridge
return {
  json: {
    prompt: text,
    token: "hermetic-c516aa513b7fc1295d12a0f310389244",
    source: "telegram",
    from_user: message.from.first_name,
    timestamp: new Date().toISOString()
  }
};
```

- Click **"Save"**
- **Rename node** (double-click name): `Parse Message`

---

### Step 5: Add HTTP Request Node (Send to Bridge)

1. Click **"+"** after Code node
2. Search: **"HTTP Request"**
3. Select it

#### Configure HTTP Request:

**Authentication:**
- **Authentication**: None

**Request Method:**
- **Method**: POST

**URL:**
- **URL**: `https://wrap-trivia-arms-commissioners.trycloudflare.com/execute`

**Body:**
- **Body Content Type**: JSON
- **Specify Body**: Using JSON
- Leave the JSON field **empty** (it will use data from previous node)

**Options** (click "Add Option"):
- **Timeout**: 30000

- Click **"Save"**
- **Rename node**: `Send to Claude Bridge`

---

### Step 6: Add Response Node (Confirmation)

1. Click **"+"** after HTTP Request
2. Search: **"HTTP Request"** again
3. Select it

#### Configure Response HTTP Request:

**Authentication:**
- **Authentication**: None

**Request Method:**
- **Method**: POST

**URL:**
- **URL**: `https://api.telegram.org/bot8005622076:AAGwEKcZHWokqyHY8c711D1Rs9r97dbEErs/sendMessage`

**Body:**
- **Body Content Type**: JSON
- **Specify Body**: Using JSON
- **JSON**:

```json
{
  "chat_id": "1540112442",
  "text": "✅ Command received!\n\n📋 Processing: {{ $('Parse Message').item.json.prompt }}\n\n⏳ Claude Code is working..."
}
```

- Click **"Save"**
- **Rename node**: `Send Confirmation`

---

### Step 7: Activate Workflow

1. Click the **"Active"** toggle switch (top right)
2. Should turn green/blue
3. Workflow is now **LIVE**!

---

## 🧪 Testing

### Test 1: Simple Query

**Send to @ormus_claude_bot:**
```
What is 2 + 2?
```

**Expected:**
- ✅ n8n workflow executes (check workflow history)
- ✅ You receive confirmation message
- ✅ Claude Code processes query (check bridge logs)

### Test 2: File Operation

**Send to @ormus_claude_bot:**
```
List files in my .hermetic directory
```

### Test 3: Code Generation

**Send to @ormus_claude_bot:**
```
Create a Python function that calculates Fibonacci numbers
```

### Test 4: Complex Task

**Send to @ormus_claude_bot:**
```
Search the web for latest AI news and summarize
```

---

## 📊 Monitoring

### Check Workflow Executions

1. Go to n8n dashboard
2. Click **"Executions"** tab
3. See all your Telegram commands and their status

### Check Bridge Logs

**Location:** `C:\Users\ormus\.hermetic\tools\claude-bridge.log`

```bash
# View logs
type C:\Users\ormus\.hermetic\tools\claude-bridge.log

# Watch logs in real-time (PowerShell)
Get-Content C:\Users\ormus\.hermetic\tools\claude-bridge.log -Wait -Tail 20
```

### Check Claude Code Output

Claude Code runs in print mode (`-p` flag), so output goes to the bridge logs.

---

## 🔧 Troubleshooting

### Telegram not responding

**Check:**
1. Is bot token correct?
2. Did you press "START" in Telegram bot?
3. Is workflow "Active"?

### n8n can't reach bridge

**Check:**
1. Is bridge running?
   - Check background process: `ps | grep node`
2. Is tunnel running?
   - Check background process: `ps | grep cloudflared`
3. Test bridge health: `curl http://localhost:3737/health`
4. Test tunnel: Visit `https://wrap-trivia-arms-commissioners.trycloudflare.com/health` in browser

### Claude Code not executing

**Check:**
1. Bridge logs: `type C:\Users\ormus\.hermetic\tools\claude-bridge.log`
2. Token matches in n8n and bridge
3. Claude Code CLI works: `claude -p "test"`

### Workflow execution fails

**Check:**
1. n8n execution logs (click on failed execution)
2. HTTP Request node shows error details
3. Verify all URLs are correct

---

## 🎨 Advanced Features

### Add Error Handling

After "Send to Claude Bridge" node, add **"Error Trigger"**:

1. Click **"On error"** workflow option
2. Add **"HTTP Request"** node
3. Send error notification to Telegram

### Add Command Prefix

Modify Code node to only process messages starting with `/`:

```javascript
const text = message.text || '';

// Only process commands starting with /
if (!text.startsWith('/')) {
  return { json: { skip: true } };
}

// Remove / prefix
const prompt = text.substring(1);

return {
  json: {
    prompt: prompt,
    token: "hermetic-c516aa513b7fc1295d12a0f310389244",
    // ... rest of config
  }
};
```

### Add Response Forwarding

Create another workflow that:
1. Polls bridge output
2. Sends results back to Telegram
3. Shows Claude's actual response

---

## 🔐 Security Best Practices

✅ **Currently Protected:**
- Bridge requires security token
- Tunnel uses HTTPS
- Token is random and secure
- Logs audit all commands

⚠️ **Additional Protection:**
- Don't share tunnel URL publicly
- Rotate token monthly
- Monitor bridge logs
- Stop services when not in use

---

## 🚀 Running Services

**To start everything:**

1. **Start Bridge:**
   ```bash
   cd C:\Users\ormus\.hermetic\tools
   start-claude-bridge.bat
   ```

2. **Start Tunnel:**
   ```bash
   cloudflared tunnel --url http://localhost:3737
   ```

3. **Activate n8n Workflow:**
   - Go to n8n dashboard
   - Toggle workflow "Active"

**To stop:**
- Close bridge window (or Ctrl+C)
- Close tunnel window (or Ctrl+C)
- Toggle workflow "Inactive" in n8n

---

## 📱 Usage Examples

### Daily Workflows

**Morning routine:**
```
/gnosis Check my calendar and create today's priorities
```

**Research:**
```
Research the latest developments in quantum computing
```

**Code assistance:**
```
Debug the Python script in my projects folder
```

**File management:**
```
Organize files in my Downloads folder
```

### Project Management

```
Analyze my GitHub repos and create a weekly summary
```

```
Create a project roadmap for my new app idea
```

### Learning

```
Explain quantum entanglement in simple terms
```

```
Create a study plan for learning Rust
```

---

## 🌟 Hermetic Integration

This bridge embodies the **Principle of Correspondence**:

```
Phone (Physical)
  ↓
Telegram (Social)
  ↓
n8n Cloud (Orchestration)
  ↓
Tunnel (Connection)
  ↓
Local Bridge (Gateway)
  ↓
Claude Code (Intelligence)
  ↓
Your Computer (Action)
```

Each level mirrors the others - **As above, so below.**

---

**Built with Sacred Intention**
*Hermetic Ormus - Gold Hat Technology*
