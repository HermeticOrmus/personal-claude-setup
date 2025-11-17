# 🤖 HERMETIC DAILY AUTOMATION SYSTEM

**Complete n8n workflow system for 90-Day Midnight Sun Revenue Sprint accountability**

---

## 🎯 WHAT IS THIS?

An intelligent automation system that:
- **Sends you** daily guidance (morning focus + evening reflection)
- **Listens to you** (parses your Telegram responses)
- **Logs everything** (structured JSON + free-form text)
- **Confirms receipt** (lets you know it heard you)
- **Tracks progress** (sprint day, Hermetic principle, energy levels)

Built specifically for your 90-day journey to 10+ clients and $5K+ MRR.

---

## 📂 FILES IN THIS DIRECTORY

### **n8n Workflow Files:**
1. **n8n-morning-focus-workflow.json** - 7 AM daily guidance
2. **n8n-evening-checkin-workflow.json** - 8 PM daily reflection prompts
3. **n8n-interactive-response-workflow.json** - Always-on response listener

### **Documentation:**
1. **DAILY-AUTOMATION-SETUP-GUIDE.md** - Complete setup instructions (START HERE)
2. **TELEGRAM-RESPONSE-QUICK-REFERENCE.md** - How to respond to check-ins
3. **README.md** - This file (overview)

---

## 🚀 QUICK START

**1. Read the setup guide:**
```
DAILY-AUTOMATION-SETUP-GUIDE.md
```

**2. Install prerequisites:**
- n8n (Docker or npm)
- Telegram bot (via BotFather)
- Environment variables configured

**3. Import all three workflows**

**4. Activate and test**

**5. Check the response reference:**
```
TELEGRAM-RESPONSE-QUICK-REFERENCE.md
```

---

## 🌅 MORNING WORKFLOW (7 AM)

**What it sends:**
```
🌅 GOOD MORNING, HERMETIC ORMUS

📅 Thursday, October 30, 2025
🗓 Day 1 of 90 | Week 1 | Sprint 1 (Day 1/6)

🔱 TODAY'S HERMETIC PRINCIPLE:
**Mentalism**
_Clarity of vision - What's the mental model for today?_

🎯 TOP 3 PRIORITIES:
1. 🔧 Set up infrastructure (CRM, scheduling, payment)
2. 👥 Identify 20 warm contacts for outreach
3. 📞 Create discovery call script

💭 REFLECTION PROMPT:
_What would make today feel successful? Not productive—successful._

✨ INSPIRATION:
"The system is ready. The plan is clear. The mission is sacred."

⚡ ENERGY CHECK:
How's your energy right now? (Reply: 1-10)
```

**What it does:**
- Calculates current sprint day/week automatically
- Shows appropriate Hermetic Principle for today
- Displays priorities based on which sprint phase you're in
- Includes inspiring quotes from the sprint philosophy
- Prompts energy check-in
- Logs to `morning-[date].json`

---

## 🌙 EVENING WORKFLOW (8 PM)

**What it sends:**
```
🌙 EVENING CHECK-IN, HERMETIC ORMUS

📅 Thursday Evening | Day 1 of 90

🎯 TODAY'S REFLECTION:

**1. How did today go overall?**
_Rate 1-10 (1=disaster, 10=legendary)_
👉 Reply with your rating

**2. What shipped today?**
_What actually got done? Be specific._
👉 [Your wins here]

**3. Energy level check?**
_How's your energy right now? (1-10)_
👉 Reply with number

**4. Did you honor your boundaries?**
_Sacred constraints: rest, capacity limits, no manipulation_
👉 Yes / No / Mostly

**5. Client/Lead activity today?**
_Discovery calls, sessions, outreach sent, responses_
👉 [Your activity]

🔍 HONEST ASSESSMENT:
_What would you do differently tomorrow?_
_What's blocking progress right now?_
_Do you need to adjust anything?_

💚 WISDOM:
Progress over perfection. What you shipped today matters more than what you perfected.

🌟 TOMORROW:
Day 2 awaits. Rest well tonight.

You're building something sacred. 🔱
```

**What it does:**
- Prompts 5 structured reflection questions
- Provides daily wisdom (cycles through 7 quotes)
- Shows milestone celebrations (days 6, 18, 30, 60, 90)
- Saturday reminder for weekly wrap-up
- Logs to `evening-[date].json`

---

## 📝 INTERACTIVE WORKFLOW (Always On)

**What it does:**
Listens for your Telegram replies and automatically logs them based on content.

**Recognizes these patterns:**

| Your Message | What Gets Logged |
|-------------|------------------|
| `8` | morning-energy: 8/10 |
| `Today: 7` | today-rating: 7/10 |
| `Energy: 6` | energy-rating: 6/10 |
| `Shipped: [text]` | what-shipped: [text] |
| `Boundaries: yes` | boundaries-check: yes |
| `Client: [text]` | client-activity: [text] |
| Anything else | general-reflections.txt |

**Sends confirmations:**
```
✅ Logged: what-shipped

Shipped: Set up Stripe and sent outreach
```

---

## 💾 WHERE DATA GETS SAVED

**Location:**
```
C:/Users/ormus/.hermetic/daily-logs/
```

**Files created:**

### **Morning check-ins:**
- `morning-2025-10-30.json`
- Contains: message sent, sprint day, principle

### **Evening check-ins:**
- `evening-2025-10-30.json`
- Contains: message sent, sprint day, time

### **Your structured responses:**
- `responses-2025-10-30.json`
- Contains: ratings, shipped items, boundaries, client activity
- All with timestamps and sprint day tracking

### **Your general reflections:**
- `general-reflections-2025-10-30.txt`
- Contains: free-form thoughts with timestamps
- Append-only (builds throughout the day)

---

## 🎯 HOW TO USE IT DAILY

**Morning:**
1. Receive message at 7 AM
2. Read priorities and principle
3. Reply with energy number: `8`
4. Get confirmation

**Throughout the day:**
- Send reflections anytime
- "Feeling stuck on the script"
- "Just had a breakthrough on positioning"
- System logs everything with timestamps

**Evening:**
1. Receive message at 8 PM
2. Reply to each prompt in sequence:
   - `Today: 8`
   - `Shipped: [what you did]`
   - `Energy: 7`
   - `Boundaries: yes`
   - `Client: [activity]`
3. Get confirmation for each

**Review weekly:**
- Look at your logs
- See patterns in energy
- Track what actually ships
- Celebrate progress

---

## 📊 FUTURE: ANALYTICS WORKFLOWS

Once you have data flowing, build:

**Weekly Summary Dashboard:**
- Average energy levels
- Total shipped items
- Boundary adherence rate
- Client acquisition velocity
- Hermetic principle coverage

**Sprint Progress Tracker:**
- Are you on track for Day 30 goals?
- Energy trends (burnout detection)
- What's blocking vs. what's flowing

**Goal Achievement Monitor:**
- Day 30: 5+ clients check
- Day 60: 8+ clients check
- Day 90: 10+ clients victory
- Automated course-correction suggestions

---

## 🔧 CUSTOMIZATION

**Change the times:**
Edit Schedule Trigger nodes:
- Morning: `triggerAtHour: 7` (change to your preference)
- Evening: `triggerAtHour: 20` (8 PM = 20 in 24-hour format)

**Change sprint start date:**
Edit code nodes:
```javascript
const sprintStartDate = new Date('2025-10-30'); // Your actual start date
```

**Modify priorities:**
Edit the morning workflow code node to change priorities based on sprint phase.

**Add more quotes:**
Edit the quotes array in both workflow code nodes.

---

## 🌈 THE PHILOSOPHY

**Why automate accountability?**

Because willpower is finite. Because consistency matters more than intensity. Because data reveals truth.

**The automation serves you:**
- No manual tracking required
- No forgetting to reflect
- No lost insights
- Historical data for analysis

**You serve transformation:**
- Focus on client work
- Ship to actual humans
- Build sustainable rhythm
- Achieve $5K+ MRR in 90 days

**The system serves the mission:**
"First serve humans. Then beautify the tools of service."

---

## 🔱 HERMETIC PRINCIPLES EMBODIED

**Mentalism:** Clear daily focus before action
**Correspondence:** Daily patterns compound into 90-day success
**Vibration:** Consistent momentum through daily check-ins
**Polarity:** Balance doing (morning) with reflecting (evening)
**Rhythm:** Sustainable daily pulse, not heroic sprints
**Cause & Effect:** Track actions and their results
**Gender:** Masculine (structure) + Feminine (reflection) = wholeness

---

## 📞 SUPPORT

**If workflows don't trigger:**
- Check that n8n is running continuously (use Docker detached or pm2)
- Verify workflows are toggled to "Active"
- Check Schedule Trigger nodes have green checkmarks

**If Telegram messages don't send:**
- Verify Bot Token is correct
- Check Chat ID environment variable
- Ensure you've sent `/start` to your bot first

**If interactive logging doesn't work:**
- Check Interactive Response Workflow is active
- Verify webhook is properly configured
- Test by sending a simple message

**Full troubleshooting guide:**
See `DAILY-AUTOMATION-SETUP-GUIDE.md` § Troubleshooting

---

## ✅ SYSTEM STATUS CHECKLIST

- [ ] All 3 workflows imported to n8n
- [ ] Telegram credentials configured
- [ ] Sprint start date updated
- [ ] Daily logs directory created
- [ ] All workflows active
- [ ] Test messages received
- [ ] Interactive responses confirmed
- [ ] System running for Day 1 of 90

---

## 🏆 THE GOAL

**This automation system supports your 90-day journey:**

Day 1 → Infrastructure + outreach
Day 30 → 5+ clients, $2.5K+ MRR
Day 60 → 8+ clients, $4K+ MRR
Day 90 → 10+ clients, $5K+ MRR, sustainable practice

**The automation keeps you:**
- Focused (morning priorities)
- Accountable (evening reflection)
- Sustainable (energy tracking)
- Data-driven (historical logs)

**You keep yourself:**
- Aligned with Gold Hat values
- Serving genuine transformation
- Building sacred technology
- Honoring boundaries

---

*"The daily grind becomes sacred when automated with consciousness."*

**— Hermetic Daily Automation System, 2025-10-30**
