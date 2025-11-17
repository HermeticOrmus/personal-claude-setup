# MCP Startup Checklist

> Quick guide for verifying all MCPs are working after restart

---

## 🔄 Current Task: First Restart After Setup

### Why Restart?
Go was just installed and the terminal needs to reload the PATH environment variable.

---

## ✅ After Restarting Claude Desktop

### 1. Verify Go Installation
```
Ask Claude: "Check if Go is installed with: go version"
```

**Expected**: Should show Go version (e.g., `go version go1.23.x`)

---

### 2. Authenticate WhatsApp (First Time Only)

**What will happen:**
When you first try to use WhatsApp MCP, it will show a QR code.

**How to authenticate:**
1. Open **WhatsApp on your phone**
2. Go to **Settings → Linked Devices**
3. Tap **"Link a Device"**
4. **Scan the QR code** that appears
5. ✅ Done! Session persists forever (until you unlink)

**Test command:**
```
Ask Claude: "Connect to my WhatsApp and show me my recent chats"
```

---

### 3. Test All MCPs

#### Telegram
```
List my recent Telegram conversations
```
**Expected**: Shows your Telegram chats

#### Discord
```
List the channels in my Discord server
```
**Expected**: Shows Discord channels

#### n8n
```
Show me my n8n workflows
```
**Expected**: Lists your workflows from https://ormus.app.n8n.cloud

#### Puppeteer
```
Take a screenshot of https://example.com
```
**Expected**: Returns screenshot of the website

#### GitHub
```
List my GitHub repositories
```
**Expected**: Shows your repos

#### Filesystem
```
List files in C:\Users\ormus\.mcp\
```
**Expected**: Shows MCP directory contents

#### Memory
```
Store this in memory: My name is Ormus and I practice Sacred Technology
```
**Expected**: Confirms storage in knowledge graph

---

## 🎉 Success Criteria

All MCPs tested ✅
- [ ] Telegram responding
- [ ] Discord responding
- [ ] WhatsApp authenticated and responding
- [ ] n8n showing workflows
- [ ] Puppeteer taking screenshots
- [ ] GitHub showing repos
- [ ] Filesystem reading files
- [ ] Memory storing data

---

## 🚨 If Something Doesn't Work

### MCP Not Responding
1. Check configuration: `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`
2. Look for typos in tokens/credentials
3. Restart Claude Desktop again
4. Check logs: `C:\Users\ormus\.mcp\data\logs\`

### WhatsApp QR Code Not Showing
1. Verify Go is installed: `go version`
2. Check WhatsApp MCP is in config
3. Restart Claude Desktop
4. Try test command again

### Rate Limits / API Errors
- Normal for first use (lots of connections)
- Wait a few seconds between tests
- Some APIs have hourly limits

---

## 📊 MCP Status Dashboard

After testing, document status here:

| MCP | Status | Last Tested | Notes |
|-----|--------|-------------|-------|
| Telegram | ⏳ | Pending | Awaiting first test |
| Discord | ⏳ | Pending | Awaiting first test |
| WhatsApp | ⏳ | Pending | Need QR auth first |
| n8n | ⏳ | Pending | Awaiting first test |
| Puppeteer | ⏳ | Pending | Awaiting first test |
| GitHub | ⏳ | Pending | Awaiting first test |
| Filesystem | ⏳ | Pending | Awaiting first test |
| Memory | ⏳ | Pending | Awaiting first test |

Update this table after testing!

---

## 🎯 Next Steps After All Tests Pass

1. **Explore** `.mcp/docs/guides/quick-reference.md` for commands
2. **Read** `.mcp/integrations/patterns/cross-platform-messaging.md` for workflows
3. **Design** your first automation using n8n
4. **Document** your workflows in `.mcp/workflows/`
5. **Build** with Gold Hat principles in mind

---

## 🏆 Gold Hat Reminder

Now that you have powerful automation tools:

**Ask before every automation:**
> "Does this serve human flourishing, or exploit it?"

**The Litmus Test:**
> "Would I proudly explain this to everyone affected by it?"

---

## 📚 Quick Links

- **Quick Reference**: `.mcp/docs/guides/quick-reference.md`
- **Architecture**: `.mcp/docs/architecture/mcp-ecosystem-overview.md`
- **Integration Patterns**: `.mcp/integrations/patterns/cross-platform-messaging.md`
- **MCP Docs**: `.mcp/docs/mcps/`

---

**Ready? Restart Claude Desktop and let's test everything!**
