# Knowledge Graph Foundation - Structured Knowledge Representation

**Principle**: "From scattered notes to interconnected wisdom"

**What is a knowledge graph**: Structured representation of entities (concepts) and relations (how they connect)

**Why use it**: Transform isolated notes into navigable knowledge web

---

## The Problem: Knowledge Silos

### Scattered Knowledge (Before Knowledge Graph)

**You have**:
- 500+ markdown notes
- 30+ dev docs files
- 12 MOCs
- 200 Anki cards
- Code comments
- ADRs
- Sprint integration notes

**Problem**:
```
Note: "JWT Authentication"
→ Isolated file

Note: "Security Best Practices"
→ Different file

Note: "HIPAA Compliance"
→ Yet another file

Connection between JWT + Security + HIPAA?
→ EXISTS IN YOUR HEAD ONLY
→ Lost when you forget
→ Impossible for teammates to discover
```

**Result**: Knowledge exists but isn't discoverable, connections invisible

---

### Connected Knowledge (With Knowledge Graph)

**Same knowledge, structured**:

```
Entities:
- JWT Authentication (concept)
- Security Best Practices (concept)
- HIPAA Compliance (regulatory)

Relations:
- JWT Authentication --requires--> Security Best Practices
- JWT Authentication --must-comply-with--> HIPAA Compliance
- HIPAA Compliance --mandates--> Audit Logging

Observations (on each entity):
- JWT Authentication:
  - "Stateless tokens using RS256 signing"
  - "Must implement refresh token rotation (HIPAA requirement)"
  - "Vulnerable if no revocation mechanism (learned 2024-12-10 incident)"

- Security Best Practices:
  - "Always hash passwords with bcrypt (min cost factor 12)"
  - "Use HTTPS only (HIPAA mandates encryption in transit)"

- HIPAA Compliance:
  - "Requires audit trail of all data access (retention 6 years)"
  - "Data encryption at rest and in transit mandatory"
```

**Now you can ask**:
- "What security practices does JWT require?" → Graph traversal shows connections
- "What does HIPAA mandate for authentication?" → Follows relations to find requirements
- "Show everything related to JWT" → Expands full context from all connections

**Result**: Knowledge is discoverable, connections explicit, team can navigate

---

## Knowledge Graph Basics

### Core Concepts

#### 1. Entities (Nodes)
**What**: Distinct concepts, technologies, patterns, people, projects

**Types we use**:
- **Concept**: Technical concepts (JWT, REST API, Event-driven)
- **Technology**: Specific tools (PostgreSQL, Redis, React)
- **Pattern**: Recurring solutions (Repository Pattern, Circuit Breaker)
- **Project**: Your projects (Midnight-Sun, Learning System)
- **Person**: Team members, teachers, experts
- **Regulatory**: Compliance requirements (HIPAA, GDPR)
- **Gotcha**: Common mistakes or pitfalls

**Example entities**:
```
- Entity: "JWT Authentication" (Concept)
- Entity: "Auth0" (Technology)
- Entity: "Token Refresh Pattern" (Pattern)
- Entity: "Midnight-Sun" (Project)
- Entity: "HIPAA" (Regulatory)
```

---

#### 2. Relations (Edges)
**What**: How entities connect to each other

**Relation types we use**:
- **requires**: X requires Y (JWT requires Signature Verification)
- **implements**: X implements Y (Auth0 implements OAuth 2.0)
- **uses**: X uses Y (Midnight-Sun uses JWT Authentication)
- **builds-on**: X builds on Y (OAuth 2.0 builds on OAuth 1.0)
- **alternative-to**: X is alternative to Y (JWT alternative to Sessions)
- **must-comply-with**: X must comply with Y (Healthcare apps must comply with HIPAA)
- **prevents**: X prevents Y (HTTPS prevents Man-in-Middle attacks)
- **causes**: X causes Y (Incorrect bcrypt cost factor causes slow logins)
- **taught-by**: X taught by Y (JWT taught by Auth0 documentation)

**Example relations**:
```
JWT Authentication --requires--> Signature Verification
JWT Authentication --alternative-to--> Session-based Auth
Midnight-Sun --uses--> JWT Authentication
JWT Authentication --must-comply-with--> HIPAA
HTTPS --prevents--> Man-in-Middle Attack
```

---

#### 3. Observations (Properties)
**What**: Facts, insights, experiences attached to entities

**Types of observations**:
- **Definition**: What it is
- **Why it matters**: Purpose, use cases
- **How it works**: Technical explanation
- **Gotcha**: Common mistakes
- **Experience**: Personal learning from using it
- **When to use**: Situations where it's appropriate
- **When to avoid**: Situations to avoid it

**Example observations on "JWT Authentication"**:
```
Observations:
1. "Stateless authentication using JSON Web Tokens with RS256 signing"
2. "Best for: Microservices, mobile apps, stateless APIs"
3. "Gotcha: Revocation is complex - can't invalidate token before expiration without state"
4. "Experience: Used in Midnight-Sun, discovered revocation complexity during security audit"
5. "When to avoid: High-security contexts requiring instant revocation (use sessions instead)"
```

---

## Integration with Memory MCP Server

### Available Tools

**Create**:
- `mcp__memory__create_entities` - Add new entities
- `mcp__memory__create_relations` - Connect entities
- `mcp__memory__add_observations` - Add insights to entities

**Read**:
- `mcp__memory__read_graph` - View entire graph
- `mcp__memory__search_nodes` - Find entities by keyword
- `mcp__memory__open_nodes` - Get specific entity details

**Update**:
- `mcp__memory__add_observations` - Add more observations to existing entities

**Delete**:
- `mcp__memory__delete_entities` - Remove entities
- `mcp__memory__delete_relations` - Remove connections
- `mcp__memory__delete_observations` - Remove specific observations

---

### Basic Workflows

#### Workflow 1: Create Entity

**When**: You encounter new concept worth remembering

**Example**: Learning about JWT

```bash
# Using MCP tool
mcp__memory__create_entities({
  entities: [{
    name: "JWT Authentication",
    entityType: "Concept",
    observations: [
      "JSON Web Token - stateless authentication mechanism",
      "Contains header, payload, signature (signed with secret or RSA key)",
      "Enables authentication without server-side session storage"
    ]
  }]
})
```

**Result**: Entity created in knowledge graph

---

#### Workflow 2: Connect Entities

**When**: You discover relationship between concepts

**Example**: Connecting JWT to Security Best Practices

```bash
# Using MCP tool
mcp__memory__create_relations({
  relations: [{
    from: "JWT Authentication",
    to: "Security Best Practices",
    relationType: "requires"
  }]
})
```

**Result**: Relation created, now traversable in graph

---

#### Workflow 3: Add Observations

**When**: You learn something new about existing concept

**Example**: Adding gotcha to JWT entity

```bash
# Using MCP tool
mcp__memory__add_observations({
  observations: [{
    entityName: "JWT Authentication",
    contents: [
      "Gotcha: Tokens can't be revoked before expiration without additional state (token blacklist)",
      "Experience: Production incident 2024-12-10 - compromised token couldn't be invalidated, 4-hour outage while implementing workaround"
    ]
  }]
})
```

**Result**: New observations added to entity

---

#### Workflow 4: Search Graph

**When**: Looking for related knowledge

**Example**: Finding all security-related concepts

```bash
# Using MCP tool
mcp__memory__search_nodes({
  query: "security"
})

# Returns:
# - JWT Authentication (mentions security)
# - Security Best Practices (direct match)
# - HTTPS (related to security)
# - Password Hashing (related to security)
```

**Result**: All relevant entities discovered

---

## Knowledge Capture Workflows

### From Dev Docs to Knowledge Graph

**Trigger**: During `/update-dev-docs` before compaction

**Process**:

1. **Review Layer 3** for new concepts/patterns/gotchas
2. **Extract entities** from key patterns and breakthroughs
3. **Create in knowledge graph**
4. **Link to related concepts**

**Example**:

```markdown
## Dev Docs Layer 3

### 🎯 Key Patterns
- **JWT Refresh Token Rotation**: Rotate refresh tokens on each use, invalidate old token (prevents token replay attacks)

### 💎 Breakthroughs
- **PostgreSQL JSONB**: Gives MongoDB-like flexibility with relational guarantees

### ⚠️ Gotchas
- **bcrypt cost factor**: Higher cost = more secure but slower logins (found sweet spot at cost 12 for our scale)
```

**Extract to Knowledge Graph**:

```bash
# Create entities for new concepts
mcp__memory__create_entities({
  entities: [
    {
      name: "Token Refresh Rotation Pattern",
      entityType: "Pattern",
      observations: [
        "Rotate refresh tokens on each use to prevent replay attacks",
        "Invalidate old refresh token immediately after issuing new one",
        "Provides revocation capability for stateless JWT systems"
      ]
    },
    {
      name: "PostgreSQL JSONB",
      entityType: "Technology",
      observations: [
        "PostgreSQL feature providing schema-less JSON storage with indexing",
        "Breakthrough: Gives MongoDB-like flexibility while maintaining relational guarantees",
        "Enables hybrid relational + document storage in single database"
      ]
    }
  ]
})

# Create relations
mcp__memory__create_relations({
  relations: [
    {
      from: "Token Refresh Rotation Pattern",
      to: "JWT Authentication",
      relationType: "enhances"
    },
    {
      from: "PostgreSQL JSONB",
      to: "PostgreSQL",
      relationType: "feature-of"
    }
  ]
})
```

---

### From Sprint Integration to Knowledge Graph

**Trigger**: During Sprint Integration Ritual (Saturday afternoon)

**Process**:

1. **Review patterns extracted** during integration
2. **Identify repeating patterns** (appeared multiple sprints)
3. **Create pattern entities** if not exists
4. **Add sprint-specific observations**
5. **Connect to related projects/technologies**

**Example**:

```markdown
## Sprint Integration - Sprint 14

### Pattern Extraction

**Technical patterns**:
- Async work consistently takes 2x estimates
- Pairing cuts debugging time in half

**Energy patterns**:
- Wednesday meetings kill Thursday productivity
```

**Extract to Knowledge Graph**:

```bash
# Create pattern entities
mcp__memory__create_entities({
  entities: [
    {
      name: "Async Work 2x Rule",
      entityType: "Pattern",
      observations: [
        "Async work (promises, async/await) takes 2x longer than estimates",
        "Discovered Sprint 10, validated Sprint 11-14",
        "Reason: Error handling, race conditions, testing async code all add complexity",
        "Mitigation: Automatically multiply async estimates by 2"
      ]
    },
    {
      name: "Meeting Impact on Flow",
      entityType: "Gotcha",
      observations: [
        "Meetings before deep work sessions destroy productivity",
        "Even 30-min meeting kills flow state for 2+ hours",
        "Discovered: Wednesday meeting-heavy days lead to Thursday low productivity",
        "Solution: Batch meetings to Tuesday PM, protect Wed-Thu for deep work"
      ]
    }
  ]
})

# Connect to projects
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

---

### From Extended Thinking to Knowledge Graph

**Trigger**: After extended thinking session produces ADR

**Process**:

1. **Extract decision as entity** (link to ADR)
2. **Extract considered options** as entities
3. **Create relations** showing decision reasoning
4. **Add insights** as observations

**Example**:

```markdown
# ADR-015: PostgreSQL vs MongoDB

**Decision**: PostgreSQL

**Reasoning**:
- Social graph queries are relational (PostgreSQL strength)
- Team SQL expertise reduces operational risk
- JSONB provides needed flexibility without losing relational guarantees
```

**Extract to Knowledge Graph**:

```bash
# Create decision entity
mcp__memory__create_entities({
  entities: [
    {
      name: "ADR-015 Database Choice Decision",
      entityType: "Decision",
      observations: [
        "Context: Choosing database for social network (100K users Year 1)",
        "Decision: PostgreSQL over MongoDB",
        "Extended Thinking Insight: 'Flexibility' is marketing - we needed query flexibility (SQL), not schema flexibility (NoSQL)",
        "Outcome: Correct choice - scaled well, team productive",
        "Avoided mistake: Would have chosen MongoDB for 'future flexibility' and regretted it when complex joins became bottleneck"
      ]
    }
  ]
})

# Create relations
mcp__memory__create_relations({
  relations: [
    {
      from: "ADR-015 Database Choice Decision",
      to: "PostgreSQL",
      relationType: "chose"
    },
    {
      from: "ADR-015 Database Choice Decision",
      to: "MongoDB",
      relationType: "rejected"
    },
    {
      from: "Midnight-Sun Project",
      to: "ADR-015 Database Choice Decision",
      relationType: "made"
    },
    {
      from: "ADR-015 Database Choice Decision",
      to: "Extended Thinking",
      relationType: "used"
    }
  ]
})
```

---

## Knowledge Graph Patterns

### Pattern 1: Technology Stack Mapping

**Purpose**: Visualize your tech stack and dependencies

**Structure**:

```
Your Project (Entity)
  --uses--> Technology A
  --uses--> Technology B
  --uses--> Technology C

Technology A
  --requires--> Library X
  --alternative-to--> Technology D

Technology B
  --depends-on--> Technology A
  --must-comply-with--> Regulatory Requirement
```

**Example for Midnight-Sun**:

```bash
mcp__memory__create_entities({
  entities: [
    { name: "Midnight-Sun", entityType: "Project", observations: ["Transformational coaching platform combining Ayahuasca, Hermetic Principles, and SRT"] },
    { name: "Next.js", entityType: "Technology", observations: ["React framework for production web applications"] },
    { name: "PostgreSQL", entityType: "Technology", observations: ["Open-source relational database"] },
    { name: "Prisma", entityType: "Technology", observations: ["Type-safe ORM for Node.js and TypeScript"] }
  ]
})

mcp__memory__create_relations({
  relations: [
    { from: "Midnight-Sun", to: "Next.js", relationType: "uses" },
    { from: "Midnight-Sun", to: "PostgreSQL", relationType: "uses" },
    { from: "Midnight-Sun", to: "Prisma", relationType: "uses" },
    { from: "Prisma", to: "PostgreSQL", relationType: "connects-to" },
    { from: "Next.js", to: "React", relationType: "builds-on" }
  ]
})
```

**Benefit**: See full tech stack at a glance, understand dependencies

---

### Pattern 2: Learning Progression Tracking

**Purpose**: Track how knowledge builds on itself

**Structure**:

```
Concept A (Foundational)
  --prerequisite-for--> Concept B
  --prerequisite-for--> Concept C

Concept B
  --builds-on--> Concept A
  --taught-by--> Resource X

Concept C
  --builds-on--> Concept A
  --builds-on--> Concept B
```

**Example for Learning Authentication**:

```bash
mcp__memory__create_entities({
  entities: [
    { name: "HTTP Basics", entityType: "Concept", observations: ["Stateless request/response protocol"] },
    { name: "Session-based Auth", entityType: "Concept", observations: ["Server-side session storage with cookies"] },
    { name: "Token-based Auth", entityType: "Concept", observations: ["Stateless authentication using tokens"] },
    { name: "JWT Authentication", entityType: "Concept", observations: ["Specific token format with claims and signatures"] }
  ]
})

mcp__memory__create_relations({
  relations: [
    { from: "HTTP Basics", to: "Session-based Auth", relationType: "prerequisite-for" },
    { from: "HTTP Basics", to: "Token-based Auth", relationType: "prerequisite-for" },
    { from: "Session-based Auth", to: "JWT Authentication", relationType: "alternative-to" },
    { from: "JWT Authentication", to: "Token-based Auth", relationType: "implements" }
  ]
})
```

**Benefit**: See learning path, identify prerequisites before diving in

---

### Pattern 3: Problem-Solution Mapping

**Purpose**: Connect problems to solutions you've discovered

**Structure**:

```
Problem (Gotcha)
  --solved-by--> Solution (Pattern)
  --caused-by--> Root Cause

Solution (Pattern)
  --prevents--> Problem
  --requires--> Technology/Tool
```

**Example**:

```bash
mcp__memory__create_entities({
  entities: [
    {
      name: "JWT Revocation Problem",
      entityType: "Gotcha",
      observations: [
        "Problem: Can't invalidate JWT before expiration without additional state",
        "Discovered: Production security incident 2024-12-10",
        "Impact: 4-hour outage implementing workaround"
      ]
    },
    {
      name: "Token Refresh Rotation Pattern",
      entityType: "Pattern",
      observations: [
        "Solution: Rotate refresh tokens on each use",
        "Invalidate old token immediately",
        "Provides revocation while maintaining statelessness for access tokens"
      ]
    }
  ]
})

mcp__memory__create_relations({
  relations: [
    { from: "Token Refresh Rotation Pattern", to: "JWT Revocation Problem", relationType: "solves" },
    { from: "JWT Revocation Problem", to: "JWT Authentication", relationType: "limitation-of" },
    { from: "Token Refresh Rotation Pattern", to: "JWT Authentication", relationType: "enhances" }
  ]
})
```

**Benefit**: When facing similar problems, graph shows proven solutions

---

## Integration with Existing Systems

### MOCs ↔ Knowledge Graph

**MOCs are views INTO the knowledge graph**

**Relationship**:
- MOC: Topical index (curated list for navigation)
- Knowledge Graph: Complete structure (all connections, queryable)

**Workflow**:

1. **Build knowledge graph** (entities + relations)
2. **Generate MOC** from graph queries
3. **MOC links to** entities in graph

**Example**:

```markdown
# Authentication MOC

**Generated from Knowledge Graph query**: `entities related to "Authentication"`

## Core Concepts
- [[HTTP Basics]] (prerequisite)
- [[Session-based Auth]] (traditional approach)
- [[Token-based Auth]] (modern approach)
- [[JWT Authentication]] (specific implementation)

## Patterns
- [[Token Refresh Rotation Pattern]] (solves revocation problem)
- [[Refresh Token Strategy]] (security + UX balance)

## Problems & Solutions
- [[JWT Revocation Problem]] --solved-by--> [[Token Refresh Rotation Pattern]]

## Technologies
- [[Auth0]] (managed auth service)
- [[Passport.js]] (Node.js auth middleware)

**This MOC auto-updates** when graph changes
```

---

### Dev Docs Layer 3 → Knowledge Graph

**Layer 3 is extraction pipeline**:

**Flow**:
```
Coding session
  ↓
Layer 3 capture (patterns, gotchas, breakthroughs)
  ↓
/update-dev-docs compaction
  ↓
Extract to Knowledge Graph (entities + relations)
  ↓
Layer 3 remains as chronological record
  ↓
Knowledge Graph provides spatial navigation
```

**Relationship**:
- **Layer 3**: Temporal (when did I learn this?)
- **Knowledge Graph**: Relational (how does this connect to other things?)

---

### Anki ↔ Knowledge Graph

**Anki cards generated FROM knowledge graph observations**:

**Workflow**:

1. **Add observation to entity** in graph
2. **Extract to Anki** if worth remembering long-term
3. **Anki card links back** to graph entity

**Example**:

```bash
# In Knowledge Graph
Entity: "JWT Authentication"
Observation: "Gotcha: Tokens can't be revoked before expiration without additional state"

# Extract to Anki
Card:
  Q: Why can't JWT tokens be revoked before expiration?
  A: JWTs are stateless - server doesn't track issued tokens. To revoke, need additional state (token blacklist or refresh token rotation pattern). See Knowledge Graph: "JWT Revocation Problem"

  Link: [[JWT Revocation Problem]] (knowledge graph entity)
```

**Benefit**: Spaced repetition keeps knowledge active, graph provides full context

---

## Visualization & Querying

### View Entire Graph

**Get overview of all knowledge**:

```bash
mcp__memory__read_graph()

# Returns:
# All entities with their observations
# All relations between entities
# Allows you to see full structure
```

**Use when**: Understanding overall knowledge structure, finding orphaned entities

---

### Search for Entities

**Find specific knowledge**:

```bash
mcp__memory__search_nodes({
  query: "JWT"
})

# Returns all entities mentioning "JWT":
# - JWT Authentication
# - JWT Revocation Problem
# - Token Refresh Rotation Pattern (mentions JWT in observations)
```

**Use when**: Quickly finding related concepts

---

### Open Specific Entities

**Get full details**:

```bash
mcp__memory__open_nodes({
  names: ["JWT Authentication", "Token Refresh Rotation Pattern"]
})

# Returns:
# Full observations for each entity
# Relations to/from each entity
# Complete context
```

**Use when**: Deep-diving into specific concept

---

## Maintenance & Evolution

### Weekly Knowledge Graph Review

**When**: Friday afternoon or Saturday (part of weekly review)

**Process**:

1. **Review this week's entities added**
2. **Check for orphaned entities** (no relations)
3. **Merge duplicates** (same concept, different names)
4. **Add missing relations** (discovered connections)
5. **Update observations** (new learnings about existing entities)

**Template**:

```markdown
# Knowledge Graph Weekly Review - Week [N]

## Entities Added This Week
- [Entity 1]: [Type] - [Why added]
- [Entity 2]: [Type] - [Why added]

## Orphaned Entities (No Relations)
- [Entity X]: Should connect to [Entity Y] via [relation type]
- Action: Add relation

## Duplicates Found
- "JWT Auth" and "JWT Authentication" are same
- Action: Merge into "JWT Authentication"

## Missing Relations Discovered
- "PostgreSQL" --supports--> "JSONB" (should have been connected)
- Action: Add relation

## Observations Updated
- Added gotcha to "bcrypt": Cost factor too high causes slow logins
- Added experience to "Extended Thinking": Used in ADR-015, prevented database choice mistake
```

---

### Quarterly Knowledge Graph Audit

**When**: Every 12-15 weeks

**Purpose**: Deep cleaning and evolution

**Process**:

1. **Identify stale entities** (not accessed in 3+ months)
2. **Archive or delete** if no longer relevant
3. **Consolidate related entities** into higher-level concepts
4. **Validate relations** (still accurate?)
5. **Extract meta-patterns** (what do connection patterns reveal?)

**Example**:

```markdown
# Q4 2024 Knowledge Graph Audit

## Stale Entities (Not Accessed 3+ Months)
- "Ruby on Rails": Stopped using Rails 6 months ago
- Action: Archive (keep observations, remove from active graph)

## Consolidation Opportunities
- 5 entities about "Authentication" variants
- Action: Create higher-level "Authentication Strategies" entity, make others children

## Relation Validation
- "Midnight-Sun uses MongoDB": Outdated (migrated to PostgreSQL)
- Action: Update relation

## Meta-Patterns Discovered
- Most gotchas relate to async programming (15 entities)
- Most patterns relate to security (12 entities)
- Action: Create "Async Programming Gotchas MOC" and "Security Patterns MOC"
```

---

## Quick Start

### Week 1: Foundation

**Goal**: Create first 10 entities

**Tasks**:
1. List your current project's tech stack
2. Create entity for each technology
3. Create entity for current project
4. Connect project to technologies (uses relation)

**Result**: Basic tech stack mapped

---

### Week 2: Expand

**Goal**: Add 20 more entities from recent work

**Tasks**:
1. Review last sprint's dev docs Layer 3
2. Extract 5 patterns/gotchas as entities
3. Review last 3 ADRs
4. Extract decisions as entities
5. Connect everything

**Result**: 30 entities, rich connection network starting to form

---

### Week 3: Integrate

**Goal**: Connect knowledge graph to daily workflow

**Tasks**:
1. Add "Extract to Knowledge Graph" step to `/update-dev-docs`
2. Add "Knowledge Graph Update" to Sprint Integration Ritual
3. Create first MOC from graph query
4. Generate Anki cards from graph observations

**Result**: Knowledge graph becomes living system, not one-time creation

---

## Success Metrics

### You're using Knowledge Graph well when:

**Qualitative**:
- ✅ Can answer "What connects to X?" instantly
- ✅ Discovering knowledge you forgot exists
- ✅ Team can navigate your knowledge
- ✅ Patterns emerge from graph structure
- ✅ Less "I know I learned this somewhere..."

**Quantitative**:
- ✅ Entities: Growing steadily (target: 100+ after 3 months)
- ✅ Relations: 2-3x entity count (well-connected)
- ✅ Orphaned entities: <5% (most things connected)
- ✅ Search success rate: >90% (find what you need)
- ✅ Knowledge reuse: Track how often graph helps find solutions

---

## Quick Reference

### Core MCP Tools

**Create**:
- `mcp__memory__create_entities` - Add entities
- `mcp__memory__create_relations` - Connect entities
- `mcp__memory__add_observations` - Add insights

**Read**:
- `mcp__memory__read_graph` - View all
- `mcp__memory__search_nodes` - Find by keyword
- `mcp__memory__open_nodes` - Get specific entity

**Update**:
- `mcp__memory__add_observations` - Add more observations

**Delete**:
- `mcp__memory__delete_entities` - Remove entities
- `mcp__memory__delete_relations` - Remove connections

### Common Entity Types

- **Concept**: Technical concepts
- **Technology**: Specific tools/frameworks
- **Pattern**: Recurring solutions
- **Gotcha**: Common mistakes
- **Project**: Your projects
- **Person**: People who taught you
- **Regulatory**: Compliance requirements
- **Decision**: Architecture decisions

### Common Relation Types

- **requires**, **uses**, **implements**
- **builds-on**, **alternative-to**
- **must-comply-with**, **prevents**
- **solves**, **causes**
- **taught-by**, **discovered-by**

---

**For complete Memory MCP integration, see**: `AUTOMATION_MCP_SETUP.md`

**For knowledge capture workflows, see**: `.claude/skills/knowledge-management/build-knowledge-graph.md`

**May your knowledge be connected. May your insights be discoverable. May your wisdom compound.**
