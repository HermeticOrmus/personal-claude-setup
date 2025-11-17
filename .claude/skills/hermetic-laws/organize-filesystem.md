---
name: organize-filesystem
description: Sacred file organization applying Hermetic principles
category: utility
principle: Correspondence
---

# Organize Filesystem - Sacred File Organization

**Hermetic Principle**: Correspondence - "Physical structure mirrors mental clarity"

**When to use**: Messy directories, cluttered projects folder, can't find files, need systematic organization

**Agent**: Use `/filesystem-organizer` agent for comprehensive reorganization

---

## Quick Philosophy

**Your filesystem is sacred space**. Clutter creates mental fog. Organization creates clarity.

**Bad organization** → Wasted time, lost files, cognitive overhead
**Good organization** → Flow, ease, clarity, productivity

---

## The Hermetic Approach

### 1. Mentalism - Structure Reflects Intention

**Before organizing, ask**:
- How do I actually work?
- What do I access daily vs monthly?
- What are my natural categories?

**Structure should match your mental model**, not some generic "best practice"

### 2. Correspondence - As Above, So Below

**High level** (your workflow):
- I work on multiple projects simultaneously
- I have active vs archived work
- I learn new skills regularly

**Low level** (directory structure):
```
projects/
├── active/          # Mirrors "current work"
├── archived/        # Mirrors "completed work"
└── learning/        # Mirrors "skill development"
```

**Perfect correspondence** = Zero friction finding files

### 3. Rhythm - Sustainable Maintenance

**Organization is not one-time**. It's a rhythm:
- Daily: Quick triage of new files
- Weekly: Review active projects
- Monthly: Archive completed work
- Quarterly: Deep clean

**Create systems that maintain themselves** through regular rhythms.

### 4. Polarity - Balance Structure vs Flexibility

**Too rigid** → Can't handle edge cases, feels constraining
**Too loose** → Becomes messy again quickly

**Balance**:
- Clear main categories (structure)
- Flexible subcategories (adaptability)
- "Inbox" folder for triage (pressure release)

---

## Quick Organization Patterns

### Pattern 1: By Status (GTD-style)

```
~/work/
├── inbox/           # Unsorted, new
├── active/          # Current projects
├── completed/       # Done this quarter
└── archive/         # Long-term storage
```

**Best for**: Task-oriented workflows

### Pattern 2: By Project (Developer-style)

```
~/projects/
├── Midnight-Sun/    # Each project self-contained
├── PandaCompanion/
├── FloreSer/
└── learning/
    ├── rust-tutorials/
    └── system-design/
```

**Best for**: Project-based work

### Pattern 3: Hybrid (Most Flexible)

```
~/work/
├── active-projects/
│   ├── client-work/
│   └── personal/
├── learning/
│   ├── active/
│   └── completed/
└── archive/
    └── 2024/
```

**Best for**: Mixed workflows

---

## File Organization Rules

### Rule 1: One Logical Home

**Every file should have ONE obvious place** it belongs.

**Bad**: Could go in "documents" or "work" or "projects"
**Good**: Obviously goes in "active-projects/midnight-sun/docs"

### Rule 2: Depth Limit

**No more than 3-4 levels deep**. Beyond that, cognitive load increases.

**Bad**: `work/projects/active/2025/january/midnight-sun/backend/services/auth/utils/helper.ts`
**Good**: `projects/midnight-sun/backend/auth/utils/helper.ts`

### Rule 3: Descriptive Names

**Names should reveal purpose immediately**.

**Bad**: `new-folder`, `stuff`, `misc`, `temp2`
**Good**: `client-deliverables`, `active-learning`, `2024-archived-projects`

### Rule 4: Consistency

**Use consistent patterns** throughout your system.

**If you use**:
- kebab-case for project names → Use it everywhere
- Date prefixes (2025-project) → Use it for all dated items
- Status folders (active/archived) → Apply pattern consistently

---

## Quick Triage System

**For the "Downloads" folder** (applies to any inbox):

```bash
# Every week, sort downloads:
~/Downloads/
├── to-keep/         # Move to permanent location
├── to-review/       # Need to read/evaluate
├── installers/      # Software installers (can delete after install)
└── archive/         # Might need later
```

**Process**:
1. Move keepers to permanent homes
2. Review the to-review items
3. Delete used installers
4. Clean archive >90 days old

---

## The Sacred Deletion

**Deleting is not wasteful - it's liberating**.

**Delete**:
- Duplicates (find with `fdupes` or `md5sum`)
- Old downloads (installers from 6 months ago)
- Incomplete projects you'll never finish
- "Just in case" files you've never opened

**Archive** (don't delete):
- Completed projects (reference/learning)
- Important documents
- Work you're proud of

**Rule**: If you haven't opened it in 6 months and can't imagine needing it → Delete

---

## Project-Specific: Organizing ~/projects

**Current state** (from your system):
```
~/projects/ (28 directories, many inactive)
```

**Recommended structure**:
```
~/projects/
├── active/          # < 5 current projects
│   ├── Midnight-Sun/
│   ├── PandaCompanion/
│   └── FloreSer/
├── learning/
│   ├── current/     # Active learning
│   └── completed/   # Finished tutorials
├── client-work/
│   ├── active/
│   └── delivered/
├── experiments/     # Quick tests, prototypes
└── archive/
    ├── 2024/
    └── 2023/
```

**Migration**:
1. Identify active projects (git activity <30 days)
2. Identify archived projects (no activity >3 months)
3. Identify learning projects (tutorials, courses)
4. Identify client work
5. Move to appropriate categories
6. Delete obvious duplicates/abandoned work

**Agent**: Run `/filesystem-organizer ~/projects` for comprehensive plan

---

## Documentation is Key

**Always create** `_ORGANIZATION.md` in organized directories:

```markdown
# Directory Organization

**Last organized**: 2025-01-04
**Structure**: Hybrid (status + project)

## Directory Purpose

### `/active`
Current, active work. Move here when starting work.
Archive when complete or inactive >90 days.

### `/archive/YYYY`
Completed or inactive projects, organized by year.
Keep for reference and learning.

### `/learning`
Tutorials, courses, skill development.
Move from `learning/current` → `learning/completed` when done.

## Maintenance

**Weekly**: Review active, archive completed
**Monthly**: Clean experiments, verify archive
**Quarterly**: Deep clean, update this doc
```

---

## Integration with Other Skills

**Combine with**:
- `/apply-classification` - Create taxonomy of file types
- `/apply-mentalism` - Clarify mental model before organizing
- `/apply-rhythm` - Set up maintenance schedule

**Workflow**:
```bash
1. /apply-mentalism "How do I actually work with files?"
   → Clarify mental model

2. /filesystem-organizer ~/projects
   → Get comprehensive reorganization plan

3. /apply-rhythm "File maintenance schedule"
   → Set up sustainable maintenance

4. /apply-classification "Project types"
   → Create clear categories
```

---

## Quick Start

**For immediate organization**:

```bash
# 1. Create inbox for triage
mkdir -p ~/inbox

# 2. Move obvious categories
mkdir -p ~/projects/{active,archive,learning}

# 3. Quick triage (30 min)
# - 5 most important projects → active/
# - Old projects → archive/
# - Tutorials → learning/

# 4. Document
# - Create _ORGANIZATION.md
# - Set calendar reminder for weekly review
```

---

## Success Criteria

✅ **Good organization when**:
- Can find any file in <30 seconds
- New files have obvious home
- No "misc" or "stuff" folders
- Structure matches your workflow
- Maintenance is effortless rhythm
- Feel calm, not overwhelmed

❌ **Needs work if**:
- Searching for files regularly
- "I know it's here somewhere..."
- Multiple copies of same file
- Folders within folders within folders
- Haven't opened folder in months
- Anxiety about finding things

---

## Hermetic Truth

"External order creates internal clarity. Sacred space serves sacred work."

**When your filesystem mirrors your mental clarity**, finding files becomes effortless.

**When your structure reflects your workflow**, productivity flows.

**When you honor rhythm in maintenance**, order sustains itself.

---

**For comprehensive reorganization, use the `/filesystem-organizer` agent.**

**For quick daily maintenance, follow the triage system above.**

**May your files find their sacred home. May your structure serve your flow.**
