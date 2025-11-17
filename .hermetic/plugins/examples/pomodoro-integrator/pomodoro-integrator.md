# Pomodoro Integrator

**Type**: integration
**Category**: productivity
**Hermetic Principles**: Rhythm, Vibration, Polarity

## Purpose

Integrates the Pomodoro Technique with Hermetic principles to create sustainable, conscious productivity:
- **Rhythm**: Honor natural attention cycles (25 min focus / 5 min rest)
- **Vibration**: Maintain forward momentum through frequent completions
- **Polarity**: Balance intense focus with intentional rest

**Not just a timer** - a conscious practice that tracks effectiveness, prevents burnout, and integrates with your Hermetic workflow.

---

## Philosophy

**Traditional Pomodoro**: Mechanical time blocks
**Hermetic Pomodoro**: Conscious rhythm aligned with natural energy

### Key Differences

**Flexibility** (Rhythm principle):
- Can adjust timing based on energy (20 min vs 25 min vs 30 min)
- Can skip break if in flow (but respects Day 7 always)
- Tracks when rigid timing hurts vs helps

**Reflection** (Mentalism principle):
- 5-min breaks include reflection: "What did I just learn?"
- End-of-day review: "Which pomodoros were most effective?"
- Pattern recognition: "When am I most productive?"

**Integration** (Correspondence principle):
- Pomodoros logged to usage analytics
- Effectiveness ratings tracked
- Patterns emerge and inform future work

---

## Core Technique

### Standard Hermetic Pomodoro

**1. Plan** (2 min):
- What will you accomplish this pomodoro?
- Is this aligned with today's goal?

**2. Focus** (25 min):
- Single task only
- No interruptions (phone off, notifications off)
- If distraction arises, note it and return to task

**3. Log** (1 min):
- What did you accomplish?
- Rate effectiveness (1-5)

**4. Break** (5 min):
- Physical movement (stand, stretch, walk)
- NO screens (rest your eyes and mind)
- Reflect: "What did I learn?"

**5. Repeat** 4x, then longer break (15-30 min)

---

## Usage

### Basic Timer

```bash
# Start a pomodoro
hm pomodoro start "implement auth API"

# System starts 25-min timer, logs start
# Notifies when done

# After completion, log result
hm pomodoro complete 4  # Effectiveness rating 1-5
```

---

### During Pomodoro

```bash
# Check time remaining
hm pomodoro status

# Pause (if emergency)
hm pomodoro pause

# Resume
hm pomodoro resume

# Cancel (if interrupted)
hm pomodoro cancel
```

---

### After Pomodoro

```bash
# Take break (guided)
hm pomodoro break

# System reminds you when break ends
# Suggests: stretch, water, reflection
```

---

### End of Day

```bash
# Review today's pomodoros
hm pomodoro review

# Shows:
# - Total pomodoros completed
# - Most productive times
# - Average effectiveness
# - Patterns and insights
```

---

## Workflow Integration

### With Daily Development

**Morning** (from daily-development.md):
```bash
hm start-day

# First focus block: 3 pomodoros
hm pomodoro start "morning task 1"
# ... work ...
hm pomodoro complete 5

hm pomodoro start "morning task 2"
# ... work ...
hm pomodoro complete 4

hm pomodoro start "morning task 3"
# ... work ...
hm pomodoro complete 4

# Longer break (15 min)
hm pomodoro longbreak
```

**Integrates with**:
- `hm start-day` - Sets intention
- `hm context` - Suggests tasks for pomodoros
- `hm close-day` - Reviews pomodoro effectiveness

---

### With Feature Implementation

When building features:
```bash
# Plan the feature work in pomodoros

Pomodoro 1: Write tests (TDD)
Pomodoro 2-3: Implement core functionality
Pomodoro 4: Refactor and clean up
Pomodoro 5: Documentation

# Each pomodoro is one focused sub-task
```

---

### With Learning

When learning new technology:
```bash
# Study rhythm: 25/5 works well for learning

Pomodoro 1: Read documentation
Pomodoro 2: Follow tutorial
Pomodoro 3: Build small example
Pomodoro 4: Experiment and break things

# Breaks are critical for consolidation
```

---

## Hermetic Adaptations

### Energy-Based Timing

**Standard**: Always 25 min
**Hermetic**: Adjust to energy

```bash
# High energy morning
hm pomodoro start "complex algorithm" --duration 30

# Post-lunch dip
hm pomodoro start "write documentation" --duration 20

# Late afternoon focus
hm pomodoro start "code review" --duration 25
```

**System tracks** which durations work best when.

---

### Flow State Respect

**Standard**: Interrupt flow at 25 min
**Hermetic**: Option to continue if deep in flow

```bash
# At 25 min mark, system asks:
"In flow state? (y/n)"

# If yes:
- Extends by 10 min
- Logs that you extended
- Still enforces break after

# If no:
- Break time
- Tracks normal completion
```

**Caution**: Don't abuse this. Flow is real, but so is fatigue.

---

### Reflection Breaks

**Standard**: 5 min break (often wasted scrolling)
**Hermetic**: Guided reflection

```bash
# Break starts, system prompts:

🌟 Pomodoro Break (5 min)

Physical:
• Stand and stretch
• Drink water
• Look away from screen (20-20-20 rule)

Mental:
• What did you just learn?
• What surprised you?
• What's next?

Do NOT:
• Check email/slack
• Browse web
• Start another task

Ready? Timer starts in 30 seconds...
```

---

## Analytics & Insights

### Daily Summary

```bash
hm pomodoro summary
```

**Output**:
```
📊 Pomodoro Summary - 2025-10-29

Total: 8 pomodoros
Time: 3h 20min focused work
Effectiveness: 4.2/5 average

Top Tasks:
• Authentication API (3 pomodoros, 5/5 avg)
• Test writing (2 pomodoros, 4/5 avg)
• Code review (1 pomodoro, 3/5)
• Documentation (2 pomodoros, 4/5)

Energy Patterns:
🔥 Peak: 9-11am (4.8/5 effectiveness)
⚡ Good: 2-4pm (4.2/5 effectiveness)
💤 Low: 11am-2pm (3.5/5 - lunch dip)

Insights:
• Complex work best in morning
• Documentation good post-lunch
• 4 pomodoros optimal before long break
```

---

### Weekly Patterns

```bash
hm pomodoro weekly
```

**Identifies**:
- Most productive days/times
- Task-effectiveness correlations
- When you typically lose focus
- Optimal pomodoro duration for different work

---

### Recommendations

Based on tracked data:
```
💡 Recommendations:

• Schedule complex work between 9-11am (your peak time)
• Limit afternoon to 3-4 pomodoros (energy drops)
• 25 min optimal for coding, 20 min better for reviewing
• Tuesday mornings are your superpower (5/5 effectiveness)
• Friday afternoons: admin/docs (lower focus acceptable)
```

---

## Configuration

Create `.hermetic-pomodoro.json`:

```json
{
  "work_duration": 25,
  "short_break": 5,
  "long_break": 15,
  "pomodoros_until_long_break": 4,
  "allow_flow_extension": true,
  "max_extension": 10,
  "guided_breaks": true,
  "sound_notification": true,
  "desktop_notification": true,
  "strict_mode": false,
  "track_effectiveness": true
}
```

**Options**:
- `work_duration`: Default pomodoro length (15-50 min)
- `short_break`: Default short break (3-10 min)
- `long_break`: After N pomodoros (10-30 min)
- `allow_flow_extension`: Can extend if in flow
- `strict_mode`: No extensions, rigid timing (for discipline practice)
- `guided_breaks`: Show break suggestions
- `track_effectiveness`: Prompt for rating after each pomodoro

---

## Notifications

### Terminal

```bash
# When pomodoro ends
🍅 Pomodoro Complete!

Task: Implement auth API
Duration: 25 min
Effectiveness? (1-5): _
```

---

### Desktop

If `desktop_notification: true`:
- System notification at completion
- Sound alert (customizable)
- Break reminder

---

### Slack/Discord

Integrate with team:
```bash
# .hermetic-pomodoro.json
{
  "slack_webhook": "https://hooks.slack.com/...",
  "post_completion": true
}
```

Posts: "Just completed a pomodoro on [task]" (optional)

---

## Advanced: Focus Music Integration

```bash
# Start pomodoro with focus music
hm pomodoro start "deep work" --music brain.fm

# Or Spotify playlist
hm pomodoro start "coding" --music spotify:playlist:focus

# Music stops during breaks automatically
```

---

## Anti-Patterns to Avoid

### ❌ Breaking the Break

**Wrong**: "I'm on a roll, skip the break"
**Consequence**: Mental fatigue, diminishing returns
**Fix**: Take the break. Your brain needs it.

**Exception**: Flow state extension (once per session max)

---

### ❌ Multitasking During Pomodoro

**Wrong**: "I'll just quickly check Slack..."
**Consequence**: Breaks focus, defeats purpose
**Fix**: One task, full focus. Note distractions for later.

---

### ❌ Screen Breaks

**Wrong**: Break time = browse Twitter
**Consequence**: No rest, eye strain continues
**Fix**: Physical movement, eyes off screen

---

### ❌ Rigid Perfection

**Wrong**: "I failed a pomodoro, whole day ruined"
**Consequence**: All-or-nothing thinking, stress
**Fix**: Some pomodoros better than none. Be flexible.

---

### ❌ Ignoring Energy Signals

**Wrong**: "Must complete 8 pomodoros per day"
**Consequence**: Pushing through exhaustion, burnout
**Fix**: Adjust to energy. Some days 4 focused pomodoros > 8 forced ones.

---

## Hermetic Principles in Practice

### Rhythm (Core Principle)

**25/5 rhythm mirrors natural attention**:
- Humans naturally focus in ~20-30 min cycles
- Short breaks prevent fatigue
- Longer breaks (after 4) for deeper rest
- Day 7 remains sacred (no pomodoro grinding on Sabbath)

**Sustainable** > Heroic sprints

---

### Vibration (Momentum)

**Frequent completions create energy**:
- Each pomodoro is a "win"
- 8 pomodoros = 8 small victories
- Momentum builds throughout day
- Shipping feeling, even during learning

---

### Polarity (Balance)

**Intense focus ↔ Intentional rest**:
- 100% focus during work time
- 100% rest during break time
- No half-focus (multitasking)
- No half-rest (phone scrolling)

**Both extremes** for best results

---

### Mentalism (Clear Thinking)

**Single-task clarity**:
- One thing per pomodoro
- Clear intention before starting
- Reflection after completing
- Learning captured

**Fuzzy thinking** → **Poor results**
**Clear thinking** → **Effective work**

---

## Success Metrics

**Good Indicators**:
- Complete 4-8 pomodoros per day (sustainable)
- Average effectiveness 4+/5
- Actually take breaks (not skip them)
- Energy maintained throughout day
- No burnout feeling

**Warning Signs**:
- Completing 12+ pomodoros (pushing too hard)
- Average effectiveness <3/5 (forcing it)
- Skipping breaks (defeating purpose)
- Exhaustion at day end (unsustainable)

**Track with**:
```bash
hm pomodoro review
hm health  # Overall wellbeing check
```

---

## Script Features

### pomodoro.sh

```bash
#!/bin/bash
# Hermetic Pomodoro Timer

hm_pomodoro() {
  case "$1" in
    start)
      # Start timer
      # Log to analytics
      # Show focus prompt
      ;;

    complete)
      # Stop timer
      # Log completion
      # Prompt effectiveness rating
      # Suggest break
      ;;

    break)
      # Start break timer
      # Show guided break suggestions
      # Notify when break ends
      ;;

    summary)
      # Show daily pomodoro summary
      # Calculate effectiveness
      # Show patterns
      ;;
  esac
}
```

**Features**:
- Terminal-based timer
- Usage logging integration
- Effectiveness tracking
- Pattern analysis
- Guided breaks
- Flexible timing

---

## Integration Points

### With Analytics

Every pomodoro logged:
```csv
timestamp,type,name,context,effectiveness,duration
2025-10-29 09:00:00,pomodoro,auth-api,feature-work,5,25
2025-10-29 09:30:00,break,short,rest,N/A,5
```

Feeds into:
- Pattern recognition
- Health monitoring
- Dashboard visualization

---

### With Health Monitoring

Pomodoro data affects health score:
- Sufficient breaks → Higher health
- Skipped breaks → Health warning
- Unsustainable pace → Burnout alert

---

### With Context Detection

Context suggests:
- Pomodoro duration (complex vs simple tasks)
- When to take longer break (energy drop detected)
- Time of day recommendations (based on patterns)

---

## Installation

```bash
# Activate plugin
hm plugin activate pomodoro-integrator

# Make timer accessible
chmod +x ~/.hermetic/plugins/examples/pomodoro-integrator/pomodoro.sh

# Add to shell integration
source ~/.hermetic/automation/shell-integration.sh

# Test
hm pomodoro start "test task"
```

---

## Effectiveness Tracking

```bash
# After using pomodoros for a day
hm rate workflow pomodoro-integrator 5

# System learns:
# - Your optimal timing
# - Best times for different work
# - When breaks most needed
# - Effectiveness patterns
```

---

## Resources

**Learn More**:
- Original Pomodoro Technique: Francesco Cirillo
- Research on attention spans
- Hermetic Rhythm principle docs

**Alternatives**:
- Flowtime Technique (flexible duration)
- Ultradian Rhythm (90-min cycles)
- DeskTime tracking

---

**Plugin Version**: 1.0.0
**Last Updated**: 2025-10-29
**Hermetic Principles**: Rhythm, Vibration, Polarity
**Type**: Integration

*"Focus follows rhythm. Productivity follows rest. Excellence follows balance."*
