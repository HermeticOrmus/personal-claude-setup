# Telegram MCP

## Overview
Telegram MCP provides full MTProto API access to your personal Telegram account, enabling automated messaging, chat management, and data retrieval.

## Status
✅ **Active** - Configured and ready

## Configuration
- **API ID**: Configured via `TG_APP_ID`
- **API Hash**: Configured via `TG_API_HASH`
- **Package**: `telegram-mcp` (npm)

## Capabilities

### Messaging
- Send messages to users, groups, channels
- Read message history
- Edit/delete messages
- Forward messages
- Search conversations

### Chat Management
- List chats and channels
- Create/manage groups
- Manage drafts
- Mark as read/unread

### Media
- Download photos, videos, documents, audio
- Send media files
- Handle stickers and GIFs

### User Management
- Search contacts
- Get user information
- Manage blocked users

## Usage Examples

### Send a Message
```
Send a Telegram message to [contact name]: "Hey, checking in on the project status"
```

### Search Messages
```
Search my Telegram chats for messages containing "invoice" from last week
```

### Download Media
```
Download all images from my Telegram chat with [person] from yesterday
```

## Gold Hat Guidelines

### ✅ Ethical Use
- Personal communication automation
- Backup your own messages
- Scheduled reminders to yourself
- Search your own chat history

### ❌ Prohibited
- Spam or bulk unsolicited messages
- Scraping user data without consent
- Automated group spamming
- Impersonation or deception

## Data Storage
- Session data: `C:\Users\ormus\.mcp\data\telegram\`
- Logs: `C:\Users\ormus\.mcp\data\logs\telegram.log`

## Security Notes
- API credentials stored in Claude config
- Session persists between restarts
- All data stored locally
- End-to-end encryption preserved

## Troubleshooting

### "Not authorized" error
Re-authenticate: `npx telegram-mcp sign-in --api-id YOUR_ID --api-hash YOUR_HASH --phone-number YOUR_PHONE`

### "Flood wait" error
Telegram has rate limits. Wait the specified time before retrying.

## Integration Patterns
See: `.mcp/integrations/patterns/telegram-workflows.md`

## Resources
- Telegram API Docs: https://core.telegram.org/api
- MCP Package: https://www.npmjs.com/package/telegram-mcp
