# Import and Run - Get Your First Message in 5 Minutes!

> **Everything is pre-configured. Just import, add bot token, and click run.**

---

## ✅ What's Already Done

**Your Credentials (Pre-Configured in Workflow):**
- ✅ Alpha Vantage API: `MOBYBND95AVXG0HI`
- ✅ Telegram Chat ID: `1540112442`
- ✅ TwelveData API: `97a0c2fef2054df08741d31e4d51e166`

**What You Need:**
- Telegram Bot Token: `8405230034:AAHtxBLtKu0gLwt5_vFTG4V-KA2rOTYfByI`

---

## Step 1: Open n8n (30 seconds)

```bash
# If n8n not running, start it:
n8n start

# Open in browser:
http://localhost:5678
```

---

## Step 2: Add Telegram Credentials (2 minutes)

1. In n8n, click **Settings** (gear icon)
2. Click **Credentials**
3. Click **"+ Add Credential"**
4. Search: `Telegram`
5. Select **"Telegram"** (not Telegram Trigger)
6. Fill in:
   - **Credential Name**: `Hermetic Market Teacher Bot`
   - **Access Token**: `8405230034:AAHtxBLtKu0gLwt5_vFTG4V-KA2rOTYfByI`
7. Click **Save**

✅ **Telegram configured!**

---

## Step 3: Import Pre-Configured Workflow (1 minute)

1. In n8n, click **"+"** (top left)
2. Click **"Import from File"**
3. Browse to:
   ```
   C:\Users\ormus\.hermetic\trading\workflows\READY-TO-IMPORT-NOW.json
   ```
4. Click **Import**
5. Workflow appears with all your settings!

---

## Step 4: Link Telegram Credentials (30 seconds)

1. Click the **"Send to Telegram"** node (last one on right)
2. Under **Credentials**, click dropdown
3. Select **"Hermetic Market Teacher Bot"**
4. Click **Save** (top right)

✅ **Everything connected!**

---

## Step 5: Test Right Now! (30 seconds)

1. Click **"Execute Workflow"** (top right)
2. Watch nodes turn green as they execute
3. **Check your Telegram app!**

**You should receive:**
```
🌅 MORNING INTELLIGENCE | [Today's Date]

━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 MARKET PULSE

SPY: $682.06 (+0.33%)
Change: +$2.23
Volume: 87,164,122
Normal volume

━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 TECHNICAL PICTURE

Mood: BULLISH 📈
Positive momentum with room to run

RSI (14): 54.32 ✅ Neutral
20-Day SMA: $671.45
Trend: ABOVE 20-day SMA ✅

━━━━━━━━━━━━━━━━━━━━━━━━━━
🎓 TEACHING: Market showing normal volatility.

Stay disciplined today:
• Follow your 2% risk rule strictly
• Only take setups meeting ALL criteria
• Document your thesis before entry
• Review yesterday's trades for lessons

Trading is a marathon, not a sprint.
Consistent execution compounds into mastery.

This is Hermetic Principle #1: MENTALISM
Clear mind creates clear trades.

━━━━━━━━━━━━━━━━━━━━━━━━━━
⏰ NEXT SCAN: Hourly during market hours (coming soon)

🔱 Hermetic Market Teacher
Trade with consciousness. Learn with discipline.
```

---

## Step 6: Activate Daily Schedule (10 seconds)

1. Toggle **"Active"** switch (top right) to ON
2. Workflow now runs **Monday-Friday at 9:00 AM ET**

✅ **You're live!**

---

## 🎉 Success! What Just Happened?

**Your Workflow:**
1. Fetches SPY quote from Alpha Vantage
2. Fetches 100 days historical data
3. Calculates RSI (14-period)
4. Calculates 20-day moving average
5. Analyzes volume patterns
6. Determines market mood
7. Generates educational teaching moment
8. Sends formatted message to YOUR Telegram

**Every Weekday at 9 AM ET:**
- Automatic execution
- Fresh market data
- Context-aware teaching
- No manual work required

---

## 🔧 Troubleshooting

### "No message received"
**Check:**
1. Telegram credentials saved?
2. Credentials linked in "Send to Telegram" node?
3. Bot token correct: `8405230034:AAHtxBLtKu0gLwt5_vFTG4V-KA2rOTYfByI`
4. Chat ID showing: `1540112442`

**Test manually:**
```bash
curl -X POST "https://api.telegram.org/bot8405230034:AAHtxBLtKu0gLwt5_vFTG4V-KA2rOTYfByI/sendMessage?chat_id=1540112442&text=Manual test from command line"
```

If this works → n8n configuration issue
If this fails → bot token or chat ID wrong

### "Workflow failed"
1. Click execution in n8n
2. Find red node
3. Read error message
4. Common issues:
   - API rate limit (wait a minute, try again)
   - Credentials not saved
   - Network connection issue

### "Wrong data in message"
- API keys might be rate-limited
- Wait 1 minute between manual tests
- Alpha Vantage free tier: 25 calls/day

---

## 📅 What's Next?

**This Week:**
- Receive morning briefs Monday-Friday
- Observe the teaching moments
- See how market conditions change the lessons

**Next Week:**
- Add Multi-Indicator Scanner (hourly alerts)
- Set up Supabase database (7-minute setup)
- Start logging signals for analysis

**Next Month:**
- Add Sentiment Aggregation (Reddit + Twitter)
- Build Portfolio Risk Dashboard
- Create Weekly Performance Review

---

## 🎓 Your First Week Goals

**Learning Objectives:**
1. Understand what RSI means (practice reading it daily)
2. Observe how RSI correlates with price moves
3. Notice volume patterns (high vs low conviction days)
4. See how teaching moments adapt to conditions
5. Build morning review habit

**Actions:**
1. Read every morning brief
2. Check TradingView to compare (free account)
3. Journal: "What did I learn today?"
4. Note: "Did RSI prediction work out?"
5. Track: "Which teaching moments helped most?"

---

## 💡 Customization (Later)

**Add More Tickers:**
1. Open workflow
2. Duplicate HTTP Request nodes
3. Change `symbol=SPY` to `symbol=AAPL`
4. Connect to indicator calculator
5. Save and test

**Adjust RSI Thresholds:**
1. Open "Calculate Technical Indicators" node
2. Find: `if (rsi < 30)` and `if (rsi > 70)`
3. Change to 25/75 for more extreme signals
4. Save and test

**Change Schedule:**
1. Open "Schedule: 9 AM ET Mon-Fri" node
2. Cron expression: `0 9 * * 1-5`
3. Format: `minute hour * * days`
4. Change to `30 8 * * 1-5` for 8:30 AM
5. Save

---

## 🔱 The Sacred Moment

**You just created your first market intelligence automation.**

**This is not a "hot tips" service.**
**This is a teaching system.**

Every morning:
- You'll learn something new
- You'll see patterns emerge
- You'll build market intuition
- You'll develop discipline

**30 days from now:**
- You'll understand RSI deeply
- You'll recognize market moods
- You'll spot volume confirmations
- You'll think like a trader

**90 days from now:**
- You'll have your own system
- You'll trust your analysis
- You'll trade with consciousness
- You'll honor your capital

---

## ✅ Final Checklist

Before you close this guide:

- [x] n8n running
- [x] Telegram credentials added
- [x] Workflow imported
- [x] Credentials linked to Telegram node
- [x] Manual test successful (message received!)
- [x] Workflow activated (toggle ON)

**All checked?** Perfect. See you Monday at 9 AM. 🌅

**Missing checks?** Go back and complete them.

---

## 🎉 Welcome to Hermetic Market Teacher OS

**You're now part of a different kind of trading education.**

**Not "get rich quick."**
**Not "follow my signals."**
**Not "just trust me."**

**But:**
- Understand the mechanics
- Build genuine skill
- Honor your capital
- Trade with consciousness

**Every morning brief is a lesson.**
**Every lesson compounds into wisdom.**

**Trade with discipline. Learn with humility. Build with patience.**

---

**Setup Time**: 5 minutes
**Next Message**: Monday 9:00 AM ET (automatic)
**Built with**: Sacred Technology Principles

🔱 **Sacred Technology meets Market Intelligence** 🔱

— Hermetic Ormus

---

**Questions?**
- See `QUICK-REFERENCE.md` for cheat sheet
- See `HERMETIC-MARKET-TEACHER-OS.md` for full architecture
- See `SUPABASE-SETUP.md` for database (next step)
