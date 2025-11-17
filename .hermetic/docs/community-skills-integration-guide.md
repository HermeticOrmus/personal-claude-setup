# Community Skills Integration Guide

**Date**: 2025-11-09
**System**: Claude Code + Community Skills + MCP Integration
**Status**: Production Ready

---

## Overview

Your Claude Code environment has been upgraded with community-built skills and MCP servers that dramatically enhance capabilities for knowledge management, content creation, and automation.

## Installed Components

### 1. Skill Seekers MCP Server ⚡

**Location**: `~/projects/08-DEVELOPMENT/Skill_Seekers/`
**MCP Config**: `~/.config/claude-code/mcp.json`
**Status**: ✅ Configured and ready

**What It Does:**
Automatically converts documentation websites, GitHub repositories, and PDFs into Claude Skills.

**Available MCP Tools** (9 total):
- `mcp__skill-seeker__list_configs` - List preset configurations
- `mcp__skill-seeker__generate_config` - Create new config files
- `mcp__skill-seeker__validate_config` - Validate configurations
- `mcp__skill-seeker__estimate_pages` - Estimate scraping time
- `mcp__skill-seeker__scrape_docs` - Scrape and build skills
- `mcp__skill-seeker__package_skill` - Create .zip files
- `mcp__skill-seeker__upload_skill` - Upload to Claude
- `mcp__skill-seeker__split_config` - Handle large documentation
- `mcp__skill-seeker__generate_router` - Create router/hub skills

**Key Use Cases:**

1. **Learning System Integration**
   - Learning new framework? Generate skill from docs
   - Example: "Generate config for FastAPI at https://fastapi.tiangolo.com/"
   - Skill becomes permanent knowledge base

2. **Hermetic Philosophy Skill**
   - Generate skill from `~/.hermetic/` directory
   - Make your philosophy queryable across sessions
   - **Stateless Architecture** principle realized

3. **Client Work**
   - Client has internal framework? Generate skill from their docs
   - One-time generation, permanent knowledge

**First Test:**
```
In Claude Code, ask: "List all available configs"
You should see 24 preset configurations
```

---

### 2. Tapestry - Knowledge Graph Builder 🕸️

**Location**: `~/.config/claude-code/skills/tapestry/`
**Repo**: michalparkola/tapestry-skills-for-claude-code

**What It Does:**
Interlinks and summarizes related documents into navigable knowledge networks.

**Use Cases:**

1. **Hermetic Content Organization**
   ```
   Point Tapestry at: ~/projects/07-CONTENT-KNOWLEDGE/Hermetica-Content/
   Result: Interconnected web of your manifestos, guides, principles
   ```

2. **Learning Resources**
   ```
   Target: ~/Learning/Resources/
   Result: Navigate complex relationships between concepts
   ```

3. **Client Documentation**
   ```
   Project handoffs, specs, API docs → living knowledge graph
   ```

**Hermetic Principle**: *Correspondence* - "Patterns repeat across abstraction levels"

Tapestry makes static files into flowing knowledge (Vibration principle).

---

### 3. Invoice Organizer - Financial Order 💰

**Location**: `~/.config/claude-code/skills/invoice-organizer/`
**Repo**: ComposioHQ/awesome-claude-skills

**What It Does:**
Automatically organizes invoices and receipts for tax preparation.

**Target Directory**: `~/projects/03-BUSINESS-VENTURES/revenue/`

**Use Cases:**
- Quarterly tax prep
- Expense tracking
- Receipt categorization
- Real Estate financial docs
- Blue-Zone business docs

**Hermetic Principle**: *Rhythm* - "Sustainable financial tracking, not annual chaos"

---

### 4. File Organizer - General Organization 📁

**Location**: `~/.config/claude-code/skills/file-organizer/`
**Repo**: ComposioHQ/awesome-claude-skills

**What It Does:**
Intelligently organizes files and folders across your computer.

**Philosophy Alignment:**
> "Filesystem organization = Consciousness organization"

When files are messy, mental clarity suffers. This is Ormus's consciousness container.

**Use Cases:**
- Downloads folder cleanup
- Project directory organization
- Learning materials structuring
- Client files categorization

---

### 5. Content Research Writer - Coaching Content ✍️

**Location**: `~/.config/claude-code/skills/content-research-writer/`
**Repo**: ComposioHQ/awesome-claude-skills

**What It Does:**
Assists in writing high-quality content by conducting research, adding citations, improving hooks, and providing real-time feedback.

**Use Cases:**

1. **Midnight Sun Content**
   ```
   Target: ~/projects/01-ACTIVE/Midnight-Sun/content/
   Features: Citations, evidence-based writing, quality iteration
   ```

2. **Hermetic Manifestos**
   ```
   Research-backed philosophy
   Proper attribution
   Academic rigor
   ```

**Style Alignment**: Genuine, grounded, evidence-based (your communication principles)

**Hermetic Principle**: *Mentalism* - "Clarity of thought expressed through researched writing"

---

## Directory Structure After Installation

```
~/.config/claude-code/
├── mcp.json                          # MCP server configuration
└── skills/                           # Community skills
    ├── tapestry/
    │   └── SKILL.md
    ├── invoice-organizer/
    │   └── SKILL.md
    ├── file-organizer/
    │   └── SKILL.md
    └── content-research-writer/
        └── SKILL.md

~/projects/08-DEVELOPMENT/
├── Skill_Seekers/                    # MCP source
│   ├── venv/                         # Python virtual environment
│   ├── skill_seeker_mcp/
│   │   └── server.py
│   ├── cli/
│   ├── configs/                      # 24 preset configurations
│   └── requirements.txt
├── tapestry-skills-for-claude-code/  # Source repo
├── composio-awesome-claude-skills/   # Source repo
├── awesome-claude-skills/            # BehiSecc catalog
├── awesome-claude-skills-travisvn/   # Travis catalog
├── superpowers/                      # obra's toolkit
└── awesome-claude-code/              # Hooks repo
```

---

## Quick Start Workflows

### Workflow 1: Generate Hermetic Philosophy Skill

```bash
# In Claude Code, ask:
"Generate a skill from my Hermetic philosophy directory at C:\Users\ormus\.hermetic\"

# Or using MCP directly:
"Generate config for my Hermetic content"
"Scrape docs using the generated config"
"Package and upload the skill"

# Result: Permanent, queryable Hermetic knowledge base
```

### Workflow 2: Create Knowledge Graph

```bash
# In Claude Code:
"Use Tapestry to create a knowledge graph from ~/projects/07-CONTENT-KNOWLEDGE/Hermetica-Content/"

# Result: Interconnected map of your philosophical writings
```

### Workflow 3: Organize Finances

```bash
# In Claude Code:
"Use invoice organizer to organize receipts in ~/projects/03-BUSINESS-VENTURES/revenue/"

# Result: Categorized, tax-ready financial documents
```

### Workflow 4: Research-Backed Content

```bash
# In Claude Code:
"Use content-research-writer to help me write about [topic] for Midnight Sun"

# Features active:
- Research citations
- Hook improvement
- Section feedback
- Quality iteration
```

---

## Integration with Existing Hermetic System

### Your Current System

```
Philosophy:       .hermetic/ (20+ subdirectories)
Enforcement:      .claude/hooks/ (UserPromptSubmit, PostToolUse, StopEvent)
Workflows:        .claude/commands/ (18 slash commands)
Skills:           .claude/skills/hermetic-laws/ (12 Hermetic skills)
Agents:           .claude/agents/ (103 specialized agents)
```

### New Additions

```
Knowledge:        Skill Seekers (docs → skills)
Mapping:          Tapestry (files → knowledge graphs)
Organization:     File/Invoice Organizers
Content:          Research Writer
```

### The Complete Stack

```
┌─────────────────────────────────────┐
│     Hermetic Principles (WHY)       │  ← Philosophy
├─────────────────────────────────────┤
│     Hooks (ENFORCEMENT)             │  ← Automatic validation
├─────────────────────────────────────┤
│     Skills (WORKFLOW)               │  ← Reusable patterns
├─────────────────────────────────────┤
│     Skill Seekers (KNOWLEDGE)       │  ← Docs → Skills
├─────────────────────────────────────┤
│     Tapestry (NAVIGATION)           │  ← Files → Graphs
├─────────────────────────────────────┤
│     Agents (SPECIALIZED)            │  ← Domain expertise
└─────────────────────────────────────┘
```

Each layer mirrors and reinforces the others (Correspondence principle).

---

## Stateless Architecture Perfected

**Before**: Philosophy + Enforcement
**After**: Philosophy + Enforcement + Knowledge Integration

**The Missing Piece**: Making existing knowledge instantly accessible.

You had:
- Hermetic principles (philosophy)
- Hooks (enforcement)
- **But no way to make existing knowledge travel with Claude**

**Skill Seekers + Tapestry solve this.**

Now `.hermetic/`, `Learning/`, and `Hermetica-Content/` become **living knowledge**.

**Stateless Architecture Realized:**
- **Interface Explicit** (skills define structure)
- **Context Embedded** (knowledge in skills, not external)
- **Constraints Automated** (hooks enforce usage)
- **Iteration Protocol** (update skills, not re-teach Claude)

---

## Maintenance & Updates

### Keep Skills Updated

```bash
# Update source repositories
cd ~/projects/08-DEVELOPMENT/Skill_Seekers/
git pull

cd ~/projects/08-DEVELOPMENT/tapestry-skills-for-claude-code/
git pull

cd ~/projects/08-DEVELOPMENT/composio-awesome-claude-skills/
git pull

# Reinstall skills if changed
cp -r ~/projects/08-DEVELOPMENT/tapestry-skills-for-claude-code/tapestry ~/.config/claude-code/skills/
# Repeat for other skills if needed
```

### Update Skill Seekers Dependencies

```bash
cd ~/projects/08-DEVELOPMENT/Skill_Seekers/
source venv/Scripts/activate
pip install --upgrade -r requirements.txt
```

### Check MCP Server Status

```bash
# Test MCP server manually
cd ~/projects/08-DEVELOPMENT/Skill_Seekers/
source venv/Scripts/activate
python3 skill_seeker_mcp/server.py

# Should start without errors (Ctrl+C to stop)
```

---

## Troubleshooting

### MCP Server Not Appearing

1. **Restart Claude Code completely** (quit application, don't just close window)
2. Verify `~/.config/claude-code/mcp.json` exists and has correct paths
3. Test server manually: `python3 ~/projects/08-DEVELOPMENT/Skill_Seekers/skill_seeker_mcp/server.py`

### Skills Not Loading

1. Verify skills are in `~/.config/claude-code/skills/`
2. Each skill must have `SKILL.md` file
3. Restart Claude Code
4. Check skill format matches Claude's specification

### Path Issues (Windows)

- MCP config uses Windows paths: `C:\\Users\\ormus\\...`
- Git Bash uses Unix paths: `/c/Users/ormus/...`
- Both are valid, context-dependent

---

## Next Steps

### Immediate Actions (Day 1)

1. **Restart Claude Code** to load new skills and MCP server
2. **Test MCP**: Ask "List all available configs"
3. **Test Tapestry**: Create knowledge graph from small directory
4. **Test Invoice Organizer**: Organize small batch of receipts

### Week 1 Goals

1. **Generate Hermetic Skill**
   - Point Skill Seekers at `.hermetic/`
   - Test complex philosophical queries
   - Document what works/doesn't

2. **Create Content Knowledge Graph**
   - Use Tapestry on `Hermetica-Content/`
   - Navigate philosophical relationships
   - Test cross-reference queries

3. **Organize Q4 Finances**
   - Invoice organizer on `03-BUSINESS-VENTURES/revenue/`
   - Set up sustainable workflow
   - Prepare for tax season

### Integration Projects

1. **Skill Seekers + Learning System**
   - Generate skills for active learning topics
   - Example: Godot, FastAPI, whatever you're studying
   - Skills persist across sessions

2. **Tapestry + MCP Memory**
   - Create knowledge graph
   - Feed into MCP memory tools
   - Test cross-session recall

3. **Content Writer + Midnight Sun**
   - Research-backed coaching content
   - Citations and evidence
   - Quality iteration workflow

---

## Resources

### Documentation

- **Skill Seekers**: `~/projects/08-DEVELOPMENT/Skill_Seekers/README.md`
- **Tapestry**: `~/projects/08-DEVELOPMENT/tapestry-skills-for-claude-code/README.md`
- **This Guide**: `~/.hermetic/docs/community-skills-integration-guide.md`

### GitHub Repositories

- Skill Seekers: https://github.com/yusufkaraaslan/Skill_Seekers
- Tapestry: https://github.com/michalparkola/tapestry-skills-for-claude-code
- ComposioHQ Skills: https://github.com/ComposioHQ/awesome-claude-skills
- BehiSecc Catalog: https://github.com/BehiSecc/awesome-claude-skills

### Support

- Check GitHub Issues for each repo
- Reddit: r/ClaudeAI
- Community: https://github.com/anthropics/skills

---

## Hermetic Reflection

**The Upgrade's Deeper Meaning:**

This isn't just about installing tools. It's about externalizing and structuring consciousness.

- **Skill Seekers** = Converting external knowledge into integrated understanding
- **Tapestry** = Revealing hidden connections (Correspondence)
- **Organizers** = Physical structure mirroring mental clarity
- **Research Writer** = Elevating expression through evidence

**From Mentalism principle:**
> "Before writing code, clarify intention."

These tools clarify knowledge, organize consciousness, and preserve wisdom.

**From Vibration principle:**
> "Nothing rests; everything moves."

Static files become flowing knowledge. Isolated documents become interconnected wisdom.

**From Correspondence principle:**
> "As above, so below."

Digital organization mirrors mental clarity. Knowledge structure reflects thought architecture.

---

**Last Updated**: 2025-11-09
**Status**: Ready for use
**Next Review**: After Week 1 testing

*"As above, so below. As the files, so the consciousness."*

— Hermetic Ormus, Gold Hat Technologist
