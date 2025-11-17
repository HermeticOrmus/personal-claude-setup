# Creating Professional Hermetic System Diagrams via MCP

> Generate stunning visualizations using Model Context Protocol servers

---

## Available MCP Servers for Diagrams

### 🎯 Recommended: Multi-Format Diagram Servers

#### **1. UML-MCP Server** (Best for Hermetic System Map)

**What it does:** Universal diagram generation supporting multiple formats
**Supports:** Mermaid, PlantUML, D2, Graphviz, ERD, BlockDiag, BPMN, C4
**Why it's perfect:** Can generate the same diagram in multiple formats, letting you choose best output

**Installation:**
```json
// Add to ~/.config/claude-code/config.json or Claude Desktop config
{
  "mcpServers": {
    "uml-mcp": {
      "command": "npx",
      "args": ["-y", "@antoinebou12/uml-mcp"]
    }
  }
}
```

**Use for:**
- System architecture diagrams
- Decision flow charts
- Hierarchical structures
- Process workflows

---

#### **2. Diagram Bridge MCP** (Most Versatile)

**What it does:** Intelligent format selection + complete rendering via Kroki
**Supports:** Mermaid, PlantUML, D2, Graphviz, ERD, and more
**Special feature:** Auto-selects best diagram format for your needs

**Installation:**
```json
{
  "mcpServers": {
    "diagram-bridge": {
      "command": "npx",
      "args": ["-y", "@tohachan/diagram-bridge-mcp"]
    }
  }
}
```

**Use for:**
- When you're not sure which format to use
- Rapid prototyping of different diagram styles
- Complex technical diagrams

---

#### **3. mcp-kroki** (Maximum Format Support)

**What it does:** Converts diagrams to SVG, PNG, PDF, or JPEG via Kroki.io
**Supports:** 20+ diagram types through Kroki API
**Output formats:** SVG, PNG, PDF, JPEG

**Installation:**
```json
{
  "mcpServers": {
    "kroki": {
      "command": "npx",
      "args": ["-y", "@tkoba1974/mcp-kroki"]
    }
  }
}
```

**Use for:**
- High-quality print diagrams (PDF)
- Web graphics (SVG)
- Presentations (PNG/JPEG)

---

### 📊 For Metrics & Data Visualization

#### **4. AntV MCP Server Chart** (Best for Dashboards)

**What it does:** 25+ chart types for data visualization
**Supports:** Area, bar, box plots, column, violin, word clouds, scatter, line, pie, etc.
**Output:** Interactive HTML visualizations

**Installation:**
```json
{
  "mcpServers": {
    "antv-charts": {
      "command": "npx",
      "args": ["-y", "@antv/mcp-server-chart"]
    }
  }
}
```

**Use for:**
- Retrospective metrics dashboard
- Alignment score tracking over time
- Economic tier progression visualization
- Principle scorecard radar charts

---

#### **5. Plotly MCP Server** (Interactive Visualizations)

**What it does:** 49+ trace types, interactive HTML charts
**Supports:** All major chart types, 3D plots, statistical charts
**Output:** Interactive HTML with zoom, pan, hover tooltips

**Installation:**
```bash
# Requires Python 3.10+
pip install plotly-mcp-server

# Then add to config:
{
  "mcpServers": {
    "plotly": {
      "command": "python",
      "args": ["-m", "plotly_mcp_server"]
    }
  }
}
```

**Use for:**
- Interactive exploration of metrics
- Complex statistical visualizations
- Time-series data (learning progress, economic runway)

---

### 🎨 For Mermaid Diagrams Specifically

#### **6. hustcc/mcp-mermaid** (Feature-Complete Mermaid)

**What it does:** Full Mermaid.js support with theming
**Supports:** All Mermaid syntax + custom themes
**Output:** Base64, SVG, Mermaid source, file export

**Installation:**
```json
{
  "mcpServers": {
    "mermaid": {
      "command": "npx",
      "args": ["-y", "@hustcc/mcp-mermaid"]
    }
  }
}
```

**Use for:**
- When you specifically want Mermaid syntax
- Custom brand theming (Gold/Purple/Emerald)
- Flowcharts, sequence diagrams, state diagrams

---

#### **7. Sailor (aj-geddes)** (Best Developer Experience)

**What it does:** Beautiful web interface + MCP server for Mermaid
**Supports:** All Mermaid diagram types
**Special feature:** Live preview in browser with auto-reload

**Installation:**
```bash
git clone https://github.com/aj-geddes/sailor
cd sailor
npm install
npm start

# Then configure MCP connection
```

**Use for:**
- Interactive diagram creation
- Real-time preview while developing
- Best for iterative design

---

## Recommended Setup for Hermetic Framework

### Install These 3 MCP Servers:

**1. UML-MCP** (primary diagramming)
**2. AntV Charts** (metrics/dashboards)
**3. mcp-mermaid** (when you want Mermaid specifically)

**Installation script:**
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
    "mermaid": {
      "command": "npx",
      "args": ["-y", "@hustcc/mcp-mermaid"]
    }
  }
}
```

---

## Diagram Types for Hermetic System

### 1. System Overview (Bird's Eye View)

**Best format:** Mermaid Flowchart or D2
**MCP server:** UML-MCP or mcp-mermaid
**Shows:** Complete system hierarchy

**Example request:**
> "Create a Mermaid flowchart showing the Hermetic system: Core Question at top, flowing to 7 Principles, then to Tools (Commands/Skills/Agents), then to Outputs (DevDocs/Code/Projects), then to Feedback (Retrospectives)"

---

### 2. Decision Flow Chart

**Best format:** Mermaid Flowchart
**MCP server:** mcp-mermaid
**Shows:** Decision logic from task receipt to shipping

**Example request:**
> "Create a Mermaid flowchart for the Hermetic decision flow: Start with 'New Task' → Check if understood → Run /gnosis if not → Check if empowers users → Run /align if uncertain → Build with principles → Verify → Ship → Celebrate"

---

### 3. Principle → Tool → Outcome Map

**Best format:** PlantUML or D2
**MCP server:** UML-MCP
**Shows:** Which principles connect to which tools and outcomes

**Example request:**
> "Create a PlantUML component diagram mapping: Mentalism principle → /gnosis command + apply-mentalism skill + strategic-plan agent → Clear intention outcome. Do this for all 7 principles."

---

### 4. Entry Points by Use Case

**Best format:** Mermaid Graph
**MCP server:** mcp-mermaid
**Shows:** Different starting points based on user situation

**Example request:**
> "Create a Mermaid graph showing entry points: 'New Project' → /gnosis → strategic-plan → /dev-docs. 'Ethical Dilemma' → /align → CONFLICT-RESOLUTION.md. 'Burnout' → STOP → Rhythm principle → Retrospective. Etc."

---

### 5. Economic Hierarchy Progression

**Best format:** Mermaid State Diagram
**MCP server:** mcp-mermaid
**Shows:** 4-tier progression from Survival to Mission Alignment

**Example request:**
> "Create a Mermaid state diagram showing economic progression: Tier 1 Survival (pay rent) → Tier 2 Stability (3-6mo runway) → Tier 3 Selectivity (can decline dark patterns) → Tier 4 Mission Alignment (fully aligned work). Show transitions between states."

---

### 6. Metrics Dashboard

**Best format:** AntV Charts (multiple chart types)
**MCP server:** antv-charts
**Shows:** Principle scores, alignment over time, economic progress

**Example request:**
> "Create a radar chart showing 7 Hermetic Principles scored 1-10. Then create a line chart showing alignment score over 12 months. Then create a stacked bar chart showing income sources weighted by alignment."

---

### 7. Hooks System Flow

**Best format:** Mermaid Sequence Diagram
**MCP server:** mcp-mermaid
**Shows:** How the 3 hooks interact during a Claude session

**Example request:**
> "Create a Mermaid sequence diagram: User submits prompt → UserPromptSubmit hook analyzes → Skills auto-activate → Claude responds → PostToolUse hook tracks edits → StopEvent hook runs builds → Shows results to user"

---

### 8. Progressive Mastery Path

**Best format:** Mermaid Timeline or Gantt
**MCP server:** mcp-mermaid
**Shows:** Month 1 → Year 2+ progression

**Example request:**
> "Create a Mermaid timeline showing mastery path: Month 1 (Essentials), Months 2-3 (Tools), Months 4-6 (Integration), Months 7-12 (Mastery), Year 2+ (Leadership). Show what's learned in each phase."

---

## Brand-Aligned Theming

### Hermetic Color Palette

**For Mermaid diagrams, set custom theme:**

```javascript
%%{init: {
  'theme': 'base',
  'themeVariables': {
    'primaryColor': '#FFD700',       // Gold - Core principles
    'primaryTextColor': '#000',
    'primaryBorderColor': '#B8860B', // Dark gold
    'secondaryColor': '#4B0082',     // Deep Purple - Tools
    'tertiaryColor': '#50C878',      // Emerald - Outcomes
    'background': '#1a1a1a',         // Slate gray background
    'mainBkg': '#2d2d2d',
    'secondBkg': '#3d3d3d',
    'lineColor': '#708090',
    'textColor': '#E0E0E0',
    'fontSize': '16px',
    'fontFamily': 'Inter, system-ui, sans-serif'
  }
}}%%
```

---

## Complete Example: Generate System Map

**Request to Claude with UML-MCP installed:**

> "Using the UML-MCP server, create a comprehensive Hermetic system map diagram:
>
> Format: Mermaid flowchart (top-to-bottom)
> Theme: Use Hermetic colors (Gold #FFD700 for principles, Purple #4B0082 for tools, Emerald #50C878 for outcomes)
>
> Structure:
> 1. Top: 'Gold Hat Core Question: Empower or Extract?'
> 2. Second level: 7 Hermetic Principles (Mentalism, Correspondence, Vibration, Polarity, Rhythm, Cause-Effect, Gender)
> 3. Third level: Three boxes - Commands (18 total), Skills (12 total), Agents (103 total)
> 4. Fourth level: Outputs - Dev Docs, Code, Projects
> 5. Fifth level: Feedback - Retrospectives (Weekly/Monthly/Quarterly)
> 6. Side box: Anti-Patterns (Dark patterns, Surveillance, Manipulation)
>
> Add decision paths with arrows. Use subgraphs to group related items.
>
> Export as both SVG (for web) and PNG (for presentations)."

---

## Workflow for Creating Diagrams

### Option 1: AI-Generated (Fastest)

1. **Install MCP server** (one-time setup)
2. **Describe what you want** to Claude in natural language
3. **Claude generates diagram code** (Mermaid/PlantUML/etc.)
4. **MCP server renders** to SVG/PNG/PDF
5. **Save to** `.hermetic/diagrams/`

**Time:** 2-5 minutes per diagram

---

### Option 2: Iterative Refinement

1. **Start with AI generation** (as above)
2. **Preview in browser** (if using Sailor)
3. **Ask for modifications**: "Make the principle boxes bigger", "Add a legend", "Change color scheme"
4. **Iterate until perfect**
5. **Export final version**

**Time:** 10-20 minutes per diagram

---

### Option 3: Hand-Code Then Render

1. **Write diagram code manually** (if you know Mermaid/PlantUML)
2. **Use MCP to render** high-quality output
3. **Validate syntax** (using mermaid-validator MCP if needed)

**Time:** 15-30 minutes per diagram

---

## Output Formats & Uses

| Format | Best For | MCP Server |
|--------|----------|------------|
| **SVG** | Website, scaling without quality loss | mcp-kroki, mcp-mermaid |
| **PNG** | Presentations, documentation | All servers |
| **PDF** | Print, professional docs | mcp-kroki |
| **JPEG** | Email, low file size | mcp-kroki |
| **HTML** | Interactive dashboards | antv-charts, plotly |
| **Base64** | Embedding in markdown | mcp-mermaid |

---

## Recommended Diagram Set for Hermetic Framework

### Essential 5 Diagrams:

**1. System Overview**
- Format: Mermaid flowchart
- Shows: Complete system architecture
- File: `.hermetic/diagrams/system-overview.svg`

**2. Decision Flow**
- Format: Mermaid flowchart
- Shows: From task to shipping
- File: `.hermetic/diagrams/decision-flow.svg`

**3. Entry Points Map**
- Format: Mermaid graph
- Shows: Where to start based on situation
- File: `.hermetic/diagrams/entry-points.svg`

**4. Principle Scorecard**
- Format: AntV radar chart
- Shows: Current alignment on 7 principles
- File: `.hermetic/diagrams/principle-scorecard.html`

**5. Economic Progression**
- Format: Mermaid state diagram
- Shows: 4-tier journey
- File: `.hermetic/diagrams/economic-tiers.svg`

---

### Advanced 5 Diagrams:

**6. Tools × Principles Matrix**
- Format: PlantUML component diagram
- Shows: Which tool serves which principle
- File: `.hermetic/diagrams/tools-principles-matrix.svg`

**7. Hooks System Sequence**
- Format: Mermaid sequence diagram
- Shows: How hooks create continuous quality
- File: `.hermetic/diagrams/hooks-flow.svg`

**8. Alignment Over Time**
- Format: AntV line chart
- Shows: Historical alignment scores
- File: `.hermetic/diagrams/alignment-trend.html`

**9. Learning Mastery Path**
- Format: Mermaid timeline
- Shows: Progressive journey Month 1 → Year 2+
- File: `.hermetic/diagrams/mastery-timeline.svg`

**10. Conflict Resolution Tree**
- Format: Mermaid graph
- Shows: How to navigate 5 common conflicts
- File: `.hermetic/diagrams/conflict-resolution.svg`

---

## Installation Quick Start

**1. Choose your MCP client:**
- Claude Desktop
- VSCode with Continue
- Cursor
- Cline

**2. Add to config file:**

**For Claude Desktop:**
`~/.config/claude-code/config.json` (Linux/Mac)
`%APPDATA%\Claude\config.json` (Windows)

**For VSCode Continue:**
`~/.continue/config.json`

**3. Restart your client**

**4. Test it:**
> "Using the mcp-mermaid server, create a simple flowchart: Start → Process → End"

**5. If it works, you're ready!**

---

## Troubleshooting

**"MCP server not found"**
- Restart Claude Desktop/VSCode
- Check config.json syntax (valid JSON)
- Try: `npx -y @hustcc/mcp-mermaid` in terminal to verify it installs

**"Diagram render failed"**
- Syntax error in diagram code
- Use mermaid-validator MCP to check
- Try simpler diagram first

**"Permission denied"**
- Check file paths in config
- Run with appropriate permissions
- On Windows: May need to allow npx in firewall

**"Image quality is poor"**
- Use SVG instead of PNG for scalability
- Increase DPI if using PNG: request "high-resolution PNG, 300 DPI"
- Try PDF for print quality

---

## Next Steps

**1. Install essential 3 MCP servers** (UML-MCP, AntV, mcp-mermaid)

**2. Generate System Overview diagram**
- Ask Claude to create it
- Review and iterate
- Save to `.hermetic/diagrams/`

**3. Create metrics dashboard template**
- Use AntV charts
- Track principle scores
- Visualize economic progression

**4. Add diagrams to documentation**
- Reference from SYSTEM-MAP.md
- Embed in README.md
- Use in presentations

**5. Iterate and improve**
- Get feedback
- Refine visuals
- Update as framework evolves

---

## Visual Standards

**File naming:**
```
.hermetic/diagrams/
├── system-overview.svg
├── decision-flow.svg
├── entry-points.svg
├── economic-tiers.svg
├── hooks-sequence.svg
├── principle-scorecard.html
└── alignment-trend.html
```

**Diagram headers:**
Every diagram should include:
- Title (clear, descriptive)
- Date generated
- Version (if applicable)
- "Hermetic Consciousness Framework" branding

**Accessibility:**
- High contrast colors
- Clear labels
- Alt text for web usage
- Print-friendly versions

---

## The MCP Advantage

**Why use MCP servers instead of manual design tools?**

✅ **AI-Generated** - Describe what you want, Claude creates it
✅ **Version Control** - Diagrams are code, track in git
✅ **Consistency** - Same style across all diagrams
✅ **Updateable** - Change one line of code, update diagram
✅ **Multiple Formats** - Export to SVG, PNG, PDF, HTML from same source
✅ **Brand Aligned** - Custom themes match Hermetic colors
✅ **Fast** - Generate in seconds, not hours
✅ **Integrated** - Works directly in your development environment

**Traditional design tools** (Figma, Adobe) are great for one-off designs.
**MCP diagram servers** are perfect for living documentation that evolves.

---

*"The map illuminates the territory. Visual clarity serves understanding."*

*— Applied Correspondence: Documentation structure mirrors consciousness structure*
