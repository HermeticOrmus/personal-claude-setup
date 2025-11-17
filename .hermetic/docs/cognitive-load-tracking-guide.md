# Cognitive Load Tracking Guide - Managing Mental Overhead

**Principle**: "Measure the invisible to optimize the sustainable"

**What is cognitive load**: Mental effort required to process information and complete tasks

**Why track it**: Invisible bottleneck - most developers optimize code performance while ignoring brain performance

---

## The Problem: Invisible Mental Overhead

### The Invisible Tax

**Scenario**: You're building a feature

**Visible costs**:
- Time: 8 hours
- Lines of code: 500
- Tests written: 20

**Invisible costs** (not measured):
- Mental energy drained: Severe
- Context switches: 47
- Working memory overload: Constant
- Focus interruptions: 23
- Decision fatigue: High
- Post-work recovery needed: 3 hours

**Result**: Feature shipped, developer burned out, sustainability destroyed

---

### The Compounding Effect

**Without tracking**:
```
Week 1: High cognitive load (unnoticed)
Week 2: Higher load (compensate with more hours)
Week 3: Exhaustion (quality drops)
Week 4: Burnout (can't think clearly)
Week 5: Crisis (nothing works anymore)
```

**With tracking**:
```
Week 1: High load detected early
  → Action: Simplify architecture, reduce scope
Week 2: Load managed (sustainable pace maintained)
Week 3: Load normalized (quality sustained)
Week 4: Rhythm established (capacity understood)
Week 5: Thriving (working with brain, not against it)
```

**Principle (Rhythm)**: What you measure, you can manage. What you manage, you can sustain.

---

## Understanding Cognitive Load

### The Three Types (Sweller's Cognitive Load Theory)

#### 1. Intrinsic Load
**Definition**: Complexity inherent to the task itself

**Examples**:
- Learning a new programming language
- Understanding complex algorithm
- Debugging race condition
- Architecting distributed system

**Cannot eliminate** - But can sequence properly

---

#### 2. Extraneous Load
**Definition**: Mental effort from HOW information is presented

**Examples**:
- Poor documentation (forces guessing)
- Unclear variable names (`x`, `temp`, `data`)
- No code comments
- Disorganized file structure
- Complex build process

**CAN eliminate** - This is where optimization happens

---

#### 3. Germane Load
**Definition**: Effort to build mental models and schemas

**Examples**:
- Creating mental map of codebase
- Understanding patterns
- Building abstractions
- Learning transferable concepts

**WANT this** - This is actual learning

---

### Working Memory Limits (Miller's Law)

**Classic research**: 7±2 chunks of information
**Modern research**: 4±1 chunks (more accurate)

**What this means**:
```javascript
// Bad (9 things to track):
function processUserOrder(
  userId, userName, userEmail,
  productId, productName, productPrice,
  quantity, shippingAddress, paymentMethod
) {
  // Cognitive overload - can't hold all parameters in mind
}

// Good (2 things to track):
function processUserOrder(user, order) {
  // Each parameter is one "chunk" containing related information
  // user.id, user.name, user.email (chunked together)
  // order.product, order.quantity, order.shipping (chunked together)
}
```

**Chunking** reduces cognitive load by grouping related information

---

### Context Switching Cost

**Research (Gloria Mark, UC Irvine)**:
- Average time before interruption: **11 minutes**
- Time to regain focus: **23 minutes**
- Productivity loss: **40%**

**For developers**:
```
9:00 AM - Start feature work (entering flow)
9:11 AM - Slack message (context switch)
9:15 AM - Return to code (need 23 min to refocus)
9:38 AM - Back in flow
9:45 AM - Meeting reminder (context switch)
10:00 AM - Meeting
10:30 AM - Return to code (need 23 min to refocus)
10:53 AM - Finally back in flow
11:04 AM - Another interruption...

Result: 2.5 hours passed, maybe 30 minutes of actual focused work
```

**Solution**: Track interruptions, batch communications, protect focus blocks

---

## Measurement Systems

### System 1: Self-Reported Cognitive Load

**NASA-TLX Scale** (adapted for developers):

#### Mental Demand
**Question**: "How mentally demanding was this task?"

**Scale**:
- 1-2: Trivial (routine work, muscle memory)
- 3-4: Low (familiar patterns, minor thinking)
- 5-6: Moderate (requires focus, some problem-solving)
- 7-8: High (complex problem, sustained concentration)
- 9-10: Extreme (overwhelming, can't hold everything in mind)

**Examples**:
- Renaming variable: 1-2
- Implementing CRUD endpoint: 3-4
- Refactoring authentication: 5-6
- Debugging distributed race condition: 7-8
- Architecting new microservice: 9-10

---

#### Temporal Demand
**Question**: "How much time pressure did you feel?"

**Scale**:
- 1-2: No rush (ample time, can think deeply)
- 3-4: Relaxed (comfortable pace)
- 5-6: Moderate (some time pressure but manageable)
- 7-8: Rushed (tight deadline affecting quality)
- 9-10: Panic (impossible deadline, cutting corners)

**Principle (Rhythm)**: High temporal demand → shortcuts → technical debt → future cognitive load increase

---

#### Effort
**Question**: "How hard did you have to work mentally?"

**Scale**:
- 1-2: Effortless (autopilot)
- 3-4: Light (minimal mental energy)
- 5-6: Moderate (steady effort)
- 7-8: Intense (draining)
- 9-10: Exhausting (completely depleted)

---

#### Frustration
**Question**: "How frustrated/stressed did you feel?"

**Scale**:
- 1-2: Calm (enjoyable)
- 3-4: Content (minor annoyances)
- 5-6: Mildly frustrated (some obstacles)
- 7-8: Very frustrated (significant blockers)
- 9-10: Overwhelmed (want to quit)

**Note**: High frustration often indicates extraneous load (can be eliminated)

---

### System 2: Behavioral Metrics

**Automatically tracked** (no manual input):

#### Context Switch Frequency
**Measure**: Number of times you switch between tasks/tools

**Tools**:
- RescueTime (automatic tracking)
- Toggl Track (manual tracking)
- Git commits (frequency indicates task switching)

**Healthy range**: 0-2 switches per hour
**Warning**: 3-5 switches per hour
**Critical**: 6+ switches per hour

---

#### File Open Count
**Measure**: Number of files open in editor simultaneously

**Interpretation**:
- 1-5 files: Focused (low cognitive load)
- 6-10 files: Moderate (manageable complexity)
- 11-15 files: High (difficult to track context)
- 16+ files: Overload (can't hold mental model)

**Action**: If 10+ files open, consider refactoring to reduce coupling

---

#### Error Rate
**Measure**: Frequency of errors (compile errors, test failures, bugs)

**Pattern**:
```
Normal cognitive load: 2-3 errors per hour (expected learning)
Elevated load: 5-7 errors per hour (losing focus)
Overload: 10+ errors per hour (can't think clearly)
```

**Principle**: Error rate is delayed indicator of cognitive overload from 30-60 minutes prior

---

#### Task Completion Time
**Measure**: Time to complete similar tasks

**Baseline**: Track normal completion time for routine tasks

**Example**:
- CRUD endpoint normally takes 2 hours
- Today taking 4 hours for same task
- **Indicator**: Cognitive load elevated (fatigue, distractions, complexity elsewhere)

---

### System 3: Code Complexity Metrics

**Objective measures** of intrinsic cognitive load:

#### Cyclomatic Complexity
**Definition**: Number of linearly independent paths through code

**Formula**: `M = E - N + 2P`
- E = edges in control flow graph
- N = nodes
- P = connected components

**Interpretation**:
- 1-10: Simple (low cognitive load)
- 11-20: Moderate (manageable)
- 21-50: Complex (high load, consider refactoring)
- 50+: Very high (likely unmaintainable)

**Example**:
```javascript
// Cyclomatic complexity: 1 (simple, one path)
function greet(name) {
  return `Hello, ${name}`;
}

// Cyclomatic complexity: 4 (4 independent paths)
function processPayment(amount, method) {
  if (amount <= 0) return false;  // Path 1

  if (method === 'card') {
    return chargeCard(amount);    // Path 2
  } else if (method === 'paypal') {
    return chargePaypal(amount);  // Path 3
  } else {
    return false;                 // Path 4
  }
}
```

**Tools**:
- ESLint (JavaScript): `complexity` rule
- Radon (Python)
- SonarQube (multi-language)

---

#### Cognitive Complexity
**Definition**: Measure of how difficult code is to understand (more nuanced than cyclomatic)

**Increments for**:
- Nested control structures (+1 per nesting level)
- Recursion (+1)
- Jumps (break, continue, goto) (+1)
- Binary logical operators in conditions (+1)

**Example**:
```javascript
// Cyclomatic: 3, Cognitive: 3 (flat structure)
function validate(user) {
  if (!user.email) return false;
  if (!user.password) return false;
  if (!user.name) return false;
  return true;
}

// Cyclomatic: 3, Cognitive: 7 (nested structure, harder to understand)
function validate(user) {
  if (user) {                      // +1 nesting
    if (user.email) {              // +2 (nested in if)
      if (user.password) {         // +3 (nested deeper)
        if (user.name) {           // +4 (nested even deeper)
          return true;
        }
      }
    }
  }
  return false;
}
// Same logic, much higher cognitive load
```

**Principle**: Cognitive complexity correlates better with "time to understand" than cyclomatic complexity

---

#### Halstead Metrics
**Measures**:
- **Volume**: Size and vocabulary of code
- **Difficulty**: How hard to write/understand
- **Effort**: Mental effort required

**Formula (simplified)**:
- η1 = number of distinct operators
- η2 = number of distinct operands
- N1 = total operators
- N2 = total operands

**Vocabulary**: `η = η1 + η2`
**Length**: `N = N1 + N2`
**Volume**: `V = N × log2(η)`
**Difficulty**: `D = (η1/2) × (N2/η2)`
**Effort**: `E = D × V`

**Interpretation**: Higher effort = higher cognitive load

---

## Tracking Workflows

### Workflow 1: Daily Cognitive Load Journal

**When**: End of each coding session

**Template** (in dev docs Layer 3):

```markdown
## Cognitive Load Journal - [Date]

### Session Overview
- **Duration**: 2.5 hours
- **Task**: Implement JWT authentication
- **Completion**: 70%

### NASA-TLX Scores
- **Mental Demand**: 7/10 (complex security considerations)
- **Temporal Demand**: 4/10 (no rush, planned properly)
- **Effort**: 8/10 (sustained concentration required)
- **Frustration**: 3/10 (minor CORS issues, resolved quickly)

**Total Cognitive Load Score**: 22/40 (55% - Moderate-High)

### Behavioral Metrics
- **Context Switches**: 3 (acceptable)
  - 10:00 AM → Slack question (5 min)
  - 11:30 AM → Code review (15 min)
  - 1:00 PM → Documentation check (10 min)
- **Files Open**: 8 (manageable)
- **Error Rate**: 4 errors/hour (slightly elevated, fatigue?)
- **Interruptions**: 2 external (team questions)

### Code Complexity Added
- `authController.js`: Cyclomatic 12, Cognitive 8 (moderate)
- `jwtUtils.js`: Cyclomatic 6, Cognitive 4 (simple)
- **Assessment**: Complexity reasonable, no refactoring needed yet

### Load Analysis
**What increased load**:
- ⚠️ **New territory**: First time implementing JWT (high intrinsic load)
- ⚠️ **Security concerns**: Constant awareness of vulnerabilities (mental tax)

**What reduced load**:
- ✅ **Clear plan**: Had architecture decided beforehand
- ✅ **Good documentation**: Auth0 guides excellent
- ✅ **No time pressure**: Could think deeply

### Adaptations Made
- **Break at 90 min**: Noticed focus dropping, took 10 min walk
- **Closed Slack**: After second interruption, set DND for 90 min
- **Simplified scope**: Deferred refresh token rotation to next session

### Tomorrow's Optimization
- [ ] Start with easier task to warm up (finish unit tests)
- [ ] Deep focus block 9-11 AM (most cognitively demanding work)
- [ ] Batch communications to 11-11:30 AM and 3-3:30 PM
```

---

### Workflow 2: Weekly Load Pattern Analysis

**When**: End of week review

**Template** (in dev docs or separate file):

```markdown
# Weekly Cognitive Load Analysis - Week of [Date]

## Load Trend
| Day | Avg Load | Peak Load | Notes |
|-----|----------|-----------|-------|
| Mon | 45%      | 70%       | Fresh, productive |
| Tue | 55%      | 80%       | Complex feature |
| Wed | 65%      | 90%       | Too many meetings |
| Thu | 70%      | 85%       | Accumulated fatigue |
| Fri | 40%      | 60%       | Light refactoring day |

**Observation**: Load accumulated through week, Thursday critical

## Context Switch Analysis
- **Total switches**: 47 (avg 9.4/day)
- **Worst day**: Wednesday (17 switches - meeting-heavy)
- **Best day**: Friday (4 switches - protected focus)

**Action**: Block Wednesday mornings for deep work

## High-Load Tasks Identified
1. **Distributed tracing implementation** (90% load)
   - Intrinsic load: High (new concept)
   - Extraneous load: Medium (documentation unclear)
   - **Action**: Pair program next time (share load)

2. **Database migration** (85% load)
   - Intrinsic load: Medium
   - Extraneous load: High (poor tooling, manual steps)
   - **Action**: Automate migration process (reduce extraneous)

3. **Code review of unfamiliar codebase** (80% load)
   - Intrinsic load: High (complex domain)
   - Temporal load: High (urgent review requested)
   - **Action**: Request more time for reviews, context-build first

## Load Reduction Wins
✅ **Implemented snippet library**: Reduced boilerplate cognitive load
✅ **Documented common patterns**: Team can reference instead of asking
✅ **Protected 9-11 AM focus blocks**: 40% more progress in less time

## Rhythm Violations
❌ **Wednesday**: 6 meetings, no sustained focus (violated Rhythm principle)
❌ **Thursday evening**: Worked late trying to compensate (unsustainable)

## Next Week Adjustments
1. **Batch meetings**: Move 3 Wednesday meetings to Tuesday afternoon
2. **Energy-match tasks**: High-load tasks in morning (fresh), low-load afternoon
3. **Buffer sessions**: Add 30-min buffer between high-load tasks
4. **Protect Friday**: Keep as integration/refactoring day (low-load recovery)
```

---

### Workflow 3: Real-Time Load Monitoring

**During work** (every 90 minutes):

**Quick Check**:
1. **Mental state?** (Clear / Foggy / Overwhelmed)
2. **Energy level?** (High / Medium / Low)
3. **Files open?** (Count them)
4. **Errors frequency?** (Increasing?)

**If load high** (foggy, low energy, 10+ files, frequent errors):
→ **STOP** and take action

**Actions**:
- [ ] Take 10-minute break (walk, water, stretch)
- [ ] Close unnecessary files (reduce visual load)
- [ ] Write down mental state in Layer 3 (externalize thoughts)
- [ ] Simplify task scope (do less, better)
- [ ] Switch to lower-load task (tests, documentation, refactoring)

**Principle**: Detect overload EARLY, adjust IMMEDIATELY (don't push through)

---

## Integration with Hermetic Systems

### Dev Docs Layer 3: Cognitive Insights

**Capture patterns**:

```markdown
## ⚡ Layer 3: Critical Insights

### 🎯 Key Patterns
- **Morning peak performance**: 9-11 AM optimal for complex work (tested Week 14-16)

### ⚠️ Gotchas
- **Meeting before deep work destroys it**: Even 30-min meeting kills flow (experienced 2024-12-03)
- **File count > 12 = complexity smell**: If need that many files open, architecture might be coupled

### 💎 Breakthroughs
- **Cognitive load journaling shows fatigue 1 day early**: Can prevent burnout by adjusting Wednesday
```

---

### MOC: Cognitive Load Management

**Create MOC** to organize cognitive load knowledge:

```markdown
# Cognitive Load Management MOC

## Core Concepts
- [[Working Memory Limits]] - 4±1 chunks
- [[Context Switching Cost]] - 23 min to refocus
- [[Cognitive Load Theory]] - Intrinsic/Extraneous/Germane

## Measurement Systems
- [[NASA-TLX Scale]] - Self-reported load
- [[Code Complexity Metrics]] - Cyclomatic, cognitive, Halstead
- [[Behavioral Tracking]] - Context switches, error rate

## Load Reduction Strategies
- [[Chunking Information]] - Group related data
- [[Eliminating Extraneous Load]] - Better docs, clear names
- [[Protected Focus Blocks]] - No interruptions
- [[Energy-Matched Task Scheduling]] - Hard tasks when fresh

## Personal Load Patterns
- [[My Peak Performance Windows]] - 9-11 AM, 2-4 PM
- [[My Load Triggers]] - Meetings, unclear requirements, legacy code
- [[My Recovery Strategies]] - Walk, water, write thoughts down

## Load-Aware Workflows
- [[Plan High-Load Tasks]] - Architecture, new concepts
- [[Execution Low-Load Tasks]] - Tests, refactoring, docs
- [[Recovery Tasks]] - Code review, learning, MOC maintenance
```

---

### Spaced Repetition: Load Management Cards

**Extract to Anki**:

**Card 1**:
- **Q**: What are the three types of cognitive load?
- **A**:
  1. **Intrinsic** (task complexity - can't eliminate)
  2. **Extraneous** (presentation - CAN eliminate)
  3. **Germane** (learning - WANT this)

**Card 2**:
- **Q**: How many chunks can working memory hold?
- **A**: 4±1 chunks (modern research). Classic "7±2" was overestimate.

**Card 3**:
- **Q**: What's the cost of context switching for developers?
- **A**:
  - Time to refocus: 23 minutes
  - Productivity loss: 40%
  - Interrupted every: 11 minutes (average)

**Card 4**:
- **Q**: When cognitive load journal shows score > 70%, what actions?
- **A**:
  1. Take immediate break
  2. Simplify scope
  3. Switch to lower-load task
  4. Document pattern in Layer 3
  5. Adjust tomorrow's plan

---

## Automation & Tooling

### Tool 1: Automatic Complexity Analysis

**Add to pre-commit hook**:

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Run complexity analysis on staged files
echo "Analyzing cognitive complexity..."

# JavaScript/TypeScript
npx eslint --rule 'complexity: [warn, 15]' --rule 'max-lines-per-function: [warn, 50]' $(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(js|ts)$')

# Python
radon cc $(git diff --cached --name-only --diff-filter=ACM | grep '\.py$') -a -nb

echo "Complexity analysis complete."
```

**Result**: Every commit shows complexity metrics, prevents load accumulation

---

### Tool 2: Context Switch Detector

**Using RescueTime API**:

```javascript
// context-switch-detector.js
const RescueTime = require('rescuetime-api');

async function analyzeContextSwitches(date) {
  const data = await RescueTime.getProductivityData(date);

  let switches = 0;
  let lastApp = null;

  data.forEach(entry => {
    if (entry.app !== lastApp) {
      switches++;
      lastApp = entry.app;
    }
  });

  // Warning if > 5 switches/hour
  const hoursWorked = data.length / 12; // 5-min intervals
  const switchRate = switches / hoursWorked;

  if (switchRate > 5) {
    console.warn(`⚠️  High context switching: ${switchRate.toFixed(1)} switches/hour`);
    console.log('Recommendation: Batch similar tasks, use focus blocks');
  }

  return { switches, switchRate };
}
```

**Integration**: Run daily, add to cognitive load journal automatically

---

### Tool 3: Load-Aware Task Scheduler

**Concept**: Schedule tasks based on cognitive load requirements

```javascript
// task-scheduler.js

const tasks = [
  { name: 'Implement auth', load: 'high', estimatedTime: 180 },
  { name: 'Write tests', load: 'low', estimatedTime: 60 },
  { name: 'Refactor utils', load: 'medium', estimatedTime: 90 },
  { name: 'Update docs', load: 'low', estimatedTime: 45 }
];

const energyPattern = [
  { time: '9:00-11:00', energy: 'high' },
  { time: '11:00-12:00', energy: 'medium' },
  { time: '13:00-14:00', energy: 'low' }, // Post-lunch dip
  { time: '14:00-16:00', energy: 'high' },
  { time: '16:00-17:00', energy: 'medium' }
];

function scheduleOptimally(tasks, energyPattern) {
  // Match high-load tasks with high-energy windows
  const schedule = [];

  energyPattern.forEach(window => {
    const matchingTasks = tasks.filter(t => {
      if (window.energy === 'high' && t.load === 'high') return true;
      if (window.energy === 'medium' && t.load === 'medium') return true;
      if (window.energy === 'low' && t.load === 'low') return true;
      return false;
    });

    schedule.push({ window: window.time, tasks: matchingTasks });
  });

  return schedule;
}

// Output:
// 9:00-11:00 (high energy): Implement auth (high load)
// 11:00-12:00 (medium energy): Refactor utils (medium load)
// 13:00-14:00 (low energy): Update docs (low load)
// 14:00-16:00 (high energy): [reserve for deep work]
// 16:00-17:00 (medium energy): Write tests (low-medium load)
```

**Principle (Rhythm)**: Work WITH natural energy cycles, not against them

---

## Advanced Patterns

### Pattern 1: Load Budgeting

**Concept**: Treat cognitive capacity like financial budget

**Daily budget**: 100 points

**Task costs**:
- Trivial (1-10 points): Rename variable, fix typo
- Low (11-25 points): Write unit test, update docs
- Medium (26-50 points): Implement CRUD endpoint, refactor function
- High (51-75 points): Design architecture, debug race condition
- Extreme (76-100 points): New domain learning, complex migration

**Budget planning**:
```
Morning (fresh): 100 points available
- High-load task: Architecture design (-70 points)
- Remaining: 30 points

Afternoon: 30 points available (depleted)
- Low-load task: Write tests (-20 points)
- Low-load task: Update docs (-10 points)
- Remaining: 0 points

Result: Stopped at right time, didn't push into burnout
```

**Warning signals**:
- Attempting 120+ points in one day → **Unsustainable**
- Three 80+ point days in a row → **Burnout incoming**
- Consistently under 40 points → **Underutilized** (might need more challenge)

---

### Pattern 2: Cognitive Load Pairing

**Concept**: Distribute load across multiple brains

**Solo**: 100% load on one person
**Pair programming**: 50-60% load each (shared working memory)

**Benefits**:
- Working memory effectively doubled (two 4-chunk buffers)
- Context switching eliminated (both in same context)
- Real-time error catching (reduced error rate)
- Knowledge transfer automatic (germane load for both)

**When to pair**:
- ✅ Task load > 75% for one person
- ✅ New/unfamiliar territory (high intrinsic load)
- ✅ Complex debugging (need second perspective)
- ✅ Architecture decisions (benefit from discussion)

**When not to pair**:
- ❌ Trivial tasks (pairing overhead > benefit)
- ❌ Both people unfamiliar (load doubled, not halved)
- ❌ When deep individual focus needed (writing, research)

---

### Pattern 3: Progressive Load Increase

**Concept**: Gradually increase task complexity (like progressive overload in fitness)

**Week 1**: Simple CRUD (load 30%)
**Week 2**: CRUD + validation (load 40%)
**Week 3**: CRUD + auth (load 50%)
**Week 4**: CRUD + auth + caching (load 60%)

**Avoid**: Jumping from 30% to 80% load (overwhelm, likely to fail)

**Principle (Rhythm)**: Sustainable growth through gradual challenge increase

---

## Common Mistakes

### Mistake 1: "I can push through"

**Belief**: Cognitive overload can be overcome with willpower

**Reality**: Brain has physical limits (glucose, neurotransmitters deplete)

**Consequence**:
- Quality drops (errors increase)
- Decisions worsen (technical debt accumulates)
- Recovery time increases (burnout)

**Fix**: Respect load signals, take breaks, simplify scope

---

### Mistake 2: Optimizing wrong load type

**Example**: Spending 3 hours making code "perfect" (optimizing intrinsic load)
**Missed**: Could eliminate extraneous load in 30 minutes (better docs, clearer names)

**ROI**:
- Intrinsic load optimization: Marginal gains (task is still complex)
- Extraneous load elimination: Massive gains (removes unnecessary friction)

**Priority**: Always eliminate extraneous load first

---

### Mistake 3: Not tracking recovery

**Tracking**: Work sessions only
**Missing**: Recovery time needed afterward

**Reality**:
- High-load session (4 hours) → Need 2 hours recovery
- Extreme-load session (8 hours) → Need 12-24 hours recovery

**Fix**: Track both work AND recovery in cognitive load journal

---

### Mistake 4: Heroic sprints

**Pattern**:
- Monday-Thursday: 80-90% load every day
- Friday: Collapse
- Weekend: Recover
- Repeat

**Problem**: Unsustainable, leads to burnout

**Fix**: Aim for 50-60% average load, with peaks to 75% max

**Principle (Rhythm)**: Marathon pace, not sprint pace

---

## Load Reduction Strategies

### Strategy 1: Chunking

**Problem**: Too many discrete items to track

**Solution**: Group related information into chunks

**Example**:
```javascript
// Before (10 things to track):
function createUser(
  firstName, lastName, email, phone,
  street, city, state, zip,
  cardNumber, cardCvv
) { }

// After (3 chunks to track):
function createUser(personalInfo, address, payment) {
  // personalInfo = { firstName, lastName, email, phone }
  // address = { street, city, state, zip }
  // payment = { cardNumber, cardCvv }
}
```

**Load reduction**: 70% (10 items → 3 chunks)

---

### Strategy 2: Externalize Thoughts

**Problem**: Trying to hold too much in working memory

**Solution**: Write it down, free up mental space

**Example**:
```markdown
## Current Mental State (externalized)

**What I'm trying to do**:
- Implement JWT refresh token rotation
- Ensure old tokens invalidated
- Store rotation in database

**What I know**:
- Access token expires in 15 min
- Refresh token expires in 7 days
- Need to invalidate old refresh token when issuing new one

**What I'm uncertain about**:
- Should I store all issued tokens or just latest?
- How to handle concurrent refresh requests?

**Decision needed**:
- Research: Check how Auth0 handles this
- Likely solution: Store token family ID, increment version on refresh
```

**Result**: Brain freed from holding this information, can focus on implementation

---

### Strategy 3: Reduce Visual Noise

**Problem**: Too many files/tabs open (visual cognitive load)

**Solution**: Strict limits

**Rules**:
- Max 5 files open in editor (current focus)
- Max 3 browser tabs (documentation only)
- Close Slack/email during focus blocks

**Before**: 23 files open, constant scanning, can't find anything
**After**: 4 files open, clear focus, instant navigation

**Load reduction**: 60%

---

### Strategy 4: Clear Naming

**Problem**: Unclear variable names force mental translation

**Example**:
```javascript
// Bad (high extraneous load):
function p(u, o) {
  const t = o.i.reduce((a, i) => a + i.p * i.q, 0);
  const s = t * 0.08;
  const f = t + s;
  return { u, f };
}
// Mental translation required for every variable

// Good (low extraneous load):
function processOrder(user, order) {
  const subtotal = order.items.reduce((sum, item) =>
    sum + item.price * item.quantity, 0
  );
  const tax = subtotal * 0.08;
  const total = subtotal + tax;
  return { user, total };
}
// Reads like English, minimal translation needed
```

**Load reduction**: 80% (no mental translation overhead)

---

### Strategy 5: Defer Decisions

**Problem**: Trying to make all decisions at once (decision fatigue)

**Solution**: Make minimum viable decisions now, defer rest

**Example**:
```javascript
// Instead of deciding perfect architecture now (high load):
// - Database schema optimization
// - Caching strategy
// - Error handling patterns
// - Logging approach
// - Testing strategy

// Start with simplest working version (low load):
// - Basic database tables (can optimize later)
// - No caching yet (add when needed)
// - Simple try/catch (refine later)
// - Console.log for now (proper logging later)
// - Happy path tests (edge cases later)
```

**Principle (Vibration)**: Ship imperfect, iterate based on reality

**Load reduction**: 70% (one decision at a time)

---

## Hermetic Principles Applied

### Mentalism - Cognitive Clarity

**Principle**: "The All is Mind" - Mental state determines code quality

**Application**:
- Foggy mind → Foggy code
- Clear mind → Clear code
- Track mental state to predict code quality

**Practice**:
```markdown
Before coding session:
- **Mental clarity check**: Am I clear or foggy?
- **If foggy**: Don't start complex task (will create technical debt)
- **Action**: Warm up with simple task, THEN tackle complexity
```

---

### Correspondence - As Above, So Below

**Principle**: External structure reflects internal state

**Application**:
- Messy desk → Messy code
- Disorganized files → Disorganized thinking
- Clear structure → Clear mind

**Practice**: Clean workspace before coding (reduces visual cognitive load)

---

### Vibration - Movement Over Perfection

**Principle**: Ship imperfect, iterate rapidly

**Application to cognitive load**:
- Trying to perfect everything → Cognitive overload
- Ship working version → Learn what actually matters
- Iterate based on feedback → Less wasted mental energy

**Practice**: When load high, reduce scope and ship smaller

---

### Polarity - Balance Load Types

**Principle**: Balance opposing forces

**Application**:
- High-load task ↔ Low-load recovery
- Deep focus ↔ Social collaboration
- Complexity ↔ Simplicity

**Practice**: Alternate high-load and low-load tasks throughout day

---

### Rhythm - Sustainable Pace

**Principle**: Work with natural cycles

**Application to cognitive load**:
- Daily rhythm: Peak energy 9-11 AM, dip 1-2 PM
- Weekly rhythm: High load Mon-Thu, low Fri
- Sprint rhythm: 6 days work, 1 day integration
- Yearly rhythm: Seasons of learning vs building

**Practice**: Match task load to energy rhythm

---

### Cause & Effect - Load Accumulation

**Principle**: Every action has consequences

**Application**:
- High load today → Fatigue tomorrow
- Sustained overload → Burnout next month
- Load tracking → Sustainable performance

**Practice**: Track load daily, analyze weekly, adjust monthly

---

### Gender - Doing vs Being

**Principle**: Balance masculine (doing) with feminine (being)

**Application to cognitive load**:
- Masculine: Execute, build, ship (active cognitive load)
- Feminine: Reflect, integrate, rest (passive recovery)
- Both needed for sustainability

**Practice**:
- Doing: High-load coding sessions
- Being: Walks, journaling, integration time

---

## Quick Reference

### Daily Workflow
1. **Morning**: Check cognitive budget (100 points available)
2. **Plan**: Match high-load tasks to high-energy windows
3. **Execute**: Track load every 90 minutes
4. **Adjust**: If load > 70%, take action (break/simplify/switch)
5. **Journal**: End of day, record NASA-TLX scores and metrics

### Weekly Workflow
1. **Monday**: Review last week's load patterns
2. **Mid-week**: Check load accumulation (adjust if building)
3. **Friday**: Light load (recovery, integration, planning)
4. **Weekend**: Full recovery (no work-related cognitive load)

### Warning Signals
- 🟡 **Elevated**: Load 60-70%, error rate increasing
  - Action: Take 10-min break, close extra files
- 🟠 **High**: Load 70-85%, frequent errors, frustration
  - Action: Simplify scope, switch to lower-load task
- 🔴 **Critical**: Load > 85%, can't think clearly, exhausted
  - Action: Stop immediately, take 30+ min break, end session early if needed

### Load Reduction Checklist
- [ ] Chunk related information (reduce discrete items)
- [ ] Externalize thoughts (write down mental state)
- [ ] Close unnecessary files/tabs (reduce visual noise)
- [ ] Use clear naming (eliminate translation overhead)
- [ ] Defer non-critical decisions (one thing at a time)
- [ ] Batch communications (reduce context switches)
- [ ] Protect focus blocks (90-120 min uninterrupted)

---

**For complete integration with dev docs, see** `.claude/skills/development-tools/track-cognitive-load.md`

**May your mind be clear. May your load be measured. May your pace be sustainable.**
