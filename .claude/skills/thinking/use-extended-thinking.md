---
name: use-extended-thinking
description: Invoke deep deliberation for complex decisions
category: thinking
principle: Mentalism
---

# Use Extended Thinking - Deep Deliberation for Critical Decisions

**Hermetic Principle**: Mentalism - "Think slowly to move fast"

**When to use**: Critical architecture decisions, security analysis, complex debugging, ethical considerations

---

## Quick Concept

**Normal thinking** = Quick answers (good for straightforward problems)

**Extended thinking** = Deep deliberation (critical for complex decisions)

**Cost of wrong choice** = Weeks of reversal work

**Solution**: Invest time in deep thinking upfront → Save weeks later

---

## When to Use

### ✅ Use Extended Thinking For:

**Critical decisions** where:
- Hard to reverse (>2 weeks to undo)
- Security implications
- Affects >3 teams
- >$10K cost impact
- Ethical considerations
- Long-term strategic

**Examples**:
- "Should we use microservices or monolith?"
- "JWT vs sessions for healthcare app?"
- "SQL vs NoSQL for this use case?"
- "Build vs buy for auth system?"

---

### ❌ Use Normal Thinking For:

**Straightforward problems**:
- "How do I write a for loop?"
- "What's the syntax for X?"
- Implementing CRUD endpoint
- Writing standard tests
- Quick clarifications

**Rule**: If decision could cost weeks to reverse, use extended thinking

---

## How to Invoke

### Method 1: Explicit Request

**Template**:

```markdown
I need your extended thinking on: [Problem]

**Context**:
- [Relevant background]
- [Constraints (time, budget, technical)]
- [What's at stake]

**Specific questions**:
1. [Question requiring deep analysis]
2. [Trade-offs to evaluate]
3. [Long-term consequences to consider]

Please think through this deliberately and show your reasoning.
```

---

### Method 2: Hermetic Command

**Use `/illuminate` command** (auto-applies Hermetic Principles):

```bash
/illuminate "Database choice - PostgreSQL vs MongoDB for social network"
```

**What `/illuminate` does**:
- Triggers extended thinking mode
- Applies 7 Hermetic Principles as evaluation framework
- Provides comprehensive analysis
- Documents decision rationale

---

## The 5-Stage Workflow

### Stage 1: Frame the Problem (3-5 min)

**Don't just ask** - Frame completely:

```markdown
## Problem Statement
[One clear question]

## Context
- **Building**: [What system]
- **Current state**: [Where we are]
- **Desired state**: [Where we want to be]
- **Constraints**: [Technical, time, budget, regulatory]

## What's at Stake
- If we choose wrong: [Consequences]
- Timeline: [When decision needed]
- Reversibility: [How hard to change later]

## Prior Research
- **Considered options**: [List alternatives]
- **Eliminated already**: [What ruled out + why]
- **Uncertain about**: [Gaps in understanding]

## Specific Questions
1. [Deep question 1]
2. [Deep question 2]
3. [Deep question 3]
```

**Save as**: Draft in note-taking app

---

### Stage 2: Request Extended Thinking (1 min)

**Paste framed problem** into Claude Code chat:

```
I need your extended thinking on the problem framed above.

Please think through deliberately and show your reasoning.
```

**OR use `/illuminate` with problem statement**

---

### Stage 3: Receive Deep Analysis (Claude provides)

**Extended thinking delivers**:
1. Comprehensive exploration (all considerations, not just obvious)
2. Tradeoff analysis (explicit pros/cons, quantified where possible)
3. Scenario planning (best/worst/likely cases)
4. Principle alignment (how options align with values)
5. Clear recommendation (with reasoning and conditions)

**Read carefully** - Extended thinking reveals non-obvious insights

---

### Stage 4: Document Decision (15 min)

**Create Architecture Decision Record (ADR)** immediately:

```markdown
# ADR-[Number]: [Decision Title]

**Date**: [YYYY-MM-DD]
**Status**: Decided

## Problem
[The problem that required extended thinking]

## Decision
**Chosen**: [Option X]

**Reasoning** (from extended thinking):
- [Key reason 1]
- [Key reason 2]
- [Key reason 3]

## Tradeoffs Accepted
- ✅ Gaining: [What we gain]
- ❌ Losing: [What we sacrifice]

## Scenarios
- **Best case**: [If everything goes right]
- **Worst case**: [If wrong + mitigation plan]
- **Likely case**: [Realistic outcome]

## Principle Alignment
- **Mentalism**: [Clear mental model?]
- **Vibration**: [Enables iteration?]
- **Rhythm**: [Sustainable?]
[etc. for all 7 principles]

## Monitoring
**Metrics to track**:
- [Metric 1]: Target [X], alert if [Y]
- [Metric 2]: Target [X], alert if [Y]

**Review date**: [3-6 months]

**Reconsider if**:
- [Condition 1 occurs]
- [Condition 2 occurs]

## Links
- Extended thinking transcript: [Link/file]
- Related ADRs: [[ADR-X]]
```

**Save as**: `dev/decisions/adr-[number]-[slug].md`

---

### Stage 5: Extract Wisdom (10 min)

**After documenting, extract insights**:

#### To MOC
```markdown
# Architecture Decisions MOC

## Recent Decisions
- [[ADR-015 - Database Choice]] (PostgreSQL - social graph queries)

## Extended Thinking Wins
- **Database**: Would have picked MongoDB for "flexibility", extended thinking revealed PostgreSQL better for our specific query patterns
```

#### To Dev Docs Layer 3
```markdown
## ⚡ Layer 3: Critical Insights

### 💎 Breakthroughs (Extended Thinking)

**Database Decision** (2024-12-15):
Extended thinking revealed: "Flexibility" is marketing. Real question: "Which flexibility do you need?" We needed query flexibility (SQL), not schema flexibility (NoSQL).

**Avoided mistake**: Would have chosen MongoDB and regretted it when complex joins became bottleneck.
```

#### To Anki
**Card**:
- Q: Why did extended thinking recommend PostgreSQL over MongoDB for social network?
- A: Three insights: (1) Social graphs are relational (PostgreSQL strength), (2) Query complexity favors SQL, (3) Team SQL expertise reduces operational risk. MongoDB flexibility wasn't needed for our use case.

---

## Common Patterns

### Pattern 1: The Goldilocks Prompt

**Too vague** (not enough context):
```
"What's the best database?"
```

**Too specific** (constrains thinking):
```
"Compare PostgreSQL 15.2 vs MongoDB 6.0 for exactly these 47 features..."
[Lists every detail]
```

**Just right**:
```
"I'm building a social network. Help me choose between PostgreSQL and MongoDB.

Context:
- Social graph (users, posts, comments, likes)
- 100K users target Year 1
- Team knows SQL, MongoDB limited
- Read-heavy (10:1 read:write)
- Budget: $500/month managed DB

Questions:
1. Which handles social graph queries better at scale?
2. Hidden operational costs?
3. Which minimizes regret if wrong about scale?

Use extended thinking please."
```

**Sweet spot**: Enough context to ground, enough openness to explore

---

### Pattern 2: Iterative Extended Thinking

**Don't ask everything at once** - Iterate:

**Round 1**: High-level choice
```
"Extended thinking: PostgreSQL vs MongoDB for social network"
→ Decision: PostgreSQL
```

**Round 2**: Implementation details
```
"Extended thinking: Given PostgreSQL, how to model friend relationships?
- Simple join table?
- Recursive CTE for mutual friends?
- Graph extension?"

→ Decision: Join table + materialized views for common queries
```

**Round 3**: Optimization
```
"Extended thinking: Slow friend-of-friend queries. Solutions?"
→ Decision: Denormalize friend counts, keep join table for accuracy
```

**Principle**: Extended thinking works best on focused questions

---

### Pattern 3: Post-Mortem Extended Thinking

**After a mistake**, use extended thinking to extract wisdom:

```markdown
**Extended Thinking Post-Mortem**:

"We chose JWT 6 months ago. Today: can't revoke tokens, had security incident, 4-hour outage.

Questions:
1. What considerations did we miss?
2. What questions should we have asked but didn't?
3. How to prevent this category of mistake?"

[Extended thinking analyzes decision process and failure modes]

**Extracted Wisdom**:
- Pattern: Optimized for "stateless" without asking "what state MUST we track?"
- Missed question: "How do we revoke access in emergency?"
- Prevention: Add "Emergency Response" section to all ADRs
```

**Purpose**: Turn mistakes into wisdom

---

## Integration with Hermetic Systems

### Ceremonial Agile: Extended Thinking in Sprint Integration

**Use in Sprint Integration Ritual**:

```markdown
## Sprint Integration - Sprint 14

### Extended Thinking Session

**Question**:
"Testing keeps slipping. We say test-first, but always skip under pressure. What's the deeper pattern? How do we actually change?"

**Extended Thinking Insights**:
[Claude's deep analysis]

**Actions**:
- Recognized: Not discipline problem, fear problem (fear won't finish on time)
- Experiment: Timebox sprints with LESS scope, test-first becomes possible
- Track: "Test-first?" + "Finished on time?" for 3 sprints
```

**Purpose**: Deep reflection on repeating patterns

---

### Cognitive Load: Pause for Extended Thinking

**When cognitive load high from decision uncertainty**:

```markdown
## Cognitive Load Journal - 2024-12-15

**Load Score**: 85% 🔴 (Critical)

**Why high**:
⚠️ Trying to make architecture decision while coding
⚠️ Don't have clear mental model
⚠️ Flipping between 3 options, analysis paralysis

**Action**:
🛑 STOP coding
📝 Use extended thinking to resolve decision
⏸️ Resume coding only after decision documented

Result: 90 min extended thinking, clear decision, load dropped to 40%.
```

**Principle**: When load high from uncertainty, don't push through - resolve with extended thinking first

---

### Dev Docs: Layer 3 Breakthroughs

**Extended thinking insights** are often 💎 Breakthroughs:

```markdown
## ⚡ Layer 3: Critical Insights

### 💎 Breakthroughs

**PostgreSQL JSONB Revelation** (Extended Thinking, 2024-12-15):
Extended thinking revealed PostgreSQL's JSONB gives MongoDB-like flexibility PLUS relational guarantees. Best of both worlds - wasn't obvious until deep analysis.
```

---

## Advanced Techniques

### Technique 1: Principle-Guided Extended Thinking

**Explicitly invoke Hermetic Principles**:

```markdown
Extended thinking: Microservices vs Monolith

Analyze through Hermetic Principles:

**Mentalism**: Which requires clearer mental model?
**Correspondence**: Which mirrors our team structure better?
**Vibration**: Which enables faster iteration?
**Polarity**: How does each balance simplicity vs flexibility?
**Rhythm**: Which supports sustainable pace?
**Cause & Effect**: Second and third-order effects?
**Gender**: Which balances doing (features) with being (maintenance)?
```

**Result**: Decision aligns with values, not just technical factors

---

### Technique 2: Comparative Extended Thinking

**Analyze multiple past decisions** to extract meta-patterns:

```markdown
Extended thinking meta-analysis:

3 architecture decisions from past year:

**Decision 1**: Database (PostgreSQL vs MongoDB)
- Chose: PostgreSQL
- Outcome: Good ✅

**Decision 2**: Auth (JWT vs Sessions)
- Chose: JWT
- Outcome: Bad ❌ (revocation issues)

**Decision 3**: Caching (Redis vs Memcached)
- Chose: Redis
- Outcome: Good ✅

Questions:
1. What pattern distinguishes good from bad decisions?
2. What questions did we ask in good but not in bad?
3. What decision framework should we use going forward?
```

**Purpose**: Improve decision-making process itself

---

### Technique 3: Scenario Planning

**For high-uncertainty decisions**:

```markdown
Extended thinking: Build our own auth vs use Auth0?

**Scenarios to analyze**:

**Scenario A**: Grow to 1M users (10x target)
- Performance? What breaks? Recovery?

**Scenario B**: Security breach
- Easier to respond to? Liability? Recovery time?

**Scenario C**: Budget cuts 50%
- Can still afford managed? Maintain if self-built?

**Scenario D**: Regulatory change (HIPAA added)
- Which more adaptable? Compliance costs?

For each scenario + choice, analyze thoroughly.
```

**Result**: Robust decision across multiple futures

---

## Quick Start

### First Time Using Extended Thinking

**Start small** - Pick one decision this week:

1. **Identify critical decision** (will be hard to reverse)
2. **Frame problem** using Stage 1 template (5 min)
3. **Request extended thinking** (paste into Claude Code)
4. **Document in ADR** immediately (15 min)
5. **Extract to MOC** (5 min)

**Total time**: 30 min upfront investment

**Saved**: Potentially weeks of reversal work later

---

## Success Metrics

### You're using Extended Thinking well when:

**Qualitative**:
- ✅ Fewer regretted decisions (track in ADRs)
- ✅ Team confident in major choices
- ✅ Clear documentation of why (future team understands)
- ✅ Principles explicitly considered
- ✅ Mistakes turned into wisdom (post-mortems)

**Quantitative**:
- ✅ Architecture reversals: Decrease over time
- ✅ ADR quality: More comprehensive reasoning
- ✅ Decision confidence: Survey team 1-10 scale
- ✅ Time to decision: Upfront longer, total shorter (including reversals)

---

## Troubleshooting

### Issue: "Extended thinking takes too long"

**Reality check**:
- Extended thinking: 90 minutes upfront
- Reversal if wrong: 4+ weeks

**ROI**: 90 min to save 4 weeks = 270x return

**Action**: Track time saved from avoided reversals

---

### Issue: "Not sure when to use it"

**Trigger checklist** - Use extended thinking if **2+ are true**:
- [ ] Hard to reverse (>2 weeks)
- [ ] Security implications
- [ ] Affects >3 teams
- [ ] >$10K cost impact
- [ ] Ethical considerations
- [ ] Long-term strategic (>6 months impact)

---

### Issue: "Team doesn't read ADRs"

**Problem**: Documentation created but not used

**Solutions**:
- Link ADRs from code comments: `// See ADR-015 for why PostgreSQL`
- Reference in PR descriptions: "Implements ADR-015"
- Review ADRs in Sprint Integration
- Add ADRs to onboarding checklist

**Make ADRs visible** in workflow, not buried

---

## Quick Reference

### Invocation Methods

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

### 5-Stage Workflow

1. **Frame problem** (3-5 min) - Use template
2. **Request extended thinking** (1 min) - Paste or /illuminate
3. **Receive deep analysis** (Claude provides)
4. **Document in ADR** (15 min) - Immediately
5. **Extract wisdom** (10 min) - MOC, Layer 3, Anki

### When to Use

**Triggers** (2+ = use extended thinking):
- Hard to reverse (>2 weeks)
- Security implications
- Affects >3 teams
- >$10K cost
- Ethical considerations
- Long-term strategic

---

**For complete guide, see**: `.hermetic/docs/extended-thinking-guide.md`

**For ADR template, see**: `.hermetic/docs/architecture-decision-records.md`

**May your decisions be deliberate. May your thinking be deep. May your wisdom grow.**
