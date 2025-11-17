# Hermetic Market Teacher Workflows

This directory contains n8n workflow templates for the Hermetic Market Teacher OS.

## Workflow Categories

### 📈 Core Intelligence (Daily)
1. **morning-intelligence-brief** - Comprehensive pre-market analysis
2. **multi-indicator-scanner** - Real-time technical signal detection
3. **ai-market-synthesis** - End-of-day AI-powered summary

### 📊 Sentiment & News (Continuous)
4. **sentiment-aggregation** - Social media and community sentiment
5. **news-catalyst-scanner** - Real-time news event monitoring

### 🎯 Risk & Portfolio (Real-time + Daily)
6. **portfolio-risk-dashboard** - Portfolio Greeks and risk monitoring
7. **paper-trading-integration** - Automated paper trading tracker

### 📚 Learning & Review (Weekly)
8. **weekly-performance-review** - Comprehensive performance analysis
9. **lesson-extraction** - AI-powered lesson identification

## Import Instructions

1. Open n8n: `http://localhost:5678` (or your n8n instance)
2. Click "+" → "Import from File"
3. Select the workflow JSON file
4. Configure credentials:
   - Alpha Vantage API key
   - TwelveData API key
   - OpenAI API key
   - Telegram bot token
   - PostgreSQL connection
5. Activate the workflow
6. Test with manual trigger

## Workflow Dependencies

**Required APIs** (Free Tier):
- Alpha Vantage (25 calls/day): https://www.alphavantage.co/support/#api-key
- TwelveData (800 credits/day): https://twelvedata.com/
- OpenAI (pay-as-you-go): https://platform.openai.com/
- Finnhub (60 calls/min): https://finnhub.io/
- NewsAPI (100 calls/day): https://newsapi.org/

**Required Infrastructure**:
- PostgreSQL database (see schema in HERMETIC-MARKET-TEACHER-OS.md)
- Telegram bot (create with @BotFather)
- Google Sheets (optional but recommended)

## Quick Start

**Day 1** - Set up foundation:
```bash
# 1. Import morning-intelligence-brief.json
# 2. Configure API credentials
# 3. Test run manually
# 4. Check Telegram for message
```

**Day 2** - Add scanning:
```bash
# 1. Import multi-indicator-scanner.json
# 2. Configure with same credentials
# 3. Schedule for 9:35 AM, 12:00 PM, 3:00 PM ET
# 4. Monitor signals for one day
```

**Week 1** - Complete core system:
```bash
# 1. Import remaining workflows
# 2. Configure all credentials
# 3. Set up PostgreSQL database
# 4. Test each workflow manually
# 5. Activate all workflows
# 6. Monitor for one week
```

## Customization

Each workflow includes comments explaining:
- Node purpose
- Data transformations
- Indicator calculations
- Alert logic
- Teaching content generation

Modify these to match your:
- Trading style (aggressive vs conservative)
- Watchlist (add/remove tickers)
- Alert thresholds (RSI levels, volume multipliers)
- Notification channels (Telegram, Discord, Email)
- Position sizing rules

## Troubleshooting

**No Telegram messages?**
- Check bot token is correct
- Verify chat ID in Telegram node
- Test with /start message to bot

**Database errors?**
- Verify PostgreSQL is running
- Check credentials in n8n
- Run schema creation script
- Test connection manually

**API rate limits hit?**
- Reduce watchlist size
- Increase workflow intervals
- Upgrade to paid API tier
- Implement caching nodes

**Wrong data in alerts?**
- Check API response structure
- Verify symbol format (AAPL vs AAPL.US)
- Review Code node transformations
- Test with manual execution

## Support

See main documentation: `.hermetic/trading/HERMETIC-MARKET-TEACHER-OS.md`

For n8n-specific issues: https://docs.n8n.io/
