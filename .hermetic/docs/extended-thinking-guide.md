# Extended Thinking Guide - Deep Deliberation for Complex Problems

**Principle**: "For critical decisions, think slowly to move fast"

**What is extended thinking**: Claude's mode for longer, more deliberate reasoning on complex problems

**Why use it**: Some problems require sustained analysis beyond normal conversation depth

---

## When to Use Extended Thinking

### Use Extended Thinking For:

✅ **Critical architecture decisions**
- "Should we use microservices or monolith?"
- "SQL vs NoSQL for this use case?"
- "Choose auth strategy: JWT, sessions, OAuth?"

✅ **Security-critical analysis**
- Threat modeling
- Vulnerability assessment
- Security architecture review

✅ **Complex debugging**
- Race conditions in distributed systems
- Memory leaks with non-obvious cause
- Heisenbug that changes when observed

✅ **Algorithm selection**
- Performance vs complexity tradeoffs
- Big-O analysis for real-world constraints
- Choosing between 3+ viable approaches

✅ **Ethical considerations**
- Dark pattern detection
- Privacy implications
- User autonomy impacts

✅ **Long-term strategy**
- Technical roadmap planning
- Technical debt prioritization
- Platform migration decisions

---

### Use Normal Thinking For:

❌ **Straightforward implementation**
- "How do I write a for loop?"
- "What's the syntax for X?"

❌ **Well-defined problems**
- Implementing CRUD endpoint
- Writing standard tests

❌ **Quick clarifications**
- "What does this error mean?"
- "Reminder of best practice?"

**Rule of thumb**: If the decision could cost weeks to reverse, use extended thinking

---

## How to Invoke Extended Thinking

### Method 1: Explicit Request

**Clear prompt structure**:

```markdown
I need your extended thinking on: [Problem statement]

**Context**:
- [Relevant background]
- [Constraints]
- [What's at stake]

**Specific questions**:
1. [Question requiring deep analysis]
2. [Trade-off to evaluate]
3. [Long-term consequences to consider]

Please think through this deliberately and show your reasoning.
```

**Example**:
```
I need your extended thinking on: Authentication architecture for healthcare app

**Context**:
- Handling PHI (Protected Health Information)
- HIPAA compliance required
- 10,000+ users expected
- Mobile + web clients
- Budget allows for managed services

**Specific questions**:
1. JWT vs sessions vs OAuth - which best serves our security requirements?
2. How do we handle token revocation for healthcare compliance?
3. What are long-term scalability implications of each approach?
4. Which approach minimizes privacy risks?

Please think through this deliberately and show your reasoning.
```

---

### Method 2: Invoke via Hermetic Command

**Use `/illuminate` command**:

```bash
/illuminate "Authentication architecture choice - JWT vs sessions for healthcare app with HIPAA requirements"
```

The `/illuminate` command automatically:
- Triggers extended thinking mode
- Applies all 7 Hermetic Principles as evaluation framework
- Provides comprehensive analysis
- Documents decision rationale

---

## Extended Thinking Workflow

### Stage 1: Problem Framing (You)

**Before requesting extended thinking**, frame the problem completely:

```markdown
## Problem Statement
[Clear, specific question]

## Context
- **What we're building**: [Description]
- **Current state**: [Where we are now]
- **Desired state**: [Where we want to be]
- **Constraints**: [Technical, time, budget, regulatory]

## What's at Stake
- If we choose wrong: [Consequences]
- Timeline: [When decision needed]
- Reversibility: [How hard to change later]

## Prior Research
- **Considered options**: [List of alternatives]
- **Eliminated already**: [What we've ruled out and why]
- **Uncertain about**: [Specific gaps in understanding]

## Specific Questions for Extended Thinking
1. [Question 1]
2. [Question 2]
3. [Question 3]
```

**Example**:
```markdown
## Problem Statement
Should we use PostgreSQL or MongoDB for our social network's data layer?

## Context
- **Building**: Social network with posts, comments, likes, user profiles
- **Current state**: MVP with SQLite (10 users)
- **Desired state**: Production-ready (targeting 100K users Year 1)
- **Constraints**:
  - Team knows SQL well, MongoDB limited
  - Budget: $500/month for managed database
  - Timeline: Need to decide this week (migration takes 2 weeks)

## What's at Stake
- If we choose wrong: 6+ month migration project in Year 2
- Timeline: Decision needed by Friday
- Reversibility: Very hard (data migration + code rewrite)

## Prior Research
- **Considered**: PostgreSQL, MongoDB, DynamoDB
- **Eliminated**: DynamoDB (too expensive for our budget)
- **Uncertain about**:
  - Can PostgreSQL handle social graph queries at scale?
  - Is MongoDB's flexibility worth the learning curve?

## Specific Questions for Extended Thinking
1. What access patterns will social network have? (Read-heavy? Write-heavy?)
2. How do PostgreSQL and MongoDB handle these patterns at 100K users?
3. What are hidden costs (learning curve, operational complexity)?
4. Which choice minimizes regret if we're wrong about scale?
```

---

### Stage 2: Extended Analysis (Claude)

**Extended thinking provides**:

1. **Comprehensive exploration**
   - All relevant considerations (not just obvious ones)
   - Edge cases and gotchas
   - Second-order effects

2. **Tradeoff analysis**
   - Explicit pros/cons for each option
   - Quantified where possible
   - Qualitative assessment where quantification impossible

3. **Scenario planning**
   - Best case, worst case, likely case for each option
   - Decision trees ("If X happens, then Y becomes optimal")

4. **Principle alignment**
   - How each option aligns with 7 Hermetic Principles
   - Ethical implications
   - Long-term sustainability

5. **Recommended decision**
   - Clear recommendation with reasoning
   - Conditions under which recommendation changes
   - Monitoring metrics to validate choice

---

### Stage 3: Decision Documentation (You)

**Immediately after extended thinking**, document the decision:

**Create Architecture Decision Record (ADR)**:

```markdown
# ADR-[Number]: [Decision Title]

**Date**: [YYYY-MM-DD]
**Status**: Decided
**Deciders**: [Who was involved]

## Context and Problem Statement

[The problem that required extended thinking]

## Considered Options

1. [Option 1]
2. [Option 2]
3. [Option 3]

## Decision Outcome

**Chosen**: [Option X]

**Reasoning** (from extended thinking analysis):
- [Key reason 1]
- [Key reason 2]
- [Key reason 3]

## Extended Thinking Insights

**Comprehensive considerations discovered**:
- [Insight 1 that wasn't obvious before]
- [Insight 2]
- [Gotcha that extended thinking revealed]

**Tradeoffs accepted**:
- ✅ Gaining: [What we gain]
- ❌ Losing: [What we sacrifice]

**Scenarios**:
- **Best case**: [What happens if everything goes right]
- **Worst case**: [What happens if wrong + mitigation]
- **Likely case**: [Realistic outcome]

## Principle Alignment

How this decision aligns with Hermetic Principles:

- **Mentalism**: [Mental clarity check]
- **Correspondence**: [Structure mirrors values?]
- **Vibration**: [Enables iteration?]
- **Polarity**: [Balances opposites?]
- **Rhythm**: [Sustainable?]
- **Cause & Effect**: [Consequences understood?]
- **Gender**: [Balances doing + being?]

## Monitoring and Validation

**Metrics to track** (validate we chose correctly):
- [Metric 1]: Target [X], Alert if [Y]
- [Metric 2]: Target [X], Alert if [Y]

**Decision review date**: [3-6 months from now]

**Conditions for revisiting**:
- If [condition 1 occurs], reconsider
- If [condition 2 occurs], reconsider

## Links

- Extended thinking transcript: [Link or file]
- Related ADRs: [[ADR-X]], [[ADR-Y]]
- Implementation tracking: [Sprint/ticket]
```

**Save as**: `dev/decisions/adr-[number]-[slug].md`

---

### Stage 4: Extract to MOC (You)

**Add decision to relevant MOCs**:

```markdown
# Architecture Decisions MOC

## Database Decisions
- [[ADR-001 - PostgreSQL vs MongoDB]] (Chose PostgreSQL - social graph queries)
- [[ADR-005 - Caching Strategy]] (Chose Redis - read-heavy patterns)

## Authentication Decisions
- [[ADR-002 - JWT vs Sessions]] (Chose sessions - revocation requirements)
- [[ADR-007 - OAuth Provider]] (Chose Auth0 - HIPAA compliance)

## Extended Thinking Patterns

### When Extended Thinking Saved Us
- **Database choice** (ADR-001): Would have picked MongoDB for "flexibility", extended thinking revealed PostgreSQL better for our graph queries
- **Auth architecture** (ADR-002): Almost went JWT, extended thinking caught revocation complexity for our compliance needs

### When to Use Extended Thinking
- Critical decisions (hard to reverse)
- Security implications
- >$10K cost implications
- Affects >3 teams
```

---

### Stage 5: Extract to Spaced Repetition (You)

**Create Anki cards from insights**:

**Card 1**:
- Q: When should you use extended thinking vs normal thinking?
- A: Extended thinking for: Critical architecture (hard to reverse), Security analysis, Complex debugging, Ethical considerations, Long-term strategy. Normal thinking for: Straightforward implementation, Well-defined problems, Quick clarifications.

**Card 2** (from actual decision):
- Q: For social network database, why did extended thinking recommend PostgreSQL over MongoDB?
- A: Three insights: (1) Social graphs are relational (PostgreSQL strength), (2) Query complexity favors SQL (known patterns), (3) Team SQL expertise reduces operational risk. MongoDB flexibility wasn't needed for our use case.

**Card 3**:
- Q: What are the 3 components of a good extended thinking request?
- A: (1) Clear problem statement + context, (2) Specific questions requiring deep analysis, (3) What's at stake (consequences, timeline, reversibility).

---

## Integration with Hermetic Systems

### Dev Docs: Extended Thinking Insights

**Add to Layer 3**:

```markdown
## ⚡ Layer 3: Critical Insights

### 💎 Breakthroughs (Extended Thinking)

**Database Architecture Decision** (2024-12-15):
Extended thinking revealed PostgreSQL's JSONB gives us MongoDB-like flexibility PLUS relational guarantees. Wasn't obvious until deep analysis - best of both worlds.

**Key insight**: "Flexibility" is marketing term. Real question: "Which flexibility do you actually need?" We needed query flexibility (SQL), not schema flexibility (NoSQL).

**Avoided mistake**: Would have chosen MongoDB for "future flexibility" and regretted it 6 months later when complex joins became bottleneck.
```

---

### Ceremonial Agile: Extended Thinking in Integration

**Use extended thinking in Sprint Integration Ritual**:

```markdown
## Sprint Integration - Sprint 14

### Extended Thinking Session: Pattern Extraction

**Question for Extended Thinking**:
"We've noticed our testing keeps slipping. We say we'll test first, but always skip it under time pressure. What's the deeper pattern here, and how do we actually change it?"

**Extended Thinking Insights**:
[Claude's deep analysis would go here]

**Actions from Insights**:
- [ ] Recognized: Testing isn't a discipline problem, it's a fear problem (fear we won't finish on time)
- [ ] Experiment: Timebox sprints with LESS scope, test-first becomes possible
- [ ] Track: "Did we test first?" + "Did we finish on time?" for 3 sprints
```

**Purpose**: Use extended thinking for deep reflection on repeating patterns

---

### Cognitive Load: When to Pause for Extended Thinking

**Signal in cognitive load tracking**:

```markdown
## Cognitive Load Journal - 2024-12-15

**Load Score**: 85% 🔴 (Critical)

**Why high**:
⚠️ Trying to make architecture decision while coding
⚠️ Don't have clear mental model
⚠️ Flipping between 3 options, analysis paralysis

**Action**:
🛑 **STOP coding**
📝 **Use extended thinking** to resolve architecture decision
⏸️ **Resume coding** only after decision documented

Result: 90 minutes of extended thinking, clear decision, cognitive load dropped to 40% when resumed coding.
```

**Principle**: When load is high from decision uncertainty, don't push through - use extended thinking to resolve, THEN execute with clarity

---

## Common Patterns

### Pattern 1: The Goldilocks Prompt

**Too vague** (not enough for extended thinking):
```
"What's the best database?"
```

**Too specific** (constrains extended thinking):
```
"Compare PostgreSQL 15.2 vs MongoDB 6.0 for a social network with exactly these 47 features..."
[Lists every detail]
```

**Just right**:
```
"I'm building a social network. Help me choose between PostgreSQL and MongoDB.

Context:
- Social graph (users, posts, comments, likes)
- 100K users target Year 1
- Team knows SQL, limited MongoDB experience
- Read-heavy workload (10:1 read:write)
- Budget: $500/month managed DB

Questions:
1. Which handles social graph queries better at scale?
2. What are hidden operational costs?
3. Which minimizes regret if we're wrong about scale assumptions?

Use extended thinking please."
```

**Sweet spot**: Enough context to ground thinking, enough openness for exploration

---

### Pattern 2: Iterative Extended Thinking

**Don't ask everything at once** - Iterate:

**Round 1**: High-level decision
```
"Extended thinking: Choose between PostgreSQL vs MongoDB for social network"

[Claude provides comprehensive analysis]

Decision: PostgreSQL
```

**Round 2**: Implementation details
```
"Extended thinking: Given we chose PostgreSQL, help design schema for social graph

Specific: How to model friend relationships?
- Simple join table?
- Recursive CTE for mutual friends?
- Graph extension (pg_graph)?

[Claude provides deep analysis of query patterns and performance]

Decision: Join table + materialized views for common queries
```

**Round 3**: Optimization
```
"Extended thinking: We're seeing slow friend-of-friend queries

Context: [Performance data]
Options: [Potential solutions]

[Claude analyzes and recommends]

Decision: Denormalize friend counts, keep join table for accuracy
```

**Principle**: Extended thinking works best on focused questions, not "solve everything"

---

### Pattern 3: Post-Mortem Extended Thinking

**After a mistake**, use extended thinking to deeply understand:

```markdown
## Post-Mortem: Production Outage 2024-12-10

**What happened**:
- Chose JWT for auth 6 months ago
- Today: Can't revoke tokens, compromised token discovered
- Result: 4-hour outage while we implemented revocation workaround

**Extended Thinking Question**:
"We chose JWT 6 months ago and it led to this outage. Help me understand:
1. What considerations did we miss in the original decision?
2. What questions should we have asked but didn't?
3. How do we prevent this category of mistake in future architecture decisions?"

**Extended Thinking Insights**:
[Claude's deep analysis of the decision process and failure modes]

**Extracted Wisdom**:
- **Pattern**: We optimized for "stateless" without asking "what state do we NEED to track?"
- **Missed question**: "How do we revoke access in emergency?"
- **Prevention**: Add "emergency scenarios" section to all architecture decisions

**Updated Process**:
Created new ADR template section: "Emergency Response" - forces us to think through worst-case recovery for every architecture choice
```

**Purpose**: Turn mistakes into wisdom through deep reflection

---

## Advanced Techniques

### Technique 1: Principle-Guided Extended Thinking

**Explicitly invoke principles in prompt**:

```markdown
Extended thinking request: Microservices vs Monolith decision

Please analyze through lens of Hermetic Principles:

**Mentalism**: Which approach requires clearer mental model? Which creates less cognitive overhead?

**Correspondence**: Which structure better mirrors our team structure and values?

**Vibration**: Which enables faster iteration and shipping?

**Polarity**: How does each approach balance simplicity vs flexibility, speed vs robustness?

**Rhythm**: Which supports sustainable development pace long-term?

**Cause & Effect**: What are second and third-order effects of each choice?

**Gender**: Which balances doing (building features) with being (maintaining systems)?
```

**Result**: Ensures decision aligns with values, not just technical factors

---

### Technique 2: Comparative Extended Thinking

**Analyze multiple past decisions to extract meta-patterns**:

```markdown
Extended thinking meta-analysis request:

I want to understand our decision-making patterns. Here are 3 architecture decisions from past year:

**Decision 1**: Database choice (PostgreSQL vs MongoDB)
- Chose: PostgreSQL
- Outcome: Good (scaled well, team productive)

**Decision 2**: Auth approach (JWT vs Sessions)
- Chose: JWT
- Outcome: Bad (revocation issues, security incident)

**Decision 3**: Caching strategy (Redis vs Memcached)
- Chose: Redis
- Outcome: Good (persistence needed, worked great)

Questions for deep analysis:
1. What pattern distinguishes good decisions from bad?
2. What questions did we ask in good decisions but not in bad ones?
3. What decision-making framework should we use going forward?

[Extended thinking extracts meta-patterns across decisions]
```

**Purpose**: Improve decision-making process itself

---

### Technique 3: Scenario Planning via Extended Thinking

**For high-uncertainty decisions**:

```markdown
Extended thinking: Help me plan for uncertainty

**Decision**: Should we build our own auth system or use Auth0?

**Scenarios to analyze**:

**Scenario A**: We grow to 1M users (10x target)
- How does each choice perform?
- What breaks first?
- Recovery options?

**Scenario B**: Security breach occurs
- Which is easier to respond to?
- What's our liability?
- Recovery time?

**Scenario C**: Budget cuts by 50%
- Can we still afford managed service?
- If building ourselves, can we maintain it with less resources?

**Scenario D**: Regulatory requirements change (HIPAA added)
- Which choice is more adaptable?
- Compliance costs?

For each scenario + choice combination, analyze thoroughly.
```

**Result**: Robust decision that works across multiple futures

---

## Success Metrics

### You're using Extended Thinking well when:

**Qualitative**:
- ✅ Fewer regretted architectural decisions (tracked in ADRs)
- ✅ Team confident in major choices (post-decision surveys)
- ✅ Clear documentation of why decisions made (future team can understand)
- ✅ Principles explicitly considered (not afterthought)
- ✅ Mistakes turned into wisdom (post-mortems extract learnings)

**Quantitative**:
- ✅ Architecture reversals: [Before extended thinking] → [After extended thinking] (should decrease)
- ✅ Time to decision: May increase upfront, but total time (including reversals) should decrease
- ✅ ADR quality score: [Before] → [After] (more comprehensive reasoning)
- ✅ Post-decision confidence: Survey team on 1-10 scale

---

## Quick Reference

### When to Use Extended Thinking

**Critical decisions** where:
- Hard to reverse (>2 weeks work to undo)
- Security implications
- Affects >3 teams
- >$10K cost impact
- Ethical considerations
- Long-term strategic

### How to Invoke

**Method 1**: Explicit prompt
```
"I need extended thinking on: [Problem]
Context: [Background]
Questions: [Specific]
Please think through deliberately."
```

**Method 2**: Hermetic command
```
/illuminate "[Problem statement]"
```

### What to Do with Results

1. **Document immediately**: Create ADR
2. **Extract to MOC**: Add to Architecture Decisions MOC
3. **Create Anki cards**: Preserve insights
4. **Update Layer 3**: Add breakthrough to dev docs
5. **Monitor metrics**: Track if decision was correct

### Integration Points

- **Dev docs Layer 3**: 💎 Breakthroughs from extended thinking
- **Ceremonial Agile**: Sprint Integration uses extended thinking for deep reflection
- **Cognitive Load**: When load high from uncertainty, use extended thinking to resolve
- **ADRs**: Extended thinking becomes decision rationale

---

**For complete ADR template, see**: `.hermetic/docs/architecture-decision-records.md`

**For extended thinking examples, see**: `.hermetic/examples/extended-thinking-sessions/`

**May your decisions be deliberate. May your thinking be deep. May your choices be wise.**
