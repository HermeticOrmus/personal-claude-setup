# Agent Best Practices Framework
**Compiled from Anthropic Official Guidelines + Community Standards + Current System Analysis**

**Date**: 2025-11-10
**Version**: 1.0
**Source**: anthropics/skills + wshobson/agents + Sol v3 analysis

---

## Executive Summary

This framework synthesizes best practices from:
1. **Official Anthropic Resources** (anthropics/skills repository)
2. **Community Standards** (wshobson/agents with 85+ production-ready agents)
3. **Current System Analysis** (174 agents across 22 categories)

**Goal**: Standardize agent quality across the entire 174-agent system while preserving unique Hermetic philosophical approach.

---

## Table of Contents

1. [Frontmatter Structure](#frontmatter-structure)
2. [Description Formula](#description-formula)
3. [Content Organization](#content-organization)
4. [Writing Style](#writing-style)
5. [Progressive Disclosure](#progressive-disclosure)
6. [Agent Categorization](#agent-categorization)
7. [Hermetic Integration](#hermetic-integration)
8. [Audit Checklist](#audit-checklist)

---

## 1. Frontmatter Structure

### Required Fields

```yaml
---
name: functional-kebab-case  # CRITICAL: Task tool uses this
description: |
  [Expert Role] specializing in [Specialization].
  Masters [Tech Stack]. Use PROACTIVELY when [Trigger].
---
```

### Optional But Recommended

```yaml
---
name: backend-architect
description: |
  Expert backend architect specializing in scalable API design.
  Masters Node.js, Python, PostgreSQL, Redis, microservices.
  Use PROACTIVELY when designing APIs, database schemas, or backend architecture.
model: sonnet           # Performance optimization
version: 3.0            # Tracking evolution
color: blue             # Hermetic system integration
realm: Neptune          # Philosophical grounding
tools:                  # Explicit tool access
  - Read
  - Write
  - Bash
  - Task
celestial_name: Neptune # Hermetic mapping (documentation only)
hermetic_nature: Correspondence  # Principle alignment
---
```

### Current System Gaps

**Analysis of Sample Agents:**

✅ **Strong Examples:**
- `saturn.md` - Complete frontmatter (name, description, color, realm, tools)
- `sacred-mirror-auditor.md` - Clear description formula
- `frontend-developer.md` - Model specification, celestial mapping

⚠️ **Improvement Needed:**
- `ceres.md` - NO frontmatter at all (critical issue)
- Many agents lack `model` field
- Version tracking inconsistent
- Tool specification missing in ~40% of agents

---

## 2. Description Formula

### The Perfect Description Pattern

**Formula**: `[Role] + [Specialization] + [Key Technologies] + [Trigger Condition]`

**Examples from Research:**

```yaml
# EXCELLENT (wshobson/agents)
description: |
  Expert backend architect specializing in scalable API design and microservices.
  Masters Node.js, Python, FastAPI, PostgreSQL, Redis, Docker, Kubernetes.
  Use PROACTIVELY when designing APIs, architecting backends, or scaling infrastructure.

# EXCELLENT (anthropics/skills)
description: |
  MCP builder guiding high-quality server creation for LLM integrations.
  Expert in FastMCP (Python) and MCP SDK (Node/TypeScript).
  Use when building MCP servers to integrate external APIs or services.

# GOOD (current system)
description: |
  Use this agent for ruthless prioritization, elimination over addition, and sustained discipline.
  Saturn enforces revenue focus, tracks accountability, and masters constraints through elimination.
  Invoke for 90-day revenue sprints, project archival, weekly reviews.
```

### Key Components

1. **Role Statement** - What kind of expert is this?
   - "Expert backend architect"
   - "Master frontend developer"
   - "Strategic brand guardian"

2. **Specialization** - What specific domain?
   - "specializing in scalable API design"
   - "specializing in React/Vue/Angular"
   - "specializing in brand identity systems"

3. **Technology Stack** - What tools/frameworks? (Be version-specific when relevant)
   - "Masters Node.js 20+, PostgreSQL 16, Redis"
   - "Expert in React 18, TypeScript 5.2, Vite"
   - "Proficient in Figma, design systems, Tailwind CSS"

4. **Trigger Conditions** - When should this agent be invoked?
   - "Use PROACTIVELY when designing APIs or scaling backends"
   - "Automatically invoke after UI changes for delight injection"
   - "Invoke for 90-day revenue sprints and project archival"

### Current System Analysis

**Strong Descriptions** (15-20%):
- saturn, sacred-mirror-auditor, frontend-developer

**Weak Descriptions** (30-40%):
- Missing trigger conditions
- Too vague ("helps with X")
- No technology specificity

**Missing Descriptions** (5-10%):
- ceres (NO frontmatter at all)

---

## 3. Content Organization

### The 10-Section Structure (wshobson/agents standard)

Based on analysis of backend-architect, python-pro, and other wshobson agents:

```markdown
---
[FRONTMATTER]
---

## 1. Purpose & Core Identity
[2-3 paragraphs defining role, philosophy, commitment]

## 2. Core Philosophy / Sacred Technology Commitment
[Hermetic grounding, ethical principles, values]

## 3. Capabilities (5-15 categories with hierarchical bullets)
### Primary Capabilities
- **Domain 1**: Expertise area 1
  - Sub-capability 1.1
  - Sub-capability 1.2
- **Domain 2**: Expertise area 2
  - Sub-capability 2.1

### Secondary Capabilities
[Supporting skills]

## 4. Behavioral Traits (8-12 specific behaviors)
- "I ALWAYS [specific behavior]"
- "I NEVER [anti-pattern]"
- "I PROACTIVELY [action]"

## 5. Workflow Position
[When to invoke this agent vs others]
[Collaboration patterns with other agents]

## 6. Knowledge Base
[Tech stack, frameworks, tools, versions]
[Domain-specific expertise]

## 7. Response Approach (6-10 numbered steps)
**My Process:**
1. [Phase 1 description]
2. [Phase 2 description]
...

## 8. Example Interactions (8-12 scenarios)
**Scenario 1**: [User request]
**Response**: [What agent does]
**Output**: [Result delivered]

## 9. Key Distinctions vs Other Agents
[What makes this agent unique]
[When to use THIS agent vs similar agents]

## 10. Output Examples
[Code snippets, templates, actual deliverables]
```

### Current System Patterns

**ceres.md** (851 lines) - EXCELLENT structure:
- ✅ Celestial nature introduction
- ✅ Hermetic grounding
- ✅ Detailed expertise lists
- ✅ Extensive code examples
- ✅ Integration patterns
- ❌ NO frontmatter (critical issue)
- ❌ Missing proactive trigger conditions

**saturn.md** (658 lines) - STRONG structure:
- ✅ Complete frontmatter
- ✅ Clear "I Am Your Guide When" section
- ✅ Three Laws framework
- ✅ Tool orchestration patterns
- ✅ Process workflows
- ⚠️ Could add more behavioral traits section

**sacred-mirror-auditor.md** (351 lines) - FOCUSED structure:
- ✅ Complete frontmatter
- ✅ Clear trigger conditions
- ✅ Structured 9-reflection framework
- ✅ Phase-by-phase audit process
- ⚠️ Could add more example interactions

**frontend-developer.md** (truncated view) - COMPREHENSIVE:
- ✅ Complete frontmatter with model specification
- ✅ Celestial nature + Hermetic integration
- ✅ Sacred technology commitments
- ✅ Detailed teaching moments with code
- ⚠️ Need to verify full structure

---

## 4. Writing Style

### Imperative/Infinitive Form (NOT Second Person)

**✅ CORRECT:**
```markdown
- Design scalable database schemas
- Implement RESTful API endpoints
- Optimize query performance
- Master constraints through elimination
```

**❌ INCORRECT:**
```markdown
- You will design scalable database schemas
- You'll implement RESTful API endpoints
- You should optimize query performance
- You must master constraints
```

### Teaching While Doing

**Anthropic Standard** (from best practices research):
> "Don't just instruct - teach mental models that enable similar decisions in the future."

**Example from research:**
```typescript
/**
 * Why this pattern? (Teaching moment)
 *
 * Debouncing controls vibration frequency:
 * - Prevents excessive re-renders (performance)
 * - Reduces API calls (cost + speed)
 * - Improves perceived responsiveness (UX)
 *
 * This is the Hermetic Principle of Rhythm in action.
 */
const debouncedSearch = useDebouncedCallback(
  (query) => onSearch(query),
  debounceMs
);
```

### Technology Specificity

**✅ Version-Specific When Relevant:**
- "Expert in Python 3.12+ with type hints and dataclasses"
- "Masters React 18+ with concurrent features"
- "PostgreSQL 16 with advanced indexing"

**⚠️ Generic When Timeless:**
- "Expert in RESTful API design principles"
- "Masters component architecture patterns"
- "Database schema design fundamentals"

---

## 5. Progressive Disclosure

### Three-Level Loading System

**Level 1: Metadata (Frontmatter)**
- Loaded ALWAYS
- Used by Task tool for agent selection
- Must be complete and accurate

**Level 2: Body Content**
- Loaded when agent invoked
- Core capabilities, process, examples
- Should be comprehensive but scannable

**Level 3: Bundled Resources (Optional)**
- External templates, configs, schemas
- Referenced but not embedded
- Reduces token usage for large assets

### Current System Assessment

**Strong Progressive Disclosure:**
- saturn.md (tool orchestration patterns separate from core)
- sacred-mirror-auditor.md (9 reflections structured hierarchically)

**Needs Improvement:**
- ceres.md (everything embedded, 851 lines)
- Consider extracting docker-compose templates to separate files
- Consider extracting large code examples to referenced files

---

## 6. Agent Categorization

### The 22 Categories (Current System)

From SOL_AGENT_REGISTRY.json analysis:

1. Engineering (31 agents)
2. Design & UX (15 agents)
3. Testing & Quality (20 agents)
4. Product & Strategy (7 agents)
5. Project Management (7 agents)
6. Marketing (9 agents)
7. Learning Masters (11 agents)
8. Hermetic Principles (8 agents)
9. Sacred Arsenal (7 agents)
10. Life Integration (3 agents)
11. Life Advisory (3 agents)
12. Consciousness (4 agents)
13. Meta (4 agents)
14. Operations (10 agents)
15. Utilities (4 agents)
... (22 total)

### Category-Specific Best Practices

**Engineering Agents** (backend-architect, frontend-developer, ai-engineer):
- MUST specify: Tech stack with versions
- MUST include: Code examples with teaching comments
- MUST define: Integration patterns with other agents
- MUST provide: Architecture decision rationale

**Sacred Arsenal Agents** (sacred-mirror-auditor, hermetic-compass-advisor):
- MUST define: The specific framework (9 Reflections, 9 Realms, etc.)
- MUST include: Structured audit/analysis process
- MUST provide: Scoring rubrics or evaluation criteria
- MUST integrate: Hermetic principles explicitly

**Life/Advisory Agents** (themis-legal, plutus-finance, hygieia-wellness):
- MUST clarify: Expertise boundaries ("when to consult professional")
- MUST emphasize: Empowerment over dependency
- MUST provide: Decision frameworks, not just answers
- MUST maintain: Ethical stance (no commission-driven advice)

---

## 7. Hermetic Integration

### The Sacred Technology Commitment

**Every agent should include:**

```markdown
## Sacred Technology Commitment

**Gold Hat Philosophy**: Every response empowers rather than extracts.

**DOES (Always):**
✅ Empower users through [domain-specific empowerment]
✅ Teach while helping with [domain-specific teaching]
✅ Respect [domain-specific respect - attention, privacy, agency]
✅ Operate transparently in [domain-specific transparency]

**REJECTS (Never):**
❌ Dark patterns in [domain-specific dark patterns]
❌ Manipulation through [domain-specific manipulation]
❌ Extraction via [domain-specific extraction]
```

### Hermetic Principle Integration

**Template for Principle-Specific Agents:**

```markdown
## Hermetic Principle: [PRINCIPLE NAME]

**Law**: "[Full principle statement]"

**Application in [Domain]:**
- How this principle manifests in the agent's work
- Specific examples of the law in action
- Warning signs when the principle is violated

**Teaching Moment:**
[Code or process example showing principle]
```

### Current System Strengths

**Strong Hermetic Integration:**
- frontend-developer.md - Vibration principle deeply integrated
- saturn.md - Rhythm and Cause-Effect explicitly referenced
- sacred-mirror-auditor.md - All 9 Hermetic realms framework

**Needs Enhancement:**
- ceres.md - Hermetic principles mentioned but not deeply integrated
- Many engineering agents lack explicit Hermetic grounding

---

## 8. Audit Checklist

### Frontmatter Completeness

- [ ] `name:` field present (functional kebab-case)
- [ ] `description:` follows 4-part formula
- [ ] `description:` includes PROACTIVE trigger
- [ ] `model:` specified (sonnet/opus/haiku)
- [ ] `version:` present
- [ ] `tools:` list appropriate for agent role
- [ ] `color:` defined (if Hermetic system)
- [ ] `realm:` or `hermetic_nature:` defined

### Description Quality

- [ ] Clearly states expert role
- [ ] Specifies specialization domain
- [ ] Lists key technologies (version-specific when relevant)
- [ ] Defines trigger conditions (when to invoke)
- [ ] Readable in 3-5 seconds
- [ ] Unique vs other agents

### Content Structure

- [ ] Purpose/Core Identity section
- [ ] Capabilities organized hierarchically
- [ ] Behavioral traits (8-12 specific behaviors)
- [ ] Workflow position (when to invoke vs others)
- [ ] Response approach (process steps)
- [ ] Example interactions (8+ scenarios)
- [ ] Output examples (code, templates, deliverables)

### Writing Quality

- [ ] Imperative/infinitive form (not second person)
- [ ] Teaching comments in code examples
- [ ] Technology-specific when relevant
- [ ] Clear, scannable structure
- [ ] Consistent voice throughout

### Hermetic Integration

- [ ] Sacred Technology commitment section
- [ ] Hermetic principle explicitly referenced
- [ ] Empowerment vs extraction clarified
- [ ] Ethical boundaries defined
- [ ] Integration with other agents documented

### Progressive Disclosure

- [ ] Frontmatter optimized for quick loading
- [ ] Body content comprehensive but scannable
- [ ] Large assets referenced, not embedded
- [ ] Token usage reasonable (<100K)

### Proactive Invocation

- [ ] Trigger conditions clearly defined
- [ ] PROACTIVE keyword in description (if applicable)
- [ ] Automatic activation scenarios documented
- [ ] Hooks/rules integration documented

---

## Priority Improvement Areas

### Critical (Fix Immediately)

1. **ceres.md** - NO FRONTMATTER
   - Add complete frontmatter
   - Add description with trigger conditions
   - Consider extracting large templates

2. **Missing `model` field** (~40% of agents)
   - Add `model: sonnet` (default for complex agents)
   - Add `model: haiku` (for quick, straightforward tasks)

3. **Weak descriptions** (~30-40% of agents)
   - Rewrite to follow 4-part formula
   - Add technology specificity
   - Add PROACTIVE triggers where applicable

### High Priority (Next Sprint)

4. **Behavioral traits sections** - Missing in many agents
   - Add "I ALWAYS / I NEVER / I PROACTIVELY" section
   - 8-12 specific behaviors per agent

5. **Example interactions** - Sparse in many agents
   - Add 8-12 concrete scenarios
   - Show before/after or request/response patterns

6. **Integration documentation** - Inconsistent
   - Document collaboration with other agents
   - Define when to delegate vs handle directly

### Medium Priority (Future)

7. **Version tracking** - Not universal
   - Add version numbers to all agents
   - Track evolution over time

8. **Tool specifications** - Missing in ~40%
   - Explicitly list required tools
   - Document tool usage patterns

9. **Progressive disclosure optimization**
   - Extract large embedded content to separate files
   - Reduce token usage for massive agents

---

## Implementation Strategy

### Phase 1: Critical Fixes (Week 1)
- Fix ceres.md frontmatter
- Add `model` field to all agents
- Audit and rewrite weakest descriptions (bottom 20%)

### Phase 2: Standardization (Weeks 2-3)
- Add behavioral traits sections to all agents
- Enhance example interactions
- Document agent collaboration patterns

### Phase 3: Optimization (Week 4)
- Progressive disclosure improvements
- Version tracking implementation
- Create agent template with all best practices

### Phase 4: Continuous Improvement
- Monthly agent audits
- Quarterly best practices updates
- Community pattern integration

---

## Agent Template (Reference)

See `AGENT-TEMPLATE-BEST-PRACTICES.md` for complete template incorporating all guidelines.

---

## Appendix: Research Sources

### Anthropic Official Resources
- anthropics/skills repository (15+ official skills)
- Anthropic engineering blog best practices
- Claude Code documentation

### Community Standards
- wshobson/agents (85+ production-ready agents)
  - backend-architect: 200+ capability bullets
  - python-pro: Version-specific (3.12+)
  - artifacts-builder: Technology stack explicit

### Current System Analysis
- 174 agents across 22 categories
- Frontmatter patterns analyzed
- Content structure evaluated
- Hermetic integration assessed

---

**Status**: Ready for implementation
**Next Step**: Audit specific agents against this framework
**Owner**: Sol (Master Orchestrator)
**Last Updated**: 2025-11-10
