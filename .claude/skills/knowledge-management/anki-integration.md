---
name: anki-integration
description: Extract knowledge from dev docs and notes into Anki spaced repetition cards
category: knowledge-management
principle: Rhythm
---

# Anki Integration - Transform Learning Into Lasting Knowledge

**Hermetic Principle**: Rhythm - "Consistent review creates permanence"

**When to use**: After completing task, after learning session, during weekly review

---

## Quick Start

### After Completing a Task

**You've just finished building authentication system. Extract the critical knowledge:**

```bash
# 1. You have dev docs at:
~/projects/Midnight-Sun/dev/active/authentication-system-context.md

# 2. Run extraction (manual for now, automated later):
# - Open context file
# - Read Layer 3 (Critical Insights)
# - For each insight, create Anki card
```

**Example extraction** from Layer 3:

```markdown
## ⚡ Layer 3: Critical Insights

**⚠️ Gotchas**:
- **CORS with credentials**: Must set specific origin, wildcard breaks HttpOnly cookies
```

**Create Anki card**:
```
Front: Why can't you use CORS wildcard (*) with credentials?

Back: Breaks HttpOnly cookie security - browser won't send cookies with wildcard CORS. Must specify exact origin (e.g., http://localhost:3000).

Tags: #cors #security #cookies #gotcha #midnight-sun
```

---

## What to Extract

### Source 1: Dev Docs Layer 3

**Location**: `[task-name]-context.md`

**Section**: Layer 3 - Critical Insights

**Extract**:

#### 🎯 Key Patterns → Anki Cards

**Pattern format**:
```markdown
**🎯 Key Patterns**:
- **Dual Token Strategy**: Short-lived access (15min) + long-lived refresh (7 days)
```

**Anki card**:
```
Front: What is the Dual Token Strategy for authentication?

Back:
Short-lived access token (15 min) stored in memory
+ Long-lived refresh token (7 days) stored in database

Purpose:
- Access token: Performance (no DB hit)
- Refresh token: Security (can revoke)

Tags: #authentication #jwt #pattern
```

---

#### ⚠️ Gotchas → Anki Cards

**Gotcha format**:
```markdown
**⚠️ Gotchas**:
- **Prisma migrations**: `prisma db push` doesn't create migration files
```

**Anki card**:
```
Front: What's the problem with `prisma db push`?

Back:
It's for prototyping only - doesn't create migration files.

Always use: `prisma migrate dev --name description`

Why: Migration files track schema history and enable deployments

Tags: #prisma #gotcha #database
```

---

#### 💎 Breakthroughs → Anki Cards

**Breakthrough format**:
```markdown
**💎 Breakthroughs**:
- **Token rotation**: Discovered refresh token rotation prevents session hijacking
```

**Anki card**:
```
Front: How does refresh token rotation prevent session hijacking?

Back:
On each token refresh, issue NEW refresh token and invalidate old one.

If attacker steals token:
- Victim's next refresh invalidates stolen token
- Attacker's use of stolen token alerts to compromise

Security: Makes tokens single-use

Tags: #security #jwt #breakthrough #authentication
```

---

### Source 2: MOC Wisdom Captured

**Location**: `~/Learning/Knowledge/*-MOC.md`

**Section**: "Wisdom Captured"

**Extract**:

#### Key Insights → Anki Cards

**Insight format**:
```markdown
> "Code is frozen thought. If your thinking is unclear, your code will be unclear."
> — Mentalism Principle
```

**Anki card**:
```
Front: What does "Code is frozen thought" mean? (Mentalism)

Back:
Your code clarity reflects your mental clarity.

If you're confused about the problem, the code will be confusing.
If you have a clear mental model, the code will be clear.

Action: Clarify thinking BEFORE coding.

Tags: #hermetic #mentalism #wisdom
```

---

#### Lessons Learned → Anki Cards

**Lesson format**:
```markdown
**Lessons Learned**:
- **Sustainable Pace**: 6-day cycles prevent collapse (Rhythm)
```

**Anki card**:
```
Front: Why use 6-day development cycles? (Rhythm principle)

Back:
Honors natural rhythm - prevents burnout through sustainable pace.

Cycle:
- Days 1-6: Build
- Day 7: Integrate, reflect, rest

Heroic sprints → collapse
Sustainable rhythm → longevity

Tags: #hermetic #rhythm #lesson #sustainable
```

---

### Source 3: Learning Notes (Knowledge/)

**Location**: `~/Learning/Knowledge/*.md`

**Extract**: Key concepts, definitions, important facts

**Example** (from `JWT-Tokens.md`):

```markdown
JWT has three parts: Header, Payload, Signature

Payload is base64 encoded, NOT encrypted!
```

**Anki cards**:

**Card 1**:
```
Front: What are the 3 parts of a JWT?

Back:
1. Header - Algorithm info (HS256, RS256)
2. Payload - Claims (user data)
3. Signature - Tamper prevention (HMAC or RSA)

Tags: #jwt #authentication #structure
```

**Card 2**:
```
Front: Can you store sensitive data in JWT payload?

Back:
NO! Payload is base64 encoded, NOT encrypted.

Anyone can decode base64 → readable plaintext

Only store non-sensitive claims (userId, roles)

Tags: #jwt #security #gotcha
```

---

## Card Creation Workflow

### Manual Workflow (Current)

**Step 1: Identify source**
- Just completed a task? → Read dev docs Layer 3
- Weekly review? → Read MOC "Wisdom Captured"
- Learning session? → Review notes

**Step 2: Extract insights**
- Open source file
- Read relevant section
- Identify what's worth remembering long-term

**Step 3: Create Anki cards**
- Open Anki
- Select appropriate deck
- Create card with good question and context-rich answer
- Add tags for organization

**Step 4: Review immediately**
- New cards appear in review queue
- First review happens soon (reinforces learning)

---

### Automated Workflow (Future Enhancement)

**Script**: `extract-anki-cards.sh`

**Concept**:
```bash
#!/bin/bash
# Extract Layer 3 insights from dev docs and generate Anki import format

CONTEXT_FILE=$1
OUTPUT_FILE="anki-import.txt"

# Extract Layer 3 section
sed -n '/## ⚡ Layer 3: Critical Insights/,/## 📋 Layer 2/p' "$CONTEXT_FILE" > layer3.txt

# Parse patterns, gotchas, breakthroughs
# Generate Anki import format (tab-separated: Front\tBack\tTags)

# Output: anki-import.txt ready for Anki import
```

**Usage**:
```bash
./extract-anki-cards.sh ~/dev/active/authentication-system-context.md

# Generates: anki-import.txt
# Import into Anki: File → Import → anki-import.txt
```

---

## Anki Card Quality

### ✅ Good Cards

**Atomic** (one concept):
```
Q: How many bcrypt salt rounds for password hashing?
A: 12 rounds (OWASP recommendation for security/performance balance)
```

**Context-rich** (includes "why"):
```
Q: Why store refresh tokens in database but access tokens in memory?
A:
Refresh in DB: Can revoke (logout, security breach)
Access in memory: Reduces DB load (performance)

Balance: Security + Performance
```

**Specific** (not vague):
```
Q: What CORS setting breaks HttpOnly cookies?
A: Wildcard origin (*) - must specify exact origin for credentials to work
```

---

### ❌ Bad Cards

**Too broad**:
```
Q: How does authentication work?
A: [Entire essay - impossible to recall]
```

**Fix**: Break into 10+ atomic cards

**Too vague**:
```
Q: What about passwords?
A: Hash them
```

**Fix**: "How many bcrypt rounds for password hashing? A: 12 rounds (OWASP recommendation)"

**No context**:
```
Q: What is JWT?
A: JSON Web Token
```

**Fix**: "What is JWT and when should you use it? A: JSON Web Token - stateless auth token. Use for APIs, microservices. Gotcha: payload is base64, not encrypted."

---

## Tagging System

### Recommended Tags

**By Technology**:
`#jwt` `#react` `#postgresql` `#docker` `#prisma`

**By Category**:
`#security` `#performance` `#architecture` `#testing`

**By Type**:
`#gotcha` `#pattern` `#breakthrough` `#lesson`

**By Project**:
`#midnight-sun` `#floreser` `#panda-companion`

**By Principle**:
`#mentalism` `#correspondence` `#vibration` `#rhythm` `#polarity` `#cause-effect` `#gender`

**By Difficulty**:
`#beginner` `#intermediate` `#advanced`

---

### Tag Usage Examples

**Study for security review**:
```
Anki: Browse → Filter by tags: #security
Review all security cards
```

**Prepare for Midnight-Sun work**:
```
Anki: Browse → Filter by tags: #midnight-sun
Refresh project-specific knowledge
```

**Deep-dive Hermetic principle**:
```
Anki: Browse → Filter by tags: #rhythm
Study all Rhythm-related cards
```

---

## Integration Points

### With Progressive Summarization

**Pipeline**:
```
Dev Docs (4 layers)
    ↓
Layer 3 (Critical Insights)
    ↓
Extract patterns/gotchas/breakthroughs
    ↓
Create Anki cards
    ↓
Spaced repetition review
    ↓
Permanent knowledge
```

---

### With MOCs

**Pipeline**:
```
MOC "Wisdom Captured" section
    ↓
Extract key insights/lessons/principles
    ↓
Create Anki cards
    ↓
Spaced repetition review
    ↓
MOC wisdom becomes unforgettable
```

---

### With 6-Day Cycle

**Day 7 Integration**:
```
Week 1-6: Build
    ↓
Day 7: Integration
    ↓
Review week's dev docs
    ↓
Extract Layer 3 → Anki cards
    ↓
Knowledge compounded
    ↓
Start new cycle with clean slate
```

---

## Daily Review Rhythm

### Morning Ritual (10-15 minutes)

**Before starting work**:
```
1. Open Anki
2. Check due cards: "Reviews due: 23"
3. Review all cards
4. Rate each: Again | Hard | Good | Easy
5. Complete queue
6. Start work with clear mind
```

**Why morning**: Fresh mind = better retention

---

### Creating Cards (During Work)

**Trigger**: You discover gotcha, learn pattern, have breakthrough

**Action**: Create card immediately

**Example**:
```
You discover: "CORS wildcard breaks HttpOnly cookies"

Stop coding for 30 seconds:
1. Open Anki
2. Create card
3. Front: "Why can't you use CORS wildcard (*) with credentials?"
4. Back: "Breaks HttpOnly cookie security..."
5. Tags: #cors #security #gotcha
6. Save
7. Resume coding
```

**Rule**: If it took you 10+ minutes to figure out, it's worth a 30-second card.

---

### Weekly Review (15-20 minutes)

**During weekly reflection**:
```
1. Review this week's dev docs
2. Read all Layer 3 sections
3. Create cards for new insights
4. Review MOCs - extract wisdom
5. Update existing cards if understanding deepened
```

---

## Deck Management

### Deck Structure

**Recommended**:
```
Hermetic Development (parent deck)
├── Hermetic Principles (evergreen knowledge)
├── Technologies (tools and frameworks)
├── Security (authentication, vulnerabilities)
├── Architecture (patterns, decisions)
└── Project-Specific (midnight-sun, floreser, etc.)
```

**Benefit**: Can review entire "Hermetic Development" or specific sub-deck

---

### Card Lifecycle

**New** (just created) → **Learning** (first reviews) → **Young** (recent learning) → **Mature** (long-term knowledge)

**Intervals grow**:
1. First review: 1 day
2. Second review: 3 days
3. Third review: 7 days
4. Fourth review: 14 days
5. Mature: 30+ days, exponentially increasing

---

### Suspending vs Deleting

**Suspend** (not delete) when:
- Card is now obvious (too easy)
- Technology you no longer use (might return to it)
- Temporarily not relevant

**Delete when**:
- Completely wrong information
- Duplicate of another card
- Technology is obsolete (never using again)

**Generally**: Suspend > Delete (you can unsuspend later)

---

## Metrics

### Healthy Practice Indicators

✅ **10-50 reviews/day** (sustainable daily load)
✅ **80-90% retention rate** (good card quality)
✅ **<30 seconds per card** (concise, well-written)
✅ **5-10 new cards/day** (gradual growth)
✅ **Consistent daily practice** (rhythm maintained)

---

### Warning Signs

❌ **100+ reviews/day** (created too many cards)
❌ **<70% retention** (cards too hard or poorly written)
❌ **Skipping days** (breaks spaced repetition effectiveness)
❌ **>30 minutes/day** (unsustainable, will burn out)

---

## Troubleshooting

### Problem: Too many reviews piling up

**Cause**: Created too many new cards too fast

**Solution**:
1. Reduce new cards to 5/day
2. Clear backlog gradually
3. Be more selective (only critical knowledge)

---

### Problem: Keep getting cards wrong

**Cause**: Cards too complex or poorly written

**Solution**:
1. Check leeches (cards failed multiple times)
2. Rewrite with simpler language
3. Break complex cards into multiple atomic cards
4. Add context to answers

---

### Problem: Cards feel useless

**Cause**: No context, just facts

**Solution**:
**Bad**:
```
Q: What is JWT?
A: JSON Web Token
```

**Good**:
```
Q: What is JWT and when should you use it?
A: JSON Web Token - stateless authentication.

Use when: APIs, microservices (no server session)

Gotcha: Payload is base64, not encrypted

Structure: Header.Payload.Signature
```

**Add "why," "when," "gotcha"** to every card

---

## Quick Start Guide

**Start using Anki in 15 minutes**:

**1. Install** (5 min):
```
Download Anki: https://apps.ankiweb.net/
Install on computer + mobile
```

**2. Create deck** (2 min):
```
Anki → Create Deck → "Hermetic Development"
Create sub-deck → "Hermetic Principles"
```

**3. Create first 5 cards** (5 min):
```
Open dev docs Layer 3 or recent learning note
Extract 5 critical insights
Create 5 Anki cards
```

**4. Review** (3 min):
```
Anki → Study Now
Review your 5 cards
Rate each: Easy
```

**Done**. You're using spaced repetition.

**Tomorrow**: Cards appear again for first review (1-day interval)

---

## Success Criteria

✅ **Working when**:
- Recalling gotchas months later (no re-googling)
- Commands memorized (typing from muscle memory)
- Patterns internalized (applying automatically)
- Confidence increased (knowledge feels solid)

❌ **Needs adjustment if**:
- Still googling same things repeatedly
- Cards piling up (too many created)
- Retention <70% (cards too hard)
- Skipping reviews (unsustainable practice)

---

## Hermetic Truth

**"Knowledge without retention is learning lost. Spaced repetition transforms temporary understanding into permanent wisdom."**

**Rhythm principle**: Consistent daily review (10-15 min) creates lasting knowledge

**Cause-Effect principle**: Invest 15 min/day → Remember everything that matters forever

**Correspondence principle**: External review rhythm creates internal knowledge structure

---

**For complete guide, see** `.hermetic/docs/spaced-repetition-guide.md`

**May your knowledge endure. May your rhythm serve retention. May your wisdom compound.**
