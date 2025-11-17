# Discord Bot Invite Guide - Get Sol Online

**Issue:** Bot configured in Claude Code but not visible in Discord server

**Solution:** Invite the bot to your Discord server

---

## 🔍 Quick Diagnosis

**You have:**
- ✅ Discord MCP configured in `.claude.json`
- ✅ Bot token: `MTQzMDIyMjQyNzQ3NTkzOTQ5NA...`
- ✅ Sol Discord Bot agent ready

**You need:**
- ⚠️ Bot invited to your Discord server
- ⚠️ Bot application in Discord Developer Portal

---

## 🚀 Step-by-Step Invitation

### Step 1: Access Discord Developer Portal

1. Open browser and go to: https://discord.com/developers/applications

2. Log in with your Discord account

3. You should see your application (might be named "Claude Automation Bot" or similar)

**If you see NO applications:**
- The bot token might be from someone else's bot
- You need to create a new bot application (see "Create New Bot" section below)

---

### Step 2: Get Your Bot Invite URL

**Option A: Use the Portal (Recommended)**

1. Click on your application
2. Go to **OAuth2** → **URL Generator** (left sidebar)
3. Under **SCOPES**, check:
   - ✅ `bot`
   - ✅ `applications.commands` (optional, for slash commands)

4. Under **BOT PERMISSIONS**, check:
   - ✅ View Channels
   - ✅ Send Messages
   - ✅ Send Messages in Threads
   - ✅ Embed Links
   - ✅ Attach Files
   - ✅ Read Message History
   - ✅ Add Reactions
   - ✅ Use External Emojis
   - ✅ Manage Messages (optional, for cleanup)
   - ✅ Manage Channels (optional, for creation)
   - ✅ Manage Webhooks (optional, for automation)

5. Copy the **GENERATED URL** at the bottom

**Option B: Manual URL Construction**

Replace `YOUR_CLIENT_ID` with your bot's Client ID (from OAuth2 → General):

```
https://discord.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&permissions=8&scope=bot
```

**Note:** `permissions=8` gives Administrator (use for testing, refine later)

---

### Step 3: Invite Bot to Your Server

1. Open the URL you copied (in same browser where you're logged into Discord)

2. You'll see "Add Bot to Server" page

3. Select your Discord server from dropdown

4. Click **Continue**

5. Review permissions

6. Click **Authorize**

7. Complete any CAPTCHA if shown

**Result:** Bot should now appear in your server's member list (right sidebar)

---

### Step 4: Verify Bot is Online

**In Discord:**
1. Look at right sidebar (member list)
2. Find your bot (might be named "Claude Automation Bot" or similar)
3. Check status:
   - 🟢 **Green dot** = Online ✅
   - ⚪ **Gray dot** = Offline ⚠️

**If Offline:**
The Discord MCP in Claude Code doesn't keep the bot "online" 24/7. The bot only appears online when:
- You're actively using Claude Code
- A command is being executed
- MCP connection is active

**This is normal for MCP-based bots.**

---

### Step 5: Test the Bot

**In Claude Code terminal:**

```bash
# Test 1: List servers (verifies MCP connection)
mcp__discord__get_server_info

# Test 2: Send a message
mcp__discord__discord_send_message {
  "channelId": "YOUR_CHANNEL_ID",
  "message": "Hello from Sol! 🌞"
}
```

**To get your channel ID:**
1. In Discord, enable Developer Mode:
   - Settings → Advanced → Developer Mode (toggle ON)
2. Right-click any channel
3. Click "Copy Channel ID"
4. Use that ID in the command above

---

## 🆕 Create New Bot (If Needed)

**If you don't have a bot application, create one:**

### 1. Create Application

1. Go to: https://discord.com/developers/applications
2. Click **New Application** (top right)
3. Name it: `Sol Discord Bot` (or any name)
4. Click **Create**

### 2. Create Bot

1. In your application, go to **Bot** (left sidebar)
2. Click **Add Bot**
3. Confirm: **Yes, do it!**
4. Configure bot:
   - Username: `Sol` or `Sol Bot`
   - Icon: Upload a sun icon ☀️ (optional)

### 3. Get Bot Token

1. Under **TOKEN**, click **Reset Token**
2. Confirm
3. Copy the new token (looks like: `MTQzMDIy...`)
4. **SAVE THIS TOKEN SECURELY**

### 4. Enable Intents

Scroll down to **Privileged Gateway Intents**, enable:
- ✅ Presence Intent
- ✅ Server Members Intent
- ✅ Message Content Intent

Click **Save Changes**

### 5. Update Your Configuration

Replace the token in `~/.claude.json`:

```json
{
  "mcpServers": {
    "discord": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "mcp-discord"],
      "env": {
        "DISCORD_BOT_TOKEN": "YOUR_NEW_TOKEN_HERE"
      }
    }
  }
}
```

**Restart Claude Code** for the new token to take effect.

### 6. Invite Your New Bot

Follow **Step 2** and **Step 3** above with your new bot.

---

## 🧪 Testing Checklist

Once bot is invited:

```bash
# In Claude Code

# Test 1: Basic MCP connection
Test the Discord MCP connection

# Test 2: Get server info
Get information about my Discord server

# Test 3: Send test message
Send a test message to #general in Discord saying "Sol is online!"

# Test 4: Create channel
Create a test channel called #sol-test

# Test 5: Full agent invocation
@sol-discord-bot introduce yourself to #general
```

---

## 🔧 Troubleshooting

### Bot Still Not Showing?

**Check 1: Correct Server**
- Make sure you selected the RIGHT server when inviting
- Bot only appears in servers where it was invited

**Check 2: Bot Token Valid**
- In Developer Portal → Bot → Token
- If it says "Invalid", reset the token
- Update `.claude.json` with new token
- Restart Claude Code

**Check 3: Permissions**
- In Discord Server Settings → Roles
- Find bot's role
- Check permissions are enabled
- Bot role should be above @everyone

**Check 4: MCP Connection**
In Claude Code:
```bash
/mcp
```
Should show: `discord` server as "healthy"

If not, restart Claude Code.

### Bot Appears Offline?

**This is normal for MCP-based bots.**

The bot doesn't run 24/7 like traditional bots. It activates when:
- You execute a Discord command in Claude Code
- An MCP tool is called
- An automation workflow triggers

**The bot will:**
- Appear offline when idle
- Come online when processing commands
- Go offline again after completing tasks

**This is by design** - it's an on-demand bot, not a persistent bot.

---

## 🎯 Expected Behavior

**After successful invite:**

1. **Bot appears in member list** ✅
2. **Bot might show offline** ⚪ (normal)
3. **Bot activates when you use it** 🟢
4. **Commands execute successfully** ✅

**When you use `@sol-discord-bot` in Claude Code:**
- MCP connection activates
- Bot processes request
- Message appears in Discord
- Bot goes back to idle

---

## 📝 Quick Command Reference

**After bot is invited, try these:**

```bash
# In Claude Code terminal

# Basic test
@sol-discord-bot send "Hello!" to #general

# Project setup
@sol-discord-bot setup project Test

# Get help
@sol-discord-bot what are your capabilities?
```

---

## 🔗 Useful Links

- **Developer Portal:** https://discord.com/developers/applications
- **Bot Permissions Calculator:** https://discordapi.com/permissions.html
- **Discord API Docs:** https://discord.com/developers/docs
- **MCP Discord Package:** https://www.npmjs.com/package/mcp-discord

---

## 💡 Pro Tips

**Bot Name:**
You can rename the bot in Discord:
- Server Settings → Members → Right-click bot → Change Nickname

**Bot Role:**
Create a dedicated role for the bot:
- Server Settings → Roles → Create Role: "Sol Bot"
- Assign to bot
- Gives better permission control

**Testing Channel:**
Create #sol-test for testing commands without disrupting other channels.

**Rate Limits:**
Discord limits: 50 requests/second
Sol automatically handles this with queuing.

---

## ✅ Success Checklist

- [ ] Discord Developer Portal accessed
- [ ] Bot application found (or created)
- [ ] Bot invite URL generated
- [ ] Bot invited to server
- [ ] Bot appears in member list
- [ ] MCP connection tested (`/mcp` shows healthy)
- [ ] First test message sent successfully
- [ ] Bot responds to commands

---

## 🆘 Still Having Issues?

If bot still doesn't appear after following all steps:

1. **Verify you're logged into correct Discord account**
   - The one with the server you want to add bot to

2. **Check server ownership/permissions**
   - You need "Manage Server" permission to add bots
   - If you're not admin, ask server owner to invite bot

3. **Try browser incognito mode**
   - Sometimes cached credentials cause issues
   - Open Developer Portal in incognito
   - Re-generate invite URL

4. **Check Discord API status**
   - Visit: https://discordstatus.com
   - If Discord API is down, wait and retry

5. **Create fresh bot application**
   - Sometimes tokens get corrupted
   - Create new application from scratch
   - Generate new token
   - Update configuration

---

**Status:** Troubleshooting Guide Complete
**Next:** Invite bot and test first command

*Once bot is in your server, all the Sol automation will work perfectly. This is just the connection step.*

**— Hermetic Ormus** 🔧
