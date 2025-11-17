# MCP Quick Reference Guide

> Fast lookup for common MCP operations and commands

---

## Telegram MCP

### Send Message
```
Send a Telegram message to [contact]: "Your message here"
```

### Search Messages
```
Search my Telegram chats for "keyword" from last week
```

### List Chats
```
Show me my recent Telegram conversations
```

### Download Media
```
Download images from my Telegram chat with [contact] from today
```

---

## Discord MCP

### Send Message
```
Send a Discord message to #channel-name: "Your message"
```

### Create Channel
```
Create a Discord text channel called "new-channel"
```

### Read Messages
```
Get the last 20 messages from #channel-name
```

### Add Reaction
```
Add a 👍 reaction to the latest message in #channel-name
```

### Create Webhook
```
Create a Discord webhook in #notifications called "Updates"
```

---

## n8n MCP

### List Workflows
```
Show me all my n8n workflows
```

### Trigger Workflow
```
Run my "Daily Report" n8n workflow
```

### Create Workflow
```
Create an n8n workflow that:
1. [Trigger description]
2. [Action 1]
3. [Action 2]
```

### Check Execution
```
What's the status of my last n8n workflow execution?
```

---

## WhatsApp MCP

### Send Message
```
Send a WhatsApp message to [contact]: "Your message"
```

### Search Messages
```
Search my WhatsApp for "invoice" from last month
```

### Download Media
```
Download all PDFs from WhatsApp chat with [contact]
```

---

## Puppeteer MCP

### Take Screenshot
```
Take a screenshot of https://example.com
```

### Navigate and Scrape
```
Go to https://example.com and extract all article titles
```

### Fill Form
```
Navigate to https://form.com and fill in:
- Name: John Doe
- Email: john@example.com
Then click Submit
```

---

## GitHub MCP

### List Repos
```
Show me my GitHub repositories
```

### Get PR Details
```
Show me details of PR #123 in my repo-name repository
```

### Create Issue
```
Create a GitHub issue in repo-name:
Title: "Bug in feature X"
Description: "Steps to reproduce..."
```

---

## Cross-MCP Workflows

### Multi-Platform Notification
```
Send this message to both Telegram and Discord: "Meeting in 5 minutes"
```

### Scrape and Share
```
1. Take screenshot of https://example.com/dashboard
2. Send it to my Telegram Saved Messages
3. Also post to #updates on Discord
```

### Archive Conversation
```
1. Get the last 100 messages from Discord #project-chat
2. Save them to a file in C:\Users\ormus\.mcp\data\archives\
```

### Workflow Trigger and Notify
```
1. Trigger my n8n "Generate Report" workflow
2. When complete, send results to my Telegram
```

---

## Configuration Management

### Backup Config
```bash
copy C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json C:\Users\ormus\.mcp\config\backup\
```

### View Active MCPs
```
Show me which MCPs are currently configured
```

### Test MCP Connection
```
Test my Telegram MCP connection
```

---

## Troubleshooting

### MCP Not Responding
1. Check if Claude Desktop is running
2. Restart Claude Desktop
3. Check logs: `C:\Users\ormus\.mcp\data\logs\`

### Authentication Failed
1. Verify credentials in config
2. Check token hasn't expired
3. Regenerate token if needed

### Rate Limited
1. Wait the specified time
2. Reduce request frequency
3. Implement delays in n8n workflows

---

## Common Patterns

### Daily Report
```
Every morning at 9am:
1. Get GitHub notifications
2. Check Telegram messages
3. List Discord @mentions
4. Compile into report
5. Send to my Telegram
```

### Emergency Alert
```
If critical event detected:
1. Send WhatsApp message
2. Send Telegram message
3. Post to Discord with @everyone
4. Create GitHub issue
```

### Content Distribution
```
When I write a blog post:
1. Post link to Discord #announcements
2. Share to Telegram channel
3. Pin in Discord for visibility
```

---

## Gold Hat Reminders

### Before Automating, Ask:
1. ✅ Does this save legitimate time?
2. ✅ Am I transparent about automation?
3. ✅ Do recipients consent/benefit?
4. ✅ Can I explain this proudly?

### Never Automate:
1. ❌ Spam or unsolicited bulk messages
2. ❌ Deceptive or manipulative content
3. ❌ Data harvesting without consent
4. ❌ Circumventing platform limits

---

## Emergency Contacts

### If MCP Misbehaves
1. **Stop it**: Restart Claude Desktop
2. **Disable it**: Remove from config temporarily
3. **Debug it**: Check `.mcp/data/logs/`
4. **Report it**: GitHub issues on MCP repo

### If Credentials Compromised
1. **Revoke immediately** via platform
2. **Remove from config**
3. **Generate new credentials**
4. **Update config**
5. **Review logs for unauthorized use**

---

## Useful Commands

### Check System Status
```bash
# Check if Go installed (for WhatsApp)
go version

# Check Node.js version
node --version

# Check npm version
npm --version
```

### View Logs
```bash
# View latest Telegram logs
type C:\Users\ormus\.mcp\data\logs\telegram.log

# View latest n8n logs
type C:\Users\ormus\.mcp\data\logs\n8n.log
```

### Clean Up
```bash
# Clear old logs (manually review first)
del C:\Users\ormus\.mcp\data\logs\*.log

# Export workflows before cleaning
# (Do this in n8n UI)
```

---

## Learning Resources

### Official Docs
- [MCP Documentation](https://github.com/modelcontextprotocol)
- [n8n Docs](https://docs.n8n.io/)
- [Telegram API](https://core.telegram.org/api)
- [Discord API](https://discord.com/developers/docs)

### Your Docs
- Architecture: `.mcp/docs/architecture/`
- Patterns: `.mcp/integrations/patterns/`
- Examples: `.mcp/docs/examples/`

---

## Template Requests

### Want to do X, not sure how?

**Format your request like this:**
```
I want to: [describe what you want to accomplish]
Currently: [describe current situation]
Goal: [describe desired outcome]
Constraints: [any limitations or requirements]
```

Claude will design a workflow using available MCPs!

---

*Keep this guide updated as you discover new patterns and workflows.*
