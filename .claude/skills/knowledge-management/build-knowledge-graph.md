---
name: build-knowledge-graph
description: Build and maintain structured knowledge graph using Memory MCP
category: knowledge-management
principle: Correspondence
---

# Build Knowledge Graph - Structured Knowledge Representation

**Hermetic Principle**: Correspondence - "As the structure, so the understanding"

**When to use**: Capturing knowledge from dev work, connecting concepts, making knowledge discoverable

---

## Quick Concept

**Problem**: 500+ notes, can't find connections

**Solution**: Knowledge graph - entities (concepts) + relations (how they connect)

**Result**: Navigable knowledge web instead of isolated notes

---

## The Memory MCP Tools

**Create**:
- `mcp__memory__create_entities` - Add new concepts
- `mcp__memory__create_relations` - Connect concepts
- `mcp__memory__add_observations` - Add insights to concepts

**Read**:
- `mcp__memory__read_graph` - View entire graph
- `mcp__memory__search_nodes` - Find by keyword
- `mcp__memory__open_nodes` - Get specific entity details

---

## Quick Start (5 Minutes)

### Step 1: Create Your First Entity

**Example**: Adding JWT Authentication concept

```bash
# In Claude Code, invoke MCP tool:
mcp__memory__create_entities({
  entities: [{
    name: "JWT Authentication",
    entityType: "Concept",
    observations: [
      "JSON Web Token - stateless authentication using signed tokens",
      "Contains header, payload, signature (RS256 or HS256)",
      "Enables authentication without server-side session storage"
    ]
  }]
})
```

**Result**: Entity created in knowledge graph

---

### Step 2: Create a Related Entity

```bash
mcp__memory__create_entities({
  entities: [{
    name: "Session-based Auth",
    entityType: "Concept",
    observations: [
      "Traditional authentication using server-side sessions",
      "Session ID stored in cookie, session data on server",
      "Stateful - requires session storage (memory, Redis, database)"
    ]
  }]
})
```

---

### Step 3: Connect Them

```bash
mcp__memory__create_relations({
  relations: [{
    from: "JWT Authentication",
    to: "Session-based Auth",
    relationType: "alternative-to"
  }]
})
```

**Result**: Two concepts connected - graph shows they're alternatives

---

### Step 4: Search Your Graph

```bash
mcp__memory__search_nodes({
  query: "authentication"
})

# Returns both entities (they mention "authentication")
```

**Result**: Knowledge now discoverable!

---

## Common Workflows

### Workflow 1: Extract from Dev Docs Layer 3

**Trigger**: During `/update-dev-docs` before compaction

**Process**:

**1. Review Layer 3** for new insights:

```markdown
## ⚡ Layer 3: Critical Insights

### 🎯 Key Patterns
- **Token Refresh Rotation**: Rotate refresh tokens on each use to prevent replay attacks

### 💎 Breakthroughs
- **PostgreSQL JSONB**: Gives MongoDB-like flexibility with relational guarantees

### ⚠️ Gotchas
- **bcrypt cost factor**: Higher cost = secure but slower (sweet spot: cost 12)
```

**2. Extract to Knowledge Graph**:

```bash
# Create pattern entity
mcp__memory__create_entities({
  entities: [{
    name: "Token Refresh Rotation Pattern",
    entityType: "Pattern",
    observations: [
      "Rotate refresh tokens on each use to prevent replay attacks",
      "Invalidate old refresh token immediately after issuing new one",
      "Provides revocation capability for stateless JWT systems",
      "Discovered: Sprint 14, implementing auth system"
    ]
  }]
})

# Connect to JWT
mcp__memory__create_relations({
  relations: [{
    from: "Token Refresh Rotation Pattern",
    to: "JWT Authentication",
    relationType: "enhances"
  }]
})
```

**3. Continue for breakthroughs and gotchas**

**Result**: Dev docs insights permanently captured in graph

---

### Workflow 2: From Sprint Integration

**Trigger**: During Sprint Integration Ritual (Saturday PM)

**Process**:

**1. Review extracted patterns**:

```markdown
## Sprint Integration - Sprint 14

### Pattern Extraction

**Technical patterns**:
- Async work consistently takes 2x estimates

**Energy patterns**:
- Wednesday meetings kill Thursday productivity
```

**2. Create pattern entities**:

```bash
mcp__memory__create_entities({
  entities: [
    {
      name: "Async Work 2x Rule",
      entityType: "Pattern",
      observations: [
        "Async work (promises, async/await) takes 2x longer than estimates",
        "Validated across Sprints 10-14",
        "Reason: Error handling, race conditions, testing complexity",
        "Mitigation: Multiply async estimates by 2 automatically"
      ]
    },
    {
      name: "Meeting Impact on Flow",
      entityType: "Gotcha",
      observations: [
        "Meetings before deep work destroy productivity",
        "Even 30-min meeting kills flow for 2+ hours",
        "Wed meetings → Thu low productivity (pattern observed)",
        "Solution: Batch meetings Tuesday PM, protect Wed-Thu"
      ]
    }
  ]
})
```

**3. Connect to projects and related concepts**:

```bash
mcp__memory__create_relations({
  relations: [
    {
      from: "Midnight-Sun Project",
      to: "Async Work 2x Rule",
      relationType: "discovered"
    },
    {
      from: "Meeting Impact on Flow",
      to: "Cognitive Load Management",
      relationType: "relates-to"
    }
  ]
})
```

**Result**: Sprint wisdom captured structurally

---

### Workflow 3: From ADRs (Architecture Decisions)

**Trigger**: After creating ADR from extended thinking session

**Process**:

**1. Extract decision from ADR**:

```markdown
# ADR-015: PostgreSQL vs MongoDB

**Decision**: PostgreSQL
**Reasoning**: Social graph queries relational, team SQL expertise, JSONB provides flexibility
```

**2. Create decision entity**:

```bash
mcp__memory__create_entities({
  entities: [{
    name: "ADR-015 Database Choice",
    entityType: "Decision",
    observations: [
      "Context: Social network database for 100K users Year 1",
      "Decision: PostgreSQL over MongoDB",
      "Key insight: 'Flexibility' is marketing - needed query flexibility (SQL), not schema flexibility (NoSQL)",
      "Outcome: Correct - scaled well, team productive",
      "Extended thinking prevented: Would have chosen MongoDB for 'future flexibility' and regretted it"
    ]
  }]
})
```

**3. Connect to technologies and project**:

```bash
mcp__memory__create_relations({
  relations: [
    {
      from: "ADR-015 Database Choice",
      to: "PostgreSQL",
      relationType: "chose"
    },
    {
      from: "ADR-015 Database Choice",
      to: "MongoDB",
      relationType: "rejected"
    },
    {
      from: "Midnight-Sun Project",
      to: "ADR-015 Database Choice",
      relationType: "made"
    }
  ]
})
```

**Result**: Architectural decisions documented and connected

---

## Entity Types & When to Use

### Concept

**Use for**: Technical concepts, methodologies, theories

**Examples**:
- "JWT Authentication"
- "RESTful API"
- "Event-Driven Architecture"
- "Microservices"

---

### Technology

**Use for**: Specific tools, frameworks, languages

**Examples**:
- "PostgreSQL"
- "React"
- "Docker"
- "Next.js"

---

### Pattern

**Use for**: Recurring solutions, design patterns, best practices

**Examples**:
- "Token Refresh Rotation Pattern"
- "Repository Pattern"
- "Circuit Breaker"
- "Async Work 2x Rule"

---

### Gotcha

**Use for**: Common mistakes, pitfalls, things to avoid

**Examples**:
- "JWT Revocation Problem"
- "Meeting Impact on Flow"
- "bcrypt Cost Factor Balance"

---

### Project

**Use for**: Your projects (to connect what you've learned to where you learned it)

**Examples**:
- "Midnight-Sun"
- "Learning System"
- "Portfolio Site"

---

### Decision

**Use for**: Architectural decisions, major choices

**Examples**:
- "ADR-015 Database Choice"
- "ADR-002 Auth Strategy"

---

## Relation Types & When to Use

### requires

**Use when**: X needs Y to function

**Example**: "JWT Authentication" --requires--> "Signature Verification"

---

### uses

**Use when**: X employs Y

**Example**: "Midnight-Sun" --uses--> "PostgreSQL"

---

### implements

**Use when**: X is a specific implementation of Y

**Example**: "JWT" --implements--> "Token-based Authentication"

---

### alternative-to

**Use when**: X and Y solve same problem differently

**Example**: "JWT Authentication" --alternative-to--> "Session-based Auth"

---

### solves / prevents

**Use when**: X addresses problem Y

**Example**: "Token Refresh Rotation" --solves--> "JWT Revocation Problem"

---

### builds-on / prerequisite-for

**Use for**: Learning progression

**Example**: "HTTP Basics" --prerequisite-for--> "JWT Authentication"

---

## Maintenance Workflows

### Weekly Knowledge Graph Review (Friday, 10 min)

**Checklist**:

```markdown
## Knowledge Graph Weekly Review - Week [N]

### Entities Added This Week
- [ ] Review: Do they have clear observations?
- [ ] Review: Are they connected (not orphaned)?

### Check for Orphaned Entities
```bash
mcp__memory__read_graph()
# Look for entities with no relations
# Add at least one relation to each
```

### Merge Duplicates
- [ ] "JWT Auth" and "JWT Authentication" → Merge to "JWT Authentication"
- [ ] Use `mcp__memory__delete_entities` for duplicate

### Add Missing Relations
- [ ] Found: "PostgreSQL" should connect to "JSONB"
- [ ] Action: `mcp__memory__create_relations`
```

---

### Monthly Knowledge Graph Audit (30 min)

**Process**:

**1. Identify stale entities** (not accessed 2+ months):

```bash
mcp__memory__read_graph()
# Review entity list
# Archive entities no longer relevant
```

**2. Consolidate related entities**:

If you have many similar entities, create higher-level parent:

```bash
# Instead of:
- "JWT Auth Problem 1"
- "JWT Auth Problem 2"
- "JWT Auth Problem 3"

# Create parent:
mcp__memory__create_entities({
  entities: [{
    name: "JWT Authentication Challenges",
    entityType: "Concept",
    observations: ["Collection of common JWT implementation challenges"]
  }]
})

# Connect children to parent:
mcp__memory__create_relations({
  relations: [
    { from: "JWT Auth Problem 1", to: "JWT Authentication Challenges", relationType: "part-of" },
    { from: "JWT Auth Problem 2", to: "JWT Authentication Challenges", relationType: "part-of" },
    { from: "JWT Auth Problem 3", to: "JWT Authentication Challenges", relationType: "part-of" }
  ]
})
```

**3. Validate relations still accurate**:

```bash
# Check: "Midnight-Sun uses MongoDB"
# Reality: Migrated to PostgreSQL
# Action: Delete old relation, create new one

mcp__memory__delete_relations({
  relations: [{ from: "Midnight-Sun", to: "MongoDB", relationType: "uses" }]
})

mcp__memory__create_relations({
  relations: [{ from: "Midnight-Sun", to: "PostgreSQL", relationType: "uses" }]
})
```

---

## Integration with Other Systems

### Generate MOC from Knowledge Graph

**Workflow**:

**1. Search graph for topic**:

```bash
mcp__memory__search_nodes({ query: "authentication" })

# Returns all auth-related entities
```

**2. Create MOC from results**:

```markdown
# Authentication MOC

**Generated from Knowledge Graph** (2024-12-15)

## Core Concepts
- [[JWT Authentication]] (modern approach)
- [[Session-based Auth]] (traditional approach)
- [[OAuth 2.0]] (delegated authorization)

## Patterns
- [[Token Refresh Rotation Pattern]] (solves revocation)

## Gotchas
- [[JWT Revocation Problem]] (stateless = hard to revoke)

## Technologies
- [[Auth0]] (managed service)
- [[Passport.js]] (Node.js middleware)

## Decisions
- [[ADR-002 Auth Strategy]] (chose JWT)

## Projects Using
- [[Midnight-Sun]] (uses JWT)
```

**Benefit**: MOC auto-updates when graph grows

---

### Extract Anki Cards from Graph

**Workflow**:

**1. Find entities with important observations**:

```bash
mcp__memory__open_nodes({ names: ["JWT Authentication"] })

# Review observations
# Identify ones worth long-term memory
```

**2. Create Anki cards**:

```
Card:
  Q: Why can't JWT tokens be revoked before expiration?
  A: JWTs are stateless - server doesn't track issued tokens. To revoke, need additional state (token blacklist or refresh token rotation pattern).

  Source: [[JWT Authentication]] (Knowledge Graph entity)
```

**Benefit**: Spaced repetition keeps knowledge active, graph provides context

---

## Troubleshooting

### Issue: Too many orphaned entities

**Problem**: Entities with no relations (isolated)

**Fix**: Weekly review, add at least one relation to each entity

```bash
# Every entity should connect to SOMETHING
# If truly isolated, might not be worth keeping
```

---

### Issue: Duplicate entities

**Problem**: "JWT Auth" and "JWT Authentication" created separately

**Fix**: Monthly audit, merge duplicates

```bash
# Keep one (usually more descriptive name)
# Add observations from duplicate to keeper
# Delete duplicate

mcp__memory__add_observations({
  observations: [{
    entityName: "JWT Authentication",
    contents: [/* observations from "JWT Auth" */]
  }]
})

mcp__memory__delete_entities({
  entityNames: ["JWT Auth"]
})
```

---

### Issue: Graph too large, hard to navigate

**Problem**: 500+ entities, overwhelming

**Fix**: Create hierarchical structure with parent entities

```bash
# Group related entities under parents
# Example: All JWT-related under "JWT Authentication"

mcp__memory__create_relations({
  relations: [
    { from: "JWT Signing", to: "JWT Authentication", relationType: "part-of" },
    { from: "JWT Claims", to: "JWT Authentication", relationType: "part-of" },
    { from: "JWT Expiration", to: "JWT Authentication", relationType: "part-of" }
  ]
})
```

**Benefit**: Navigate by topic, not overwhelmed by detail

---

## Success Metrics

### You're using Knowledge Graph well when:

**Qualitative**:
- ✅ Can answer "What connects to X?" instantly
- ✅ Discovering knowledge you forgot
- ✅ Team can navigate your knowledge
- ✅ Less "I know I learned this somewhere..."
- ✅ Patterns emerging from graph structure

**Quantitative**:
- ✅ Entities: 100+ after 3 months
- ✅ Relations: 2-3x entity count (well-connected)
- ✅ Orphaned entities: <5%
- ✅ Search success: >90% find what you need

---

## Quick Reference

### Create Entity

```bash
mcp__memory__create_entities({
  entities: [{
    name: "[Entity Name]",
    entityType: "[Concept/Technology/Pattern/Gotcha/Project/Decision]",
    observations: [
      "[Observation 1]",
      "[Observation 2]"
    ]
  }]
})
```

### Create Relation

```bash
mcp__memory__create_relations({
  relations: [{
    from: "[Entity A]",
    to: "[Entity B]",
    relationType: "[requires/uses/implements/alternative-to/solves/etc]"
  }]
})
```

### Search

```bash
mcp__memory__search_nodes({ query: "[keyword]" })
```

### View Entity

```bash
mcp__memory__open_nodes({ names: ["[Entity Name]"] })
```

### View All

```bash
mcp__memory__read_graph()
```

---

### Common Entity Types

- **Concept**: Technical concepts
- **Technology**: Tools/frameworks
- **Pattern**: Recurring solutions
- **Gotcha**: Mistakes/pitfalls
- **Project**: Your projects
- **Decision**: Architecture decisions

### Common Relation Types

- **requires**, **uses**, **implements**
- **alternative-to**, **solves**, **prevents**
- **builds-on**, **prerequisite-for**
- **part-of**, **relates-to**

---

**For complete guide, see**: `.hermetic/docs/knowledge-graph-foundation.md`

**May your knowledge be connected. May your insights be discoverable. May your wisdom grow.**
