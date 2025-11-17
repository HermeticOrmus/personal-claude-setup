# Hermetic Market Teacher - Quick Reference

## 🔑 Your Credentials

**Alpha Vantage API Key:**
```
MOBYBND95AVXG0HI
```

**TwelveData API Key:**
```
97a0c2fef2054df08741d31e4d51e166
```

**API Limits:**
- Alpha Vantage: 25 calls/day (free tier)
- TwelveData: 800 credits/day (free tier)

---

## 📁 File Locations

**Main Documentation:**
```
C:\Users\ormus\.hermetic\trading\HERMETIC-MARKET-TEACHER-OS.md
```

**10-Minute Setup Guide:**
```
C:\Users\ormus\.hermetic\trading\SETUP-NOW-10-MINUTES.md
```

**Working Workflow:**
```
C:\Users\ormus\.hermetic\trading\workflows\morning-intelligence-brief-READY.json
```

**Quick Start:**
```
C:\Users\ormus\.hermetic\trading\QUICKSTART-IMPLEMENTATION.md
```

---

## ⚡ Quick Setup (10 Minutes)

1. **Get Telegram Bot Token** (3 min)
   - Message @BotFather: `/newbot`
   - Save token

2. **Get Chat ID** (2 min)
   - Send `/start` to your bot
   - Visit: `https://api.telegram.org/bot<TOKEN>/getUpdates`
   - Copy chat ID number

3. **Configure n8n** (5 min)
   - Import workflow JSON
   - Add Telegram credentials
   - Replace chat ID in "Send to Telegram" node
   - Test manually
   - Activate schedule

**Done!** Monday 9 AM you'll receive your first brief.

---

## 📊 What You Get Daily

**Morning Intelligence (9:00 AM ET)**
- SPY price, change, volume
- RSI indicator (overbought/oversold)
- 20-day moving average trend
- Market mood assessment
- Educational teaching moment

**Message Format:**
```
🌅 MORNING INTELLIGENCE | [Date]

📊 MARKET PULSE
SPY: $XXX.XX (+/-X.XX%)
Volume: [volume] [context]

📈 TECHNICAL PICTURE
Mood: [BULLISH/BEARISH/NEUTRAL]
RSI: [value] [interpretation]
Trend: [ABOVE/BELOW 20-day SMA]

🎓 TEACHING:
[Context-aware market lesson]
[Connected to Hermetic Principle]

🔱 Hermetic Market Teacher
```

---

## 🎯 Understanding Indicators

**RSI (Relative Strength Index):**
- Below 30: Oversold (potential bounce)
- 30-70: Neutral (normal range)
- Above 70: Overbought (potential pullback)

**20-Day SMA (Simple Moving Average):**
- Price above: Uptrend
- Price below: Downtrend
- Acts as support/resistance

**Volume:**
- 1.5x+ average: High conviction move
- 0.8x- average: Low conviction move
- Confirms or contradicts price action

**Market Mood:**
- BULLISH: Positive momentum + room to run
- BEARISH: Selling pressure
- OVERBOUGHT: Strong but extended
- OVERSOLD: Weak but potential bounce
- NEUTRAL: Sideways, wait for clarity

---

## 🔧 Troubleshooting

**"No message received"**
→ Check: Bot token, Chat ID, Credentials linked

**"API error"**
→ Check: API key correct, Rate limit not exceeded

**"Workflow failed"**
→ Check: n8n execution logs, Node error messages

**Test Telegram manually:**
```bash
curl -X POST "https://api.telegram.org/bot<TOKEN>/sendMessage?chat_id=<CHAT_ID>&text=Test"
```

---

## 📚 Next Workflows to Add

**Week 1:**
1. ✅ Morning Intelligence (DONE)
2. Multi-Indicator Scanner (hourly)

**Week 2:**
3. Sentiment Aggregation
4. News Catalyst Scanner

**Week 3:**
5. AI Market Synthesis
6. Portfolio Risk Dashboard

**Week 4:**
7. Weekly Performance Review
8. Paper Trading Integration

---

## 🎓 The 7 Hermetic Principles

**1. Mentalism** - Clear thinking before trading
**2. Correspondence** - Patterns repeat across scales
**3. Vibration** - Ship, learn, iterate
**4. Polarity** - Balance opposing forces
**5. Rhythm** - Honor market cycles
**6. Cause & Effect** - Every action has consequences
**7. Gender** - Balance analysis with intuition

Every workflow embodies these principles.

---

## 💡 Customization

**Change Schedule:**
- Edit cron expression in Schedule node
- Format: `minute hour * * days`
- Example: `30 8 * * 1-5` = 8:30 AM Mon-Fri

**Add More Tickers:**
- Duplicate HTTP Request nodes
- Change symbol in URL
- Connect to indicator calculation

**Adjust Thresholds:**
- Edit Code node
- Change RSI levels (30/70)
- Change volume multiplier (1.5x)

---

## 📞 Support

**Documentation:**
See `HERMETIC-MARKET-TEACHER-OS.md` for complete architecture

**n8n Issues:**
https://docs.n8n.io/

**Telegram Bot Issues:**
https://core.telegram.org/bots

---

## 🔱 Remember

**This is not a "hot tips" service.**
**This is a teaching system.**

- Every message explains WHY
- Every indicator is educational
- Every lesson builds wisdom
- Capital is sacred trust

**Trade with consciousness.**
**Learn with discipline.**
**Build with patience.**

---

**Last Updated**: November 2025
**Status**: Ready for Import
**Next Step**: Follow SETUP-NOW-10-MINUTES.md

🔱 **Sacred Technology meets Market Intelligence** 🔱
