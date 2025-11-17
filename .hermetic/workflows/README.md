# Hermetic Workflow Templates

**Pre-built workflows combining agents, commands, and skills for common scenarios**

---

## 🎯 What Are Workflows?

Workflows are **proven sequences** of agents, commands, and skills that accomplish specific goals while embodying Hermetic principles. Think of them as recipes for success.

Instead of figuring out which agents to invoke when starting a new project, you can follow the **New Project Setup** workflow. Instead of wondering how to approach a bug, you can use the **Bug Fixing Workflow**.

---

## 📚 Available Workflows

### Development Workflows

1. **new-project-setup.md** - Initialize new project with Hermetic structure
2. **daily-development.md** - Sustainable daily development rhythm
3. **feature-implementation.md** - Ship new features with quality
4. **code-review.md** - Thorough, principle-guided code review
5. **bug-fixing.md** - Systematic debugging with consciousness
6. **refactoring.md** - Clean up technical debt safely

### Learning & Growth

7. **learn-technology.md** - Master new tools/languages rapidly
8. **skill-improvement.md** - Level up in specific areas
9. **knowledge-share.md** - Document and teach what you've learned

### Planning & Strategy

10. **sprint-planning.md** - Plan 6-day development cycles
11. **architecture-design.md** - Design systems with Hermetic principles
12. **technical-decision.md** - Make complex technical choices

### Maintenance & Operations

13. **system-health-check.md** - Regular system maintenance
14. **troubleshooting.md** - Diagnose and fix issues
15. **backup-strategy.md** - Protect your work and data

---

## 🚀 How to Use Workflows

### 1. Read the Workflow

Each workflow includes:
- **Purpose**: What this workflow accomplishes
- **Hermetic Principles**: Which principles it embodies
- **Prerequisites**: What you need before starting
- **Steps**: Detailed process with agent/command/skill invocations
- **Success Metrics**: How to know it worked
- **Common Pitfalls**: What to avoid

### 2. Follow Step-by-Step

Don't skip steps. Each step builds on the previous. The sequence matters.

### 3. Log Usage

Track your workflow usage:
```bash
hm agent <agent-name> "workflow: feature-implementation"
hm cmd <command-name> "workflow: feature-implementation"
```

This helps the system learn which workflows work best for you.

### 4. Rate Effectiveness

After completing a workflow:
```bash
# Rate the overall workflow
hm rate workflow feature-implementation 5
```

---

## 🎨 Creating Custom Workflows

### Structure

```markdown
# Workflow Name

**Purpose**: One-line description
**Hermetic Principles**: Mentalism, Rhythm, etc.
**Estimated Time**: 30 minutes, 2 hours, etc.
**Prerequisites**: What's needed first

## Steps

### Step 1: [Action Name] (Principle)
**Agent**: agent-name
**Command**: /command-name
**Why**: Explanation of purpose

[Detailed instructions...]

### Step 2: [Action Name] (Principle)
...

## Success Metrics
- [ ] Checklist item 1
- [ ] Checklist item 2

## Common Pitfalls
- **Pitfall**: How to avoid it
```

### Best Practices

1. **Principle-First**: Ground each step in Hermetic principles
2. **Teach While Doing**: Explain WHY, not just WHAT
3. **Include Examples**: Show real usage
4. **Track Effectiveness**: Measure results
5. **Iterate**: Improve based on experience

---

## 🔄 Workflow Patterns

### The Foundation Pattern
**Start with clarity** (Mentalism + Correspondence)

1. `/gnosis` - Understand the problem deeply
2. `/align` - Verify ethical alignment
3. Design before implementing

**Used in**: Architecture Design, Technical Decisions

---

### The Rhythm Pattern
**Sustainable pacing** (Rhythm + Vibration)

1. 25-minute focused work
2. 5-minute reflection
3. Repeat 4 times, then longer break

**Used in**: Daily Development, Feature Implementation

---

### The Verification Pattern
**Prove correctness** (Cause-Effect + Mentalism)

1. Write tests first
2. Implement feature
3. `/verify` - Validate thoroughly
4. Document learnings

**Used in**: Feature Implementation, Bug Fixing

---

### The Teaching Pattern
**Share knowledge** (Correspondence + Mentalism)

1. Learn deeply
2. Document clearly
3. Share with community
4. Teach someone else

**Used in**: Learn Technology, Knowledge Share

---

## 📊 Workflow Effectiveness

### Tracking

The system automatically tracks:
- How often you use each workflow
- Time spent in each workflow
- Completion rate
- Effectiveness ratings
- Which steps you skip (anti-pattern detection)

### Analysis

Run pattern recognition to discover:
```bash
python3 ~/.hermetic/intelligence/pattern-recognition.py

# Check for workflow insights
cat ~/.hermetic/intelligence/insights.md | grep -A5 "Workflow"
```

### Optimization

Based on your data:
- Customize workflows to your style
- Skip steps that don't add value for you
- Add steps where you commonly make mistakes
- Adjust timing based on your rhythm

---

## 🌟 Example: Daily Development Workflow

Quick preview of how workflows look in practice:

```
1. Morning Setup (5 min)
   - hm start-day
   - /gnosis "today's goal"
   - hm context

2. First Task Block (90 min)
   - rapid-prototyper agent for new features
   - test-writer-fixer agent for quality
   - 25-min work / 5-min reflect rhythm

3. Midday Integration (15 min)
   - hm check-in
   - /align (check if on track)
   - Adjust based on context

4. Second Task Block (90 min)
   - Continue implementation
   - /verify before committing
   - Clean git commits

5. Evening Closure (15 min)
   - hm close-day
   - /celebrate wins
   - Plan tomorrow
```

---

## 🎯 Workflow Selection Guide

**Starting new project?** → `new-project-setup.md`
**Daily work?** → `daily-development.md`
**Stuck on bug?** → `bug-fixing.md`
**Need to learn something?** → `learn-technology.md`
**Planning sprint?** → `sprint-planning.md`
**Making big decision?** → `technical-decision.md`
**Code smells bad?** → `refactoring.md`
**Reviewing code?** → `code-review.md`
**Building feature?** → `feature-implementation.md`
**System issues?** → `troubleshooting.md`

---

## 🔧 Workflow Manager (Coming Soon)

Future enhancement: Command-line workflow manager

```bash
hm workflow list              # See all workflows
hm workflow start <name>      # Begin workflow with guidance
hm workflow status            # Current workflow progress
hm workflow complete          # Mark workflow done, collect metrics
```

---

## 💡 Workflow Philosophy

Workflows embody the Hermetic principle of **Correspondence** - patterns that work at small scale (single task) also work at large scale (entire project).

**Mental Models** (Mentalism):
- Clear workflows → clear thinking
- Repeatable process → reliable results

**Natural Rhythm** (Rhythm):
- Workflows respect energy cycles
- Build in rest and reflection

**Cause & Effect**:
- Each step has clear purpose
- Consequences considered upfront

**Vibration**:
- Workflows create momentum
- Small wins compound

---

## 📖 Learning from Workflows

Workflows are not rigid rules - they're **learning tools**:

1. **Follow exactly** at first (learn the pattern)
2. **Understand WHY** each step exists
3. **Customize** based on your context
4. **Share improvements** with community

As you internalize the patterns, you'll naturally invoke the right agents and commands without needing the workflow document. That's mastery.

---

## 🌈 Community Workflows

Share your custom workflows:

```bash
# Export your workflow
cp ~/.hermetic/workflows/my-custom-workflow.md /tmp/
hm plugin export workflow my-custom-workflow

# Import someone's workflow
hm plugin import workflow /path/to/workflow.tar.gz
```

---

**Workflows Version**: 1.0.0
**Last Updated**: 2025-10-29

*"Proven patterns, conscious practice, measurable results."*
