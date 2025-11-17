---
name: debug-like-master
description: Domain-specific Hermetic workflow for debugging using Mentalism + Cause-Effect + Correspondence
category: hermetic-domain
domain: Debugging
principles: Mentalism, Cause-Effect, Correspondence
---

## Debug Like a Master - Hermetic Debugging Workflow

**Domain:** Software Debugging
**Principles Applied:** Mentalism (clear mental model) + Cause-Effect (trace to root) + Correspondence (check alignment)

### Purpose
Debug complex issues systematically by understanding the system, tracing causality, and checking alignment.

### When to Use
- Bug is elusive or mysterious
- Issue only happens in certain conditions
- "Works on my machine" problems
- Performance degradation
- System behaving unexpectedly

### The Hermetic Debugging Process

**Step 1: MENTALISM - Understand the System**
```
Before debugging, ensure you understand HOW IT SHOULD WORK:

1. What is the mental model of this system?
   - What should happen in the happy path?
   - What are the entities and flows?
   - What state changes occur?

2. If mental model unclear → Study code first
3. Never debug what you don't understand
4. Clear understanding → Obvious problems
```

**Step 2: CAUSE-EFFECT - Trace to Root Cause**
```
Use the 5 WHYS to find root cause:

Symptom: "Users seeing error 500"
Why? → Database query failing
Why? → Connection pool exhausted
Why? → Too many concurrent requests
Why? → No rate limiting
Why? → Never implemented it
ROOT CAUSE → Missing rate limiting

Always ask "Why?" not "How do I fix this symptom?"
Fix root cause, not symptoms
```

**Step 3: CORRESPONDENCE - Check Alignment**
```
Bugs often hide in misalignment:

Mental Model ↔ Actual Code
- Does code match what you THINK it does?
- Common: Assumptions don't match reality

API Contract ↔ Implementation
- Does implementation match API contract?
- Common: Undocumented behavior

Frontend State ↔ Backend State
- Are both sides in sync?
- Common: Stale data, race conditions

Database Schema ↔ Application Model
- Do models match tables?
- Common: Migration not run, schema drift

Check for broken correspondence
```

**Step 4: REPRODUCE - Make Bug Visible**
```
Following Vibration principle (movement reveals truth):

1. Create minimal reproduction case
2. Make bug happen on demand
3. If can't reproduce → Not a bug you can fix
4. If can reproduce → You can fix it

Reproducible bugs are half-solved bugs
```

**Step 5: ISOLATE - Narrow the Scope**
```
Using Mentalism (clear thinking) to eliminate noise:

1. Binary search the problem:
   - Does it happen with half the code disabled?
   - Narrow down to specific module/function/line

2. Remove variables:
   - Same environment? (dev vs prod)
   - Same data? (test vs real)
   - Same timing? (race condition?)

3. Isolate to single factor
```

**Step 6: HYPOTHESIZE & TEST**
```
Using Cause-Effect (predict consequences):

1. Form hypothesis: "I think X is causing Y because..."
2. Predict: "If my hypothesis is correct, then when I do Z, W will happen"
3. Test prediction
4. If prediction TRUE → Hypothesis likely correct
5. If prediction FALSE → New hypothesis

Scientific method applied to debugging
```

**Step 7: FIX ROOT CAUSE**
```
Using Cause-Effect to prevent recurrence:

1. Fix the ROOT cause (not symptom)
2. Add safeguards to prevent recurrence:
   - Add tests that would catch this
   - Add logging for visibility
   - Add validation to prevent bad state
   - Improve error messages

3. Update mental model if it was wrong
```

### Expected Outcome
- Root causes identified (not symptoms treated)
- Systematic approach (not random fixes)
- Understanding deepened (not just bug fixed)
- Future bugs prevented (safeguards added)
- Faster debugging over time (mental models improve)

### Example Application

**Bug:** "Users can't log in sometimes"

**Mentalism:** Understand auth flow
- User submits credentials
- Server validates against database
- JWT token generated and returned
- Client stores token in localStorage

**Cause-Effect:** Trace the failure
Why can't users log in?
→ Token not being returned
Why? → Database query timing out
Why? → Query taking too long
Why? → Missing index on users table
Why? → Migration never ran
ROOT: Migration system failed silently

**Correspondence:** Check alignment
Mental model: "Migration system runs automatically"
Reality: Migration system requires manual trigger in production
MISALIGNMENT FOUND

**Fix:**
1. Run missing migration (immediate fix)
2. Add migration status check to deployment (prevent recurrence)
3. Add monitoring for query performance (early warning)
4. Update mental model about deployment process

### Hermetic Truth
> "Understanding the system (Mentalism), tracing to root cause (Cause-Effect), and checking alignment (Correspondence) makes mysterious bugs obvious."

---

**Master debugging is master thinking.**
