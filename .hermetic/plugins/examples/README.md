# Example Plugins

**Reference implementations demonstrating the Hermetic plugin system**

---

## 📦 Available Examples

### 1. Code Reviewer (`code-reviewer/`)

**Type**: Agent Plugin
**Category**: Engineering
**Principles**: Mentalism, Cause-Effect, Correspondence
**Purpose**: Intelligent code review with Hermetic awareness

**Features**:
- Mental model analysis
- Consequence tracing
- Architectural alignment
- Hermetic principle checking
- Customizable per-project

**Install**:
```bash
hm plugin activate code-reviewer
```

**Use**:
```
In Claude Code:
"code-reviewer, review this authentication function"
```

---

### 2. Daily Standup Generator (`daily-standup/`)

**Type**: Agent Plugin (Analyzer)
**Category**: Productivity
**Principles**: Mentalism, Rhythm, Correspondence
**Purpose**: Generate meaningful daily standup reports from usage data

**Features**:
- Analyzes yesterday's actual work from analytics
- Identifies blockers and dependencies
- Provides team context
- Formats for async or sync standups
- Tracks progress against sprint goals

**Install**:
```bash
hm plugin activate daily-standup
```

**Use**:
```
In Claude Code:
"daily-standup, generate my standup for today"
"daily-standup, I'm blocked on API review"
```

---

### 3. Pomodoro Integrator (`pomodoro-integrator/`)

**Type**: Integration Plugin
**Category**: Productivity
**Principles**: Rhythm, Vibration, Polarity
**Purpose**: Integrate Pomodoro Technique with Hermetic rhythm principles

**Features**:
- Conscious 25/5 focus/rest cycles
- Effectiveness tracking
- Energy-based timing adjustments
- Flow state respect
- Guided reflection breaks
- Pattern analysis

**Install**:
```bash
hm plugin activate pomodoro-integrator
chmod +x ~/.hermetic/plugins/examples/pomodoro-integrator/pomodoro.sh
```

**Use**:
```bash
hm pomodoro start "implement feature"
hm pomodoro complete 5
hm pomodoro summary
```

---

## 🎓 Learning from Examples

Each example plugin demonstrates:

1. **Proper Structure**
   - `plugin.json` with all metadata
   - Well-documented markdown files
   - Clear hermetic principle grounding

2. **Best Practices**
   - Principle-first design
   - Clear documentation
   - Example usage
   - Integration guides

3. **Real Value**
   - Solves actual problems
   - Measurable effectiveness
   - Community-shareable

---

## 🛠️ Using Examples as Templates

### Copy and Customize

```bash
# Copy example as starting point
cp -r ~/.hermetic/plugins/examples/code-reviewer ~/.hermetic/plugins/my-plugin

# Customize
cd ~/.hermetic/plugins/my-plugin
nano plugin.json
nano *.md

# Validate
hm plugin validate my-plugin

# Activate
hm plugin activate my-plugin
```

---

## 🌟 Contributing Examples

Have a great plugin? Add it to the examples!

1. Create high-quality plugin
2. Document thoroughly
3. Test extensively
4. Submit as example

**Guidelines**:
- Must embody at least one Hermetic principle
- Must provide clear value
- Must be well-documented
- Must include usage examples
- Should track effectiveness

---

## 📚 More Examples Coming

Planned example plugins:

### Daily Standup Generator
**Type**: Analyzer
**Purpose**: Generate daily standup from yesterday's usage

### Project Kickstarter
**Type**: Workflow
**Purpose**: Initialize new project with Hermetic structure

### Code Kata Generator
**Type**: Skill
**Purpose**: Generate practice exercises based on weak areas

### Pomodoro Integrator
**Type**: Integration
**Purpose**: Integrate Pomodoro technique with Hermetic rhythm

### Team Retrospective Facilitator
**Type**: Command
**Purpose**: Guide team retrospectives using Hermetic principles

---

## 🎯 Example Plugin Checklist

When creating example plugins:

- [ ] Embodies Hermetic principles
- [ ] Solves real problem
- [ ] Well-documented
- [ ] Clear usage examples
- [ ] Integration guides
- [ ] Effectiveness tracking
- [ ] Community-ready

---

**Examples Version**: 1.0.0
**Last Updated**: 2025-10-29

*"Learn from examples. Build your own. Share with community."*
