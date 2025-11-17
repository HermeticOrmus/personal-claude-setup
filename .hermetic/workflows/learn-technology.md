# Learn New Technology Workflow

**Purpose**: Master new programming languages, frameworks, or tools rapidly and deeply using Hermetic principles

**Hermetic Principles**: Mentalism, Correspondence, Vibration, Rhythm

**Estimated Time**: 1-4 weeks (varies by technology complexity)

**Prerequisites**:
- Clear reason for learning (genuine need, not resume padding)
- Time allocated for learning
- Access to documentation and resources

---

## Philosophy

Learning technology is about **building mental models** (Mentalism), not memorizing syntax. This workflow uses:

1. **Mentalism**: Understand concepts deeply, not just copy-paste code
2. **Correspondence**: Connect new knowledge to existing knowledge
3. **Vibration**: Ship small projects quickly to learn by doing
4. **Rhythm**: Sustainable learning pace prevents overwhelm

**Key Insight**: You don't need to learn "everything" - you need to learn enough to be productive, then learn more as needed.

---

## Phase 1: Foundation & Mental Model (Day 1-2)

### Step 1: Clarify Your "Why" (Mentalism)

**Before diving in**, understand why you're learning this.

**Command**: `/gnosis "why am I learning [technology]?"`

**Example**:
```
/gnosis "Why am I learning Rust? Is it genuine need for my project
or am I just chasing trends? What problems will it solve that my
current tools don't?"
```

**Log usage**:
```bash
hm cmd gnosis "learning: rust"
```

**Good reasons**:
- Solving specific problem current tools can't handle
- Career requirement for job/project
- Genuine curiosity aligned with goals
- Fills knowledge gap affecting your work

**Bad reasons**:
- "Everyone's using it"
- Resume padding without application
- FOMO (fear of missing out)
- Avoiding actual work

**Deliverable**: Clear, honest reason for learning

---

### Step 2: Build the Mental Model (Mentalism)

**Don't start with syntax**. Start with concepts.

**Questions to answer**:
1. **What problem does this technology solve?**
   - What was the world like before it existed?
   - What pain points does it address?

2. **What are the core concepts?**
   - 3-5 fundamental ideas that make it work
   - What's the mental model?

3. **How does it differ from what I know?**
   - What's similar (Correspondence)?
   - What's different (new mental model needed)?

4. **What's the "philosophy"?**
   - What does the community value?
   - What trade-offs does it make?

**Resources**:
- Official documentation (philosophy/overview sections)
- "Why [Technology]" blog posts
- Conference talks by creators
- NOT tutorials yet (they come later)

**Agent**: `ai-engineer` or relevant domain expert

```
"ai-engineer, explain the core mental model of Rust and how it
differs from languages like JavaScript and Python. Focus on
concepts, not syntax."
```

**Log usage**:
```bash
hm agent ai-engineer "learning: rust mental model"
```

**Deliverable**: One-page mental model document

**Template**:
```markdown
# [Technology] Mental Model

## Core Problem It Solves
[What pain point does this address?]

## Key Concepts (3-5)
1. [Concept 1 and why it matters]
2. [Concept 2 and why it matters]
3. [Concept 3 and why it matters]

## Compared to What I Know
Similar to [known tech]: [similarities]
Different from [known tech]: [key differences]

## Philosophy
[What does the community value? What trade-offs?]

## When to Use
Good for: [use cases]
Not good for: [anti-use cases]
```

---

### Step 3: Map to Existing Knowledge (Correspondence)

**Principle of Correspondence**: New knowledge connects to existing knowledge.

**Exercise**: Create a mapping table

```markdown
| I already know... | In [new tech] it's called... | Key difference... |
|-------------------|------------------------------|-------------------|
| Functions         | [equivalent concept]         | [what's different]|
| Objects/Classes   | [equivalent concept]         | [what's different]|
| Error handling    | [equivalent concept]         | [what's different]|
| ...               | ...                          | ...               |
```

**Why this works**: Brain learns by connecting new to known, not blank slate memorization.

---

## Phase 2: Hands-On Exploration (Day 3-5)

### Step 4: Set Up Environment (Vibration)

**Get something running quickly** - don't get stuck on setup.

**Goal**: "Hello World" in under 30 minutes

**If stuck on setup longer than 30 min**:
```bash
hm unstuck
```

Consider:
- Using online playground (repl.it, CodeSandbox, etc.)
- Pre-configured Docker container
- Asking for help (don't waste hours on setup)

**Agent**: `devops-automator` or `rapid-prototyper`

```
"devops-automator, help me set up a minimal Rust development
environment on [your OS] with the fastest path to running code"
```

**Log usage**:
```bash
hm agent devops-automator "learning: rust setup"
```

---

### Step 5: Learn By Doing - Progressive Difficulty (Vibration + Rhythm)

**Don't watch tutorials passively**. Build small projects.

**Progression** (2-3 days, 2-3 hours per day):

#### Level 1: Hello World (30 min)
- Basic syntax
- Print to console
- Variables and data types
- **Project**: CLI that prints formatted output

#### Level 2: Data Manipulation (1-2 hours)
- Data structures (arrays, objects, etc.)
- Loops and conditionals
- Functions
- **Project**: Parse CSV, transform data, output result

#### Level 3: Real Problem (2-3 hours)
- Error handling
- File I/O or network requests
- Modules/packages
- **Project**: Solve actual problem you have

#### Level 4: Mini Real-World App (4-6 hours)
- Combine all concepts
- Use external libraries
- Tests
- **Project**: Simplified version of real need

**Skill**: `learn-any-skill-fast`

Invoke this skill at the start:
```
"apply learn-any-skill-fast skill to learning Rust"
```

**Log usage**:
```bash
hm skill learn-any-skill-fast "learning: rust"
```

**Key principle**: Each project slightly harder than the last, building on previous.

---

### Step 6: Deliberate Practice (Mentalism + Rhythm)

**Not random coding - intentional practice**.

**Daily practice routine** (25-50 min):

**Option A: Coding Challenges**
- Pick platform (LeetCode, Exercism, etc.)
- Do 2-3 problems in new language
- Focus on understanding, not speed
- **Review** after: "What did I learn?"

**Option B: Feature Addition**
- Pick your learning project
- Add one small feature
- Refactor for clarity
- **Review**: "How would a pro do this?"

**Agent**: Domain-specific agent for the technology

**Example for Rust**:
```
"linux-expert, review my Rust code for this file parser.
What would make it more idiomatic Rust?"
```

**Rhythm**:
- 25 min focus
- 5 min reflection: "What did I just learn?"
- Repeat 2x per session
- Track in learning journal

---

## Phase 3: Deep Dive & Best Practices (Week 2)

### Step 7: Study Excellent Code (Mentalism + Correspondence)

**Read code written by experts**.

**Process**:
1. **Find**: Popular open-source projects in the technology
2. **Read**: Pick one file, read it completely
3. **Understand**: What patterns do you see?
4. **Compare**: How does this compare to your code?
5. **Extract**: What techniques can you adopt?

**Agent**: `code-reviewer`

```
"code-reviewer, help me understand this code from [project].
What patterns and techniques should I learn from this?"
```

**Log usage**:
```bash
hm agent code-reviewer "learning: rust code review"
```

**Deliverable**: List of patterns/techniques to adopt

---

### Step 8: Build Something Real (Vibration)

**Apply knowledge to genuine need**.

**Project criteria**:
- Solves real problem you have
- Uses new technology appropriately
- Can be completed in 6-day sprint
- Ships to "production" (even if just you using it)

**Follow**: `feature-implementation.md` workflow

**Why this matters**:
- Real constraints teach better than tutorials
- You'll hit edge cases tutorials skip
- Shipping something cements learning
- Builds portfolio

**Agent**: `rapid-prototyper`

```
"rapid-prototyper, help me build a [description] using Rust.
I'm learning the language, so guide me on idiomatic approaches."
```

**Log usage**:
```bash
hm agent rapid-prototyper "learning: rust project"
```

---

### Step 9: Learn Debugging & Troubleshooting (Cause-Effect)

**Deliberately break things to learn**.

**Exercise**:
1. Take working code
2. Introduce bug intentionally
3. Use debugger to find it
4. Learn debugging tools for this tech

**Common bug types to practice**:
- Syntax errors
- Runtime errors
- Logic errors
- Performance issues
- Memory issues (if applicable)

**Skill**: `debug-like-master`

```
"apply debug-like-master skill to debugging Rust programs"
```

**Why**: You learn more from fixing bugs than writing perfect code.

---

## Phase 4: Integration & Mastery (Week 3-4)

### Step 10: Learn the Ecosystem (Correspondence)

**Technology is more than just the language**.

**Explore**:
- **Package manager**: How to find and use libraries
- **Build tools**: How to compile/bundle/deploy
- **Testing**: How to write and run tests
- **Community**: Where to get help, best practices
- **Tooling**: IDE support, linters, formatters

**Agent**: Relevant domain agent

```
"[domain-agent], what are the essential tools and libraries
in the Rust ecosystem that I should know?"
```

---

### Step 11: Best Practices & Patterns (Mentalism)

**Learn the "right way"** (not just "a way").

**Study**:
- Official style guides
- Common design patterns in this tech
- Anti-patterns to avoid
- Performance best practices
- Security considerations

**Resources**:
- Official documentation (best practices section)
- Well-regarded books
- Style guides from major companies using it

**Agent**: `code-reviewer`

```
"code-reviewer, review my Rust project for idiomatic code,
best practices, and common anti-patterns I should avoid"
```

**Deliverable**: Best practices checklist for this technology

---

### Step 12: Teach What You Learned (Mentalism + Correspondence)

**Teaching is the ultimate test of understanding**.

**Options**:

**A: Write Tutorial**
- Blog post explaining core concepts
- Focus on mental model, not just syntax
- Teach what confused you initially

**B: Give Talk/Demo**
- Present to team or local meetup
- Live coding demonstration
- Q&A forces deep understanding

**C: Mentor Someone**
- Help a colleague learn the same tech
- Teaching reveals gaps in your knowledge

**D: Create Learning Resource**
- Cheat sheet
- "Things I wish I knew when starting"
- Common pitfalls and solutions

**Agent**: `content-creator` or `visual-storyteller`

```
"content-creator, help me outline a blog post teaching Rust
to developers who already know JavaScript"
```

**Log usage**:
```bash
hm agent content-creator "learning: rust teaching"
```

**Why teaching works**:
- Forces clarity (can't teach what you don't understand)
- Reveals gaps in knowledge
- Cements learning through explanation
- Helps others (Gold Hat principle)

---

## Success Metrics

### After Week 1
- [ ] Can explain core concepts to someone else
- [ ] Built 3-5 small working programs
- [ ] Comfortable with basic syntax
- [ ] Know where to find answers (docs, community)
- [ ] Mental model document complete

### After Week 2
- [ ] Built one real (small) project start-to-finish
- [ ] Can read and understand others' code
- [ ] Know common patterns and idioms
- [ ] Comfortable with debugging tools
- [ ] Learning journal shows daily progress

### After Week 3-4
- [ ] Shipped something to "production"
- [ ] Understand ecosystem (packages, tools, community)
- [ ] Know best practices and anti-patterns
- [ ] Can teach basics to someone else
- [ ] Comfortable using it for real work

### Mastery Indicators (3-6 months)
- [ ] Contribute to open source projects
- [ ] Mentor others learning the tech
- [ ] Make architectural decisions confidently
- [ ] Recognize subtle bugs and performance issues
- [ ] Stay current with ecosystem evolution

---

## Common Pitfalls

### ❌ Tutorial Hell
**Symptom**: Watching hours of tutorials but never building
**Consequence**: Passive learning doesn't stick
**Fix**: Build immediately after learning concept (Vibration)

### ❌ Trying to Learn Everything
**Symptom**: Overwhelmed by all the features/libraries
**Consequence**: Analysis paralysis, never start
**Fix**: Learn "just enough" then build, learn more as needed

### ❌ No Real Project
**Symptom**: Only doing toy exercises
**Consequence**: Shallow learning, unclear how to apply
**Fix**: Build something you'll actually use (Vibration)

### ❌ Ignoring Fundamentals
**Symptom**: Jumping to advanced features too quickly
**Consequence**: Shaky foundation, confusion later
**Fix**: Master basics first (Mentalism)

### ❌ Learning Alone
**Symptom**: No interaction with community
**Consequence**: Learn bad practices, miss better approaches
**Fix**: Join communities, get code reviewed

### ❌ Not Taking Breaks
**Symptom**: Trying to learn 8 hours straight
**Consequence**: Burnout, poor retention
**Fix**: Follow daily rhythm - 25/5 Pomodoro, regular breaks

---

## Adaptation by Technology Type

### Programming Language (Python, Rust, Go)
- **Focus**: Syntax, idioms, standard library
- **Time**: 2-4 weeks
- **Projects**: 5-7 progressively complex programs

### Framework (React, Django, Rails)
- **Focus**: Architecture patterns, ecosystem
- **Time**: 3-6 weeks
- **Projects**: 2-3 full apps

### Tool/Platform (Docker, Kubernetes, AWS)
- **Focus**: Use cases, best practices, integration
- **Time**: 4-8 weeks
- **Projects**: Deploy real service

### Concept (Machine Learning, Blockchain)
- **Focus**: Fundamentals, math/theory, applications
- **Time**: 8-12 weeks
- **Projects**: Implement algorithms from scratch, then use libraries

---

## Learning Journal Template

**Keep daily notes**:

```markdown
# Learning [Technology] - Day [N]

## Today's Goal
[What you planned to learn/build]

## What I Learned
- [Concept 1]
- [Concept 2]
- [Surprising insight]

## What I Built
[Brief description of code written]

## Challenges
[What was hard? How did I overcome it?]

## Questions Remaining
[What do I still not understand?]

## Tomorrow's Plan
[What's next?]

## Effectiveness Rating
[1-5 stars for today's learning]
```

**Review weekly**:
```bash
# Track learning effectiveness
hm skill learn-any-skill-fast "learning: rust"
hm rate skill learn-any-skill-fast 5
```

---

## Integration with Daily Workflow

**Nested within daily-development workflow**:

**Morning block** (90 min):
- Review yesterday's notes (5 min)
- Set today's learning goal (5 min)
- Focused learning/practice (80 min)

**Afternoon block** (90 min):
- Build small project applying concepts
- Get code reviewed (by agent or human)
- Document learnings

**Evening** (15 min):
- Update learning journal
- Plan tomorrow
- Rate effectiveness

---

## When You Feel Stuck

```bash
hm unstuck
```

**Specific strategies**:

1. **Can't understand concept**:
   ```
   /gnosis "[specific concept] in [technology] - explain with analogy to [what I know]"
   ```

2. **Code not working**:
   - Apply `debug-like-master` skill
   - Binary search the problem
   - Ask in community (show what you tried)

3. **Overwhelmed**:
   - Take a walk (seriously)
   - Reduce scope (learn less, but learn it well)
   - Review mental model (are you lost?)

4. **Losing motivation**:
   - Revisit your "why" from Step 1
   - Build something fun
   - Celebrate small wins

---

## Resource Recommendations

### Always Good
- Official documentation (start here)
- GitHub trending projects (see real usage)
- Stack Overflow (common problems)

### Language-Specific Quality Resources
Will vary, but look for:
- Books by language creators or experts
- Video courses with high completion rates
- Interactive platforms (Exercism, freeCodeCamp)

### Community
- Reddit: r/[technology]
- Discord/Slack: [technology] community servers
- Local meetups (in-person learning is powerful)

---

## Effectiveness Tracking

**After completing this workflow**:

```bash
hm rate workflow learn-technology 5
hm rate skill learn-any-skill-fast 5
hm rate agent [agents-used] 5
```

**Track over time**:
- Time to productivity (can build real things)
- Retention (still remember after 3 months?)
- Quality (code reviewed well by experts?)

**System learns** your learning patterns and optimizes suggestions.

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Mentalism, Correspondence, Vibration, Rhythm
**Effectiveness**: Track with `hm rate workflow learn-technology <1-5>`

*"Understanding over memorization. Building over watching. Shipping over perfection."*
