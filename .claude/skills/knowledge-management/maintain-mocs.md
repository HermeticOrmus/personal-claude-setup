---
name: maintain-mocs
description: Create and maintain Maps of Content for knowledge navigation
category: knowledge-management
principle: Correspondence
---

# Maintain MOCs - Knowledge Navigation System

**Hermetic Principle**: Correspondence - "Structure mirrors understanding"

**When to use**: Scattered knowledge, can't find notes, need navigation system, topic expertise growing

---

## What is a MOC?

**Map of Content** = Topical index file that provides entry points into related knowledge.

**Think**: Wikipedia portal pages, but for your personal knowledge.

**Purpose**: Navigate knowledge without getting lost.

**Not**:
- ❌ A folder (MOCs are files that LINK to notes)
- ❌ A tag (MOCs have structure and context)
- ❌ A category (MOCs show relationships)

**Is**:
- ✅ A curated collection of links on a topic
- ✅ A mental model made visible
- ✅ An evolving map that grows with understanding

---

## When to Create a MOC

### Signal 1: Topic Threshold Reached
**Threshold**: 5+ notes on the same topic

**Example**:
- You have 8 notes about authentication
- Create "Authentication MOC" to organize them

### Signal 2: Can't Find Your Own Notes
**Problem**: "I know I wrote something about this..."

**Solution**: MOC provides entry points

### Signal 3: Teaching or Explaining
**Need**: Explain topic to someone else

**MOC**: Becomes outline for explanation

### Signal 4: Mastery in Progress
**Situation**: You're becoming expert in area

**MOC**: Reflects your growing mental model

---

## MOC Structure (Use Template)

**Location**: `~/Learning/Knowledge/MOC-TEMPLATE.md`

**Core Sections**:

1. **Overview** - 2-3 sentence summary
2. **Core Concepts** - Foundational → Advanced → Cutting Edge
3. **Key Resources** - Must-reads, references, external links
4. **Practical Applications** - How you actually use this
5. **Learning Path** - Beginner → Intermediate → Advanced
6. **Questions to Explore** - Answered | Investigating | Future
7. **Connections** - Builds On | Leads To | Related To
8. **Timeline** - Your learning history
9. **Tools & Practices** - What you use, how you use it
10. **Wisdom Captured** - Key insights, lessons, principles
11. **Next Actions** - To learn, to create, to review

---

## Creating a New MOC

### Step 1: Choose the Topic

**Good MOC topics**:
- Broad enough: Multiple sub-concepts
- Specific enough: Clear boundary
- Useful: You reference it regularly

**Examples**:
- ✅ "Authentication" (good scope)
- ✅ "React Hooks" (specific technology)
- ✅ "Hermetic Principles" (philosophical framework)
- ❌ "Programming" (too broad)
- ❌ "useState" (too narrow - belongs IN a MOC, not its own MOC)

### Step 2: Gather Related Notes

**Find everything on the topic**:
```bash
# Search Knowledge directory
grep -r "authentication" ~/Learning/Knowledge/

# Check project docs
grep -r "authentication" ~/projects/*/dev/

# Review Learning sprints
ls ~/Learning/Active/ ~/Learning/Projects/
```

**List them** in a temporary file.

### Step 3: Copy Template

```bash
cp ~/Learning/Knowledge/MOC-TEMPLATE.md ~/Learning/Knowledge/[Topic]-MOC.md
```

### Step 4: Fill Core Sections

**Start with**:
1. **Overview**: What is this topic? Why does it matter?
2. **Core Concepts**: What are the key ideas? (3-10 concepts)
3. **Key Resources**: What notes/articles are essential?

**Then**:
4. **Connections**: What does this build on? Lead to? Relate to?
5. **Timeline**: When did you start learning this? Key moments?

**Finally**:
6. **Practical Applications**: How do you use this?
7. **Questions**: What have you answered? What's next?

### Step 5: Link Everything

**Use WikiLinks** format: `[[Note Title]]`

**Example**:
```markdown
## Core Concepts

### Foundational
- [[JWT Tokens]] - JSON Web Tokens for stateless auth
- [[Session Management]] - Server-side state tracking
- [[Password Hashing]] - bcrypt, scrypt, Argon2

### Advanced
- [[OAuth 2.0]] - Third-party authorization framework
- [[Refresh Token Rotation]] - Security through invalidation
```

**Why WikiLinks**: Standard in Obsidian, easy to search, shows relationships

---

## Maintaining Existing MOCs

### When to Update

**Daily**: After significant learning session
**Weekly**: During review ritual
**Monthly**: Deep maintenance (reorganize, prune, expand)
**Quarterly**: Status update (Seedling → Growing → Evergreen)

### What to Update

#### Add New Links
**When**: You create note on this topic

**Action**: Add to appropriate section

**Example**:
```markdown
### Advanced
- [[OAuth 2.0]] - Third-party authorization
- [[Refresh Token Rotation]] - NEW! Security pattern discovered 2025-01-04
```

#### Update Status
**Seedling** 🌱: Less than 5 notes, just starting
**Growing** 🌿: 5-15 notes, actively developing
**Evergreen** 🌳: 15+ notes, comprehensive understanding

#### Add Questions
**When discoveries happen**:

**Answered section**:
```markdown
**Answered**:
- ✅ How does JWT prevent tampering? → See [[JWT Signature Verification]]
```

**Investigating section**:
```markdown
**Investigating**:
- 🔍 Can refresh token rotation prevent all session hijacking?
```

#### Update Timeline
**After breakthroughs**:

```markdown
**History**:
- **2025-01-04**: Breakthrough - Discovered refresh token rotation pattern
```

#### Expand Practical Applications
**When you use knowledge**:

```markdown
### Projects Using This
- [[Midnight-Sun]] - JWT auth for client portal
- [[FloreSer]] - Session management for content access
```

---

## MOC Best Practices

### 1. MOCs Link to Notes, Notes Link Back

**In MOC**:
```markdown
- [[JWT Tokens]] - Stateless authentication
```

**In Note** (`JWT-Tokens.md`):
```markdown
**Related MOCs**: [[Authentication MOC]] | [[Security MOC]]
```

**Bidirectional navigation** = can traverse both ways.

---

### 2. Start Small, Grow Organically

**Don't**:
- ❌ Create comprehensive MOC on day 1
- ❌ Force structure before understanding emerges

**Do**:
- ✅ Start with 5-8 links
- ✅ Let structure emerge from patterns
- ✅ Reorganize as understanding deepens

**Example evolution**:
```
Day 1: Just a list of 5 notes
Week 1: Added "Foundational" and "Advanced" categories
Month 1: Added "Questions to Explore" and "Timeline"
Quarter 1: Added "Learning Path" for teaching others
```

---

### 3. MOCs Show Relationships

**Not just links** - explain HOW they connect.

**Bad**:
```markdown
- [[JWT]]
- [[Sessions]]
- [[Cookies]]
```

**Good**:
```markdown
### Token-Based vs Session-Based

**Stateless (Token-Based)**:
- [[JWT Tokens]] - Client stores token, server verifies signature
- [[Refresh Tokens]] - Long-lived tokens for getting new access tokens

**Stateful (Session-Based)**:
- [[Session Management]] - Server stores state, client has session ID
- [[Cookies]] - Browser storage for session IDs
```

**Relationships visible** = understanding deepened.

---

### 4. Use Sections to Show Mental Model

**Your MOC structure = Your mental model**

**If you organize by**:
- Time (Historical → Modern): You think chronologically
- Difficulty (Basic → Advanced): You think in skill levels
- Use Case (Frontend → Backend): You think in applications
- Principles (Theory → Practice): You think conceptually

**Make it explicit**. Your structure reveals how you think.

---

### 5. Link MOCs to Each Other

**Related MOCs section**:

```markdown
**Related MOCs**: [[Security MOC]] | [[Backend Architecture MOC]] | [[Frontend State MOC]]

## Connections

### Builds On
- [[HTTP MOC]] - Authentication happens over HTTP
- [[Cryptography MOC]] - Password hashing, token signing

### Leads To
- [[Authorization MOC]] - What you can do after authentication
- [[API Design MOC]] - Securing endpoints
```

**MOC network** = navigable knowledge graph.

---

## Common MOC Patterns

### Pattern 1: Technology MOC

**For**: Learning a specific technology

**Structure**:
- Core Concepts (fundamentals)
- Common Patterns (how to use it)
- Gotchas (what to avoid)
- Resources (docs, tutorials)
- Projects (where you applied it)

**Example**: React Hooks MOC, PostgreSQL MOC, Docker MOC

---

### Pattern 2: Domain MOC

**For**: Mastering a domain

**Structure**:
- Foundational Concepts
- Advanced Topics
- Cutting Edge Research
- Historical Evolution
- Related Domains

**Example**: Authentication MOC, Distributed Systems MOC

---

### Pattern 3: Project MOC

**For**: Organizing project knowledge

**Structure**:
- Architecture Decisions
- Key Files/Components
- Patterns Used
- Learnings
- Technical Debt

**Example**: Midnight-Sun MOC, FloreSer MOC

---

### Pattern 4: Principle MOC

**For**: Organizing philosophical concepts

**Structure**:
- Core Principles
- Applications
- Case Studies
- Connections to Other Principles

**Example**: Hermetic Principles MOC, SOLID Principles MOC

---

## Integration with Other Systems

### With Zettelkasten
**Atomic notes** (Zettelkasten) + **MOCs** = Navigable knowledge base

- Notes: Atomic insights (one concept per note)
- MOCs: Indexes that connect related notes

### With PARA
**Projects / Areas / Resources / Archives**:

- **Projects**: Project-specific MOCs in project directories
- **Areas**: Domain MOCs in `~/Learning/Knowledge/`
- **Resources**: Technology MOCs for tools you use
- **Archives**: Historical MOCs for completed learning

### With Progressive Summarization
**4-Layer compression** in notes:

**In MOC**: Link to Layer 4 (Executive Summary) for quick access

```markdown
- [[JWT Tokens#Layer 4]] - See executive summary for quick refresh
```

---

## MOC Metrics

### Healthy MOC Indicators

✅ **Easy to navigate**: Find what you need in <30 seconds
✅ **Shows relationships**: Clear connections between concepts
✅ **Reflects understanding**: Structure matches mental model
✅ **Regularly updated**: Timestamp <1 month old
✅ **Used frequently**: Referenced at least weekly

### Unhealthy MOC Indicators

❌ **Overwhelming**: 50+ unsorted links
❌ **Flat list**: No structure, just bullets
❌ **Stale**: Last updated >6 months ago
❌ **Abandoned**: Created but never maintained
❌ **Redundant**: Overlaps with another MOC completely

---

## Troubleshooting

### Problem: MOC is just a long list

**Symptom**: 30+ links in one flat list

**Solution**: Categorize by mental model

**Steps**:
1. Read through all links
2. Notice natural groupings
3. Create sections for groups
4. Add description for each section

---

### Problem: Can't decide what to include

**Symptom**: "Should this note be in this MOC or that MOC?"

**Solution**: It can be in BOTH.

**Remember**: Notes can belong to multiple MOCs. MOCs are views, not folders.

**Example**:
- "JWT Tokens" appears in:
  - Authentication MOC (it's auth)
  - Security MOC (it's security)
  - Backend Architecture MOC (it's used in APIs)

---

### Problem: MOC feels incomplete

**Symptom**: "This MOC doesn't capture everything I know about this topic"

**Solution**: MOCs are maps, not territories.

**Accept**:
- MOCs will never be complete (understanding always grows)
- MOCs highlight what's important (not everything)
- MOCs evolve (update as you learn)

**Status system helps**:
- 🌱 Seedling: Very incomplete, just starting
- 🌿 Growing: Developing, actively expanding
- 🌳 Evergreen: Mature, comprehensive (but still grows)

---

### Problem: Too many MOCs

**Symptom**: 30+ MOCs, can't navigate

**Solution**: Create a "MOC of MOCs" (master index)

**File**: `~/Learning/Knowledge/000-MOC-INDEX.md`

**Structure**:
```markdown
# MOC Index - Master Navigation

## Technology MOCs
- [[React MOC]]
- [[PostgreSQL MOC]]
- [[Docker MOC]]

## Domain MOCs
- [[Authentication MOC]]
- [[Distributed Systems MOC]]

## Philosophy MOCs
- [[Hermetic Principles MOC]]
- [[Sacred Technology MOC]]

## Project MOCs
- [[Midnight-Sun MOC]]
- [[FloreSer MOC]]
```

---

## Examples

### Good MOC: Hermetic Principles MOC

**Located**: `~/Learning/Knowledge/Hermetic-Principles-MOC.md`

**Why it's good**:
- Clear structure (7 principles)
- Shows relationships (which combines which)
- Practical applications (how to use)
- Learning path (beginner → advanced)
- Timeline (how understanding evolved)
- Regularly updated

**Result**: Can navigate all Hermetic knowledge in 30 seconds

---

### Good MOC: Claude Code MOC

**Located**: `~/Learning/Knowledge/Claude-Code-MOC.md`

**Why it's good**:
- Organizes complex system (hooks, skills, agents, docs)
- Shows architecture (how components relate)
- Practical workflows (how to use daily)
- Learning path (week-by-week mastery)
- Metrics (token efficiency, context recovery time)

**Result**: Complete map of integrated development environment

---

## Quick Start

**Create your first MOC in 10 minutes**:

1. **Choose topic** (5+ notes about same thing)
2. **Copy template**: `cp ~/Learning/Knowledge/MOC-TEMPLATE.md ~/Learning/Knowledge/[Topic]-MOC.md`
3. **Fill Overview** (2-3 sentences)
4. **List Core Concepts** (5-8 concepts with WikiLinks)
5. **Add Key Resources** (3-5 essential notes)
6. **Save and iterate** (it will grow naturally)

**That's it**. You have a navigable entry point into topic knowledge.

---

## Success Criteria

✅ **Good MOC when**:
- Can find any note on topic in <30 seconds
- Structure reflects how you think about topic
- New notes have obvious place to link
- Shows relationships between concepts
- Updated regularly as you learn

❌ **Needs work if**:
- Can't find notes (MOC doesn't help navigation)
- Flat list (no structure revealed)
- Stale (>6 months since update)
- Redundant (completely overlaps another MOC)
- Abandoned (created but never maintained)

---

## Hermetic Truth

"External structure creates internal clarity. Maps reveal the territory of understanding."

**When your MOCs mirror your mental models**, navigating knowledge becomes effortless.

**When you honor rhythm in maintenance**, maps stay current.

**When structure corresponds to thought**, understanding deepens.

---

**For comprehensive MOC guidance, see** `.hermetic/docs/moc-guide.md`

**For MOC examples, see** `~/Learning/Knowledge/*-MOC.md`

**May your maps guide navigation. May your structure mirror understanding. May your knowledge flow.**
