# Discord MCP

## Overview
Discord MCP enables bot-based automation of Discord servers, including message management, channel operations, and webhook integration.

## Status
✅ **Active** - Bot configured and authorized

## Configuration
- **Bot Token**: Configured via `DISCORD_BOT_TOKEN`
- **Package**: `mcp-discord` (npm)
- **Bot Name**: Claude Automation Bot

## Capabilities

### Messaging
- Send messages to channels
- Read message history
- Edit/delete messages (if bot authored)
- Add/remove reactions
- Send embeds and rich content

### Channel Management
- Create/delete text channels
- Manage channel permissions
- Get channel information
- List channels in server

### Forum Management
- List forum channels
- Create/delete/reply to forum posts
- Manage forum threads

### Webhooks
- Create/edit/delete webhooks
- Execute webhooks
- Manage webhook settings

### Server Information
- Get server details
- List members (with proper intents)
- Get role information

## Bot Permissions

### Current Permissions
- Read Messages/View Channels
- Send Messages
- Manage Messages
- Read Message History
- Add Reactions
- Manage Channels
- Manage Webhooks

### Gateway Intents Enabled
- Server Members Intent
- Message Content Intent
- Presence Intent

## Usage Examples

### Send Message
```
Send a Discord message to #general channel: "Daily standup starting in 5 minutes!"
```

### Create Channel
```
Create a new Discord text channel called "project-alpha" in my server
```

### Setup Webhook
```
Create a Discord webhook in #notifications for automated updates
```

### Read Messages
```
Get the last 10 messages from #feedback channel
```

## Gold Hat Guidelines

### ✅ Ethical Use
- Community management
- Automated notifications (non-spammy)
- Event coordination
- Moderation assistance
- Transparent bot behavior

### ❌ Prohibited
- Spam or raid other servers
- Scrape user data without consent
- Impersonate users
- Mass DM advertising
- Token manipulation

## Data Storage
- Cache: `C:\Users\ormus\.mcp\data\discord\cache\`
- Logs: `C:\Users\ormus\.mcp\data\logs\discord.log`

## Security Notes
- Bot token stored in Claude config
- Bot has limited permissions by design
- Cannot access DMs (not a user account)
- Rate limits enforced by Discord API

## Bot Management

### Invite Bot to New Server
1. Go to Discord Developer Portal
2. OAuth2 → URL Generator
3. Check "bot" scope
4. Select permissions
5. Copy and open generated URL

### Revoke Access
Remove bot from server via Server Settings → Integrations

## Integration Patterns
- Discord → n8n → Other platforms
- Automated notifications from workflows
- Cross-platform chat bridges

See: `.mcp/integrations/patterns/discord-workflows.md`

## Resources
- Discord API Docs: https://discord.com/developers/docs
- MCP Package: https://www.npmjs.com/package/mcp-discord
- Developer Portal: https://discord.com/developers/applications
