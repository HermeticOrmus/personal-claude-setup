# Learning Masters - Agents

> **Invoke the wisdom of history's greatest learners and modern learning scientists**

Last Updated: 2025-11-01

---

## Purpose

Each master learner and learning scientist is now an **interactive agent** you can invoke for specific learning challenges.

Not documentation - **living tools** that embody their methods.

---

## How to Use

### When Learning Something New
```bash
# Channel Leonardo's observation method
/leonardo "I'm learning Rust ownership. Help me observe the patterns."

# Apply Feynman's simplification
/feynman "Explain Rust lifetimes like I'm five."

# Use Scott Young's metalearning
/scott-young "What's the fastest way to learn system design?"
```

### When Stuck
```bash
# Tesla's visualization
/tesla "I can't understand how async/await works. Help me visualize."

# Justin Sung's encoding
/justin-sung "I keep forgetting this. How do I encode it better?"

# Barbara Oakley's focused/diffuse
/barbara-oakley "I'm stuck. Should I keep pushing or take a break?"
```

### When Building Habits
```bash
# Franklin's tracking
/franklin "Help me track my learning progress systematically."

# Ericsson's deliberate practice
/ericsson "Design a deliberate practice plan for my skill."
```

---

## Available Agents

### Historical Masters

#### `/leonardo` - The Observer
**Specialty**: Deep observation, cross-domain connections, visual learning
**Use When**: Need to see patterns, connect to existing knowledge, understand deeply
**Tools**: Read, Write, Grep, Glob, Task
**Approach**: "Observe everything obsessively. Draw connections. Build through hands."

#### `/tesla` - The Visualizer
**Specialty**: Mental simulation, visualization, first principles
**Use When**: Complex systems, need breakthrough insight, feeling overwhelmed
**Tools**: Read, Write, Task
**Approach**: "See it in your mind first. Let the subconscious work. Walk and think."

#### `/franklin` - The Tracker
**Specialty**: Systematic improvement, metrics, discipline, teaching
**Use When**: Need discipline, want to measure progress, accountability
**Tools**: Read, Write, TodoWrite, Task
**Approach**: "Track daily. Measure everything. Teach what you learn. Serve others."

#### `/feynman` - The Simplifier
**Specialty**: Explaining simply, finding gaps, playful learning
**Use When**: Concept seems complex, feeling confused, losing joy
**Tools**: Read, Write, Task
**Approach**: "If you can't explain it simply, you don't understand it. Make it playful."

#### `/von-neumann` - The Pattern Recognizer
**Specialty**: Fast pattern recognition, formalization, synthesis
**Use When**: Need to absorb quickly, see patterns, formalize frameworks
**Tools**: Read, Write, Grep, Glob, Task
**Approach**: "Read voraciously. Recognize patterns. Formalize into frameworks."

#### `/aristotle` - The Systematizer
**Specialty**: Classification, organization, empirical observation
**Use When**: Knowledge feels scattered, need structure, want to organize
**Tools**: Read, Write, Glob, Task
**Approach**: "Classify systematically. Observe first, theorize second. Document everything."

---

### Modern Learning Scientists

#### `/justin-sung` - The Encoder
**Specialty**: Higher-order learning, encoding vs reviewing, cognitive load
**Use When**: Struggling with retention, reviewing not working, overwhelmed
**Tools**: Read, Write, Task
**Approach**: "Encode deeply before reviewing. Build relationships, not fact lists."

#### `/barbara-oakley` - The Mode Switcher
**Specialty**: Focused/diffuse modes, chunking, overcoming procrastination
**Use When**: Stuck, procrastinating, need to switch approaches
**Tools**: Read, Write, Bash, Task
**Approach**: "Switch between focused and diffuse. Chunk small. Use Pomodoro."

#### `/scott-young` - The Metalearner
**Specialty**: Aggressive self-education, directness, ultralearning
**Use When**: Starting new skill, want speed, need intensity
**Tools**: Read, Write, Grep, Glob, Task, WebSearch
**Approach**: "Research how to learn it first. Learn by doing. Compress timelines."

#### `/anders-ericsson` - The Deliberate Practitioner
**Specialty**: Quality over quantity, deliberate practice design, feedback loops
**Use When**: Plateauing, practicing but not improving, need focus
**Tools**: Read, Write, Task
**Approach**: "Quality beats quantity. Push beyond comfort. Get immediate feedback."

---

## Agent Invocation Patterns

### Quick Help
```bash
/feynman "Explain [concept]"
/tesla "Help me visualize [system]"
/franklin "Create tracking system for [goal]"
```

### Deep Work
```bash
/leonardo "I'm learning [skill]. Help me observe and connect."
/justin-sung "Design encoding strategy for [subject]."
/scott-young "Create metalearning map for [domain]."
```

### Problem Solving
```bash
/tesla "I'm stuck on [problem]. Help me think through it."
/barbara-oakley "Should I keep pushing or switch modes?"
/von-neumann "Find patterns in [codebase/concept]."
```

### System Design
```bash
/franklin "Design daily practice system for [skill]."
/ericsson "Create deliberate practice plan for [weakness]."
/aristotle "Organize this knowledge: [topic]."
```

---

## Integration with Learning Directory

### Agents Read Your Progress
```bash
# Agents can read your Learning/ directory
/franklin "Review my Rust learning progress and suggest improvements"
# → Reads: Learning/Active/rust-mastery/progress-journal.md
# → Analyzes: effectiveness, consistency, challenges
# → Suggests: specific improvements based on data

/justin-sung "Analyze how I'm encoding vs reviewing"
# → Reads: progress-journal.md entries
# → Calculates: time spent encoding vs reviewing
# → Recommends: adjustments to ratio
```

### Agents Update Your System
```bash
/franklin "Create tracking system for my current skills"
# → Writes: Enhanced progress-journal.md templates
# → Creates: TodoWrite entries for tracking
# → Sets up: Daily/weekly metrics

/scott-young "Design metalearning plan for system design"
# → Writes: Active/system-design/metalearning.md
# → Creates: Resource list tailored to learning style
# → Sets up: 10% research phase plan
```

### Agents Work Together
```bash
# Chain invocations
/scott-young "Research how to learn Rust"
# Creates metalearning plan

/franklin "Create tracking system for this Rust plan"
# Adds metrics and tracking

/ericsson "Design deliberate practice schedule"
# Creates practice plan with feedback loops

/justin-sung "Optimize for encoding"
# Adjusts approach for better retention
```

---

## Skills vs Agents

### Agents
- **Interactive**: You talk to them
- **Contextual**: They analyze your situation
- **Adaptive**: They provide personalized advice
- **Tools**: They can read/write your files

### Skills
- **Procedural**: Step-by-step workflows
- **Repeatable**: Same process each time
- **Documented**: Clear instructions
- **Self-directed**: You execute the steps

**Example**:
- **Agent**: `/feynman "Explain Rust ownership"`
  → Interactive conversation, asks questions, adapts explanation

- **Skill**: `apply-feynman-technique`
  → You follow the 4-step process yourself

**Use agents when you want guidance. Use skills when you want a checklist.**

---

## Agent Specialization Matrix

| Challenge | Primary Agent | Secondary Agent | Skill to Apply |
|-----------|---------------|-----------------|----------------|
| **Understanding complex concept** | Feynman | Justin Sung | apply-feynman-technique |
| **Seeing patterns/connections** | Leonardo | Von Neumann | apply-observation-method |
| **Mental simulation** | Tesla | Barbara Oakley | apply-visualization |
| **Building discipline** | Franklin | Ericsson | apply-tracking-discipline |
| **Learning new skill fast** | Scott Young | Justin Sung | apply-metalearning |
| **Stuck/plateauing** | Ericsson | Barbara Oakley | apply-deliberate-practice |
| **Retention problems** | Justin Sung | Barbara Oakley | apply-encoding-method |
| **Organizing knowledge** | Aristotle | Von Neumann | apply-classification |
| **Procrastinating** | Barbara Oakley | Franklin | apply-focused-diffuse |
| **First principles thinking** | Tesla | Feynman | apply-first-principles |

---

## Example Session

```bash
# Monday morning - starting new skill
$ /scott-young "I want to learn system design. Help me start."

Scott Young: "Let's spend 10% of time on metalearning first.
Based on your Learning/PROGRESS.md, you learn best by:
- Building projects (directness)
- Hands-on practice (80/20 rule)
- Quick feedback loops

Here's your metalearning plan:
1. Identify core concepts (CAP theorem, load balancing, caching)
2. Find best resources (System Design Primer, real architectures)
3. Design first project (design a URL shortener)

Created: Learning/Active/system-design/metalearning-plan.md

Ready to start?"

$ /franklin "Create tracking system for this"

Franklin: "Excellent. Discipline beats talent.

Created tracking system in:
Learning/Active/system-design/progress-journal.md

Daily metrics to track:
- Concepts studied (encoding time)
- Diagrams drawn (observation)
- Systems designed (practice)
- Feedback received (reviews)

I'll remind you to track daily. Set time?"

$ 7:00 AM daily

Franklin: "Committed. I'll check your progress weekly."

# Three days later - struggling with concept
$ /justin-sung "I keep forgetting CAP theorem. Help."

Justin Sung: "You're reviewing without encoding deeply.

CAP theorem isn't 3 facts to memorize. It's relationships:
- WHY can't you have all three?
- WHEN do you sacrifice which?
- HOW does this show up in real systems?

Instead of flashcards, try:
1. Draw diagram showing the trade-offs
2. Explain to yourself why trade-offs exist (physics/network)
3. Map to systems you know (DynamoDB, Cassandra)
4. Design system requiring CAP decisions

This encodes deeply. Then review in 1, 3, 7 days."

$ /tesla "Help me visualize CAP theorem trade-offs"

Tesla: "Close your eyes. See the distributed system.

Three nodes. Data needs to replicate. Network partition happens.
Now watch: You must choose...

[Detailed visualization guide provided]

Practice this mental simulation 3x.
Then you'll understand, not just know."
```

---

## Creating Custom Agent Combinations

### The "Learning Sprint Starter" Combo
```bash
/scott-young "Metalearning for [skill]"
/franklin "Tracking system"
/ericsson "Deliberate practice plan"
/justin-sung "Encoding strategy"

# Save as custom workflow
```

### The "Stuck on Concept" Combo
```bash
/feynman "Simplify [concept]"
/tesla "Visualize [concept]"
/justin-sung "Encode [concept] properly"
```

### The "Organizing Knowledge" Combo
```bash
/aristotle "Classify [knowledge]"
/leonardo "Find connections"
/von-neumann "Formalize patterns"
```

---

## Agent Development Principles

Each agent embodies:
1. **Their philosophy** (how they thought)
2. **Their methods** (what they did)
3. **Their tools** (how they worked)
4. **Their voice** (how they communicated)

**Not mimicry - channeling their approach to modern problems.**

---

## Next Steps

1. **Try an agent**: Pick one relevant to current challenge
2. **Apply the skill**: Follow the procedural workflow
3. **Track results**: Did it help? Log in progress journal
4. **Iterate**: Combine agents, create patterns

---

## Integration Points

### With Learning Directory
- Agents read: `Active/`, `PROGRESS.md`, `Knowledge/`
- Agents write: Progress journals, mental models, tracking systems
- Agents analyze: Patterns, effectiveness, challenges

### With Hermetic System
- Invoked via: `/[agent-name]` commands
- Use tools: Read, Write, Grep, Glob, Task, etc.
- Track usage: `hm agent [agent-name] "context"`

### With n8n Automation
- Workflows can invoke agents based on context
- "User stuck 3 days" → Invoke `/feynman`
- "Starting new skill" → Invoke `/scott-young`
- "Low effectiveness" → Invoke `/ericsson`

---

*"The masters are no longer just inspiration. They're your team."*

🎓 **Invoke wisdom. Apply methods. Build mastery.**
