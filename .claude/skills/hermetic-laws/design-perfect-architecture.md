---
name: design-perfect-architecture
description: Combined Hermetic workflow using Mentalism + Correspondence + Polarity to create elegant system architecture
category: hermetic-combined
principles: Mentalism, Correspondence, Polarity
---

## Design Perfect Architecture - Combined Hermetic Workflow

**Principles Applied:** Mentalism (clear mental model) + Correspondence (aligned patterns) + Polarity (balanced tradeoffs)

### Purpose
Create system architecture that is clear, aligned across all levels, and balances competing priorities.

### When to Use
- Starting new projects (greenfield architecture)
- Major refactoring of existing systems
- Architecture feels messy/complex
- Need to make fundamental design decisions

### The Combined Workflow

**Step 1: MENTALISM - Clarify Mental Model**
```
Before touching any code, perfect the mental model:

1. What is the ESSENCE of this system in one sentence?
   Example: "Event-sourced order management with CQRS pattern"

2. Draw the core concepts:
   - Entities (User, Order, Product)
   - Relationships (User places Orders for Products)
   - Flows (Command → Event → State Change)

3. Refine until crystal clear
```

**Step 2: CORRESPONDENCE - Align All Levels**
```
Map how mental model corresponds across levels:

Mental Concept: "Order Management"
  ↓ corresponds to
Business Domain: OrderContext
  ↓ corresponds to
Bounded Context: order-service
  ↓ corresponds to
Module: src/order/
  ↓ corresponds to
Entities: Order.ts, OrderItem.ts
  ↓ corresponds to
Database: orders schema

Perfect alignment = Zero cognitive load
```

**Step 3: POLARITY - Balance Tradeoffs**
```
For each architectural decision, balance polarities:

Speed ↔ Quality:
- How fast can we ship this?
- What quality standards must we maintain?
- Balance: Ship MVP fast WITH core quality (tests, basic docs)

Flexibility ↔ Structure:
- How much flexibility do we need?
- What structure prevents chaos?
- Balance: Plugin architecture WITH clear contracts

Complexity ↔ Simplicity:
- What complexity is essential?
- What can we simplify?
- Balance: Rich domain model WITH simple interfaces

Innovation ↔ Stability:
- Where can we experiment?
- What must be rock-solid?
- Balance: Innovative features ON stable core
```

**Step 4: INTEGRATION - Synthesize All Three**
```
1. Mental model is CLEAR (Mentalism)
2. All levels CORRESPOND to that model (Correspondence)
3. Tradeoffs are BALANCED (Polarity)

Result: Perfect architecture that is:
- Understandable (clear mental model)
- Navigable (aligned across levels)
- Balanced (competing priorities harmonized)
```

**Step 5: VALIDATION - Triple Check**
```
Mentalism Check:
- Can I explain this architecture simply?
- Is the mental model crystal clear?

Correspondence Check:
- Can I trace concepts from business to code?
- Do all levels mirror each other?

Polarity Check:
- Have I balanced competing priorities?
- Am I avoiding extremes?

If ALL YES → Proceed
If ANY NO → Refine
```

### Expected Outcome
- Elegant architecture (simple yet powerful)
- Zero confusion (clear mental model)
- Easy navigation (perfect correspondence)
- Balanced design (no extreme tradeoffs)
- Long-term sustainability

### Example Application

**Project:** E-commerce Platform

**Mentalism:** Mental model = "Users browse catalog, add to cart, checkout with payments"

**Correspondence:**
- Business: Catalog, Cart, Checkout
- Services: catalog-service, cart-service, payment-service
- Modules: src/catalog/, src/cart/, src/payment/
- Perfect alignment

**Polarity:**
- Speed vs Quality: Ship MVP catalog fast, invest in payment reliability
- Monolith vs Microservices: Start monolith, extract services later
- Build vs Buy: Build catalog (core), buy payment processing (commodity)

**Result:** Clear, aligned, balanced architecture

### Hermetic Truth
> "Perfect architecture emerges when mind is clear (Mentalism), patterns align (Correspondence), and polarities balance (Polarity)."

---

**Mastery is synthesis of principles, not application of one.**
