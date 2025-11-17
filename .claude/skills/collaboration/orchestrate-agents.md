---
name: orchestrate-agents
description: Coordinate multiple specialized agents for complex tasks
category: collaboration
principle: Correspondence
---

# Orchestrate Agents - Multi-Agent Coordination

**Hermetic Principle**: Correspondence - "As the team structure, so the solution quality"

**When to use**: Complex multi-faceted tasks requiring specialist expertise

---

## Quick Concept

**Problem**: One agent doing everything = jack-of-all-trades, master of none

**Solution**: Delegate to specialists, you orchestrate

**Result**: Expert-level work in each domain, sustainable pace

---

## When to Orchestrate vs Single Agent

### Use Single Agent For:

✅ **Simple, focused tasks**:
- Implement single CRUD endpoint
- Fix specific bug
- Write documentation for one feature

### Use Multi-Agent Orchestration For:

✅ **Complex, multi-domain tasks**:
- Build complete authentication system (architecture + implementation + security + tests + docs)
- Major refactoring (analysis + strategy + implementation + validation)
- New feature requiring multiple specialists (backend + frontend + database + DevOps)

**Rule**: If task requires >3 different specialties, orchestrate

---

## The Four Orchestration Patterns

### Pattern 1: Sequential Pipeline

**Use when**: Each step depends on previous completion

**Template**:
```
Step 1: [Agent A] → Output 1
Step 2: [Agent B uses Output 1] → Output 2
Step 3: [Agent C uses Output 2] → Final
```

**Example**:
```bash
# Step 1: Architecture
/task "Backend Architect: Design auth system architecture. Produce ADR and component diagram."

# [Wait for completion, review]

# Step 2: Implementation
/task "Backend Developer: Implement auth system per ADR-[X]. Reference component diagram at [link]."

# [Wait for completion, review]

# Step 3: Security Audit
/task "Security Engineer: Security audit of auth implementation at [path]. Produce threat model and remediation plan."
```

---

### Pattern 2: Parallel Execution

**Use when**: Multiple independent tasks can happen simultaneously

**Template**:
```
        ┌─ Agent A ─┐
Start ──┼─ Agent B ─┼── Integrate
        └─ Agent C ─┘
```

**Example**:
```bash
# Launch all three simultaneously (single message)
/task "Backend Developer: Implement user profile API endpoints - GET /api/profile/:id, PUT /api/profile/:id."

/task "Frontend Developer: Build ProfileView and ProfileEdit React components. Use hooks, include validation."

/task "Database Architect: Design user profile schema extension. Create migration script."

# All work in parallel, you integrate after all complete
```

**Time savings**: 3x faster (3 hours parallel vs 9 hours sequential)

---

### Pattern 3: Hierarchical Delegation

**Use when**: Complex problem needs breakdown then specialization

**Template**:
```
You (Orchestrator)
    ↓
Planner Agent (breaks down)
    ↓
├─ Specialist A
├─ Specialist B
└─ Specialist C
```

**Example**:
```bash
# Level 1: Get strategy
/task "Backend Architect: Analyze monolith, propose microservice boundaries. Use extended thinking. Produce migration strategy."

# [Review strategy]

# Level 2: Delegate to specialists (after strategy approved)
/task "Backend Developer: Extract auth service per [strategy doc]."
/task "Backend Developer: Extract user service per [strategy doc]."
/task "DevOps Automator: Set up microservices infrastructure per [strategy doc]."

# You orchestrate integration after specialists complete
```

---

### Pattern 4: Iterative Refinement

**Use when**: Need multiple rounds of quality improvement

**Template**:
```
Agent A (draft) → Agent B (refine) → Agent C (polish) → Done
```

**Example**:
```bash
# Round 1: Draft
/task "Create initial API documentation for auth endpoints."

# Round 2: Technical accuracy
/task "Backend Architect: Review API docs for technical accuracy, add missing details."

# Round 3: User-friendliness
/task "UX Researcher: Review API docs for clarity, add examples, improve readability."

# Round 4: Visual enhancement
/task "Visual Storyteller: Add diagrams and visual examples to API docs."
```

---

## Specialist Agent Quick Reference

### Engineering Specialists

**Backend Architect**
- **Use for**: System design, ADRs, tech stack decisions
- **Example**: "Design microservices architecture"

**Backend Developer**
- **Use for**: API implementation, business logic
- **Example**: "Implement REST endpoints for user management"

**Frontend Developer**
- **Use for**: UI components, state management
- **Example**: "Build React dashboard components"

**Security Engineer**
- **Use for**: Security audits, threat modeling
- **Example**: "Security review authentication implementation"

**DevOps Automator**
- **Use for**: CI/CD, deployment, infrastructure
- **Example**: "Set up CI/CD pipeline for microservices"

**Database Architect**
- **Use for**: Schema design, query optimization
- **Example**: "Design database schema for social network"

---

### Quality Specialists

**Test Writer/Fixer**
- **Use for**: Test suites, fixing test failures
- **Example**: "Write comprehensive tests for auth API"

**Sacred Geometry Analyzer**
- **Use for**: Code analysis against natural patterns
- **Example**: "Analyze codebase for sacred geometry alignment"

---

### Design Specialists

**UI Designer**
- **Use for**: Component design, design systems
- **Example**: "Design authentication flow UI components"

**UX Researcher**
- **Use for**: User research, journey mapping
- **Example**: "Research user onboarding best practices"

**Visual Storyteller**
- **Use for**: Diagrams, presentations, infographics
- **Example**: "Create visual diagram of system architecture"

---

## Practical Workflows

### Workflow 1: Build New Feature (Full Stack)

**Task**: User profile management feature

**Orchestration Plan**:

**Phase 1: Planning (Sequential)**
```bash
# Day 1: Architecture
/task "Backend Architect: Design user profile system. Include data model, API design, security considerations. Produce ADR."

# After architecture review
/task "Database Architect: Design user profile database schema based on [ADR]. Produce migration scripts."
```

**Phase 2: Implementation (Parallel)**
```bash
# Day 2-3: Simultaneous development
/task "Backend Developer: Implement user profile API per [ADR]. Endpoints: GET/PUT /api/profile/:id, GET /api/users (search)."

/task "Frontend Developer: Build user profile UI components: ProfileView, ProfileEdit, UserSearch. Follow design system."

/task "Test Writer: Write test suite for profile feature. Cover API endpoints, UI components, integration tests."
```

**Phase 3: Quality (Sequential)**
```bash
# Day 4: Quality assurance
/task "Security Engineer: Security review of profile feature. Check: authorization, data validation, privacy."

# After security review
/task "Backend Developer: Apply security fixes from review."

# After fixes applied
/task "DevOps Automator: Deploy profile feature to staging. Set up monitoring."
```

**Total time**: 4 days with orchestration vs 10+ days solo

---

### Workflow 2: Emergency Production Fix

**Scenario**: Critical security vulnerability discovered

**Orchestration (Rapid Response)**:

**Immediate (Parallel)**:
```bash
# Simultaneously:
/task "Security Engineer: URGENT - Assess vulnerability scope for [issue]. Recommend immediate mitigation."

/task "Backend Developer: URGENT - Implement temporary fix for [issue]. Deploy ASAP."

/task "Draft incident communication: What happened, what we're doing, user actions needed."
```

**Follow-up (Sequential)**:
```bash
# After immediate crisis resolved
/task "Security Engineer: Post-mortem analysis of [issue]. Use extended thinking. Recommend permanent fixes."

# After post-mortem reviewed
/task "Backend Developer: Implement permanent fixes from post-mortem: [list]."

/task "Test Writer: Write regression tests for [issue] to prevent recurrence."
```

**Benefit**: Fast coordinated response + thorough follow-up

---

### Workflow 3: Quality Assurance Before Launch

**Task**: Pre-launch review of authentication system

**Multi-Angle Review (Parallel)**:

```bash
# Launch all reviews simultaneously
/task "Backend Developer: Code review auth implementation for functionality, edge cases, error handling."

/task "Security Engineer: Security audit of auth. Check OWASP Top 10, provide threat model."

/task "Backend Architect: Architecture review - implementation matches design? Technical debt? Refactoring needed?"

/task "Test Writer: Test coverage audit. Identify gaps. Write missing tests."

/task "Frontend Developer: UX review of auth flow. Any friction points? Accessibility issues?"
```

**After all reviews complete**:
- Consolidate findings
- Prioritize fixes
- Delegate fixes to appropriate agents

**Benefit**: Comprehensive quality check from multiple expert angles

---

## Delegation Best Practices

### Practice 1: Clear Specifications

**Bad**:
```bash
/task "Build auth system"
```

**Good**:
```bash
/task "Backend Developer: Implement JWT authentication.

Context:
- Architecture: [ADR-015 link]
- Schema: [users table schema]
- Requirements: RS256 signing, 15-min expiration, refresh tokens

Deliverables:
1. POST /api/auth/login (email/password → JWT + refresh)
2. POST /api/auth/refresh (refresh token → new JWT)
3. JWT validation middleware
4. Error handling (invalid credentials, expired tokens)

Quality:
- TypeScript with strict types
- Rate limiting on login
- Audit logging
- Unit tests included"
```

**Benefit**: Clear spec = better output, less rework

---

### Practice 2: Explicit Handoffs

**Bad**:
```bash
# Agent A and B start simultaneously, no coordination
/task "Backend Architect, design it. Backend Developer, build it."
```

**Good**:
```bash
# Agent A completes first
/task "Backend Architect: Design auth system. Produce ADR."

# [Review ADR]

# Then Agent B starts with clear input
/task "Backend Developer: Implement auth per ADR-015. Reference architecture diagram at [link]."
```

**Benefit**: Each agent has validated input, reduces conflicting work

---

### Practice 3: Document Agent Outputs

**Create agent decision log**:

```markdown
# Agent Decisions - Project: Auth System

## 2024-12-15: Backend Architect
**Output**: ADR-015 - JWT with refresh token rotation
**Your review**: Approved
**Next**: Backend Developer implements

## 2024-12-16: Security Engineer
**Output**: Threat model, 3 vulnerabilities found
**Your review**: Approved fixes, assigned to Backend Developer
**Next**: Implement security fixes

## 2024-12-17: Test Writer
**Output**: Test suite, 92% coverage
**Your review**: Good, requested edge case tests for token expiration
**Next**: Add edge case tests
```

**Benefit**: Track what agents delivered, inform future delegation

---

## Troubleshooting

### Issue: Agents produce conflicting recommendations

**Example**:
- Backend Architect: "Use JWT (stateless)"
- Security Engineer: "Use sessions (better revocation)"

**Solution**: Synthesis task

```bash
/task "Extended thinking synthesis:

Conflicting recommendations:
- Backend Architect: JWT for statelessness
- Security Engineer: Sessions for revocation

Context: Healthcare app, HIPAA compliance, 10K users

Question: What's the best approach? Can we get benefits of both?

Analyze both positions, recommend solution that serves our context best."
```

**Benefit**: AI synthesizes multiple expert viewpoints

---

### Issue: Low-quality agent output

**Diagnosis**:
- [ ] Was delegation clear? (Review your prompt)
- [ ] Did agent have context? (Architecture docs, requirements)
- [ ] Right specialist? (Security work to Security Engineer, not generic)
- [ ] Task too complex? (Break into smaller pieces)

**Fix**: Improve delegation specificity (see Practice 1 above)

---

### Issue: Can't decide which pattern to use

**Decision tree**:

**Q1**: Do later steps depend on earlier completion?
- **Yes** → Sequential Pipeline
- **No** → Go to Q2

**Q2**: Can tasks happen simultaneously?
- **Yes** → Parallel Execution
- **No** → Go to Q3

**Q3**: Need breakdown before execution?
- **Yes** → Hierarchical Delegation
- **No** → Go to Q4

**Q4**: Need multiple quality improvement rounds?
- **Yes** → Iterative Refinement
- **No** → Probably Sequential or Parallel

---

## Integration with Hermetic Systems

### Sprint Planning with Agents

**During Sprint Opening**:

```markdown
## Sprint 15 - Agent Delegation Plan

**Sprint Goal**: User profile management

**Agent Assignments**:

**Mon-Tue** (Architecture):
- Backend Architect: System design
- Database Architect: Schema design

**Wed-Thu** (Implementation - Parallel):
- Backend Developer: Profile API
- Frontend Developer: Profile UI

**Fri** (Quality):
- Test Writer: Test suite
- Security Engineer: Security review

**Sat** (Integration):
- You: Integrate, test, Sprint Harvest
```

**Benefit**: Team (including AI agents) knows roles from sprint start

---

### Cognitive Load: Delegate When Overwhelmed

**Signal**:

```markdown
## Cognitive Load Journal

**Load**: 90% 🔴 (Trying to do everything)

**Action**:
🛑 Stop doing everything yourself
📋 Delegate to specialists:
  - Architecture → Backend Architect
  - Implementation → Backend Developer
  - Testing → Test Writer
⏸️ You orchestrate, don't execute

Result: Load dropped to 40% (orchestration manageable)
```

**Principle**: When overwhelmed by scope, orchestrate specialists

---

## Quick Start

### Your First Orchestration (15 min)

**Pick a current task** requiring 2+ specialties

**Example**: "Add password reset to auth system"

**1. Identify specialists needed**:
- Backend Developer (implement reset logic)
- Frontend Developer (reset UI)
- Security Engineer (security review)

**2. Create sequential plan**:
```bash
# Step 1
/task "Backend Developer: Implement password reset. POST /api/auth/reset-password endpoint."

# [Review output]

# Step 2
/task "Frontend Developer: Build password reset UI. Email input → reset link sent confirmation."

# [Review output]

# Step 3
/task "Security Engineer: Security review password reset flow. Check: rate limiting, token security, timing attacks."
```

**3. Execute plan, integrate outputs**

**Result**: First orchestration complete!

---

## Success Metrics

### You're orchestrating well when:

**Qualitative**:
- ✅ Each agent works in specialty
- ✅ Clear handoffs (validated inputs/outputs)
- ✅ You orchestrate, not execute everything
- ✅ Parallel work happening
- ✅ Quality from specialist expertise

**Quantitative**:
- ✅ Time: Faster with orchestration vs solo
- ✅ Rework: Lower (clear specs)
- ✅ Quality: Higher (specialist review)
- ✅ Your cognitive load: Lower (delegation)
- ✅ Agent specialty usage: >70%

---

## Quick Reference

### Patterns

**Sequential**: Step 1 → 2 → 3 (dependencies)
**Parallel**: A, B, C simultaneously (independent)
**Hierarchical**: Planner → Specialists (complex breakdown)
**Iterative**: Draft → Refine → Polish (quality rounds)

### Delegation Template

```bash
/task "[Agent]: [Task]

Context:
- [Background]
- [Constraints]

Deliverables:
1. [Output 1]
2. [Output 2]

Quality:
- [Standard 1]
- [Standard 2]"
```

### Pattern Selection

**Dependencies?** → Sequential
**Independent?** → Parallel
**Complex breakdown?** → Hierarchical
**Quality rounds?** → Iterative

---

**For complete guide, see**: `.hermetic/docs/multi-agent-orchestration.md`

**For agent catalog, see**: `.claude/agents/README.md`

**May your agents specialize. May your orchestration flow. May excellence emerge from collaboration.**
