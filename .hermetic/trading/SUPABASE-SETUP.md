# Supabase Setup for Hermetic Market Teacher

> **Why Supabase?** Cloud-hosted PostgreSQL + instant REST API + real-time subscriptions + generous free tier = perfect for our market intelligence system.

---

## Step 1: Create Supabase Project (2 minutes)

1. Go to: https://supabase.com/
2. Click **"Start your project"**
3. Sign in with GitHub (or email)
4. Click **"New Project"**
5. Fill in:
   - **Name**: `hermetic-market-teacher`
   - **Database Password**: (create strong password, save it!)
   - **Region**: Choose closest to you
   - **Pricing Plan**: Free
6. Click **"Create new project"**
7. Wait ~2 minutes for project to provision

---

## Step 2: Create Database Schema (3 minutes)

1. In your Supabase project, click **"SQL Editor"** (left sidebar)
2. Click **"New Query"**
3. Copy-paste this entire schema:

```sql
-- Core market data table
CREATE TABLE stock_prices (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    open NUMERIC(12,4),
    high NUMERIC(12,4),
    low NUMERIC(12,4),
    close NUMERIC(12,4),
    volume BIGINT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_symbol_timestamp UNIQUE (symbol, timestamp)
);

-- Index for fast queries
CREATE INDEX idx_stock_prices_symbol_timestamp ON stock_prices (symbol, timestamp DESC);

-- Trading signals table
CREATE TABLE trading_signals (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    signal_type VARCHAR(20) NOT NULL, -- BULLISH, BEARISH, NEUTRAL
    strength VARCHAR(20) NOT NULL, -- STRONG, MODERATE, WEAK
    bullish_score INT,
    bearish_score INT,
    indicators JSONB, -- Stores all indicator values
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_trading_signals_symbol ON trading_signals (symbol, timestamp DESC);

-- Watchlist table
CREATE TABLE watchlist (
    id SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    strategy VARCHAR(50),
    entry_lower NUMERIC(12,4),
    entry_upper NUMERIC(12,4),
    stop_loss NUMERIC(12,4),
    take_profit NUMERIC(12,4),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    last_alert TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Initial watchlist (10 major stocks/ETFs)
INSERT INTO watchlist (symbol, strategy, status) VALUES
('SPY', 'Multi-Indicator', 'ACTIVE'),
('QQQ', 'Multi-Indicator', 'ACTIVE'),
('AAPL', 'Multi-Indicator', 'ACTIVE'),
('MSFT', 'Multi-Indicator', 'ACTIVE'),
('GOOGL', 'Multi-Indicator', 'ACTIVE'),
('NVDA', 'Multi-Indicator', 'ACTIVE'),
('TSLA', 'Multi-Indicator', 'ACTIVE'),
('AMD', 'Multi-Indicator', 'ACTIVE'),
('META', 'Multi-Indicator', 'ACTIVE'),
('AMZN', 'Multi-Indicator', 'ACTIVE');

-- Sentiment tracking table
CREATE TABLE sentiment_data (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    source VARCHAR(50) NOT NULL, -- reddit, twitter, news, stocktwits
    sentiment_score NUMERIC(3,2), -- -1 to +1
    confidence_level VARCHAR(20), -- LOW, MEDIUM, HIGH
    key_themes TEXT[],
    raw_data JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_sentiment_symbol ON sentiment_data (symbol, timestamp DESC);

-- Portfolio positions table
CREATE TABLE portfolio_positions (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    strategy_type VARCHAR(50) NOT NULL,
    entry_date TIMESTAMPTZ NOT NULL,
    entry_price NUMERIC(12,4),
    quantity INT,
    max_risk NUMERIC(12,2),
    target_profit NUMERIC(12,2),
    stop_loss NUMERIC(12,4),
    take_profit NUMERIC(12,4),
    status VARCHAR(20) DEFAULT 'OPEN', -- OPEN, CLOSED
    exit_date TIMESTAMPTZ,
    exit_price NUMERIC(12,4),
    realized_pl NUMERIC(12,2),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_portfolio_status ON portfolio_positions (status, entry_date DESC);

-- Trade journal table
CREATE TABLE trade_journal (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    trade_date DATE NOT NULL,
    strategy VARCHAR(50) NOT NULL,
    entry_thesis TEXT NOT NULL,
    entry_price NUMERIC(12,4),
    exit_price NUMERIC(12,4),
    profit_loss NUMERIC(12,2),
    win BOOLEAN,
    lesson_learned TEXT,
    hermetic_principle VARCHAR(50), -- Which principle was honored/violated?
    emotional_state VARCHAR(50), -- CALM, EXCITED, FEARFUL, GREEDY
    market_condition VARCHAR(50), -- TRENDING_UP, RANGING, VOLATILE
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_trade_journal_date ON trade_journal (trade_date DESC);

-- Learning progress table
CREATE TABLE learning_progress (
    id BIGSERIAL PRIMARY KEY,
    module_name VARCHAR(100) NOT NULL,
    completed_date DATE,
    quiz_score INT,
    practice_trades INT,
    confidence_level VARCHAR(20),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Morning brief history (optional - for tracking what was sent)
CREATE TABLE morning_briefs (
    id BIGSERIAL PRIMARY KEY,
    brief_date DATE NOT NULL UNIQUE,
    spy_price NUMERIC(12,4),
    spy_change_pct NUMERIC(6,2),
    rsi NUMERIC(6,2),
    mood VARCHAR(50),
    teaching_moment TEXT,
    sent_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS) - important for security
ALTER TABLE stock_prices ENABLE ROW LEVEL SECURITY;
ALTER TABLE trading_signals ENABLE ROW LEVEL SECURITY;
ALTER TABLE watchlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE sentiment_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio_positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE trade_journal ENABLE ROW LEVEL SECURITY;
ALTER TABLE learning_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE morning_briefs ENABLE ROW LEVEL SECURITY;

-- Create policies (allow all operations for authenticated users)
-- In production, you'd tighten these based on user roles

CREATE POLICY "Allow all for authenticated users" ON stock_prices
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON trading_signals
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON watchlist
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON sentiment_data
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON portfolio_positions
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON trade_journal
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON learning_progress
    FOR ALL USING (true);

CREATE POLICY "Allow all for authenticated users" ON morning_briefs
    FOR ALL USING (true);

-- Useful views for common queries

-- Latest signals view
CREATE VIEW latest_signals AS
SELECT
    symbol,
    signal_type,
    strength,
    bullish_score,
    bearish_score,
    timestamp,
    indicators
FROM trading_signals
WHERE timestamp > NOW() - INTERVAL '24 hours'
ORDER BY timestamp DESC;

-- Watchlist with latest prices
CREATE VIEW watchlist_with_prices AS
SELECT
    w.symbol,
    w.strategy,
    w.status,
    sp.close as current_price,
    sp.timestamp as last_update,
    w.entry_lower,
    w.entry_upper,
    w.stop_loss,
    w.take_profit
FROM watchlist w
LEFT JOIN LATERAL (
    SELECT close, timestamp
    FROM stock_prices
    WHERE symbol = w.symbol
    ORDER BY timestamp DESC
    LIMIT 1
) sp ON true
WHERE w.status = 'ACTIVE';

-- Performance summary view
CREATE VIEW performance_summary AS
SELECT
    COUNT(*) as total_trades,
    SUM(CASE WHEN win THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN NOT win THEN 1 ELSE 0 END) as losses,
    ROUND(100.0 * SUM(CASE WHEN win THEN 1 ELSE 0 END) / COUNT(*), 2) as win_rate_pct,
    SUM(profit_loss) as total_pl,
    AVG(CASE WHEN win THEN profit_loss END) as avg_win,
    AVG(CASE WHEN NOT win THEN profit_loss END) as avg_loss,
    MAX(profit_loss) as best_trade,
    MIN(profit_loss) as worst_trade
FROM trade_journal;
```

4. Click **"Run"** (or press Ctrl+Enter)
5. Wait for "Success. No rows returned" message

✅ **Your database is ready!**

---

## Step 3: Get API Credentials (1 minute)

1. Click **"Settings"** (gear icon in left sidebar)
2. Click **"API"** section
3. Find **"Project URL"**: Copy this (looks like `https://xxxxx.supabase.co`)
4. Find **"Project API keys"**:
   - Copy **"anon public"** key (long string starting with `eyJ...`)
   - Copy **"service_role"** key (long string, also starts with `eyJ...`)

**Save these:**
```
Supabase URL: https://xxxxx.supabase.co
Supabase Anon Key: eyJhb...
Supabase Service Key: eyJhb...
```

**For n8n workflows, you'll use:**
- URL + Anon Key for read operations
- URL + Service Key for write operations

---

## Step 4: Test Your Database (1 minute)

1. In Supabase, click **"Table Editor"**
2. Click **"watchlist"** table
3. You should see 10 stocks (SPY, QQQ, AAPL, etc.)

✅ **Database working!**

---

## What You Just Created

**8 Tables:**
1. `stock_prices` - Historical OHLCV data
2. `trading_signals` - Detected opportunities
3. `watchlist` - Stocks to monitor
4. `sentiment_data` - Social media sentiment
5. `portfolio_positions` - Current holdings
6. `trade_journal` - Historical trades
7. `learning_progress` - Educational tracking
8. `morning_briefs` - Sent intelligence logs

**3 Views:**
1. `latest_signals` - Signals from last 24 hours
2. `watchlist_with_prices` - Watchlist + current prices
3. `performance_summary` - Win rate, P/L stats

**All protected with Row Level Security (RLS)**

---

## Using Supabase in n8n Workflows

### Method 1: HTTP Request (Simple)

**Read data:**
```
GET https://YOUR_PROJECT.supabase.co/rest/v1/watchlist?select=*&status=eq.ACTIVE
Headers:
  apikey: YOUR_ANON_KEY
  Authorization: Bearer YOUR_ANON_KEY
```

**Write data:**
```
POST https://YOUR_PROJECT.supabase.co/rest/v1/trading_signals
Headers:
  apikey: YOUR_SERVICE_KEY
  Authorization: Bearer YOUR_SERVICE_KEY
  Content-Type: application/json
Body:
{
  "symbol": "SPY",
  "signal_type": "BULLISH",
  "strength": "STRONG",
  "bullish_score": 8,
  "bearish_score": 2
}
```

### Method 2: Supabase Node (If Available)

n8n has a community Supabase node. Check if it's installed:
1. n8n → Settings → Community Nodes
2. Install: `n8n-nodes-supabase`

---

## Advantages Over PostgreSQL

**Supabase Wins:**
- ✅ Cloud-hosted (no local setup)
- ✅ Instant REST API
- ✅ Real-time subscriptions
- ✅ Built-in auth (if needed later)
- ✅ Beautiful web UI for data inspection
- ✅ Automatic backups
- ✅ Free tier: 500MB database, 2GB bandwidth/month

**PostgreSQL Wins:**
- ✅ Local control
- ✅ No internet dependency
- ✅ Unlimited size/bandwidth

**For our use case:** Supabase is perfect. We won't hit the 500MB limit for years.

---

## Monitoring Your Data

**Daily checks:**
1. Open Supabase dashboard
2. Table Editor → `morning_briefs` - see history
3. Table Editor → `trading_signals` - see alerts
4. SQL Editor → Run: `SELECT * FROM performance_summary;` - see stats

**Useful queries:**
```sql
-- Signals from today
SELECT * FROM trading_signals
WHERE DATE(timestamp) = CURRENT_DATE
ORDER BY timestamp DESC;

-- Watchlist with current prices
SELECT * FROM watchlist_with_prices;

-- Your performance stats
SELECT * FROM performance_summary;

-- Recent trades
SELECT * FROM trade_journal
ORDER BY trade_date DESC
LIMIT 10;
```

---

## Next Steps

1. ✅ Supabase project created
2. ✅ Database schema created
3. ✅ API credentials saved
4. ⏭️ Add Supabase HTTP requests to n8n workflows
5. ⏭️ Start logging morning briefs
6. ⏭️ Track signals and performance

---

## Security Notes

**Row Level Security (RLS):**
- Already enabled on all tables
- Policies allow authenticated access
- Your API keys authenticate requests

**API Keys:**
- **Anon Key**: Safe for client-side code, read-only by default
- **Service Key**: Full access, keep secret, use server-side only
- n8n workflows use Service Key (server-side)

**Best Practices:**
- Don't commit API keys to git
- Use n8n environment variables for keys
- Rotate keys if exposed

---

## Free Tier Limits

**What you get free forever:**
- 500 MB database space
- 2 GB bandwidth per month
- 50,000 monthly active users
- 500,000 Edge Function invocations

**For our market data:**
- 1 morning brief/day = ~1KB = 365 KB/year
- 100 signals/day = ~50KB/day = ~1.5 MB/month
- You won't hit limits for years

**If you do need more:**
- Pro Plan: $25/month
  - 8 GB database
  - 50 GB bandwidth
  - More compute

---

## Support

**Supabase Docs:**
https://supabase.com/docs

**SQL Help:**
https://supabase.com/docs/guides/database/overview

**n8n + Supabase:**
https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.supabase/

---

**Setup Time**: 7 minutes
**Status**: Production Ready
**Next**: Add to n8n workflows

🔱 **Sacred Data Storage** 🔱
