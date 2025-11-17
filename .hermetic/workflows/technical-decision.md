# Technical Decision Making Workflow

**Purpose**: Make complex technical decisions confidently using systematic analysis and Hermetic principles

**Hermetic Principles**: Mentalism, Cause-Effect, Polarity, Gender

**Estimated Time**: 1-4 hours (varies by decision complexity)

**Prerequisites**:
- Decision needs to be made
- Stakeholders identified
- Consequences matter (not trivial choice)

---

## Philosophy

**Technical decisions shape the future**. Choosing wrong can cost months of rework; choosing right accelerates for years.

This workflow uses:
1. **Mentalism**: Clear thinking before deciding
2. **Cause-Effect**: Trace consequences thoroughly
3. **Polarity**: Balance opposing forces
4. **Gender**: Combine analysis (masculine) with intuition (feminine)

**"It's not about making the perfect decision. It's about making a decision perfectly."** - Hermetic wisdom

---

## When to Use This Workflow

**Use for decisions that are**:
- **High Impact**: Affects architecture, team, or timeline significantly
- **Hard to Reverse**: Changing later is expensive
- **Uncertain**: Multiple viable options, not obvious

**Examples**:
- Technology choice (React vs Vue, SQL vs NoSQL)
- Build vs Buy (custom vs third-party)
- Approach (monolith vs microservices)
- Platform (AWS vs GCP vs Azure)
- Pricing model (free vs paid vs freemium)

**Don't use for**:
- Trivial choices (formatting style)
- Obvious decisions (fix critical bugs)
- Already-committed decisions (post-hoc rationalization)

---

## Phase 1: Framing (15-30 min)

### Step 1: Define the Decision Clearly (Mentalism)

**Vague decisions lead to vague outcomes**.

**Bad decision statements**:
- "What should we use for the backend?"
- "How should we handle this?"
- "What's the best approach?"

**Good decision statements**:
- "Should we use PostgreSQL or MongoDB for our blog CMS's database?"
- "Should we build a custom recommendation engine or use a third-party service?"
- "Should we deploy on AWS Lambda (serverless) or EC2 (traditional servers)?"

**Template**:
```markdown
# Decision: [Clear Statement]

**Context**: [What led to this decision point?]

**Timeline**: [When do we need to decide by?]

**Irreversibility**: [How hard is it to change later?]
- Easy (can change anytime)
- Moderate (can change but with cost)
- Difficult (very expensive to change)
- Permanent (effectively irreversible)

**Impact**: [Who/what is affected?]
- Team
- Users
- Timeline
- Budget
- Future flexibility
```

**Command**: `/gnosis "Frame this decision: [your decision]"`

**Example**:
```
/gnosis "We need to choose between PostgreSQL and MongoDB for our
blog CMS database. What factors should guide this decision?"
```

**Log usage**:
```bash
hm cmd gnosis "decision: database choice"
```

---

### Step 2: Identify Stakeholders (Correspondence)

**Who cares about this decision?**

**Stakeholders**:
- **Developers** (maintainability, familiarity)
- **Users** (performance, features)
- **Business** (cost, time-to-market)
- **Operations** (reliability, support)
- **Security** (data protection)

**For each stakeholder**:
- What do they value?
- What are their constraints?
- How does this decision affect them?

**Example**:
```markdown
## Stakeholders

**Developer (me)**:
- Values: Productivity, learning, maintainability
- Constraint: Solo developer, limited time
- Impact: Need to learn and maintain whatever we choose

**Users**:
- Values: Fast performance, reliability
- Constraint: None directly
- Impact: Choice affects their experience

**Business**:
- Values: Low cost, fast delivery
- Constraint: Budget, timeline
- Impact: Affects hosting costs and development speed

**Future Team**:
- Values: Common technologies, good documentation
- Constraint: May hire in future
- Impact: Obscure tech is harder to hire for
```

---

### Step 3: List Options (Vibration)

**Identify all viable options** (don't prematurely eliminate).

**Brainstorm**:
- Obvious choices
- Less obvious but valid
- Hybrid approaches
- "Do nothing" (always an option)

**For database decision example**:
```markdown
## Options

1. **PostgreSQL** (Relational)
2. **MongoDB** (Document store)
3. **SQLite** (Embedded relational)
4. **Hybrid** (PostgreSQL + Redis for caching)
5. **Hosted Service** (Firebase, Supabase, etc.)
6. **Delay Decision** (Use file storage temporarily)
```

**Minimum**: 2 options (if only 1, no decision needed)
**Maximum**: 5 options (more becomes analysis paralysis)

**Agent**: Relevant domain expert

```
"database-architect, what are the viable database options for a
blogging CMS with these requirements: [requirements]?"
```

**Log usage**:
```bash
hm agent database-architect "decision: options"
```

---

## Phase 2: Analysis (1-2 hours)

### Step 4: Define Criteria (Mentalism + Polarity)

**What matters for this decision?**

**Common criteria**:
- **Cost** (development + operational)
- **Time** (how long to implement)
- **Performance** (speed, scale)
- **Maintainability** (easy to change/fix)
- **Familiarity** (team knows it)
- **Community** (support, libraries)
- **Risk** (unknown unknowns)
- **Flexibility** (future needs)

**Weight them** (not everything is equally important):
- **Critical** (deal-breaker if missing)
- **Important** (significant factor)
- **Nice-to-have** (tiebreaker)

**Example**:
```markdown
## Decision Criteria

### Critical
1. **Time-to-implement**: Must ship in 4 weeks
2. **Cost**: Must stay under $100/month
3. **Solo maintainable**: I'm the only developer

### Important
4. **Performance**: Sub-second page loads
5. **Scalability**: Handle 100K users eventually

### Nice-to-have
6. **Familiarity**: Nice if I know it already
7. **Flexibility**: Easy to add features
```

---

### Step 5: Evaluate Each Option (Cause-Effect)

**Score each option against criteria**.

**Evaluation matrix**:

|Criterion (Weight)|PostgreSQL|MongoDB|SQLite|Hybrid|Hosted|
|------------------|----------|-------|------|------|------|
|Time (Critical)   | 3        | 3     | 5    | 2    | 5    |
|Cost (Critical)   | 4        | 4     | 5    | 3    | 3    |
|Maintainable (Critical)| 4   | 3     | 5    | 2    | 5    |
|Performance (Important)| 4   | 4     | 3    | 5    | 4    |
|Scalability (Important)| 4   | 5     | 2    | 4    | 5    |
|Familiarity (Nice)| 5        | 2     | 4    | 4    | 3    |
|Flexibility (Nice)| 4        | 5     | 3    | 4    | 3    |

**Scoring**: 1 (poor) to 5 (excellent)

**Calculate weighted scores**:
```
Critical criteria: If any score < 3, eliminate option
Important criteria: Weight 2x
Nice-to-have: Weight 1x

Example for PostgreSQL:
Critical: 3+4+4 = 11 (all ≥3, passes)
Important: (4+4) * 2 = 16
Nice: 5+4 = 9
Total: 36
```

---

### Step 6: Analyze Trade-offs (Polarity)

**Every choice sacrifices something**.

**For each option**:
- What do you gain?
- What do you lose?
- What's the biggest risk?

**Example for PostgreSQL**:
```markdown
## PostgreSQL Analysis

### Pros
+ Familiar (I know SQL well)
+ Mature (battle-tested, stable)
+ ACID guarantees (data integrity)
+ Rich ecosystem (ORMs, tools)
+ Good performance for relational data

### Cons
- More setup than hosted options
- Slightly slower for document-style queries
- Need to manage backups/migrations
- Schema changes require migrations

### Biggest Risk
Learning curve for advanced PostgreSQL features
might slow development if needed.

### When This Choice Fails
If we need extremely high write throughput or
document-style flexibility becomes critical.
```

**Repeat for all options**.

**Agent**: `backend-architect`

```
"backend-architect, analyze the trade-offs between PostgreSQL
and MongoDB for a blogging CMS"
```

---

### Step 7: Consider Consequences (Cause-Effect)

**Trace downstream effects**.

**Questions**:
1. **6 months from now**: What's easier? What's harder?
2. **If we 10x scale**: Does this still work?
3. **If we need to change**: How painful?
4. **If we hire someone**: Can they learn this?
5. **If this goes wrong**: What happens?

**Consequence mapping**:
```markdown
## Consequences: PostgreSQL

### Short-term (1-3 months)
+ Faster development (I know it)
+ More time learning business logic, less on DB
- Some setup time for backups, migrations

### Medium-term (6-12 months)
+ Easy to hire developers (common skill)
+ Mature tooling for analytics, reporting
- Schema changes require care as data grows

### Long-term (1-2 years)
+ Proven scalability path (read replicas, etc.)
+ Can migrate to distributed PostgreSQL if needed
- Locked into relational model (costly to change)

### Failure Modes
**If performance becomes issue**: Add caching (Redis)
**If schema too rigid**: Can use JSONB columns for flexibility
**If need document model**: Could migrate but expensive
**If costs too high**: Optimize queries, add read replicas

### Success Indicators
Data integrity maintained, queries fast,
easy to add features, team can maintain
```

---

## Phase 3: Decision (30 min - 1 hour)

### Step 8: Apply Hermetic Principles (All Principles)

**Filter through wisdom**.

**Principle Checks**:

**Mentalism** (Clear Thinking):
- Do I deeply understand each option?
- Are my mental models accurate?
- Am I rationalizing a pre-decided choice?

**Correspondence** (As Above, So Below):
- Does this match our values/culture?
- Does this scale to our aspirations?
- Is the choice consistent with other decisions?

**Vibration** (Move Forward):
- Will this enable shipping quickly?
- Can we iterate and learn?
- Or will this cause analysis paralysis?

**Polarity** (Balance Opposites):
- Have I balanced short-term and long-term?
- Familiar vs optimal?
- Cost vs quality?

**Rhythm** (Sustainable):
- Can we maintain this long-term?
- Will this cause operational burden?
- Does it fit our development rhythm?

**Cause-Effect** (Consequences):
- Have I traced downstream effects?
- What are second-order consequences?
- What feedback loops exist?

**Gender** (Masculine + Feminine):
- Analysis (M): Have I analyzed rationally?
- Intuition (F): What does my gut say?
- Both aligned or in conflict?

**Command**: `/illuminate "Help me make this decision with full clarity"`

**Use when**: Decision is critical and you want maximum wisdom applied.

---

### Step 9: Make the Decision (Vibration + Gender)

**Combine analysis with intuition**.

**Process**:
1. **Review scores**: Which option ranks highest?
2. **Check gut feeling**: Does this feel right?
3. **If aligned**: Decide confidently
4. **If misaligned**: Dig deeper (why does gut disagree with analysis?)

**Decision matrix**:
```
     │ Analysis Says A │ Analysis Says B
─────┼─────────────────┼────────────────
Gut  │                 │
Says A│  ✓ Decide A    │  Investigate
─────┼─────────────────┼────────────────
Gut  │                 │
Says B│  Investigate   │  ✓ Decide B
```

**If conflict** (gut disagrees with analysis):
- What information is gut using that analysis missed?
- Is gut biased (fear, familiarity)?
- Can you reconcile both perspectives?

**Our example**:
```markdown
## Decision: PostgreSQL

**Analysis**: PostgreSQL scores 36, highest of all options
**Gut feeling**: Comfortable with this, feels right
**Alignment**: Yes - both point to PostgreSQL

**Rationale**:
- Familiar, so faster development (critical constraint)
- Proven scalability path (important for future)
- Mature ecosystem (reduces risk)
- Acceptable trade-offs (schema changes manageable)

**Decided**: Use PostgreSQL for blog CMS database

**Confidence**: 8/10 (high but not absolute - nothing is)
```

---

### Step 10: Document the Decision (Mentalism)

**Record it before you forget why**.

**Architecture Decision Record** (ADR):

```markdown
# ADR-003: Use PostgreSQL for Blog CMS Database

**Date**: 2025-10-29
**Status**: Accepted
**Deciders**: [Your name]

## Context

Building a blogging CMS with constraints:
- 4-week timeline
- $100/month budget
- Solo developer
- Need to scale to 100K users

Need to choose a database that balances
time-to-market with future scalability.

## Decision

Use PostgreSQL as the primary database.

## Rationale

**Evaluation against criteria**:
- Time: Fast (familiar tech) ✓
- Cost: Low (< $50/month) ✓
- Maintainability: High (I know it well) ✓
- Performance: Good (sub-second queries) ✓
- Scalability: Proven (read replicas, etc.) ✓

**Compared to alternatives**:
- MongoDB: Less familiar, schema flexibility not needed
- SQLite: Doesn't scale to 100K users
- Hosted (Firebase): Higher cost long-term, vendor lock-in

## Consequences

**Positive**:
- Faster development (no learning curve)
- Data integrity (ACID transactions)
- Mature tooling (ORMs, admin tools, monitoring)
- Easy to hire for (common skill)
- Proven scalability path

**Negative**:
- Schema changes require migrations
- Less flexible than document stores
- More operational overhead than hosted solutions

**Mitigation**:
- Use JSONB for semi-structured data
- Plan migrations carefully
- Set up automated backups from start

## Alternatives Considered

1. **MongoDB**: More flexible schema, but unfamiliar
2. **SQLite**: Simplest option, but won't scale
3. **Hosted (Supabase)**: Easiest, but long-term cost concerns
4. **Hybrid (PostgreSQL + Redis)**: Over-engineering for v1

## Review Date

6 months (April 2026) - Evaluate if choice still serving us

## Success Criteria

- Schema changes manageable
- Query performance acceptable (<500ms P95)
- Cost under $50/month at 10K users
- No data integrity issues
```

---

## Phase 4: Communication & Execution (15-30 min)

### Step 11: Communicate the Decision (Correspondence)

**If team decision**, share the rationale.

**Communication template**:
```
Subject: Decision: Database Choice - PostgreSQL

Team,

Decision: We're using PostgreSQL for the blog CMS database.

Why:
- We need to ship in 4 weeks (familiar tech fastest)
- Proven scalability to our 100K target
- Best balance of cost, performance, maintainability

What this means:
- Schema design upfront (migrations later are slower)
- ACID guarantees (data integrity)
- Rich SQL querying (complex reports easy)

Alternative considered:
MongoDB was close, but PostgreSQL's familiarity and maturity won.

Questions/concerns? Let's discuss.

Full ADR: [link to document]
```

**Solo**: Still document publicly (GitHub, docs) for future team/contributors.

---

### Step 12: Act on the Decision (Vibration)

**Decide, then do**.

**Action items**:
- [ ] Update architecture docs
- [ ] Set up PostgreSQL (dev, staging, production)
- [ ] Configure backups
- [ ] Create initial schema
- [ ] Update project timeline if needed

**Agent**: Domain-specific for implementation

```
"database-architect, help me set up PostgreSQL for production
with proper backups, monitoring, and security"
```

**Log usage**:
```bash
hm agent database-architect "decision: implementation"
```

**Don't**:
- Second-guess the decision immediately
- Relitigate after committing
- Half-commit (hedging bets)

**Trust the process**.

---

## Success Metrics

**Good Decision Indicators**:
- [ ] Team understands the rationale
- [ ] Consequences anticipated accurately
- [ ] No major surprises in first 3 months
- [ ] Would make same decision again with same information
- [ ] Stakeholders satisfied

**Warning Signs** (review decision if):
- Immediate regret (day 1)
- Unforeseen consequences (week 1)
- Better information surfaces (month 1)
- Context changes dramatically (anytime)

**Decision quality** ≠ Outcome quality
- Good decision can have bad luck
- Bad decision can have good luck
- Judge decision by process + information available at time

---

## Common Pitfalls

### ❌ Analysis Paralysis
**Symptom**: Weeks of analysis, no decision
**Consequence**: Opportunity cost, delayed progress
**Fix**: Set decision deadline, use "good enough" not "perfect"

### ❌ Deciding Too Fast
**Symptom**: First option chosen without analysis
**Consequence**: Miss better alternatives, unforeseen consequences
**Fix**: Force yourself to evaluate at least 2-3 options

### ❌ Sunk Cost Fallacy
**Symptom**: "We've already invested so much in X..."
**Consequence**: Continue with wrong choice
**Fix**: Evaluate based on future consequences, not past investment

### ❌ Groupthink
**Symptom**: Everyone agrees without debate
**Consequence**: Miss obvious issues
**Fix**: Assign "devil's advocate" to argue alternatives

### ❌ Resume-Driven
**Symptom**: Choosing trendy tech for learning/resume
**Consequence**: Wrong tool for the job
**Fix**: Optimize for solving the problem, not learning new tech

### ❌ Not Documenting
**Symptom**: Forget why decision was made
**Consequence**: Relitigate same decision later
**Fix**: Always write ADR, even for solo projects

---

## Decision Types & Adjustments

### Technology Selection
**Key criteria**: Familiarity, community, maturity, fit
**Timeline**: 1-4 hours
**Review**: 6 months after implementation

### Build vs Buy
**Key criteria**: Cost (total), time, customization needs, control
**Timeline**: 2-6 hours
**Review**: After implementation, quarterly

### Architectural Approach
**Key criteria**: Scalability, complexity, team size, timeline
**Timeline**: 4-8 hours
**Review**: Before major scaling events

### Pricing Model
**Key criteria**: User value, competitor pricing, costs, growth
**Timeline**: 4-12 hours
**Review**: Quarterly, after user feedback

### Platform/Hosting
**Key criteria**: Cost, performance, ease of use, lock-in
**Timeline**: 2-4 hours
**Review**: Annually

---

## Quick Decision Framework (30 min)

For **smaller** decisions, use abbreviated process:

**1. Frame** (5 min):
```
Decision: [One sentence]
Deadline: [When]
Impact: [Low/Medium/High]
```

**2. Options** (5 min):
```
A: [Option] - Pros: [...] Cons: [...]
B: [Option] - Pros: [...] Cons: [...]
```

**3. Criteria** (5 min):
```
Most important: [Criterion]
Secondary: [Criterion]
```

**4. Decide** (5 min):
```
Choice: [A or B]
Why: [One paragraph]
Risk: [Biggest concern]
```

**5. Document** (10 min):
```
Brief ADR or note in project docs
```

---

## Effectiveness Tracking

**After making decision**:

```bash
hm rate workflow technical-decision 5
hm rate agent [agents-consulted] 5
hm cmd illuminate "decision: [topic]"
```

**Track over time**:
- Decision confidence (at time of decision)
- Outcome satisfaction (3 months later)
- Would you decide same again?
- Unforeseen consequences

**Review quarterly**:
- Which decisions aged well?
- Which decisions need revisiting?
- What patterns in good vs bad decisions?

---

## Integration with Other Workflows

**Feeds into**:
- `architecture-design.md` - Architectural decisions
- `sprint-planning.md` - Tool choices affect timelines
- `new-project-setup.md` - Technology stack decisions

**Draws from**:
- `/gnosis` - Deep understanding
- `/illuminate` - Ultimate clarity for critical decisions
- `/align` - Ethical alignment check

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Mentalism, Cause-Effect, Polarity, Gender
**Effectiveness**: Track with `hm rate workflow technical-decision <1-5>`

*"Decide with wisdom, execute with confidence, review with humility."*
