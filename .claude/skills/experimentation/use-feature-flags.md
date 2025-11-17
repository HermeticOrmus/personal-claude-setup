---
name: use-feature-flags
description: Implement and manage feature flags for safe production experimentation
category: experimentation
principle: Vibration
---

# Use Feature Flags - Safe Production Experimentation

**Hermetic Principle**: Vibration - "Ship continuously, experiment safely, iterate rapidly"

**When to use**: Risky changes, gradual rollouts, A/B testing, incomplete work

---

## Quick Concept

**Problem**: Deploy new feature → breaks for everyone → emergency rollback → hours of panic

**Solution**: Feature flag → deploy disabled → enable for 5% → monitor → scale or kill instantly

**Result**: Ship confidently, experiment safely, learn from reality

---

## The 3-Minute Implementation

### Step 1: Add Flag (1 min)

```typescript
// feature-flags.ts
const FLAGS = {
  'my-new-feature': {
    enabled: true,
    percentage: 5  // Start at 5%
  }
};

export function isEnabled(flagName: string, userId: string): boolean {
  const flag = FLAGS[flagName];
  if (!flag || !flag.enabled) return false;

  const bucket = simpleHash(userId) % 100;
  return bucket < flag.percentage;
}

function simpleHash(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = ((hash << 5) - hash) + str.charCodeAt(i);
  }
  return Math.abs(hash);
}
```

---

### Step 2: Wrap Feature (1 min)

```typescript
// Before
function processPayment() {
  return oldPaymentFlow();
}

// After
import { isEnabled } from './feature-flags';

function processPayment(userId: string) {
  if (isEnabled('new-payment-flow', userId)) {
    return newPaymentFlow();  // 5% of users
  }
  return oldPaymentFlow();  // 95% of users
}
```

---

### Step 3: Monitor & Adjust (1 min)

```typescript
// Check metrics
const metrics = {
  oldFlow: { successRate: 98%, avgTime: 2.5s },
  newFlow: { successRate: 99.5%, avgTime: 1.8s }
};

// New flow better? Scale up
FLAGS['new-payment-flow'].percentage = 25;  // 5% → 25%

// Issues? Kill instantly
FLAGS['new-payment-flow'].enabled = false;  // Everyone back to old flow
```

**Done. Feature flag deployed in 3 minutes.**

---

## The Decision Tree

### Should I Flag This?

**✅ YES - Flag it:**
- New payment processing
- Algorithm changes
- Major refactoring
- Database schema migrations
- Third-party integrations
- UI redesigns
- Performance optimizations (need validation)

**❌ NO - Just ship it:**
- Bug fixes (ship immediately)
- Simple content updates
- Copy changes
- Minor CSS tweaks
- Documentation updates

**Rule**: If failure affects >100 users or costs >1 hour to rollback, flag it.

---

## The Gradual Rollout Pattern

**Use this for every major feature:**

```markdown
## Day 1: Internal Testing
percentage: 0
whitelist: [team_member_ids]
→ Team validates basic functionality

## Day 3: Canary (1%)
percentage: 1
→ Real users, minimal blast radius
→ Monitor: Error rates, performance

## Day 5: Small Rollout (5%)
percentage: 5
→ Enough signal to detect issues
→ Monitor: User feedback, metrics

## Day 7: Larger Rollout (25%)
percentage: 25
→ Significant validation
→ Monitor: Support tickets, conversion

## Day 10: Majority (75%)
percentage: 75
→ Near full confidence
→ Monitor: Edge cases

## Day 14: Full Rollout (100%)
percentage: 100
→ Feature stable
→ Monitor: 2 weeks before cleanup

## Day 21: Cleanup
→ Remove flag code
→ Delete old implementation
```

**Why this works**: Catches issues at 1-5% before affecting 100%. Instant rollback vs hours of emergency deploy.

---

## The Kill Switch Pattern

**For critical features with failure risk:**

```typescript
// Auto-disable on errors
if (errorRate > threshold) {
  FLAGS['new-payment-flow'].enabled = false;
  alertTeam('Payment flow auto-disabled due to errors');
  logIncident({
    feature: 'new-payment-flow',
    reason: 'error_rate_threshold_exceeded',
    errorRate,
    threshold
  });
}
```

**Real scenario:**
```
3:00 AM: Deploy new payment flow (10% rollout)
3:15 AM: Monitoring detects error spike
3:16 AM: Auto-disable flag
3:17 AM: Error rate back to normal (users on old flow)
Morning: Debug issue calmly, fix, re-enable gradually
```

**Benefit**: Sleep through production issues (they fix themselves).

---

## The A/B Test Pattern

**When you have two competing approaches:**

```typescript
function getSearchResults(query: string, userId: string) {
  const variant = getVariant('search-algorithm', userId);

  switch (variant) {
    case 'elastic':
      return elasticSearch(query);
    case 'postgres-fts':
      return postgresFullTextSearch(query);
    default:
      return elasticSearch(query);  // Control
  }
}

// Configuration
{
  name: 'search-algorithm',
  variants: [
    { name: 'elastic', percentage: 50 },
    { name: 'postgres-fts', percentage: 50 }
  ]
}
```

**Analysis after 2 weeks:**
```markdown
**Elastic** (50% users):
- Response: 120ms
- Relevance: 7.2/10
- Cost: $200/month

**Postgres FTS** (50% users):
- Response: 85ms (30% faster!)
- Relevance: 7.5/10 (better!)
- Cost: $0 (already paying for Postgres)

Decision: Postgres FTS wins → Roll out to 100%
```

---

## Integration with Hermetic Systems

### 1. Sprint Planning

**During Sprint Opening, plan flag lifecycle:**

```markdown
## Sprint 15 - Feature Flag Strategy

**Feature**: Dashboard redesign

**Flag**: `dashboard-v2`

**Rollout Plan**:
- Sprint 15: Build + flag (disabled)
- Sprint 16: Team testing (whitelist)
- Sprint 17: 5% rollout, monitor metrics
- Sprint 18: 25% if metrics good
- Sprint 19: 100% rollout
- Sprint 20: Remove flag code

**Success Metrics**:
- Page load < 1s (currently 1.5s)
- Session time +20%
- Error rate < 0.1%

**Kill Switch Triggers**:
- Error rate > 1%
- Page load > 2s
- User complaints > 5
```

---

### 2. Dev Docs Layer 3

**Extract flag insights to Layer 3:**

```markdown
## ⚡ Layer 3: Critical Insights

### 🎯 Key Patterns (Feature Flags)
**Gradual rollout saved us**: Caught performance bug at 5% rollout (dashboard-v2). Fixed before wider release. Without flag, would've affected all 10K users.

### ⚠️ Gotchas
**Flag fatigue is real**: Had 15 active flags, team confused. Now limit to 5 max. Queue new flags until old ones cleaned up.

### 💎 Breakthroughs
**Kill switch prevented disaster**: Payment bug at 3 AM, auto-disabled, zero customer impact. Manual rollback would've taken 2+ hours.
```

---

### 3. Knowledge Graph

**Capture flag decisions:**

```bash
# Create flag entity
mcp__memory__create_entities({
  entities: [{
    name: "dashboard-v2 Feature Flag",
    entityType: "Decision",
    observations: [
      "Created: Sprint 15 (2024-12-15)",
      "Rollout: 5% → 25% → 100% over 3 weeks",
      "Success: Page load 1.5s → 0.8s, exceeded targets",
      "Learning: Caught performance regression at 5%, fixed before scaling",
      "Removed: Sprint 20 (2025-01-12)"
    ]
  }]
})

# Connect to project
mcp__memory__create_relations({
  relations: [{
    from: "dashboard-v2 Feature Flag",
    to: "Midnight-Sun Project",
    relationType: "deployed-in"
  }]
})
```

---

## Flag Management Rules

### Rule 1: Maximum 5 Active Flags

**Problem**: Too many flags → confusion

**Solution**: Queue system

```markdown
## Active Flags (3/5 slots)
1. `dashboard-v2` (Rollout: 25%, Remove: Sprint 20)
2. `search-v2` (Testing: Team only, Remove: Sprint 21)
3. `payment-v3` (Rollout: 5%, Remove: Sprint 22)

## Queued (Waiting for slot)
- `notification-system` (Blocked until dashboard-v2 done)
- `mobile-redesign` (Blocked until search-v2 done)

**Policy**: No new flag until slot opens (FIFO)
```

---

### Rule 2: 90-Day Maximum Lifetime

**Problem**: Stale flags accumulate

**Solution**: Automated enforcement

```typescript
// CI check - fails build if flag >90 days old
function checkStaleFlagsCI() {
  const staleFlags = FLAGS.filter(flag => {
    const age = daysSince(flag.created);
    return age > 90;
  });

  if (staleFlags.length > 0) {
    console.error('Stale flags detected (>90 days):');
    staleFlags.forEach(f => console.error(`- ${f.name} (${daysSince(f.created)} days)`));
    console.error('\nAction: Remove flag or justify extension.');
    process.exit(1);  // Fail CI
  }
}
```

---

### Rule 3: Document Every Flag

**Bad:**
```typescript
if (FLAGS['feature-123']) { ... }
```

**Good:**
```typescript
// Flag: dashboard-v2 (ADR-045)
// Purpose: Gradual rollout of redesigned dashboard
// Created: 2024-12-15
// Target removal: Sprint 20 (2025-01-15)
// Kill switch: Auto-disable if page load > 2s
if (isEnabled('dashboard-v2', userId)) {
  return <DashboardV2 />;
}
return <DashboardV1 />;  // Remove after cleanup
```

---

## Common Workflows

### Workflow 1: Launch New Feature

**Checklist:**

```markdown
## New Feature Launch: [Feature Name]

**Pre-launch:**
- [ ] Create flag in config (disabled, 0%)
- [ ] Wrap feature in flag check
- [ ] Document flag purpose (ADR if complex)
- [ ] Add flag to active flags tracker
- [ ] Set removal target date (Sprint N+4)
- [ ] Define success metrics
- [ ] Define kill switch triggers

**Launch (Day 1):**
- [ ] Enable for team (whitelist only)
- [ ] Team validates basic functionality
- [ ] Fix obvious bugs before wider rollout

**Scale (Days 3-14):**
- [ ] Day 3: 1% rollout, monitor errors
- [ ] Day 5: 5% rollout, check metrics vs targets
- [ ] Day 7: 25% rollout, gather feedback
- [ ] Day 10: 75% rollout, validate edge cases
- [ ] Day 14: 100% rollout

**Stabilize (Days 14-21):**
- [ ] Monitor for 2 weeks at 100%
- [ ] Validate success metrics met
- [ ] Confirm no regressions

**Cleanup (Day 21+):**
- [ ] Remove flag from code
- [ ] Delete old implementation
- [ ] Remove from config
- [ ] Update active flags tracker
- [ ] Extract learnings to Dev Docs Layer 3
```

---

### Workflow 2: Emergency Rollback

**When production breaks:**

```bash
# Immediate (30 seconds)
1. Open feature-flags.ts
2. Set enabled: false
3. Commit + push (or manual config update)
4. Verify users back on old flow
5. Alert team

# Follow-up (Next day)
1. Debug root cause
2. Fix issue
3. Test thoroughly
4. Re-enable gradually (1% → 5% → ...)
```

**Why flags are critical**: 30-second rollback vs 2-hour emergency deploy + testing + rollout.

---

### Workflow 3: A/B Test

**Setup:**

```typescript
// 1. Configure variants
{
  name: 'pricing-page',
  variants: [
    { name: 'monthly-first', percentage: 50 },
    { name: 'annual-first', percentage: 50 }
  ]
}

// 2. Implement variants
function PricingPage({ userId }) {
  const variant = getVariant('pricing-page', userId);

  if (variant === 'monthly-first') {
    return <PricingMonthlyFirst />;
  }
  return <PricingAnnualFirst />;
}

// 3. Track metrics
trackEvent('pricing_page_view', { variant, userId });
trackEvent('pricing_conversion', { variant, userId, plan });
```

**Analysis (after 2 weeks):**

```markdown
## A/B Test Results: Pricing Page

**Monthly-First** (50% users):
- Views: 10,000
- Conversions: 250 (2.5%)
- Revenue: $12,500

**Annual-First** (50% users):
- Views: 10,000
- Conversions: 200 (2.0%)
- Revenue: $20,000 (higher AOV!)

**Decision**: Annual-first wins on revenue (our goal)
**Action**: Roll out annual-first to 100%
```

---

## Troubleshooting

### Issue: Flag not working as expected

**Debug checklist:**

```typescript
// 1. Check flag exists and enabled
console.log('Flag config:', FLAGS['my-feature']);
// Expected: { enabled: true, percentage: 5 }

// 2. Check user bucketing
console.log('User bucket:', simpleHash(userId) % 100);
// Should be consistent (same user → same bucket)

// 3. Check flag evaluation
console.log('Is enabled?', isEnabled('my-feature', userId));
// Should match expectations based on percentage

// 4. Verify feature code path
if (isEnabled('my-feature', userId)) {
  console.log('New flow triggered');
} else {
  console.log('Old flow triggered');
}
```

---

### Issue: Can't decide rollout percentage

**Guidelines:**

```markdown
## Rollout Percentage Decision Tree

**High risk feature** (payments, auth, data loss potential):
→ Start: 1%
→ Scale: 1% → 5% → 10% → 25% → 50% → 100%
→ Duration: 3-4 weeks

**Medium risk feature** (UI changes, new workflows):
→ Start: 5%
→ Scale: 5% → 25% → 75% → 100%
→ Duration: 2 weeks

**Low risk feature** (cosmetic, analytics, optional):
→ Start: 25%
→ Scale: 25% → 100%
→ Duration: 1 week

**Rule**: If unsure, start smaller and scale slower.
```

---

### Issue: Too many flags accumulating

**Audit & cleanup:**

```bash
# Monthly flag audit (15 min)

# 1. List all flags
grep -r "isEnabled\|FLAGS\[" --include="*.ts" --include="*.js"

# 2. Check age
# For each flag, check git history:
git log --all --oneline --grep="flag-name"

# 3. Classify
echo "Active (< 90 days, not 100%): [list]"
echo "Stable (100% for 2+ weeks): [cleanup candidates]"
echo "Stale (> 90 days): [must cleanup]"

# 4. Cleanup stale flags
# For each:
# - Remove flag check from code
# - Delete old implementation
# - Remove from config
# - Git commit with reason
```

---

## Success Metrics

### You're using flags well when:

**Qualitative:**
- ✅ Ship without fear (know you can rollback)
- ✅ Catch issues early (small % affected)
- ✅ No emergency 2 AM deploys (flags handle rollback)
- ✅ Flags cleaned up promptly (not accumulating)
- ✅ Team understands what's flagged

**Quantitative:**
- ✅ Active flags: ≤5 at any time
- ✅ Flag lifetime: <90 days (created → removed)
- ✅ Rollback time: <5 minutes (vs hours for redeploy)
- ✅ Blast radius: <10% users for issues
- ✅ Deployment frequency: Daily (flags enable continuous deployment)

---

## Quick Reference

### When to Flag

**Flag it:**
- Risky changes (payments, auth, data)
- Gradual rollouts (validate before scaling)
- A/B tests (compare approaches)
- Incomplete work (merge disabled, enable when ready)

**Don't flag:**
- Bug fixes (ship immediately)
- Simple content changes
- Everything (flag fatigue)

---

### Rollout Timeline

```
Day 1:   Team testing (whitelist)
Day 3:   1% canary
Day 5:   5% small rollout
Day 7:   25% larger rollout
Day 10:  75% majority
Day 14:  100% full rollout
Day 21:  Remove flag code
```

---

### Flag Lifecycle

```
Created (Sprint N)
  → Testing (N+1)
  → Rollout (N+2 to N+3)
  → Complete (N+4)
  → Cleanup (N+5)

Max lifetime: 90 days (created → removed)
```

---

### Code Template

```typescript
// feature-flags.ts
const FLAGS = {
  'feature-name': {
    enabled: true,
    percentage: 5,
    whitelist: ['user_123']
  }
};

export function isEnabled(flag: string, userId: string): boolean {
  const f = FLAGS[flag];
  if (!f || !f.enabled) return false;
  if (f.whitelist?.includes(userId)) return true;
  return (simpleHash(userId) % 100) < f.percentage;
}

// Usage
if (isEnabled('feature-name', user.id)) {
  return newImplementation();
}
return oldImplementation();
```

---

**Complete guide:** `.hermetic/docs/feature-flags-guide.md`

**May your experiments be safe. May your rollbacks be instant. May your features ship with confidence.**
