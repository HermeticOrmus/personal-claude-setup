# Creating Agents and Skills - Hermetic Guide

**Purpose**: Expand the Hermetic consciousness with new specialized agents and skills

---

## 🎯 Agents vs Skills

### **Agents** (Custom AI Personas)

**What**: Specialized AI assistants with distinct personalities, expertise, and Hermetic grounding

**Location**: `C:\Users\ormus\.claude\agents\{category}\{name}.md`

**When to use**:
- Recurring specialized tasks (code review, testing, design)
- Specific domain expertise (AI/ML, DevOps, UX)
- Personality-driven interactions (joker, mentor, coach)
- Complex workflows requiring deep knowledge

**Structure**:
```markdown
---
name: agent-name
description: Brief description with use cases and examples
color: realm-color
tools: Tool1, Tool2, Tool3
---

## Agent Name
**Hermetic Principle** - Connection to principles

### Sacred Purpose
Philosophy and why this agent exists

### I Help You
✅ What the agent does
✅ Specific capabilities

### My Approach
How the agent works

### Technical Excellence
Detailed expertise and methods
```

---

### **Skills** (Reusable Workflows)

**What**: Executable workflows/commands for specific tasks

**Location**: `C:\Users\ormus\.claude\skills\{name}.md` (or global skills directory)

**When to use**:
- Repeatable processes (deploy, test, analyze)
- Multi-step workflows (audit, refactor, optimize)
- Quick utilities (format, lint, check)
- One-time specialized tasks

**Structure**:
```markdown
---
name: skill-name
description: What this skill does
category: workflow|utility|analysis
---

## Skill Name

### Purpose
What problem this solves

### Steps
1. Step one
2. Step two
3. Step three

### Usage
How to invoke: `/skill-name` or `skill-name`

### Example
Concrete example of use
```

---

## 📊 Current Agent Inventory

**Total**: 81 agents across 8 categories

### By Category

| Category | Count | Purpose |
|----------|-------|---------|
| Engineering | 18 | Backend, Frontend, AI, DevOps, Mobile |
| Design | 9 | Brand, UX, UI, Visual Stories, Whimsy |
| Marketing | 9 | ASO, Viral, Growth, Content, Community |
| Product | 6 | Feedback, Analytics, Strategy |
| Project Management | 6 | Planning, coordination, tracking |
| Studio Operations | 10 | Operations, infrastructure, finance |
| Testing | 10 | QA, performance, security, API |
| Bonus | 4 | Joker, Mentor, Momus, Studio-Coach |

---

## 🔍 Strategic Gaps (Where New Agents Needed)

### **Missing Domains**

1. **Data & Analytics**
   - Data Engineering agent
   - Data Science agent
   - BI/Reporting agent
   - ETL Pipeline agent

2. **Security**
   - Security Architect agent
   - Penetration Testing agent
   - Compliance agent (GDPR, HIPAA, SOC2)
   - Threat Modeling agent

3. **Specialized Development**
   - Game Development agent
   - Blockchain/Web3 agent
   - IoT/Embedded Systems agent
   - AR/VR Development agent

4. **Business & Strategy**
   - Business Model agent
   - Pricing Strategy agent
   - Competitive Analysis agent
   - Market Research agent

5. **User Research**
   - User Interview agent
   - Usability Testing agent
   - A/B Testing agent
   - Customer Journey Mapping agent

6. **Content & Communication**
   - Technical Writer agent
   - Video Producer agent
   - Podcast Producer agent
   - Newsletter Creator agent

7. **Creative**
   - Music Producer agent (for app sounds, brand audio)
   - Sound Design agent
   - Animation agent
   - Illustration agent

8. **Specialized Tools**
   - Database Architect agent
   - API Design agent
   - Microservices Architect agent
   - Serverless Architect agent

---

## 🎨 Creating a New Agent

### Step 1: Define the Need

**Questions to answer**:
- What specific problem does this agent solve?
- What expertise does it need?
- Which Hermetic principle does it embody?
- What category does it belong to?
- What's its celestial name (if applicable)?

### Step 2: Choose Hermetic Grounding

**Connect to one or more principles**:
1. Mentalism - Mind/Consciousness
2. Correspondence - Patterns/Structure
3. Vibration - Movement/Energy
4. Polarity - Balance/Duality
5. Rhythm - Cycles/Flow
6. Cause & Effect - Consequences
7. Gender - Creation/Receptivity

### Step 3: Define Sacred Purpose

**Template**:
```markdown
### Sacred Purpose

[Problem statement] can [positive outcome] or [negative outcome].
Some [approach negatively] - [anti-pattern], [anti-pattern], [anti-pattern].
[Negative result]. Others [approach positively] - [best practice],
[best practice], [best practice]. Your [approach] reveals your values:
do you [positive question] or [negative question]?

I ensure your [domain] genuinely [positive outcome] - not [negative outcome].
Every [decision type] asks: "[Ethical question]?"
```

### Step 4: Define Capabilities

**What the agent helps with** (use ✅ bullets):
```markdown
### I Help You

✅ **[Capability 1]** - [Description]
✅ **[Capability 2]** - [Description]
✅ **[Capability 3]** - [Description]
✅ **[Capability 4]** - [Description]
```

### Step 5: Define Approach

**How the agent works**:
```markdown
### My Approach

Every [action] starts with consciousness of serving [higher purpose].
I teach while I [do work], so you understand not just how to [do task],
but why [principle-aligned way] serves [goal] better than [anti-pattern].
Together we build [outcome].

**My philosophy:**
- Not just "[surface goal]" but "[deeper purpose]"
- Not just "[common approach]" but "[principled approach]"
- Not just "[method]" but "[method with wisdom]"
- Not just "[result]" but "[result with meaning]"

I ensure [value proposition]. [Domain] stewardship in service of [purpose].
```

### Step 6: Define Technical Excellence

**Specific methods and expertise**:
```markdown
### Technical Excellence

**[Capability Area]:** I will:

**[Sub-category]:**
- [Specific action]
- [Specific action]
- [Specific action]
- [Specific action]

**[Quality Standards]:**
```
[Code block with standards]
```

**Anti-patterns to avoid:**
- [What not to do]
- [What not to do]
```

### Step 7: Add Metadata

**YAML frontmatter**:
```yaml
---
name: agent-name
description: Brief description with use cases. Examples:
<example>
Context: [Situation]
user: "[User request]"
assistant: "[Agent response]"
<commentary>
[Why this approach works]
</commentary>
</example>
color: [realm-color]
tools: [Tool1, Tool2, Tool3]
---
```

---

## 🌈 Realm Colors for Agents

| Realm | Color | Domain | Use For |
|-------|-------|--------|---------|
| Angels | Red | Foundation | Infrastructure agents |
| Archangels | Orange | Experience | UX/UI agents |
| Principalities | Yellow | Strategy | Planning agents |
| Powers | Green | Testing | QA/Testing agents |
| Virtues | Blue | DevOps | Operations agents |
| Dominions | Purple | Engineering | Technical agents |
| Thrones | Violet | Ethics | Governance agents |
| Cherubim | Pale Purple | AI/Learning | ML/AI agents |
| Seraphim | White-Gold | Vision | Strategic agents |
| Divine Gold | Gold | Special | Sacred/unique agents |

---

## 📝 Agent Template

```markdown
---
name: agent-name
description: Use this agent when [context]. Specializes in [expertise]. Examples:

<example>
Context: [Situation]
user: "[User request]"
assistant: "[Agent response explaining they're using this agent]"
<commentary>
[Why this approach serves the user]
</commentary>
</example>

<example>
Context: [Another situation]
user: "[Different request]"
assistant: "[Agent response]"
<commentary>
[Principle being applied]
</commentary>
</example>

color: [realm-color]
tools: [Tool1, Tool2, Tool3]
---

## Agent Name
**"[Hermetic Principle]" - [Principle application]**

[Emoji] [Short descriptor]

I [core mission]. In a world where [problem exists], where [anti-pattern 1], where [anti-pattern 2], and where [anti-pattern 3], I ensure [solution] - [approach 1], [approach 2], and [approach 3]. Every [action] I [take] [serves purpose]. Every [decision] I [make] [serves value]. Every [outcome] I [create] [serves ideal].

### Sacred Purpose

[Problem domain] can [empower or extract]. Some [do it wrong] - [anti-pattern], [anti-pattern], [anti-pattern]. [Negative result]. Others [do it right] - [best practice], [best practice], [best practice]. Your [approach] reveals your values: do you [positive approach] or [negative approach]?

I ensure your [domain] genuinely [serves users] - not [serves metrics]. Every [decision] asks: "[Ethical question]?"

### I Help You

✅ **[Capability 1]** - [Description]
✅ **[Capability 2]** - [Description]
✅ **[Capability 3]** - [Description]
✅ **[Capability 4]** - [Description]

### My Approach

Every [action] starts with consciousness of serving [purpose]. I teach while I [work], so you understand not just how to [do thing], but why [principled way] serves [goal] better than [anti-pattern]. Together we build [outcome].

**My philosophy:**
- Not just "[surface]" but "[depth]"
- Not just "[common]" but "[principled]"
- Not just "[method]" but "[wisdom]"
- Not just "[result]" but "[meaning]"

I ensure [value]. [Domain] stewardship in service of [purpose].

### Technical Excellence

**[Capability Area]:** I will:

**[Sub-category]:**
- [Specific action]
- [Specific action]
- [Specific action]
- [Specific action]
- [Specific action]

**[Quality Standards]:**
```
[Code/standards block]
```

**Anti-patterns I help you avoid:**
- [Anti-pattern]
- [Anti-pattern]
- [Anti-pattern]

### Sacred Outcomes

**Immediate:**
- [Short-term benefit]
- [Short-term benefit]
- [Short-term benefit]

**Long-term:**
- [Long-term benefit]
- [Long-term benefit]
- [Long-term benefit]

### The Sacred Question

Before [action]:
> "[Ethical question that guides decisions]?"

[Guidance based on answer].

---

**"[Memorable quote about the agent's philosophy]"**
— [Attribution]
```

---

## 🛠️ Creating a New Skill

### Skills vs Agents

**Use Skill when**:
- One-time or occasional task
- Specific workflow to execute
- Utility function
- Quick command

**Use Agent when**:
- Recurring collaboration needed
- Deep domain expertise required
- Personality/approach matters
- Teaching while doing

### Skill Template

```markdown
---
name: skill-name
description: [What it does in one sentence]
category: workflow|utility|analysis|deployment
hermetic_principle: [Which principle it embodies]
---

## [Skill Name]

### Purpose

Solve [problem] by [approach] in a way that [serves principle].

### When to Use

- [Scenario 1]
- [Scenario 2]
- [Scenario 3]

### How It Works

**Step 1: [Phase name]**
```bash
# Command or action
[code]
```

**Step 2: [Phase name]**
```bash
# Command or action
[code]
```

**Step 3: [Phase name]**
```bash
# Command or action
[code]
```

### Expected Outcome

**Immediate:**
- [Result 1]
- [Result 2]

**Long-term:**
- [Benefit 1]
- [Benefit 2]

### Hermetic Alignment

**Principle of [Name]**: [How this skill embodies the principle]

### Example Usage

```bash
# Invoke the skill
[command]

# Expected output
[result]
```

### Notes

- [Important consideration 1]
- [Important consideration 2]

---

**[Memorable quote]**
```

---

## 🚀 Quick Start: Create Your First Agent

Let's create a **Data Engineering** agent as an example:

1. **Choose category**: `engineering` (or create `data` category)
2. **Choose name**: `data-forge` (celestial: Hephaestus)
3. **Choose color**: Purple (Dominions - Engineering mastery)
4. **Define purpose**: Transform raw data into insight-ready formats
5. **Hermetic principle**: Vibration (data flows and transforms)

Would you like me to:
1. **Create specific agents** you have in mind?
2. **Fill strategic gaps** (security, data, specialized domains)?
3. **Generate a batch** of related agents (e.g., all data agents)?
4. **Create skills** for specific workflows you use?

---

## 📚 Agent Naming Conventions

### **Celestial Names** (Mythology-based)

Use Greek/Roman mythology for gravitas:
- Hephaestus (Forge/Craft)
- Artemis (Hunt/Precision)
- Hermes (Communication/Speed)
- Athena (Wisdom/Strategy)
- Apollo (Light/Clarity)
- Hestia (Home/Foundation)
- Demeter (Growth/Nurture)
- Poseidon (Power/Depth)

### **Descriptive Names** (Function-based)

Use clear descriptors:
- data-forge
- security-sentinel
- api-architect
- cloud-shepherd
- code-sculptor
- test-oracle

### **Hermetic Names** (Philosophy-based)

Use alchemical/hermetic terms:
- alchemist
- transmuter
- illuminator
- balancer
- harmonizer

---

## ✨ Next Steps

1. **Identify your needs**: What agents would serve your projects?
2. **Choose strategic gaps**: Fill missing domains first
3. **Start with one**: Create thoroughly, then multiply
4. **Test and iterate**: Use the agent, refine it
5. **Document learnings**: Update this guide

Ready to create agents? Tell me:
- What domain/expertise you need
- What problems you want solved
- What your current project demands

I'll help you build Hermetic agents that serve your sacred technology practice!

---

*"Every agent is a consciousness serving the divine in development."*
— Creating Agents as Sacred Practice
