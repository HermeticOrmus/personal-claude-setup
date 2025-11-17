---
name: track-cognitive-load
description: Measure and manage cognitive load to sustain peak performance
category: development-tools
principle: Rhythm
---

# Track Cognitive Load - Sustainable Mental Performance

**Hermetic Principle**: Rhythm - "What you measure, you can sustain"

**When to use**: Daily (track sessions), Weekly (analyze patterns), When feeling overloaded

---

## Quick Concept

**Cognitive load** = Mental effort required to complete tasks

**The invisible bottleneck**: Code performance optimized, brain performance ignored

**Result**: Burnout, errors, unsustainable pace

**Solution**: Track load, manage capacity, work with brain (not against it)

---

## The Three-Tier Tracking System

### Tier 1: Real-Time Monitoring (Every 90 minutes)

**Quick mental check** (30 seconds):

```
Current time: [e.g., 10:30 AM]

Quick 4-question check:
1. Mental state? Clear / Foggy / Overwhelmed
2. Energy level? High / Medium / Low
3. Files open? [Count them]
4. Errors increasing? Yes / No
```

**If 2+ warning signs** (foggy, low energy, 10+ files, errors increasing):
→ **STOP and take action**

**Immediate actions**:
- [ ] Take 10-minute break (walk, water, stretch)
- [ ] Close unnecessary files (target 5 or less)
- [ ] Externalize thoughts (write mental state in dev docs Layer 3)
- [ ] Simplify current task (reduce scope)
- [ ] OR switch to lower-load task

**Purpose**: Catch overload EARLY (before it destroys productivity)

---

### Tier 2: Session Journal (End of each coding session)

**NASA-TLX Quick Assessment** (2 minutes):

Add to dev docs `progress-journal.md` Layer 3:

```markdown
## Cognitive Load - [Date] [Time]

### Quick Scores (1-10 scale)
- **Mental Demand**: 7/10 (complex security considerations)
- **Time Pressure**: 4/10 (no rush, well-planned)
- **Effort**: 8/10 (sustained concentration needed)
- **Frustration**: 3/10 (minor issues, quickly resolved)

**Total Score**: 22/40 (55% - Moderate-High)

### What Increased Load
⚠️ New territory (first JWT implementation)
⚠️ Security awareness (constant vigilance for vulnerabilities)

### What Reduced Load
✅ Clear plan (architecture decided beforehand)
✅ Good docs (Auth0 guides excellent)

### Adaptations Made
- Took break at 90 min (noticed focus dropping)
- Set DND on Slack (after 2nd interruption)
- Simplified scope (deferred refresh rotation)

### Tomorrow's Plan
- Start with warm-up task (unit tests)
- Deep focus 9-11 AM (most demanding work)
- Batch communications to 11-11:30 AM
```

**Metrics to track**:
- NASA-TLX scores (mental demand, time pressure, effort, frustration)
- Context switches (count them)
- Files open (indicator of complexity)
- Error rate (compile errors, test failures per hour)
- Interruptions (external, internal)

**Purpose**: Daily feedback loop (see what works, what doesn't)

---

### Tier 3: Weekly Pattern Analysis (End of week)

**Load Trend Table**:

```markdown
# Weekly Cognitive Load Analysis - Week of [Date]

| Day | Avg Load | Peak Load | Context Switches | Notes |
|-----|----------|-----------|------------------|-------|
| Mon | 45%      | 70%       | 6                | Fresh start |
| Tue | 55%      | 80%       | 9                | Complex feature |
| Wed | 65%      | 90%       | 17               | Too many meetings |
| Thu | 70%      | 85%       | 8                | Fatigue accumulating |
| Fri | 40%      | 60%       | 4                | Light refactoring |

**Observation**: Load accumulated through week, Wednesday critical (meeting overload)

## High-Load Tasks This Week
1. **Distributed tracing** (90% load)
   - Why high: New concept + unclear docs
   - Action next time: Pair program (share load)

2. **Database migration** (85% load)
   - Why high: Poor tooling, manual steps (high extraneous load)
   - Action: Automate migration (eliminate extraneous load)

## Load Reduction Wins
✅ Created snippet library (reduced boilerplate load)
✅ Documented patterns (team references instead of asking)
✅ Protected 9-11 AM blocks (40% more progress)

## Rhythm Violations
❌ Wednesday: 6 meetings, no focus blocks
❌ Thursday: Worked late compensating (unsustainable)

## Next Week Adjustments
- Move 3 Wednesday meetings to Tuesday PM
- High-load tasks in morning (9-11 AM)
- Add 30-min buffers between high-load tasks
- Keep Friday light (recovery + integration)
```

**Purpose**: Identify patterns, optimize schedule, prevent burnout

---

## The 4 Load Types

### Type 1: Intrinsic Load (Task Complexity)

**Definition**: Complexity inherent to the task itself

**Examples**:
- Learning new programming language
- Understanding complex algorithm
- Debugging race condition
- Architecting distributed system

**Can you eliminate it?** NO (task IS complex)

**Can you manage it?** YES:
- Break into smaller steps
- Pair program (share working memory)
- Schedule when energy high
- Build mental model first (reduce load when executing)

---

### Type 2: Extraneous Load (Presentation)

**Definition**: Mental effort from HOW information is presented

**Examples**:
- Poor documentation (forces guessing)
- Unclear variable names (`x`, `temp`, `data`)
- Disorganized file structure
- Missing code comments
- Complex build process

**Can you eliminate it?** YES! (This is where optimization happens)

**How to eliminate**:
- [ ] Write clear documentation
- [ ] Use descriptive names
- [ ] Organize files logically
- [ ] Comment the "why"
- [ ] Simplify processes

**ROI**: Massive - eliminates unnecessary mental friction

---

### Type 3: Germane Load (Learning)

**Definition**: Effort to build mental models and schemas

**Examples**:
- Creating mental map of codebase
- Understanding patterns
- Building abstractions
- Learning transferable concepts

**Can you eliminate it?** NO (and you don't want to!)

**This is actual learning** - the load you WANT

**How to maximize**:
- Extract patterns to MOCs
- Document mental models
- Create Anki cards for key insights
- Teach others (solidifies learning)

---

### Type 4: Context Switch Load (Interruptions)

**Definition**: Mental cost of switching between tasks

**Cost**:
- 23 minutes to regain focus after interruption
- 40% productivity loss
- Interrupted every 11 minutes (average developer)

**Examples**:
- Slack message during focus work
- Meeting in middle of coding session
- Switching between unrelated tasks
- Checking email frequently

**Can you eliminate it?** YES:
- [ ] Batch communications (check Slack at specific times)
- [ ] Protect focus blocks (90-120 min DND)
- [ ] Group similar tasks together
- [ ] Schedule meetings back-to-back (not scattered)

---

## Practical Workflows

### Workflow 1: Morning Planning (5 minutes)

**Before starting work**:

```markdown
## Today's Cognitive Load Budget

**Total capacity**: 100 points

### Task Load Estimation
- [ ] Implement JWT auth (70 points - HIGH)
- [ ] Write unit tests (20 points - LOW)
- [ ] Update documentation (10 points - LOW)

**Total planned**: 100 points ✅ (within budget)

### Energy-Matched Schedule
9:00-11:00 (HIGH energy): JWT auth (HIGH load) ✅ Match
11:00-12:00 (MEDIUM energy): Short break + buffer
13:00-14:00 (LOW energy): Update docs (LOW load) ✅ Match
14:00-16:00 (HIGH energy): Write tests (LOW-MED load) ✅ Match

### Protected Blocks
- 9:00-11:00 AM: DND on Slack, no meetings
- 2:00-4:00 PM: Focus block (tests + polish)

### Recovery Plan
- Break every 90 minutes (10 min walk)
- Lunch break: 60 minutes (full disconnect)
- End by 5 PM (no overtime)
```

**Result**: Matched load to energy, protected focus, sustainable pace

---

### Workflow 2: Mid-Session Check (90-minute intervals)

**Timer goes off** → Quick assessment:

```
Time: 10:30 AM (90 min into session)

1. Mental state? [Clear/Foggy/Overwhelmed]: Foggy
2. Energy? [High/Med/Low]: Medium (dropping)
3. Files open: 14 files 🚨 (too many)
4. Errors increasing? Yes 🚨 (3 in last 15 min)

**Status**: 🟠 High load (2+ warning signs)

**Action**:
1. ✅ Take 10-min break (walk outside)
2. ✅ Close 9 files (target: 5 files max)
3. ✅ Externalize thoughts (write current mental state)
4. ✅ Simplify task (defer edge cases to later)

[After break]
Time: 10:45 AM

1. Mental state: Clear ✅
2. Energy: Medium-High ✅
3. Files open: 5 ✅
4. Errors: None in 30 min ✅

**Status**: 🟢 Normal load - Continue
```

**Principle**: Detect early, act immediately (don't push through)

---

### Workflow 3: End-of-Day Journal (5 minutes)

**Add to `progress-journal.md` Layer 3**:

```markdown
## [Date] - Cognitive Load Analysis

### Session Overview
- Duration: 6 hours (9 AM - 5 PM with breaks)
- Task: JWT authentication implementation
- Completion: 80% (deferred refresh rotation)

### Load Scores
- Mental Demand: 7/10
- Time Pressure: 4/10
- Effort: 8/10
- Frustration: 3/10
- **Total**: 22/40 (55%)

### What Worked
✅ Morning deep focus (9-11 AM) - highest productivity
✅ Took break when foggy (caught overload early)
✅ Simplified scope (shipped core, deferred nice-to-have)

### What Didn't Work
❌ Too many files open initially (14 → confusion)
❌ Slack interruption at 10 AM (broke flow, took 20 min to recover)

### Insights for Layer 3
**🎯 Pattern**: Morning 9-11 AM consistently best for complex work
**⚠️ Gotcha**: Slack before 11 AM kills flow - keep DND until then
**💎 Breakthrough**: Externalizing thoughts to docs cleared mental fog instantly

### Tomorrow's Optimizations
- [ ] DND until 11 AM (protect morning flow)
- [ ] Start with 5 files max (close as I go)
- [ ] Schedule refresh token work for morning block
- [ ] Buffer time after lunch (energy dip expected)
```

**Purpose**: Daily learning loop, extract patterns to Layer 3

---

### Workflow 4: Weekly Review (15 minutes)

**Friday afternoon** or **Saturday morning**:

```markdown
# Week [Number] - Cognitive Load Review

## Load Trend
Average load: 53% ✅ (sustainable range: 50-60%)
Peak load: 85% 🟡 (Thursday - too high)

Trend: ⬆️ Accumulating through week (need Friday buffer)

## Context Switch Analysis
Total: 47 switches
Daily average: 9.4 switches
Worst day: Wednesday (17 switches - meeting hell)
Best day: Friday (4 switches - protected)

**Action**: Batch Wednesday meetings to Tuesday PM

## Energy Pattern Discovery
| Time Block | Energy Level | Best For |
|------------|--------------|----------|
| 9-11 AM    | Peak         | Complex architecture, new learning |
| 11-12 PM   | High         | Implementation, focused coding |
| 12-1 PM    | Lunch        | Full disconnect |
| 1-2 PM     | Low          | Documentation, code review |
| 2-4 PM     | High         | Testing, refactoring, polish |
| 4-5 PM     | Medium       | Planning, communication |

**Action**: Match task load to energy (already doing this well)

## Load Reduction Wins
This week I eliminated:
✅ 30 min/day (snippet library for boilerplate)
✅ 15 min/day (pattern documentation reduces questions)
✅ 45 min/day (protected focus blocks = less context switching)

**Total time saved**: 90 min/day = 7.5 hours/week 🎉

## Insights → MOC
Added to [[Cognitive Load Management MOC]]:
- [[My Peak Performance Windows]] - 9-11 AM confirmed
- [[Meeting Batch Strategy]] - Tuesday PM works best
- [[Focus Block Protection]] - DND until 11 AM non-negotiable

## Next Week Goals
1. Test Wednesday meeting batch (move 3 to Tuesday)
2. Add 30-min buffer after high-load tasks
3. Track recovery time needed (not just work time)
4. Experiment: Can I sustain 60% load without Friday dip?
```

**Purpose**: Continuous improvement, pattern extraction, sustainable optimization

---

## Load Reduction Strategies

### Strategy 1: Chunking Information

**Problem**: Too many discrete items (exceeds working memory limit of 4±1)

**Solution**: Group related items into chunks

**Before** (9 parameters - overload):
```javascript
function createUser(
  firstName, lastName, email, phone,
  street, city, state, zip,
  cardNumber
) { }
```

**After** (3 chunks - manageable):
```javascript
function createUser(personalInfo, address, payment) {
  // personalInfo = { firstName, lastName, email, phone }
  // address = { street, city, state, zip }
  // payment = { cardNumber }
}
```

**Load reduction**: 70% (9 items → 3 chunks)

---

### Strategy 2: Externalize Thoughts

**Problem**: Holding too much in working memory (mental juggling)

**Solution**: Write it down, free up mental space

**When foggy**, dump mental state:

```markdown
## Current Mental State (externalized at 10:35 AM)

**Trying to do**:
- Implement JWT refresh token rotation
- Ensure old tokens invalidated
- Store in database with version tracking

**What I know**:
- Access token: 15 min expiration
- Refresh token: 7 days
- Need atomic invalidation + new token issue

**Uncertain about**:
- Store all tokens or just current?
- Handle concurrent refresh requests how?

**Next action** (singular):
- Research Auth0's approach (15 min)
```

**Result**: Brain freed, can focus on single next action

---

### Strategy 3: Clear Naming

**Problem**: Unclear names require constant mental translation (extraneous load)

**Before** (high translation overhead):
```javascript
function p(u, o) {
  const t = o.i.reduce((a, i) => a + i.p * i.q, 0);
  const s = t * 0.08;
  return { u, f: t + s };
}
```

**After** (minimal translation):
```javascript
function processOrder(user, order) {
  const subtotal = order.items.reduce((sum, item) =>
    sum + item.price * item.quantity, 0
  );
  const tax = subtotal * 0.08;
  return { user, total: subtotal + tax };
}
```

**Load reduction**: 80% (reads like English)

---

### Strategy 4: Reduce Visual Noise

**Problem**: Too many files/tabs open (visual cognitive load)

**Solution**: Strict limits

**Rules**:
- Editor: Max 5 files open (current focus only)
- Browser: Max 3 tabs (docs only, no social media)
- Close Slack/email during focus blocks

**Before**: 23 files, can't find anything, constant scanning
**After**: 4 files, instant navigation, clear focus

**Load reduction**: 60%

---

### Strategy 5: Batch Context Switches

**Problem**: Constant interruptions (40% productivity loss)

**Solution**: Batch similar tasks, protect focus blocks

**Before**:
```
9:00 - Code
9:15 - Slack message
9:30 - Code
9:45 - Email
10:00 - Code
10:10 - Meeting
10:30 - Code
...constant switching
```

**After**:
```
9:00-11:00 - Deep focus (DND, no interruptions)
11:00-11:30 - Communication batch (Slack, email, quick calls)
11:30-1:00 - Focus block 2
1:00-2:00 - Lunch + buffer
2:00-4:00 - Focus block 3
4:00-4:30 - Communication batch 2
4:30-5:00 - Planning tomorrow
```

**Load reduction**: 50% (from context switching elimination)

---

## Integration with Dev Docs

### Layer 3: Extract Cognitive Insights

**As you discover patterns**, add to Layer 3:

```markdown
## ⚡ Layer 3: Critical Insights

### 🎯 Key Patterns
- **Morning peak**: 9-11 AM optimal for high-load tasks (tested 4 weeks)
- **Load accumulation**: Tue-Thu high load → Fri must be light (recovery)
- **File count indicator**: If >10 files open, architecture likely too coupled

### ⚠️ Gotchas
- **Pre-deep-work meetings destroy flow**: Even 30-min meeting before 11 AM kills productivity
- **Pushing through fatigue backfires**: 2 hours fatigued = 1 hour fresh (negative ROI)
- **Context switches compound**: 1st switch = 23 min recovery, 2nd switch = 35 min, 3rd = 45 min

### 💎 Breakthroughs
- **Externalizing thoughts**: Writing mental state clears fog in <5 min
- **Cognitive load journaling**: Shows fatigue 1 day early (can prevent burnout)
- **Energy-matched scheduling**: High-load tasks in morning = 2x throughput vs afternoon
```

---

### MOC: Link Cognitive Patterns

**Create/Update MOC**:

```markdown
# Cognitive Load Management MOC

## My Load Patterns
- [[Peak Performance Windows]] - 9-11 AM, 2-4 PM
- [[Load Triggers]] - Meetings, unclear requirements, legacy code
- [[Recovery Strategies]] - Walk, externalize thoughts, simplify scope

## Load Reduction Wins
- [[Snippet Library]] - Saved 30 min/day on boilerplate
- [[Pattern Documentation]] - Reduced team questions (15 min/day saved)
- [[Focus Block Protection]] - DND until 11 AM (45 min/day saved)

## Experiments
- ✅ [[Wednesday Meeting Batch]] - Moved to Tuesday, worked great
- 🔬 [[60% Sustained Load Test]] - Week 3 of experiment
- 💭 [[Pair Programming Load Split]] - Haven't tried yet

## Wisdom Extracted
**Key Insight**: "Cognitive load is invisible tax on every task. Measure it to manage it, manage it to sustain excellence."
```

---

### Spaced Repetition: Extract to Anki

**From Layer 3 gotchas** → Create Anki cards:

**Card 1**:
- Q: What's the cost of context switching for developers?
- A: 23 min to refocus, 40% productivity loss. Interrupted every 11 min on average.

**Card 2**:
- Q: What are the 4 types of cognitive load and which can you eliminate?
- A:
  1. Intrinsic (task complexity) - CAN'T eliminate, but can manage
  2. Extraneous (presentation) - CAN eliminate (high ROI)
  3. Germane (learning) - DON'T want to eliminate (this is learning)
  4. Context switch (interruptions) - CAN eliminate (protect focus blocks)

**Card 3**:
- Q: When cognitive load journal shows score >70%, what immediate actions?
- A:
  1. Take 10-min break
  2. Close files to <5
  3. Externalize thoughts (write mental state)
  4. Simplify scope
  5. Switch to lower-load task if needed

---

## Hermetic Principles Applied

### Rhythm - Sustainable Cognitive Pace

**Without tracking**:
- Work until exhausted
- Burnout inevitable
- Unsustainable

**With tracking**:
- Match load to energy
- Recover intentionally
- Sustain indefinitely

**Principle**: "Measure what matters (cognitive capacity), manage for sustainability"

---

### Mentalism - Mental Clarity → Code Quality

**Clear mind** → Clear code
**Foggy mind** → Foggy code

**Application**: Don't code when cognitively overloaded (creates technical debt)

**Practice**: Check mental state BEFORE starting high-load task

---

### Polarity - Balance Load Types

**Opposite forces**:
- High-load tasks ↔ Low-load recovery
- Deep focus ↔ Communication/collaboration
- Complexity ↔ Simplicity

**Balance**: Alternate throughout day/week

**Practice**: High-load morning, low-load afternoon

---

### Vibration - Iteration Over Perfection

**Perfectionism** → Cognitive overload (trying to optimize everything)
**Iteration** → Ship working version, learn, refine

**Application**: When load high, simplify scope (ship less, better)

---

## Quick Reference

### Daily Checklist
**Morning** (5 min):
- [ ] Plan cognitive budget (100 points)
- [ ] Match high-load → high-energy windows
- [ ] Protect focus blocks (DND)

**Every 90 min**:
- [ ] Mental state check (clear/foggy/overwhelmed?)
- [ ] If 2+ warnings → Take action (break/simplify/switch)

**Evening** (5 min):
- [ ] Journal NASA-TLX scores
- [ ] Extract insights to Layer 3
- [ ] Plan tomorrow's optimization

### Weekly Checklist
**Friday** (15 min):
- [ ] Analyze load trend (sustainable average?)
- [ ] Count context switches (reduce next week?)
- [ ] Extract patterns to MOC
- [ ] Plan next week adjustments

### Warning Signals
- 🟢 **Normal** (0-60%): Sustainable, productive
- 🟡 **Elevated** (60-70%): Monitor closely, take breaks
- 🟠 **High** (70-85%): Immediate action (simplify/switch)
- 🔴 **Critical** (85-100%): STOP, long break, end session if needed

---

**For complete guide, see** `.hermetic/docs/cognitive-load-tracking-guide.md`

**May your load be measured. May your capacity be respected. May your pace be sustainable.**
