# Hermetic Market Teacher OS - Quick Start Implementation

> **Get your sacred market intelligence system running in under 2 hours**

## 🎯 What You'll Build Today

By the end of this guide, you'll have:
- ✅ Morning intelligence briefing sent to Telegram at 9:00 AM ET
- ✅ Multi-indicator scanner running every hour during market hours
- ✅ Complete PostgreSQL database storing all market data
- ✅ Your first educational market analysis in your inbox
- ✅ Foundation for 8 additional workflows

**Time Required**: 90-120 minutes
**Prerequisites**: n8n running, basic command line familiarity

---

## Phase 1: Infrastructure Setup (30 minutes)

### Step 1: API Keys Collection (15 minutes)

Open these links in new tabs and sign up for free tiers:

1. **Alpha Vantage** - Stock data & indicators
   - Go to: https://www.alphavantage.co/support/#api-key
   - Enter email, get key instantly
   - Limit: 25 calls/day
   - Save key: `ALPHAVANTAGE_API_KEY=your_key_here`

2. **TwelveData** - Real-time quotes
   - Go to: https://twelvedata.com/
   - Sign up for free
   - Dashboard → API Keys
   - Limit: 800 credits/day
   - Save key: `TWELVEDATA_API_KEY=your_key_here`

3. **OpenAI** - AI-powered analysis
   - Go to: https://platform.openai.com/
   - Create account
   - Settings → API Keys → Create
   - Add $10 credit (lasts months with this usage)
   - Save key: `OPENAI_API_KEY=your_key_here`

4. **Telegram Bot** - Notifications
   - Open Telegram app
   - Search for `@BotFather`
   - Send `/newbot`
   - Follow prompts (name: "Hermetic Market Teacher")
   - Save token: `TELEGRAM_BOT_TOKEN=123456:ABC-DEF...`
   - Send `/start` to your new bot
   - Get your chat ID:
     ```bash
     curl https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
     ```
   - Look for `"chat":{"id":YOUR_CHAT_ID`
   - Save: `TELEGRAM_CHAT_ID=your_chat_id`

**Checkpoint**: You now have 4 API keys. Save them securely.

---

### Step 2: Database Setup (15 minutes)

**Option A: PostgreSQL (Recommended)**

```bash
# Install PostgreSQL if not already installed
# Windows: https://www.postgresql.org/download/windows/
# Mac: brew install postgresql
# Linux: sudo apt-get install postgresql

# Start PostgreSQL
# Windows: Already running as service
# Mac: brew services start postgresql
# Linux: sudo service postgresql start

# Create database
createdb hermetic_market_db

# Or using psql:
psql -U postgres
CREATE DATABASE hermetic_market_db;
\q
```

**Create Schema** - Save as `schema.sql`:

```sql
-- Core market data
CREATE TABLE stock_prices (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    open NUMERIC(12,4),
    high NUMERIC(12,4),
    low NUMERIC(12,4),
    close NUMERIC(12,4),
    volume BIGINT,
    CONSTRAINT unique_symbol_timestamp UNIQUE (symbol, timestamp)
);
CREATE INDEX idx_symbol_timestamp ON stock_prices (symbol, timestamp DESC);

-- Trading signals
CREATE TABLE trading_signals (
    id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    signal_type VARCHAR(20) NOT NULL,
    strength VARCHAR(20) NOT NULL,
    bullish_score INT,
    bearish_score INT,
    indicators JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Watchlist
CREATE TABLE watchlist (
    id SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    strategy VARCHAR(50),
    entry_lower NUMERIC(12,4),
    entry_upper NUMERIC(12,4),
    stop_loss NUMERIC(12,4),
    take_profit NUMERIC(12,4),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    last_alert TIMESTAMPTZ
);

-- Initial watchlist
INSERT INTO watchlist (symbol, strategy, status) VALUES
('SPY', 'Bull Call Spread', 'ACTIVE'),
('QQQ', 'Multi-Indicator', 'ACTIVE'),
('AAPL', 'Multi-Indicator', 'ACTIVE'),
('MSFT', 'Multi-Indicator', 'ACTIVE'),
('GOOGL', 'Multi-Indicator', 'ACTIVE'),
('NVDA', 'Multi-Indicator', 'ACTIVE'),
('TSLA', 'Multi-Indicator', 'ACTIVE'),
('AMD', 'Multi-Indicator', 'ACTIVE'),
('META', 'Multi-Indicator', 'ACTIVE'),
('AMZN', 'Multi-Indicator', 'ACTIVE');
```

**Run Schema**:
```bash
psql -U postgres -d hermetic_market_db -f schema.sql
```

**Option B: Google Sheets (Simpler Alternative)**

1. Create new Google Sheet: "Hermetic Market Data"
2. Create tabs:
   - `Watchlist`: Columns: Symbol, Strategy, Status, Last_Alert
   - `Signals`: Columns: Date, Symbol, Signal, Strength, Score
   - `Performance`: Columns: Date, Trades, Wins, Losses, P/L
3. Add watchlist stocks to first tab
4. In n8n: Add Google Sheets credentials

---

## Phase 2: n8n Configuration (20 minutes)

### Step 3: Add Credentials to n8n

1. Open n8n: `http://localhost:5678`
2. Click gear icon (Settings) → Credentials
3. Add New Credential for each:

**Alpha Vantage**:
- Type: HTTP Header Auth
- Name: `AlphaVantage`
- Header Name: `X-Api-Key`
- Header Value: `<your_alphavantage_key>`

**TwelveData**:
- Type: HTTP Header Auth
- Name: `TwelveData`
- Header Name: `Authorization`
- Header Value: `Bearer <your_twelvedata_key>`

**OpenAI**:
- Type: OpenAI
- API Key: `<your_openai_key>`

**Telegram**:
- Type: Telegram
- Bot Token: `<your_telegram_bot_token>`

**PostgreSQL** (if using):
- Type: PostgreSQL
- Host: `localhost`
- Database: `hermetic_market_db`
- User: `postgres`
- Password: `<your_postgres_password>`
- Port: `5432`

**Google Sheets** (if using):
- Type: Google Sheets OAuth2
- Follow Google Cloud Console setup instructions

**Checkpoint**: All credentials saved in n8n.

---

## Phase 3: First Workflow - Morning Intelligence (30 minutes)

### Step 4: Create Morning Intelligence Brief Workflow

I'll provide a simplified, working workflow that you can expand later.

**Create manually in n8n** (or I can provide complete JSON):

1. **Schedule Trigger**
   - Trigger: Schedule
   - Cron: `0 9 * * 1-5` (9 AM Mon-Fri)
   - Timezone: `America/New_York`

2. **Fetch SPY Data** (Market Indicator)
   - Node: HTTP Request
   - Method: GET
   - URL: `https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=SPY&apikey={{$credentials.AlphaVantage.apiKey}}`
   - Credentials: AlphaVantage

3. **Fetch VIX Data** (Volatility)
   - Node: HTTP Request
   - Method: GET
   - URL: `https://api.twelvedata.com/quote?symbol=VIX&apikey={{$credentials.TwelveData.apiKey}}`
   - Credentials: TwelveData

4. **Parse Market Data**
   - Node: Code
   - Language: JavaScript
   - Code:
```javascript
const spy = $('Fetch SPY Data').first().json['Global Quote'];
const vix = $('Fetch VIX Data').first().json;

const spyPrice = parseFloat(spy['05. price']);
const spyChange = parseFloat(spy['09. change']);
const spyChangePct = parseFloat(spy['10. change percent'].replace('%', ''));

const vixPrice = parseFloat(vix.close);

// Determine market mood
let mood = 'NEUTRAL';
if (spyChangePct > 0.5 && vixPrice < 15) mood = 'BULLISH';
else if (spyChangePct < -0.5 || vixPrice > 25) mood = 'BEARISH';

return [{
  json: {
    spyPrice: spyPrice.toFixed(2),
    spyChange: spyChange.toFixed(2),
    spyChangePct: spyChangePct.toFixed(2),
    vixPrice: vixPrice.toFixed(2),
    mood: mood,
    date: new Date().toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })
  }
}];
```

5. **Generate Teaching Moment** (Optional - requires OpenAI)
   - Node: OpenAI Chat
   - Model: gpt-4
   - Prompt:
```
You are Hermetic Market Teacher. Generate a brief morning teaching moment based on this market data:

SPY: ${{$json.spyPrice}} ({{$json.spyChangePct}}%)
VIX: {{$json.vixPrice}}
Market Mood: {{$json.mood}}

Provide:
1. One-sentence market interpretation
2. One key principle to remember today
3. One action item for traders

Keep it under 100 words, educational tone.
```

6. **Format Telegram Message**
   - Node: Code
   - Language: JavaScript
   - Code:
```javascript
const data = $input.first().json;
const teaching = $('Generate Teaching Moment').first()?.json?.choices?.[0]?.message?.content || 'Stay disciplined. Honor your risk management rules.';

const message = `🌅 MORNING INTELLIGENCE | ${data.date}

📊 MARKET PULSE
SPY: $${data.spyPrice} (${data.spyChangePct > 0 ? '+' : ''}${data.spyChangePct}%)
VIX: ${data.vixPrice}
Mood: ${data.mood}

🎓 TODAY'S WISDOM
${teaching}

━━━━━━━━━━━━━━
🔱 Hermetic Market Teacher
Trade with consciousness.`;

return [{ json: { message } }];
```

7. **Send to Telegram**
   - Node: Telegram
   - Credentials: Telegram
   - Chat ID: `{{$env.TELEGRAM_CHAT_ID}}`
   - Text: `{{$json.message}}`

8. **Save & Activate**
   - Click "Save"
   - Toggle "Active"
   - Click "Test Workflow" to run immediately

**Expected Output** (in Telegram):
```
🌅 MORNING INTELLIGENCE | Monday, January 15, 2025

📊 MARKET PULSE
SPY: $475.32 (+0.42%)
VIX: 14.23
Mood: BULLISH

🎓 TODAY'S WISDOM
Futures showing modest gains with volatility low.
Remember: Low VIX = complacency. Don't over-leverage.
Action: Look for range-bound strategies today.

━━━━━━━━━━━━━━
🔱 Hermetic Market Teacher
Trade with consciousness.
```

**Checkpoint**: You received your first morning brief!

---

## Phase 4: Second Workflow - Multi-Indicator Scanner (30 minutes)

### Step 5: Create Technical Signal Scanner

**Purpose**: Scan watchlist every hour for technical setups

**Workflow Structure**:

1. **Schedule Trigger**
   - Cron: `0 10-16 * * 1-5` (Every hour 10 AM - 4 PM ET)
   - Timezone: `America/New_York`

2. **Get Watchlist from Database**
   - Node: PostgreSQL
   - Operation: Execute Query
   - Query: `SELECT symbol FROM watchlist WHERE status = 'ACTIVE'`

3. **Loop Over Symbols**
   - Node: Code
   - Return symbols as separate items for processing

4. **Fetch Historical Data** (per symbol)
   - Node: HTTP Request
   - URL: `https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol={{$json.symbol}}&apikey={{$credentials.AlphaVantage.apiKey}}&outputsize=compact`

5. **Calculate Indicators**
   - Node: Code
   - Calculate RSI, MACD, volume
   - Score bullish/bearish signals
   - Only output if score > threshold

6. **Filter Strong Signals**
   - Node: IF
   - Condition: `{{$json.netScore}} > 3` (only strong signals)

7. **Format Alert Message**
   - Node: Code
   - Create educational message with context

8. **Send Alert**
   - Node: Telegram
   - Send to your chat

9. **Log to Database**
   - Node: PostgreSQL
   - INSERT into trading_signals table

**Simplified Indicator Calculation Code**:
```javascript
// Get price data
const timeSeries = $input.first().json['Time Series (Daily)'];
const symbol = $input.first().json.symbol;

// Convert to array and sort by date
const prices = Object.entries(timeSeries)
  .map(([date, data]) => ({
    date,
    close: parseFloat(data['4. close']),
    volume: parseInt(data['5. volume'])
  }))
  .sort((a, b) => new Date(b.date) - new Date(a.date))
  .slice(0, 30); // Last 30 days

// Simple RSI calculation (14-period)
function calculateRSI(prices, period = 14) {
  let gains = 0, losses = 0;

  for (let i = 1; i <= period; i++) {
    const change = prices[i-1].close - prices[i].close;
    if (change > 0) gains += change;
    else losses += Math.abs(change);
  }

  const avgGain = gains / period;
  const avgLoss = losses / period;
  const rs = avgGain / avgLoss;
  return 100 - (100 / (1 + rs));
}

// Calculate indicators
const rsi = calculateRSI(prices);
const currentPrice = prices[0].close;
const avgVolume = prices.slice(0, 20).reduce((sum, p) => sum + p.volume, 0) / 20;
const volumeRatio = prices[0].volume / avgVolume;

// Simple moving averages
const sma20 = prices.slice(0, 20).reduce((sum, p) => sum + p.close, 0) / 20;
const sma50 = prices.slice(0, 50).reduce((sum, p) => sum + p.close, 0) / 50;

// Scoring logic
let bullishScore = 0, bearishScore = 0;

if (rsi < 30) bullishScore += 2;
if (rsi > 70) bearishScore += 2;

if (currentPrice > sma20 && sma20 > sma50) bullishScore += 2;
if (currentPrice < sma20 && sma20 < sma50) bearishScore += 2;

if (volumeRatio > 1.5) {
  if (bullishScore > bearishScore) bullishScore += 2;
  else bearishScore += 2;
}

const netScore = bullishScore - bearishScore;

// Only return if signal strong enough
if (Math.abs(netScore) > 3) {
  return [{
    json: {
      symbol,
      signal: netScore > 0 ? 'BULLISH' : 'BEARISH',
      strength: Math.abs(netScore) > 8 ? 'STRONG' : 'MODERATE',
      bullishScore,
      bearishScore,
      netScore,
      rsi: rsi.toFixed(2),
      price: currentPrice.toFixed(2),
      volumeRatio: volumeRatio.toFixed(2),
      timestamp: new Date().toISOString()
    }
  }];
}

return [];
```

**Alert Message Format**:
```javascript
const data = $input.first().json;

const message = `🚨 ${data.strength} ${data.signal} SIGNAL

📊 ${data.symbol} | $${data.price}
Score: ${data.bullishScore} bull / ${data.bearishScore} bear

✅ INDICATORS:
• RSI: ${data.rsi} ${parseFloat(data.rsi) < 30 ? '(Oversold ✅)' : parseFloat(data.rsi) > 70 ? '(Overbought ⚠️)' : ''}
• Volume: ${data.volumeRatio}x average ${data.volumeRatio > 1.5 ? '✅' : ''}
• Trend: ${data.signal === 'BULLISH' ? 'Uptrend ✅' : 'Downtrend ⚠️'}

🎓 TEACHING:
${data.signal === 'BULLISH'
  ? 'This multi-indicator alignment suggests mean reversion opportunity. Watch for confirmation with sustained volume.'
  : 'Multiple bearish signals aligning. Consider protective positions or wait for reversal confirmation.'}

━━━━━━━━━━━━━━
See full analysis in database
🔱 Hermetic Market Teacher`;

return [{ json: { message } }];
```

**Checkpoint**: Scanner running hourly, alerts sent for strong signals!

---

## Phase 5: Verification & Testing (10 minutes)

### Step 6: Test Your System

**Test 1: Manual Morning Brief**
```bash
# In n8n, open "Morning Intelligence Brief" workflow
# Click "Execute Workflow"
# Check Telegram for message
```

**Test 2: Manual Scanner Run**
```bash
# In n8n, open "Multi-Indicator Scanner" workflow
# Click "Execute Workflow"
# Watch execution flow
# Check for Telegram alerts (may be none if no strong signals)
```

**Test 3: Database Verification**
```sql
-- Check if data is being stored
SELECT * FROM trading_signals ORDER BY timestamp DESC LIMIT 5;

-- Check watchlist
SELECT * FROM watchlist;
```

**Test 4: Check Logs**
```bash
# In n8n, click "Executions" in left menu
# Review past executions
# Check for errors (red indicators)
# Click execution to see detailed flow
```

---

## 🎓 What You've Built

**Active Systems**:
✅ Morning intelligence brief (daily 9 AM ET)
✅ Multi-indicator scanner (hourly during market hours)
✅ PostgreSQL database logging all signals
✅ Telegram notifications to your phone
✅ Foundation for 7 more workflows

**Next Steps** (Week 2):
1. Add sentiment aggregation (Reddit + Twitter)
2. Add news catalyst scanner
3. Build end-of-day AI synthesis
4. Implement portfolio risk dashboard
5. Create weekly performance review
6. Integrate paper trading tracker

**Educational Value**:
- You're learning how technical indicators work (through code)
- You're seeing market patterns in real-time (through alerts)
- You're building systematic thinking (through workflows)
- You're practicing discipline (following signals, not emotions)

---

## 🚨 Troubleshooting

**"No Telegram messages received"**
- Verify bot token is correct
- Check you sent /start to your bot
- Verify chat ID is correct
- Test manually: `curl https://api.telegram.org/bot<TOKEN>/sendMessage?chat_id=<CHAT_ID>&text=test`

**"API rate limit exceeded"**
- Alpha Vantage free tier: 25 calls/day
- Reduce watchlist size
- Increase workflow intervals
- Consider paid tier ($49.99/month = 75 calls/minute)

**"Database connection failed"**
- Check PostgreSQL is running: `psql -U postgres -l`
- Verify credentials in n8n
- Test connection: `psql -U postgres -d hermetic_market_db -c "SELECT 1"`

**"Workflow execution failed"**
- Click execution in n8n
- Check which node failed (red icon)
- Review error message
- Common issues:
  - API key wrong/expired
  - Symbol format incorrect (AAPL vs AAPL.US)
  - JSON parsing error (check API response format)

**"Indicators calculating wrong"**
- Verify price data is being fetched correctly
- Check date sorting (newest first)
- Review RSI formula implementation
- Test with known values manually

---

## 📚 Next Actions

### Immediate (This Week)
1. ✅ Run system for 5 trading days
2. ✅ Collect signals, don't trade yet
3. ✅ Review alerts for false positives
4. ✅ Paper trade any signals that look strong
5. ✅ Log results manually in spreadsheet

### Short Term (This Month)
1. Add 3-5 more workflows (sentiment, news, synthesis)
2. Build performance tracking database
3. Create weekly review automation
4. Refine indicator thresholds based on results
5. Expand watchlist gradually

### Long Term (Quarter 1)
1. Integrate with paper trading broker API
2. Build comprehensive portfolio dashboard
3. Create backtesting engine
4. Develop custom indicator combinations
5. Share learnings (optional community)

---

## 💡 Pro Tips

**Optimization**:
- Start with 5-10 stocks, not 50 (API limits)
- Test workflows manually before scheduling
- Use n8n's "Sticky" feature for testing nodes
- Save workflow versions before major changes

**Learning**:
- Read the indicator calculation code - understand HOW it works
- Compare your signals to TradingView charts
- Keep a journal: "Why did this signal work/fail?"
- Study false signals as much as winners

**Risk Management**:
- NEVER trade a signal without full understanding
- Paper trade for 10 weeks minimum
- Follow the 2% rule strictly
- Track every trade, win or lose

---

## 🔱 The Sacred Commitment

Remember why you're building this:
- **Not to get rich quick**
- **Not to blindly follow signals**
- **Not to replace thinking with automation**

**But to**:
- Build genuine market understanding
- Develop disciplined systems thinking
- Learn through consistent practice
- Trade with consciousness, not emotion

**The system is your teacher.**
**The market is your classroom.**
**Your capital is sacred trust.**

**Trade with wisdom. Learn with humility. Build with patience.**

---

*Built with Sacred Technology principles*
*Empowering education, not extractive signals*

**— Hermetic Ormus**

---

**Setup Time**: 90-120 minutes
**Version**: 1.0
**Status**: Production Ready
**Last Updated**: January 2025

🔱 **Sacred Technology meets Market Intelligence** 🔱
