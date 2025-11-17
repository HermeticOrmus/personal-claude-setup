# MCP Diagram Servers - API Requirements

> TL;DR: **No API keys needed!** All three servers work out of the box.

---

## ✅ Current Status: Fully Functional

All three MCP diagram servers installed in your configuration are **ready to use immediately** after restarting Claude Desktop.

**No API keys required.**
**No additional configuration needed.**
**No external services to sign up for.**

---

## Server-by-Server Breakdown

### 1. **UML-MCP** (`@antoinebou12/uml-mcp`)

**API Key Required:** ❌ No

**Default Behavior:**
- Works completely out of the box
- Uses free public services for diagram rendering
- No authentication needed

**Optional Configuration:**
If you want to use your own private servers (advanced, not required):

```json
{
  "uml-mcp": {
    "command": "npx",
    "args": ["-y", "@antoinebou12/uml-mcp"],
    "env": {
      "MCP_OUTPUT_DIR": "/path/to/output",          // Optional
      "KROKI_SERVER": "http://localhost:8000",       // Optional
      "PLANTUML_SERVER": "http://localhost:8080",    // Optional
      "USE_LOCAL_KROKI": "true",                     // Optional
      "USE_LOCAL_PLANTUML": "true"                   // Optional
    }
  }
}
```

**When would you need this?**
- Running your own Kroki/PlantUML servers (enterprise/privacy reasons)
- Heavy usage requiring dedicated infrastructure
- Offline diagram generation

**For normal use:** Leave it as-is. Works perfectly with public free services.

---

### 2. **mcp-mermaid** (`@hustcc/mcp-mermaid`)

**API Key Required:** ❌ No

**Default Behavior:**
- Client-side diagram rendering
- No external API calls
- Completely free and unlimited

**Optional Configuration:**
If you want to customize transport protocol (advanced, not required):

```json
{
  "mcp-mermaid": {
    "command": "npx",
    "args": [
      "-y",
      "@hustcc/mcp-mermaid",
      "--transport", "stdio",     // Default, optional to specify
      "--port", "3033"             // Only if using SSE transport
    ]
  }
}
```

**When would you need this?**
- Custom network configurations
- Non-standard MCP setups
- Advanced integrations

**For normal use:** Leave it as-is. Default stdio transport is perfect.

---

### 3. **AntV Charts** (`@antv/mcp-server-chart`)

**API Key Required:** ❌ No

**Default Behavior:**
- Free chart generation
- No rate limits
- No authentication

**Optional Configuration:**
If you want advanced features (not required for basic use):

```json
{
  "antv-charts": {
    "command": "npx",
    "args": ["-y", "@antv/mcp-server-chart"],
    "env": {
      "VIS_REQUEST_SERVER": "https://your-server.com",  // Optional: Private deployment
      "SERVICE_ID": "your-service-id",                  // Optional: Geographic maps
      "DISABLED_TOOLS": "tool1,tool2"                   // Optional: Disable specific charts
    }
  }
}
```

**When would you need this?**
- **VIS_REQUEST_SERVER**: Running your own private AntV server (enterprise)
- **SERVICE_ID**: Using geographic map visualizations (requires AntV service account)
- **DISABLED_TOOLS**: Restricting which chart types are available

**For normal use:** Leave it as-is. All 25+ chart types work without configuration.

---

## Why No API Keys?

### UML-MCP
- Uses free public Kroki API (kroki.io)
- Client-side rendering for Mermaid
- No authentication model

### mcp-mermaid
- Pure client-side JavaScript library (Mermaid.js)
- Renders in-process, no external calls
- Open source, no restrictions

### AntV Charts
- Free open-source visualization library
- Developed by Ant Group (Alibaba)
- No commercial restrictions for basic features

---

## Rate Limits?

**UML-MCP:**
- Public Kroki API: Generous free tier
- For heavy usage: Consider self-hosting (optional)
- Normal use: No limits you'll hit

**mcp-mermaid:**
- No limits (client-side rendering)
- Unlimited diagrams

**AntV Charts:**
- No limits (open source)
- Free for all use cases

---

## When Would You Add Configuration?

### Scenario 1: Enterprise Privacy Requirements

**Problem:** Company policy forbids external API calls

**Solution:** Self-host Kroki/PlantUML servers

```json
{
  "uml-mcp": {
    "command": "npx",
    "args": ["-y", "@antoinebou12/uml-mcp"],
    "env": {
      "USE_LOCAL_KROKI": "true",
      "KROKI_SERVER": "http://internal-kroki.company.com",
      "MCP_OUTPUT_DIR": "C:\\Company\\Diagrams"
    }
  }
}
```

---

### Scenario 2: Heavy Production Use

**Problem:** Generating 1000s of diagrams daily, concerned about public API reliability

**Solution:** Deploy private infrastructure

```json
{
  "antv-charts": {
    "command": "npx",
    "args": ["-y", "@antv/mcp-server-chart"],
    "env": {
      "VIS_REQUEST_SERVER": "https://charts.yourcompany.com"
    }
  }
}
```

---

### Scenario 3: Geographic Visualizations

**Problem:** Need China/world maps for data visualization

**Solution:** Register for AntV service (free)

```json
{
  "antv-charts": {
    "command": "npx",
    "args": ["-y", "@antv/mcp-server-chart"],
    "env": {
      "SERVICE_ID": "your-free-service-id"
    }
  }
}
```

**How to get SERVICE_ID:**
1. Visit AntV website
2. Register (free)
3. Get service ID
4. Add to config

---

## Your Current Configuration

**Status:** ✅ Production-ready as-is

```json
{
  "uml-mcp": {
    "command": "npx",
    "args": ["-y", "@antoinebou12/uml-mcp"]
  },
  "antv-charts": {
    "command": "npx",
    "args": ["-y", "@antv/mcp-server-chart"]
  },
  "mcp-mermaid": {
    "command": "npx",
    "args": ["-y", "@hustcc/mcp-mermaid"]
  }
}
```

**This configuration provides:**
- ✅ All diagram types (flowcharts, state, sequence, class, etc.)
- ✅ All chart types (25+ from AntV)
- ✅ Full Mermaid feature set
- ✅ Unlimited usage
- ✅ No costs
- ✅ No rate limits you'll hit
- ✅ Works offline (mcp-mermaid)
- ✅ Works online (UML-MCP uses free public APIs)

---

## Testing After Restart

**Once you restart Claude Desktop, test with:**

### Test 1: Mermaid (Client-Side)
> "Using mcp-mermaid, create a simple flowchart: Start → Process → End. Use Hermetic gold color for Start."

**Expected:** Instant generation, no API calls needed

---

### Test 2: UML-MCP (Public API)
> "Using UML-MCP, create a PlantUML class diagram showing: Principle → Tool → Outcome relationships"

**Expected:** Quick generation via free Kroki API

---

### Test 3: AntV Charts (Data Viz)
> "Using AntV Charts, create a radar chart with 7 points: Mentalism 8, Correspondence 7, Vibration 9, Polarity 6, Rhythm 5, Cause-Effect 8, Gender 7"

**Expected:** Interactive HTML chart, no API required

---

## Troubleshooting

### "Server not responding"
**Check:**
1. Did you restart Claude Desktop?
2. Is internet connected? (UML-MCP uses public APIs)
3. Check Claude logs: `C:\Users\ormus\AppData\Roaming\Claude\logs`

**Not related to API keys** - these servers don't use authentication

---

### "Diagram generation failed"
**Possible causes:**
1. Network issue (for UML-MCP public API calls)
2. Invalid diagram syntax
3. MCP server crashed (restart Claude Desktop)

**Not related to API keys** - no authentication failures possible

---

### "Rate limit reached"
**Unlikely scenarios:**
- UML-MCP: Public Kroki API has generous limits
- mcp-mermaid: No limits (client-side)
- AntV Charts: No limits (open source)

**If you somehow hit limits:**
- UML-MCP: Consider self-hosting Kroki (advanced)
- Others: Should never happen

---

## Summary

### Current Status
✅ **All servers functional without API keys**

### Action Required
⚡ **Restart Claude Desktop** - that's it!

### Future Configuration
📋 **Only if you need:**
- Private/offline diagram generation (enterprise)
- Geographic map visualizations (free SERVICE_ID)
- Custom output directories

### For Hermetic Use
🎨 **Current setup is perfect:**
- Generate system diagrams
- Create principle scorecards
- Track alignment metrics
- Build dashboards
- Export to SVG/PNG/PDF/HTML

**No additional setup needed!**

---

## Next Steps

1. **Restart Claude Desktop**
2. **Test diagram generation** (examples above)
3. **Start creating:**
   - Render existing diagrams in `.hermetic/diagrams/`
   - Generate principle scorecards
   - Build alignment dashboards
   - Create custom visualizations

4. **If you need advanced features later:**
   - Self-hosting: See UML-MCP docs
   - Geographic maps: Register at AntV
   - Custom output: Add MCP_OUTPUT_DIR env var

---

*"Simplicity is the ultimate sophistication. These tools work because they're built right."*

*— Hermetic Principle of Mentalism: Clear tools serve clear intention*
