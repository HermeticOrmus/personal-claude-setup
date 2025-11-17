# Trading Scanner - Supabase Schema

> Schema for the "Trading Scanner - Daily Market Analysis" workflow

---

## Quick Setup (5 minutes)

1. Go to your Supabase project: https://repzrsqutuktdzzxoiio.supabase.co
2. Click **SQL Editor** → **New Query**
3. Copy-paste the SQL below
4. Click **Run**
5. Done!

---

## Complete SQL Schema

```sql
-- Table 1: Educational content for morning briefs
CREATE TABLE IF NOT EXISTS educational_content (
    id SERIAL PRIMARY KEY,
    topic VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(50), -- RSI, VOLUME, MOMENTUM, RISK, DISCIPLINE
    hermetic_principle VARCHAR(50), -- MENTALISM, VIBRATION, RHYTHM, etc.
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table 2: Wisdom quotes (Hermetic philosophy)
CREATE TABLE IF NOT EXISTS wisdom_quotes (
    id SERIAL PRIMARY KEY,
    quote TEXT NOT NULL,
    author VARCHAR(100),
    principle VARCHAR(50), -- Which Hermetic principle
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table 3: Market scan results (daily logs)
CREATE TABLE IF NOT EXISTS market_scans (
    id BIGSERIAL PRIMARY KEY,
    scan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    scan_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    total_scanned INT,
    bullish_count INT,
    bearish_count INT,
    neutral_count INT,
    high_volume_count INT,
    market_condition TEXT,
    setups JSONB, -- Array of actual setups found
    watchlist JSONB, -- Stocks to watch
    message_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table 4: Individual stock signals (optional detailed logging)
CREATE TABLE IF NOT EXISTS stock_signals (
    id BIGSERIAL PRIMARY KEY,
    scan_id BIGINT REFERENCES market_scans(id),
    ticker VARCHAR(10) NOT NULL,
    price NUMERIC(12,4),
    rsi NUMERIC(6,2),
    sma50 NUMERIC(12,4),
    volume_ratio NUMERIC(6,2),
    price_change_pct NUMERIC(6,2),
    signal VARCHAR(20), -- bullish, bearish, neutral
    setup_type VARCHAR(50), -- OVERSOLD + VOLUME, etc.
    watchlist BOOLEAN DEFAULT FALSE,
    watchlist_reason TEXT,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_market_scans_date ON market_scans (scan_date DESC);
CREATE INDEX idx_stock_signals_ticker ON stock_signals (ticker, timestamp DESC);
CREATE INDEX idx_stock_signals_scan ON stock_signals (scan_id);

-- Enable Row Level Security
ALTER TABLE educational_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE wisdom_quotes ENABLE ROW LEVEL SECURITY;
ALTER TABLE market_scans ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_signals ENABLE ROW LEVEL SECURITY;

-- Create policies (allow all for authenticated/service role)
CREATE POLICY "Allow all for service role" ON educational_content FOR ALL USING (true);
CREATE POLICY "Allow all for service role" ON wisdom_quotes FOR ALL USING (true);
CREATE POLICY "Allow all for service role" ON market_scans FOR ALL USING (true);
CREATE POLICY "Allow all for service role" ON stock_signals FOR ALL USING (true);

-- Insert sample educational content
INSERT INTO educational_content (topic, content, category, hermetic_principle) VALUES
('RSI Oversold', 'When RSI drops below 30, it indicates oversold conditions. However, in strong downtrends, RSI can stay oversold for extended periods. Wait for confirmation: volume spike on reversal candle, positive divergence, or break above moving average.', 'RSI', 'RHYTHM'),
('RSI Overbought', 'RSI above 70 signals overbought conditions. Strong trends can remain overbought for weeks. Consider: reduce position sizing on new longs, take partial profits, watch for bearish divergences, tighten stop losses.', 'RSI', 'POLARITY'),
('Volume Confirmation', 'High volume confirms conviction. If price moves UP on high volume = sustainable rally. Price DOWN on high volume = capitulation/potential bottom. Volume precedes price - institutions accumulate before retail notices.', 'VOLUME', 'VIBRATION'),
('Risk Management', 'Never risk more than 2% of capital on a single trade. This ensures you can survive 20 consecutive losses and still have 67% of your account. Position sizing is more important than entry timing.', 'RISK', 'CAUSE-EFFECT'),
('Discipline', 'The trader who follows their plan for 100 trades beats the genius with no system. Consistent execution compounds into mastery. Plan the trade, trade the plan, review the results.', 'DISCIPLINE', 'MENTALISM'),
('Market Timing', 'You cannot predict every move. What you can do: identify high-probability setups, execute with discipline, manage risk religiously. Accept that some trades will lose - it''s part of the process.', 'DISCIPLINE', 'RHYTHM'),
('Trend Following', 'The trend is your friend until it bends. Price above 50-day SMA = uptrend bias. Price below = downtrend bias. Don''t fight strong trends. Wait for pullbacks in the direction of the trend.', 'MOMENTUM', 'CORRESPONDENCE'),
('False Signals', 'Not every oversold reading bounces. Not every overbought reading corrects. Volume, trend context, and broader market conditions all matter. Multiple indicator confirmation reduces false signals.', 'RISK', 'POLARITY');

-- Insert sample wisdom quotes
INSERT INTO wisdom_quotes (quote, author, principle) VALUES
('The All is Mind. The Universe is Mental. Your consciousness determines your trading reality. Enter trades with clear mind, not emotional reactivity.', 'The Kybalion', 'MENTALISM'),
('As above, so below. The patterns you see in 5-minute charts repeat in daily charts. Master one timeframe, understand all timeframes.', 'The Kybalion', 'CORRESPONDENCE'),
('Nothing rests; everything moves; everything vibrates. Markets never stay still. Accept this rhythm. Ship your strategy, learn from reality, iterate.', 'The Kybalion', 'VIBRATION'),
('Everything is Dual; everything has poles. Risk and reward are two ends of the same spectrum. You cannot have one without the other.', 'The Kybalion', 'POLARITY'),
('Everything flows, out and in; everything has its tides. Markets have cycles - expansion, peak, contraction, trough. Honor the rhythm. Don''t force trades in low-energy periods.', 'The Kybalion', 'RHYTHM'),
('Every Cause has its Effect; every Effect has its Cause. Your discipline today creates your results tomorrow. No action is neutral.', 'The Kybalion', 'CAUSE-EFFECT'),
('Gender is in everything. Balance aggressive execution (masculine) with patient observation (feminine). Both are needed for mastery.', 'The Kybalion', 'GENDER'),
('In trading, the market is never wrong - only your perception of it. Adapt your understanding to reality, not reality to your understanding.', 'Jesse Livermore', 'MENTALISM'),
('The big money is made in the waiting, not the trading. Patience compounds into wealth.', 'Charlie Munger', 'RHYTHM'),
('Risk comes from not knowing what you''re doing. If you can''t explain your thesis in two sentences, you don''t have one.', 'Warren Buffett', 'MENTALISM');
```

---

## How to Use in n8n

### Node 1: "Supabase: Get Educational Content"

**Configuration:**
```
Resource: Database
Operation: Execute Query
Query: SELECT * FROM educational_content ORDER BY RANDOM() LIMIT 1;
```

**What it does:** Fetches one random educational tip for the morning brief.

---

### Node 2: "Supabase: Get Wisdom Quote"

**Configuration:**
```
Resource: Database
Operation: Execute Query
Query: SELECT * FROM wisdom_quotes ORDER BY RANDOM() LIMIT 1;
```

**What it does:** Fetches one random Hermetic wisdom quote.

---

### Node 3: "Supabase: Save Scan Results"

**Configuration:**
```
Resource: Row
Operation: Insert
Table: market_scans
Columns:
  - scan_date: {{ $now.format('yyyy-MM-dd') }}
  - total_scanned: {{ $('Aggregate Market Analysis').item.json.totalScanned }}
  - bullish_count: {{ $('Aggregate Market Analysis').item.json.bullishCount }}
  - bearish_count: {{ $('Aggregate Market Analysis').item.json.bearishCount }}
  - neutral_count: {{ $('Aggregate Market Analysis').item.json.neutralCount }}
  - high_volume_count: {{ $('Aggregate Market Analysis').item.json.highVolumeCount }}
  - market_condition: {{ $('Aggregate Market Analysis').item.json.condition }}
  - setups: {{ $('Aggregate Market Analysis').item.json.setups }}
  - watchlist: {{ $('Aggregate Market Analysis').item.json.watchlist }}
  - message_sent: true
```

**What it does:** Saves the complete market scan results to the database for historical tracking.

---

## Verification Queries

After setup, verify data exists:

```sql
-- Check educational content
SELECT COUNT(*) FROM educational_content;
-- Should return: 8

-- Check wisdom quotes
SELECT COUNT(*) FROM wisdom_quotes;
-- Should return: 10

-- Test random educational content
SELECT topic, content FROM educational_content ORDER BY RANDOM() LIMIT 1;

-- Test random wisdom quote
SELECT quote, author FROM wisdom_quotes ORDER BY RANDOM() LIMIT 1;

-- View recent scans (after workflow runs)
SELECT * FROM market_scans ORDER BY scan_date DESC LIMIT 5;
```

---

## Database Tables Summary

| Table | Purpose | Row Count |
|-------|---------|-----------|
| `educational_content` | Teaching moments for briefs | 8 (expandable) |
| `wisdom_quotes` | Hermetic philosophy quotes | 10 (expandable) |
| `market_scans` | Daily scan results log | Grows daily |
| `stock_signals` | Individual stock details | Optional detailed logging |

---

## Next Steps

1. ✅ Run SQL schema in Supabase
2. ✅ Verify tables created (8 content rows, 10 wisdom rows)
3. ⏭️ Update n8n nodes with configurations above
4. ⏭️ Test workflow manually
5. ⏭️ Activate schedule (9:35 AM ET Mon-Fri)

---

**Schema Created**: November 2025
**For Workflow**: Trading Scanner - Daily Market Analysis
**Database**: https://repzrsqutuktdzzxoiio.supabase.co

🔱 **Sacred Market Intelligence with Hermetic Wisdom** 🔱
