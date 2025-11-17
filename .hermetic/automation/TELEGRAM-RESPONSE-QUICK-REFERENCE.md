# 📱 TELEGRAM RESPONSE QUICK REFERENCE

**How to interact with your Hermetic Daily Automation**

---

## 🌅 MORNING CHECK-IN RESPONSES

### When you receive the morning message:

**Message asks:** "⚡ **ENERGY CHECK:** How's your energy right now? (Reply: 1-10)"

**You reply:**
```
8
```

**System logs:** `morning-energy: 8/10` ✅

---

## 🌙 EVENING CHECK-IN RESPONSES

### 1. How did today go overall?

**Message asks:** "**1. How did today go overall?** _Rate 1-10 (1=disaster, 10=legendary)_"

**You reply:**
```
Today: 7
```

**System logs:** `today-rating: 7/10` ✅

---

### 2. What shipped today?

**Message asks:** "**2. What shipped today?** _What actually got done? Be specific._"

**You reply:**
```
Shipped: Set up Stripe, created discovery call script, sent 5 outreach messages
```

**System logs:** `what-shipped: Set up Stripe, created discovery call script...` ✅

---

### 3. Energy level check?

**Message asks:** "**3. Energy level check?** _How's your energy right now? (1-10)_"

**You reply:**
```
Energy: 6
```

**System logs:** `energy-rating: 6/10` ✅

---

### 4. Did you honor your boundaries?

**Message asks:** "**4. Did you honor your boundaries?** _Sacred constraints: rest, capacity limits, no manipulation_"

**You reply any of:**
```
Boundaries: yes
```
```
Boundaries: no
```
```
Boundaries: mostly
```

**System logs:** `boundaries-check: yes` ✅

---

### 5. Client/Lead activity today?

**Message asks:** "**5. Client/Lead activity today?** _Discovery calls, sessions, outreach sent, responses_"

**You reply:**
```
Client: 2 discovery calls scheduled, 1 session with Maya, 3 outreach responses
```

**System logs:** `client-activity: 2 discovery calls scheduled...` ✅

---

## 💬 GENERAL REFLECTIONS

**Any message that doesn't match the patterns above is saved as a general reflection:**

**You send:**
```
Feeling stuck on the outreach messaging. The script feels too formal. Need to make it more personal and authentic.
```

**System logs to:** `general-reflections-2025-10-30.txt` with timestamp ✅

---

## 📊 WHAT GETS LOGGED WHERE

### Structured Responses → JSON
File: `C:/Users/ormus/.hermetic/daily-logs/responses-2025-10-30.json`

Contains:
- Morning energy ratings
- Today's overall ratings
- Evening energy ratings
- What shipped
- Boundary checks
- Client activity

All with timestamps and sprint day tracking.

### General Reflections → Text
File: `C:/Users/ormus/.hermetic/daily-logs/general-reflections-2025-10-30.txt`

Contains:
- Free-form thoughts
- Reflections on progress
- Blockers and challenges
- Insights and breakthroughs

All with timestamps.

---

## ✅ CONFIRMATION MESSAGES

Every response gets acknowledged:

**You send:** `8`
**Bot replies:**
```
✅ Logged: morning-energy

Energy level: 8/10
```

**You send:** `Shipped: Set up Stripe and sent outreach`
**Bot replies:**
```
✅ Logged: what-shipped

Shipped: Set up Stripe and sent outreach
```

This confirms the system heard you and logged correctly.

---

## 🎯 RESPONSE PATTERNS CHEAT SHEET

| What You Want to Log | How to Format It | Example |
|---------------------|------------------|---------|
| Morning energy | Just the number | `8` |
| Today's rating | `Today: [number]` | `Today: 7` |
| Evening energy | `Energy: [number]` | `Energy: 6` |
| What shipped | `Shipped: [text]` | `Shipped: Created script` |
| Boundaries | `Boundaries: [yes/no/mostly]` | `Boundaries: yes` |
| Client activity | `Client: [text]` or `Lead: [text]` | `Client: 2 calls scheduled` |
| General reflection | Anything else | `Need to revisit the script` |

---

## 💡 PRO TIPS

**1. You can send multiple responses in sequence:**
```
8
```
*(system confirms)*
```
Feeling energized to start Sprint 1 today. Ready to build infrastructure.
```
*(system logs both)*

**2. You don't need to wait for check-in messages:**
Send responses anytime during the day. The system timestamps everything.

**3. Mix structured and general:**
```
Today: 8
```
```
Really proud of the outreach I sent today. They felt authentic and aligned.
```

**4. Use voice-to-text:**
The system handles natural language well. Don't stress about formatting.

**5. Check confirmations:**
If you don't get a confirmation, the message might not have been logged. Resend.

---

## 🚨 TROUBLESHOOTING

**Problem:** "I sent a response but got no confirmation"

**Check:**
- Is the Interactive Response Workflow active in n8n?
- Is n8n running continuously?
- Did you message the correct bot?

**Fix:**
- Activate the workflow in n8n
- Keep n8n running (use `pm2` or Docker detached mode)
- Verify bot token is correct

---

**Problem:** "System logged the wrong response type"

**Example:** You sent `Today: 8` but it logged as general reflection.

**Fix:**
- Check your formatting (colon after keyword)
- The patterns are case-insensitive, so `today: 8` or `TODAY: 8` both work
- If it logged to general reflections, that's fine - you still have the data

---

**Problem:** "Where are my logs?"

**Location:**
```
C:/Users/ormus/.hermetic/daily-logs/
```

**Files:**
- `responses-[date].json` - Structured data
- `general-reflections-[date].txt` - Free-form thoughts

---

## 🌟 EXAMPLE DAILY FLOW

**7:00 AM - Morning message arrives:**

You reply:
```
8
```

Confirmation: ✅ Logged: morning-energy

---

**Throughout the day - spontaneous reflections:**

You send:
```
Just finished setting up Stripe. Feels good to have infrastructure coming together.
```

Confirmation: ✅ Logged: general

---

**8:00 PM - Evening message arrives:**

You reply in sequence:
```
Today: 8
```
```
Shipped: Stripe setup, discovery call script, 5 outreach messages
```
```
Energy: 7
```
```
Boundaries: yes
```
```
Client: 5 outreach sent, 2 responses received, 1 call scheduled for tomorrow
```

Each gets its own confirmation. ✅

---

**Later that evening:**

You reflect:
```
The outreach responses were encouraging. People are genuinely interested. Feeling aligned with the mission.
```

Confirmation: ✅ Logged: general

---

## 📈 USING YOUR DATA

Once you have a week of logs:
1. Review your energy patterns (morning vs evening)
2. See what you actually shipped vs. what you planned
3. Check boundary adherence
4. Track client acquisition velocity

**Next level:** Build analytics workflows that read these logs and generate insights.

---

*"Data-driven self-awareness through sacred automation."*

**— Hermetic Daily Rhythm System**
