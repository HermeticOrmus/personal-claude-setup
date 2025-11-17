# Feature Implementation Workflow

**Purpose**: Ship new features with quality, aligned with user needs and Hermetic principles

**Hermetic Principles**: Mentalism, Correspondence, Cause-Effect, Vibration

**Estimated Time**: 4-6 hours (nested within daily workflow)

**Prerequisites**:
- Feature request/requirement understood
- Technical approach decided
- Time allocated in sprint

---

## Philosophy

Features should **serve genuine human needs** (Gold Hat principle), not extract value through manipulation. This workflow ensures:

1. **Mentalism**: Clear understanding before building
2. **Correspondence**: Implementation matches intention
3. **Cause-Effect**: Consequences considered
4. **Vibration**: Ship quickly, iterate based on reality

---

## Phase 1: Understanding (30 minutes)

### Step 1: Deep Understanding (Mentalism)

**Command**: `/gnosis "feature description and requirements"`

**Example**:
```
/gnosis "We need to add user notifications for important events.
Users have complained about missing critical updates.
How should we implement this without becoming annoying spam?"
```

**Gnosis provides**:
- Deep analysis of the need
- Potential approaches
- Ethical considerations
- Best practices

**Deliverable**: Clear mental model of what to build and why

---

### Step 2: Alignment Check (Gold Hat Principle)

**Command**: `/align`

Ask yourself:
1. **Does this serve genuine need or manufactured desire?**
   - Good: Help users stay informed of critical events
   - Bad: Maximize engagement through notification spam

2. **Does it empower or extract?**
   - Good: User controls notification preferences
   - Bad: No opt-out, defaults to all notifications

3. **Is it transparent?**
   - Good: Clear what notifications do and why
   - Bad: Hidden tracking under guise of notifications

4. **Does it respect autonomy?**
   - Good: User chooses frequency, channels, types
   - Bad: Company decides what's "important"

**If ANY answer violates Gold Hat principles**: Push back or modify approach.

---

### Step 3: Technical Planning (Correspondence)

**Agent**: `backend-architect` or relevant domain agent

```
"backend-architect, design the notification system architecture
considering these requirements: [list requirements]"
```

**Log usage**:
```bash
hm agent backend-architect "feature: notifications"
```

**Questions to answer**:
- How does this integrate with existing system?
- What's the data model?
- What are the edge cases?
- How will we test this?
- What could go wrong?

**Deliverable**: Architecture sketch/notes

---

## Phase 2: Implementation (2-3 hours)

### Step 4: Test-Driven Development (Cause-Effect)

**Agent**: `test-writer-fixer`

**Why**: Tests document expected behavior and catch regressions

```
"test-writer-fixer, write tests for notification system with these scenarios:
1. User receives notification for critical event
2. User can opt out of notifications
3. Notification preferences are persisted
4. No duplicate notifications
5. Rate limiting prevents spam"
```

**Log usage**:
```bash
hm agent test-writer-fixer "feature: notifications"
```

**Red-Green-Refactor**:
1. Write test (it fails - RED)
2. Implement minimum code to pass (GREEN)
3. Refactor for clarity (REFACTOR)

---

### Step 5: Core Implementation (Vibration)

**Agent**: Specialized agent for your domain
- `frontend-developer` for UI
- `backend-architect` for API
- `database-architect` for schema
- `mobile-app-builder` for native apps

**Process**:
1. **Implement minimum viable version first**
   - Core functionality only
   - Skip polish initially
   - Get it working

2. **Verify it works**
   ```
   /verify "notification system delivers notifications correctly"
   ```

3. **Iterate on quality**
   - Add error handling
   - Improve UX
   - Polish edge cases

**Log agent usage** as you go:
```bash
hm agent frontend-developer "feature: notifications"
```

**Principle of Vibration**: Ship imperfect, iterate. Don't polish before proving it works.

---

### Step 6: User Experience Check (Mentalism + Gold Hat)

**Agent**: `ui-designer` or `ux-researcher`

Ask yourself:
1. **Is the mental model clear?**
   - Can user understand how this works?
   - Is the UI intuitive?
   - Are error messages helpful?

2. **Does it delight?** (optional but valuable)
   **Agent**: `whimsy-injector`
   ```
   "whimsy-injector, add delightful moments to the notification preferences UI"
   ```

3. **Is it accessible?**
   - Screen reader compatible?
   - Keyboard navigable?
   - Color contrast sufficient?

---

## Phase 3: Quality & Ethics (1-2 hours)

### Step 7: Code Review (Mentalism + Correspondence)

**Agent**: `code-reviewer`

```
"code-reviewer, review the notification system implementation
focusing on security, performance, and code quality"
```

**Log usage**:
```bash
hm agent code-reviewer "feature: notifications"
```

**Address** all critical and medium issues before shipping.

**Deliverable**: Clean, reviewed code

---

### Step 8: Security Check (Cause-Effect)

**Agent**: `security-engineer`

**Critical for features that**:
- Handle user data
- Send external communications
- Modify permissions
- Process sensitive information

```
"security-engineer, review notification system for security vulnerabilities"
```

**Key questions**:
- Can user A trigger notifications for user B?
- Is input sanitized?
- Are notification contents encrypted in transit?
- Can this be used for spam/abuse?
- Rate limiting in place?

**Log usage**:
```bash
hm agent security-engineer "feature: notifications"
```

---

### Step 9: Dark Pattern Check (Gold Hat Critical)

**Agent**: `extraction-pattern-detector`

```
"extraction-pattern-detector, analyze the notification system
for any extraction patterns or manipulation tactics"
```

**This agent checks for**:
- Manipulative defaults
- Hidden opt-outs
- Unnecessary friction
- FOMO mechanics
- Privacy violations

**If issues found**: Fix them. Non-negotiable.

**Log usage**:
```bash
hm agent extraction-pattern-detector "feature: notifications"
```

---

### Step 10: Performance Testing (Cause-Effect)

**Agent**: `performance-benchmarker`

```
"performance-benchmarker, test notification system performance
under various load conditions"
```

**Test scenarios**:
- Normal load (expected users)
- Peak load (2x expected)
- Stress test (10x expected)
- Edge cases (user with 10,000 notifications)

**Ensure**:
- Response times acceptable
- No memory leaks
- Graceful degradation
- Rate limiting works

---

## Phase 4: Documentation & Shipping (30 minutes)

### Step 11: Documentation (Correspondence)

**Document**:
1. **User-facing**: How to use the feature
2. **Developer-facing**: How it works technically
3. **Why decisions**: Explain the rationale

**Template**:
```markdown
# Notification System

## Purpose
Users need to stay informed of critical events without being spammed.

## User Guide
[How users interact with this feature]

## Architecture
[Technical implementation details]

## Configuration
[Settings and options]

## Why We Built It This Way
- Opted for opt-in by default to respect user autonomy
- Used rate limiting to prevent spam
- Allowed granular control to empower users
```

---

### Step 12: Verification Before Shipping (Cause-Effect)

**Command**: `/verify`

**Checklist**:
```
/verify "Notification system checklist:
- [ ] All tests passing
- [ ] Code reviewed and approved
- [ ] Security check passed
- [ ] No dark patterns detected
- [ ] Performance acceptable
- [ ] Documentation complete
- [ ] User preferences respected
- [ ] Opt-out clearly available"
```

**Do NOT ship** until all items checked.

---

### Step 13: Create Pull Request (if using PR workflow)

**Agent**: `project-shipper`

Use automated PR creation:
```bash
# Ensure changes committed
git add .
git commit -m "Add user notification system

- Implement notification delivery mechanism
- Add user preference controls
- Ensure opt-out is prominent
- Add rate limiting to prevent spam
- Write comprehensive tests
- Security review passed

Hermetic Principle: Empowers users through timely info while respecting autonomy.

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

# Create PR (if gh CLI available)
gh pr create --title "Add User Notification System" --body "
## Summary
Implements notification system that keeps users informed without being intrusive.

## Hermetic Principles Applied
- **Mentalism**: Clear mental model for users
- **Cause-Effect**: Considered all downstream effects
- **Gold Hat**: Empowers users, respects autonomy

## Testing
- [ ] Unit tests: 15 passing
- [ ] Integration tests: 8 passing
- [ ] Security review: Passed
- [ ] Dark pattern check: Clean
- [ ] Performance test: Acceptable

## User Impact
- Users can now stay informed of critical events
- Full control over notification preferences
- Easy opt-out available
- No spam risk due to rate limiting
"
```

---

### Step 14: Ship It (Vibration)

**Deploy to production** (or merge PR)

**After shipping**:
```bash
hm agent project-shipper "feature: notifications"
```

**Celebrate**:
```
/celebrate "Shipped notification system that empowers users!"
```

**Why celebrate**: Positive reinforcement, rhythm completion, team morale.

---

## Phase 5: Learning & Iteration (Ongoing)

### Step 15: Monitor Real Usage

**Agent**: `analytics-reporter`

After 1 week:
```
"analytics-reporter, analyze notification system usage and user behavior"
```

**Questions**:
- Are users actually using it?
- What's the opt-out rate?
- Any error patterns?
- Performance in production?

---

### Step 16: Gather Feedback

**Agent**: `feedback-synthesizer`

```
"feedback-synthesizer, analyze user feedback about notification system"
```

**Sources**:
- Support tickets
- User reviews
- Direct feedback
- Analytics data

---

### Step 17: Iterate

**Based on learnings**:
1. Fix bugs
2. Improve UX
3. Add requested features
4. Remove unused features

**Principle of Vibration**: Continuous improvement through real-world feedback.

---

## Success Metrics

**Immediate (Day 1)**:
- [ ] Feature deployed without incidents
- [ ] All tests passing in production
- [ ] No security issues
- [ ] Documentation complete

**Short-term (Week 1)**:
- [ ] Users actually using the feature (>10% adoption)
- [ ] Opt-out rate reasonable (<20%)
- [ ] No critical bugs
- [ ] Performance acceptable

**Long-term (Month 1)**:
- [ ] Positive user feedback
- [ ] Measurable improvement in user experience
- [ ] Feature serving genuine need
- [ ] No dark patterns emerged

**Gold Hat Alignment**:
- [ ] Feature empowers users
- [ ] Respects user autonomy
- [ ] Transparent operation
- [ ] No manipulation detected

---

## Common Pitfalls

### ❌ Skipping `/gnosis` and `/align`
**Consequence**: Build wrong thing or violate principles
**Fix**: Always start with understanding and alignment

### ❌ No Tests Before Implementation
**Consequence**: Bugs, unclear requirements, regression risk
**Fix**: TDD approach, write tests first

### ❌ Skipping Security/Dark Pattern Checks
**Consequence**: Ship vulnerable or manipulative code
**Fix**: Make these checks mandatory, no exceptions

### ❌ Over-Engineering First Version
**Consequence**: Violates Vibration, delays learning
**Fix**: Ship MVP, iterate based on reality

### ❌ No Documentation
**Consequence**: Future confusion, maintenance hell
**Fix**: Document as you build, not after

### ❌ Shipping Without `/verify`
**Consequence**: Broken production, user frustration
**Fix**: Never skip verification checklist

---

## Effectiveness Tracking

After completing this workflow:

```bash
# Rate the workflow
hm rate workflow feature-implementation 5

# Rate specific agents used
hm rate agent backend-architect 5
hm rate agent code-reviewer 4
hm rate agent extraction-pattern-detector 5
```

**System learns** which workflows and agents work best for you.

---

## Integration with Daily Workflow

This workflow nests inside your daily development workflow:

**Day 1**: Phase 1 (Understanding) + Phase 2 start (Implementation)
**Day 2**: Phase 2 completion (Implementation)
**Day 3**: Phase 3 (Quality & Ethics)
**Day 4**: Phase 4 (Documentation & Shipping)
**Day 5**: Phase 5 start (Monitor early results)

Adjust based on feature complexity.

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Mentalism, Correspondence, Cause-Effect, Vibration
**Gold Hat Alignment**: Critical
**Effectiveness**: Track with `hm rate workflow feature-implementation <1-5>`

*"Ship with conscience. Empower with code."*
