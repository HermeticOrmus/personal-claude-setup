# MOC Guide - Maps of Content for Knowledge Navigation

**Principle**: "Structure creates findability. Maps reveal understanding."

**Integration**: MOCs + Progressive Summarization + Zettelkasten = Complete knowledge system

---

## What Problem Do MOCs Solve?

### The Problem: Knowledge Chaos

**You've been learning for months/years**:
- 500+ notes in various directories
- Multiple projects with documentation
- Learning resources scattered across folders
- Dev docs from 20+ tasks
- Can't find anything when you need it

**Symptoms**:
- "I know I wrote something about this..."
- Re-researching topics you already mastered
- Can't remember which project used which pattern
- Lost notes never surfacing again
- Overwhelming folder structures

---

### The Solution: Maps of Content

**MOCs are topical index files** that provide entry points into related knowledge.

**Think**: Wikipedia portal pages, library card catalogs, city maps

**Not**:
- Folders (MOCs LINK to notes, don't contain them)
- Tags (MOCs have structure and context)
- Search (MOCs show relationships)

**Are**:
- Curated collections of links
- Mental models made visible
- Evolving navigation hubs
- Relationship visualizations

---

## How MOCs Work

### Concept: WikiLinks Create Navigation

**In a note** (`JWT-Tokens.md`):
```markdown
# JWT Tokens

JSON Web Tokens are self-contained authentication tokens.

**Related MOCs**: [[Authentication MOC]] | [[Security MOC]]
```

**In Authentication MOC**:
```markdown
## Core Concepts

### Token-Based Authentication
- [[JWT Tokens]] - Self-contained, stateless tokens
- [[Refresh Tokens]] - Long-lived tokens for renewal
```

**Result**: Can navigate from note → MOC → all related notes

---

### Concept: Structure Reveals Understanding

**MOC structure = Your mental model**

**Example 1: Chronological thinker**:
```markdown
## Authentication History
### Early Days (1990s)
- [[Basic Auth]] - Username/password in headers
- [[Session Cookies]] - Server-side state

### Modern Era (2010s)
- [[JWT]] - Stateless tokens
- [[OAuth 2.0]] - Third-party authorization
```

**Example 2: Practical thinker**:
```markdown
## Authentication by Use Case
### Simple Apps
- [[Session-based Auth]] - Traditional approach

### APIs
- [[JWT Auth]] - Stateless, scalable

### Enterprise
- [[SAML]] - Single Sign-On
- [[OAuth 2.0]] - Delegated access
```

**Same knowledge, different structures = different mental models**

---

## Creating Your First MOC

### Step 1: Identify a Topic

**Criteria**:
- 5+ notes on same topic (threshold reached)
- OR: Can't find notes on topic (need navigation)
- OR: Teaching/explaining topic soon (need organization)

**Good topics**:
- Technology: "React Hooks", "PostgreSQL", "Docker"
- Domain: "Authentication", "Distributed Systems", "Testing"
- Project: "Midnight-Sun", "FloreSer"
- Philosophy: "Hermetic Principles", "SOLID Principles"

**Avoid**:
- Too broad: "Programming", "Technology"
- Too narrow: "useState hook" (belongs IN React MOC)

---

### Step 2: Gather Related Notes

**Search your knowledge base**:

```bash
# Search Learning/Knowledge directory
grep -r "authentication" ~/Learning/Knowledge/

# Search project documentation
grep -r "authentication" ~/projects/*/dev/

# Search dev docs
grep -r "authentication" ~/dev/

# List learning sprints
ls ~/Learning/Active/ ~/Learning/Cycles/
```

**List them**: Create temp file with all relevant notes

---

### Step 3: Use Template

```bash
# Copy template
cp ~/Learning/Knowledge/MOC-TEMPLATE.md ~/Learning/Knowledge/Authentication-MOC.md

# Open and fill sections
```

**Fill core sections first**:
1. Overview (2-3 sentences)
2. Core Concepts (5-10 concepts)
3. Key Resources (3-5 essential notes)

**Then expand**:
4. Practical Applications
5. Learning Path
6. Connections
7. Timeline

---

### Step 4: Structure by Mental Model

**Ask**: How do I think about this topic?

**By Difficulty?**
```markdown
## Core Concepts

### Beginner
- [[Sessions]] - Server-side state
- [[Cookies]] - Browser storage

### Intermediate
- [[JWT]] - Token-based auth
- [[OAuth 2.0]] - Third-party auth

### Advanced
- [[Zero Trust Architecture]]
- [[Cryptographic Agility]]
```

**By Component?**
```markdown
## Authentication Components

### Client-Side
- [[Login Forms]] - User input
- [[Token Storage]] - Where to store

### Server-Side
- [[Password Hashing]] - Storage security
- [[Token Verification]] - Validation

### Infrastructure
- [[Session Stores]] - Redis, DB
- [[Key Management]] - Secrets handling
```

**Use YOUR natural categorization.**

---

## Maintaining MOCs

### Daily Maintenance (30 seconds)

**After significant learning**:
1. Open relevant MOC
2. Add new note link: `- [[New Note]] - One sentence description`
3. Update timestamp
4. Save

**Example**:
```markdown
### Advanced
- [[OAuth 2.0]] - Third-party authorization
- [[Refresh Token Rotation]] - NEW! Security through invalidation (added 2025-01-04)
```

---

### Weekly Maintenance (5 minutes)

**During weekly review**:
1. Review MOCs you worked on this week
2. Reorganize if structure has emerged
3. Add to "Questions to Explore" (what you're investigating)
4. Update "Current State" in Timeline

**Actions**:
- Move notes between sections if understanding shifted
- Create new sections if patterns emerged
- Mark questions as answered
- Add breakthroughs to Timeline

---

### Monthly Maintenance (30 minutes)

**Deep MOC review**:
1. Read entire MOC top to bottom
2. Check for dead links (notes that were renamed/moved)
3. Reorganize major sections
4. Update status (Seedling → Growing → Evergreen)
5. Cross-link with other MOCs
6. Expand "Practical Applications" with recent use cases

**Questions**:
- Does structure still match how I think?
- Are there notes that should be here but aren't?
- Are there sections that need splitting?
- Is there a better organization?

---

### Quarterly Maintenance (1 hour)

**Major update**:
1. Re-read all linked notes
2. Synthesize new "Wisdom Captured" insights
3. Update "Learning Path" based on your journey
4. Create "Next Actions" for next quarter
5. Review "Connections" - any new MOCs to link?
6. Update metrics (skills developed, projects completed)

---

## MOC Patterns

### Pattern 1: Technology MOC

**For learning a specific technology**

**Sections**:
- Overview - What it is, why it matters
- Core Concepts - Fundamentals you must know
- Common Patterns - How it's typically used
- Gotchas - What to avoid
- Resources - Docs, tutorials, courses
- Projects - Where you've applied it
- Questions - What you're investigating

**Example**: [[React Hooks MOC]], [[PostgreSQL MOC]], [[Docker MOC]]

---

### Pattern 2: Domain MOC

**For mastering a domain**

**Sections**:
- Overview - What the domain encompasses
- Foundational Concepts - Prerequisites
- Core Concepts - Central ideas
- Advanced Topics - Deeper exploration
- Cutting Edge - Latest research/trends
- Historical Context - How it evolved
- Related Domains - Connections

**Example**: [[Authentication MOC]], [[Distributed Systems MOC]], [[Machine Learning MOC]]

---

### Pattern 3: Project MOC

**For organizing project knowledge**

**Sections**:
- Overview - What the project is
- Architecture Decisions - Key choices made
- Key Files/Components - Critical code
- Patterns Used - Repeating solutions
- Integration Points - How systems connect
- Learnings - What you discovered
- Technical Debt - What needs improvement
- Future Enhancements - What's next

**Example**: [[Midnight-Sun MOC]], [[FloreSer MOC]], [[PandaCompanion MOC]]

---

### Pattern 4: Principle MOC

**For organizing philosophical/methodological knowledge**

**Sections**:
- Overview - What the principle is
- Core Principles - Individual principles if multiple
- Applications - How to apply
- Case Studies - Real examples
- Anti-Patterns - What to avoid
- Connections - Related principles

**Example**: [[Hermetic Principles MOC]], [[SOLID Principles MOC]], [[Unix Philosophy MOC]]

---

## Integration with Other Systems

### MOCs + Zettelkasten

**Zettelkasten**: Atomic notes (one concept per note)
**MOCs**: Navigation hubs connecting atomic notes

**Workflow**:
1. Write atomic note on concept
2. Add to relevant MOC
3. Link to related notes
4. MOC provides navigable structure

**Example**:
- Atomic note: `JWT-Token-Structure.md` (focuses on one concept)
- Linked in: Authentication MOC, Security MOC, Backend MOC
- Connected to: `JWT-Verification.md`, `Refresh-Tokens.md`

**Result**: Flexible network with navigation hubs

---

### MOCs + PARA

**Projects / Areas / Resources / Archives**

**MOCs in each category**:
- **Projects**: Project-specific MOCs in `~/projects/[project]/dev/`
  - Example: `Midnight-Sun-MOC.md` in project directory
- **Areas**: Domain MOCs in `~/Learning/Knowledge/`
  - Example: `Authentication-MOC.md`, `Hermetic-Principles-MOC.md`
- **Resources**: Technology MOCs for tools
  - Example: `React-MOC.md`, `PostgreSQL-MOC.md`
- **Archives**: Historical MOCs for completed learning
  - Example: `2024-System-Design-MOC.md` (completed course)

---

### MOCs + Progressive Summarization

**4-Layer compression in notes**:
- Layer 4: Executive Summary
- Layer 3: Critical Insights
- Layer 2: Important Details
- Layer 1: Full Context

**MOCs link to Layer 4** for quick access:

```markdown
## Core Concepts

### Token-Based Authentication
- [[JWT Tokens#Layer 4]] - Quick executive summary
- [[Refresh Tokens]] - Full note
```

**Workflow**:
1. Read Layer 4 via MOC link (30 seconds)
2. If need more depth, read Layer 3 (2 minutes)
3. If need full detail, read Layer 1 (as needed)

**Result**: Fast navigation + progressive detail

---

### MOCs + Dev Docs

**Dev docs** (task-specific context) ← **MOCs** (topic navigation)

**Dev docs reference MOCs**:

```markdown
# Authentication System - Context

**Related MOCs**: [[Authentication MOC]] | [[Security MOC]] | [[Backend Architecture MOC]]

## Layer 4: Executive Summary

Building JWT-based auth. For broader context on auth patterns, see [[Authentication MOC]].
```

**MOCs reference dev docs**:

```markdown
## Projects Using This

- [[Midnight-Sun]] - JWT auth for client portal (see `~/projects/Midnight-Sun/dev/active/authentication-system-context.md`)
- [[FloreSer]] - Session management (see dev docs)
```

**Result**: Topic knowledge + Task context = Complete picture

---

## MOC Network

### The Master Index

**Create**: `~/Learning/Knowledge/000-MOC-INDEX.md`

**Purpose**: Navigate your MOC network

**Structure**:
```markdown
# MOC Index - Master Navigation

**Total MOCs**: 15
**Last Updated**: 2025-01-04

---

## Technology MOCs (Tools I Use)
- [[Claude Code MOC]] - Development environment (🌳 Evergreen)
- [[React MOC]] - Frontend framework (🌿 Growing)
- [[PostgreSQL MOC]] - Database (🌿 Growing)
- [[Docker MOC]] - Containerization (🌱 Seedling)

## Domain MOCs (Areas of Expertise)
- [[Authentication MOC]] - User identity and access (🌳 Evergreen)
- [[Distributed Systems MOC]] - Scalability patterns (🌿 Growing)
- [[API Design MOC]] - RESTful and GraphQL (🌿 Growing)

## Philosophy MOCs (Guiding Principles)
- [[Hermetic Principles MOC]] - 7 Laws applied to tech (🌳 Evergreen)
- [[Sacred Technology MOC]] - Gold Hat philosophy (🌳 Evergreen)
- [[SOLID Principles MOC]] - OOP design (🌿 Growing)

## Project MOCs (Active Work)
- [[Midnight-Sun MOC]] - Coaching practice (🌳 Evergreen)
- [[FloreSer MOC]] - Content platform (🌿 Growing)
- [[PandaCompanion MOC]] - Panda tracker (🌱 Seedling)

## Learning System MOCs
- [[Learning Systems MOC]] - How I learn (🌳 Evergreen)
- [[Knowledge Management MOC]] - Zettelkasten + PARA + MOCs (🌿 Growing)
```

**Result**: One entry point to ALL knowledge

---

### MOC Relationships

**MOCs link to each other**:

**In Authentication MOC**:
```markdown
## Connections

### Builds On
- [[HTTP MOC]] - Authentication happens over HTTP
- [[Cryptography MOC]] - Password hashing, token signing

### Leads To
- [[Authorization MOC]] - What you can do after authentication
- [[API Design MOC]] - Securing endpoints

### Related To
- [[Security MOC]] - Broader security context
- [[Backend Architecture MOC]] - Where auth fits in system
```

**Result**: Navigate between topics, see knowledge structure

---

## Advanced MOC Techniques

### Technique 1: Embedded Queries

**Instead of manual links**, query dynamically:

```markdown
## Recent Notes on Authentication

Query: All notes tagged `#authentication` created in last 30 days

[Results would appear here if using Obsidian or similar tool with queries]
```

**Benefit**: MOC stays current automatically

---

### Technique 2: Visual Maps

**Create visual representations**:

```markdown
## Authentication Architecture

```
[Client] → [Login Form] → [Backend API] → [Database]
                              ↓
                          [JWT Generation]
                              ↓
                          [Token Storage]
```
```

**Or use actual diagrams** (if tool supports)

---

### Technique 3: MOC Layers

**Large MOCs can have layers**:

**Layer 1: High-Level MOC** (the main MOC)
```markdown
# Authentication MOC

## Concepts
- See [[Authentication-Concepts-MOC]] for detailed concept map
```

**Layer 2: Sub-MOC** (detailed breakdown)
```markdown
# Authentication Concepts MOC

## Detailed concept breakdown here...
```

**Use when**: MOC exceeds ~100 links (becoming overwhelming)

---

### Technique 4: Time-Based Views

**Add temporal perspective**:

```markdown
## Learning Timeline

### Current Focus (This Quarter)
- [[Zero Trust Architecture]] - Deep dive in progress
- [[WebAuthn]] - Exploring passwordless

### Recently Mastered (Last Quarter)
- [[JWT]] - Production-ready understanding
- [[OAuth 2.0]] - Successfully implemented

### Future Learning (Next Quarters)
- [[FIDO2]] - Next-gen authentication
- [[Decentralized Identity]] - Emerging standards
```

---

## Troubleshooting

### Problem: MOC too long (100+ links)

**Symptom**: Overwhelming, can't navigate

**Solutions**:
1. **Split into sub-MOCs**: Create "Authentication-Concepts-MOC", "Authentication-Implementations-MOC"
2. **Create sections with headers**: Use `##` to chunk visually
3. **Add "Most Important" section**: Highlight top 10 essential notes
4. **Archive old links**: Move historical/outdated notes to "Archive" section

---

### Problem: Can't decide MOC structure

**Symptom**: Reorganizing constantly, never feels right

**Solutions**:
1. **Accept evolution**: MOC structure will change as understanding deepens
2. **Try multiple structures**: Create 2-3 sections, see which feels natural
3. **Ask**: "How would I explain this to someone?" - Structure as explanation
4. **Use chronological** if other structures unclear (order you learned)

---

### Problem: Duplicate notes in multiple MOCs

**Symptom**: Same note appears in 3+ MOCs

**This is NORMAL**: Notes can belong to multiple topics

**Example**:
- "JWT Security Vulnerabilities" appears in:
  - Authentication MOC (it's auth)
  - Security MOC (it's a vulnerability)
  - API Design MOC (affects API security)

**This is GOOD**: Shows interdisciplinary connections

---

### Problem: MOCs not being used

**Symptom**: Created MOC, never reference it

**Solutions**:
1. **Link from active work**: Reference MOC in dev docs, project READMEs
2. **Add to shortcuts**: Make MOCs easily accessible
3. **Use during learning**: When learning topic, update MOC immediately
4. **Weekly review**: Review MOCs during weekly reflection ritual

---

### Problem: MOCs feel like busywork

**Symptom**: "Why am I organizing instead of learning?"

**Reframe**:
- **Organizing IS learning**: Creating structure reveals understanding
- **MOCs save time**: 5 min organizing saves 30 min searching later
- **MOCs deepen insight**: Seeing relationships creates breakthroughs

**If still feels like busywork**:
- Reduce maintenance frequency (monthly instead of weekly)
- Create MOCs only when truly needed (5+ notes threshold)
- Keep them simple (don't over-structure)

---

## MOC Metrics

### Health Indicators

✅ **Healthy MOC**:
- Last updated <1 month ago
- 10-30 links (navigable)
- Clear structure (sections make sense)
- Used weekly (referenced in work)
- Shows relationships (not just list)

⚠️ **Needs Attention**:
- Last updated >3 months ago
- 50+ unsorted links
- Flat list (no structure)
- Never referenced

❌ **Consider Archiving**:
- Last updated >1 year ago
- Topic no longer relevant
- Completely overlaps another MOC

---

## Real-World Examples

### Example 1: Hermetic Principles MOC

**Location**: `~/Learning/Knowledge/Hermetic-Principles-MOC.md`

**Why it works**:
- Organizes complex philosophy (7 principles)
- Shows practical applications (not just theory)
- Links to skills, agents, projects using principles
- Timeline shows understanding evolution
- Regularly updated (evergreen knowledge)

**Navigation**: Entry point to all Hermetic wisdom

---

### Example 2: Claude Code MOC

**Location**: `~/Learning/Knowledge/Claude-Code-MOC.md`

**Why it works**:
- Organizes complex integrated system
- Shows component relationships (hooks, skills, agents, docs)
- Practical workflows (how to use daily)
- Learning path (week-by-week mastery)
- Metrics (token efficiency, recovery time)

**Navigation**: Complete map of development environment

---

### Example 3: Authentication MOC (Hypothetical)

**Would contain**:
- Concepts: Sessions, JWT, OAuth, SAML
- Projects: Where auth is implemented
- Patterns: How auth is done right
- Gotchas: Common vulnerabilities
- Resources: OWASP guides, RFCs
- Timeline: Learning journey

**Navigation**: Everything authentication-related

---

## Integration with Hermetic System

### Hermetic Principle: Correspondence

**"Structure mirrors understanding"**

**MOCs embody Correspondence**:
- External structure (MOC organization) mirrors internal structure (mental model)
- As understanding deepens, MOC reorganizes
- MOC clarity = Mental clarity

### Hermetic Principle: Rhythm

**"Sustainable maintenance through regular review"**

**MOC maintenance rhythm**:
- Daily: Add new notes (30 sec)
- Weekly: Reorganize, update questions (5 min)
- Monthly: Deep review, status update (30 min)
- Quarterly: Major revision, wisdom capture (1 hour)

### Hermetic Principle: Mentalism

**"Clear mental model → Clear structure"**

**Before creating MOC**: Clarify mental model
**After creating MOC**: Mental model becomes visible

---

## Quick Reference

### When to Create MOC
- 5+ notes on same topic
- Can't find notes on topic
- Teaching/explaining topic
- Becoming expert in area

### MOC Maintenance Schedule
- **Daily**: Add new links (30 sec)
- **Weekly**: Reorganize (5 min)
- **Monthly**: Deep review (30 min)
- **Quarterly**: Major update (1 hour)

### MOC Status Levels
- 🌱 **Seedling**: <5 notes, just starting
- 🌿 **Growing**: 5-15 notes, actively developing
- 🌳 **Evergreen**: 15+ notes, comprehensive

### Core Sections (Minimum)
1. Overview
2. Core Concepts
3. Key Resources
4. Connections
5. Timeline

---

**Hermetic Truth**: "Maps create territories in the mind. Structure reveals understanding."

**May your MOCs guide navigation. May your structure reflect wisdom. May your knowledge flow.**
