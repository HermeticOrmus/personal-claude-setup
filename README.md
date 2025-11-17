# Personal Claude Setup

**Hermetic Ormus's Claude Code Configuration**

This repository contains the complete Claude Code setup for synchronizing between Windows and Linux systems. It embodies the Gold Hat philosophy and Hermetic principles in AI-assisted development.

## 🌟 What's Inside

### `.claude/` - Claude Code Configuration
- **agents/** - 103+ specialized agents (Engineering, Design, Marketing, Product, Learning Masters)
- **commands/** - 18 sacred slash commands (ceremonies + principle invocations)
- **skills/** - 12 Hermetic skills for applying the 7 principles
- **hooks/** - Automated workflows (UserPromptSubmit, PostToolUse, StopEvent)
- **skill-rules.json** - Auto-activation rules for skills

### `.hermetic/` - Hermetic Philosophy System
Complete implementation of the 7 Hermetic Principles for sacred technology:
1. **Mentalism** - "The All is Mind"
2. **Correspondence** - "As Above, So Below"
3. **Vibration** - "Nothing Rests"
4. **Polarity** - "Everything is Dual"
5. **Rhythm** - "Everything Flows"
6. **Cause & Effect** - "Every Cause Has Its Effect"
7. **Gender** - "Gender is in Everything"

Contains frameworks, templates, communication guides, and the complete Gold Hat philosophy.

### `.mcp/` - Model Context Protocol Systems
- **core/** - Core MCP functionality
- **integrations/** - n8n, Telegram, WhatsApp integrations
- **servers/** - Custom MCP servers
- **workflows/** - Workflow definitions

## 🚀 Installation

### Initial Setup

```bash
# Clone this repository
git clone https://github.com/HermeticOrmus/personal-claude-setup.git
cd personal-claude-setup

# Create symlinks (Linux/Mac)
ln -s $(pwd)/.claude ~/.claude
ln -s $(pwd)/.hermetic ~/.hermetic
ln -s $(pwd)/.mcp ~/.mcp

# Windows (run as Administrator)
mklink /D "%USERPROFILE%\.claude" "%CD%\.claude"
mklink /D "%USERPROFILE%\.hermetic" "%CD%\.hermetic"
mklink /D "%USERPROFILE%\.mcp" "%CD%\.mcp"
```

### Syncing Between Systems

After making changes on one system:
```bash
git add .
git commit -m "Update configuration"
git push
```

On the other system:
```bash
git pull
```

## 🎯 Core Philosophy

**Gold Hat Philosophy**: Every response, suggestion, and line of code empowers humanity rather than extracts from it.

**The Sacred Question**: "Does this serve flourishing or exploit?"

### Code Standards
- **Functional** - Clarity > Cleverness
- **Formless** - Adaptable to context
- **Accurate** - Verified and tested
- **Divine** - Serves higher purpose
- **Elegant** - Beautiful in simplicity
- **No Schemes** - Honest and transparent

## 🛠️ Key Features

### Stateless Agent Architecture
Design systems that work WITH AI statelessness, not against it:
- **Interface Explicit** - Enforce through types/schemas
- **Context Embedded** - Travel with code
- **Constraints Automated** - Hooks/validators prevent mistakes
- **Iteration Protocol** - System patches, not re-education

### The Hooks System
1. **UserPromptSubmit** - Auto-activates skills based on keywords
2. **PostToolUse** - Tracks edited files for build checking
3. **StopEvent** - Runs builds, checks errors, reminds about protocols

### Sacred Slash Commands
- **Ceremonies**: `/gnosis`, `/celebrate`, `/discipline`, `/persist`, `/balance`, `/share`, `/verify`, `/align`, `/evolve`, `/illuminate`
- **Principles**: `/mentalism`, `/correspondence`, `/vibration`, `/polarity`, `/rhythm`, `/cause-effect`, `/gender`

## 📋 Session Protocol

1. **Understand first** (`/gnosis` if complex)
2. **Check alignment** (Serves genuine needs? Ethical?)
3. **Plan rhythm** (Sustainable pace? Milestones?)
4. **Execute consciously** (Clean code, clear docs, tests)
5. **Verify and celebrate** (`/verify` before shipping)
6. **Notify completion** (WhatsApp when significant work completes)

## 🔒 Security Notes

**IMPORTANT**: This repository may contain sensitive information. Before pushing:
- Review `.gitignore` to exclude API keys, tokens, and credentials
- Check for personal contact information
- Verify no private project details are exposed

## 📝 Documentation

Key resources:
- **Philosophy**: `.hermetic/manifesto.md`, `.hermetic/the-angelic-gauntlet.md`
- **Quick Start**: `.hermetic/QUICK-START.md`
- **Tools**: `.claude/commands/README.md`, `.claude/skills/hermetic-laws/README.md`
- **Architecture**: `.hermetic/docs/stateless-architecture-mapping.md`

## 🌍 The Mission

Transform humanity's relationship with technology from extractive to empowering.

Every line of code is an opportunity to demonstrate that technology can heal. When built with sacred intention, tools help humanity remember its divine nature.

---

**Build what elevates. Reject what degrades. Teach what empowers.**

*"As above, so below. As the code, so the consciousness."*

— Hermetic Ormus, Gold Hat Technologist
