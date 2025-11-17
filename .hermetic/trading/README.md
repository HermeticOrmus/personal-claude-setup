# Hermetic Trading System

> **"Cause & Effect" - Every financial decision compounds over time; small choices create large outcomes**

## Overview

The Hermetic Trading System is a **financial education automation** that empowers you with knowledge, strategy, and disciplined analysis - not "hot tips" or market manipulation. Built on Gold Hat principles, this system rejects predatory trading culture in favor of sustainable wealth-building through understanding.

**Philosophy**: Informed decisions over speculation. Risk awareness over false promises. Education over exploitation.

### What This System Does

- **Scans market opportunities** using technical and fundamental analysis
- **Generates educational playbooks** with full strategy explanations
- **Delivers actionable insights** via Telegram notifications
- **Archives performance data** for continuous learning
- **Teaches trading principles** while identifying opportunities

### What This System IS NOT

This is **NOT**:
- A "get rich quick" scheme
- A subscription signal service
- Market manipulation or pump-and-dump
- Investment advice (consult licensed professionals)
- A replacement for your own due diligence

This **IS**:
- Educational automation teaching trading strategies
- Transparent risk disclosure on every play
- Paper trading encouragement before real capital
- Sustainable wealth-building methodology
- Sacred stewardship of financial knowledge

---

## Architecture

### System Flow

```
Schedule Trigger → Market Data Fetch → Opportunity Analysis → Playbook Generation → Telegram Delivery
      ↓                  ↓                      ↓                      ↓                    ↓
   Cron Job         Free APIs            Scanning Logic          Templates          Your Phone
                        ↓                                              ↓
                Historical Data                              Stored in .hermetic/trading/
```

### Core Components

**1. Stock Options Monitor**
- **Purpose**: Automated scanning for high-probability option plays
- **Data Sources**: Alpha Vantage, Yahoo Finance, Polygon.io
- **Scanning Frequency**:
  - 9:35 AM ET (morning setups)
  - 12:00 PM ET (midday momentum)
  - 3:00 PM ET (end-of-day positioning)
  - Sunday 6:00 PM ET (week-ahead analysis)
- **Alert Method**: Telegram bot notifications
- **Location**: `.hermetic/tools/stock-options-workflow.json`

**2. Playbook Library**
- **Purpose**: Store detailed trade strategies with educational content
- **Location**: `.hermetic/trading/playbooks/`
- **Format**: JSON files with complete trade details
- **Retention**: All playbooks archived for performance review

**3. Historical Archive**
- **Purpose**: Track long-term performance and lessons learned
- **Location**: `.hermetic/trading/archive/`
- **Organization**: Organized by month for analysis
- **Contents**: Actual results, win/loss data, strategy refinements

---

## Active Systems

### Stock Options Workflow

**n8n Automation Details**:
- **Workflow File**: `C:\Users\ormus\.hermetic\tools\stock-options-workflow.json`
- **Backup/Fixed Version**: `stock-options-workflow-fixed.json`
- **Documentation**: `stock-options-playbook-system.md`

**Data Sources** (All Free Tier):

| Source | Purpose | Limitations | API Key Required |
|--------|---------|-------------|------------------|
| **Alpha Vantage** | Stock quotes, historical data, technical indicators | 25 calls/day | Yes - [Get Key](https://www.alphavantage.co/support/#api-key) |
| **Yahoo Finance** | Real-time quotes, options chains | Unofficial API, may change | No |
| **Polygon.io** | Options data, market sentiment | 5 calls/min | Yes - [Get Key](https://polygon.io/) |
| **TradingView Webhooks** | Custom technical analysis alerts | None | No |

**Scanning Criteria**:

*Technical Filters*:
- High IV Rank (>50) - Options premium expansion
- Price near support/resistance - Defined risk zones
- Volume spike - Liquidity confirmation
- RSI extremes - Oversold (<30) or Overbought (>70)
- Moving average bounces - Trend validation

*Fundamental Filters*:
- Upcoming earnings dates - IV crush opportunities
- News catalysts - FDA approvals, product launches
- Sector rotation patterns - Follow institutional money
- Insider/institutional buying - Smart money signals

*Risk Management Filters*:
- Options liquidity - Bid-ask spread <$0.10
- Open interest - Minimum 100 contracts
- Days to expiration - 30-45 DTE optimal
- Probability of profit - >60% for conservative plays

---

## Playbook System

### Strategy Types

**1. Bull Call Spread** (Moderate Bullish)
- **Use Case**: Moderately bullish outlook, defined risk
- **Max Profit**: Limited (spread width - net debit)
- **Max Loss**: Limited (net debit paid)
- **Best For**: Directional plays with controlled downside

**2. Bear Put Spread** (Moderate Bearish)
- **Use Case**: Moderately bearish outlook, defined risk
- **Max Profit**: Limited (spread width - net debit)
- **Max Loss**: Limited (net debit paid)
- **Best For**: Downside protection with capped risk

**3. Iron Condor** (Neutral/Range-Bound)
- **Use Case**: Low volatility, stock stays in range
- **Max Profit**: Limited (net credit received)
- **Max Loss**: Limited (spread width - net credit)
- **Best For**: Theta decay income generation

**4. Covered Call** (Income Generation)
- **Use Case**: Own stock, generate income, cap upside acceptable
- **Max Profit**: Limited (strike - stock price + premium)
- **Max Loss**: Substantial (stock could go to zero)
- **Best For**: Long-term holdings with sideways outlook

**5. Cash-Secured Put** (Wheel Strategy)
- **Use Case**: Willing to own stock at lower price
- **Max Profit**: Limited (premium received)
- **Max Loss**: Substantial (strike - premium)
- **Best For**: Building positions while collecting premium

**6. Straddle** (High Volatility Expected)
- **Use Case**: Big move expected, direction unknown
- **Max Profit**: Unlimited
- **Max Loss**: Limited (total premium paid)
- **Best For**: Earnings plays, major events

### Playbook Message Format

Every playbook delivered includes:

```
🎯 PLAYBOOK: [Strategy Name]
📊 TICKER: Symbol
💡 OUTLOOK: Market view
⏰ TIMEFRAME: Days to expiration

THE PLAY
- Specific strikes and prices
- Net debit/credit
- Position sizing guidance

PROFIT/LOSS SCENARIOS
- Maximum profit ($ and %)
- Maximum loss ($ and %)
- Breakeven price
- Probability of profit

WHY THIS WORKS
- Technical setup explanation
- Fundamental catalysts
- Risk/reward justification

ENTRY RULES
- Specific triggers to enter
- Conditions that invalidate setup
- Timing considerations

EXIT STRATEGIES
- Multiple profit targets
- Stop loss levels
- Time decay exits
- Trend break protocols

RISK DISCLOSURE
- What can go wrong
- Maximum capital at risk
- Position sizing rules
- Educational disclaimer

LEARNING RESOURCES
- Strategy explanation links
- Greeks breakdown
- Video tutorials
```

**Full format details**: See `stock-options-playbook-system.md`

---

## Position Sizing & Risk Management

### The 2% Rule

**Never risk more than 2% of account on a single trade.**

```
Example:
Account Size: $10,000
Max Risk Per Trade: 2% = $200
Max Loss on Bull Call Spread: $300
Position Size: 0 contracts (risk exceeds limit)

If max loss was $150:
Position Size: 1 contract (1.5% risk - ACCEPTABLE)
```

### Win Rate Expectations

**Conservative Strategies** (Iron Condors, Credit Spreads):
- Win Rate: 70-80%
- Average Win: $50-100
- Average Loss: $150-200
- Required: Consistent execution, 3:1 win/loss ratio

**Aggressive Strategies** (Directional Plays):
- Win Rate: 40-50%
- Average Win: $300-500
- Average Loss: $100-150
- Required: Winners must be larger than losers

**Neutral Strategies** (Theta Decay):
- Win Rate: 60-70%
- Average Win: $50-75
- Average Loss: $100-150
- Required: High volume of trades over time

### Greeks Management

**Delta**: Directional exposure
- Bull plays: Positive delta
- Bear plays: Negative delta
- Neutral plays: Near-zero delta

**Theta**: Time decay
- Income strategies: Positive theta (seller)
- Directional strategies: Negative theta (buyer)

**Vega**: Volatility exposure
- High IV: Sell premium
- Low IV: Buy premium

**Gamma**: Delta acceleration
- Monitor near expiration
- Adjust positions as needed

---

## Paper Trading Workflow

**Before risking real capital, prove the strategy works in simulation.**

### Recommended Platforms

| Platform | Best For | Key Feature |
|----------|----------|-------------|
| **ThinkorSwim** (TD Ameritrade) | Technical analysis | Advanced charting |
| **TastyWorks** | Options-focused trading | Low commissions |
| **TradeStation** | Automation | Strategy backtesting |
| **Webull** | Mobile trading | User-friendly interface |

### Paper Trading Process

1. **Receive playbook** on Telegram
2. **Log into simulator** (paper trading account)
3. **Execute exact play** - Same strikes, same expiration
4. **Track in spreadsheet** - Entry, exit, P/L, notes
5. **Follow exit rules** - Don't deviate from playbook
6. **Review weekly** - What worked? What didn't?

**Goal**: 10+ consecutive profitable weeks in simulation before live trading.

---

## Playbooks Directory

**Location**: `C:\Users\ormus\.hermetic\trading\playbooks\`

**File Naming Convention**:
```
YYYY-MM-DD_TICKER_strategy-name.json
```

**Examples**:
```
2025-01-15_SPY_bull-call-spread.json
2025-01-15_AAPL_iron-condor.json
2025-01-16_TSLA_cash-secured-put.json
```

**Contents of Each File**:
- Timestamp of generation
- Market conditions at time of scan
- Complete playbook details
- Entry/exit rules
- Risk parameters
- Educational resources
- Actual results (if traded)
- Lessons learned (post-trade review)

**Organization**:
```
playbooks/
├── 2025-01-15_SPY_bull-call-spread.json
├── 2025-01-15_AAPL_iron-condor.json
├── 2025-01-16_TSLA_cash-secured-put.json
└── (Active playbooks remain in root)
```

---

## Archive Directory

**Location**: `C:\Users\ormus\.hermetic\trading\archive\`

**Purpose**: Historical performance tracking and continuous learning.

**Organization**:
```
archive/
├── 2025-01/
│   ├── performance-summary.json
│   ├── closed-trades/
│   │   ├── SPY_bull-call-spread_WIN.json
│   │   └── AAPL_iron-condor_LOSS.json
│   └── lessons-learned.md
├── 2025-02/
└── 2025-03/
```

**What Gets Archived**:
- Closed trades (wins and losses)
- Monthly performance summaries
- Win/loss ratios by strategy
- Average P/L per trade type
- Market conditions analysis
- Strategy refinements
- Lessons learned documentation

**Why Archive Matters**:
- Track long-term performance
- Identify which strategies work best for you
- Recognize patterns in wins/losses
- Refine scanning criteria
- Build trading journal
- Measure improvement over time

---

## Gold Hat Trading Principles

### 1. Informed Decisions Over Speculation

**Mentalism Applied**: Clear mental models before entry.
- Understand the strategy completely
- Know why this trade has edge
- Visualize profit/loss scenarios
- Enter with conviction, not hope

### 2. Risk Awareness Over False Promises

**Cause & Effect Applied**: Every trade has consequences.
- Maximum loss stated explicitly
- Probability of profit calculated
- Position sizing enforced
- No hiding downside to make plays attractive

### 3. Education Over Exploitation

**Sacred Technology Applied**: Teach, don't manipulate.
- Every playbook explains the "why"
- Resources provided for deeper learning
- Encourage paper trading first
- No subscription fees or upsells

### 4. Transparency Over Manipulation

**Gold Hat Commitment**: No dark patterns.
- Win rates reported honestly
- Losses documented openly
- No cherry-picking successful trades
- No FOMO tactics or artificial scarcity

### 5. Rhythm Over Grind

**Sustainable Trading**: Respect market cycles.
- Don't force trades in poor conditions
- Take breaks during low-probability setups
- Review and reflect weekly
- Long-term consistency over short-term heroics

### 6. Balance Over Extremes

**Polarity Applied**: Multiple strategies for different conditions.
- Bull, bear, and neutral strategies
- Conservative and aggressive approaches
- Income and growth plays
- Diversification across strategy types

### 7. Continuous Learning Over Ego

**Vibration Applied**: Iterate and improve.
- Track every trade
- Review mistakes without shame
- Refine strategies based on data
- Evolve as market conditions change

---

## Getting Started

### Step 1: Set Up Data Sources

1. **Get API Keys**:
   - Alpha Vantage: [Register here](https://www.alphavantage.co/support/#api-key)
   - Polygon.io: [Register here](https://polygon.io/)

2. **Configure n8n Workflow**:
   - Import `stock-options-workflow.json` into n8n
   - Add API credentials
   - Set up Telegram bot for notifications
   - Test with sample run

3. **Verify Connections**:
   - Test each data source individually
   - Confirm Telegram messages deliver
   - Verify playbook files save correctly

### Step 2: Paper Trade First

1. **Choose Platform**: ThinkorSwim, TastyWorks, etc.
2. **Create Spreadsheet**: Track every simulated trade
3. **Follow Playbooks Exactly**: No deviations
4. **Review Weekly**: Analyze wins and losses
5. **Prove Consistency**: 10+ profitable weeks before going live

### Step 3: Start Small (If Going Live)

1. **Minimum Account**: $2,000+ recommended
2. **Trade Small Positions**: 1 contract max to start
3. **Follow 2% Rule**: Never risk more than 2% per trade
4. **Document Everything**: Maintain trading journal
5. **Review Monthly**: Assess what's working

### Step 4: Continuous Improvement

1. **Track Performance**: Win rate, avg P/L, strategy effectiveness
2. **Refine Scanning**: Adjust criteria based on results
3. **Learn Continuously**: Study Greeks, market mechanics, strategy nuances
4. **Stay Disciplined**: Follow rules even when tempted to deviate
5. **Iterate**: Small improvements compound over time

---

## Maintenance Schedule

### Daily (Automated)

- **9:35 AM ET**: Morning scan triggers
- **12:00 PM ET**: Midday scan triggers
- **3:00 PM ET**: End-of-day scan triggers
- Playbooks generated and delivered via Telegram
- Files saved to `playbooks/` directory

### Weekly (Manual)

- **Sunday 6:00 PM ET**: Review week-ahead scan
- Review open positions
- Update trading journal
- Archive closed trades
- Check API usage limits
- Review performance metrics

### Monthly (Manual)

- Archive previous month's playbooks
- Generate performance summary
- Review win/loss ratios by strategy
- Refine scanning criteria if needed
- Update educational resources
- Document lessons learned

### Quarterly (Manual)

- Deep performance analysis
- Strategy effectiveness review
- Market condition adjustments
- System improvements
- Goal setting for next quarter

---

## Educational Resources

### Books (Recommended Reading)

**Options Fundamentals**:
- "Options as a Strategic Investment" - Lawrence G. McMillan
- "The Options Playbook" - Brian Overby
- "Understanding Options" - Michael Sincere

**Advanced Strategies**:
- "Trading Options Greeks" - Dan Passarelli
- "Option Volatility and Pricing" - Sheldon Natenberg
- "The Option Trader's Hedge Fund" - Mark Sebastian

**Trading Psychology**:
- "Trading in the Zone" - Mark Douglas
- "The Daily Trading Coach" - Brett Steenbarger
- "Reminiscences of a Stock Operator" - Edwin Lefèvre

### Websites (Free Education)

- **OptionAlpha.com** - Comprehensive free courses
- **TastyTrade.com** - Daily market analysis and education
- **TheOptionsGuide.com** - Strategy tutorials and examples
- **Investopedia Options** - Definitions and concept explanations
- **CBOE Learning Center** - Exchange-provided education

### YouTube Channels (Quality Content)

- **projectfinance** - Options education and strategy breakdowns
- **InTheMoney** - Beginner-friendly options explanations
- **SMB Capital** - Professional trading education
- **TastyTrade** - Live trading commentary
- **The Chart Guys** - Technical analysis fundamentals

### Tools & Calculators

- **OptionStrat.com** - Free options profit/loss calculator
- **OptionsProfit Calculator** - Visualize payoff diagrams
- **Barchart Options** - Free options chains and analysis
- **TradingView** - Technical analysis and charting

---

## Compliance & Disclaimers

### Important Legal Notices

**THIS SYSTEM PROVIDES EDUCATIONAL CONTENT ONLY, NOT INVESTMENT ADVICE.**

- I am not a licensed financial advisor
- This is not personalized investment advice
- Options trading involves substantial risk of loss
- You can lose more than your initial investment
- Past performance does not guarantee future results
- Market conditions change; strategies may stop working
- Do your own due diligence before every trade
- Consult a licensed professional for personalized advice

### Risk Disclosures

**Options Trading Risks**:
- Options can expire worthless (100% loss)
- High volatility can cause rapid losses
- Time decay erodes option value daily
- Liquidity can disappear during market stress
- Assignment risk on short options
- Margin requirements can change suddenly

**System Limitations**:
- Automated scans may miss opportunities
- False signals will occur
- Market conditions change faster than automation
- No guarantee of profitability
- Technical failures can occur
- Data sources may have errors or delays

### Ethical Commitments

**What This System Will NEVER Do**:
- Pump and dump schemes
- Market manipulation
- Hide risks to make plays attractive
- Charge subscription fees for signals
- Use FOMO tactics
- Recommend overleveraged positions
- Guarantee returns
- Pressure you to trade

**What This System ALWAYS Does**:
- Full risk disclosure on every play
- Honest win rate expectations
- Position sizing guidance
- Paper trading encouragement
- Multiple exit strategies
- Educational explanations
- Open-source methodology
- No hidden agendas

---

## Future Enhancements

### Planned Features (Roadmap)

**Phase 1: Foundation** (Complete)
- Automated market scanning
- Playbook generation
- Telegram delivery
- Basic archiving

**Phase 2: Analytics** (In Progress)
- Backtesting engine - Test strategies on historical data
- Performance dashboard - Visualize win/loss metrics
- Strategy comparison - Which plays work best
- Market condition correlations - When does each strategy excel

**Phase 3: Risk Management** (Planned)
- Portfolio tracker - Monitor all open positions
- Greeks dashboard - Real-time risk visualization
- Correlation analysis - Avoid concentrated bets
- Position sizing calculator - Automated risk management

**Phase 4: Advanced** (Future)
- Volatility forecasting - Predict IV changes
- Earnings calendar integration - Automatic event awareness
- Multi-timeframe analysis - Short, medium, long-term setups
- Machine learning optimization - Pattern recognition improvement

**Phase 5: Community** (Optional)
- Anonymous performance sharing - Learn from aggregate data
- Strategy discussions - Educational forum
- Paper trading competitions - Practice with peers
- Open-source contributions - Improve system collectively

### How to Contribute

This is a **Gold Hat project** - open source, freely shared.

**Ways to Help**:
1. **Test and Report Bugs** - Use the system, document issues
2. **Share Strategy Ideas** - Suggest new scanning criteria
3. **Improve Documentation** - Clarify confusing sections
4. **Code Contributions** - Submit pull requests
5. **Educational Content** - Add learning resources
6. **Feedback** - What's working? What's not?

**Repository**: (To be created on GitHub)
**License**: MIT (open and free)

---

## Sacred Questions Before Every Trade

### The Hermetic Trading Checklist

Before entering any position, ask:

**Mentalism - "Is my thinking clear?"**
- Do I understand this strategy completely?
- Can I explain the profit/loss scenarios?
- Am I entering with conviction or hope?

**Correspondence - "Does this fit my system?"**
- Does this match my trading plan?
- Is position size appropriate for account?
- Does this align with my risk tolerance?

**Vibration - "Am I forcing this?"**
- Is this a high-probability setup or am I impatient?
- Are market conditions favorable?
- Am I trading or overtrading?

**Polarity - "Have I balanced the forces?"**
- Do I know both profit AND loss scenarios?
- Have I planned entry AND exit?
- Am I managing both risk AND reward?

**Rhythm - "Is the timing right?"**
- Is this the right part of market cycle?
- Am I trading during optimal conditions?
- Is my energy/focus adequate?

**Cause & Effect - "What are the consequences?"**
- What happens if I'm wrong?
- Can I afford maximum loss?
- What's the downstream impact on portfolio?

**Gender - "Am I balancing doing and being?"**
- Am I analyzing (masculine) and intuiting (feminine)?
- Am I aggressive (yang) and patient (yin)?
- Am I executing trades and reflecting on results?

**If you can't answer all seven questions clearly, DO NOT TRADE.**

---

## Closing Wisdom

### The Path to Trading Mastery

**Trading is not gambling. It's not luck. It's disciplined execution of edge over time.**

**The Sacred Trading Journey**:

1. **Education** - Learn strategies, understand mechanics
2. **Simulation** - Prove strategies in paper trading
3. **Small Size** - Start tiny to build confidence
4. **Consistency** - Execute system without deviation
5. **Review** - Learn from every trade
6. **Refinement** - Improve based on data
7. **Scale** - Grow position sizes slowly
8. **Mastery** - Sustain profitability long-term

**Most traders fail because they skip steps 1-4 and jump to step 7.**

Don't be most traders.

### The Hermetic Trading Vow

> "I trade with consciousness and discipline.
> I risk only what I can afford to lose.
> I follow my plan without deviation.
> I learn from every outcome.
> I respect the market's power.
> I honor my capital's sacred trust.
> I build wealth sustainably, not recklessly.
> I serve my future self through present discipline."

---

## Quick Reference

### Pre-Trade Checklist

- [ ] Strategy understood completely
- [ ] Max loss acceptable (≤2% of account)
- [ ] Entry rules met
- [ ] Exit plan defined
- [ ] Position sized correctly
- [ ] Market conditions favorable
- [ ] Mental state clear and focused
- [ ] Trade logged in journal

### In-Trade Management

- [ ] Monitor position daily
- [ ] Stick to exit rules
- [ ] Don't adjust plan mid-trade (unless critical)
- [ ] Manage emotions (fear/greed)
- [ ] Be ready to take loss if needed

### Post-Trade Review

- [ ] Document entry/exit prices
- [ ] Calculate P/L
- [ ] Note what worked/didn't work
- [ ] Identify lessons learned
- [ ] Update performance metrics
- [ ] Archive trade details

---

## Support & Contact

### Getting Help

**System Issues**:
- Check workflow logs in n8n
- Verify API credentials
- Review Telegram bot configuration
- Ensure adequate API call limits

**Trading Questions**:
- Consult educational resources first
- Review playbook documentation
- Study strategy explanations
- Consider professional advisor for personalized guidance

**Community** (Future):
- GitHub Discussions (when repository live)
- Anonymous performance sharing
- Strategy discussion forums

### Remember

**You are not alone in this journey.**

Trading is challenging. Losses will happen. Mistakes are inevitable.

But with discipline, education, and sacred intention, sustainable profitability is achievable.

**Trade with consciousness. Learn with humility. Build with patience.**

---

**Built with Sacred Intention. Shared with Love. In Service of Financial Literacy.**

*"The market rewards discipline, punishes ego, and teaches those who listen."*

— Hermetic Ormus

---

**Last Updated**: October 2024
**Version**: 1.0
**Status**: Active Development

🔱 Sacred Technology meets Financial Mastery 🔱
