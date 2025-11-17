# WhatsApp MCP

## Overview
WhatsApp MCP provides direct access to your personal WhatsApp account via the official WhatsApp Web multidevice API, enabling message automation while maintaining end-to-end encryption.

## Status
⏳ **Pending** - Requires Go installation

## Configuration
- **Prerequisites**: Go programming language
- **Package**: `whatsapp-mcp-server` (npm)
- **Auth Method**: QR code scan (one-time)

## Installation Steps

1. **Install Go**: Download from https://go.dev/dl/
2. **Restart Terminal**: For PATH to update
3. **Start Claude Desktop**: Will show QR code
4. **Scan QR Code**: WhatsApp → Settings → Linked Devices
5. **Authentication Complete**: Session persists

## Capabilities

### Messaging
- Send messages to individuals
- Send messages to groups
- Read message history
- Edit messages (within 15 min window)
- Delete messages
- Forward messages

### Media Handling
- Download images, videos, documents, audio
- Send media files
- Handle voice messages
- Stickers and GIFs

### Contact Management
- Search contacts
- Get contact information
- Access group members

### Message Search
- Search all conversations locally
- Filter by date, contact, content
- Full-text search capability

## Usage Examples

### Send Message
```
Send a WhatsApp message to [contact]: "Meeting rescheduled to 3pm"
```

### Search Messages
```
Search my WhatsApp messages for "invoice" from last month
```

### Download Media
```
Download all images from WhatsApp chat with [person] from this week
```

### Group Message
```
Send a message to [group name]: "Reminder: team call in 10 minutes"
```

## Gold Hat Guidelines

### ✅ Ethical Use
- Personal communication automation
- Scheduled reminders
- Backup your conversations
- Family/friend coordination
- Business communication (your own)

### ❌ Prohibited Use
- Spam or bulk unsolicited messages
- Commercial blasts (use Business API instead)
- Scraping contact data
- Automated group spam
- Circumventing blocks

### WhatsApp Terms Compliance
- **No commercial use** without Business API
- Respect 24-hour message windows
- Don't automate at scale
- Be transparent when automating
- Honor recipient preferences

## Data Storage

### Local Database
All messages stored locally in SQLite:
```
C:\Users\ormus\.mcp\data\whatsapp\whatsapp.db
```

### Security Features
- End-to-end encryption maintained
- Local storage only (not cloud)
- Claude only accesses when you invoke tools
- You control data retention
- Can delete anytime

## Privacy Notes

### What's Stored
- Message content (encrypted at rest)
- Contact information
- Media metadata
- Session credentials

### What's NOT Shared
- Data never sent to cloud without your action
- Claude doesn't see messages unless you ask
- No analytics or tracking
- No third-party access

## Session Management

### QR Code Authentication
- One-time setup
- Session persists until logged out
- Same as WhatsApp Web linking

### Multiple Devices
- Can link up to 4 devices
- MCP counts as one linked device
- Shows as "Claude MCP" in linked devices

### Logout/Reset
```
Unlink device via: WhatsApp → Settings → Linked Devices → Claude MCP → Log out
```

## Integration Patterns

### Message Bridging
```
WhatsApp → MCP → n8n → Telegram
(Forward important messages cross-platform)
```

### Backup Automation
```
WhatsApp → MCP → Save to Google Drive
(Daily backup of important chats)
```

### Smart Notifications
```
WhatsApp → MCP → Parse → n8n → Filtered alerts
(Only notify for important messages)
```

See: `.mcp/integrations/patterns/whatsapp-workflows.md`

## Troubleshooting

### QR Code Not Showing
- Check Go is installed: `go version`
- Restart Claude Desktop
- Check logs in Claude Desktop

### "Not Connected" Error
- Rescan QR code
- Check WhatsApp on phone is connected to internet
- Verify session hasn't expired

### Messages Not Sending
- Check recipient not blocked
- Verify phone number format
- Ensure you're not rate-limited

## Rate Limits & Best Practices

### WhatsApp Limits
- ~1000 messages per day (varies)
- Max 256 members in groups
- Media size limits (16MB for video)

### Best Practices
1. **Don't spam** - Respect recipients
2. **Rate limit yourself** - Space out messages
3. **Test first** - Verify before bulk sends
4. **Monitor** - Watch for blocking signals
5. **Be transparent** - Tell people it's automated

## Alternative: WhatsApp Business API

For commercial use, consider official Business API:
- Approved by Meta
- Higher limits
- Official support
- Template messages
- Costs money but compliant

## Resources
- WhatsApp Web: https://web.whatsapp.com/
- MCP Package: https://www.npmjs.com/package/whatsapp-mcp-server
- Terms of Service: https://www.whatsapp.com/legal/terms-of-service
- Business API: https://business.whatsapp.com/
