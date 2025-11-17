# Feature Flags Guide - Safe Experimentation in Production

**Principle**: "Test in production safely - flags isolate risk"

**What are feature flags**: Code-level toggles to enable/disable features without redeploying

**Why use them**: Ship continuously, experiment safely, rollback instantly, gradual rollouts

---

## Quick Concept

**Traditional deployment**:
```javascript
// New feature - all or nothing
function checkout() {
  return newCheckoutFlow(); // Everyone gets new flow (risky!)
}
```

**Problem**: If new flow has bug, everyone affected, must redeploy to fix

---

**With feature flags**:
```javascript
function checkout() {
  if (featureFlags.isEnabled('new-checkout-flow', userId)) {
    return newCheckoutFlow(); // Only 5% of users
  }
  return oldCheckoutFlow(); // 95% still on stable version
}
```

**Benefits**:
- ✅ Test in production with real users (5%)
- ✅ If broken, disable flag instantly (no redeploy)
- ✅ Gradual rollout (5% → 25% → 50% → 100%)
- ✅ A/B testing built-in
- ✅ Emergency kill switch

---

## When to Use Feature Flags

### ✅ Use for:

**Risky changes**:
- New payment flow
- Algorithm change
- Major refactoring
- Database migration

**Gradual rollouts**:
- New UI (test with power users first)
- Performance optimization (validate no regression)
- Third-party integration (test with subset)

**A/B testing**:
- Pricing page variants
- Onboarding flow options
- Feature effectiveness

**Team coordination**:
- Merge incomplete work (disabled by flag)
- Work on feature over multiple sprints
- Enable when ready

---

### ❌ Don't use for:

**Bug fixes** (deploy immediately, no flag needed)
**Simple content changes** (no rollback risk)
**Everything** (flag fatigue - only flag what needs it)

---

## Basic Implementation

### Simple Feature Flag System

```typescript
// feature-flags.ts

interface FeatureFlags {
  'new-checkout-flow': boolean;
  'experimental-search': boolean;
  'beta-dashboard': boolean;
}

class FeatureFlagService {
  private flags: Map<string, FeatureFlag> = new Map();

  constructor() {
    // Initialize from environment or config
    this.loadFlags();
  }

  isEnabled(flagName: keyof FeatureFlags, userId?: string): boolean {
    const flag = this.flags.get(flagName);
    if (!flag) return false;

    // Check if globally enabled
    if (flag.enabled === false) return false;

    // Check rollout percentage
    if (flag.rolloutPercentage) {
      const userBucket = this.getUserBucket(userId || 'anonymous');
      if (userBucket > flag.rolloutPercentage) return false;
    }

    // Check user whitelist
    if (flag.whitelist && userId) {
      return flag.whitelist.includes(userId);
    }

    return flag.enabled;
  }

  private getUserBucket(userId: string): number {
    // Hash user ID to 0-100 bucket (consistent bucketing)
    const hash = this.simpleHash(userId);
    return hash % 100;
  }

  private simpleHash(str: string): number {
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
      hash = ((hash << 5) - hash) + str.charCodeAt(i);
      hash |= 0; // Convert to 32bit integer
    }
    return Math.abs(hash);
  }

  private loadFlags() {
    // Load from config file or environment
    const config: FeatureFlagConfig[] = [
      {
        name: 'new-checkout-flow',
        enabled: true,
        rolloutPercentage: 5, // 5% of users
        whitelist: ['user_123', 'user_456'] // Always enabled for these users
      },
      {
        name: 'experimental-search',
        enabled: true,
        rolloutPercentage: 25
      },
      {
        name: 'beta-dashboard',
        enabled: false // Completely disabled
      }
    ];

    config.forEach(flag => this.flags.set(flag.name, flag));
  }
}

// Usage
const featureFlags = new FeatureFlagService();

// In your code
if (featureFlags.isEnabled('new-checkout-flow', user.id)) {
  return <NewCheckoutFlow />;
}
return <OldCheckoutFlow />;
```

---

## Feature Flag Patterns

### Pattern 1: Gradual Rollout

**Use case**: Deploy new feature to increasing percentages

**Workflow**:

```markdown
## Day 1: Internal testing
rolloutPercentage: 0
whitelist: [team_member_ids]

## Day 3: Canary (1%)
rolloutPercentage: 1

## Day 5: Small rollout (5%)
rolloutPercentage: 5
Monitor metrics: error rates, performance

## Day 7: Larger rollout (25%)
rolloutPercentage: 25
Monitor: user feedback, conversion rates

## Day 10: Majority (75%)
rolloutPercentage: 75

## Day 14: Full rollout (100%)
rolloutPercentage: 100

## Day 21: Remove flag
Feature stable, delete flag code
```

**Benefit**: Catch issues early, minimal blast radius

---

### Pattern 2: Kill Switch

**Use case**: Emergency disable broken feature

```typescript
// In production monitoring
if (errorRate > threshold) {
  featureFlags.disable('new-payment-flow');
  alertTeam('Payment flow disabled due to errors');
}
```

**Real scenario**:
```
3:00 AM: New payment flow deployed (enabled for 10%)
3:15 AM: Monitoring detects error spike
3:16 AM: Auto-disable flag OR manual disable via dashboard
3:17 AM: Error rate back to normal (users on old flow)
Next morning: Debug issue, fix, re-enable gradually
```

**Benefit**: Instant rollback without redeployment

---

### Pattern 3: A/B Testing

**Use case**: Compare two implementations

```typescript
function getSearchResults(query: string, userId: string) {
  const variant = featureFlags.getVariant('search-algorithm', userId);

  switch (variant) {
    case 'elastic':
      return elasticSearch(query);
    case 'postgres-fts':
      return postgresFullTextSearch(query);
    default:
      return elasticSearch(query); // Control group
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

**Analysis**:
```markdown
After 2 weeks:

**Elastic** (50% of users):
- Avg response time: 120ms
- Relevance score: 7.2/10
- Cost: $200/month

**Postgres FTS** (50% of users):
- Avg response time: 85ms (30% faster!)
- Relevance score: 7.5/10 (better!)
- Cost: $0 (already paying for Postgres)

Decision: Roll out Postgres FTS to 100%
```

---

### Pattern 4: Beta Features

**Use case**: Let users opt into experimental features

```typescript
function canAccessBetaFeature(userId: string, featureName: string): boolean {
  const user = await getUser(userId);

  // Check if user opted into beta program
  if (user.betaProgramEnrolled) {
    return featureFlags.isEnabled(featureName, userId);
  }

  return false;
}

// UI
<BetaFeatureToggle>
  Experimental Dashboard (Beta)
  <Toggle
    checked={userPreferences.betaProgramEnrolled}
    onChange={enrollInBeta}
  />
</BetaFeatureToggle>
```

**Benefit**: Engaged users test features, provide feedback before general release

---

## Integration with Hermetic Systems

### Sprint Integration: Feature Flagging Strategy

**During Sprint Planning**:

```markdown
## Sprint 15 - Feature Flag Strategy

### New Feature: Redesigned Dashboard

**Flag name**: `dashboard-v2`

**Rollout plan**:
- **Sprint 15**: Build + flag (disabled)
- **Sprint 16**: Enable for team (whitelist)
- **Sprint 17**: 5% rollout, monitor
- **Sprint 18**: 25% rollout if metrics good
- **Sprint 19**: 100% rollout
- **Sprint 20**: Remove flag code

**Success metrics**:
- Page load time < 1s (currently 1.5s)
- User session time +20%
- Error rate < 0.1%

**Kill switch triggers**:
- Error rate > 1%
- Page load > 2s
- User complaints > 5
```

---

### Knowledge Graph: Track Flag Lifecycles

```bash
# Create entities for flags
mcp__memory__create_entities({
  entities: [{
    name: "dashboard-v2 Feature Flag",
    entityType: "Decision",
    observations: [
      "Created: 2024-12-15 (Sprint 15)",
      "Rollout plan: 5% → 25% → 100% over 3 weeks",
      "Success metrics: Load time <1s, session time +20%, errors <0.1%",
      "Result: Rolled out to 100% (2025-01-05), metrics exceeded targets",
      "Removed: 2025-01-12 (Sprint 20)"
    ]
  }]
})

# Connect to related entities
mcp__memory__create_relations({
  relations: [{
    from: "dashboard-v2 Feature Flag",
    to: "Midnight-Sun Project",
    relationType: "deployed-in"
  }]
})
```

**Benefit**: Historical record of what flags worked, learning for future rollouts

---

### Dev Docs Layer 3: Flag Insights

```markdown
## ⚡ Layer 3: Critical Insights

### 🎯 Key Patterns (Feature Flags)

**Gradual rollout pattern works**: dashboard-v2 rolled out 5%→25%→100% over 3 weeks. Caught performance regression at 5%, fixed before wider release.

### ⚠️ Gotchas

**Flag fatigue is real**: Had 15 flags at once, team confused about which enabled. Now limit to 5 active flags maximum.

**Stale flags accumulate**: Flags from 6 months ago still in code. Now delete flags within 2 sprints of 100% rollout.

### 💎 Breakthroughs

**Kill switch saved us**: Payment bug detected at 3 AM, flag disabled automatically, woke up to zero impact. Without flag, would've been disaster.
```

---

## Flag Lifecycle Management

### Lifecycle Stages

```
Created → Testing → Rollout → Complete → Cleanup
```

### Stage 1: Created (Sprint N)

```typescript
// Add flag to config
{
  name: 'new-feature',
  enabled: false, // Disabled in production
  rolloutPercentage: 0
}

// Add flag to code
if (featureFlags.isEnabled('new-feature', userId)) {
  // New implementation
} else {
  // Old implementation
}

// Document in ADR
ADR-XXX: New Feature Flag Created
Purpose: [Why we're flagging this]
Rollout plan: [Timeline]
Removal target: Sprint N+4
```

---

### Stage 2: Testing (Sprint N+1)

```typescript
// Enable for team
{
  name: 'new-feature',
  enabled: true,
  whitelist: [team_member_ids],
  rolloutPercentage: 0 // Not to general public yet
}

// Test internally
// Gather feedback
// Fix bugs before wider release
```

---

### Stage 3: Rollout (Sprint N+2 to N+3)

```typescript
// Gradual rollout
Sprint N+2: rolloutPercentage: 5
Sprint N+3: rolloutPercentage: 25
Sprint N+4: rolloutPercentage: 100

// Monitor metrics at each stage
// Pause or rollback if issues detected
```

---

### Stage 4: Complete (Sprint N+4)

```typescript
// 100% rollout, stable for 2+ weeks
rolloutPercentage: 100

// Flag still in code but effectively always enabled
// Monitor for 2 weeks to ensure stability
```

---

### Stage 5: Cleanup (Sprint N+5)

```typescript
// Remove flag from code
// BEFORE:
if (featureFlags.isEnabled('new-feature', userId)) {
  return newImplementation();
} else {
  return oldImplementation(); // Delete this
}

// AFTER:
return newImplementation(); // Flag removed, only new code remains

// Remove flag from config
// Delete old implementation
// Update tests
// Create PR: "Cleanup: Remove new-feature flag"
```

**Principle**: Flags are temporary - always plan removal from day 1

---

## Flag Management Best Practices

### Practice 1: Limited Active Flags

**Problem**: Too many flags → confusion

**Solution**: Limit to 5 active flags at once

```markdown
## Active Flags Policy

**Max active flags**: 5
**Current count**: 3

**Active Flags**:
1. `dashboard-v2` (Rollout: 25%, Target removal: Sprint 20)
2. `search-v2` (Testing: Team only, Target removal: Sprint 21)
3. `payment-flow-v3` (Rollout: 5%, Target removal: Sprint 22)

**Upcoming** (blocked until slot opens):
- `notification-system` (Waiting for dashboard-v2 completion)

**Policy**: No new flag until one removed (FIFO queue)
```

---

### Practice 2: Automated Flag Cleanup

**Problem**: Stale flags accumulate

**Solution**: Automated reminder + enforcement

```typescript
// CI/CD check
function checkStaleFlagsCI() {
  const flags = loadAllFlags();
  const staleFlags = flags.filter(flag => {
    const createdDate = flag.metadata.created;
    const daysSinceCreated = daysBetween(createdDate, now());

    // Flag older than 90 days?
    return daysSinceCreated > 90;
  });

  if (staleFlags.length > 0) {
    console.error(`Stale flags detected (>90 days old):`);
    staleFlags.forEach(flag => {
      console.error(`- ${flag.name} (created ${flag.metadata.created})`);
    });
    console.error('\nAction required: Remove stale flags or update removal timeline.');
    process.exit(1); // Fail CI
  }
}
```

---

### Practice 3: Document Flag Purpose

**Bad**:
```typescript
if (featureFlags.isEnabled('feature-123', userId)) {
  // ...
}
```

**Good**:
```typescript
// Flag: dashboard-v2 (ADR-045)
// Purpose: Gradual rollout of redesigned dashboard
// Created: 2024-12-15
// Target removal: Sprint 20 (2025-01-15)
// Kill switch: Auto-disable if page load > 2s
if (featureFlags.isEnabled('dashboard-v2', userId)) {
  return <DashboardV2 />;
}
return <DashboardV1 />; // Remove after flag cleanup
```

---

## Quick Start (15 Minutes)

### Step 1: Create Simple Flag System (5 min)

```typescript
// feature-flags.ts
const FLAGS = {
  'my-first-feature': {
    enabled: true,
    percentage: 10 // 10% rollout
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

### Step 2: Use Flag in Code (5 min)

```typescript
// Before
function checkout() {
  return processPayment();
}

// After
import { isEnabled } from './feature-flags';

function checkout(userId: string) {
  if (isEnabled('new-payment-flow', userId)) {
    return processPaymentV2(); // New implementation (10% of users)
  }
  return processPayment(); // Old implementation (90% of users)
}
```

---

### Step 3: Monitor & Adjust (5 min)

```typescript
// Monitor metrics
const metrics = {
  oldFlow: { successRate: 98%, avgTime: 2.5s },
  newFlow: { successRate: 99.5%, avgTime: 1.8s }
};

// New flow better? Increase rollout
FLAGS['new-payment-flow'].percentage = 25; // 10% → 25%

// Issues detected? Decrease or disable
FLAGS['new-payment-flow'].enabled = false; // Kill switch
```

---

**First feature flag deployed in 15 minutes!**

---

## Success Metrics

### You're using flags well when:

**Qualitative**:
- ✅ Ship confidently (know you can rollback)
- ✅ Catch issues early (small percentage first)
- ✅ No emergency redeploys (flags handle it)
- ✅ Flags cleaned up (not accumulating)
- ✅ Team understands flag state

**Quantitative**:
- ✅ Active flags: <5 at any time
- ✅ Flag lifetime: <3 months (created → removed)
- ✅ Rollback time: <5 minutes (vs hours for redeploy)
- ✅ Blast radius: <10% users affected by issues
- ✅ Deployment frequency: Daily (flags enable continuous deployment)

---

## Quick Reference

### When to Flag

**Flag it**:
- Risky changes
- Gradual rollouts
- A/B tests
- Incomplete work (merge disabled)

**Don't flag**:
- Bug fixes
- Simple content
- Everything (flag fatigue)

### Rollout Pattern

```
Day 1: Team testing (whitelist)
Day 3: 1% canary
Day 5: 5% small rollout
Day 7: 25% larger rollout
Day 10: 75% majority
Day 14: 100% full rollout
Day 21: Remove flag code
```

### Flag Lifecycle

```
Created (Sprint N) → Testing (N+1) → Rollout (N+2 to N+3) → Complete (N+4) → Cleanup (N+5)
```

**Max lifetime**: 3 months from creation to removal

---

**For complete implementation examples, see**: `.hermetic/examples/feature-flags/`

**May your releases be confident. May your rollbacks be instant. May your experiments be safe.**
