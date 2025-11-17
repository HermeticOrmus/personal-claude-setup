# Cross-Platform Messaging Patterns

> Gold Hat approach to connecting communication platforms ethically and transparently

---

## Pattern 1: Multi-Platform Notifications

### Use Case
Send important notifications to multiple platforms simultaneously while respecting user preferences.

### Architecture
```
Event Trigger
    ↓
n8n Workflow
    ↓
├→ Telegram (instant)
├→ Discord (team)
└→ WhatsApp (urgent only)
```

### Implementation
```javascript
// n8n workflow nodes:
1. Webhook Trigger (receive event)
2. Filter Node (check urgency level)
3. Telegram Node (all notifications)
4. Discord Node (team notifications)
5. WhatsApp Node (urgent only, with consent)
```

### Gold Hat Principles
✅ User can opt-out per platform
✅ Urgency levels respect attention
✅ No duplicate spam
✅ Clear notification source

---

## Pattern 2: Message Bridging

### Use Case
Bridge messages between platforms for users who prefer different apps.

### Architecture
```
Telegram Group
    ↓
n8n (transform & route)
    ↓
Discord Channel
```

### Implementation
- Listen to Telegram group updates
- Transform message format
- Post to Discord with attribution
- Optionally: bi-directional sync

### Gold Hat Principles
✅ All participants know bridging is active
✅ Opt-in only (never surprise bridge)
✅ Clear message attribution
✅ Respect platform-specific norms

### Anti-Pattern Warning
❌ Secret bridges (privacy violation)
❌ Bridging private DMs without consent
❌ Removing message attribution

---

## Pattern 3: Smart Routing

### Use Case
Route incoming messages to appropriate platform based on content, urgency, or sender.

### Architecture
```
Incoming Message (any platform)
    ↓
Claude MCP Analysis
    ↓
n8n Router
    ↓
├→ High Priority → WhatsApp
├→ Team Related → Discord
└→ Personal → Telegram
```

### Implementation
1. Message arrives via any MCP
2. Claude analyzes content/context
3. Determines appropriate platform
4. Routes via n8n workflow
5. Sends with context preservation

### Gold Hat Principles
✅ Routing logic is transparent
✅ User can override routing
✅ No surprises about where messages go
✅ Privacy boundaries respected

---

## Pattern 4: Scheduled Broadcasts

### Use Case
Send scheduled updates/reminders across platforms (newsletters, team updates, etc.)

### Architecture
```
n8n Cron Trigger (schedule)
    ↓
Content Generation
    ↓
Platform Optimization
    ↓
├→ Telegram (formatted for inline)
├→ Discord (formatted as embed)
└→ Email (via SMTP node)
```

### Implementation
- n8n schedules the broadcast
- One message, multiple formats
- Platform-specific optimization
- Sent at optimal times per platform

### Gold Hat Principles
✅ Easy unsubscribe mechanism
✅ Frequency limits (respect attention)
✅ Value-first content (not spam)
✅ Clear sender identity

### Anti-Pattern Warning
❌ No unsubscribe option
❌ High frequency (daily+)
❌ Clickbait or manipulation
❌ Purchased contact lists

---

## Pattern 5: Backup & Archive

### Use Case
Automatically backup important conversations across platforms.

### Architecture
```
Message Platforms
    ↓
n8n Collector
    ↓
Transform & Store
    ↓
└→ Local SQLite / JSON files
```

### Implementation
- Daily: Pull messages from Telegram, Discord, WhatsApp
- Transform to common format
- Store locally with timestamps
- Searchable archive

### Gold Hat Principles
✅ Local storage (you own data)
✅ Encrypted at rest
✅ Only backup your own chats
✅ Respect deletion requests

---

## Pattern 6: Context-Aware Replies

### Use Case
AI-assisted replies that maintain context across platforms.

### Architecture
```
Incoming Message
    ↓
MCP → Claude Analysis
    ↓
Draft Response
    ↓
Human Approval
    ↓
Send via appropriate MCP
```

### Implementation
1. Message arrives (any platform)
2. Claude reads context via MCP
3. Drafts appropriate response
4. Shows to you for approval
5. You edit/approve/reject
6. Sends if approved

### Gold Hat Principles
✅ **Human always approves** (never fully automated)
✅ Context clearly shown to you
✅ Easy to edit before sending
✅ Recipients know you use AI assistance (transparency)

### Critical Rule
⚠️ **NEVER send AI responses without human approval**
This crosses from empowerment to deception.

---

## Pattern 7: Status Sync

### Use Case
Sync status/presence across platforms.

### Architecture
```
Status Change (one platform)
    ↓
n8n Trigger
    ↓
├→ Update Discord status
├→ Update Telegram bio
└→ Update custom status API
```

### Implementation
- Detect status change on one platform
- Transform to other platform formats
- Update all connected platforms
- Rate limit to avoid spam

### Gold Hat Principles
✅ Opt-in sync (not automatic)
✅ Clear sync indicators
✅ Can disable per-platform
✅ Respects platform limitations

---

## Pattern 8: Emergency Broadcast

### Use Case
Critical alerts that must reach you immediately across all channels.

### Architecture
```
Critical Event
    ↓
n8n High Priority Path
    ↓
Parallel Send (all platforms)
    ↓
├→ WhatsApp (SMS backup if no read)
├→ Telegram (with notification)
├→ Discord (with @mention)
└→ Email (with high priority)
```

### Implementation
- Reserved for genuinely critical events
- Bypasses normal routing
- Sends to all platforms simultaneously
- Confirmation when received/read

### Gold Hat Principles
✅ Reserved for true emergencies
✅ Clear escalation criteria
✅ Test regularly (don't surprise yourself)
✅ Review and adjust thresholds

### What Qualifies as Emergency
- Security breaches
- System failures
- Time-sensitive opportunities
- Health/safety alerts

### What's NOT an Emergency
- Newsletter updates
- Promotional content
- Regular reminders
- Non-urgent notifications

---

## Anti-Patterns to Avoid

### ❌ The Attention Vampire
Sending to all platforms "just to make sure they see it"
**Problem**: Disrespects user attention, causes notification fatigue

### ❌ The Secret Bridge
Bridging conversations without telling all participants
**Problem**: Privacy violation, trust breach

### ❌ The Spam Cannon
Auto-replying to everything across all platforms
**Problem**: Creates noise, reduces signal

### ❌ The Data Harvester
Collecting messages/contacts without clear purpose
**Problem**: Extractive, not empowering

### ❌ The Impersonator
AI-generated responses without disclosure
**Problem**: Deceptive, undermines trust

---

## Testing Patterns

Before deploying any cross-platform pattern:

1. **Test with yourself** - Send to your own accounts
2. **Document clearly** - Explain what happens when
3. **Get consent** - From all participants if bridging
4. **Monitor carefully** - Watch for unintended effects
5. **Iterate slowly** - Don't automate everything at once

---

## Measuring Success (Gold Hat Metrics)

### ✅ Good Metrics
- Time saved on legitimate coordination
- Reduced missed important messages
- Better organization of conversations
- User satisfaction and calm

### ❌ Bad Metrics
- Messages sent (more ≠ better)
- Platforms reached (coverage ≠ value)
- Engagement rate (manipulation metric)
- Time in app (attention extraction)

---

*Remember: Technology should serve human flourishing, not extract attention.*

**The Litmus Test**: Would you proudly explain this automation to everyone affected by it?
