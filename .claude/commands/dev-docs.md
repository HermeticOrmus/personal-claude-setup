---
description: Create comprehensive dev docs (plan + context + tasks) for large features
---

# Create Development Documentation

You're about to create a comprehensive **dev docs package** for tracking this task across multiple sessions.

This system embodies the **Hermetic Principle of Rhythm** - maintaining continuity across sessions through structured documentation.

---

## Your Task

### 1. Understand the Plan

**First**, carefully read the user's prompt or planning session to understand:
- What feature/task they're building
- The approved implementation approach
- Key phases and milestones
- Success criteria

**If no plan exists yet**: Stop and tell the user to run Planning Mode first, or provide more details about what they want to build.

---

### 2. Determine Task Name

Create a clear, kebab-case task name:
- Good: `user-authentication-system`
- Good: `email-notification-service`
- Bad: `new feature` (too vague)
- Bad: `fix_bug` (underscores, not descriptive)

**Include date if needed**: `2025-01-user-auth`

---

### 3. Determine Location

**Ask yourself**: Is this task part of a specific project in `~/projects/[project-name]`?

**If YES** (project-specific):
- Create in: `~/projects/[project-name]/dev/active/[task-name]/`
- Example: `~/projects/Midnight-Sun/dev/active/client-onboarding-flow/`

**If NO** (general/cross-project/learning):
- Create in: `~/dev/active/[task-name]/`
- Example: `~/dev/active/learn-rust-basics/`

---

### 4. Create the Three Files

You MUST create all three files:

#### File 1: `[task-name]-plan.md`

Use the **PLAN-TEMPLATE.md** structure from `~/dev/templates/`:

**Must include**:
- Executive summary (2-3 sentences)
- Detailed implementation plan broken into 2-5 phases
- Each phase with specific, numbered tasks
- Success criteria (measurable)
- Known risks and mitigations
- Dependencies
- Testing strategy

**Format**: Clear markdown with proper headings

---

#### File 2: `[task-name]-context.md`

Use the **CONTEXT-TEMPLATE.md** structure from `~/dev/templates/`:

**Uses Progressive Summarization (4 layers)**:
- **Layer 4 (Top)**: Executive Summary - 2-3 sentence essence, critical decision, current focus
- **Layer 3**: Critical Insights - Key patterns, gotchas, breakthroughs (highlighted)
- **Layer 2**: Important Details - Key files, decisions, patterns (with bolding)
- **Layer 1 (Bottom)**: Full Context - Complete detailed information

**Must include**:
- **Layer 4**: Essence in your own words, ONE critical decision, current + next focus
- **Layer 3**: 2-3 key patterns, 2-3 gotchas, major breakthroughs
- **Layer 2**: 3-5 key files with **bolded** critical behaviors, architecture decisions with **bolded** core choices
- **Layer 1**: Complete file details, comprehensive decisions, full patterns, all integration points
- **Last Updated** timestamp (current date/time)

**Purpose**: Progressive Summarization enables instant context recovery. Read Layer 4 (30 sec orientation), scan Layer 3 (critical reminders), skim Layer 2 (important items), reference Layer 1 (full detail).

**Principle**: "Each layer compresses the layer below it. Information flows from comprehensive (bottom) to essence (top)."

---

#### File 3: `[task-name]-tasks.md`

Use the **TASKS-TEMPLATE.md** structure from `~/dev/templates/`:

**Must include**:
- All tasks from the plan, organized by phase
- Checkbox format: `- [ ]` for incomplete, `- [x]` for complete
- Each task actionable and testable
- Final checks section (tests, review, docs)
- **Last Updated** timestamp

**Format**:
```markdown
## Phase 1: Database Schema

- [ ] Create User table with email, password_hash fields
- [ ] Add unique constraint on email column
- [ ] Create Session table for JWT refresh tokens
- [ ] Write Prisma migration

**Phase complete when**: All migrations run successfully
```

---

### 5. Verify Completeness

Before finishing, **verify**:
- ✅ All three files created in correct location
- ✅ Plan accurately reflects user's intent
- ✅ Context file has concrete file paths and patterns
- ✅ Tasks are specific and actionable (not vague)
- ✅ Timestamps are current
- ✅ Task name is clear and descriptive

---

### 6. Confirm with User

**Output to user**:
```
✅ Dev docs created successfully!

**Location**: ~/projects/[project]/dev/active/[task-name]/

**Files created**:
- [task-name]-plan.md (Executive summary + 3 phases)
- [task-name]-context.md (5 key files + patterns)
- [task-name]-tasks.md (12 tasks across 3 phases)

**Next steps**:
1. Review the plan to ensure accuracy
2. Mark first task as in-progress
3. Begin implementation
4. Update context/tasks as you work
5. Before compaction: Run /update-dev-docs

**Hermetic Principle: Rhythm**
"This structure enables sustainable development across multiple sessions."

Ready to begin! 🚀
```

---

## Important Guidelines

### ✅ DO:
- Be specific with file paths (actual paths, not placeholders)
- Break plan into 2-5 clear phases
- Make tasks actionable ("Create X" not "Think about X")
- Include concrete examples in context
- Use templates from `~/dev/templates/`
- Verify location (project vs general)

### ❌ DON'T:
- Use placeholder text like "[TODO]" or "[Fill in]"
- Create vague tasks ("Work on feature")
- Skip any of the three files
- Put files in wrong location
- Forget timestamps
- Make assumptions - ask if unclear

---

## Examples

### Good Task Names:
- `midnight-sun-whatsapp-automation`
- `floreser-content-migration`
- `learn-system-design-patterns`
- `refactor-n8n-workflows`

### Bad Task Names:
- `new_thing` (vague, underscores)
- `fix bug` (not descriptive)
- `update` (what are you updating?)

---

## Hermetic Principles Applied

**Mentalism**: Clear plan → Clear implementation
**Correspondence**: File structure mirrors mental model
**Rhythm**: Sustainable across sessions through preserved context
**Cause-Effect**: Track decisions and their consequences

---

**May your plans be clear. May your context be preserved. May your tasks be completed.**

**Now create the dev docs package and confirm completion with the user.**
