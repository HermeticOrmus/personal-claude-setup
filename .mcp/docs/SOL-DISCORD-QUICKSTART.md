# Sol Discord Bot - Quick Reference

**⚡ Fast reference for common commands and workflows**

---

## 🚀 Instant Start

```bash
# Test connection
@sol-discord-bot send "Hello!" to #general

# Get help
@sol-discord-bot help

# Show capabilities
@sol-discord-bot what can you do?
```

---

## 📋 Common Commands

### Messaging
```bash
# Send message
@sol-discord-bot send [message] to #channel

# Send embed
@sol-discord-bot send rich message to #channel
  Title: [title]
  Description: [description]
  Color: gold

# Add reaction
@sol-discord-bot react to [message] with ✅
```

### Channels
```bash
# Create channel
@sol-discord-bot create channel #name

# Create category
@sol-discord-bot create category "Project Name"

# List channels
@sol-discord-bot list all channels

# Archive channel
@sol-discord-bot archive #old-channel
```

### Project Setup
```bash
# Complete setup
@sol-discord-bot setup project [name]

# Creates:
# • Category
# • 4 channels (#general, #dev, #design, #qa)
# • Forum channel
# • Webhook
# • Welcome message
```

### Automation
```bash
# Daily standup
@sol-discord-bot setup daily standup at 9:00 AM in #general

# Deployment notification
@sol-discord-bot notify #deployments about [deployment details]

# Error alert
@sol-discord-bot alert #incidents about [error]

# Webhook
@sol-discord-bot create webhook in #notifications
```

---

## 🌍 Planetary Delegation

```bash
# Backend (Neptune)
@sol-discord-bot deploy backend to Supabase

# Frontend (Earth)
@sol-discord-bot deploy frontend to Vercel

# Testing (Mars)
@sol-discord-bot run tests and report

# Design (Venus)
@sol-discord-bot create brand guide

# Organization (Saturn)
@sol-discord-bot clean up old channels

# Growth (Jupiter)
@sol-discord-bot analyze community metrics

# AI/ML (Uranus)
@sol-discord-bot generate embeddings for search

# Communication (Mercury)
@sol-discord-bot setup cross-platform bridge
```

---

## 🎯 Real-World Workflows

### New Project
```bash
@sol-discord-bot setup project Phoenix

Result:
✅ Category: 🔥 Project Phoenix
✅ Channels: 4 created
✅ Forum: forum-phoenix-discussions
✅ Webhook: Configured
✅ Welcome: Message sent
```

### Deployment
```bash
@sol-discord-bot deploy to production and notify

Result:
🚀 Deployment initiated
✅ Backend deployed (Neptune)
✅ Frontend deployed (Earth)
✅ Tests passing (Mars)
📢 Notification sent to #deployments
```

### Weekly Status
```bash
@sol-discord-bot generate weekly report

Result:
📊 Comprehensive report
• Deployments
• Development stats
• Growth metrics
• Team activity
• Next week priorities
```

---

## 🔧 Quick Troubleshooting

### Bot not responding?
```bash
# Check MCP connection
/mcp

# Should show: discord (healthy)
```

### Permission error?
```
Server Settings → Integrations → [Bot] → Check permissions
```

### Rate limited?
```
Wait 60 seconds, Sol will auto-retry
```

---

## 📊 Status Emojis

```
✅ Success/Complete
❌ Error/Failed
⚠️ Warning/Issue
🔄 In Progress
⏳ Waiting/Queued
🔍 Investigating
💡 Info/Tip
📊 Metrics/Report
🚀 Deployment
🐛 Bug/Issue
```

---

## 🎓 Pro Tips

**Use threads:** Keep channels clean, discussions in threads

**Use reactions:** Quick acknowledgments without messages

**Schedule wisely:** Respect working hours (9-5)

**Be specific:** Clear commands = faster execution

**Check first:** Use "show" or "list" before "create"

---

## 🔗 Full Documentation

**Complete Guide:** `.mcp/docs/SOL-DISCORD-BOT-GUIDE.md`

**Agent Definition:** `.claude/agents/sol-discord-bot.md`

**Automation Skill:** `.claude/skills/discord-automation.md`

**Discord MCP:** `.mcp/docs/mcps/discord.md`

---

## 💬 Get Help

```bash
# In Discord
@sol-discord-bot help

@sol-discord-bot how do I [task]?

@sol-discord-bot examples for [feature]
```

---

**Status:** Active and Ready
**Version:** 1.0.0
**Updated:** 2025-11-09

*Sol in Discord. Quick. Powerful. Sacred.*
