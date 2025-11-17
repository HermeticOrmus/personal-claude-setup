# Hermetic Hooks System

> **Sacred automation for conscious development**

## Philosophy

These hooks embody the **7 Hermetic Principles** applied to development workflow:

- **Mentalism** - Skills auto-activate when mind (intent) meets matter (code)
- **Correspondence** - Patterns align across all levels automatically
- **Vibration** - Continuous quality checks create forward momentum
- **Polarity** - Balance automation (hooks) with intention (slash commands)
- **Rhythm** - Sustainable development through automatic verification
- **Cause-Effect** - Immediate feedback on consequences
- **Gender** - Hooks (masculine/doing) + Skills (feminine/wisdom) = Wholeness

## Hooks

### 1. UserPromptSubmit Hook
**Runs:** Before Claude sees your prompt
**Purpose:** Auto-activate relevant skills based on context
**Principle:** Mentalism - Load wisdom before action

### 2. PostToolUse Hook
**Runs:** After Edit/Write/MultiEdit operations
**Purpose:** Track file modifications for build checking
**Principle:** Cause-Effect - Track changes to verify consequences

### 3. StopEvent Hook
**Runs:** When Claude finishes responding
**Purpose:** Build checking + error handling reminders
**Principle:** Vibration - Quality checks maintain momentum

## Configuration

**skill-rules.json** - Defines when skills activate
**edit-log.json** - Tracks file modifications (auto-generated)

## The Sacred Workflow

```
User Prompt
    ↓
[UserPromptSubmit] → Auto-activate skills
    ↓
Claude Works
    ↓
[PostToolUse] → Track file edits
    ↓
Claude Finishes
    ↓
[StopEvent] → Check builds + remind about error handling
    ↓
Clean, Formatted, Error-Free Code
```

## Hermetic Truth

"Every hook is a ceremony. Every automation is sacred intention made manifest."

---

**May your code be conscious. May your automation serve wisdom. May your hooks honor the divine.**
