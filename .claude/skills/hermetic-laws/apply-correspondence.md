---
name: apply-correspondence
description: Practical workflow for aligning patterns across levels and finding where misalignment creates complexity
category: hermetic-workflow
principle: Correspondence - "As Above, So Below"
---

## Apply Correspondence - Pattern Alignment Workflow

### Purpose
Align patterns across all levels. Make micro mirror macro to eliminate complexity.

### When to Use
- Messy architecture (doesn't match business)
- Team dysfunction (structure vs system mismatch)
- Can't find anything in codebase
- Constant coordination overhead
- System feels unnecessarily complex

### The Workflow

**Step 1: Map the Highest Level**
```
Identify the top-level pattern:
- Business domains (what does the business do?)
- Core vision (what are we creating?)
- Conceptual model (what's the mental framework?)
```

**Step 2: Map Each Level Below**
```
For each level, ask: "Does this mirror the level above?"

Example:
Business Domain: "Order Management"
  ↓ Should correspond to
Bounded Context: "OrderContext"
  ↓ Should correspond to
Service: "order-service"
  ↓ Should correspond to
Module: "src/order/"
  ↓ Should correspond to
Files: "order.entity.ts, order.service.ts"
```

**Step 3: Find Misalignments**
```
Where does correspondence break?
- Files don't match concepts?
- Teams don't match services?
- Architecture doesn't match business?

Mark each misalignment.
```

**Step 4: Realign Levels**
```
Fix misalignments from top to bottom:
- Rename to match higher level
- Reorganize to mirror pattern
- Restructure to correspond

Result: Every level mirrors every other level
```

**Step 5: Verify Correspondence**
```
Walk through levels:
"Can I trace a concept from business domain all the way to specific files?"

If yes → Perfect correspondence
If no → More alignment needed
```

### Expected Outcome
- Intuitive navigation
- Zero cognitive load
- Reduced complexity
- Clear ownership
- Easy onboarding

### Hermetic Truth
"When levels correspond, complexity vanishes. Align the pattern."
