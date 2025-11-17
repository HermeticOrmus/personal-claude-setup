# Scheduler MCP (Cron)

## Overview
Scheduler MCP enables automated task scheduling using cron expressions, allowing you to run shell commands, API calls, AI tasks, and send desktop notifications at specified times.

## Status
⏸️ **Manual Setup Required** - Python-based, needs separate installation

## Configuration
- **Language**: Python
- **Package**: `scheduler-mcp` (GitHub)
- **Repository**: https://github.com/PhialsBasement/scheduler-mcp

---

## What is Cron?

Cron is a time-based job scheduler used in Unix-like systems.

**Cron Expression Format:**
```
* * * * *
│ │ │ │ │
│ │ │ │ └─── Day of week (0-6, Sunday=0)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of month (1-31)
│ └───────── Hour (0-23)
└─────────── Minute (0-59)
```

**Common Examples:**
```
0 9 * * *        # Every day at 9:00 AM
*/15 * * * *     # Every 15 minutes
0 0 * * 0        # Every Sunday at midnight
0 12 * * 1-5     # Weekdays at noon
```

---

## Manual Setup (For Future Installation)

### Prerequisites
- Python 3.8+
- pip
- Git

### Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/PhialsBasement/scheduler-mcp.git
cd scheduler-mcp

# 2. Create virtual environment
python -m venv .venv

# 3. Activate virtual environment
# Windows:
.venv\Scripts\activate
# Unix/Mac:
source .venv/bin/activate

# 4. Install dependencies
pip install -r requirements.txt

# 5. Test run
python main.py
```

### Add to Claude Config

After installation, add to `claude_desktop_config.json`:

```json
"scheduler": {
  "command": "python",
  "args": [
    "C:\\path\\to\\scheduler-mcp\\main.py"
  ],
  "env": {}
}
```

---

## Capabilities (When Installed)

### Task Types

#### 1. Shell Commands
Execute any shell/bash command:
```
Schedule "git pull" to run every hour at :00
```

#### 2. API Calls
Make HTTP requests on schedule:
```
Schedule a POST request to https://api.example.com/webhook every day at 3 PM
```

#### 3. AI Tasks
Run AI-powered tasks:
```
Schedule Claude to generate a daily summary report at 8 AM
```

#### 4. Desktop Notifications
Send notifications at specific times:
```
Schedule a notification "Standup in 5 min" every weekday at 9:55 AM
```

---

## Usage Examples (When Installed)

### Daily Backup
```
Create a scheduled task:
- Command: backup-script.bat
- Schedule: 0 2 * * * (Every day at 2 AM)
- Name: "Daily Backup"
```

### Hourly Health Check
```
Schedule an API health check:
- URL: https://myapp.com/health
- Schedule: 0 * * * * (Every hour)
- Alert on failure
```

### Weekly Report
```
Schedule AI report generation:
- Task: Generate weekly metrics report
- Schedule: 0 9 * * 1 (Every Monday at 9 AM)
- Send to: my Telegram
```

### Meeting Reminders
```
Schedule notifications:
- "Team standup in 10 minutes"
- Schedule: 50 9 * * 1-5 (Weekdays at 9:50 AM)
```

---

## Gold Hat Use Cases

### ✅ Empowering Automation

**Personal Productivity:**
- Daily backup of important files
- Scheduled git commits/pushes
- Regular system maintenance
- Automated reporting

**Health & Wellness:**
- Posture check reminders
- Water break notifications
- Screen time alerts
- Exercise reminders

**Learning:**
- Daily review of flashcards
- Spaced repetition reminders
- Content consumption limits
- Study session triggers

**Project Management:**
- Daily standup reminders
- Sprint planning notifications
- Deadline alerts
- Progress check-ins

### ❌ Anti-Patterns to Avoid

**Don't schedule:**
- Spam messages to others
- Excessive notifications (notification fatigue)
- Resource-heavy tasks during work hours
- Automated social media spam
- Aggressive reminders (respect your own attention)

---

## Integration Patterns

### Pattern 1: Automated Backups
```
Cron Schedule → Backup Script → Upload to Cloud → Notify on Telegram
Daily at 2 AM
```

### Pattern 2: Health Monitoring
```
Cron Schedule → API Health Check → Log Results → Alert if Down
Every 5 minutes
```

### Pattern 3: Content Distribution
```
Cron Schedule → Generate Report → Post to Discord → Archive in Obsidian
Weekly on Monday 9 AM
```

### Pattern 4: Personal Reminders
```
Cron Schedule → Desktop Notification → Log Completion
Custom times throughout day
```

---

## Cron Expression Examples

### Every Minute
```
* * * * *
```

### Every 5 Minutes
```
*/5 * * * *
```

### Every Hour at :30
```
30 * * * *
```

### Every Day at 3:15 PM
```
15 15 * * *
```

### Every Weekday at 9 AM
```
0 9 * * 1-5
```

### First Day of Month at Midnight
```
0 0 1 * *
```

### Every Sunday at 11 PM
```
0 23 * * 0
```

### Twice Daily (8 AM and 8 PM)
```
0 8,20 * * *
```

---

## Best Practices

### Task Design
1. **Idempotent** - Safe to run multiple times
2. **Error handling** - Don't assume success
3. **Logging** - Track execution history
4. **Timeout** - Don't run indefinitely
5. **Resource aware** - Don't overload system

### Scheduling
1. **Off-peak hours** - Heavy tasks at night
2. **Reasonable frequency** - Don't over-schedule
3. **Buffer time** - Space out dependent tasks
4. **Timezone aware** - Know when tasks actually run
5. **Test first** - Verify before automating

### Monitoring
1. **Log all executions** - Success and failure
2. **Alert on failure** - Know when things break
3. **Review regularly** - Are tasks still needed?
4. **Clean up old tasks** - Remove unused schedules
5. **Document purpose** - Why does this task exist?

---

## Alternative: n8n Scheduling

**If you don't want to install Scheduler MCP:**

You can use your existing **n8n** for scheduling:

1. **Create workflow in n8n**
2. **Add "Schedule" trigger node**
3. **Configure cron expression**
4. **Add action nodes**
5. **Activate workflow**

**Advantages:**
- Already installed
- Visual interface
- More powerful workflows
- Cloud-based (always running)

**Disadvantages:**
- Requires n8n access
- More complex setup per task
- Not directly in Claude conversation

---

## Future Installation

**When you want to install Scheduler MCP:**

1. **Check prerequisites** (Python, Git)
2. **Follow manual setup steps above**
3. **Add to Claude config**
4. **Test with simple task**
5. **Document your scheduled tasks in** `.mcp/workflows/scheduled-tasks.md`

---

## Resources
- **Repository**: https://github.com/PhialsBasement/scheduler-mcp
- **Cron Expression Tool**: https://crontab.guru/
- **Alternative (n8n)**: Already installed!
