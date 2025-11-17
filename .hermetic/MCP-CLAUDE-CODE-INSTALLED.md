# MCP Diagram Servers - Claude Code Configuration ✅

> Successfully installed in Claude Code (not Claude Desktop)

---

## ✅ Installation Complete

**Date:** November 7, 2025, 11:07 PM
**Location:** `C:\Users\ormus\.claude.json`
**Project:** `C:\Users\ormus`

Three MCP diagram servers have been added to your Claude Code configuration:

### 1. **uml-mcp**
```json
{
  "command": "npx",
  "args": ["-y", "@antoinebou12/uml-mcp"]
}
```

### 2. **antv-charts**
```json
{
  "command": "npx",
  "args": ["-y", "@antv/mcp-server-chart"]
}
```

### 3. **mcp-mermaid**
```json
{
  "command": "npx",
  "args": ["-y", "@hustcc/mcp-mermaid"]
}
```

---

## 🔄 Next Step: Restart Session

**To activate these servers, restart your Claude Code session:**

### Method 1: Type Command
```
/restart
```

### Method 2: Keyboard Shortcut
- Press `Ctrl + Shift + P` (Windows/Linux)
- Type "restart"
- Select "Developer: Reload Window"

### Method 3: Close and Reopen
- Close Claude Code completely
- Reopen from terminal or start menu

---

## 🎨 After Restart

Once restarted, I will have access to these MCP tools for generating:

**System Diagrams:**
- Flowcharts (system architecture)
- State diagrams (economic tiers, lifecycles)
- Sequence diagrams (hooks flow, interactions)
- Class diagrams (architecture)
- Gantt charts (timelines, mastery path)
- Mind maps (concept relationships)

**Data Visualizations:**
- Radar charts (principle scorecards)
- Line charts (alignment trends)
- Bar/column charts (comparisons)
- Pie charts (proportions)
- Scatter plots (correlations)
- 20+ other chart types

**Output Formats:**
- SVG (scalable, web)
- PNG (presentations)
- PDF (print quality)
- HTML (interactive dashboards)

---

## 📁 Configuration Details

**Config File:** `~/.claude.json`
**Backup Created:** `~/.claude.json.backup-[timestamp]`

**Current Project MCP Servers:**
```json
"C:\\Users\\ormus": {
  "mcpServers": {
    "supabase": { ... },
    "uml-mcp": { ... },
    "antv-charts": { ... },
    "mcp-mermaid": { ... }
  }
}
```

---

## 🚀 First Test After Restart

Try this command:

> "Using mcp-mermaid, render .hermetic/diagrams/system-overview.mmd as SVG"

This will generate the complete Hermetic system architecture diagram with:
- Gold Hat core question
- 7 Hermetic Principles
- Implementation layer (Commands/Skills/Agents)
- Outputs (DevDocs/Code/Projects)
- Feedback layer (Retrospectives)
- Anti-patterns (rejection list)

All in beautiful Gold/Purple/Emerald brand colors.

---

## 🔧 Troubleshooting

### "MCP servers not showing up after restart"

**Check:**
1. Did you fully restart Claude Code session?
2. Run: `/restart` or reload window
3. Check logs: `~/.claude/debug/`

**Verify config:**
```bash
cat ~/.claude.json | grep -A 5 "uml-mcp"
```

Should show the three servers.

---

### "npx command not found"

**On Windows, use full path:**

Edit `~/.claude.json` and change:
```json
"command": "npx"
```

To:
```json
"command": "C:\\Program Files\\nodejs\\npx.cmd"
```

---

### "Still not working"

**Alternative: Use .mcp.json in project directory**

Create `C:\Users\ormus\.mcp.json`:
```json
{
  "mcpServers": {
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
}
```

---

## 📚 Related Documentation

**Setup Guides:**
- `MCP-DIAGRAM-SERVERS-INSTALLED.md` - Claude Desktop config (reference only)
- `VISUAL-DIAGRAM-MCP-GUIDE.md` - Comprehensive usage guide
- `MCP-API-REQUIREMENTS.md` - No API keys needed confirmation

**Diagram Sources:**
- `.hermetic/diagrams/system-overview.mmd`
- `.hermetic/diagrams/decision-flow.mmd`
- `.hermetic/diagrams/economic-tiers.mmd`
- `.hermetic/diagrams/README.md`

---

## ✅ Checklist

- [x] Backup created: `~/.claude.json.backup-*`
- [x] Three MCP servers added to config
- [x] Configuration verified in correct project path
- [ ] **Restart Claude Code session** ← DO THIS NOW
- [ ] Test diagram generation
- [ ] Render system-overview.mmd
- [ ] Create principle scorecard
- [ ] Build metrics dashboard

---

## 🎯 What This Enables

**Automated Professional Diagrams:**
- Generate through conversation ("create a flowchart showing...")
- Render existing `.mmd` files ("render system-overview.mmd")
- Export to multiple formats (SVG, PNG, PDF, HTML)
- Maintain Hermetic brand consistency (Gold/Purple/Emerald)
- Version control diagrams as code
- Update with single command

**No More Manual Work:**
- ❌ No Figma/Adobe needed for system diagrams
- ❌ No manual chart creation for metrics
- ❌ No copy-paste for updates
- ✅ Just describe what you want → I generate it

---

## 💡 Example Commands After Restart

**Render Existing Diagrams:**
> "Render all .mmd files in .hermetic/diagrams as SVG and PNG"

**Create Custom Diagram:**
> "Create a Mermaid sequence diagram showing: User → UserPromptSubmit hook → Skills auto-activate → Claude responds → PostToolUse tracks files → StopEvent runs builds. Use Hermetic colors."

**Generate Dashboard:**
> "Using AntV Charts, create an interactive HTML dashboard with:
> 1. Radar chart of my 7 principle scores
> 2. Line chart showing alignment trend over 12 months
> 3. Stacked bar chart of income sources weighted by alignment"

**Batch Export:**
> "Export system-overview.mmd, decision-flow.mmd, and economic-tiers.mmd as both SVG (for web) and PNG (for presentations, 2400x1800)"

---

## 🏁 Summary

**What was configured:**
- ✅ uml-mcp (universal diagrams)
- ✅ antv-charts (25+ chart types)
- ✅ mcp-mermaid (feature-complete Mermaid)

**Where:**
- ✅ `~/.claude.json` (Claude Code config)
- ✅ Project: `C:\Users\ormus`

**Status:**
- ✅ Configuration complete
- ⏳ **Restart needed to activate**

**Next action:**
**Type `/restart` or reload window, then say "ready" to render your first diagram!**

---

*"Automation serves consciousness. The tools are ready - activate them."*

*— Hermetic Principle of Vibration: Movement creates manifestation*
