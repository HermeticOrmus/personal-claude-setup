# Apply Tracking Discipline

**Master**: Benjamin Franklin
**Core Principle**: "What gets measured gets improved. Track everything, improve systematically."
**Time**: 5 min daily + 20 min weekly review
**Best For**: Accountability, systematic improvement, building habits, measuring progress

---

## Franklin's Tracking System

**Franklin's challenge**: How to become morally better?

**His solution**: Track 13 virtues daily
- Every evening: Review day, mark failures
- Every week: Focus on one virtue intensely
- Every quarter: Review progress, adjust
- Every year: Complete cycle through all virtues

**Result**: Continuous systematic self-improvement over lifetime

**His notebook**: Grid of 13 virtues × 7 days, marked with dots for each failure

**Key insight**: "I was surprised to find myself so much fuller of faults than I had imagined."

Tracking reveals truth.

---

## When to Use This Skill

✅ **Use when:**
- Want measurable improvement
- Need accountability
- Building new habit
- Breaking bad habit
- Skill plateau (need data to diagnose)
- Multiple goals (need system to track all)
- Lack motivation (data shows progress)
- Long-term commitment (months/years)

❌ **Don't use when:**
- Short-term project (< 1 week)
- Can't define metrics
- Tracking overhead > value gained
- Purely exploratory (not optimizing)

---

## The Franklin Tracking System

### Step 1: Define What to Track (15 min setup)

**What**: Choose 3-7 metrics to track daily.

**Franklin's 13 Virtues**:
1. Temperance (eat/drink in moderation)
2. Silence (speak only what benefits)
3. Order (everything in its place)
4. Resolution (perform what you ought)
5. Frugality (waste nothing)
6. Industry (be always employed)
7. Sincerity (think innocently, speak justly)
8. Justice (wrong none)
9. Moderation (avoid extremes)
10. Cleanliness (body, clothes, habitation)
11. Tranquility (not disturbed by trifles)
12. Chastity (moderation)
13. Humility (imitate Jesus and Socrates)

**Your tracking (developer version)**:
```markdown
## My Tracking System

### Daily Metrics (3-7 things)

1. **Deep Work Hours**
   - Goal: 4 hours/day
   - Why: Build focused work capacity
   - How to measure: Pomodoro count × 0.5 hours

2. **Code Quality**
   - Goal: Write tests before code
   - Why: Reduce bugs, improve design
   - How to measure: # of commits with tests

3. **Learning Time**
   - Goal: 1 hour/day on new skill
   - Why: Continuous growth
   - How to measure: Minutes spent in Learning directory

4. **Health Maintenance**
   - Goal: Exercise 30 min
   - Why: Sustainable energy
   - How to measure: Did I exercise? (Yes/No)

5. **Communication Quality**
   - Goal: Clear, kind, direct
   - Why: Better collaboration
   - How to measure: # of unclear messages I sent

6. **Focus Management**
   - Goal: No context switching
   - Why: Deep work needs unbroken time
   - How to measure: # of times checked email/Slack outside designated times

7. **Rest & Recovery**
   - Goal: End work by 6 PM
   - Why: Prevent burnout
   - How to measure: Actual end time
```

**Choose YOUR metrics based on YOUR goals**

**Rule**: 3-7 metrics. Too few = miss important areas. Too many = tracking becomes burdensome.

---

### Step 2: Create Daily Tracking Grid (5 min daily)

**What**: Track each metric every evening.

**Franklin's grid** (physical notebook):
```
Virtue       | Mon | Tue | Wed | Thu | Fri | Sat | Sun
-------------|-----|-----|-----|-----|-----|-----|-----
Temperance   |     |  •  |     |     |  •  |     |
Silence      |  •  |     |     |     |     |     |  •
Order        |     |     |  •  |     |     |     |
Resolution   |     |     |     |     |     |     |
Industry     |     |     |     |  •  |     |     |
```
• = Failed this virtue today

**Your grid** (markdown file):
```markdown
# Daily Tracking: Week of [Date]

| Metric            | Mon | Tue | Wed | Thu | Fri | Sat | Sun | Goal |
|-------------------|-----|-----|-----|-----|-----|-----|-----|------|
| Deep Work Hours   | 3.5 | 4.0 | 2.5 | 4.5 | 3.0 | -   | -   | 4.0  |
| Code w/ Tests     | ✓   | ✓   | ✗   | ✓   | ✓   | -   | -   | 100% |
| Learning Time     | 60m | 45m | 90m | 30m | 60m | -   | -   | 60m  |
| Exercise          | ✓   | ✗   | ✓   | ✓   | ✓   | -   | -   | Daily|
| Focus (no switch) | 8   | 6   | 12  | 4   | 7   | -   | -   | <5   |
| End Work Time     | 6PM | 7PM | 6PM | 6PM | 8PM | -   | -   | 6PM  |
```

**Every evening** (5 minutes):
1. Fill in today's metrics
2. Note if you hit goal (✓) or missed (✗)
3. Brief note on why if missed

**Template** - Save to `Learning/Active/<skill>/franklin-tracking.md`:
```markdown
# Franklin Tracking: [Skill/Life Area]

## Current Week: [Week of Date]

### Daily Grid

| Metric | Mon | Tue | Wed | Thu | Fri | Sat | Sun | Goal | Hit Rate |
|--------|-----|-----|-----|-----|-----|-----|-----|------|----------|
| Metric 1 | | | | | | | | X | _% |
| Metric 2 | | | | | | | | X | _% |
| Metric 3 | | | | | | | | X | _% |

### Daily Notes

**Monday**:
- What went well:
- What to improve:

**Tuesday**:
- What went well:
- What to improve:

[Continue for each day]
```

---

### Step 3: Weekly Review (20 min every Sunday)

**What**: Analyze the week, identify patterns, adjust for next week.

**Franklin's weekly review**:
1. Count failures for each virtue
2. Calculate success rate
3. Choose ONE virtue to focus on intensely next week
4. Plan specific actions to improve that virtue

**Your weekly review**:

#### 3.1 Calculate Hit Rates
```markdown
## Weekly Review: [Week of Date]

### Hit Rates This Week

| Metric | Days Hit | Days Missed | Success Rate | Trend |
|--------|----------|-------------|--------------|-------|
| Deep Work Hours | 4/5 | 1/5 | 80% | ↑ from 60% |
| Code w/ Tests | 4/5 | 1/5 | 80% | → same |
| Learning Time | 5/5 | 0/5 | 100% | ↑ from 80% |
| Exercise | 4/5 | 1/5 | 80% | ↓ from 100% |
| Focus Management | 2/5 | 3/5 | 40% | ↓ from 60% |
| End Work Time | 3/5 | 2/5 | 60% | → same |
```

#### 3.2 Identify Patterns
```markdown
### Patterns Observed

**What's working**:
- Learning time consistent (morning routine working)
- Deep work improving (Pomodoro technique helping)

**What's not working**:
- Focus management declining (too many Slack notifications)
- Thursday/Friday energy drops (working late earlier in week)

**Insights**:
- When I work past 6 PM, next day is less productive
- Exercise on Monday sets positive tone for week
- Wednesday deep work peak (fewest meetings)
```

#### 3.3 Root Cause Analysis
For each missed goal, ask "Why?"

```markdown
### Root Cause Analysis

**Focus Management (only 40% success)**:
- Why missed? → Checked Slack too often
- Why checked? → Notifications on, fear of missing urgent message
- Why fear? → No agreed response time with team
- Root cause: No communication boundaries set

**Action**: Set Slack to "Do Not Disturb" during deep work, communicate response time expectations
```

#### 3.4 Choose Focus Virtue for Next Week
**Franklin's method**: Focus on ONE intensely

```markdown
### Next Week's Focus Virtue

**Primary Focus**: Focus Management (only 40% success)

**Specific actions**:
1. [ ] Set Slack DND hours (9-11 AM, 2-4 PM)
2. [ ] Communicate response time expectations to team
3. [ ] Move phone to different room during deep work
4. [ ] Check Slack only at 11 AM, 12 PM, 4 PM, 5 PM (4 times/day)

**Success = getting to 80%+ next week**

**Secondary goals**: Maintain 80%+ on other metrics
```

---

### Step 4: Monthly Review (1 hour monthly)

**What**: Zoom out, see trends, course-correct.

```markdown
## Monthly Review: [Month]

### Monthly Trends

| Metric | Week 1 | Week 2 | Week 3 | Week 4 | Monthly Avg | Trend |
|--------|--------|--------|--------|--------|-------------|-------|
| Deep Work | 60% | 70% | 80% | 85% | 74% | ↑↑ |
| Tests | 80% | 80% | 90% | 95% | 86% | ↑ |
| Learning | 80% | 90% | 100% | 100% | 93% | ↑↑ |
| Exercise | 100% | 80% | 80% | 60% | 80% | ↓ |

### Wins This Month
- Deep work increased 25 percentage points (60% → 85%)
- Learning consistency excellent (93% average)
- Test coverage now habitual (95% last week)

### Losses This Month
- Exercise declining (100% → 60%)
- Working late more frequently

### Key Insights
1. **Systems beat willpower**: Pomodoro timer = deep work improvement
2. **Morning routines stick**: Learning never missed (always morning)
3. **Evening routines fail**: Exercise declining (always "later")
4. **Tracking reveals self-deception**: Thought I was exercising more than I was

### Next Month Focus
- Move exercise to morning (successful pattern)
- Maintain gains in deep work and learning
- Address work-life boundary (late nights increasing)
```

---

### Step 5: Quarterly Deep Dive (2 hours quarterly)

**What**: Major reflection, adjust goals, celebrate progress.

```markdown
## Quarterly Review: Q[X] [Year]

### Quarter Summary

**Goals at start of quarter**:
1. [ / ✓ / ✗ ] Goal 1: [Status]
2. [ / ✓ / ✗ ] Goal 2: [Status]
3. [ / ✓ / ✗ ] Goal 3: [Status]

**Actual achievement**:
- What I achieved: [List]
- What I didn't: [List]
- Surprises: [Unexpected outcomes]

### Data Analysis

**Best weeks**: [Which weeks had highest performance?]
**Worst weeks**: [Which had lowest?]
**What differentiated them**: [Key factors]

### Habit Formation Results

| Metric | Start % | End % | Change | Status |
|--------|---------|-------|--------|--------|
| Deep Work | 40% | 85% | +45% | ✓ Habit formed |
| Learning | 50% | 95% | +45% | ✓ Habit formed |
| Exercise | 80% | 70% | -10% | ✗ Needs work |

### Next Quarter Goals

Based on this quarter's data:

1. **Goal 1**: [Specific, measurable, based on tracking insights]
2. **Goal 2**: [Based on what tracking revealed]
3. **Goal 3**: [New area to track/improve]

**Metrics to add**: [New things to track]
**Metrics to remove**: [Things that are now habits, don't need tracking]
```

---

## Advanced Tracking Techniques

### The Streak Counter
**What**: Count consecutive days hitting goal

**Why**: Psychological motivation ("Don't break the chain")

```markdown
### Current Streaks

- Deep Work: 12 days ✓✓✓✓✓✓✓✓✓✓✓✓
- Learning: 45 days ✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓
- Exercise: 0 days (restart tomorrow!)

**Longest streak ever**: Learning - 67 days
```

### The Leading vs Lagging Indicator
**Lagging**: Result metrics (weight lost, skill mastered)
**Leading**: Action metrics (exercised, studied)

Track LEADING indicators (what you control), lagging will follow.

```markdown
**Lagging goal**: Ship feature
**Leading metrics**:
- Deep work hours (control)
- Code with tests (control)
- Focus management (control)

Track the actions → Result will come
```

### The If-Then Implementation Intention
When tracking reveals pattern, create if-then rule:

```markdown
**Pattern observed**: Miss exercise on Mondays
**If-Then rule**: If Monday, then exercise immediately after morning coffee

**Pattern observed**: Work late on Thursdays (meetings till 5 PM)
**If-Then rule**: If Thursday, then schedule NO meetings after 3 PM
```

### The Energy Tracking
Track WHEN you're most productive:

```markdown
| Time | Energy | Best For |
|------|--------|----------|
| 6-8 AM | High | Deep work |
| 9-11 AM | Peak | Creative work |
| 12-1 PM | Low | Lunch, admin |
| 2-4 PM | Medium | Meetings OK |
| 4-6 PM | Declining | Wrap up, planning |

**Insight**: Schedule deep work 9-11 AM, not afternoons
```

---

## Common Pitfalls

### ❌ Pitfall 1: Tracking Too Many Things
**Problem**: 15 metrics = tracking takes 30 min, becomes burden
**Solution**: 3-7 metrics maximum. Quality > quantity.

### ❌ Pitfall 2: Not Tracking Daily
**Problem**: "I'll catch up on Sunday" → Forget everything → Useless data
**Solution**: 5 min EVERY evening. Non-negotiable.

### ❌ Pitfall 3: Lying to the Data
**Problem**: Inflating numbers to feel better
**Solution**: Brutal honesty. The data is FOR you, not AGAINST you.

### ❌ Pitfall 4: Tracking Without Acting
**Problem**: Track for months, never adjust based on data
**Solution**: Weekly review MUST produce action items

### ❌ Pitfall 5: Tracking Vanity Metrics
**Problem**: Track things that don't matter (lines of code, hours "working")
**Solution**: Track outcomes that matter (deep work quality, tests written, learning retention)

---

## Success Criteria

✅ **You've succeeded when:**
- Tracking daily (100% consistency)
- Weekly reviews happening (every Sunday)
- Data reveals patterns you didn't see before
- Making adjustments based on data
- Metrics improving month-over-month
- Habits forming (some metrics no longer need tracking)
- Feel accountable to yourself

❌ **You need to adjust if:**
- Missing daily tracking frequently
- No weekly reviews
- Data doesn't reveal anything useful (tracking wrong things)
- No action from reviews
- Metrics not improving
- Feels like punishment instead of tool

---

## Integration with Other Skills

**Combine with**:
- `/apply-deliberate-practice` - Track practice metrics
- `/apply-metalearning` - Track progress against milestones
- `/apply-focused-diffuse` - Track Pomodoro counts
- `/apply-encoding-method` - Track review schedule adherence

**Workflow**:
```bash
1. /apply-metalearning "System design" (creates 12-week plan with milestones)

2. /apply-tracking-discipline "Track system design progress"
   → Daily: Log hours, concepts mastered, practice completed
   → Weekly: Review against milestones, adjust if behind

3. /apply-deliberate-practice "Design drills"
   → Track drill performance metrics

4. Monthly review: See 400% improvement in design speed (data doesn't lie)
```

---

## Franklin's Results

**From tracking 13 virtues over lifetime**:
- Most successful American of his era
- Inventor, writer, diplomat, scientist
- Founded institutions (library, fire department, university)
- Helped found nation (signed Declaration of Independence)

**His quote**: "I never arrived at the perfection I had been so ambitious of obtaining, but I fell far short of it. Yet, by the endeavor, I was a better and happier man than I otherwise should have been if I had not attempted it."

**Key**: Not perfection, but systematic improvement over time.

---

## Quick Reference

| Activity | Frequency | Time | Output |
|----------|-----------|------|--------|
| Daily tracking | Every evening | 5 min | Today's metrics |
| Weekly review | Sunday | 20 min | Patterns + focus virtue |
| Monthly review | Last Sunday | 1 hour | Trends + adjustments |
| Quarterly review | End of quarter | 2 hours | Goals + deep insights |

**Remember**: "In reality, there is, perhaps, no one of our natural passions so hard to subdue as pride." - Benjamin Franklin

**Track with humility. Improve with discipline. Succeed with consistency.**
