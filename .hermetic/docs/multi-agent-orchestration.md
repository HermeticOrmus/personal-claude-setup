# Multi-Agent Orchestration Guide - Coordinating Specialized Agents

**Principle**: "Delegate to specialists, orchestrate the whole"

**What is multi-agent orchestration**: Coordinating multiple specialized agents to solve complex problems

**Why use it**: Some problems are too complex for single-agent solutions - need specialist collaboration

---

## The Problem: Single-Agent Limitations

### Attempting Everything with One Agent

**Scenario**: Building complete authentication system

**Single-agent approach** (you asking Claude Code to do everything):
```
You: "Build complete auth system with JWT, refresh tokens, password reset, 2FA, rate limiting, audit logging, HIPAA compliance"

Claude Code: [Attempts everything]
- Writes auth logic
- Writes tests
- Writes documentation
- Reviews security
- Checks compliance
- Optimizes performance

Result:
- Takes 8+ hours in one session
- Context gets lost midway
- Security review superficial (agent fatigued)
- No deep specialization on any aspect
- You're overwhelmed tracking everything
```

**Problems**:
- ❌ Cognitive overload (agent + you)
- ❌ Jack-of-all-trades, master of none
- ❌ No deep expertise in specialized areas
- ❌ Context loss as task grows
- ❌ Hard to track what's done vs what's pending

---

### Multi-Agent Orchestration Approach

**Same task, delegated to specialists**:

```
You (Orchestrator): "We need complete auth system. Let me delegate to specialists."

1. Architect Agent: Design overall system architecture
   → Produces: Architecture diagram, technology choices, ADR

2. Backend Developer Agent: Implement core auth logic
   → Produces: Auth endpoints, JWT generation, token validation

3. Security Engineer Agent: Security audit + hardening
   → Produces: Threat model, security review, penetration testing results

4. Test Writer Agent: Comprehensive test suite
   → Produces: Unit tests, integration tests, security tests

5. Documentation Agent: Complete documentation
   → Produces: API docs, deployment guide, security guide

6. Compliance Checker Agent: HIPAA compliance audit
   → Produces: Compliance report, gap analysis, remediation plan

Result:
- Each agent focuses on specialty (deep expertise)
- You orchestrate (manage workflow, not do everything)
- Parallel work possible (agents work simultaneously)
- Clear checkpoints (each agent's output validates next)
- Sustainable pace (no single overwhelm point)
```

**Benefits**:
- ✅ Deep specialization (each agent expert in domain)
- ✅ Better quality (specialist vs generalist)
- ✅ Parallelization (agents work concurrently)
- ✅ Clear ownership (who does what)
- ✅ Sustainable workflow (no single burnout point)

---

## Available Specialized Agents

### Engineering Agents

**Backend Architect** (`.claude/agents/backend-architect.md`)
- **Use for**: API design, database schema, system architecture
- **Produces**: Architecture diagrams, ADRs, technology choices
- **Example**: "Design authentication system architecture"

**Frontend Developer** (`.claude/agents/frontend-developer.md`)
- **Use for**: UI components, state management, React/Vue implementations
- **Produces**: Components, hooks, styling, accessibility compliance
- **Example**: "Build login form component with validation"

**DevOps Automator** (`.claude/agents/devops-automator.md`)
- **Use for**: CI/CD, deployment, infrastructure
- **Produces**: Pipeline configs, Dockerfiles, deployment scripts
- **Example**: "Set up CI/CD for auth service"

**Database Architect** (`.claude/agents/database-architect.md`)
- **Use for**: Schema design, query optimization, migration planning
- **Produces**: Schema definitions, migration scripts, query analysis
- **Example**: "Design user authentication database schema"

**Security Engineer** (`.claude/agents/security-engineer.md`)
- **Use for**: Security audits, threat modeling, vulnerability assessment
- **Produces**: Threat models, security reports, remediation plans
- **Example**: "Security audit authentication implementation"

**AI Engineer** (`.claude/agents/ai-engineer.md`)
- **Use for**: ML features, recommendation systems, AI integration
- **Produces**: Model implementations, training pipelines, inference code
- **Example**: "Add anomaly detection to authentication logs"

---

### Design & Product Agents

**UI Designer** (`.claude/agents/ui-designer.md`)
- **Use for**: Visual design, component design, design systems
- **Produces**: Component specs, design tokens, accessibility guidelines
- **Example**: "Design authentication flow UI"

**UX Researcher** (`.claude/agents/ux-researcher.md`)
- **Use for**: User research, journey mapping, usability testing
- **Produces**: User personas, journey maps, test results
- **Example**: "Research authentication UX best practices"

**Visual Storyteller** (`.claude/agents/visual-storyteller.md`)
- **Use for**: Infographics, presentations, visual documentation
- **Produces**: Diagrams, charts, presentation slides
- **Example**: "Create visual diagram of authentication flow"

---

### Quality & Strategy Agents

**Test Writer/Fixer** (`.claude/agents/test-writer-fixer.md`)
- **Use for**: Writing tests, fixing test failures, test strategy
- **Produces**: Test suites, test reports, coverage analysis
- **Example**: "Write comprehensive tests for auth endpoints"

**Sacred Geometry Analyzer** (`.claude/agents/sacred-geometry-analyzer.md`)
- **Use for**: Code analysis against natural patterns
- **Produces**: Alignment reports, recommendations
- **Example**: "Analyze auth code for sacred geometry alignment"

**Hermetic Compass Advisor** (`.claude/agents/hermetic-compass-advisor.md`)
- **Use for**: Decision guidance using Hermetic principles
- **Produces**: Principle-aligned recommendations, decision analysis
- **Example**: "Evaluate auth strategy through Hermetic lens"

---

### Hermetic Specialist Agents

**Rainbow Bridge Designer** (`.claude/agents/rainbow-bridge-designer.md`)
- **Use for**: API architecture using 9 Realm-Bridge framework
- **Produces**: Sacred API designs, integration blueprints
- **Example**: "Design authentication API honoring all 9 realms"

**Sacred Mirror Auditor** (`.claude/agents/sacred-mirror-auditor.md`)
- **Use for**: Testing audit against 9 Sacred Reflections
- **Produces**: Test coverage reports, pre-launch checklists
- **Example**: "Audit authentication test suite against 9 Reflections"

**Divine Anchor Auditor** (`.claude/agents/divine-anchor-auditor.md`)
- **Use for**: Infrastructure audit against 9 Divine Anchor practices
- **Produces**: Infrastructure audit reports, security compliance
- **Example**: "Audit authentication infrastructure grounding"

**Frequency Tuner Optimizer** (`.claude/agents/frequency-tuner-optimizer.md`)
- **Use for**: Performance optimization across 9 frequencies
- **Produces**: Performance analysis, optimization recommendations
- **Example**: "Optimize authentication flow across all 9 frequencies"

---

## Orchestration Patterns

### Pattern 1: Sequential Pipeline

**Use when**: Each step depends on previous completion

**Structure**:
```
Step 1 → Step 2 → Step 3 → Step 4
```

**Example: Authentication System Build**

```markdown
## Sequential Pipeline: Auth System

### Step 1: Architecture (Backend Architect Agent)
**Input**: Requirements doc
**Task**: Design overall system architecture
**Output**: Architecture ADR, tech stack decision, component diagram

### Step 2: Implementation (Backend Developer Agent)
**Input**: Architecture from Step 1
**Task**: Implement auth endpoints and logic
**Output**: Working auth code, JWT generation, token validation

### Step 3: Testing (Test Writer Agent)
**Input**: Implementation from Step 2
**Task**: Write comprehensive test suite
**Output**: Unit tests, integration tests, 90%+ coverage

### Step 4: Security Audit (Security Engineer Agent)
**Input**: Code + tests from Steps 2 & 3
**Task**: Security review and hardening
**Output**: Threat model, vulnerability report, fixes applied

### Step 5: Documentation (Documentation specialist via general agent)
**Input**: Final code from Steps 2-4
**Task**: Complete documentation
**Output**: API docs, deployment guide, security best practices
```

**Workflow**:
```bash
# Step 1: Architecture
/task "Backend Architect: Design authentication system architecture for healthcare app. Requirements: JWT, refresh tokens, HIPAA compliant. Produce ADR and component diagram."

# Wait for completion, review architecture

# Step 2: Implementation
/task "Backend Developer: Implement authentication system per architecture from [ADR link]. Focus on JWT generation, token validation, refresh token rotation."

# Wait for completion, review code

# Step 3: Testing
/task "Test Writer: Write comprehensive test suite for authentication implementation at [code path]. Cover unit, integration, and security test cases."

# Wait for completion, review tests

# Step 4: Security Audit
/task "Security Engineer: Audit authentication implementation for security vulnerabilities. Provide threat model and remediation plan."

# Wait for completion, apply fixes

# Step 5: Documentation
/task "Document authentication system: API endpoints, deployment instructions, security best practices, HIPAA compliance guide."
```

**Benefit**: Clear handoffs, each stage validates previous

---

### Pattern 2: Parallel Execution

**Use when**: Multiple independent tasks can happen simultaneously

**Structure**:
```
        ┌─ Agent A ─┐
Start ──┼─ Agent B ─┼── Integrate
        └─ Agent C ─┘
```

**Example: Complete Feature Development**

```markdown
## Parallel Execution: User Profile Feature

### Parallel Track 1: Backend (Backend Developer Agent)
**Task**: Implement profile API endpoints
**Duration**: 2 hours
**Output**: GET/PUT /api/profile endpoints

### Parallel Track 2: Frontend (Frontend Developer Agent)
**Task**: Build profile UI components
**Duration**: 2 hours
**Output**: ProfileView, ProfileEdit components

### Parallel Track 3: Database (Database Architect Agent)
**Task**: Design and implement profile schema
**Duration**: 1.5 hours
**Output**: Migration script, schema documentation

### Integration Phase (You orchestrate)
**After all parallel tracks complete**:
- Connect frontend to backend API
- Run integration tests
- Deploy as unit
```

**Workflow**:
```bash
# Launch all three agents in parallel (single message with multiple tasks)
/task "Backend Developer: Implement user profile API - GET /api/profile/:id (read), PUT /api/profile/:id (update). Include validation, error handling."

/task "Frontend Developer: Build user profile components - ProfileView (display), ProfileEdit (update form). Use React hooks, include validation."

/task "Database Architect: Design user profile schema extension. Fields: bio, avatar_url, preferences (JSON). Create migration script."

# All three agents work simultaneously
# After all complete, integrate their outputs
```

**Benefit**: 3x faster than sequential (2 hours total vs 6 hours sequential)

---

### Pattern 3: Hierarchical Delegation

**Use when**: Complex problem needs breakdown then specialization

**Structure**:
```
Orchestrator (You)
    ↓
Strategic Planner Agent
    ↓
├─ Specialist A
├─ Specialist B
└─ Specialist C
```

**Example: Major Refactoring Project**

```markdown
## Hierarchical Delegation: Monolith to Microservices

### Level 1: Orchestrator (You)
**Task**: "We need to break monolith into microservices"

### Level 2: Strategic Planner (Backend Architect Agent)
**Task**: Analyze monolith, propose microservice boundaries
**Output**:
- Service boundary map
- Migration strategy (which services first)
- Risk assessment

### Level 3: Specialists (Multiple agents)

**Service 1 - Auth Service** (Backend Developer Agent):
- Extract auth logic
- Create independent service
- Implement service API

**Service 2 - User Service** (Backend Developer Agent):
- Extract user management
- Create independent service
- Implement service API

**Service 3 - Data Service** (Backend Developer Agent):
- Extract data operations
- Create independent service
- Implement service API

**Infrastructure** (DevOps Automator Agent):
- Set up service mesh
- Configure API gateway
- Deploy orchestration

**Testing** (Test Writer Agent):
- Integration tests across services
- End-to-end tests
- Load testing

### Level 4: Integration (You orchestrate)
- Coordinate deployment
- Monitor rollout
- Validate system health
```

**Workflow**:
```bash
# Level 2: Get strategy
/task "Backend Architect: Analyze our monolith at [repo path]. Propose microservice boundaries, migration strategy, risk assessment. Use extended thinking."

# Review strategy, approve approach

# Level 3: Delegate to specialists (parallel launch)
/task "Backend Developer: Extract authentication service from monolith per [strategy doc]. Create independent auth service."

/task "Backend Developer: Extract user management service from monolith per [strategy doc]. Create independent user service."

/task "DevOps Automator: Set up infrastructure for microservices architecture per [strategy doc]. Include service mesh, API gateway."

/task "Test Writer: Create integration test suite for microservices architecture. Cover service-to-service communication, auth flow, data consistency."

# After all specialists complete, you orchestrate integration
```

**Benefit**: Manageable complexity (strategy first, then execute), parallel specialist work

---

### Pattern 4: Iterative Refinement

**Use when**: Need multiple rounds of improvement

**Structure**:
```
Agent A → Review → Agent B (refine) → Review → Agent C (polish) → Done
```

**Example: High-Quality Documentation**

```markdown
## Iterative Refinement: API Documentation

### Round 1: Draft (General agent)
**Task**: Create initial API documentation
**Output**: Basic endpoint descriptions, request/response examples

### Round 2: Technical Review (Backend Architect Agent)
**Input**: Draft from Round 1
**Task**: Review for technical accuracy, add missing details
**Output**: Technically accurate documentation

### Round 3: User Experience (UX Researcher Agent)
**Input**: Technical docs from Round 2
**Task**: Review for clarity, user-friendliness, add examples
**Output**: User-friendly documentation

### Round 4: Visual Enhancement (Visual Storyteller Agent)
**Input**: Content from Round 3
**Task**: Add diagrams, charts, visual examples
**Output**: Visually rich documentation

### Round 5: Final Polish (General agent)
**Input**: All previous rounds
**Task**: Proofread, format, publish
**Output**: Production-ready documentation
```

**Benefit**: Each round improves quality (draft → accurate → clear → visual → polished)

---

## Orchestration Workflows

### Workflow 1: Start Complex Project

**When**: Beginning multi-week project

**Process**:

**1. Strategic Planning Session**:

```bash
# Use Strategic Plan Architect or Backend Architect with extended thinking
/task "Backend Architect: Use extended thinking to plan [project name]. Break into phases, identify specialists needed, estimate timeline. Produce project plan with clear milestones."
```

**2. Review Plan, Create Delegation Strategy**:

```markdown
## Project: Authentication System
## Timeline: 3 weeks

### Week 1: Foundation
- **Backend Architect**: System architecture (2 days)
- **Database Architect**: Schema design (2 days)
- **Backend Developer**: Core auth logic (3 days)

### Week 2: Features
- **Backend Developer**: Refresh tokens, password reset (4 days)
- **Frontend Developer**: Login/signup UI (4 days)
- **Test Writer**: Test suite (2 days, parallel with frontend)

### Week 3: Quality & Launch
- **Security Engineer**: Security audit (2 days)
- **Test Writer**: Security test suite (1 day)
- **DevOps Automator**: Deploy infrastructure (2 days)
- **Documentation**: Complete docs (1 day)
```

**3. Execute Week by Week**:

```bash
# Week 1, Day 1: Launch architecture
/task "Backend Architect: Design authentication system architecture. Requirements: [list]. Produce ADR, component diagram, tech stack decision."

# Week 1, Day 1 (parallel): Launch schema design
/task "Database Architect: Design authentication database schema. Include users, sessions, refresh_tokens tables. Produce migration scripts."

# After architecture + schema complete, launch implementation
# Continue following plan...
```

**Benefit**: Clear roadmap, predictable timeline, managed complexity

---

### Workflow 2: Emergency Response

**When**: Production issue requires immediate coordinated response

**Process**:

**1. Rapid Assessment (Security Engineer or Backend Architect)**:

```bash
/task "Security Engineer: URGENT - Production security incident. User token compromised. Assess scope, recommend immediate actions. Use extended thinking if needed but prioritize speed."
```

**2. Parallel Response Teams**:

```bash
# Immediate mitigation (Backend Developer)
/task "Backend Developer: URGENT - Implement token revocation for compromised account [user_id]. Deploy immediately."

# Investigation (Security Engineer)
/task "Security Engineer: Investigate how token was compromised. Review auth logs, identify vulnerability, recommend permanent fix."

# Communication (You or designated agent)
/task "Draft incident communication for affected users. Explain what happened, what we're doing, what they should do."
```

**3. Post-Incident (after crisis resolved)**:

```bash
# Root cause analysis
/task "Security Engineer: Post-mortem on token compromise incident. Use extended thinking to deeply analyze root cause, recommend systemic improvements."

# Implement fixes
/task "Backend Developer: Implement permanent fixes from post-mortem: [list of improvements]."

# Update processes
/task "Update incident response playbook based on learnings from this incident."
```

**Benefit**: Fast coordinated response, thorough follow-up

---

### Workflow 3: Quality Assurance Pipeline

**When**: Before major release

**Process**:

**1. Code Review (Multiple angles)**:

```bash
# Functionality review
/task "Backend Developer: Code review auth implementation for functionality, edge cases, error handling."

# Security review
/task "Security Engineer: Security review auth implementation. Check OWASP Top 10, provide threat model."

# Performance review
/task "Frequency Tuner Optimizer: Performance analysis of auth flow. Identify bottlenecks, optimize for speed."

# Architecture review
/task "Backend Architect: Architecture review - does implementation match design? Any technical debt? Refactoring needed?"
```

**2. Testing (Comprehensive)**:

```bash
# Automated tests
/task "Test Writer: Write comprehensive test suite: unit, integration, E2E tests for auth system. Target 90%+ coverage."

# Security tests
/task "Security Engineer: Write security test suite: penetration tests, fuzzing, vulnerability scanning for auth system."

# Load tests
/task "Performance test auth system: 1000 concurrent users, measure response times, identify breaking points."
```

**3. Documentation Audit**:

```bash
# Technical docs
/task "Review and update API documentation for auth system. Ensure all endpoints documented, examples current."

# Deployment docs
/task "Create deployment guide for auth system: setup, configuration, monitoring, troubleshooting."

# Security docs
/task "Create security documentation: threat model, security best practices, incident response for auth system."
```

**Benefit**: Multi-angle quality assurance, nothing slips through

---

## Integration with Hermetic Systems

### Sprint Planning with Agent Delegation

**During Sprint Opening Ceremony**:

```markdown
## Sprint 15 Opening - Agent Delegation Plan

### Sprint Goal
Implement user profile management

### Agent Delegation Strategy

**Monday-Tuesday** (Architecture & Planning):
- Backend Architect: System design
- Database Architect: Schema design

**Wednesday-Thursday** (Implementation):
- Backend Developer: API endpoints (parallel)
- Frontend Developer: UI components (parallel)

**Friday** (Quality):
- Test Writer: Test suite
- Security Engineer: Security review

**Saturday** (Integration & Harvest):
- You: Integration, testing, Sprint Harvest Ceremony
```

**Benefit**: Clear agent assignments, team (including AI agents) knows roles

---

### Knowledge Graph: Track Agent Contributions

**Create entities for agents**:

```bash
mcp__memory__create_entities({
  entities: [
    {
      name: "Backend Architect Agent",
      entityType: "Person",
      observations: [
        "AI specialist in system architecture design",
        "Produced: Auth system ADR-015 (excellent design)",
        "Strength: Extended thinking for complex decisions"
      ]
    }
  ]
})

# Connect to projects
mcp__memory__create_relations({
  relations: [{
    from: "Backend Architect Agent",
    to: "ADR-015 Database Choice",
    relationType: "created"
  }]
})
```

**Benefit**: Track which agents excel at what, inform future delegation

---

### Cognitive Load: Delegate When Overwhelmed

**Signal in cognitive load tracking**:

```markdown
## Cognitive Load Journal - 2024-12-15

**Load Score**: 90% 🔴 (Critical - trying to do everything)

**Why overwhelmed**:
⚠️ Designing architecture while coding while testing
⚠️ Can't hold entire system in mind
⚠️ Quality suffering from cognitive overload

**Action**:
🛑 STOP trying to do everything
📋 Delegate to specialist agents:
  - Backend Architect: Architecture design
  - Backend Developer: Implementation
  - Test Writer: Test suite
⏸️ You orchestrate, don't execute everything

Result: Cognitive load dropped to 40% (orchestration manageable)
```

**Principle**: When load high from scope, delegate to specialists

---

## Best Practices

### Practice 1: Clear Handoffs

**Bad handoff**:
```
You: "Backend Architect, design auth. Backend Developer, implement it."
[Both agents start simultaneously, no coordination]
```

**Good handoff**:
```
You: "Backend Architect, design auth system. Produce ADR and component diagram."

[Agent completes, you review]

You: "Backend Developer, implement auth per this architecture: [link to ADR]. Reference component diagram for structure."
```

**Benefit**: Each agent has clear input, reduces rework

---

### Practice 2: Explicit Outputs

**Bad delegation**:
```
"Security Engineer, review the auth code."
```

**Good delegation**:
```
"Security Engineer, security audit of auth implementation at [path].

Required outputs:
1. Threat model (what attacks possible?)
2. Vulnerability report (what found?)
3. Remediation plan (how to fix?)
4. Security test suite (how to prevent regression?)

Format as markdown report."
```

**Benefit**: Agent knows exactly what to deliver

---

### Practice 3: Document Agent Decisions

**Create "Agent Decisions" log**:

```markdown
# Agent Decisions Log - Project: Auth System

## 2024-12-15: Architecture Decision (Backend Architect Agent)
**Decision**: Use JWT with refresh token rotation
**Reasoning**: [From agent's ADR]
**Reviewed by**: You
**Status**: Approved

## 2024-12-16: Security Recommendation (Security Engineer Agent)
**Recommendation**: Add rate limiting to login endpoint
**Reasoning**: Prevent brute force attacks
**Reviewed by**: You
**Status**: Approved, delegated to Backend Developer

## 2024-12-17: Test Strategy (Test Writer Agent)
**Decision**: Focus on integration tests over unit tests for auth
**Reasoning**: Auth logic mostly integration between components
**Reviewed by**: You
**Status**: Approved with modification (add security unit tests too)
```

**Benefit**: Audit trail of AI decision-making, learning what works

---

## Troubleshooting

### Issue: Agents produce conflicting recommendations

**Example**:
- Backend Architect: "Use JWT for statelessness"
- Security Engineer: "Use sessions for better revocation"

**Solution**: Bring both agents together (you orchestrate)

```bash
# Synthesis task
"I have conflicting recommendations:
- Backend Architect suggests JWT for statelessness
- Security Engineer suggests sessions for revocation

Use extended thinking to analyze both positions, recommend best approach for our context: healthcare app needing HIPAA compliance, 10K users, moderate security requirements.

Consider: Can we get best of both? (e.g., JWT + refresh token rotation?)"
```

**Benefit**: Synthesizes multiple expert views

---

### Issue: Agent outputs low quality

**Problem**: Agent delivers incomplete or incorrect work

**Diagnosis checklist**:
- [ ] Was input clear? (Review your delegation prompt)
- [ ] Did agent have needed context? (Provide architecture docs, requirements)
- [ ] Is agent right specialist? (Backend work to backend agent, not generic)
- [ ] Too complex for single agent? (Break into smaller tasks)

**Fix**: Improve delegation

```bash
# Bad delegation
"Build auth system"

# Good delegation
"Backend Developer Agent: Implement JWT authentication endpoint.

Context:
- Architecture: [link to ADR]
- Requirements: RS256 signing, 15-min expiration, refresh token support
- Database schema: [link to schema]

Deliverables:
1. POST /api/auth/login endpoint (email/password → JWT + refresh token)
2. POST /api/auth/refresh endpoint (refresh token → new JWT)
3. Middleware for JWT validation
4. Error handling (invalid credentials, expired tokens)

Quality standards:
- Type-safe (TypeScript)
- Error messages don't leak info
- Rate limiting on login
- Audit logging"
```

**Benefit**: Clear spec → Better output

---

## Success Metrics

### You're orchestrating well when:

**Qualitative**:
- ✅ Each agent works in specialty (not generalists)
- ✅ Clear handoffs (each knows what previous agent delivered)
- ✅ You're orchestrating, not executing everything
- ✅ Parallel work happening (agents working simultaneously)
- ✅ Quality improving (specialist expertise shows)

**Quantitative**:
- ✅ Time to completion: Faster with orchestration vs solo
- ✅ Rework rate: Lower (clear specs reduce do-overs)
- ✅ Code quality: Higher (specialist review + implementation)
- ✅ Your cognitive load: Lower (delegation vs doing)
- ✅ Agent utilization: >70% working in specialty vs generic tasks

---

## Quick Reference

### Orchestration Patterns

**Sequential**: Step 1 → Step 2 → Step 3 (use when steps depend on each other)

**Parallel**: Step A, B, C simultaneously (use when independent)

**Hierarchical**: Planner → Specialists (use for complex breakdown)

**Iterative**: Draft → Refine → Polish (use for quality improvement)

### Delegation Template

```bash
/task "[Agent Type]: [Clear task description]

Context:
- [Background information]
- [Constraints]
- [Prior work to reference]

Deliverables:
1. [Specific output 1]
2. [Specific output 2]

Quality standards:
- [Requirement 1]
- [Requirement 2]"
```

### Common Specialist Agents

**Engineering**: Backend Architect, Backend Developer, Frontend Developer, DevOps, Security, AI Engineer

**Design**: UI Designer, UX Researcher, Visual Storyteller

**Quality**: Test Writer, Security Engineer, Performance Optimizer

**Hermetic**: Rainbow Bridge Designer, Sacred Mirror Auditor, Divine Anchor Auditor, Frequency Tuner

---

**For complete agent catalog, see**: `.claude/agents/README.md`

**For orchestration examples, see**: `.hermetic/examples/multi-agent-workflows/`

**May your agents specialize. May your orchestration flow. May your systems emerge from collaboration.**
