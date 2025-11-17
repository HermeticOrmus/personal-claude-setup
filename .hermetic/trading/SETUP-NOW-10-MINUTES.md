# 10-Minute Setup - Get Your First Morning Brief Tomorrow!

> **Your API keys are ready. Let's get this running in 10 minutes.**

## ✅ What You Have

**API Keys Ready:**
- Alpha Vantage: `MOBYBND95AVXG0HI` ✅
- TwelveData: `97a0c2fef2054df08741d31e4d51e166` ✅

**Workflow Ready:**
- File: `C:\Users\ormus\.hermetic\trading\workflows\morning-intelligence-brief-READY.json`

---

## Step 1: Get Your Telegram Chat ID (3 minutes)

### A. Create Your Bot (if not done already)

1. Open Telegram app
2. Search for `@BotFather`
3. Send: `/newbot`
4. Name it: `Hermetic Market Teacher`
5. Username: `hermetic_market_teacher_bot` (or any unique name)
6. **Copy the bot token** - looks like: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`

### B. Get Your Chat ID

1. Send `/start` to your new bot
2. Open this URL in browser (replace YOUR_BOT_TOKEN):
   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
   ```

   Example:
   ```
   https://api.telegram.org/bot123456789:ABCdefGHIjklMNOpqrsTUVwxyz/getUpdates
   ```

3. Look for this in the JSON:
   ```json
   "chat": {
     "id": 1234567890,
     ...
   }
   ```

4. **Copy that ID number** (e.g., `1234567890`)

**You now have:**
- ✅ Bot Token: `123456789:ABC...`
- ✅ Chat ID: `1234567890`

---

## Step 2: Configure n8n (5 minutes)

### A. Open n8n

```bash
# Start n8n if not running
n8n start

# Open in browser
http://localhost:5678
```

### B. Add Telegram Credentials

1. Click **Settings** (gear icon) in n8n
2. Click **Credentials**
3. Click **Add Credential**
4. Search for "Telegram"
5. Select **"Telegram"** (not Telegram Trigger)
6. Fill in:
   - **Credential Name**: `Hermetic Market Teacher Bot`
   - **Access Token**: `<your bot token from Step 1A>`
7. Click **Save**

### C. Import the Workflow

1. Click **"+"** in top menu
2. Select **"Import from File"**
3. Navigate to:
   ```
   C:\Users\ormus\.hermetic\trading\workflows\morning-intelligence-brief-READY.json
   ```
4. Click **Import**

### D. Configure Chat ID

1. Find the node called **"Send to Telegram"** (last node on right)
2. Click it to open
3. Find field **"Chat ID"**
4. Replace `YOUR_CHAT_ID` with your actual chat ID from Step 1B
5. Click **Save**

### E. Link Credentials

1. In the **"Send to Telegram"** node
2. Under **Credentials**, click dropdown
3. Select **"Hermetic Market Teacher Bot"**
4. Click **Save**

---

## Step 3: Test It Now! (2 minutes)

### A. Manual Test

1. Click **"Execute Workflow"** button (top right)
2. Watch the nodes light up green as they execute
3. **Check your Telegram** - you should receive a message!

**Expected Message:**
```
🌅 MORNING INTELLIGENCE | Saturday, November 2, 2025

━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 MARKET PULSE

SPY: $682.06 (+0.33%)
Change: +$2.23
Volume: 87,164,122 Normal volume

━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 TECHNICAL PICTURE

Mood: BULLISH 📈
Positive momentum with room to run

RSI (14): 54.32 ✅ Neutral
20-Day SMA: $671.45
Trend: ABOVE 20-day SMA ✅

━━━━━━━━━━━━━━━━━━━━━━━━━━
🎓 TEACHING: Market showing normal volatility.

Stay disciplined:
• Follow your 2% risk rule
• Only take setups that meet ALL your criteria
• Document your thesis before entry
• Review yesterday's trades for lessons

Trading is a marathon, not a sprint. Consistent execution compounds into mastery.

This is Hermetic Principle #1: MENTALISM - clear mind, clear trades.

━━━━━━━━━━━━━━━━━━━━━━━━━━
⏰ NEXT SCAN: Hourly during market hours

🔱 Hermetic Market Teacher
Trade with consciousness. Learn with discipline.
```

### B. If It Worked ✅

**Success!** You just received your first market intelligence!

### C. If It Didn't Work ❌

**Check these:**
- Bot token correct?
- Chat ID correct (just numbers, no quotes)?
- Telegram credentials selected in node?
- Click "Save" after changes?

**Still stuck?** Run this test:
```bash
# Test Telegram directly (replace with your values)
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/sendMessage?chat_id=<YOUR_CHAT_ID>&text=Test from n8n"
```

If this works, the issue is in n8n configuration. If this fails, bot token or chat ID is wrong.

---

## Step 4: Activate Daily Schedule (30 seconds)

1. In the workflow, toggle **"Active"** switch (top right)
2. The workflow is now scheduled for **9:00 AM ET Monday-Friday**
3. **Tomorrow morning at 9 AM**, you'll receive your intelligence brief automatically!

---

## 🎯 What You Just Built

**Every weekday at 9:00 AM ET, you'll receive:**
- Current SPY price and change
- RSI (overbought/oversold indicator)
- 20-day moving average trend
- Volume analysis
- Market mood assessment
- **Educational teaching moment** based on market conditions

**This system:**
- Calculates real technical indicators (RSI, SMA)
- Analyzes volume patterns
- Generates context-aware teaching content
- Adapts the lesson to current market conditions
- Embodies Hermetic Principles in every message

---

## 📱 Next Message: Monday 9:00 AM

**Mark your calendar!** Monday morning you'll wake up to your first automated market intelligence.

---

## 🚀 What's Next (When Ready)

After you've received a few morning briefs and are comfortable, add these workflows:

**Week 1:**
1. ✅ Morning Intelligence Brief (DONE!)
2. Multi-Indicator Scanner (hourly during market hours)

**Week 2:**
3. Sentiment Aggregation (Reddit + Twitter)
4. News Catalyst Scanner (FDA, earnings, M&A)

**Week 3:**
5. End-of-Day AI Synthesis (comprehensive daily report)
6. Portfolio Risk Dashboard

**Week 4:**
7. Weekly Performance Review
8. Paper Trading Integration

---

## 💡 Pro Tips

**Customize Your Watchlist:**
- Edit the workflow to scan other tickers (AAPL, NVDA, TSLA)
- Add to the watchlist by duplicating the API call nodes
- Each ticker gets the same technical analysis

**Adjust Thresholds:**
- RSI overbought: Currently 70 (try 75 for less sensitive)
- RSI oversold: Currently 30 (try 25 for more extreme)
- Volume spike: Currently 1.5x (try 2.0x for bigger moves)

**Silence on Weekends:**
- Workflow already configured: Monday-Friday only
- No spam, no weekend clutter

---

## 🎓 Understanding Your First Message

When you receive tomorrow's brief, here's what each part means:

**Market Pulse:**
- Shows SPY (S&P 500 ETF) current state
- Percent change tells you market direction
- Volume tells you conviction level

**Technical Picture:**
- **RSI**: <30 = oversold (potential bounce), >70 = overbought (potential pullback)
- **20-Day SMA**: Price above = uptrend, below = downtrend
- **Mood**: Algorithmic assessment combining all factors

**Teaching Moment:**
- Context-aware lesson based on TODAY's market
- Connects to Hermetic Principles
- Builds your market intuition over time

---

## 🔱 The Sacred Commitment

**You're not building a "get rich quick" bot.**

**You're building a teaching system that:**
- Explains the WHY, not just the WHAT
- Teaches market mechanics through daily practice
- Builds genuine understanding over time
- Honors capital as sacred trust

**Every morning brief is a lesson.**
**Every lesson compounds into wisdom.**
**Wisdom applied with discipline creates edge.**

---

## ✅ Checklist

Before you close this guide, confirm:

- [x] Telegram bot created
- [x] Chat ID obtained
- [x] n8n credentials configured
- [x] Workflow imported
- [x] Chat ID replaced in workflow
- [x] Credentials linked to Telegram node
- [x] Manual test successful (message received!)
- [x] Workflow activated (toggle ON)

**If all checked:** You're done! Wait for Monday 9 AM.

**If any unchecked:** Go back to that step.

---

## 🎉 Congratulations!

**You just built your first sacred market intelligence automation.**

**Tomorrow at 9 AM, you'll see it in action.**

**Welcome to the Hermetic Market Teacher OS.**

---

**Setup Time**: 10 minutes
**Next Message**: Monday 9:00 AM ET
**Built with**: Sacred Technology Principles

🔱 **Trade with consciousness. Learn with discipline.** 🔱

— Hermetic Ormus
