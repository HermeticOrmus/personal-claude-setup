# Daily Standup Generator

**Type**: agent (analyzer)
**Category**: productivity
**Hermetic Principles**: Mentalism, Rhythm, Correspondence

## Purpose

Automatically generates concise, meaningful daily standup reports by analyzing:
- Yesterday's actual work (from usage tracking)
- Today's planned tasks (from sprint plan or calendar)
- Blockers and context (from current project state)

**Why this matters**: Standups should be helpful, not performative. This agent helps you communicate progress clearly without spending 15 minutes crafting the "perfect" standup message.

---

## When to Use

- **Daily team standups** (sync or async)
- **Solo progress tracking** (accountability to yourself)
- **Manager check-ins** (quick status updates)
- **Sprint reviews** (what got done this week)

**Invoke**: Every morning before standup, or use `/gnosis` with standup context

---

## Capabilities

### 1. Yesterday Analysis (Mentalism - Clear Thinking)

Analyzes your usage data to determine:
- **What you actually worked on** (agents used, commands invoked)
- **How much time spent** (work session duration)
- **What you shipped** (git commits, deployments)
- **Effectiveness** (based on your ratings)

**Not vague**: "worked on the API"
**Specific**: "Implemented 3 authentication endpoints, wrote 12 tests, deployed to staging"

---

### 2. Today Planning (Rhythm - Intentional Work)

Combines:
- Today's sprint tasks (from sprint plan)
- Context from current branch/files
- Your stated intention (from `hm start-day`)

**Output**: Clear, achievable goals for today

---

### 3. Blocker Detection (Cause-Effect)

Identifies potential blockers:
- Waiting on others (PRs, reviews, designs)
- Technical unknowns (research needed)
- External dependencies (APIs, services)
- Capacity issues (too much planned)

**Proactive**: Surfaces blockers before they delay you

---

### 4. Context Sharing (Correspondence)

Provides relevant context for team:
- What feature/epic this relates to
- Dependencies with others' work
- Risks or concerns to be aware of

---

## Example Usage

### Basic Invocation

**User**: "daily-standup, generate my standup for today"

**Agent Output**:
```
📊 Daily Standup - 2025-10-29

✅ Yesterday:
• Completed user authentication API (3 endpoints)
  - POST /auth/register
  - POST /auth/login
  - POST /auth/logout
• Wrote 12 unit tests (100% coverage on auth)
• Code reviewed 2 PRs for team members
• Deployed auth service to staging, verified working

⏱️ Time: 6 hours focused work (good pace)
⭐ Effectiveness: 4.5/5 (productive day)

🎯 Today:
• Implement password reset flow
  - Email service integration
  - Token generation & validation
  - Frontend password reset page
• Write tests for password reset
• Get security review from @sarah before shipping

⚠️ Blockers:
• None currently
• Will need email service credentials (ask @ops)

📌 Context:
• Sprint 12: User Account Management
• On track to complete sprint goal (user auth system)
• Auth service ready for integration with other services

💡 Note: Authentication is foundation for next sprint's features
```

---

### With Blocker

**User**: "daily-standup, I'm blocked waiting on API design review"

**Agent Output**:
```
📊 Daily Standup - 2025-10-29

✅ Yesterday:
• Designed password reset API (documented in Notion)
• Created sequence diagrams for email flow
• Prepared security review questions

🚧 Today - BLOCKED:
❌ Can't implement password reset (waiting on API design review from @sarah)

🔄 Alternate work planned while blocked:
• Improve test coverage on existing auth endpoints
• Refactor auth middleware for clarity
• Update documentation for authentication flow
• Research email service providers (SendGrid vs AWS SES)

⚠️ Blockers:
• CRITICAL: Need API design review from @sarah (requested Monday, no response yet)
• Timeline impact: Will push password reset to tomorrow if not unblocked by noon

📌 Context:
• Sprint 12: User Account Management
• Password reset is critical path for sprint goal
• Need design review to ensure security best practices

🆘 Action needed: @sarah - Can you review the API design today?
```

---

### Team Coordination

**User**: "daily-standup, emphasize dependencies with Alex's work"

**Agent Output**:
```
📊 Daily Standup - 2025-10-29

✅ Yesterday:
• Completed auth API endpoints
• All tests passing, deployed to staging

🎯 Today:
• Integrate auth with @alex's user profile service
  - Add JWT validation to profile endpoints
  - Test cross-service authentication
  - Document integration for team

🤝 Dependencies:
• NEED from @alex: Profile service deployed to staging by 10am
• PROVIDING to @alex: Auth token format documentation (sent this morning)
• COORDINATING: Pair programming session at 2pm to integrate services

⚠️ Blockers:
• None if Alex's service is ready by 10am
• Backup plan: Continue with other sprint tasks if delayed

📌 Context:
• Sprint 12: User Account Management
• Auth + Profile integration is milestone for end-of-sprint demo
• This unblocks @maria's frontend work tomorrow
```

---

## Configuration

Create `.hermetic-standup.json` in project root to customize:

```json
{
  "format": "detailed",
  "include_time_spent": true,
  "include_effectiveness": true,
  "highlight_blockers": true,
  "team_context": true,
  "emoji_style": "professional",
  "time_zone": "America/Los_Angeles"
}
```

**Options**:
- `format`: "brief" | "detailed" | "bullets"
- `include_time_spent`: Show hours worked (useful for solo tracking, might skip for team)
- `include_effectiveness`: Your self-rating (personal accountability)
- `highlight_blockers`: Emphasize blockers clearly
- `team_context`: Add context for team understanding
- `emoji_style`: "none" | "minimal" | "professional" | "fun"

---

## Integration

### Slack/Teams Integration

Use with automation to post daily standups:

```bash
#!/bin/bash
# post-standup.sh

# Generate standup
standup=$(hm agent daily-standup "generate standup")

# Post to Slack
curl -X POST $SLACK_WEBHOOK \
  -H 'Content-Type: application/json' \
  -d "{\"text\": \"$standup\"}"
```

---

### GitHub Issues

Create issue comment with standup:

```bash
# Add to .git/hooks/pre-push or CI/CD
gh issue comment $ISSUE_NUMBER --body "$(hm agent daily-standup)"
```

---

### Async Standups (Discord/Email)

For remote teams with async standups:

```bash
# Morning routine
hm start-day
hm agent daily-standup "generate detailed standup" > standup.txt

# Post to team channel
cat standup.txt | pbcopy  # Copy to clipboard, paste in Discord
```

---

## Approach & Algorithm

### Data Sources

**1. Usage Analytics** (`~/.hermetic/analytics/usage.csv`):
```csv
timestamp,type,name,context,effectiveness
2025-10-28 09:15:00,agent,backend-architect,auth-api,5
2025-10-28 10:30:00,cmd,gnosis,password-reset,4
2025-10-28 14:00:00,agent,test-writer-fixer,auth-tests,5
```

**2. Git History**:
```bash
git log --since="yesterday" --author="$USER" --oneline
git diff --shortstat HEAD@{yesterday} HEAD
```

**3. Sprint Plan** (if exists):
```markdown
## Today's Tasks
- [ ] Implement password reset
- [ ] Write tests
- [ ] Security review
```

**4. Context Detection** (current branch, files, time):
```bash
git branch --show-current
ls -lt | head -5  # Recently modified files
date  # Current time for scheduling
```

---

### Analysis Process

**Step 1: Extract Yesterday's Work**
```
- Parse usage.csv for yesterday's entries
- Group by context/feature
- Calculate time spent (session duration)
- Extract effectiveness ratings
- Query git for commits/changes
```

**Step 2: Summarize Accomplishments**
```
- Identify completed tasks (tests passing, code merged, deployed)
- Quantify output (N endpoints, X tests, Y commits)
- Note effectiveness (high/medium/low productivity)
```

**Step 3: Identify Today's Plan**
```
- Read sprint plan for today's tasks
- Check current branch for active work
- Consider yesterday's momentum (continue same feature?)
- Estimate realistic scope (based on historical velocity)
```

**Step 4: Detect Blockers**
```
- Check for pending PR reviews
- Identify external dependencies
- Scan for "waiting on" comments in code/notes
- Assess capacity vs planned work
```

**Step 5: Format Output**
```
- Clear sections (Yesterday, Today, Blockers, Context)
- Specific numbers and artifacts
- Actionable language
- Appropriate detail level for audience
```

---

## Hermetic Principles Applied

### Mentalism (Clear Thinking)

**Problem**: Vague standups waste time
"I worked on stuff. Today I'll work on more stuff."

**Solution**: Specific, clear communication
- What specifically was accomplished?
- What specifically is planned?
- What specifically is blocked?

**Mental clarity** → **Communication clarity**

---

### Rhythm (Sustainable Pace)

**Problem**: Performative standups create pressure to "look busy"

**Solution**: Honest progress reporting
- Shows actual work done (not inflated)
- Realistic plans for today (not over-committed)
- Acknowledges blockers without shame

**Healthy rhythm** requires **honest communication**

---

### Correspondence (Patterns Repeat)

**Problem**: Individual work seems disconnected from team goals

**Solution**: Connect micro to macro
- Individual tasks → Feature completion
- Feature completion → Sprint goals
- Sprint goals → Product vision

**Your daily work** ↔ **Team success**

---

## Success Metrics

**Individual**:
- Standup takes <5 min to prepare
- Team understands your progress
- Blockers surfaced early
- Accountability maintained

**Team**:
- Coordination issues identified quickly
- Dependencies managed proactively
- Progress visible to all
- Async standups work smoothly

**Track with**:
```bash
hm agent daily-standup "generate standup"
hm rate agent daily-standup 5
```

---

## Common Issues & Solutions

### Issue: Standup seems too long

**Solution**: Use "brief" format
```json
{
  "format": "brief",
  "include_time_spent": false,
  "include_effectiveness": false
}
```

---

### Issue: Not enough detail

**Solution**: Use "detailed" format + more context
```
"daily-standup, generate detailed standup with full context for remote team"
```

---

### Issue: Blocker not detected

**Solution**: Explicitly mention blockers
```
"daily-standup, I'm blocked on [specific thing]"
```

---

### Issue: Yesterday's work seems wrong

**Solution**: Check usage tracking is active
```bash
hm stats  # Verify data is being logged
```

If not tracking:
```bash
hm start-day  # Activates tracking
```

---

## Advanced: Sprint Summary

**User**: "daily-standup, generate week summary for sprint review"

**Agent Output**:
```
📊 Sprint 12 Summary - Week of Oct 23-29

🎯 Sprint Goal: Complete User Account Management
Status: ✅ ON TRACK (90% complete)

📈 What We Shipped:
• User Authentication System
  - Registration, login, logout (3 endpoints)
  - JWT token management
  - Session handling
  - Comprehensive test suite (95% coverage)
  - Deployed to staging (verified working)

• Password Reset Flow
  - Email integration (SendGrid)
  - Secure token generation
  - Reset page UI
  - End-to-end tested

• Security Hardening
  - Rate limiting on auth endpoints
  - Password strength validation
  - Brute force protection
  - Security audit passed

📊 Velocity:
• Planned: 32 hours of work
• Actual: 30 hours (good estimate!)
• Completed: 8/10 tasks (80%)
• Effectiveness: 4.3/5 average

🚧 Not Completed (Carrying Over):
• Two-factor authentication (low priority, moved to Sprint 13)
• OAuth social login (nice-to-have, descoped)

🎓 What We Learned:
• Email integration took longer than expected (3h vs 1h estimated)
• Test-driven development saved time on auth security
• Pair programming on integration was very effective

🎉 Wins:
• Zero security issues in audit
• All critical user stories completed
• Code quality remained high
• No production incidents

📅 Next Sprint:
• Two-factor authentication
• User profile management
• Account settings page
```

---

## Plugin Metadata

**Version**: 1.0.0
**Last Updated**: 2025-10-29
**Hermetic Principles**: Mentalism, Rhythm, Correspondence
**Dependencies**: Usage tracking system
**Type**: Analyzer Agent

---

## Installation

```bash
# Activate plugin
hm plugin activate daily-standup

# Configure (optional)
cat > .hermetic-standup.json <<EOF
{
  "format": "detailed",
  "include_time_spent": true
}
EOF

# Use
hm agent daily-standup "generate standup"
```

---

## Effectiveness Tracking

```bash
# After using for standup
hm agent daily-standup "standup"
hm rate agent daily-standup 5

# Review effectiveness
python3 ~/.hermetic/intelligence/pattern-recognition.py
```

**Optimization**: Agent learns from your ratings to adjust detail level and format preference.

---

*"Clear communication starts with clear thinking. Daily standups should inform, not perform."*
