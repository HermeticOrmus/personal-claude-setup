# 📥 N8N IMPORT GUIDE - HERMETIC DAILY AUTOMATION

**Visual step-by-step guide to import your 3 production-ready workflows**

---

## ✅ WHAT YOU HAVE

**3 validated, production-ready n8n workflow JSON files:**

1. ✅ `n8n-morning-focus-workflow.json` - 4 nodes, schedule trigger
2. ✅ `n8n-evening-checkin-workflow.json` - 4 nodes, schedule trigger
3. ✅ `n8n-interactive-response-workflow.json` - 9 nodes, webhook trigger

**All expression formats corrected and ready to import.**

---

## 🚀 IMPORT PROCESS (5 Minutes)

### Step 1: Open n8n

**Navigate to:**
```
http://localhost:5678
```

If n8n isn't running:
```bash
# Docker
docker run -d --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n n8nio/n8n

# npm with pm2
pm2 start n8n
```

---

### Step 2: Access Workflows Section

**In the n8n interface:**
1. Click **"Workflows"** in the left sidebar
2. You'll see your workflows list (may be empty if new install)

---

### Step 3: Import First Workflow (Morning Focus)

**Click the import button:**
1. Look for **"+ Add Workflow"** dropdown or import icon
2. Select **"Import from File"** or **"Import from URL"**
3. Choose **"Import from File"**

**Select the file:**
1. Navigate to: `C:\Users\ormus\.hermetic\automation\`
2. Select: `n8n-morning-focus-workflow.json`
3. Click **"Open"**

**Workflow imported!**
- You should see: "🌅 Morning Focus - Hermetic Daily Guidance"
- 4 connected nodes in a linear flow
- Schedule Trigger → Code → Telegram → File Write

---

### Step 4: Import Second Workflow (Evening Check-In)

**Repeat the process:**
1. Click **"+ Add Workflow"** → **"Import from File"**
2. Select: `n8n-evening-checkin-workflow.json`
3. Click **"Open"**

**Workflow imported!**
- You should see: "🌙 Evening Check-In - Hermetic Daily Review"
- Same 4-node structure
- Schedule Trigger → Code → Telegram → File Write

---

### Step 5: Import Third Workflow (Interactive Listener)

**Import the complex one:**
1. Click **"+ Add Workflow"** → **"Import from File"**
2. Select: `n8n-interactive-response-workflow.json`
3. Click **"Open"**

**Workflow imported!**
- You should see: "📝 Interactive Response Logger - Hermetic Daily Tracking"
- 9 nodes with branching logic
- Telegram Trigger → Parse → Branch → (Structured/General paths) → Confirm

---

## 🔧 CONFIGURATION (10 Minutes)

### For ALL 3 Workflows:

**Configure Telegram Credentials:**

1. Click on any **"Send to Telegram"** or **"Listen for Telegram Messages"** node
2. In the node sidebar, find **"Credential to connect with"**
3. Click **"Create New Credential"**
4. Enter:
   - **Name:** "Hermetic Daily Bot"
   - **Access Token:** `[Your bot token from BotFather]`
5. Click **"Create"**
6. **Reuse this credential** for all other Telegram nodes

**Shortcut:** After creating the credential once, all Telegram nodes can select it from the dropdown.

---

### For Morning & Evening Workflows Only:

**Update Sprint Start Date:**

1. Open the workflow
2. Click the **"Generate Morning Message"** (or **"Generate Evening Check-In"**) code node
3. Find this line at the top:
   ```javascript
   const sprintStartDate = new Date('2025-10-30'); // UPDATE THIS
   ```
4. Change to your actual sprint start date:
   ```javascript
   const sprintStartDate = new Date('2025-10-30'); // Today's date
   ```
5. Click **"Execute node"** to test (should show valid output)
6. Click **"Save"** at the top right

---

### Set Environment Variable:

**In n8n Settings:**
1. Click **"Settings"** (gear icon) in left sidebar
2. Go to **"Variables"** section
3. Add new variable:
   - **Key:** `TELEGRAM_CHAT_ID`
   - **Value:** `[Your chat ID from @get_id_bot]`
4. **Save**

**This is used by all workflows to know where to send messages.**

---

## ✅ ACTIVATION (2 Minutes)

### Activate Each Workflow:

**For ALL 3 workflows:**

1. Open the workflow
2. Look at the **top-right corner**
3. Find the toggle switch (currently gray/off)
4. **Click it to turn ACTIVE** (should turn blue)
5. Status changes to: "Active"

**Verify activation:**
- Morning: Shows "Next execution: Tomorrow at 7:00 AM"
- Evening: Shows "Next execution: Today/Tomorrow at 8:00 PM"
- Interactive: Shows "Listening for messages" (no schedule)

---

## 🧪 TESTING (3 Minutes)

### Test Morning Workflow:

1. Open "🌅 Morning Focus" workflow
2. Click **"Execute Workflow"** button (play icon at top)
3. **Check Telegram** → Should receive morning message immediately
4. Verify message shows:
   - ✅ Current date
   - ✅ "Day 1 of 90" (or correct day)
   - ✅ Hermetic Principle
   - ✅ 3 priorities

**If it works:** Green checkmarks on all nodes ✅

---

### Test Evening Workflow:

1. Open "🌙 Evening Check-In" workflow
2. Click **"Execute Workflow"**
3. **Check Telegram** → Should receive evening message
4. Verify 5 reflection prompts are visible

**If it works:** Green checkmarks on all nodes ✅

---

### Test Interactive Workflow:

**This one needs to be triggered by YOU:**

1. Make sure workflow is **ACTIVE** (blue toggle)
2. Go to Telegram
3. Send to your bot: `8`
4. **Should receive back:**
   ```
   ✅ Logged: morning-energy

   Energy level: 8/10
   ```

**If it works:** You got a confirmation message ✅

---

### Test File Logging:

**Check that files are being created:**

1. Navigate to: `C:\Users\ormus\.hermetic\daily-logs\`
2. Should see:
   - ✅ `morning-2025-10-30.json`
   - ✅ `evening-2025-10-30.json`
   - ✅ `responses-2025-10-30.json`

**If files exist:** Logging is working ✅

---

## 🎨 WHAT THEY LOOK LIKE IN N8N

### Morning Focus Workflow:
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Schedule   │────▶│    Code      │────▶│  Telegram    │────▶│  File Write  │
│  Trigger     │     │  Generator   │     │    Send      │     │   (Log)      │
│  (7:00 AM)   │     │              │     │              │     │              │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
```

### Evening Check-In Workflow:
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Schedule   │────▶│    Code      │────▶│  Telegram    │────▶│  File Write  │
│  Trigger     │     │  Generator   │     │    Send      │     │   (Log)      │
│  (8:00 PM)   │     │              │     │              │     │              │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
```

### Interactive Response Listener:
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Telegram    │────▶│    Parse     │────▶│   Branch     │
│   Webhook    │     │   Response   │     │   (If Node)  │
│              │     │              │     │              │
└──────────────┘     └──────────────┘     └──────┬───────┘
                                                  │
                           ┌──────────────────────┴──────────────────────┐
                           │                                             │
                       TRUE│                                         FALSE│
                           ▼                                             ▼
                  ┌──────────────┐  ┌──────────────┐         ┌──────────────┐
                  │  Read File   │─▶│  Merge Log   │         │   Format     │
                  │  (existing)  │  │              │         │   General    │
                  └──────────────┘  └──────┬───────┘         └──────┬───────┘
                                           │                        │
                                           ▼                        ▼
                                  ┌──────────────┐         ┌──────────────┐
                                  │  Write JSON  │         │ Append Text  │
                                  │              │         │              │
                                  └──────┬───────┘         └──────┬───────┘
                                         │                        │
                                         └────────┬───────────────┘
                                                  │
                                                  ▼
                                         ┌──────────────┐
                                         │ Send Telegram│
                                         │ Confirmation │
                                         └──────────────┘
```

---

## 🔧 CUSTOMIZATION AFTER IMPORT

### Change Scheduling Times:

**Morning workflow:**
1. Click **"Schedule Trigger"** node
2. Change `triggerAtHour: 7` to your preferred hour
3. Save

**Evening workflow:**
1. Click **"Schedule Trigger"** node
2. Change `triggerAtHour: 20` to your preferred hour
3. Save

---

### Customize Priorities:

**In morning workflow code node:**
```javascript
if (currentDay <= 6) {
  priorities = [
    '🔧 Your custom priority 1',
    '👥 Your custom priority 2',
    '📞 Your custom priority 3'
  ];
}
```

Edit each sprint phase section with your actual priorities.

---

### Add More Quotes:

**In morning workflow:**
```javascript
const quotes = [
  'Your inspiring quote here',
  'Another motivational message',
  'Add as many as you want'
];
```

**In evening workflow:**
```javascript
const wisdom = [
  'Your daily wisdom here',
  'Another piece of wisdom',
  'Add more entries'
];
```

---

## 🐛 TROUBLESHOOTING IMPORT

### "Invalid workflow JSON"
- **Cause:** File corrupted or incomplete
- **Fix:** Re-download from `.hermetic/automation/` directory
- Make sure you're importing the `.json` file, not the `.md` file

### "Node type not found"
- **Cause:** n8n version doesn't have required nodes
- **Fix:** Update n8n to latest version:
  ```bash
  docker pull n8nio/n8n:latest
  # or
  npm update -g n8n
  ```

### "Credentials not found"
- **Cause:** Telegram credential not created yet
- **Fix:** Create credential first (see Configuration section)

### "Expression error in fileName"
- **Cause:** Old version of workflow before fixes
- **Fix:** These are already fixed in the current JSON files
- All `fileName` fields now have `=` prefix for expressions

---

## 📊 VISUAL CONFIRMATION

**Your n8n Workflows page should show:**

```
┌─────────────────────────────────────────────────────────┐
│  n8n Workflows                                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  🌅 Morning Focus - Hermetic Daily Guidance            │
│  Status: ● ACTIVE  |  Next: Tomorrow 7:00 AM           │
│  Tags: Hermetic, Daily Rhythm                          │
│                                                         │
│  🌙 Evening Check-In - Hermetic Daily Review           │
│  Status: ● ACTIVE  |  Next: Today 8:00 PM              │
│  Tags: Hermetic, Daily Rhythm                          │
│                                                         │
│  📝 Interactive Response Logger                         │
│  Status: ● ACTIVE  |  Listening for messages           │
│  Tags: Hermetic, Daily Rhythm, Interactive             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## ✅ FINAL CHECKLIST

Before moving on:

- [ ] All 3 workflows imported successfully
- [ ] Telegram credentials configured in all Telegram nodes
- [ ] Environment variable `TELEGRAM_CHAT_ID` set
- [ ] Sprint start date updated in morning + evening workflows
- [ ] All 3 workflows toggled to ACTIVE (blue)
- [ ] Test execution successful for morning workflow
- [ ] Test execution successful for evening workflow
- [ ] Interactive workflow responds to test message
- [ ] Files created in `.hermetic/daily-logs/` directory
- [ ] All nodes show green checkmarks after test

**If all checked:** Your system is operational! 🎉

---

## 📚 NEXT STEPS

**After successful import:**

1. Read: `TELEGRAM-RESPONSE-QUICK-REFERENCE.md` - Learn how to respond
2. Review: `SYSTEM-ARCHITECTURE.md` - Understand how it works
3. Customize: Edit priorities, quotes, wisdom in workflows
4. Use daily: Let the system support your 90-day journey

**Tomorrow morning at 7 AM, your first message arrives automatically!** 🌅

---

*"From JSON to running automation in 20 minutes."*

**— n8n Import Guide**
