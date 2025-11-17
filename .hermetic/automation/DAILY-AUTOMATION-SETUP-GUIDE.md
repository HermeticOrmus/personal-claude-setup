# 🤖 DAILY AUTOMATION SETUP GUIDE
**Hermetic Daily Rhythm - Morning Focus + Evening Check-In**

---

## 🎯 WHAT YOU'RE BUILDING

Three n8n workflows that automate your daily accountability:

**🌅 Morning (7 AM):**
- Day # of 90-day sprint
- Today's Hermetic Principle focus
- Top 3 priorities for the day
- Energy check-in prompt
- Inspiring quote

**🌙 Evening (8 PM):**
- Reflection prompts (1-10 rating, what shipped, energy level)
- Boundary check (did you honor constraints?)
- Client/lead activity tracking
- Tomorrow preview
- Daily wisdom

**📝 Interactive Response Listener (Always On):**
- Listens for your Telegram replies
- Parses structured responses (ratings, shipped items, boundaries)
- Logs everything to daily files
- Sends confirmation when logged
- Builds historical data automatically

---

## 📋 PREREQUISITES

### 1. **n8n Installed & Running**

If you don't have n8n yet:
```bash
# Option A: Docker (recommended)
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n

# Option B: npm
npm install -g n8n
n8n start
```

Access n8n at: `http://localhost:5678`

### 2. **Telegram Bot Setup**

**Step 1: Create Bot**
1. Open Telegram and message `@BotFather`
2. Send `/newbot`
3. Follow prompts (name your bot: "Hermetic Daily Coach Bot")
4. Save the **Bot Token** (looks like: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`)

**Step 2: Get Your Chat ID**
1. Message `@get_id_bot` on Telegram
2. Send any message
3. Bot will reply with your **Chat ID** (looks like: `123456789`)

### 3. **Environment Variables in n8n**

Add these to your n8n environment:

**Via Docker:**
```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -e TELEGRAM_CHAT_ID="YOUR_CHAT_ID_HERE" \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

**Via n8n Settings:**
1. Go to n8n → Settings → Environments
2. Add variable: `TELEGRAM_CHAT_ID` = `[your chat ID]`

---

## 🚀 INSTALLATION STEPS

### **Step 1: Import Workflows**

1. Open n8n (`http://localhost:5678`)
2. Click **"Workflows"** → **"Import from File"**
3. Import **ALL THREE** workflow files:
   - `n8n-morning-focus-workflow.json`
   - `n8n-evening-checkin-workflow.json`
   - `n8n-interactive-response-workflow.json`

### **Step 2: Set Up Telegram Credentials**

For EACH workflow:

1. Click on the **"Send to Telegram"** node
2. Click **"Create New Credential"**
3. Enter your **Bot Token** from BotFather
4. Click **"Save"**
5. Test the connection

### **Step 3: Update Sprint Start Date**

In BOTH workflows:

1. Click the **"Generate Morning Message"** (or **"Generate Evening Check-In"**) code node
2. Find this line:
   ```javascript
   const sprintStartDate = new Date('2025-10-30');
   ```
3. **Change the date** to your actual sprint start date (probably today)
4. Click **"Save"**

### **Step 4: Create Log Directory**

```bash
mkdir -p C:/Users/ormus/.hermetic/daily-logs
```

This is where your daily check-ins will be saved as JSON.

### **Step 5: Activate Workflows**

For EACH workflow:

1. Toggle the switch at the top to **"Active"**
2. Verify the settings:
   - Morning: 7:00 AM daily schedule
   - Evening: 8:00 PM daily schedule
   - Interactive: Webhook-based (always listening)

### **Step 6: Test Immediately**

Don't wait for the scheduled time!

1. Click the **"Execute Workflow"** button (play icon)
2. You should receive a Telegram message immediately
3. Check that the message looks correct

---

## 📱 HOW THE INTERACTIVE WORKFLOW WORKS

Once activated, the **Interactive Response Listener** automatically detects and logs your replies to the daily check-ins.

### **Structured Response Patterns**

The workflow recognizes these response types:

**1. Morning Energy Check** (just send a number):
```
8
```
→ Logged as: `morning-energy: 8/10`

**2. Today's Rating:**
```
Today: 7
```
→ Logged as: `today-rating: 7/10`

**3. What Shipped:**
```
Shipped: Set up Stripe payment link and sent 5 outreach messages
```
→ Logged as: `what-shipped: Set up Stripe...`

**4. Energy Level:**
```
Energy: 6
```
→ Logged as: `energy-rating: 6/10`

**5. Boundaries Check:**
```
Boundaries: yes
```
→ Logged as: `boundaries-check: yes`

**6. Client Activity:**
```
Client: 2 discovery calls, 1 session with Maya
```
→ Logged as: `client-activity: 2 discovery calls...`

**7. General Reflections** (anything else):
```
Feeling stuck on the outreach messaging. Need to revisit the script.
```
→ Saved to: `general-reflections-[date].txt`

### **What Gets Logged**

**Structured responses** → `responses-2025-10-30.json`:
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
        "shipped": "Set up Stripe payment link...",
        "timestamp": "2025-10-30T20:15:00.000Z"
      }
    }
  ]
}
```

**General reflections** → `general-reflections-2025-10-30.txt`:
```
[07:05] Feeling energized to start the sprint today
[20:15] Feeling stuck on the outreach messaging. Need to revisit the script.
```

### **Confirmation Messages**

Every response gets confirmed:
```
✅ Logged: what-shipped

Shipped: Set up Stripe payment link and sent 5 outreach messages
```

This lets you know the system heard you.

---

## 🎨 CUSTOMIZATION OPTIONS

### **Change the Time**

In the **"Schedule Trigger"** node:

```javascript
// For morning workflow
"triggerAtHour": 7,  // Change to your preferred hour (24-hour format)
"triggerAtMinute": 0

// For evening workflow
"triggerAtHour": 20, // 8 PM = 20 in 24-hour format
"triggerAtMinute": 0
```

### **Adjust Priorities**

The morning message shows priorities based on your sprint day. To customize:

1. Open the **"Generate Morning Message"** code node
2. Find the priorities section:
   ```javascript
   if (currentDay <= 6) {
     priorities = [
       '🔧 Your custom priority 1',
       '👥 Your custom priority 2',
       '📞 Your custom priority 3'
     ];
   }
   ```
3. Update with your actual Week 1 priorities

### **Add More Quotes**

In the **"Generate Morning Message"** code node:

```javascript
const quotes = [
  'Your inspiring quote here',
  'Another motivational message',
  // Add as many as you want
];
```

### **Change Evening Prompts**

In the **"Generate Evening Check-In"** code node, modify the questions to suit your needs.

---

## 📊 VIEWING YOUR LOGS

Every check-in is saved as JSON in:
```
C:/Users/ormus/.hermetic/daily-logs/
```

Files are named:
- `morning-2025-10-30.json`
- `evening-2025-10-30.json`

You can later build a **dashboard workflow** that reads these logs and shows your progress over time.

---

## 🔥 WHAT'S NEXT: ANALYTICS & INSIGHTS

Now that you have interactive logging, you can build analytics workflows:

### **📊 Weekly Summary Dashboard** (coming next)

A workflow that runs every Sunday at 6 PM:
1. Reads all week's check-in logs
2. Calculates average energy levels
3. Counts what shipped
4. Shows Hermetic Principle coverage
5. Sends summary report via Telegram

### **📈 Sprint Progress Tracker**

A workflow that shows:
- Client acquisition velocity (discovery calls → conversions)
- Energy trend analysis (are you burning out?)
- Boundary adherence rate (sustainability check)
- What's actually shipping vs. what's planned

### **🎯 Goal Achievement Monitor**

Tracks your 90-day milestones:
- Day 30: 5+ clients check
- Day 60: 8+ clients check
- Day 90: 10+ clients victory
- Sends encouragement or course-correction alerts

---

## 🐛 TROUBLESHOOTING

### **"Workflow not triggering at scheduled time"**

**Check:**
- Workflow is toggled to "Active"
- n8n is running continuously (not just when you open it)
- Schedule Trigger node shows green checkmark

**Fix:**
- For Docker: Use `docker run -d` (detached mode) instead of `docker run -it`
- For npm: Use `pm2` to keep n8n running:
  ```bash
  npm install -g pm2
  pm2 start n8n
  pm2 save
  pm2 startup
  ```

### **"Telegram message not sending"**

**Check:**
- Bot Token is correct in credentials
- Chat ID environment variable is set correctly
- Bot is not blocked by you on Telegram

**Fix:**
- Message your bot on Telegram first (send `/start`)
- Re-test the Telegram credential connection
- Check n8n logs for error messages

### **"Message says 'Day NaN of 90'"**

**Fix:**
- The sprint start date is incorrect or in wrong format
- Update `sprintStartDate` to valid JavaScript Date format: `YYYY-MM-DD`

---

## 🎯 NEXT LEVEL: WEEKLY SUMMARY WORKFLOW

Once this is running, you can build:

**📊 Weekly Dashboard (Sundays at 6 PM):**
- Read all week's check-in logs
- Calculate average energy levels
- Count what shipped
- Show Hermetic Principle coverage
- Send summary report

Want me to create this?

---

## ✅ VERIFICATION CHECKLIST

Before considering this complete:

- [ ] n8n is running and accessible
- [ ] Telegram bot created and token saved
- [ ] Chat ID obtained
- [ ] Environment variables set in n8n
- [ ] All three workflows imported
- [ ] Telegram credentials configured in all workflows
- [ ] Sprint start date updated in morning + evening workflows
- [ ] Daily logs directory created
- [ ] All three workflows activated (toggle ON)
- [ ] Test execution successful (received messages)
- [ ] Messages look correct and formatted properly
- [ ] Interactive workflow responds to test message
- [ ] Confirmation received when logging response

---

## 🌟 WHAT THIS GIVES YOU

**Daily Rhythm Automation:**
- ✅ Never forget your top priorities
- ✅ Daily Hermetic Principle focus keeps you aligned
- ✅ Evening reflection builds self-awareness
- ✅ Energy tracking prevents burnout
- ✅ Logs create historical data for analysis

**Sustainable Accountability:**
- No manual effort required
- Runs even when you forget
- Data-driven insights over time
- Supports 90-day sprint discipline

**Sacred Technology in Action:**
- Automation serves consciousness (not just productivity)
- Hermetic Principles integrated daily
- Boundaries honored through prompts
- Wisdom delivered consistently

---

## 🔱 HERMETIC PRINCIPLES EMBODIED

**Rhythm:** Daily morning + evening creates sustainable pulse
**Mentalism:** Morning sets mental clarity for the day
**Correspondence:** Daily micro-patterns compound into 90-day macro-success
**Vibration:** Consistent momentum through daily check-ins
**Cause & Effect:** Track your actions and their results
**Polarity:** Balance morning (doing) with evening (reflecting)
**Gender:** Masculine (structure) + Feminine (reflection) = wholeness

---

## 📞 SUPPORT

If you encounter issues:

1. Check n8n logs: `docker logs n8n` or check console output
2. Verify each node executes successfully (green checkmarks)
3. Test Telegram bot independently (message it directly)
4. Ensure environment variables are loaded correctly

---

**Next Steps:**
1. Import all three workflows
2. Configure credentials
3. Activate
4. Test the interactive workflow by sending a message
5. Wait for tomorrow morning's first message! 🌅

**Your complete automation system:**
- 📤 Sends you guidance (morning + evening)
- 📥 Receives your responses (interactive listener)
- 💾 Logs everything automatically
- ✅ Confirms what it heard
- 📊 Ready for analytics workflows

---

*"The daily grind becomes sacred when automated with consciousness."*

**— Hermetic Automation System, 2025-10-30**
