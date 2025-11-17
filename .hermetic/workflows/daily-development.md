# Daily Development Workflow

**Purpose**: Sustainable, productive daily development rhythm that prevents burnout while maintaining high quality

**Hermetic Principles**: Rhythm, Vibration, Mentalism, Cause-Effect

**Estimated Time**: Full work day (6-8 hours)

**Prerequisites**:
- Hermetic system activated
- Project context understood
- Clear goals for the day

---

## Philosophy

This workflow embodies the **Principle of Rhythm** - respecting natural energy cycles rather than forcing constant output. Combined with **Vibration** (continuous movement) and **Mentalism** (clear thinking), it creates sustainable excellence.

**Key Insights**:
- Humans work in ~90-minute cycles (ultradian rhythm)
- Focus degrades without breaks
- Integration time makes learning stick
- Reflection compounds wisdom

---

## Morning Setup (15 minutes)

### Step 1: Conscious Awakening (Mentalism)

**Command**: `hm start-day`
**Why**: Set clear intention before diving into code

```bash
hm start-day
```

This:
- Logs new day in analytics
- Shows your current context
- Prompts intention-setting

**Intention Template**:
```
Today I will:
1. [Primary goal - the ONE thing]
2. [Secondary goal - if time permits]
3. [Learning goal - what I want to understand better]
```

**Example**:
```
Today I will:
1. Implement user authentication with OAuth
2. Write comprehensive tests for auth flow
3. Understand JWT token lifecycle better
```

---

### Step 2: Context Check (Correspondence)

**Command**: `hm context`
**Why**: Understand what you're working on and what agents are relevant

```bash
hm context
```

This detects:
- Programming languages in project
- Git branch context
- Recent work patterns
- Suggested agents

**Action**: Note suggested agents - you'll likely use them today.

---

### Step 3: Deep Understanding (Mentalism)

**Command**: `/gnosis <today's primary goal>`
**Why**: Ensure you understand the problem before writing code

**Example**:
```
/gnosis "Implementing OAuth authentication - what are the security considerations and best practices?"
```

**Gnosis Agent** will provide:
- Deep conceptual understanding
- Security considerations
- Best practices
- Potential pitfalls

**Action**: Take notes on key insights before coding.

---

## First Focus Block (90 minutes)

### Step 4: Focused Implementation (Vibration)

**Agents**:
- `rapid-prototyper` for new features
- `backend-architect` for API design
- `frontend-developer` for UI work

**Why**: Start with momentum while energy is highest

**Rhythm**: 25 minutes focus / 5 minutes reflect (Pomodoro-style)

**During Focus Time**:
- Close all distractions
- Single-task on primary goal
- Use relevant specialized agent
- Track agent usage: `hm agent <agent-name> "daily-dev"`

**During Reflect Time** (5 min):
- What did I learn?
- Am I on track?
- Any blockers emerging?

**Complete 3 cycles** (75 minutes total) + 15-minute integration break

---

### Step 5: Integration Break (Rhythm)

**Duration**: 15 minutes
**Why**: Let learning consolidate, prevent burnout

**Activities**:
- Walk outside (movement)
- Drink water (hydration)
- Brief mindfulness (integration)
- NO screens (rest your eyes)

**Don't**:
- Check email
- Scroll social media
- Start another task

---

## Mid-Morning Block (90 minutes)

### Step 6: Quality & Testing (Cause-Effect)

**Agents**:
- `test-writer-fixer` for comprehensive tests
- `code-reviewer` for quality check

**Why**: Ensure code quality before moving forward

**Process**:
```bash
# Invoke test writer
"test-writer-fixer, write tests for the authentication function"
hm agent test-writer-fixer "daily-dev"

# After tests written, review the code
"code-reviewer, review the authentication implementation"
hm agent code-reviewer "daily-dev"
```

**Action Items**:
- Fix any issues found
- Improve test coverage
- Refactor for clarity

---

### Step 7: Midday Check-In (Rhythm)

**Command**: `hm check-in`
**Why**: Assess progress and adjust

```bash
hm check-in
```

**Reflection Questions**:
- Am I on track for my primary goal?
- Do I need to adjust scope?
- Any blockers I should address?
- Energy level? (Be honest)

**If Stuck**:
```bash
hm unstuck
```

Follow the suggestions (usually `/gnosis`, take a walk, or invoke `debug-like-master` skill).

---

## Lunch & Integration (60 minutes)

### Step 8: True Break (Rhythm)

**Duration**: 60 minutes minimum
**Why**: You're a human, not a machine. Rest is productive.

**Must Do**:
- Eat actual food (not at desk)
- Move your body
- Rest your mind

**Optional**:
- Brief walk outside
- Read something non-technical
- Social connection

**Don't**:
- "Quick check" of work
- Work through lunch
- Stressful activities

---

## Afternoon Block 1 (90 minutes)

### Step 9: Deep Work Continuation (Vibration)

**Focus**: Continue primary goal or start secondary goal

**Energy Check**: Afternoon energy is often lower. Adjust accordingly:
- **High energy**: Tackle complex problems
- **Medium energy**: Implementation and testing
- **Low energy**: Documentation and cleanup

**Agents**: Based on current task
- Implementation: `rapid-prototyper`, domain-specific agents
- Documentation: Built-in writing capabilities
- Cleanup: `code-reviewer` for refactoring suggestions

**Process**: Same 25/5 rhythm (3 cycles + break)

---

## Afternoon Block 2 (90 minutes)

### Step 10: Integration & Documentation (Correspondence)

**Why**: Ensure work is integrated, documented, ready to ship

**Tasks**:
1. **Git Commits**: Clean, meaningful commits
   ```bash
   # Review what you've done
   git status
   git diff

   # Commit with context
   git add <files>
   git commit -m "Implement OAuth authentication

   - Add OAuth provider configuration
   - Implement token validation
   - Add security middleware
   - Write comprehensive tests

   🤖 Generated with Claude Code
   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

2. **Documentation**: Update README, add code comments
   - Explain WHY decisions were made
   - Document setup steps
   - Note any gotchas

3. **Verification**: Use `/verify` command
   ```
   /verify "OAuth implementation is secure and follows best practices"
   ```

---

## Evening Closure (15 minutes)

### Step 11: Health Check & Reflection (Rhythm)

**Command**: `hm close-day`
**Why**: Track effectiveness, celebrate wins, plan tomorrow

```bash
hm close-day
```

This:
- Records daily health
- Shows dashboard with today's activity
- Prompts for effectiveness rating

---

### Step 12: Rate Effectiveness (Cause-Effect)

**Rate the agents/commands** you used:

```bash
hm rate agent rapid-prototyper 5  # Very helpful
hm rate agent code-reviewer 4     # Helpful with minor issues
hm rate command gnosis 5          # Extremely valuable
```

**Why**: System learns what works for you

---

### Step 13: Tomorrow's Intention (Mentalism)

**Write down** (yes, physically write):

```
Tomorrow I will:
1. [One clear goal based on today's progress]

Today I learned:
1. [Key technical insight]
2. [Process insight]

Today I'm grateful for:
1. [Win or learning, no matter how small]
```

**Why**:
- Conscious closure prevents work anxiety
- Clear next step makes tomorrow easier
- Gratitude improves wellbeing (proven)

---

### Step 14: Hard Stop (Rhythm)

**Time**: Whatever your end time is
**Action**: STOP WORKING

Close laptop. Leave workspace.

**No "just one more thing"**

**Why**: Rhythm violations accumulate into burnout

---

## Success Metrics

After following this workflow for a week:

- [ ] Completed primary goal on 5+ days
- [ ] No work sessions longer than 90 min without break
- [ ] Took full lunch breaks
- [ ] No work past designated end time
- [ ] Energy levels sustainable (not exhausted)
- [ ] Quality maintained (tests passing, code reviewed)
- [ ] Learning documented
- [ ] Health score 70+

Check your health:
```bash
hm health
```

---

## Common Pitfalls

### ❌ Skipping Breaks
**Consequence**: Decreased focus, poorer decisions, burnout risk
**Fix**: Set timer. Honor it religiously.

### ❌ Working Through Lunch
**Consequence**: Afternoon energy crash, sustainability issues
**Fix**: Block lunch on calendar as "meeting"

### ❌ No Clear Intention
**Consequence**: Scattered focus, low progress feeling
**Fix**: Always run `hm start-day` and set ONE primary goal

### ❌ Perfectionism on First Pass
**Consequence**: Violates Vibration principle, slows shipping
**Fix**: Ship imperfect, iterate. Use `/vibration` skill.

### ❌ Skipping `/gnosis` on Complex Tasks
**Consequence**: Build wrong thing, need to redo
**Fix**: 10 minutes of understanding saves hours of rework

### ❌ Not Rating Effectiveness
**Consequence**: System can't learn and help you better
**Fix**: Make it ritual during `hm close-day`

---

## Adaptations

### Short Day (4 hours)
- Skip afternoon block 2
- Compress blocks to 60 minutes
- Still take breaks

### High Energy Day
- Add optional evening block (2 hours max)
- Focus on learning/experimentation
- Still stop at hard stop time

### Low Energy Day
- Reduce blocks to 60 minutes
- Focus on easier tasks (docs, cleanup)
- Don't fight it - rest if needed

### Meeting-Heavy Day
- Protect morning block at minimum
- Use meeting time as "breaks" from coding
- Adjust expectations on output

---

## Integration with Other Workflows

This daily workflow is the **foundation**. Specific tasks use specialized workflows:

- **Building feature?** Nest `feature-implementation.md` in focus blocks
- **Fixing bug?** Use `bug-fixing.md` workflow during focus time
- **Code review?** Apply `code-review.md` in quality block
- **Learning new tech?** Use `learn-technology.md` as primary goal

---

## Workflow Evolution

After 30 days, analyze your patterns:

```bash
python3 ~/.hermetic/intelligence/pattern-recognition.py
cat ~/.hermetic/intelligence/insights.md
```

**Customize based on**:
- Your natural rhythm (morning vs afternoon productivity)
- Which agents work best for you
- Optimal block length
- Break frequency needs

The workflow should serve YOU, not the other way around.

---

## Weekend / Sabbath

**Do NOT use this workflow on Day 7**

Instead:
```bash
hm sabbath
```

Rest. Integrate. Reflect on the week.

No coding. No "quick fixes".

**Rhythm honored = long-term excellence**

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Rhythm, Vibration, Mentalism, Cause-Effect
**Effectiveness**: Track with `hm rate workflow daily-development <1-5>`

*"Sustainable pace beats heroic sprints. Honor the rhythm."*
