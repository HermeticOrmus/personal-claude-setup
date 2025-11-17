# Sprint Planning Workflow (6-Day Cycle)

**Purpose**: Plan sustainable, productive 6-day development sprints aligned with Hermetic principles and natural rhythm

**Hermetic Principles**: Rhythm, Vibration, Mentalism, Cause-Effect, Polarity

**Estimated Time**: 2-4 hours (Day 0 or Day 7 of previous sprint)

**Prerequisites**:
- Project vision/goals clear
- Backlog of potential work
- Understanding of team capacity
- Commitment to Day 7 rest

---

## Philosophy

The Hermetic system uses **6-day development cycles** (not traditional 2-week sprints) because:

1. **Rhythm**: One week fits natural human rhythm
2. **Vibration**: Ship weekly for faster learning
3. **Rest**: Day 7 sacred for integration and reflection
4. **Focus**: 6 days forces ruthless prioritization
5. **Sustainability**: Weekly shipping rhythm is maintainable long-term

**"Ship weekly, learn constantly, rest religiously"**

---

## Pre-Planning: Day 7 Reflection (30 min)

### Before planning next sprint, integrate last sprint

**Command**: `hm sabbath`

**Reflection questions**:
1. **What did we ship?** (Concrete outcomes)
2. **What did we learn?** (Insights gained)
3. **What worked well?** (Keep doing)
4. **What didn't work?** (Stop doing)
5. **What blocked us?** (Remove obstacles)
6. **Are we sustainable?** (Burnout check)

**Agent**: `analytics-reporter`

```
"analytics-reporter, analyze the past sprint's metrics.
What patterns emerged? Where did we spend time?"
```

**Log usage**:
```bash
hm agent analytics-reporter "sprint-planning: retrospective"
```

**Deliverable**: Clear lessons from last sprint to apply to next

---

## Phase 1: Intention & Alignment (30-60 min)

### Step 1: Clarify Sprint Goal (Mentalism)

**Every sprint needs ONE clear goal**. Not ten goals. ONE.

**Bad goals** (too vague):
- "Make progress on the app"
- "Fix bugs and add features"
- "Improve the product"

**Good goals** (specific, measurable):
- "Users can create and share projects"
- "API handles 10x current load"
- "Onboarding flow reduces drop-off by 50%"

**Command**: `/gnosis "What's the ONE thing that would make next week valuable?"`

**Example**:
```
/gnosis "We have authentication, project creation, and sharing on the backlog.
Which ONE should we focus on this sprint for maximum user value?"
```

**Log usage**:
```bash
hm cmd gnosis "sprint-planning: goal setting"
```

**Sprint Goal Template**:
```markdown
# Sprint [N] Goal

**Primary Goal**: [One clear outcome]

**Why This Matters**: [Impact on users/business]

**Success Criteria**:
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]
- [ ] [Measurable outcome 3]

**Not in This Sprint** (explicitly exclude):
- [Feature X] - important but not this week
- [Feature Y] - will do after this goal
```

---

### Step 2: Alignment Check (Gold Hat + Cause-Effect)

**Before committing, verify alignment**.

**Command**: `/align`

**Questions**:
1. **Does this serve genuine user need?** (Not vanity metrics)
2. **Is this the right priority?** (Highest value work)
3. **Is 6 days realistic?** (Or are we setting up failure)
4. **Does this advance our vision?** (Not random feature)
5. **Are we empowering or extracting?** (Gold Hat check)

**Agent**: `sprint-prioritizer`

```
"sprint-prioritizer, help prioritize these features for the next
6-day sprint: [list features]. Consider user value, technical risk,
and dependencies."
```

**Log usage**:
```bash
hm agent sprint-prioritizer "sprint-planning: prioritization"
```

**Red flags** (reconsider if true):
- Goal is vague or has multiple conflicting outcomes
- Team doesn't understand why this matters
- Technical unknowns make estimation impossible
- Requires working >8 hours/day to complete
- Violates Gold Hat principles

---

## Phase 2: Scope & Breakdown (1-2 hours)

### Step 3: Break Down into Tasks (Correspondence)

**Large goal → small, concrete tasks**.

**Task breakdown principles**:
- **Specific**: Clear what "done" means
- **Sized**: 2-6 hours max per task
- **Testable**: Can verify completion
- **Independent**: Can work on in any order (mostly)
- **Valuable**: Each task contributes to goal

**Example goal**: "Users can create and share projects"

**Task breakdown**:
```markdown
## Sprint Tasks

### Day 1-2: Project Creation
- [ ] Design project data model (2h)
- [ ] Create project API endpoints (4h)
- [ ] Write API tests (2h)
- [ ] Build project creation UI (4h)
- [ ] Connect UI to API (2h)

### Day 3-4: Sharing Functionality
- [ ] Design share permissions model (2h)
- [ ] Implement share API (4h)
- [ ] Add share UI to project page (3h)
- [ ] Test sharing flow end-to-end (2h)

### Day 5: Polish & Edge Cases
- [ ] Error handling for edge cases (3h)
- [ ] Loading states and feedback (2h)
- [ ] Cross-browser testing (2h)

### Day 6: Integration & Deployment
- [ ] Code review and fixes (3h)
- [ ] Integration testing (2h)
- [ ] Deploy to production (1h)
- [ ] Monitor and verify (2h)
```

**Agent**: Domain-specific agent

```
"backend-architect, help me break down this feature 'users can
create and share projects' into specific tasks for a 6-day sprint"
```

**Log usage**:
```bash
hm agent backend-architect "sprint-planning: task breakdown"
```

---

### Step 4: Estimate & Capacity Check (Cause-Effect + Polarity)

**Estimate honestly**, then buffer.

**Estimation approach**:

**Individual task estimates**:
- Best case: How long if everything goes perfectly
- Likely case: How long it will probably take
- Worst case: How long if problems arise

**Use likely case**, buffer at sprint level.

**Capacity calculation**:
```
Available days: 6
Hours per day: 6 (not 8! Leave buffer for meetings, interruptions)
Total capacity: 36 hours

Estimated work: [sum of all task estimates]

Buffer: 20-30% for unknowns

Safe commitment: Capacity * 0.7 = ~25 hours of planned work
```

**Principle of Polarity**: Balance ambition (Vibration - ship lots) with realism (Rhythm - sustainable pace).

**If estimates exceed capacity**:
1. **Cut scope** (preferred - narrow the goal)
2. **Simplify tasks** (MVP version)
3. **Split sprint** (goal spans 2 sprints)
4. **Don't**: Add more hours (violates Rhythm, causes burnout)

---

### Step 5: Identify Risks & Dependencies (Cause-Effect)

**What could block us?**

**Risk categories**:

**Technical Risks**:
- Unfamiliar technology
- Performance unknowns
- Integration complexity
- Infrastructure dependencies

**External Dependencies**:
- Waiting on others (design, API, approval)
- Third-party services
- Data availability

**Team Risks**:
- Key person on vacation
- Multiple people need same expertise
- Context switching between projects

**Mitigation strategies**:
```markdown
## Risks & Mitigation

**Risk**: Database schema changes might be complex
**Impact**: Could delay Days 1-2
**Mitigation**: Spike on Day 1 morning, adjust plan if needed

**Risk**: Waiting on design assets for sharing UI
**Impact**: Blocks Day 3
**Mitigation**: Get designs by end of Day 2, have fallback simple UI

**Risk**: Production deployment might have issues
**Impact**: Could consume all of Day 6
**Mitigation**: Deploy to staging on Day 5, have rollback plan
```

---

## Phase 3: Daily Structure (30 min)

### Step 6: Design Daily Rhythm (Rhythm)

**Map tasks to days** with buffer.

**Daily rhythm template**:
```markdown
# Sprint [N] Schedule

## Day 1 (Monday): Foundation
**Theme**: Setup & Core Structure
**Tasks**:
- [Task 1] (2h)
- [Task 2] (4h)
**Goal**: Foundation in place
**Buffer**: 2h for unknowns

## Day 2 (Tuesday): Building
**Theme**: Core Implementation
**Tasks**:
- [Task 3] (3h)
- [Task 4] (3h)
**Goal**: Main features working
**Buffer**: 2h

## Day 3 (Wednesday): Integration
**Theme**: Connect the Pieces
**Tasks**:
- [Task 5] (4h)
- [Task 6] (2h)
**Goal**: End-to-end flow works
**Buffer**: 2h

## Day 4 (Thursday): Enhancement
**Theme**: Polish & Edge Cases
**Tasks**:
- [Task 7] (3h)
- [Task 8] (3h)
**Goal**: Production-ready quality
**Buffer**: 2h

## Day 5 (Friday): Testing & Fixes
**Theme**: Verification & Refinement
**Tasks**:
- [Task 9] (3h)
- [Task 10] (2h)
**Goal**: All tests passing, bugs fixed
**Buffer**: 3h for bug fixes

## Day 6 (Saturday): Ship
**Theme**: Deploy & Monitor
**Tasks**:
- Code review (2h)
- Deployment (2h)
- Monitoring & verification (2h)
**Goal**: Live in production, stable
**Buffer**: 2h for issues

## Day 7 (Sunday): REST
**No work**. Integrate, reflect, celebrate.
```

**Key principles**:
- Early days: Foundation and building
- Middle days: Integration and core value
- Late days: Polish and deployment
- Last day: Ship and verify
- Day 7: Sacred rest (non-negotiable)

---

## Phase 4: Commitment & Communication (30 min)

### Step 7: Team Alignment (Correspondence)

**If team sprint**, get everyone aligned.

**Sprint kickoff meeting** (30 min max):
1. **Share sprint goal** (5 min) - Why this matters
2. **Review task breakdown** (10 min) - What we're building
3. **Identify dependencies** (5 min) - Who needs what from whom
4. **Clarify questions** (5 min) - Remove ambiguity
5. **Commit** (5 min) - Team agrees this is realistic

**Solo sprint**: Still write this down for clarity.

**Document the plan**:
```markdown
# Sprint [N] Plan

**Dates**: [Start] - [End]

**Sprint Goal**: [One clear outcome]

**Success Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Not in This Sprint**:
- [Explicitly excluded items]

**Task Breakdown**: [Link to detailed task list]

**Daily Goals**: [Link to day-by-day plan]

**Risks**: [Key risks and mitigations]

**Team Capacity**: [Hours available]

**Committed Work**: [Hours estimated]

**Buffer**: [Percentage for unknowns]
```

---

### Step 8: Set Up Tracking (Vibration)

**Make progress visible**.

**Tracking mechanisms**:

**Simple** (solo or small team):
- Markdown checklist in project
- GitHub/GitLab issues
- Notion, Trello, or similar

**Integrated** (with Hermetic system):
```bash
# Log sprint start
hm cmd sprint-planning "sprint-N: kickoff"

# Throughout sprint, log task completion
hm agent [agent-used] "sprint-N: [task-name]"

# Daily check
hm health
```

**Daily standup questions** (5 min, async or sync):
1. What did I complete yesterday?
2. What will I do today?
3. Any blockers?

**Agent**: `studio-producer` (for team coordination)

```
"studio-producer, help coordinate this 6-day sprint across
[team members] working on [project]"
```

---

## Phase 5: Execution & Adaptation (Days 1-6)

### Step 9: Follow Daily Development Workflow

**Each day** follows: `daily-development.md` workflow

**Sprint-specific additions**:

**Daily standup/check-in**:
```bash
# Morning
hm start-day
hm context

# Review: Are we on track for sprint goal?
# Adjust: If blocked or ahead, re-plan remaining days
```

**Mid-sprint check** (Day 3):
```
/align "Are we still on track for the sprint goal?
Should we adjust scope?"
```

**Agent**: `sprint-prioritizer` (if adjustments needed)

```
"sprint-prioritizer, we're behind schedule on Day 3.
Help me re-prioritize remaining work to still achieve
the core sprint goal."
```

---

### Step 10: Adapt to Reality (Polarity + Vibration)

**Plans change. That's okay.**

**When to adapt**:
- Discovered a blocker (remove or mitigate)
- Task took longer than expected (cut scope)
- Task was easier than expected (add stretch goal)
- New information changes priority (adjust)

**How to adapt**:
1. **Protect the goal**: Can we still achieve it with adjustments?
2. **Cut scope, don't add hours**: Work 6 hours/day, not 10
3. **Communicate**: If team, tell everyone about changes
4. **Document**: Update the plan so it reflects reality

**Don't adapt** (stick to the plan):
- Random new ideas (write down for future, not now)
- Scope creep from stakeholders (protect the sprint)
- Perfectionism (good enough is good enough)

---

## Phase 6: Sprint Completion (Day 6)

### Step 11: Verification & Deployment (Vibration)

**Day 6 is ship day**.

**Final checklist**:
- [ ] All success criteria met
- [ ] Tests passing
- [ ] Code reviewed
- [ ] No critical bugs
- [ ] Deployment successful
- [ ] Monitoring shows stability

**Command**: `/verify "Sprint goal achieved and stable in production"`

**If not ready to ship**:
- Ship reduced scope (MVP of the goal)
- Don't: Work all night (violates Rhythm)
- Don't: Skip Day 7 (sacred rest)

**Agent**: `project-shipper`

```
"project-shipper, help me deploy this sprint's work to production
and verify it's working correctly"
```

**Log usage**:
```bash
hm agent project-shipper "sprint-N: deployment"
```

---

### Step 12: Celebrate & Document (Rhythm)

**Shipped something? Celebrate.**

**Command**: `/celebrate "Sprint [N] complete - [achievement]!"`

**Example**:
```
/celebrate "Sprint 12 complete - users can now create and share projects!
First 10 users already sharing. Clean deployment, no issues."
```

**Document outcomes**:
```markdown
# Sprint [N] Results

**Goal**: [What we planned]

**Achieved**:
- [What we actually shipped]
- [Key metrics]

**Learned**:
- [Technical insights]
- [Process insights]
- [What surprised us]

**Carried Over** (if anything):
- [Tasks moved to next sprint with reason]

**Celebration**: [How we recognized the win]
```

**Log completion**:
```bash
hm close-day
hm rate workflow sprint-planning 5
```

---

## Phase 7: Integration (Day 7)

### Step 13: Sacred Rest (Rhythm - Non-Negotiable)

**Day 7 = NO WORK**.

**Command**: `hm sabbath`

**Activities** (choose what resonates):
- Physical rest
- Reflection on the week
- Time with loved ones
- Nature / outdoors
- Creative hobbies
- Spiritual practice
- Reading (non-technical)
- Nothing at all

**Don't**:
- Code
- Check work email
- "Quick fixes"
- Planning next sprint (wait until evening if needed)

**Why this matters**:
- **Rhythm**: Sustainable pace requires rest
- **Integration**: Learning consolidates during rest
- **Creativity**: Best ideas come when not forcing
- **Humanity**: You're a human, not a machine

---

## Success Metrics

**Immediate (End of Sprint)**:
- [ ] Sprint goal achieved (success criteria met)
- [ ] Work shipped to production
- [ ] Team not burned out
- [ ] No critical bugs in production
- [ ] Day 7 rest honored

**Process (Over Time)**:
- [ ] Consistently shipping weekly
- [ ] Estimates improving (getting more accurate)
- [ ] Buffer time decreasing (less unknown unknowns)
- [ ] Health scores staying 70+ (sustainable)
- [ ] Team morale high

**Business Impact**:
- [ ] User value delivered weekly
- [ ] Feedback loop fast (weekly shipping → weekly learning)
- [ ] Predictable delivery (stakeholders trust the rhythm)

---

## Common Pitfalls

### ❌ Too Much Scope
**Symptom**: Never completing sprint goals
**Consequence**: Demoralization, always "behind"
**Fix**: Cut scope aggressively, celebrate small wins

### ❌ No Clear Goal
**Symptom**: Sprint is "bucket of tasks"
**Consequence**: No focus, random work
**Fix**: ONE goal per sprint, ruthlessly prioritize

### ❌ Ignoring Day 7
**Symptom**: Working 7 days to "catch up"
**Consequence**: Burnout, poor decisions, health issues
**Fix**: Sacred rest non-negotiable, cut scope instead

### ❌ No Buffer
**Symptom**: Plans assume everything goes perfectly
**Consequence**: Always running late, stress
**Fix**: 20-30% buffer for unknowns

### ❌ Not Adapting
**Symptom**: Stick to original plan despite reality changing
**Consequence**: Miss sprint goal stubbornly
**Fix**: Adapt mid-sprint, protect goal not tasks

### ❌ Perfectionism
**Symptom**: Not shipping because "not perfect"
**Consequence**: Violates Vibration, slows learning
**Fix**: Ship MVP, iterate next sprint

---

## Sprint Types

### Feature Sprint
**Goal**: Ship new user-facing capability
**Focus**: User value, UX, end-to-end functionality
**Success**: Users can do something new

### Technical Sprint
**Goal**: Infrastructure, refactoring, technical debt
**Focus**: Code quality, performance, maintainability
**Success**: System healthier, faster, more maintainable

### Learning Sprint
**Goal**: Explore new technology, spike solution
**Focus**: Experiments, prototypes, proof-of-concept
**Success**: Decision made with confidence

### Bug Bash Sprint
**Goal**: Fix accumulated bugs
**Focus**: Quality, stability, user pain points
**Success**: Bug count reduced, stability improved

### Polish Sprint
**Goal**: UX improvements, edge cases, delight
**Focus**: Details, user experience, smoothness
**Success**: Product feels better, users notice

---

## Team vs Solo Sprints

### Solo Developer
**Advantages**:
- No coordination overhead
- Full focus time
- Quick decisions
- Flexible schedule

**Challenges**:
- No one to unblock you
- All skills must be yours
- Lonely
- Easy to skip process

**Adjustments**:
- Still write plan down (for future you)
- Still track progress (data is valuable)
- Find external accountability (community, mentor)
- Protect Day 7 extra carefully (no one else will)

### Team Sprint
**Advantages**:
- Complementary skills
- Peer unblocking
- Shared knowledge
- Social momentum

**Challenges**:
- Coordination overhead
- Dependencies can block
- Communication crucial
- Schedule alignment

**Adjustments**:
- Daily standup (5-15 min)
- Clear task ownership
- Explicit dependencies
- Over-communicate

**Agent**: `studio-producer` for team coordination

---

## Effectiveness Tracking

**After each sprint**:

```bash
# Rate the sprint planning process
hm rate workflow sprint-planning 5

# Rate agents used
hm rate agent sprint-prioritizer 4
hm rate agent backend-architect 5
hm rate agent project-shipper 5

# Log sprint completion
hm cmd celebrate "sprint-N: complete"
```

**Track over sprints**:
- Sprint goal achievement rate (target: 80%+)
- Estimate accuracy (actual vs planned hours)
- Carry-over rate (target: <20% of tasks)
- Team health score (target: 70+)
- Shipping consistency (every week?)

**Review monthly**:
```bash
python3 ~/.hermetic/intelligence/pattern-recognition.py
cat ~/.hermetic/intelligence/insights.md
```

**Optimize based on data**:
- Consistently over-estimating? Cut buffer
- Consistently under-estimating? Add buffer
- Always carrying over? Reduce scope
- Always finishing early? Increase ambition (slightly)

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Rhythm, Vibration, Mentalism, Cause-Effect, Polarity
**Effectiveness**: Track with `hm rate workflow sprint-planning <1-5>`

*"Plan with intention. Execute with focus. Ship with rhythm. Rest with discipline."*
