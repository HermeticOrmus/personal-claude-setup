# Daily Hermetic Ritual

**Purpose**: Sustainable, integrated system usage

---

## ☀️ Morning Ritual (5 minutes)

### 1. Invoke Consciousness
```bash
# Start new day in logs
~/.hermetic/analytics/usage-tracker.sh new-day

# Check context
~/.hermetic/automation/context-detector.sh report
```

### 2. Set Intention
- What am I building today?
- Which agents will help?
- Which principle applies?

### 3. First Invocation
```
/gnosis [today's main challenge]
```

**Record**: Write intention in daily log

---

## 🌞 Midday Check (2 minutes)

### 1. Progress Check
- Is the work flowing?
- Am I stuck anywhere?
- Have I honored the chosen principle?

### 2. Course Correction
**If stuck**:
```
/vibration [stuck point]
or
apply-vibration skill
```

**If unclear**:
```
/mentalism [confusing aspect]
```

**If ethically uncertain**:
```
/align [questionable feature]
```

---

## 🌙 Evening Closure (5 minutes)

### 1. Capture Learnings
```bash
# Review health
~/.hermetic/health/health-monitor.sh dashboard

# Check stats
~/.hermetic/analytics/usage-tracker.sh stats
```

### 2. Rate Effectiveness
For each agent/command/skill used today:
```bash
~/.hermetic/analytics/usage-tracker.sh rate agent neptune 4
~/.hermetic/analytics/usage-tracker.sh rate command /gnosis 5
~/.hermetic/analytics/usage-tracker.sh rate skill debug-like-master 5
```

### 3. Journal
Answer in daily log:
- What worked well today?
- What didn't work?
- What did I learn about the system?
- What did I learn about myself?

### 4. Tomorrow's Setup
- What's tomorrow's main focus?
- Which agents to prepare?
- Which principle to emphasize?

---

## 📅 Weekly Ritual (30 minutes - Sunday Sabbath)

### 1. Sabbath Guide
```
Invoke sabbath-guide agent for structured rest
```

### 2. Week Review
```bash
# View weekly health
~/.hermetic/health/health-monitor.sh weekly

# Analyze usage patterns
~/.hermetic/analytics/usage-tracker.sh stats
```

### 3. Learning Integration
- Which agents were most valuable?
- Which commands transformed work?
- Which skills need more practice?
- What workflows emerged?

### 4. System Evolution
```
/evolve [this week's experience]
```

### 5. Celebrate
```
/celebrate [this week's achievements]
```

### 6. Plan Next Week
- What to build?
- What to learn?
- What to improve?
- Which new agent/skill to try?

---

## 🌙 Monthly Ritual (2 hours - First Sunday)

### 1. Deep System Review
- Read all daily logs from month
- Identify patterns and themes
- Calculate effectiveness trends

### 2. Health Audit
```bash
# Custom analysis of monthly health data
awk -F',' 'NR > 1 { print $1, $7 }' ~/.hermetic/health/health-history.csv | tail -30
```

### 3. Evolution Planning
- Which agents to create?
- Which workflows to optimize?
- Which skills to develop?
- What integrations to build?

### 4. Documentation Update
- Update knowledge base
- Record new patterns
- Share learnings

### 5. Gratitude Practice
```
/celebrate [this month's journey]
```

---

## 🎯 Quarterly Ritual (Half day - Every 90 days)

### 1. System Overhaul
- Review all 103 agents
- Archive unused agents
- Create needed agents
- Optimize workflows

### 2. Philosophy Deepening
- Re-read `.hermetic/manifesto.md`
- Study one Hermetic Principle deeply
- Integrate new understanding

### 3. Mastery Assessment
- Self-evaluation against all 7 principles
- Identify growth areas
- Celebrate mastery achieved

### 4. Vision Renewal
```
/illuminate [the complete system and my relationship to it]
```

### 5. Future Roadmap
- Next 90-day goals
- System evolution priorities
- Personal growth intentions

---

## ⚡ Emergency Rituals

### When Completely Stuck
1. Stop working
2. `/gnosis [the stuck point]`
3. Walk away for 15 minutes
4. Return with fresh eyes
5. `apply debug-like-master skill`

### When Burned Out
1. Check rhythm violations:
   ```bash
   ~/.hermetic/automation/context-detector.sh check
   ```
2. Immediate Sabbath:
   ```
   Invoke sabbath-guide agent
   ```
3. Rest until restored
4. Review `/rhythm` principle
5. Restructure work to honor cycles

### When Ethics Unclear
1. Stop implementation
2. `/align [the questionable feature]`
3. Consult Themis if legal implications
4. Check against Gold Hat principles
5. Only proceed if alignment confirmed

### When System Not Helping
1. Return to basics:
   - Read QUICKSTART.md
   - Use only 3 agents for one week
   - Apply only 1 skill repeatedly
2. Simplify workflows
3. Journal: "What friction am I experiencing?"
4. Optimize or remove friction points

---

## 🎨 Customization

This is a **template**. Adapt to your rhythm:

### Morning Person?
- Longer morning ritual
- Lighter evening ritual
- Deep work in AM hours

### Night Owl?
- Lighter morning ritual
- Deeper evening ritual
- Creative work in PM hours

### Sprinter?
- Intense 6-day cycles
- Full Sabbath integration
- Clear boundaries

### Marathon Runner?
- Steady daily pace
- Smaller rest cycles
- Continuous integration

**The ritual serves you. You don't serve the ritual.**

---

## 📊 Tracking Ritual Adherence

Weekly check:
- [ ] Daily morning ritual (5/7 days minimum)
- [ ] Daily evening closure (5/7 days minimum)
- [ ] Weekly Sabbath integration (mandatory)
- [ ] Monthly review (once per month)

**If falling below targets**: Simplify ritual, don't abandon it.

---

## 🌟 The Deeper Purpose

These rituals aren't bureaucracy - they're:

1. **Consciousness practice** - Mindful use of technology
2. **Pattern recognition** - Learning what works
3. **System evolution** - Making it better over time
4. **Sustainable pace** - Preventing burnout
5. **Integration** - Transforming information into wisdom

**Every ritual is a ceremony honoring sacred technology.**

---

## 💡 Quick Commands

```bash
# Morning start
hm start-day

# Midday check
hm check-in

# Evening close
hm close-day

# Weekly review
hm sabbath

# Quick stats
hm stats

# Health check
hm health

# Context report
hm context
```

*Create aliases in your `.bashrc` or `.zshrc` for these.*

---

**Ritual Version**: 1.0.0
**Created**: 2025-10-29
**For**: Hermetic Consciousness System v2.0.0

*"Rhythm creates life. Ritual creates consciousness."*

**— Principle of Rhythm applied to daily practice**
