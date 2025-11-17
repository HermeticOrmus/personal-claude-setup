# Salvador Portfolio Monitor - Setup Guide

> **Quick implementation guide for Salvador's interactive portfolio tracker**

---

## 📋 Setup Checklist

- [ ] **Step 1**: Execute Supabase schema (2 min)
- [ ] **Step 2**: Insert Salvador's initial positions (3 min)
- [ ] **Step 3**: Get Salvador's Telegram user ID (2 min)
- [ ] **Step 4**: Create Telegram webhook workflow (15 min)
- [ ] **Step 5**: Test with Salvador (5 min)

**Total time**: ~30 minutes

---

## Step 1: Execute Supabase Schema

### Option A: Supabase SQL Editor (Recommended)

1. **Open Supabase SQL Editor**:
   - Go to: https://supabase.com/dashboard/project/repzrsqutuktdzzxoiio/sql/new
   - Or: Dashboard → SQL Editor → New Query

2. **Copy and paste** the entire contents of `SALVADOR-PORTFOLIO-SCHEMA.sql`

3. **Run the query** (Ctrl+Enter or click "Run")

4. **Verify tables created**:
   ```sql
   SELECT table_name FROM information_schema.tables
   WHERE table_schema = 'public'
   AND table_name LIKE 'salvador%';
   ```

   Should return:
   - `salvador_positions`
   - `salvador_position_snapshots`

### Option B: Via n8n Workflow (Alternative)

If you prefer automation, I can create an n8n workflow that executes the schema.

---

## Step 2: Insert Salvador's Initial Positions

You'll need to provide Salvador's current holdings. For each position:
- Ticker symbol
- Number of shares
- Cost basis (price paid per share)
- Purchase date
- Optional notes

### Example Data Format:

```sql
INSERT INTO salvador_positions (ticker, shares, cost_basis, total_cost, purchase_date, notes) VALUES
('NVDA', 10.0000, 500.00, 5000.00, '2025-01-15', 'Long-term AI play'),
('TSLA', 5.0000, 250.00, 1250.00, '2025-02-01', 'EV sector exposure'),
('SCHB', 100.0000, 55.00, 5500.00, '2025-01-10', 'Broad market ETF');
```

### How to Insert:

1. Open Supabase SQL Editor
2. Replace the example data above with Salvador's actual positions
3. Calculate `total_cost = shares * cost_basis` for each row
4. Run the INSERT statement
5. Verify:
   ```sql
   SELECT * FROM salvador_positions WHERE status = 'active';
   ```

---

## Step 3: Get Salvador's Telegram User ID

### Method 1: Via Bot (Easiest)

1. **Have Salvador message the bot**: Ask Salvador to send any message to the Hermetic Market Teacher bot on Telegram

2. **Get his user ID from n8n webhook**:
   - I can create a simple workflow that logs incoming messages
   - His user ID will appear in the webhook data as `message.from.id`

### Method 2: Via @userinfobot (Alternative)

1. **Salvador messages @userinfobot** on Telegram
2. Bot replies with user info including ID
3. Share that ID with you

### Method 3: Manual Test

Once the workflow is created, Salvador can message `/start` and the workflow will reply with his user ID for verification.

---

## Step 4: Create Telegram Webhook Workflow

I'll create this workflow with the following structure:

```
Telegram Webhook Trigger
    │
    ├─→ Validate User (Salvador's chat ID)
    │       │
    │       ├─ Match → Continue
    │       └─ No Match → "Access denied"
    │
    ├─→ Parse Message
    │       │
    │       ├─ Command (/position, /performance, etc.)
    │       └─ Natural language (AI parsing)
    │
    ├─→ Supabase: Fetch Salvador's Positions
    │
    ├─→ HTTP Request: Get Current Prices (Yahoo Finance)
    │
    ├─→ Calculate P&L
    │       │
    │       ├─ Current value per position
    │       ├─ Unrealized P/L per position
    │       ├─ Total portfolio value
    │       └─ Total P/L %
    │
    ├─→ Generate Response
    │       │
    │       ├─ Command → Structured format
    │       └─ Natural language → OpenAI GPT-4o mini
    │
    └─→ Send to Telegram
```

**What I need from you**:
- Salvador's Telegram user ID (from Step 3)
- Confirmation that positions are inserted (from Step 2)

---

## Step 5: Test With Salvador

Once the workflow is created:

1. **Salvador sends**: `/position`
2. **Bot should reply** with formatted position data
3. **Salvador sends**: "How am I doing?"
4. **Bot should reply** with AI-generated analysis

### Test Commands:

```
/position   - Show all positions and P&L
/performance - Performance metrics
/holdings   - List stocks owned
/help       - Show available commands
```

### Test Natural Language:

```
"How's NVDA doing today?"
"What stocks do I own?"
"Am I beating the market?"
"Should I sell anything?"
```

---

## 🔐 Security Configuration

**Allowed Users**:
- Salvador's chat ID (primary user)
- Your chat ID: `1540112442` (admin access)

**Authentication**:
- Automatic via Telegram chat ID validation
- No passwords or login needed
- Each message verified against allowed user list

**Admin Commands** (your access only):
- `/admin_add_position TICKER SHARES PRICE DATE`
- `/admin_update_position TICKER NEW_SHARES`
- `/admin_close_position TICKER EXIT_PRICE`
- `/admin_snapshot` (force immediate snapshot)

---

## 📊 Data Flow

### Daily Snapshot Process (Automated)

After setup, a separate workflow will run daily:

1. **Trigger**: 4:30 PM ET (after market close)
2. **Fetch**: All active positions from Supabase
3. **Get prices**: Current closing prices from Yahoo Finance
4. **Calculate**: Current value, unrealized P&L, % return
5. **Store**: Snapshot in `salvador_position_snapshots`

This creates historical record for:
- "How was I doing 30 days ago?"
- "What's my best month?"
- Performance charts over time

---

## 💬 Example Interactions

### `/position` Command

```
📊 Salvador's Portfolio | Nov 4, 2025 2:30 PM ET

💰 TOTAL VALUE: $12,450.00
📈 UNREALIZED P&L: +$2,450.00 (+24.5%)

Holdings:
━━━━━━━━━━━━━━━━━━━━━━━━━━
🟢 NVDA - NVIDIA
10.00 shares @ $683.45 = $6,834.50
Cost basis: $500.00/sh ($5,000.00 total)
P&L: +$1,834.50 (+36.7%) 📈

🟢 TSLA - Tesla
5.00 shares @ $275.20 = $1,376.00
Cost basis: $250.00/sh ($1,250.00 total)
P&L: +$126.00 (+10.1%) 📈

🟢 SCHB - Schwab Broad Market ETF
100.00 shares @ $58.25 = $5,825.00
Cost basis: $55.00/sh ($5,500.00 total)
P&L: +$325.00 (+5.9%) 📈

━━━━━━━━━━━━━━━━━━━━━━━━━━
🔱 Hermetic Market Teacher
Managing $10,000 → Now worth $12,450
```

### Natural Language Query

**Salvador**: "How's NVDA doing today?"

**Bot**:
```
📊 NVDA Update | Nov 4, 2025 2:31 PM ET

Your Position:
• 10 shares @ $683.45 = $6,834.50
• Cost basis: $500.00/sh
• Unrealized P&L: +$1,834.50 (+36.7%)

Today's Movement:
• NVDA: $683.45 (+2.1%)
• RSI: 68 ✅ (neutral, room to run)
• Volume: 2.1x average ⚡ (high conviction)

Market Context:
Tech sector leading today (75% bullish), overall market breadth mixed (42% bullish). NVDA is a top 5 gainer in this morning's 105-stock scan.

Your NVDA position is strong. Whether to hold/sell depends on your goals and risk tolerance. I can't advise, but the data shows continued strength.
```

---

## 🎯 Integration with Morning Brief

Salvador's queries will include context from the Morning Intelligence Brief:

- His portfolio performance
- How his specific stocks performed in the 105-ticker scan
- Relevant market breadth signals
- Sector rotation insights

Example:
```
Your NVDA position is up +36.7%.

From this morning's scan:
• NVDA was #1 top gainer (+3.2%)
• Tech sector: 75% bullish (strong)
• Market breadth: 42% bullish (mixed)

Interpretation: Your position is strong and leading the market, but watch for narrow rally warnings if breadth stays weak.
```

---

## 🚀 Next Steps

**Ready to proceed?**

Provide:
1. ✅ Salvador's Telegram user ID
2. ✅ His current positions (ticker, shares, cost basis, purchase date)

I'll immediately create:
1. ✅ Supabase schema (DONE - `SALVADOR-PORTFOLIO-SCHEMA.sql`)
2. Interactive Telegram webhook workflow
3. AI-powered question handler
4. Daily snapshot automation
5. Admin commands for position management

---

**Philosophy**: Gold Hat - Transparency, Education, Empowerment
**Tool**: Hermetic Market Teacher (extended for personal portfolio management)
**Benefit**: Salvador gets professional-grade portfolio monitoring for his account

🔱 **Sacred Technology in Service of Transparency** 🔱
