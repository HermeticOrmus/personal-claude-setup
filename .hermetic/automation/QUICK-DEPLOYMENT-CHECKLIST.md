# ⚡ QUICK DEPLOYMENT CHECKLIST

**Get your Hermetic Daily Automation running in 30 minutes**

---

## ☑️ PRE-DEPLOYMENT (5 minutes)

### 1. Install n8n
```bash
# Option A: Docker (recommended)
docker run -d --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n n8nio/n8n

# Option B: npm
npm install -g n8n
pm2 start n8n
```

### 2. Create Telegram Bot
1. Open Telegram → Message `@BotFather`
2. Send `/newbot`
3. Follow prompts → Name: "Hermetic Daily Coach Bot"
4. **SAVE BOT TOKEN** → `123456789:ABCdefGHI...`

### 3. Get Your Chat ID
1. Message `@get_id_bot`
2. Send any message
3. **SAVE CHAT ID** → `123456789`

---

## ☑️ DEPLOYMENT (15 minutes)

### 4. Set Environment Variable in n8n
1. Open `http://localhost:5678`
2. Settings → Variables
3. Add: `TELEGRAM_CHAT_ID` = `[your chat ID]`
4. Save

### 5. Import Workflows
1. Workflows → Import from File
2. Import all 3 files:
   - ✅ `n8n-morning-focus-workflow.json`
   - ✅ `n8n-evening-checkin-workflow.json`
   - ✅ `n8n-interactive-response-workflow.json`

### 6. Configure Telegram Credentials (All 3 Workflows)
**For EACH workflow:**
1. Click "Send to Telegram" node
2. Create New Credential
3. Enter Bot Token from step 2
4. Save
5. Test connection (should show ✅)

### 7. Update Sprint Start Date (2 Workflows)
**Morning workflow:**
1. Click "Generate Morning Message" code node
2. Find line: `const sprintStartDate = new Date('2025-10-30');`
3. Change to TODAY'S DATE
4. Save

**Evening workflow:**
1. Click "Generate Evening Check-In" code node
2. Find line: `const sprintStartDate = new Date('2025-10-30');`
3. Change to TODAY'S DATE
4. Save

### 8. Create Log Directory
```bash
mkdir -p C:/Users/ormus/.hermetic/daily-logs
```

### 9. Activate All Workflows
**For EACH workflow:**
1. Toggle switch at top to **ACTIVE** (blue)
2. Verify:
   - Morning: 7:00 AM schedule ✅
   - Evening: 8:00 PM schedule ✅
   - Interactive: Webhook active ✅

---

## ☑️ VERIFICATION (10 minutes)

### 10. Test Morning Workflow
1. Click "Execute Workflow" button (play icon)
2. Check Telegram → Should receive morning message ✅
3. Verify message shows:
   - Correct date ✅
   - "Day 1 of 90" (or current day) ✅
   - Today's Hermetic Principle ✅
   - Top 3 priorities ✅

### 11. Test Evening Workflow
1. Click "Execute Workflow" button
2. Check Telegram → Should receive evening message ✅
3. Verify message shows:
   - 5 reflection prompts ✅
   - Daily wisdom ✅

### 12. Test Interactive Workflow
1. Send to your bot: `8`
2. Should receive: "✅ Logged: morning-energy" ✅
3. Send: `Shipped: Testing the system`
4. Should receive: "✅ Logged: what-shipped" ✅

### 13. Verify Logging
1. Check directory: `C:/Users/ormus/.hermetic/daily-logs/`
2. Should contain:
   - `morning-[today's date].json` ✅
   - `evening-[today's date].json` ✅
   - `responses-[today's date].json` ✅

---

## ☑️ DAILY USAGE

### Morning (7 AM - automatic)
- Receive message
- Read priorities
- Reply: `8` (your energy level)
- Get confirmation ✅

### Throughout Day (optional)
- Send reflections anytime
- All logged with timestamps
- Get confirmations

### Evening (8 PM - automatic)
- Receive prompts
- Reply to each:
  - `Today: 8`
  - `Shipped: [what you did]`
  - `Energy: 7`
  - `Boundaries: yes`
  - `Client: [activity]`
- Get confirmations ✅

---

## 🎯 SUCCESS CRITERIA

**System is working if:**
- [x] All 3 workflows show "ACTIVE" (blue toggle)
- [x] Test messages received immediately
- [x] Responses get confirmed
- [x] Files appear in daily-logs directory
- [x] Sprint day calculation is correct

**You're ready for Day 1 of 90!** 🔱

---

## 🐛 QUICK TROUBLESHOOTING

**❌ No message received:**
- Check workflow is ACTIVE (blue toggle)
- Verify Bot Token is correct
- Message your bot `/start` first
- Check n8n is running continuously

**❌ "Day NaN of 90" in message:**
- Sprint start date is wrong format
- Use: `new Date('YYYY-MM-DD')`
- Should be: `new Date('2025-10-30')`

**❌ No confirmation when replying:**
- Check Interactive workflow is ACTIVE
- Verify webhook is configured
- Try restarting n8n

**❌ Files not created:**
- Check directory exists: `C:/Users/ormus/.hermetic/daily-logs/`
- Verify n8n has write permissions
- Check file paths in workflow nodes

---

## 📚 NEXT STEPS

**After deployment:**
1. Read: `TELEGRAM-RESPONSE-QUICK-REFERENCE.md`
2. Review: `SYSTEM-ARCHITECTURE.md` (optional, for understanding)
3. Customize: Edit priorities, quotes, wisdom in workflows
4. Use daily: Let the system support your 90-day journey

**Full documentation:** `DAILY-AUTOMATION-SETUP-GUIDE.md`

---

## ⏱️ TIME INVESTMENT

**Setup:** 30 minutes today
**Daily usage:** 2 minutes (morning) + 5 minutes (evening)
**Value:** 90 days of data-driven accountability + transformation tracking

**ROI:** Priceless insights on your journey to $5K+ MRR

---

*"30 minutes of setup. 90 days of accountability. A lifetime of transformation."*

**— Quick Deployment Checklist**
