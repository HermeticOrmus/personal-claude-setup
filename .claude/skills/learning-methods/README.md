# Learning Method Skills

**Purpose**: Procedural workflows applying the wisdom of master learners and learning scientists.

**Difference from Agents**: Agents are interactive guides that ask questions and provide personalized guidance. Skills are step-by-step checklists you follow independently.

---

## Available Skills

### Historical Master Methods

#### `apply-feynman-technique`
**When**: Concept seems complex, you're confused, or preparing to teach
**Output**: Simple explanation revealing knowledge gaps
**Time**: 30-60 minutes per concept
**Integration**: Creates `feynman-explanations.md` in Learning directory

#### `apply-observation-method`
**When**: Starting new domain, need deeper understanding, seeking connections
**Output**: Detailed observations, sketches, cross-domain insights
**Time**: Daily practice, 15-30 min
**Integration**: Writes to `visuals/observations/`, `connections-map.md`

#### `apply-visualization`
**When**: Debugging complex systems, designing architecture, solving problems
**Output**: Complete mental model, refined solution before building
**Time**: 30 min visualization + walking
**Integration**: Creates diagrams in `visuals/diagrams/`

#### `apply-tracking-discipline`
**When**: Need accountability, measuring progress, systematic improvement
**Output**: Daily tracking logs, weekly reviews, measurable progress
**Time**: 5 min daily + 20 min weekly review
**Integration**: Creates `franklin-tracking.md`, `weekly-reviews.md`

#### `apply-pattern-recognition`
**When**: Reading technical material, learning new frameworks, connecting domains
**Output**: Pattern catalog, abstractions, transfer knowledge
**Time**: During reading/learning
**Integration**: Writes to `visuals/patterns/`, `mental-model.md`

#### `apply-classification`
**When**: Organizing knowledge, building references, systematic documentation
**Output**: Taxonomies, wikis, classification trees, comparison tables
**Time**: 1-2 hours for domain
**Integration**: Creates `visuals/taxonomies/`, `domain-wiki.md`

---

### Learning Science Methods

#### `apply-encoding-method`
**When**: Learning anything complex, creating study materials, preparing for recall
**Output**: Rich relationship maps (not just facts)
**Time**: 80% of study time on encoding
**Integration**: Creates `visuals/relationships/`, relationship maps

#### `apply-focused-diffuse`
**When**: Deep work sessions, problem-solving, overcoming procrastination
**Output**: Productive work sessions with breakthroughs
**Time**: 25 min focus + 5 min break cycles
**Integration**: Logs in `pomodoro-log.md`, breakthrough insights

#### `apply-metalearning`
**When**: Starting completely new skill, planning learning approach
**Output**: Metalearning map, directness plan, drills identified
**Time**: 10% of total learning time (upfront)
**Integration**: Creates `metalearning-map.md`, `practice-plan.md`

#### `apply-deliberate-practice`
**When**: Improving specific skill, attacking weaknesses, measurable improvement
**Output**: Focused practice sessions targeting weaknesses
**Time**: 1-3 hour sessions with breaks
**Integration**: Logs in `practice-log.md`, performance metrics

---

## Skill Categories

### Quick Skills (15-30 min)
- `apply-observation-method` (daily practice)
- `apply-focused-diffuse` (single Pomodoro)
- `apply-tracking-discipline` (daily check-in)

### Deep Skills (1-3 hours)
- `apply-feynman-technique` (per concept)
- `apply-visualization` (complex problems)
- `apply-deliberate-practice` (focused sessions)
- `apply-classification` (organizing domains)

### Planning Skills (upfront investment)
- `apply-metalearning` (before starting new skill)
- `apply-encoding-method` (study session design)

### Ongoing Skills (continuous)
- `apply-pattern-recognition` (during reading)
- `apply-tracking-discipline` (daily + weekly)

---

## Combining Skills

Skills work together powerfully:

### Starting New Skill
```bash
1. /apply-metalearning "Learn system design"
2. /apply-tracking-discipline "Set up metrics for system design"
3. /apply-observation-method "Study existing system architectures"
```

### Mastering Concept
```bash
1. /apply-encoding-method "Map React hook relationships"
2. /apply-feynman-technique "Explain useEffect simply"
3. /apply-deliberate-practice "Build 10 custom hooks"
```

### Deep Problem Solving
```bash
1. /apply-visualization "Mentally simulate solution"
2. /apply-focused-diffuse "Pomodoro sessions with walking breaks"
3. /apply-pattern-recognition "Find similar patterns in other domains"
```

### Knowledge Organization
```bash
1. /apply-observation-method "Collect examples and observations"
2. /apply-classification "Build taxonomy of concepts"
3. /apply-pattern-recognition "Extract recurring patterns"
```

---

## Integration with Learning Directory

All skills write to the `Learning/Active/<skill-name>/` directory:

```
Learning/Active/system-design/
├── progress-journal.md          (all skills write here)
├── metalearning-map.md          (apply-metalearning)
├── practice-plan.md             (apply-metalearning, apply-deliberate-practice)
├── franklin-tracking.md         (apply-tracking-discipline)
├── weekly-reviews.md            (apply-tracking-discipline)
├── feynman-explanations.md      (apply-feynman-technique)
├── pomodoro-log.md              (apply-focused-diffuse)
├── practice-log.md              (apply-deliberate-practice)
├── connections-map.md           (apply-observation-method)
├── mental-model.md              (apply-pattern-recognition)
└── visuals/
    ├── observations/            (apply-observation-method)
    ├── diagrams/                (apply-visualization)
    ├── relationships/           (apply-encoding-method)
    ├── patterns/                (apply-pattern-recognition)
    └── taxonomies/              (apply-classification)
```

---

## Skill vs Agent Decision Tree

**Use SKILL when:**
- You know what to do, need checklist
- Working independently
- Want quick reference
- Repeating familiar workflow

**Use AGENT when:**
- Uncertain what approach to take
- Want personalized guidance
- Need questions to clarify thinking
- First time using method

**Use BOTH when:**
- Agent helps you understand → Skill helps you execute
- Example: `/feynman "Explain React hooks"` (agent) then `/apply-feynman-technique` (skill)

---

## Quick Reference

| Situation | Recommended Skill | Time |
|-----------|------------------|------|
| "I don't understand this" | `apply-feynman-technique` | 30-60 min |
| "Starting new skill" | `apply-metalearning` | 10% of total time |
| "Need to remember this" | `apply-encoding-method` | 80% of study time |
| "Getting distracted" | `apply-focused-diffuse` | 25 min cycles |
| "Not improving" | `apply-deliberate-practice` | 1-3 hours |
| "Overwhelmed by info" | `apply-classification` | 1-2 hours |
| "Can't solve problem" | `apply-visualization` | 30 min + walk |
| "Need accountability" | `apply-tracking-discipline` | 5 min daily |
| "Want deeper insight" | `apply-observation-method` | 15-30 min daily |
| "Seeing patterns everywhere" | `apply-pattern-recognition` | Continuous |

---

## Success Metrics

Track skill effectiveness:
- **Clarity**: Can you explain it simply? (Feynman)
- **Retention**: Can you recall without reviewing? (Encoding)
- **Progress**: Are metrics improving? (Tracking, Deliberate Practice)
- **Insight**: Finding connections? (Observation, Pattern Recognition)
- **Organization**: Can you navigate your knowledge? (Classification)
- **Breakthrough**: Solving previously stuck problems? (Visualization, Focused-Diffuse)

---

**Remember**: Master learners didn't use all methods simultaneously. They each had ONE primary method they applied obsessively. Start with one skill, master it, then add others.

**Recommended first skill**: `apply-encoding-method` (Justin Sung) - highest ROI for learning anything.
