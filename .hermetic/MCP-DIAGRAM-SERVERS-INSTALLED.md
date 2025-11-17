# MCP Diagram Servers - Installation Complete ✅

> Professional diagram generation now available through conversation

---

## ✅ Installed Servers

**Three MCP servers have been added to your Claude Desktop configuration:**

### 1. **UML-MCP** (`@antoinebou12/uml-mcp`)
**Purpose:** Universal diagram generation
**Supports:** Mermaid, PlantUML, D2, Graphviz, ERD, BlockDiag, BPMN, C4
**Best for:** System architecture, decision flows, complex diagrams

### 2. **AntV Charts** (`@antv/mcp-server-chart`)
**Purpose:** Data visualization and metrics dashboards
**Supports:** 25+ chart types (area, bar, box, line, pie, radar, scatter, violin, word clouds)
**Best for:** Principle scorecards, alignment trends, economic progression tracking

### 3. **mcp-mermaid** (`@hustcc/mcp-mermaid`)
**Purpose:** Feature-complete Mermaid diagram generation
**Supports:** All Mermaid syntax with custom theming
**Best for:** Flowcharts, sequence diagrams, state diagrams with Hermetic brand colors

---

## 🔄 Next Step: Restart Required

**To activate these servers:**

1. **Quit Claude Desktop completely**
   - Right-click taskbar icon → Quit
   - Or: Alt+F4 when Claude Desktop is focused

2. **Restart Claude Desktop**
   - Launch from Start Menu or desktop shortcut

3. **Verify installation**
   - Once restarted, these servers will be available automatically
   - No additional configuration needed

---

## 🎨 How to Use (Examples)

### Generate the System Overview Diagram

**You can now say:**

> "Using the mcp-mermaid server, render the diagram in .hermetic/diagrams/system-overview.mmd as a high-resolution SVG file"

**Or more naturally:**

> "Render system-overview.mmd as SVG using Mermaid"

**Or create from scratch:**

> "Using UML-MCP, create a Mermaid flowchart showing the Hermetic system: Core Question at top, 7 Principles below, then Commands/Skills/Agents, then Outputs, then Feedback. Use Gold (#FFD700) for principles, Purple (#4B0082) for tools, Emerald (#50C878) for outcomes. Export as both SVG and PNG."

---

### Create a Metrics Dashboard

**Example:**

> "Using AntV Charts, create a radar chart showing my current scores on the 7 Hermetic Principles:
> - Mentalism: 8/10
> - Correspondence: 7/10
> - Vibration: 9/10
> - Polarity: 6/10
> - Rhythm: 5/10
> - Cause-Effect: 8/10
> - Gender: 7/10
>
> Use the Hermetic color scheme and make it interactive HTML."

---

### Generate Decision Flow

**Example:**

> "Create a decision flowchart using mcp-mermaid:
> Start with 'New Task' → Check if understood → /gnosis if not → Check if empowers users → /align if uncertain → Check for alternatives → Build → Verify → Ship → Celebrate.
> Use Hermetic brand colors. Export as SVG."

---

### Economic Tier Progression

**Example:**

> "Render the economic-tiers.mmd state diagram as a high-quality PNG suitable for presentations"

---

## 📊 Available Diagram Types

### Via UML-MCP or mcp-mermaid:

**Flowcharts** - Process flows, system architecture
```
"Create a Mermaid flowchart showing..."
```

**State Diagrams** - Lifecycles, progressions, transitions
```
"Create a state diagram showing economic tiers..."
```

**Sequence Diagrams** - Interactions, message flows
```
"Create a sequence diagram showing the hooks system..."
```

**Gantt Charts** - Timelines, schedules
```
"Create a Gantt chart showing the mastery timeline from Month 1 to Year 2+"
```

**Class Diagrams** - Object relationships, architecture
```
"Create a class diagram showing principle-tool-outcome relationships"
```

**Mind Maps** - Concept relationships
```
"Create a mindmap of the Hermetic framework"
```

### Via AntV Charts:

**Radar Charts** - Multi-dimensional comparisons
```
"Create a radar chart for principle scores"
```

**Line Charts** - Trends over time
```
"Create a line chart showing alignment scores over 12 months"
```

**Bar/Column Charts** - Comparisons
```
"Create a stacked bar chart showing income sources weighted by alignment"
```

**Pie Charts** - Proportions
```
"Create a pie chart showing time allocation across principles"
```

**Scatter Plots** - Correlations
```
"Create a scatter plot showing alignment vs economic tier"
```

---

## 🎨 Hermetic Brand Theming

**All diagrams can use the Hermetic color palette:**

```javascript
Gold: #FFD700      // Principles, core, success
Purple: #4B0082    // Tools, implementation
Emerald: #50C878   // Outcomes, positive results
Slate: #708090     // Structure, neutral
Dark Red: #8B0000  // Rejection, warnings
```

**To apply to Mermaid diagrams, include:**

```
"Use Hermetic brand colors: Gold #FFD700 for principles, Purple #4B0082 for tools, Emerald #50C878 for outcomes"
```

---

## 📁 Output Formats

**You can request any of these formats:**

- **SVG** - Scalable vector graphics (best for web, perfect quality at any size)
- **PNG** - Raster image (good for presentations, specify resolution)
- **PDF** - Print quality (use UML-MCP with Kroki backend)
- **HTML** - Interactive charts (AntV Charts default output)
- **Base64** - Embedded in markdown/documents

**Example:**
> "Export as both SVG and high-resolution PNG (2400x1800)"

---

## 🗂️ Recommended File Structure

**Save rendered diagrams to:**

```
.hermetic/diagrams/
├── system-overview.svg
├── system-overview.png
├── decision-flow.svg
├── economic-tiers.svg
├── principle-scorecard.html
├── alignment-trend.html
└── [your-custom-diagrams].svg
```

---

## 🔧 Troubleshooting

### "MCP server not responding"

**Solution:**
1. Restart Claude Desktop
2. Check config syntax (must be valid JSON)
3. Verify internet connection (npx downloads packages on first use)

### "Diagram generation failed"

**Solution:**
1. Try simpler diagram first
2. Check syntax if manually writing Mermaid code
3. Specify which server to use explicitly: "Using mcp-mermaid..."

### "Colors not applying"

**Solution:**
1. Explicitly request Hermetic colors in your prompt
2. For Mermaid, mention "use custom theme with Gold/Purple/Emerald colors"

---

## 💡 Pro Tips

### 1. Be Specific About Output

**Good:**
> "Render system-overview.mmd as SVG at 3000px width using mcp-mermaid"

**Also good:**
> "Create a radar chart of principle scores, export as interactive HTML"

### 2. Reference Existing Diagrams

**The source files are in `.hermetic/diagrams/`:**
- system-overview.mmd
- decision-flow.mmd
- economic-tiers.mmd

**You can say:**
> "Render decision-flow.mmd as PNG"

### 3. Iterate on Diagrams

**Generate → Review → Refine:**
1. "Create a flowchart showing X"
2. Review the result
3. "Make the boxes bigger and add colors"
4. "Perfect, now export as SVG"

### 4. Batch Processing

**You can request multiple diagrams at once:**
> "Render all three .mmd files in .hermetic/diagrams/ as both SVG and PNG"

---

## 🎯 Quick Start Checklist

- [x] MCP servers installed in config
- [ ] Restart Claude Desktop
- [ ] Test with: "Render system-overview.mmd as SVG"
- [ ] Generate principle scorecard radar chart
- [ ] Create alignment trend line chart
- [ ] Export diagrams for documentation/presentations

---

## 📚 Related Documentation

**Complete guides:**
- `VISUAL-DIAGRAM-MCP-GUIDE.md` - Comprehensive MCP diagram guide
- `diagrams/README.md` - How to use diagram source files
- `SYSTEM-MAP.md` - Which diagrams to create for what purpose

**Source files:**
- `diagrams/system-overview.mmd` - System architecture
- `diagrams/decision-flow.mmd` - Task workflow
- `diagrams/economic-tiers.mmd` - Financial progression

---

## 🚀 Next Actions

**After restarting Claude Desktop:**

1. **Test the installation:**
   > "Using mcp-mermaid, render .hermetic/diagrams/system-overview.mmd as SVG"

2. **Create your first metric:**
   > "Using AntV Charts, create a radar chart showing my principle scores: [your scores]"

3. **Generate a custom diagram:**
   > "Create a Mermaid sequence diagram showing how the hooks system works"

4. **Build a dashboard:**
   > "Create an HTML dashboard with 3 charts: principle scorecard (radar), alignment over time (line), and income sources (stacked bar)"

---

## Configuration Backup

**A backup of your config was created:**

`C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json.hermetic-backup-[timestamp]`

**If you need to restore:**
```bash
cp "$APPDATA/Claude/claude_desktop_config.json.hermetic-backup-*" "$APPDATA/Claude/claude_desktop_config.json"
```

---

## Summary

✅ **Installed:** 3 MCP diagram servers
✅ **Backed up:** Original config
✅ **Ready for:** Automated diagram generation through conversation
✅ **Supports:** Flowcharts, state diagrams, sequence diagrams, timelines, charts, dashboards
✅ **Output:** SVG, PNG, PDF, HTML
✅ **Themed:** Hermetic brand colors (Gold/Purple/Emerald)

**Next step:** Restart Claude Desktop to activate the servers.

---

*"Automation serves consciousness. Visual clarity serves understanding."*

*— Hermetic Principle of Vibration applied to tooling*
