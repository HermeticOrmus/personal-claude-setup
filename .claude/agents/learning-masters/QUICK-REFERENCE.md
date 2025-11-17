# Learning Master System - Quick Reference

**One-page overview of the complete system**

---

## 🎯 The Four Components

### 1. Agents (Interactive Guides)
**Location**: `.claude/agents/learning-masters/`

| Agent | Use When | Time |
|-------|----------|------|
| `/leonardo` | Starting new domain, need to see patterns | 15-30 min |
| `/tesla` | Designing system, debugging complex problem | 30-60 min |
| `/franklin` | Need accountability, tracking, discipline | 5 min daily |
| `/feynman` | Concept confusing, preparing to teach | 30-60 min |
| `/von-neumann` | Reading technical material, seeking patterns | Continuous |
| `/aristotle` | Organizing knowledge, building taxonomy | 1-2 hours |
| `/justin-sung` | Need to remember long-term | 80% of study time |
| `/barbara-oakley` | Procrastinating, stuck, need breakthrough | 25 min cycles |
| `/scott-young` | Starting new skill, need learning plan | 10% upfront |
| `/anders-ericsson` | Plateaued, want measurable improvement | 1-3 hour sessions |

---

### 2. Skills (Step-by-Step Checklists)
**Location**: `.claude/skills/learning-methods/`

| Skill | Output | Time |
|-------|--------|------|
| `apply-feynman-technique` | Simple explanation | 30-60 min |
| `apply-encoding-method` | Relationship map | 80% of study time |
| `apply-metalearning` | Learning plan | 10% of total time |
| `apply-deliberate-practice` | Targeted improvement | 1-3 hours |
| `apply-focused-diffuse` | Breakthrough insights | 25 min + 5 min cycles |
| `apply-observation-method` | Deep understanding | 15-30 min daily |
| `apply-visualization` | Mental model | 30-60 min |
| `apply-tracking-discipline` | Systematic progress | 5 min daily |
| `apply-pattern-recognition` | Pattern library | Continuous |
| `apply-classification` | Complete taxonomy | 1-2 hours |

---

### 3. Visual Learning
**Location**: `Learning/Active/.template/visuals/`

| Visual Type | Method | Saves To |
|-------------|--------|----------|
| Mindmap | Manual (Mermaid) | `visuals/mindmaps/` |
| Relationship map | `/apply-encoding-method` | `visuals/relationships/` |
| Taxonomy | `/apply-classification` | `visuals/taxonomies/` |
| Pattern catalog | `/apply-pattern-recognition` | `visuals/patterns/` |
| Observation sketch | `/apply-observation-method` | `visuals/observations/` |
| System diagram | `/apply-visualization` | `visuals/diagrams/` |

---

### 4. Automation (n8n + Telegram + Discord)
**Location**: `Learning/Active/DUAL-PLATFORM-ARCHITECTURE.md`

**Telegram** (Daily/Quick):
- Morning check-in (8 AM)
- Quick logging (`/log`)
- Streak tracking
- Simple reminders

**Discord** (Weekly/Visual):
- Visual rendering (auto)
- Weekly reviews (Sunday)
- Forum discussions
- Voice study sessions

---

## 🔄 Common Workflows

### Learning New Skill (12 weeks)
```bash
Week 0: /scott-young + /apply-metalearning
Week 1-2: /apply-observation-method + /apply-encoding-method
Week 3-8: /apply-deliberate-practice + /apply-focused-diffuse
Week 9-12: Build mastery project + /apply-classification
```

### Understanding Concept (1-2 days)
```bash
Day 1 AM: /leonardo + /apply-observation-method
Day 1 PM: /justin-sung + /apply-encoding-method
Day 1 Eve: /feynman + /apply-feynman-technique
Day 2: Sleep → Walk → Test → Teach
```

### Overcoming Block (1-2 hours)
```bash
Step 1: /barbara-oakley (diagnose)
Step 2: /apply-focused-diffuse (one Pomodoro + walk)
Step 3: Breakthrough!
```

---

## 🎯 Decision Trees

### "I'm starting to learn something new"
→ `/scott-young` + `/apply-metalearning` → `/apply-tracking-discipline`

### "I don't understand this concept"
→ `/feynman` + `/apply-feynman-technique` → `/apply-encoding-method`

### "I need to remember this long-term"
→ `/justin-sung` + `/apply-encoding-method` (relationships, not flashcards)

### "I'm plateauing, not improving"
→ `/anders-ericsson` + `/apply-deliberate-practice` → `/apply-tracking-discipline`

### "I'm procrastinating and stuck"
→ `/barbara-oakley` + `/apply-focused-diffuse` (one Pomodoro, then walk)

### "I need to organize scattered knowledge"
→ `/aristotle` + `/apply-classification` (build taxonomy)

### "I want deeper understanding"
→ `/leonardo` + `/apply-observation-method` → `/apply-visualization`

### "I want to see patterns"
→ `/von-neumann` + `/apply-pattern-recognition` (pattern library)

### "I need accountability"
→ `/franklin` + `/apply-tracking-discipline` (daily + weekly)

### "I need to solve complex problem"
→ `/tesla` + `/apply-visualization` (mental simulation)

---

## 📁 File Structure

```
Learning/Active/[skill-name]/
├── progress-journal.md          (EVERYTHING writes here)
├── metalearning-map.md
├── practice-plan.md
├── franklin-tracking.md
├── weekly-reviews.md
├── feynman-explanations.md
├── pomodoro-log.md
├── practice-log.md
├── encoding-concepts.md
├── connections-map.md
├── mental-model.md
├── domain-wiki.md
└── visuals/
    ├── observations/
    ├── diagrams/
    ├── relationships/
    ├── patterns/
    ├── taxonomies/
    └── mindmaps/
```

---

## ⚡ Quick Commands

### Telegram Bot
```
/start - Setup wizard
/log - Quick daily logging
/insight [text] - Capture insight
/streak - Check current streak
/today - Today's goals
/stats - Quick stats
```

### n8n Workflows
- Morning check-in: 8:00 AM daily
- Visual rendering: On file save
- Weekly review: Sunday 8:00 PM
- Streak tracker: After daily log
- Insight capture: On `/insight` command

---

## 📊 Success Metrics

**Week 1 → Week 12**:
- Deep work: 2 hours → 4 hours
- Understanding: Can't explain → Teaching others
- Practice success: 40% → 85%
- Visual library: 0 → 50+ artifacts
- Pattern recognition: Slow → Instant

---

## 🎨 Rendering Options

**VS Code** (Recommended):
1. Install "Markdown Preview Mermaid Support"
2. Open `.md` file
3. `Ctrl+K V` (preview)

**Obsidian**:
1. Open `Learning/` as vault
2. Mermaid renders automatically
3. Graph view shows connections

**Auto-rendering**:
- n8n watches file changes
- Renders Mermaid to PNG
- Posts to Discord

**See**: `visuals/AUTO-RENDERING.md`

---

## 🚀 Getting Started (First Week)

### Day 1: Setup (1 hour)
```bash
1. Choose ONE skill to learn
2. Copy .template/ to Learning/Active/[skill]/
3. /scott-young "Create metalearning plan"
4. /apply-metalearning
```

### Day 2-3: Foundation (2 hours)
```bash
1. /franklin "Set up tracking"
2. /apply-tracking-discipline
3. Install VS Code Mermaid extension
4. Create first mindmap
5. /apply-encoding-method (first relationship map)
```

### Day 4-7: First Sprint (4 hours)
```bash
Daily:
1. /apply-focused-diffuse (2 Pomodoros)
2. /apply-encoding-method (add relationships)
3. /apply-tracking-discipline (evening log)

Sunday:
1. Weekly review
2. /franklin "Review my data"
```

---

## 🔧 Troubleshooting

**"I'm overwhelmed"**
→ Start with ONE skill: `/apply-encoding-method` (highest ROI)

**"Tracking feels like burden"**
→ Reduce to 3 metrics, automate with n8n

**"Not seeing improvement"**
→ Check: Are you doing deliberate practice? Encoding or just reviewing?

**"Visuals not rendering"**
→ VS Code extension installed? Try Obsidian.

**"I forget to use system"**
→ n8n daily reminders (8 AM Telegram check-in)

---

## 📚 Full Documentation

**Core Guides**:
- `INTEGRATION-GUIDE.md` - Complete system integration
- `DUAL-PLATFORM-ARCHITECTURE.md` - Telegram + Discord setup
- `.claude/agents/learning-masters/README.md` - All agents
- `.claude/skills/learning-methods/README.md` - All skills
- `visuals/README.md` - Visual learning complete guide

**Automation**:
- `LEARNING-AUTOMATION.md` - n8n workflows
- `n8n-workflows/starter-pack/` - 3 essential workflows
- `n8n-workflows/advanced-pack/` - 5 advanced workflows

---

## 💡 Core Principles

**From the masters**:
- "Explain simply" - Feynman
- "Observe obsessively" - Leonardo
- "Recognize patterns" - von Neumann
- "Track everything" - Franklin
- "Visualize completely" - Tesla
- "Classify systematically" - Aristotle
- "Encode, don't review" - Justin Sung
- "Two modes: focused + diffuse" - Barbara Oakley
- "Metalearning first" - Scott Young
- "Edge of ability" - Anders Ericsson

---

## 🎯 The Learning Loop

```
Observe → Encode → Practice → Track → Review → Adjust → Repeat

Monday: Observe (Leonardo)
Tuesday: Encode (Justin Sung)
Wednesday: Practice (Ericsson)
Thursday: Pomodoro (Oakley)
Friday: Simplify (Feynman)
Sunday: Review (Franklin)
```

---

## ⏱️ Time Investments

**Setup**:
- Basic (Telegram only): 1 hour
- Visual learning (+ Discord): 2 hours
- Full system: 5 hours over 3 weeks

**Daily**:
- Minimal: 5 min (tracking only)
- Standard: 1-2 hours (practice + tracking)
- Deep: 4+ hours (deliberate practice)

**Weekly**:
- Review: 20-30 min (Sunday)
- Planning: 15 min (next week focus)

**Return**: Lifetime learning system

---

## 🎉 You Have Everything

✅ 10 interactive agents (master learner wisdom)
✅ 10 procedural skills (step-by-step checklists)
✅ Complete visual learning system
✅ Dual-platform automation (Telegram + Discord)
✅ 30+ guides and templates
✅ n8n workflow library
✅ Integration documentation

**The only thing left is to begin.**

**Start simple. One skill. One Pomodoro. One day at a time.**

**Welcome to your learning OS. 🚀**
