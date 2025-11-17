# 🏗️ HERMETIC DAILY AUTOMATION - SYSTEM ARCHITECTURE

**Visual overview of the complete n8n workflow ecosystem**

---

## 📊 SYSTEM OVERVIEW

```
┌─────────────────────────────────────────────────────────────────┐
│                  HERMETIC DAILY AUTOMATION                      │
│                  3-Workflow Ecosystem                           │
└─────────────────────────────────────────────────────────────────┘

┌───────────────┐         ┌──────────────┐         ┌──────────────┐
│   MORNING     │         │   EVENING    │         │ INTERACTIVE  │
│   WORKFLOW    │         │   WORKFLOW   │         │   LISTENER   │
│   (7 AM)      │         │   (8 PM)     │         │  (Always On) │
└───────┬───────┘         └──────┬───────┘         └──────┬───────┘
        │                        │                        │
        │ Sends                  │ Sends                  │ Receives
        │ Guidance               │ Prompts                │ Responses
        │                        │                        │
        ▼                        ▼                        ▼
   ┌────────────────────────────────────────────────────────┐
   │            📱 TELEGRAM (Your Daily Coach)             │
   │                                                        │
   │  🌅 Morning: Focus + Priorities + Energy Check        │
   │  🌙 Evening: Reflection + Assessment Prompts          │
   │  📝 Anytime: You respond → System logs                │
   └────────────────┬───────────────────────────────────────┘
                    │
                    │ All workflows write to:
                    ▼
        ┌──────────────────────────┐
        │   💾 DAILY LOGS          │
        │   .hermetic/daily-logs/  │
        │                          │
        │  📄 morning-[date].json  │
        │  📄 evening-[date].json  │
        │  📄 responses-[date].json│
        │  📄 general-[date].txt   │
        └──────────────────────────┘
                    │
                    │ Future: Analytics workflows read from
                    ▼
        ┌──────────────────────────┐
        │   📊 INSIGHTS & REPORTS  │
        │   (Coming Next)          │
        │                          │
        │  • Weekly summaries      │
        │  • Sprint progress       │
        │  • Goal tracking         │
        │  • Energy analysis       │
        └──────────────────────────┘
```

---

## 🌅 WORKFLOW 1: MORNING FOCUS (Schedule-Based)

**Trigger:** Schedule Trigger (7:00 AM daily)

**Flow:**
```
┌─────────────────┐
│ Schedule        │  Every morning at 7 AM
│ Trigger         │
│ (7:00 AM)       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Generate        │  Calculate sprint day, week, principle
│ Morning         │  Determine priorities based on phase
│ Message (Code)  │  Select quote, format message
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Send to         │  Send via Telegram API
│ Telegram        │  Chat ID from environment variable
│                 │  Markdown formatting
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Log Morning     │  Save to morning-[date].json
│ Check-In        │  Includes sprint day, principle, message
│ (File Write)    │
└─────────────────┘
```

**Key Components:**
- **Sprint Day Calculation:** `(today - sprintStartDate) + 1`
- **Principle Cycling:** Maps day of week to Hermetic Principle
- **Priority Selection:** Conditional based on sprint phase (1-15)
- **Quote Rotation:** Cycles through inspiring quotes array

**Variables You Set:**
- `sprintStartDate` - When your 90-day sprint began
- `priorities[]` - Arrays for each sprint phase
- `quotes[]` - Inspiring messages

---

## 🌙 WORKFLOW 2: EVENING CHECK-IN (Schedule-Based)

**Trigger:** Schedule Trigger (8:00 PM daily)

**Flow:**
```
┌─────────────────┐
│ Schedule        │  Every evening at 8 PM
│ Trigger         │
│ (8:00 PM)       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Generate        │  Calculate sprint day, week
│ Evening         │  Build reflection prompts
│ Check-In (Code) │  Add milestone messages if applicable
│                 │  Select daily wisdom
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Send to         │  Send via Telegram API
│ Telegram        │  5 structured questions
│                 │  Markdown formatting
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Log Evening     │  Save to evening-[date].json
│ Check-In        │  Includes sprint day, prompts, time
│ (File Write)    │
└─────────────────┘
```

**Key Components:**
- **Sprint Progress Tracking:** Same calculation as morning
- **Milestone Detection:** Days 6, 18, 30, 60, 90 trigger special messages
- **Weekly Wrap-Up:** Saturday (day 6) triggers Sabbath reminder
- **Wisdom Cycling:** 7 rotating wisdom quotes

**Variables You Set:**
- `sprintStartDate` - Same as morning workflow
- `wisdom[]` - Daily wisdom array

---

## 📝 WORKFLOW 3: INTERACTIVE RESPONSE LISTENER (Event-Based)

**Trigger:** Telegram Webhook (listens continuously)

**Flow:**
```
┌─────────────────┐
│ Telegram        │  Listens for ANY message you send
│ Webhook         │  Triggers on message event
│ Trigger         │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Parse           │  Detect response type using regex patterns:
│ Response        │  • Just number? → morning-energy
│ Type (Code)     │  • "Today: 7"? → today-rating
│                 │  • "Shipped: ..."? → what-shipped
│                 │  • Anything else? → general-reflection
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Is Structured   │  Branch logic:
│ Response?       │  TRUE path: structured response
│ (If Node)       │  FALSE path: general reflection
└────┬────────┬───┘
     │        │
TRUE │        │ FALSE
     │        │
     ▼        ▼
┌─────────────────┐  ┌─────────────────┐
│ Read Existing   │  │ Format General  │
│ Log (File Read) │  │ Reflection      │
│ Continue on fail│  │ with Timestamp  │
└────────┬────────┘  └────────┬────────┘
         │                    │
         ▼                    ▼
┌─────────────────┐  ┌─────────────────┐
│ Merge with      │  │ Append to       │
│ Existing Log    │  │ general-[date]  │
│ (Code)          │  │ .txt file       │
└────────┬────────┘  └────────┬────────┘
         │                    │
         ▼                    │
┌─────────────────┐           │
│ Save Structured │           │
│ responses-[date]│           │
│ .json           │           │
└────────┬────────┘           │
         │                    │
         └────────┬───────────┘
                  │
                  ▼
         ┌─────────────────┐
         │ Build           │  Create confirmation message
         │ Confirmation    │  based on response type
         │ Message (Code)  │
         └────────┬────────┘
                  │
                  ▼
         ┌─────────────────┐
         │ Send            │  "✅ Logged: [type]"
         │ Confirmation    │  Shows what was captured
         │ to Telegram     │
         └─────────────────┘
```

**Key Components:**

### **Pattern Detection (Regex):**
```javascript
morningEnergy: /^\s*\d{1,2}\s*$/          // Just a number
todayRating: /today[:\s]*(\d{1,2})/i      // "Today: 7"
energyRating: /energy[:\s]*(\d{1,2})/i    // "Energy: 6"
shipped: /shipped[:\s]*(.+)/i             // "Shipped: text"
boundaries: /boundaries[:\s]*(yes|no|mostly)/i
clientActivity: /client|lead|activity[:\s]*(.+)/i
general: /.+/                              // Catch-all
```

### **Structured Response Flow:**
1. Read existing `responses-[date].json` (create if doesn't exist)
2. Parse existing JSON
3. Add new response to `responses[]` array
4. Write merged JSON back to file
5. Send confirmation

### **General Reflection Flow:**
1. Format as: `[HH:MM] Your message text`
2. Append to `general-reflections-[date].txt`
3. Send confirmation

---

## 💾 DATA STORAGE STRUCTURE

### **Morning Logs:** `morning-2025-10-30.json`
```json
{
  "message": "🌅 GOOD MORNING, HERMETIC ORMUS...",
  "currentDay": 1,
  "currentWeek": 1,
  "principle": "Mentalism"
}
```

### **Evening Logs:** `evening-2025-10-30.json`
```json
{
  "message": "🌙 EVENING CHECK-IN...",
  "currentDay": 1,
  "checkInTime": "2025-10-30T20:00:00.000Z"
}
```

### **Structured Responses:** `responses-2025-10-30.json`
```json
{
  "date": "2025-10-30",
  "sprintDay": 1,
  "responses": [
    {
      "type": "morning-energy",
      "data": {
        "energyLevel": 8,
        "timestamp": "2025-10-30T07:05:00.000Z"
      },
      "raw": "8"
    },
    {
      "type": "what-shipped",
      "data": {
        "shipped": "Set up Stripe, created script, sent outreach",
        "timestamp": "2025-10-30T20:15:00.000Z"
      },
      "raw": "Shipped: Set up Stripe, created script, sent outreach"
    }
  ]
}
```

### **General Reflections:** `general-reflections-2025-10-30.txt`
```
[07:05] Feeling energized to start Sprint 1 today
[14:30] Just had a breakthrough on the discovery call positioning
[20:15] Proud of what shipped today. Feeling aligned.
```

---

## 🔄 DATA FLOW DIAGRAM

```
YOU (via Telegram)
    │
    │ Morning: Receive guidance
    │ Evening: Receive prompts
    │ Anytime: Send responses
    │
    ▼
┌─────────────────────────────────┐
│  n8n WORKFLOW PROCESSING        │
│                                 │
│  Morning → Generate + Send      │
│  Evening → Generate + Send      │
│  Interactive → Parse + Log      │
└─────────────────┬───────────────┘
                  │
                  ▼
         ┌────────────────┐
         │  FILE SYSTEM   │
         │  (.hermetic/   │
         │   daily-logs/) │
         └────────┬───────┘
                  │
                  │ Future analytics read from here
                  ▼
         ┌────────────────┐
         │   INSIGHTS     │
         │   • Trends     │
         │   • Patterns   │
         │   • Warnings   │
         │   • Reports    │
         └────────────────┘
                  │
                  ▼
         Back to YOU (via Telegram)
```

---

## 🔧 CONFIGURATION POINTS

### **Environment Variables (Set in n8n):**
```bash
TELEGRAM_CHAT_ID="123456789"  # Your Telegram chat ID
```

### **Workflow-Level Settings (Edit in code nodes):**
```javascript
// In BOTH morning and evening workflows:
const sprintStartDate = new Date('2025-10-30');  // Your actual start date

// In morning workflow:
const priorities = [...];  // Customize per sprint phase
const quotes = [...];      // Add your inspiring quotes

// In evening workflow:
const wisdom = [...];      // Add your daily wisdom
```

### **Telegram Credentials (Set per workflow):**
- Bot Token from BotFather
- Configured in "Telegram" nodes
- Same credentials can be reused across all 3 workflows

---

## 🎯 WORKFLOW STATES

### **Active Workflows:**
```
✅ Morning Focus      - Triggered: 7:00 AM daily
✅ Evening Check-In   - Triggered: 8:00 PM daily
✅ Interactive Listener - Triggered: On every message received
```

### **Execution Flow:**
```
Morning:  Schedule → Code → Telegram → File → Done
Evening:  Schedule → Code → Telegram → File → Done
Interactive: Webhook → Parse → Branch → Merge/Append → Confirm → Done
```

### **Error Handling:**
- **Morning/Evening:** If Telegram fails, workflow stops (check credentials)
- **Interactive:** "Continue on Fail" for file read (creates new file if doesn't exist)

---

## 📊 FUTURE: ANALYTICS LAYER

**Planned 4th Workflow: Weekly Summary Dashboard**

**Trigger:** Schedule (Sunday 6 PM)

**Processing:**
1. Read all `responses-*.json` files from past week
2. Read all `general-reflections-*.txt` files
3. Calculate metrics:
   - Average morning energy
   - Average evening energy
   - Total items shipped
   - Boundary adherence rate
   - Client activity volume
4. Identify patterns:
   - Best energy days
   - Most productive sprint days
   - Common blockers (from reflections)
5. Generate report
6. Send via Telegram

**Output Example:**
```
📊 WEEK 1 SUMMARY (Days 1-7)

⚡ ENERGY:
Morning avg: 7.4/10
Evening avg: 6.8/10
Trend: ↗️ Increasing

📦 SHIPPED:
14 total items completed
Most productive: Thursday (4 items)

🛡️ BOUNDARIES:
6/7 days honored
Red flag: None

👥 CLIENT ACTIVITY:
8 outreach messages sent
3 responses received
2 discovery calls scheduled

🔱 PRINCIPLE COVERAGE:
All 7 principles touched ✅

📈 SPRINT PROGRESS:
Week 1 goal: Infrastructure ✅
Week 2 focus: Service delivery framework

Keep building. You're on track. 🔥
```

---

## 🌟 SYSTEM PRINCIPLES

**1. Automation Serves Consciousness**
- Not extractive (no dark patterns)
- Empowering (you control your data)
- Sacred (supports transformation, not just productivity)

**2. Data Serves Insight**
- Logs build historical awareness
- Patterns reveal truth
- Metrics guide decisions

**3. Structure Enables Freedom**
- Daily rhythm creates consistency
- Automatic logging removes cognitive load
- You focus on client work, system handles accountability

**4. The System Serves the Mission**
"First serve humans. Then beautify the tools of service."

---

## 🔒 PRIVACY & OWNERSHIP

**Your data stays with you:**
- Stored locally on your machine
- No external services (except Telegram)
- You own all JSON/TXT files
- Can backup, export, analyze freely

**Telegram considerations:**
- Messages are encrypted in transit
- Bot token gives access to your account (keep secret)
- Chat ID is specific to you
- Only you and your bot see these messages

---

## ⚙️ SYSTEM REQUIREMENTS

**Minimum:**
- n8n installed (Docker or npm)
- Telegram account
- Bot token from BotFather
- 10 MB disk space for logs

**Recommended:**
- n8n running continuously (Docker detached or pm2)
- Automatic backups of `.hermetic/daily-logs/`
- Version control for workflow JSON files

---

## 🎭 THE ARCHITECTURE EMBODIES HERMETIC PRINCIPLES

**Mentalism:** Code reflects clear intention (mental model)
**Correspondence:** File structure mirrors conceptual flow
**Vibration:** Workflows create consistent momentum
**Polarity:** Balance automated (system) with manual (you)
**Rhythm:** Daily cycles (morning/evening/continuous)
**Cause & Effect:** Every input logged, every action tracked
**Gender:** Masculine (structure) + Feminine (reflection)

---

*"As the architecture, so the experience. As the system, so the transformation."*

**— Hermetic Daily Automation System Architecture**
