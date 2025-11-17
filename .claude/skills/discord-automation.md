---
name: discord-automation
description: Automate Discord server operations including channel management, message orchestration, webhook setup, and community coordination. Uses Discord MCP for all operations.
triggers:
  - discord
  - bot
  - channel
  - webhook
  - community
  - notification
  - announcement
---

# Discord Automation Skill

**Purpose:** Expert-level Discord server automation via MCP
**When:** Any Discord server operation or community management task
**Tools:** Discord MCP tools (`mcp__discord__*`)

---

## Core Capabilities

### 1. Message Management
- Send messages with rich embeds
- Schedule announcements
- Bulk message operations
- Reaction-based interactions
- Message threading

### 2. Channel Operations
- Create channel hierarchies
- Setup permissions
- Organize categories
- Archive inactive channels
- Clone channel structures

### 3. Automation Setup
- Configure webhooks
- Create notification flows
- Setup scheduled messages
- Implement reaction roles
- Build moderation automation

### 4. Community Coordination
- Standup reminders
- Event announcements
- Status updates
- Error alerts
- Project coordination

---

## Workflow Patterns

### Pattern 1: Project Channel Setup

When user requests: "Create Discord channels for Project X"

**Execute:**
```
1. Create category: "Project X"
2. Create channels:
   - #x-general (public discussion)
   - #x-dev (development work)
   - #x-design (design collaboration)
   - forum-x-discussions (forum channel)
3. Setup permissions:
   - Team members: read/write access
   - Guests: read-only to #x-general
4. Create webhook in #x-general:
   - For automated notifications
   - Returns webhook URL for integrations
5. Send welcome message:
   - Project overview
   - Channel purposes
   - Links to resources
```

**MCP Tools Used:**
- `mcp__discord__create_channel` (4x)
- `mcp__discord__create_webhook` (1x)
- `mcp__discord__send_message` (1x)

---

### Pattern 2: Deployment Notification

When deployment completes:

**Execute:**
```
1. Get deployment info:
   - Version number
   - Changes included
   - Deployed by
   - Timestamp
   - Status (success/failure)

2. Create rich embed:
   - Title: "🚀 Deployment Complete"
   - Color: Green (success) / Red (failure)
   - Fields:
     • Version: v1.2.3
     • Environment: Production
     • Changes: [commit messages]
     • Deployed by: @username
     • Time: 2025-11-09 14:30 UTC
   - Footer: "Automated by Sol"

3. Send to #deployments channel

4. Add reaction: ✅ (success) or ⚠️ (issues)

5. Create follow-up thread if failure:
   - Auto-create incident thread
   - Tag relevant team members
   - Provide rollback instructions
```

**MCP Tools Used:**
- `mcp__discord__send_message` (with embed)
- `mcp__discord__add_reaction`
- `mcp__discord__create_forum_post` (if failure)

---

### Pattern 3: Daily Standup Automation

Scheduled: 9:00 AM daily

**Execute:**
```
1. Send standup message to #general:
   "☀️ Good morning! Daily standup time.

   Please share:
   ✅ Yesterday's achievements
   🎯 Today's goals
   ⚠️ Blockers or challenges

   React with 👍 when done!"

2. Create standup thread:
   - In forum-standups channel
   - Title: "Standup - [Date]"
   - Auto-tag team members

3. Wait 30 minutes

4. At 9:30 AM, summarize:
   - Count reactions (participation rate)
   - Link to standup thread
   - Send summary to #status-updates
```

**MCP Tools Used:**
- `mcp__discord__send_message`
- `mcp__discord__create_forum_post`
- `mcp__discord__get_messages` (to count reactions)

---

### Pattern 4: Error Alert System

When error detected:

**Execute:**
```
1. Analyze error severity:
   - Critical: Immediate outage
   - High: Degraded functionality
   - Medium: Minor issue
   - Low: Warning or info

2. Send alert to #incidents:
   - Critical: @everyone mention
   - High: @team mention
   - Medium/Low: No mention

   Format:
   "🚨 [SEVERITY] Error Detected

   Service: [name]
   Error: [message]
   Time: [timestamp]
   Impact: [description]

   Investigating..."

3. Create incident thread:
   - Title: "[SEVERITY] [Service] - [Short description]"
   - Initial post with full details
   - Status updates as investigation progresses

4. Add reaction for status:
   - 🔍 Investigating
   - 🔄 Fixing
   - ✅ Resolved

5. When resolved:
   - Update thread with resolution
   - Post summary to #incidents
   - Close thread
```

**MCP Tools Used:**
- `mcp__discord__send_message`
- `mcp__discord__create_forum_post`
- `mcp__discord__add_reaction`
- `mcp__discord__edit_message` (status updates)

---

### Pattern 5: Webhook Integration

When user requests: "Setup webhook for [service]"

**Execute:**
```
1. Create webhook in target channel:
   - Name: "[Service] Bot"
   - Avatar: Relevant icon (if provided)

2. Store webhook URL:
   - Return to user
   - Document in channel description

3. Test webhook:
   - Send test message
   - Verify formatting
   - Confirm delivery

4. Provide integration instructions:
   - How to use webhook URL
   - Example payload format
   - Rate limit information
   - Security best practices

5. Document in #webhooks-registry:
   - Channel: #target-channel
   - Service: [name]
   - Created: [timestamp]
   - Owner: @username
```

**MCP Tools Used:**
- `mcp__discord__create_webhook`
- `mcp__discord__execute_webhook` (test)
- `mcp__discord__send_message` (instructions)

---

### Pattern 6: Channel Cleanup

When user requests: "Clean up inactive channels"

**Execute:**
```
1. List all channels:
   - Get channel info
   - Check last message timestamp
   - Identify inactive (>30 days)

2. Analyze activity:
   - Message count last 30 days
   - Member activity
   - Purpose still relevant?

3. Create report in #admin:
   - List inactive channels
   - Activity stats
   - Recommendation (archive/delete/keep)

4. Ask for confirmation

5. If approved, archive:
   - Rename: "archived-[channel-name]"
   - Move to "Archived" category
   - Post archive notice
   - Remove write permissions (read-only)

6. Document:
   - Log in #admin-log
   - Update channel registry
```

**MCP Tools Used:**
- `mcp__discord__list_channels`
- `mcp__discord__get_channel_info`
- `mcp__discord__get_messages` (activity check)
- `mcp__discord__send_message` (report + confirmation)
- `mcp__discord__delete_channel` or modify (if approved)

---

## Advanced Workflows

### Multi-Channel Announcements
```
Send same message to multiple channels:
1. Define message (text or embed)
2. Identify target channels
3. Send to each (respecting rate limits)
4. Log delivery status
5. Report completion
```

### Reaction Role Setup
```
Create reaction-based role assignment:
1. Send message with role descriptions
2. Add reactions for each role
3. Monitor reactions (via webhook)
4. Assign roles based on reactions
   (Note: Role assignment requires bot permissions)
```

### Forum Moderation
```
Auto-moderate forum posts:
1. Monitor new forum posts
2. Check against guidelines:
   - Spam detection
   - Inappropriate content
   - Duplicate posts
3. Take action:
   - Flag for review
   - Auto-delete obvious spam
   - Notify moderators
4. Log actions
```

### Cross-Platform Bridging
```
Bridge Discord ↔ Telegram/WhatsApp:
1. Receive message in Discord
2. Process via Sol
3. Send to other platform via respective MCP
4. Receive replies
5. Post back to Discord
6. Maintain conversation threading
```

---

## Best Practices

### Rate Limiting
```
Discord API limits:
- 50 requests per second per bot
- Burst tolerance: 120 requests/minute
- Webhook limits: 30 requests/minute

Strategy:
- Queue messages if high volume
- Use bulk operations when available
- Implement exponential backoff on errors
- Respect 429 rate limit responses
```

### Error Handling
```
On API error:
1. Detect error type:
   - Rate limit (429)
   - Permissions (403)
   - Not found (404)
   - Server error (5xx)

2. Handle appropriately:
   - Rate limit: Wait and retry
   - Permissions: Notify user, explain
   - Not found: Verify channel exists
   - Server: Retry after delay

3. Log for debugging

4. Report to user gracefully
```

### Message Formatting
```
Use embeds for rich content:
{
  "title": "Clear, concise title",
  "description": "Main content",
  "color": 0xFFD700, // Gold for Sol
  "fields": [
    {
      "name": "Field Name",
      "value": "Field content",
      "inline": true
    }
  ],
  "footer": {
    "text": "Automated by Sol • 2025-11-09"
  },
  "timestamp": "ISO 8601 format"
}
```

### Security
```
✅ Do:
- Validate all inputs
- Use webhook URLs securely (don't expose)
- Respect channel permissions
- Rate limit user commands
- Log all actions

❌ Don't:
- Spam channels
- Store sensitive data in messages
- Bypass permissions
- Impersonate users
- Auto-delete user content without permission
```

---

## Integration with Sol's Planetary System

### When to Delegate

**Mercury (Communication):**
- API integration automation
- Data flow setup
- Webhook configuration

**Saturn (Organization):**
- Channel cleanup
- Archive management
- Usage analytics

**Mars (Testing):**
- Bot permission verification
- Webhook testing
- Error scenario handling

**Jupiter (Growth):**
- Community engagement metrics
- Announcement scheduling
- Growth automation

**Venus (Design):**
- Embed design
- Rich message formatting
- Visual consistency

---

## Monitoring & Metrics

### Track:
```
- Messages sent per day
- Channels created/deleted
- Webhooks configured
- Automation triggers executed
- API errors encountered
- User satisfaction (reaction tracking)
```

### Report Weekly:
```
📊 Discord Automation Report

Messages: 1,247
Channels: 3 created, 2 archived
Webhooks: 5 active
Automations: 87 triggers
Errors: 2 (both rate limits, resolved)
Satisfaction: 96% positive reactions

Top commands:
1. Deployment notifications (43%)
2. Standup reminders (28%)
3. Channel creation (15%)
4. Error alerts (10%)
5. Other (4%)
```

---

## Hermetic Principles Applied

**Mentalism** - Clarify Discord intent before acting (ask if ambiguous)

**Correspondence** - Discord structure mirrors project organization

**Vibration** - Real-time updates, keep information flowing

**Polarity** - Balance automation (efficiency) with human control (agency)

**Rhythm** - Respect working hours, schedule appropriately

**Cause-Effect** - Track automation outcomes, learn and improve

**Gender** - Messages balance directness (masculine) with empathy (feminine)

---

## Usage Examples

### Basic Commands
```
User: "Send message to #general: 'Server maintenance in 1 hour'"
→ Execute: mcp__discord__send_message

User: "Create channel #project-phoenix"
→ Execute: mcp__discord__create_channel

User: "Setup webhook in #notifications"
→ Execute: mcp__discord__create_webhook
```

### Complex Workflows
```
User: "Setup complete project infrastructure for Alpha"
→ Execute: Pattern 1 (Project Channel Setup)
→ Creates: 4 channels, 1 webhook, welcome message

User: "Notify team about deployment"
→ Execute: Pattern 2 (Deployment Notification)
→ Creates: Rich embed, reactions, incident thread if needed

User: "Clean up old channels"
→ Execute: Pattern 6 (Channel Cleanup)
→ Analyzes: Activity, creates report, awaits confirmation
```

---

## Extension Points

### Custom Automations
```
Add custom automation workflows in:
.claude/skills/discord-automation/
  ├── deployments.md
  ├── standups.md
  ├── incidents.md
  └── community.md

Each file defines specific workflow pattern
```

### n8n Integration
```
Trigger n8n workflows from Discord:
1. Receive Discord command
2. Parse parameters
3. Trigger n8n workflow via webhook
4. Receive n8n response
5. Post result to Discord

Example: "@Sol run sentiment analysis on #feedback"
```

### MCP Ecosystem
```
Coordinate with other MCPs:

Discord + GitHub:
- PR opened → Discord notification
- Deployment status → Discord update

Discord + Supabase:
- Query database → Post results
- Database alerts → Discord incidents

Discord + WhatsApp/Telegram:
- Cross-platform bridging
- Unified notifications
```

---

## Initialization Checklist

When first using this skill:

- [ ] Verify Discord MCP connection
- [ ] Check bot permissions in target servers
- [ ] Test basic commands (send message, create channel)
- [ ] Setup primary automation workflows
- [ ] Configure webhook integrations
- [ ] Create #sol-commands documentation channel
- [ ] Test error handling
- [ ] Monitor first week of usage
- [ ] Gather user feedback
- [ ] Optimize based on patterns

---

## Troubleshooting

### Bot not responding
```
1. Check Discord MCP connection:
   - MCP server running?
   - Bot token valid?
   - Network connectivity?

2. Verify bot permissions:
   - Invited to server?
   - Has required intents?
   - Channel permissions set?

3. Check Claude Code:
   - Agent accessible?
   - Skill loaded?
   - No errors in logs?
```

### Rate limiting issues
```
1. Identify cause:
   - Too many messages?
   - Webhook overuse?
   - Bulk operations?

2. Implement solution:
   - Add delays between operations
   - Queue messages
   - Use bulk APIs where available
   - Reduce automation frequency

3. Monitor and adjust
```

### Permission errors
```
1. Check bot role:
   - High enough in hierarchy?
   - Has required permissions?

2. Check channel permissions:
   - Bot can read/write?
   - Manage channels enabled?

3. Request admin to fix:
   - Explain needed permissions
   - Provide Discord docs link
```

---

## The Sacred Promise

This skill ensures:
- Discord operations are reliable and efficient
- Automation serves users, never annoys them
- Community thrives through organized coordination
- Transparency in all bot actions
- Privacy and security respected

---

**Status:** Active and Ready
**Dependencies:** Discord MCP, Sol orchestration system
**Integration:** Full planetary agent ecosystem
**Principle:** Mercury (Communication) + Rhythm (Flow) + Correspondence (Structure)

*This skill is Discord expertise manifested. Through Sol, it serves the community with sacred technology.*
