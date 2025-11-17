# Fix Trading Scanner Workflow - Node Configuration Guide

> Step-by-step instructions to fix the 3 Supabase nodes in your workflow

**Workflow URL**: https://ormus.app.n8n.cloud/workflow/iBrk9sTFnR4Y9tw3

---

## Step 0: Set Up Database (5 minutes)

**BEFORE fixing nodes, create the database tables:**

1. Go to Supabase: https://repzrsqutuktdzzxoiio.supabase.co
2. Click **SQL Editor** (left sidebar)
3. Click **New Query**
4. Open: `C:\Users\ormus\.hermetic\trading\TRADING-SCANNER-SUPABASE-SCHEMA.md`
5. Copy the entire SQL schema (starts with `CREATE TABLE`)
6. Paste into Supabase SQL Editor
7. Click **Run** (or Ctrl+Enter)
8. Wait for "Success. No rows returned" message

✅ **Verify**: Click **Table Editor** → You should see 4 new tables:
- `educational_content` (8 rows)
- `wisdom_quotes` (10 rows)
- `market_scans` (0 rows - will populate after first run)
- `stock_signals` (0 rows - optional)

---

## Step 1: Fix "Supabase: Get Educational Content" Node

**Current Problem:** Operation `executeQuery` but missing SQL query

### Fix Instructions:

1. **Open workflow**: https://ormus.app.n8n.cloud/workflow/iBrk9sTFnR4Y9tw3
2. **Click node**: "Supabase: Get Educational Content"
3. **Configure as follows:**

**Resource:** `Database` (select from dropdown)

**Operation:** `Execute Query` (select from dropdown)

**Query:**
```sql
SELECT * FROM educational_content ORDER BY RANDOM() LIMIT 1;
```

4. **Click "Execute Node"** to test
5. **Expected result**: One random educational tip
6. **Click "Save"** (top right)

✅ **Success indicator**: Node executes without error, returns 1 item with `topic`, `content`, `category`, `hermetic_principle` fields

---

## Step 2: Fix "Supabase: Get Wisdom Quote" Node

**Current Problem:** Operation `executeQuery` but missing SQL query

### Fix Instructions:

1. **Click node**: "Supabase: Get Wisdom Quote"
2. **Configure as follows:**

**Resource:** `Database` (select from dropdown)

**Operation:** `Execute Query` (select from dropdown)

**Query:**
```sql
SELECT * FROM wisdom_quotes ORDER BY RANDOM() LIMIT 1;
```

3. **Click "Execute Node"** to test
4. **Expected result**: One random wisdom quote
5. **Click "Save"** (top right)

✅ **Success indicator**: Node executes without error, returns 1 item with `quote`, `author`, `principle` fields

---

## Step 3: Fix "Supabase: Save Scan Results" Node

**Current Problem:** Operation `insert` but missing table and data configuration

### Fix Instructions:

1. **Click node**: "Supabase: Save Scan Results"
2. **Configure as follows:**

**Resource:** `Row` (select from dropdown)

**Operation:** `Insert` (already selected)

**Table:** `market_scans` (type this in the field)

**Columns to Send:** `Define Below`

**Add these columns** (click "Add Column" for each):

| Field Name | Value |
|------------|-------|
| `scan_date` | `={{ $now.format('yyyy-MM-dd') }}` |
| `total_scanned` | `={{ $('Aggregate Market Analysis').item.json.totalScanned }}` |
| `bullish_count` | `={{ $('Aggregate Market Analysis').item.json.bullishCount }}` |
| `bearish_count` | `={{ $('Aggregate Market Analysis').item.json.bearishCount }}` |
| `neutral_count` | `={{ $('Aggregate Market Analysis').item.json.neutralCount }}` |
| `high_volume_count` | `={{ $('Aggregate Market Analysis').item.json.highVolumeCount }}` |
| `market_condition` | `={{ $('Aggregate Market Analysis').item.json.condition }}` |
| `setups` | `={{ JSON.stringify($('Aggregate Market Analysis').item.json.setups) }}` |
| `watchlist` | `={{ JSON.stringify($('Aggregate Market Analysis').item.json.watchlist) }}` |
| `message_sent` | `true` |

3. **Click "Execute Node"** to test
4. **Expected result**: New row created in `market_scans` table
5. **Click "Save"** (top right)

✅ **Success indicator**: Node executes without error, inserts 1 row into Supabase

---

## Step 4: Test Complete Workflow

1. **Click "Execute Workflow"** (top right, play button)
2. **Watch nodes execute** (they'll turn green one by one)
3. **Expected flow:**
   - Schedule triggers
   - Loads 100 tickers
   - Fetches stock data (takes 30-60 seconds)
   - Calculates technical analysis
   - Aggregates market analysis
   - Gets educational content ✅
   - Gets wisdom quote ✅
   - Formats message with GPT-4o mini
   - Sends to Telegram
   - Saves scan results ✅

4. **Check your Telegram** - You should receive a formatted market analysis message

---

## Step 5: Verify Database Logging

1. Go to Supabase: https://repzrsqutuktdzzxoiio.supabase.co
2. Click **Table Editor** → `market_scans`
3. You should see a new row with today's scan results

**Check the data:**
- `scan_date`: Today's date
- `total_scanned`: 100 (or fewer if some failed)
- `bullish_count`: Number of bullish setups
- `bearish_count`: Number of bearish setups
- `market_condition`: Text description
- `setups`: JSON array of actual trading setups
- `message_sent`: true

---

## Troubleshooting

### "Query failed" error on educational content node

**Problem:** Table doesn't exist
**Fix:** Run the SQL schema again from `TRADING-SCANNER-SUPABASE-SCHEMA.md`

### "No data returned" from educational/wisdom nodes

**Problem:** Tables are empty
**Fix:** The SQL schema includes INSERT statements - make sure you ran the complete SQL, not just the CREATE TABLE part

### "Invalid expression" on Save Scan Results

**Problem:** Expression syntax wrong
**Fix:** Make sure you copied the expressions exactly, including the `={{` and `}}` wrappers

### Stock data fetch fails

**Problem:** Yahoo Finance API rate limiting or ticker issues
**Fix:** This is normal - the workflow has `continueOnFail: true` and will skip failed tickers

### GPT-4o mini node fails

**Problem:** Missing OpenAI credentials or quota exceeded
**Fix:** Check your OpenAI API key in n8n credentials, verify you have quota remaining

---

## Expected Message Format

After successful run, your Telegram message should look like:

```
📊 MORNING MARKET SCAN | [Date] 9:35 AM ET

━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 MARKET OVERVIEW

Scanned: 100 stocks
Setups Found: X
• Bullish: X
• Bearish: X
High Volume: X stocks

Condition: [Market condition]

━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 SETUPS TO WATCH

[List of actual trading setups]

━━━━━━━━━━━━━━━━━━━━━━━━━━
🎓 EDUCATION

[Random educational content from database]

━━━━━━━━━━━━━━━━━━━━━━━━━━
💎 WISDOM

[Random Hermetic quote from database]

━━━━━━━━━━━━━━━━━━━━━━━━━━
🔱 Hermetic Market Teacher
Trade with consciousness. Learn with discipline.
```

---

## Activation

After successful test:

1. **Toggle "Active"** switch (top right) to ON
2. Workflow will now run automatically at **9:35 AM ET Monday-Friday**
3. You'll receive market scans every morning before market open

---

## Summary

**Fixed Nodes:**
- ✅ Supabase: Get Educational Content (random educational tip)
- ✅ Supabase: Get Wisdom Quote (random Hermetic quote)
- ✅ Supabase: Save Scan Results (logs scan to database)

**What This Workflow Does:**
1. Scans 100 major stocks every morning
2. Calculates RSI, SMA50, volume ratios
3. Identifies bullish/bearish setups
4. Adds educational content + Hermetic wisdom
5. Sends formatted message to Telegram
6. Logs results to Supabase for historical tracking

**Schedule:** 9:35 AM ET (13:35 UTC), Monday-Friday

---

**Setup Time**: 10 minutes
**Status**: Ready to activate after fixing nodes
**Next Message**: Monday 9:35 AM ET (automatic)

🔱 **Sacred Market Intelligence** 🔱
