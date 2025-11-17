# Bug Fixing Workflow

**Purpose**: Systematically diagnose and fix bugs while learning from the experience

**Hermetic Principles**: Mentalism, Cause-Effect, Correspondence

**Estimated Time**: 30 minutes - 4 hours (depending on complexity)

**Prerequisites**:
- Bug report or error observed
- Access to codebase and logs
- Ability to reproduce (ideally)

---

## Philosophy

Bugs are not failures - they're **teachers**. Each bug reveals a gap in:
- **Understanding** (Mentalism)
- **Consequence analysis** (Cause-Effect)
- **Pattern consistency** (Correspondence)

This workflow treats debugging as **consciousness elevation**, not mere error correction.

---

## Phase 1: Reproduction & Understanding (15-30 min)

### Step 1: Reproduce the Bug (Cause-Effect)

**Before touching any code**, reproduce the issue reliably.

**Process**:
1. Follow exact steps from bug report
2. Document what you observe vs what's expected
3. Try edge cases and variations
4. Note any error messages or stack traces

**If you can't reproduce**:
- Ask for more details
- Try different environments
- Check if it's intermittent
- Verify you're using same conditions

**Principle of Cause-Effect**: Can't fix what you can't observe.

---

### Step 2: Deep Understanding (Mentalism)

**Command**: `/gnosis "bug description and symptoms"`

**Example**:
```
/gnosis "Users report that notifications aren't being delivered
for events created after midnight UTC. Error logs show
'NullPointerException in NotificationService line 42'.
What could cause this time-based failure?"
```

**Gnosis provides**:
- Potential root causes
- Common patterns for this error type
- Questions to investigate
- Related system knowledge

**Log command usage**:
```bash
hm cmd gnosis "bug: notification delivery"
```

**Deliverable**: Hypothesis list of potential causes

---

### Step 3: Gather Context (Correspondence)

**Questions to answer**:
- When did this start happening?
- What changed recently? (code, config, dependencies, data)
- Does it affect all users or specific subset?
- Are there patterns? (time-based, data-based, user-based)
- What does the full error stack trace show?
- What do the logs reveal?

**Command**: `hm context`
**Why**: Understand current codebase state

**Tools**:
```bash
# Git history
git log --oneline --since="1 week ago"

# Recent changes to affected file
git log -p path/to/buggy/file.js

# Who last touched this code
git blame path/to/buggy/file.js
```

---

## Phase 2: Diagnosis (30 min - 2 hours)

### Step 4: Systematic Debugging (Mentalism + Cause-Effect)

**Skill**: `debug-like-master`

Invoke the debugging skill:
```
"apply debug-like-master skill to this notification delivery bug"
```

**Log skill usage**:
```bash
hm skill debug-like-master "bug: notification delivery"
```

**The skill guides you through**:
1. **Isolate**: Narrow down the problem space
2. **Hypothesize**: Form testable theories
3. **Test**: Verify each hypothesis
4. **Eliminate**: Rule out causes systematically
5. **Converge**: Zero in on root cause

---

### Step 5: Binary Search the Problem (Cause-Effect)

**Mental model**: Cut problem space in half repeatedly

**Example for notification bug**:

```
Full system: [Client → API → Queue → Worker → Notification Service → External API]

Test 1: Does notification reach the queue?
- YES → Problem is after queue
- NO → Problem is before queue

If YES (problem after queue):
Test 2: Does worker receive notification?
- YES → Problem in Notification Service or External API
- NO → Problem in queue processing

If YES (problem in Notification Service):
Test 3: Does NotificationService.send() get called?
- YES → Problem in send() implementation or External API
- NO → Problem in worker's service invocation

Continue until isolated...
```

**Deliverable**: Specific function/line where bug occurs

---

### Step 6: Understand the Root Cause (Mentalism)

**Don't stop at symptoms**. Find the **why**.

**Example**:
```
❌ Symptom: NullPointerException at line 42
✓ Root Cause: Notifications created after midnight UTC
              have null timezone in database because
              migration script missed edge case

❌ Fix symptom: Add null check at line 42
✓ Fix root cause: Fix migration, backfill data, prevent in future
```

**Command**: `/gnosis "why would [observed behavior] happen?"`

**The "Five Whys" technique**:
1. Why does NotificationService crash? → Null timezone
2. Why is timezone null? → Database has null value
3. Why is it null in database? → Migration didn't set default
4. Why didn't migration set default? → Missed edge case for midnight events
5. Why was edge case missed? → No test for midnight boundary

**Deliverable**: Root cause identified and understood

---

## Phase 3: Fix Implementation (30 min - 2 hours)

### Step 7: Design the Fix (Correspondence)

**Questions**:
1. **What's the minimal fix?** (Vibration - ship quickly)
2. **What's the complete fix?** (Cause-Effect - address root cause)
3. **Are there similar bugs elsewhere?** (Correspondence - patterns repeat)

**Agent**: Relevant domain agent
- `backend-architect` for backend bugs
- `frontend-developer` for UI bugs
- `database-architect` for data bugs

**Example**:
```
"backend-architect, I found that notifications created at midnight UTC
have null timezones due to a migration edge case. What's the safest way
to fix this both for new data and backfill existing data?"
```

**Log agent usage**:
```bash
hm agent backend-architect "bug: notification timezone"
```

**Deliverable**: Fix strategy (immediate + long-term if needed)

---

### Step 8: Write Test That Fails (Cause-Effect)

**Before fixing, write test that reproduces the bug**

**Agent**: `test-writer-fixer`

```
"test-writer-fixer, write a test that reproduces the notification
timezone bug for events created at midnight UTC"
```

**Log agent usage**:
```bash
hm agent test-writer-fixer "bug: notification timezone"
```

**Why**:
- Proves you can reproduce it
- Ensures fix actually works
- Prevents regression in future

**Test should FAIL** before your fix, PASS after.

---

### Step 9: Implement the Fix (Vibration)

**Implement** the minimal fix that addresses root cause.

**Principles**:
- **Change as little as possible** (reduce risk)
- **Fix root cause, not symptoms** (prevent recurrence)
- **Add defensive code** (prevent similar issues)

**Example fix**:
```javascript
// Before (buggy)
function createNotification(event) {
    return {
        eventId: event.id,
        timestamp: event.time,
        timezone: event.timezone  // BUG: can be null!
    };
}

// After (fixed)
function createNotification(event) {
    return {
        eventId: event.id,
        timestamp: event.time,
        timezone: event.timezone || 'UTC'  // Default to UTC if null
    };
}

// Better (prevents at source)
// Also fix the migration script and add validation
```

---

### Step 10: Verify Fix Works (Cause-Effect)

**Run the test** you wrote in Step 8:
- Should PASS now
- If not, fix isn't complete

**Manually test**:
- Reproduce original bug steps
- Bug should be gone
- No new bugs introduced

**Command**: `/verify "notification timezone bug is fixed"`

**Checklist**:
- [ ] Test passes
- [ ] Original bug unreproducible
- [ ] No regressions introduced
- [ ] Edge cases handled
- [ ] Root cause addressed

---

## Phase 4: Prevention & Learning (15-30 min)

### Step 11: Code Review Your Fix (Mentalism + Correspondence)

**Agent**: `code-reviewer`

```
"code-reviewer, review this bug fix for the notification timezone issue.
Check for potential side effects and similar bugs elsewhere."
```

**Log agent usage**:
```bash
hm agent code-reviewer "bug: notification timezone fix"
```

**Review checks**:
- Does fix address root cause?
- Are there similar bugs elsewhere?
- Is the fix safe?
- Any performance implications?
- Is error handling adequate?

---

### Step 12: Find Similar Bugs (Correspondence)

**Principle of Correspondence**: Patterns repeat across levels.

**Search codebase** for similar patterns:
```bash
# If bug was null timezone
grep -r "event.timezone" .

# If bug was midnight boundary
grep -r "midnight\|00:00\|boundary" .
```

**Fix proactively** before users encounter them.

---

### Step 13: Add Defensive Measures (Cause-Effect)

**Prevent this class of bugs** in the future:

**Options**:
1. **Type system**: Use non-nullable types
   ```typescript
   // TypeScript example
   interface Event {
       timezone: string;  // Not string | null
   }
   ```

2. **Validation**: Check at boundaries
   ```javascript
   function createEvent(data) {
       if (!data.timezone) {
           throw new Error('Timezone required');
       }
       // ...
   }
   ```

3. **Database constraints**: Add NOT NULL
   ```sql
   ALTER TABLE events
   ALTER COLUMN timezone SET NOT NULL,
   ALTER COLUMN timezone SET DEFAULT 'UTC';
   ```

4. **Linting**: Add rule to catch this
   ```javascript
   // .eslintrc
   "no-null-timezone": "error"
   ```

---

### Step 14: Document the Learning (Mentalism)

**Create or update** documentation:

```markdown
## Known Issues & Fixes

### Notification Timezone Bug (2025-10-29)

**Symptom**: NullPointerException in NotificationService
**Root Cause**: Events created at midnight UTC had null timezone
**Fix**: Updated migration, added default value, backfilled data
**Prevention**: Added database constraint, type validation
**Learning**: Always handle timezone explicitly, midnight is edge case
**Test**: test/notifications/timezone-edge-cases.test.js
```

**Why**: Future developers (including future you) learn from this.

---

### Step 15: Commit with Context (Correspondence)

**Git commit** should tell the story:

```bash
git add .
git commit -m "Fix notification delivery for midnight UTC events

**Bug**: Notifications created exactly at midnight UTC were failing
with NullPointerException due to null timezone field.

**Root Cause**: Migration script didn't set default timezone for
edge case where event.time.hour === 0 and event.time.minute === 0.

**Fix**:
- Updated migration to set UTC default for null timezones
- Backfilled existing data
- Added database NOT NULL constraint
- Added validation at service layer
- Created test for midnight boundary case

**Prevention**:
- Database constraint prevents null timezones
- Service validation catches missing data
- Test suite now covers midnight edge case

**Principle**: Cause-Effect - Traced bug to root cause and prevented
recurrence through defensive measures.

Fixes #1234

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Why this format**:
- Future developers understand the context
- Bug tracking system linked (#1234)
- Learning captured for posterity
- Hermetic principle noted

---

## Phase 5: Validation & Shipping (15-30 min)

### Step 16: Test in Staging (Cause-Effect)

**Deploy to staging/preview** environment:
- Verify fix works in production-like environment
- Test with real-ish data
- Monitor for any issues

**Soak time**: Let it run for a few hours minimum

---

### Step 17: Monitor Metrics (Cause-Effect)

**Before deploying to production**, check:
- Error rate in staging (should be zero for this bug)
- Performance impact (should be negligible)
- Any unexpected behavior

**Agent**: `analytics-reporter`
```
"analytics-reporter, check staging environment for any anomalies
after deploying the notification timezone fix"
```

---

### Step 18: Ship to Production (Vibration)

**Deploy the fix**

**Monitor closely** for first few hours:
- Error rates
- User reports
- System performance

**Agent**: `project-shipper`
```bash
hm agent project-shipper "bug: notification timezone"
```

---

### Step 19: Verify in Production (Cause-Effect)

**After deployment**:
- [ ] Original bug is gone
- [ ] No new errors introduced
- [ ] Performance acceptable
- [ ] Users can confirm fix

**If issues arise**: Be ready to rollback quickly

---

### Step 20: Close Loop & Celebrate (Rhythm)

**Update bug tracker**: Mark as resolved
**Notify stakeholders**: Users, team, anyone waiting
**Celebrate**: Bug fixed, learning captured, system improved

```
/celebrate "Fixed notification timezone bug and prevented similar issues!"
```

**Why celebrate**: Positive reinforcement, team morale, rhythm completion

---

## Success Metrics

**Immediate**:
- [ ] Bug is reproducibly fixed
- [ ] Tests prevent regression
- [ ] Root cause addressed
- [ ] No new bugs introduced

**Short-term**:
- [ ] No recurrence in next week
- [ ] Similar bugs proactively fixed
- [ ] Learning documented

**Long-term**:
- [ ] This class of bugs prevented system-wide
- [ ] Team learned from the experience
- [ ] System more robust

---

## Common Pitfalls

### ❌ Fixing Symptoms, Not Root Cause
**Example**: Adding null check instead of fixing why it's null
**Consequence**: Bug recurs in different form
**Fix**: Always ask "why" until you hit root cause

### ❌ No Test for the Bug
**Consequence**: Bug returns, no regression detection
**Fix**: Always write failing test first

### ❌ Rushing to Fix Without Understanding
**Consequence**: Fix doesn't work or breaks something else
**Fix**: Take time to understand deeply (Mentalism)

### ❌ Not Searching for Similar Bugs
**Consequence**: Same bug exists elsewhere
**Fix**: Apply Correspondence - patterns repeat

### ❌ No Documentation
**Consequence**: Same bug gets fixed repeatedly
**Fix**: Document the learning for future

### ❌ Changing Too Much
**Consequence**: Hard to know what fixed it, risk of new bugs
**Fix**: Minimal change that addresses root cause

---

## When Stuck

If you can't figure out the bug after 2 hours:

```bash
hm unstuck
```

**Options**:
1. **Take a walk** - Let subconscious work on it
2. **Rubber duck debugging** - Explain it out loud
3. **Ask for help** - Fresh eyes see different things
4. **Sleep on it** - Seriously, sleep solves bugs
5. **Bisect the problem** - Use git bisect if recent regression

**Skill**: `debug-like-master` includes "stuck" strategies

---

## Bug Complexity Levels

### Level 1: Obvious (30 min)
- Clear error message
- Stack trace points to line
- Easy to reproduce
- Simple fix

**Example**: Typo in variable name

---

### Level 2: Moderate (1-2 hours)
- Reproducible but not obvious why
- Requires some investigation
- Multiple potential causes
- Needs testing to verify

**Example**: Null timezone bug (our example)

---

### Level 3: Complex (4-8 hours)
- Hard to reproduce
- Race condition or timing issue
- Requires deep system knowledge
- May need instrumentation

**Example**: Intermittent data corruption in distributed system

---

### Level 4: Hairy (days/weeks)
- Extremely rare or non-reproducible
- Affects production but not staging
- May require architecture changes
- Deep expertise needed

**For Level 3+**: Get help early, pair debug, consider refactoring

---

## Effectiveness Tracking

After fixing a bug:

```bash
# Rate workflow
hm rate workflow bug-fixing 5

# Rate tools used
hm rate skill debug-like-master 5
hm rate agent code-reviewer 4
hm rate command gnosis 5
```

**Track**:
- Time to fix
- Was root cause found?
- Did fix work first time?
- Did you prevent similar bugs?

**System learns** your debugging patterns and suggests better approaches.

---

## Integration with Daily Workflow

Bugs interrupt your planned work. Handle appropriately:

**Severity levels**:
- **Critical** (production down): Drop everything, fix now
- **High** (major feature broken): Fix within hours
- **Medium** (minor feature broken): Fix within day
- **Low** (cosmetic/edge case): Schedule in next sprint

**Protect rhythm**: Don't let bug fixing consume entire day
- Set time limit (e.g., 2 hours)
- If exceeding, get help or reschedule

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Mentalism, Cause-Effect, Correspondence
**Effectiveness**: Track with `hm rate workflow bug-fixing <1-5>`

*"Bugs are teachers. Debug with consciousness."*
