# Architecture Decision Records (ADRs) - Documentation as Code

**Principle**: "Decisions are code - version, review, and evolve them"

**What are ADRs**: Lightweight documentation of architectural decisions, their context, and consequences

**Why document decisions**: Future you (and teammates) need to understand WHY choices were made, not just WHAT was chosen

---

## The Problem: Lost Context

### Decisions Without Documentation

**Scenario**: 6 months after choosing database

**Teammate**: "Why did we choose PostgreSQL over MongoDB?"

**You**: "Uh... I think it was for relational queries? Or was it team expertise? Maybe ACID guarantees? Honestly, I don't remember the full reasoning."

**Result**:
- Context lost
- Can't evaluate if decision still valid
- Might make same mistake if redoing
- New team members confused by choices

---

**Same scenario with ADR**:

**Teammate**: "Why PostgreSQL?"

**You**: "See ADR-015 in `dev/decisions/`. Extended thinking analysis showed: (1) Social graph queries are relational, (2) Team SQL expertise reduces risk, (3) JSONB provides flexibility we thought we'd need from NoSQL. We chose PostgreSQL and it's worked well."

**Result**:
- Context preserved
- Can validate decision still correct
- Learning captured for future similar decisions
- New teammates onboard faster

---

## ADR Structure

### The Template

```markdown
# ADR-[Number]: [Short Title]

**Date**: [YYYY-MM-DD]
**Status**: [Proposed | Accepted | Deprecated | Superseded by ADR-XXX]
**Deciders**: [Who was involved in the decision]
**Tags**: [technical-debt, security, performance, database, etc.]

## Context and Problem Statement

[Describe the context and the problem you're solving]

**Why this decision is needed**:
- [Reason 1]
- [Reason 2]

**What's at stake**:
- If we choose right: [Positive outcome]
- If we choose wrong: [Negative consequences]

## Decision Drivers

[Forces/factors influencing the decision]

- [Driver 1]: [Why it matters]
- [Driver 2]: [Why it matters]
- [Driver 3]: [Why it matters]

## Considered Options

1. **[Option 1 Name]**
   - Pros: [...]
   - Cons: [...]

2. **[Option 2 Name]**
   - Pros: [...]
   - Cons: [...]

3. **[Option 3 Name]**
   - Pros: [...]
   - Cons: [...]

## Decision Outcome

**Chosen option**: [Option X]

**Justification**:
- [Key reason 1]
- [Key reason 2]
- [Key reason 3]

**Consequences**:
- ✅ **Positive**:
  - [Benefit 1]
  - [Benefit 2]

- ❌ **Negative** (accepted tradeoffs):
  - [Downside 1]
  - [Downside 2]

- ⚠️ **Risks**:
  - [Risk 1]: Mitigation → [How we'll handle it]
  - [Risk 2]: Mitigation → [How we'll handle it]

## Validation

**How we'll know if this decision was correct**:
- **Success metrics**:
  - [Metric 1]: Target [X], current [Y]
  - [Metric 2]: Target [X], current [Y]

- **Review date**: [When to re-evaluate - usually 3-6 months]

- **Conditions for reconsidering**:
  - If [condition 1 occurs], reconsider this decision
  - If [condition 2 occurs], reconsider this decision

## Links

- **Extended thinking transcript**: [Link if applicable]
- **Related ADRs**: [[ADR-XXX]], [[ADR-YYY]]
- **Implementation tracking**: [Sprint/ticket/PR link]
- **Code references**: [Links to code implementing this decision]

## Notes

[Any additional context, assumptions, or clarifications]

---

**Revision History**:
- [Date]: [What changed and why]
