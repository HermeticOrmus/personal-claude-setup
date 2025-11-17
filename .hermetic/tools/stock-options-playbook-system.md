# Stock Options Playbook Automation

## Philosophy: Empowerment Through Education

**WHY THIS EXISTS:**
Following Hermetic principles, this automation empowers you with knowledge, not just "hot tips." Each playbook teaches the strategy, risk, and reasoning - building your trading wisdom over time.

**REJECTS:**
❌ Pump-and-dump signals
❌ "Get rich quick" schemes
❌ Hiding risk to make plays look good
❌ Subscription-based signal services
❌ Manipulation or FOMO tactics

**EMBRACES:**
✅ Full risk disclosure
✅ Educational explanations
✅ Paper trading encouragement
✅ Multiple exit strategies
✅ Position sizing guidance
✅ Honest win rates

---

## Architecture

```
Schedule → Fetch Market Data → Analyze Opportunities → Generate Playbooks → Send to Telegram
    ↓             ↓                    ↓                      ↓                  ↓
  Cron      Free APIs         Scanning Logic         Templates          Your Phone
```

### Data Sources (Free Tier)

1. **Alpha Vantage** (Free: 25 calls/day)
   - Stock quotes
   - Historical data
   - Technical indicators
   - API Key: https://www.alphavantage.co/support/#api-key

2. **Yahoo Finance API** (Unofficial, Free)
   - Real-time quotes
   - Options chains
   - No API key needed

3. **Polygon.io** (Free: 5 calls/min)
   - Options data
   - Market sentiment
   - API Key: https://polygon.io/

4. **TradingView Webhooks** (Free)
   - Custom alerts
   - Technical analysis triggers

---

## Playbook Types

### 1. Bull Call Spread (Moderate Bullish)
**When to use:** You're moderately bullish, want defined risk
**Max Profit:** Limited (spread width - net debit)
**Max Loss:** Limited (net debit paid)
**Breakeven:** Lower strike + net debit

### 2. Bear Put Spread (Moderate Bearish)
**When to use:** You're moderately bearish, want defined risk
**Max Profit:** Limited (spread width - net debit)
**Max Loss:** Limited (net debit paid)
**Breakeven:** Higher strike - net debit

### 3. Iron Condor (Neutral/Range-Bound)
**When to use:** You expect low volatility, stock to stay in range
**Max Profit:** Limited (net credit received)
**Max Loss:** Limited (spread width - net credit)
**Breakeven:** Two breakevens (upper and lower)

### 4. Covered Call (Income Generation)
**When to use:** You own stock, want income, okay with capping upside
**Max Profit:** Limited (strike - stock price + premium)
**Max Loss:** Substantial (stock could go to zero)
**Breakeven:** Stock purchase price - premium received

### 5. Cash-Secured Put (Wheel Strategy)
**When to use:** You want to own stock at lower price, collect premium
**Max Profit:** Limited (premium received)
**Max Loss:** Substantial (strike price - premium)
**Breakeven:** Strike price - premium

### 6. Straddle (High Volatility Expected)
**When to use:** Big move expected, direction unknown
**Max Profit:** Unlimited
**Max Loss:** Limited (total premium paid)
**Breakeven:** Two points (strike ± total premium)

---

## Scanning Criteria

### Technical Filters
- **High IV Rank** (>50) - Options are expensive
- **Price near support/resistance** - Defined risk zones
- **Volume spike** - Liquidity for entry/exit
- **RSI extremes** - Oversold (<30) or Overbought (>70)
- **Moving average bounces** - Trend confirmation

### Fundamental Filters
- **Earnings date** - Avoid or target IV crush
- **News catalysts** - Product launches, FDA approvals
- **Sector rotation** - Follow the money
- **Institutional buying** - Smart money confirmation

### Risk Management Filters
- **Options liquidity** - Bid-ask spread <$0.10
- **Open interest** - At least 100 contracts
- **Days to expiration** - 30-45 DTE (sweet spot)
- **Probability of profit** - >60% for conservative plays

---

## Playbook Message Format

```
🎯 PLAYBOOK: [Strategy Name]

📊 TICKER: $SPY
💡 OUTLOOK: Moderately Bullish
⏰ TIMEFRAME: 30 days

━━━━━━━━━━━━━━━
📈 THE PLAY

BUY:  1x $SPY 450 Call @ $5.00
SELL: 1x $SPY 460 Call @ $2.00
NET DEBIT: $3.00 per spread ($300 total)

━━━━━━━━━━━━━━━
💰 PROFIT/LOSS

MAX PROFIT: $700 (233%)
MAX LOSS: $300 (100%)
BREAKEVEN: $453.00

PROBABILITY OF PROFIT: 65%

━━━━━━━━━━━━━━━
🎓 WHY THIS WORKS

SPY is consolidating above 450 support. RSI bounced from oversold. Fed meeting next week could provide catalyst. Bull call spread limits risk while maintaining upside exposure.

━━━━━━━━━━━━━━━
📋 ENTRY RULES

✅ Enter if SPY holds above $448
✅ IV Rank remains >40
✅ Volume confirms on green candle
❌ DO NOT enter if SPY breaks $447

━━━━━━━━━━━━━━━
🚪 EXIT STRATEGIES

🎯 PROFIT TARGET 1: Close at 50% profit ($150)
🎯 PROFIT TARGET 2: Close at 100% profit ($300)
🎯 PROFIT TARGET 3: Close at 150% profit ($450)

🛑 STOP LOSS: Close if value drops to $1.50 (50% loss)

⏰ TIME DECAY: Exit 7 days before expiration
📉 TREND BREAK: Exit if SPY breaks below $447

━━━━━━━━━━━━━━━
⚠️ RISK DISCLOSURE

- Options can expire worthless
- Maximum loss is $300 per spread
- Past performance ≠ future results
- This is education, not financial advice
- Position size: Risk only what you can lose

━━━━━━━━━━━━━━━
📚 LEARN MORE

Strategy: Bull Call Spread
Greeks: Delta +0.35, Theta -0.08
Ideal for: Moderate directional plays

🔗 Investopedia: [Link]
🎥 YouTube Tutorial: [Link]

━━━━━━━━━━━━━━━
📊 TRACK YOUR RESULTS

Paper trade first: Use ThinkorSwim, TastyWorks, or TradeStation simulators.

Document: Entry price, exit price, P/L, lessons learned.
```

---

## Automation Triggers

### Daily Scans (Market Open)
- **9:35 AM ET** - Morning scan for setups
- Looks for: Gap fills, breakouts, support bounces

### Mid-Day Checks
- **12:00 PM ET** - Midday momentum scan
- Looks for: Failed breakouts, reversals

### Pre-Close Setup
- **3:00 PM ET** - End-of-day scan
- Looks for: Setups for tomorrow, earnings plays

### Weekly Scans
- **Sunday 6:00 PM ET** - Week ahead analysis
- Looks for: Earnings calendar, economic data

### Event-Driven Alerts
- **Real-time** - FDA approvals, earnings surprises
- Triggered by: News APIs, custom webhooks

---

## Position Sizing Formula

```
ACCOUNT SIZE: $10,000 (example)
MAX RISK PER TRADE: 2% = $200
MAX LOSS PER SPREAD: $300
POSITION SIZE: 0 contracts (risk exceeds 2%)

If max loss was $150:
POSITION SIZE: 1 contract (1.5% risk)
```

**Rule**: Never risk more than 2% of account on single trade.

---

## Win Rate Expectations

**Conservative Strategies** (Iron Condors, Credit Spreads):
- Win Rate: 70-80%
- Avg Win: $50-100
- Avg Loss: $150-200
- Required: 3:1 win-loss ratio to profit

**Aggressive Strategies** (Directional Plays):
- Win Rate: 40-50%
- Avg Win: $300-500
- Avg Loss: $100-150
- Required: Larger wins than losses

**Neutral Strategies** (Theta Decay):
- Win Rate: 60-70%
- Avg Win: $50-75
- Avg Loss: $100-150
- Required: Consistency over time

---

## Paper Trading Workflow

1. **Receive playbook on Telegram**
2. **Log into paper trading platform**
3. **Execute the exact play** (same strikes, same dates)
4. **Track in spreadsheet**
5. **Exit per playbook rules**
6. **Review weekly**

**Platforms:**
- ThinkorSwim (TD Ameritrade) - Best for analysis
- TastyWorks - Best for options-focused
- TradeStation - Best for automation
- Webull - Best mobile experience

---

## Data Storage

All playbooks stored in:
```
C:\Users\ormus\.hermetic\trading\playbooks\
```

Structure:
```
playbooks/
├── 2025-01-15_SPY_bull-call-spread.json
├── 2025-01-15_AAPL_iron-condor.json
├── 2025-01-16_TSLA_cash-secured-put.json
└── archive/
    └── 2025-01/
```

Each file includes:
- Entry date/time
- Market conditions
- Full playbook details
- Actual results (if traded)
- Lessons learned

---

## Educational Resources

### Books
- "Options as a Strategic Investment" - McMillan
- "The Options Playbook" - Brian Overby
- "Trading Options Greeks" - Dan Passarelli

### Websites
- OptionAlpha.com - Free courses
- TastyTrade.com - Daily education
- TheOptionsGuide.com - Strategy tutorials

### YouTube Channels
- projectfinance
- InTheMoney
- SMB Capital

---

## Compliance & Ethics

**This automation provides EDUCATION, not investment advice.**

- Never risk money you can't afford to lose
- Past performance doesn't guarantee future results
- Options trading involves substantial risk
- Consult a licensed financial advisor
- Do your own due diligence

**No affiliates, no kickbacks, no hidden agendas.**

This system exists to empower your learning, not extract fees.

---

## Future Enhancements

1. **Backtesting Engine** - Test strategies on historical data
2. **Portfolio Tracker** - Monitor all open positions
3. **Greeks Dashboard** - Visualize portfolio risk
4. **Correlation Analysis** - Avoid concentrated bets
5. **Volatility Forecasting** - Predict IV changes
6. **Community Sharing** - Learn from others (optional)

---

**Sacred Technology meets Financial Literacy** 🔱

*Empowerment through knowledge, not exploitation through signals.*
