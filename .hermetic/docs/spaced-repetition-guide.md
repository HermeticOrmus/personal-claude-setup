# Spaced Repetition Guide - Combat the Forgetting Curve

**Principle**: "Review at optimal intervals. Remember everything that matters."

**Research**: Ebbinghaus Forgetting Curve - Without review, you forget:
- 50% within 1 hour
- 70% within 24 hours
- 90% within 30 days

**Solution**: Spaced Repetition - Review information at increasing intervals based on memory strength

---

## The Problem: The Forgetting Curve

### What You Learn Today

**Without spaced repetition**:
```
Day 1:   100% retention ██████████
Day 2:    30% retention ███
Day 7:    10% retention █
Day 30:    5% retention
```

**With spaced repetition**:
```
Day 1:   100% retention ██████████ (learned)
Day 2:    95% retention ████████  █ (reviewed)
Day 7:    90% retention ████████  █ (reviewed)
Day 30:   85% retention ████████  █ (reviewed)
Day 90:   80% retention ████████    (reviewed)
```

**Result**: Knowledge moves from short-term → long-term memory

---

### The Spacing Effect

**Key Discovery** (Hermann Ebbinghaus, 1885):
- Reviewing at optimal intervals = maximum retention with minimum effort
- Intervals increase exponentially (1 day, 3 days, 7 days, 14 days, 30 days...)
- Each successful recall strengthens memory trace

**Optimal intervals** (SuperMemo SM-2 algorithm):
1. **First review**: 1 day
2. **Second review**: 3 days
3. **Third review**: 7 days
4. **Fourth review**: 14 days
5. **Fifth review**: 30 days
6. **Sixth+ reviews**: Exponential increase based on difficulty

---

## Integration with Hermetic System

### What to Put Into Spaced Repetition

**NOT everything** - Only what needs long-term retention:

**✅ Excellent for SR**:
- **Key concepts**: Definitions, principles, laws
- **Gotchas**: Common mistakes you keep making
- **Patterns**: Architectural patterns, code patterns
- **Commands**: Terminal commands, git commands
- **APIs**: Function signatures, key parameters
- **Facts**: Version compatibility, security standards

**❌ Poor for SR**:
- Information you reference daily (already retained)
- Rapidly changing information (becomes outdated)
- Complex procedures (better as checklists)
- Project-specific details (better in dev docs)

---

### Source 1: Learning Directory Notes

**Extract from**: `~/Learning/Knowledge/*.md`

**What to capture**:
- Key insights from notes
- Definitions of important concepts
- Patterns you discovered
- Gotchas that surprised you

**Example** (from `JWT-Tokens.md`):
```markdown
# JWT Tokens

JWT has three parts: Header, Payload, Signature

Header contains algorithm (HS256, RS256, etc.)
Payload contains claims (user data)
Signature prevents tampering

**Gotcha**: Never store sensitive data in payload - it's base64 encoded, not encrypted!
```

**Anki cards to create**:
1. Q: "What are the 3 parts of a JWT?" A: "Header, Payload, Signature"
2. Q: "Why shouldn't you store sensitive data in JWT payload?" A: "Payload is base64 encoded, not encrypted - anyone can decode it"

---

### Source 2: Dev Docs Layer 3 (Critical Insights)

**Extract from**: Layer 3 of context files

**Layer 3 contains**:
- 🎯 Key Patterns
- ⚠️ Gotchas
- 💎 Breakthroughs

**Example** (from authentication dev docs):
```markdown
## ⚡ Layer 3: Critical Insights

**⚠️ Gotchas**:
- **CORS with credentials**: Must set specific origin, wildcard breaks HttpOnly cookies
- **Prisma migrations**: `prisma db push` doesn't create migration files
```

**Anki cards**:
1. Q: "Why can't you use CORS wildcard (*) with credentials?" A: "Breaks HttpOnly cookie security - must specify exact origin"
2. Q: "What's the difference between `prisma db push` and `prisma migrate dev`?" A: "`db push` is for prototyping only, doesn't create migration files. Always use `migrate dev` for production."

---

### Source 3: MOC "Wisdom Captured"

**Extract from**: MOCs you maintain

**MOCs contain**:
- Key Insights (synthesized understanding)
- Lessons Learned (hard-won knowledge)
- Principles (rules you follow)

**Example** (from Hermetic Principles MOC):
```markdown
## Wisdom Captured

**Key Insights**:
> "Code is frozen thought. If your thinking is unclear, your code will be unclear."
> — Mentalism Principle

**Lessons Learned**:
- **Dark Patterns**: Recognizing them immediately (Cause-Effect awareness)
- **Sustainable Pace**: 6-day cycles prevent collapse (Rhythm)
```

**Anki cards**:
1. Q: "What does 'Code is frozen thought' mean?" A: "If your thinking is unclear, your code will be unclear. Mentalism principle - mental clarity precedes code clarity."
2. Q: "Why 6-day development cycles?" A: "Honors Rhythm principle - sustainable pace prevents burnout. Work 6 days, integrate on Day 7."

---

## Anki Setup for Developers

### Installation

**Download Anki**: https://apps.ankiweb.net/

**Why Anki**:
- Free, open-source
- Cross-platform (Windows, Mac, Linux, mobile)
- Proven algorithm (SuperMemo SM-2)
- Customizable
- Syncs across devices

---

### Deck Structure

**Recommended organization**:

```
Hermetic Development
├── Programming Concepts
│   ├── Algorithms & Data Structures
│   ├── Design Patterns
│   └── Language Specific
│       ├── JavaScript
│       ├── Python
│       └── TypeScript
├── Hermetic Principles
│   ├── Mentalism
│   ├── Correspondence
│   ├── Vibration
│   ├── Polarity
│   ├── Rhythm
│   ├── Cause-Effect
│   └── Gender
├── Technologies
│   ├── React
│   ├── PostgreSQL
│   ├── Docker
│   └── Claude Code
├── Security
│   ├── Authentication
│   ├── Authorization
│   ├── Common Vulnerabilities
│   └── Best Practices
└── Project-Specific
    ├── Midnight-Sun
    ├── FloreSer
    └── PandaCompanion
```

---

### Card Types

#### Basic Card (Question → Answer)

**Use for**: Facts, definitions, simple concepts

**Front**:
```
What does JWT stand for?
```

**Back**:
```
JSON Web Token

A compact, URL-safe means of representing claims between two parties.
```

---

#### Reverse Card (Both Directions)

**Use for**: Bidirectional knowledge (term ↔ definition)

**Front 1**:
```
What is the Hermetic Principle of Correspondence?
```

**Back 1**:
```
"As above, so below; as below, so above."

Architecture mirrors values. System structure reflects priorities.
```

**Front 2** (automatically generated):
```
Which Hermetic Principle means "As above, so below"?
```

**Back 2**:
```
Correspondence

Architecture mirrors values. System structure reflects priorities.
```

---

#### Cloze Deletion (Fill in the Blank)

**Use for**: Sequential information, lists, formulas

**Card**:
```
The 7 Hermetic Principles are:
1. {{c1::Mentalism}}
2. {{c2::Correspondence}}
3. {{c3::Vibration}}
4. {{c4::Polarity}}
5. {{c5::Rhythm}}
6. {{c6::Cause-Effect}}
7. {{c7::Gender}}
```

**Review**: Anki shows one blank at a time, you recall each principle

---

#### Code Card (Syntax/Pattern)

**Use for**: Code patterns, syntax, commands

**Front**:
```
How do you hash a password with bcrypt in Node.js?
(12 rounds, async)
```

**Back**:
```javascript
const bcrypt = require('bcrypt');

const saltRounds = 12;
const hashedPassword = await bcrypt.hash(password, saltRounds);
```

**Tag**: `#nodejs #bcrypt #security #authentication`

---

### Card Quality Guidelines

#### ✅ Good Cards

**1. Atomic** (one concept per card):
```
Q: What does the Correspondence principle say about code structure?
A: Code structure should mirror your mental model and values
```

**2. Specific** (not vague):
```
Q: How many salt rounds for bcrypt password hashing?
A: 12 rounds (OWASP recommendation)
```

**3. Context-rich** (includes "why"):
```
Q: Why store refresh tokens in database but access tokens in memory?
A: Refresh in DB = can revoke (security). Access in memory = reduce DB load (performance). Balances security and performance.
```

---

#### ❌ Bad Cards

**1. Too broad**:
```
Q: How does authentication work?
A: [Too much information, impossible to recall]
```

**Fix**: Break into 5+ atomic cards

**2. Too vague**:
```
Q: What's important about passwords?
A: Hash them
```

**Fix**: "How many bcrypt rounds for password hashing? A: 12 rounds (OWASP recommendation)"

**3. No context**:
```
Q: What is JWT?
A: JSON Web Token
```

**Fix**: "What does JWT stand for and what is it used for? A: JSON Web Token - compact, URL-safe authentication token containing claims"

---

## Daily Review Workflow

### Morning Ritual (5-15 minutes)

**Before starting work**:
```
1. Open Anki
2. Check due cards count
3. Review all due cards (typically 10-50/day)
4. Rate difficulty: Again | Hard | Good | Easy
5. Complete reviews (clears mental space)
```

**Why morning**: Fresh mind = better retention

---

### Creating Cards (During Learning)

**Workflow**:
```
1. You're reading/learning something
2. You encounter important concept/gotcha
3. Immediately create Anki card
   - Question: "What's critical to remember?"
   - Answer: "The key insight"
   - Tags: Relevant categories
4. Continue learning
```

**Example** (while reading JWT docs):
```
Encounter: "JWT signature uses HMAC with secret key"

Create card immediately:
Q: How does JWT signature work?
A: HMAC (Hash-based Message Authentication Code) using secret key. Ensures token hasn't been tampered with.
Tags: #jwt #security #authentication
```

**Rule**: If it took you time to learn, it's worth a card.

---

### Post-Dev-Docs Card Creation (After Task)

**When you complete a task**:
```
1. Open your dev docs context file
2. Read Layer 3 (Critical Insights)
3. For each gotcha/pattern/breakthrough:
   - Create Anki card
4. File Layer 3 becomes permanent knowledge via SR
```

**Example** (after auth system task):
```
Layer 3 Gotcha: "CORS wildcard breaks HttpOnly cookies"

Create card:
Q: Why can't you use CORS wildcard (*) with credentials?
A: Breaks HttpOnly cookie security - browser won't send cookies with wildcard CORS. Must specify exact origin.
Tags: #cors #security #cookies #gotcha
```

---

### Weekly MOC Card Creation (During Review)

**During weekly review**:
```
1. Review your MOCs
2. Read "Wisdom Captured" section
3. Create cards for new insights
4. Update existing cards if understanding deepened
```

---

## Advanced Techniques

### Technique 1: Image Occlusion

**Use for**: Diagrams, architecture, visual patterns

**Process**:
1. Screenshot architecture diagram
2. Use Anki image occlusion add-on
3. Hide parts of diagram
4. Recall what's hidden

**Example**:
- Diagram of authentication flow
- Hide "JWT signature" step
- Q: "What happens after payload encoding?"
- A: (reveal) "JWT signature with HMAC"

---

### Technique 2: Progressive Elaboration

**Start simple, add detail over time**:

**Card v1** (Day 1):
```
Q: What is Correspondence principle?
A: "As above, so below" - structure mirrors values
```

**Card v1.1** (Month 1 - after using it):
```
Q: What is Correspondence principle?
A: "As above, so below"

Architecture reflects values.
Directory structure reveals priorities.
Code organization mirrors mental model.

Example: If your folders are messy, your thinking about the system is messy.
```

**Update cards** as understanding deepens.

---

### Technique 3: Context-Rich Tags

**Use tags for**:
- Technology: `#jwt #react #postgresql`
- Category: `#security #performance #architecture`
- Source: `#midnight-sun #floreser`
- Principle: `#mentalism #rhythm #correspondence`
- Difficulty: `#gotcha #easy #complex`

**Power**: Can review by tag
- "Show me all #gotcha cards" (review common mistakes)
- "Show me all #midnight-sun cards" (project-specific knowledge)
- "Show me all #security cards" (prepare for security review)

---

### Technique 4: Leech Detection

**Leeches** = Cards you keep getting wrong

**Anki marks cards as leeches** after multiple failures

**When you encounter a leech**:
1. **Don't delete it** - it's clearly important knowledge you struggle with
2. **Rewrite the card** - current formulation doesn't work for you
3. **Break it down** - might be too complex, split into multiple cards
4. **Add context** - might need more "why" explanation
5. **Add mnemonic** - create memory hook

**Example leech**:
```
Q: What's the difference between HS256 and RS256?
A: [Keep forgetting]

Rewrite as:
Q: What's the difference between HS256 and RS256 JWT signing?
A:
HS256 = HMAC with shared secret (symmetric)
- Same key signs and verifies
- Simpler, faster
- Both parties need secret

RS256 = RSA with private/public key (asymmetric)
- Private key signs, public key verifies
- More secure (public key can be shared)
- Slower

Mnemonic: "H for HMAC (same), R for RSA (different)"
```

---

## Integration with Hermetic Workflows

### With Progressive Summarization

**Layer 3 → Anki Pipeline**:
```
1. Create dev docs with 4-layer context
2. Layer 3 contains Critical Insights
3. After task completion:
   - Extract Layer 3 gotchas → Anki cards
   - Extract Layer 3 patterns → Anki cards
   - Extract Layer 3 breakthroughs → Anki cards
4. Knowledge preserved permanently via SR
```

**Result**: Never forget critical insights from tasks

---

### With MOCs

**MOC Wisdom → Anki Pipeline**:
```
1. Maintain MOCs with "Wisdom Captured" section
2. During weekly review:
   - Extract key insights → Anki cards
   - Extract lessons learned → Anki cards
   - Extract principles → Anki cards
3. MOC becomes source of permanent knowledge
```

**Result**: Your accumulated wisdom becomes unforgettable

---

### With Learning Sprints

**Active Learning → Anki Pipeline**:
```
1. You're learning new skill (in ~/Learning/Active/)
2. As you learn:
   - Create cards for key concepts
   - Create cards for gotchas encountered
   - Create cards for patterns discovered
3. After sprint completion:
   - Review progress journal
   - Extract critical knowledge → Anki cards
4. Move sprint to Completed with Anki deck tag
```

**Result**: Learning sprints create permanent knowledge, not temporary understanding

---

### With 6-Day Development Cycle

**Day 7 (Integration Day) → Anki Creation**:
```
Week's workflow:
- Day 1-6: Build
- Day 7: Integrate

On Day 7:
1. Review week's dev docs
2. Extract critical insights → Anki cards
3. Review week's learnings
4. Create cards for gotchas/patterns
5. Start new week with clean slate
```

**Result**: Every cycle compounds knowledge

---

## Metrics and Maintenance

### Healthy Anki Practice

**Daily targets**:
- ✅ 10-50 reviews/day (sustainable)
- ✅ 5-10 new cards/day (gradual growth)
- ✅ 80%+ correct rate (good retention)
- ✅ <15 minutes daily (efficient)

**Warning signs**:
- ❌ 100+ reviews/day (too many cards)
- ❌ <50% correct rate (cards too hard or poorly written)
- ❌ >30 minutes daily (unsustainable)
- ❌ Skipping days (breaks spaced repetition rhythm)

---

### Deck Maintenance

**Monthly review**:
```
1. Check leech cards (rewrite or delete)
2. Archive outdated cards (old technologies you no longer use)
3. Merge redundant cards
4. Update cards with deepened understanding
5. Suspend cards that are now obvious (too easy)
```

**Quarterly deep clean**:
```
1. Review entire deck structure
2. Reorganize tags
3. Delete truly obsolete cards
4. Add new sub-decks for new domains
5. Export deck (backup)
```

---

### Anki Statistics to Track

**Built-in stats**:
- Retention rate (aim for 80-90%)
- Average review time (aim for <30 sec/card)
- Cards due (should be manageable daily)
- New cards learned (cumulative knowledge)
- Mature cards (long-term retention)

**Review monthly**: Are patterns healthy?

---

## Common Mistakes

### Mistake 1: Creating too many cards

**Problem**: 1000+ cards, 200 reviews/day, unsustainable

**Solution**:
- Be selective - only critical knowledge
- Archive old technologies
- Merge redundant cards
- Aim for quality over quantity

---

### Mistake 2: Cards too complex

**Problem**: Cards with paragraph answers, can't recall

**Solution**:
- One concept per card (atomic)
- Break complex cards into 3-5 simpler ones
- Use cloze deletion for lists

---

### Mistake 3: No context in cards

**Problem**: "Q: What is JWT? A: JSON Web Token" (useless)

**Solution**: Add context - why it matters, when to use, gotchas

**Better**:
```
Q: What is JWT and when should you use it?
A: JSON Web Token - stateless auth token containing claims.

Use when:
- Stateless APIs (no server session)
- Microservices (shared auth)

Gotcha: Payload is base64, not encrypted (don't store secrets)
```

---

### Mistake 4: Skipping reviews

**Problem**: Break the rhythm, lose retention benefits

**Solution**:
- Morning ritual (before work)
- Even 5 minutes helps
- Mobile app for commute reviews
- Consistency > perfection

---

## Tools and Resources

### Anki Add-ons

**Essential**:
- **Image Occlusion Enhanced**: Hide parts of images
- **Hierarchical Tags**: Better tag organization
- **Advanced Browser**: Better card searching
- **Review Heatmap**: Visualize review consistency

**Coding-specific**:
- **Syntax Highlighting**: Code highlighting in cards
- **Power Format Pack**: Better formatting options

---

### Anki Alternatives

**SuperMemo**: Original spaced repetition software (complex UI)
**RemNote**: Outliner + SR (note-taking integrated)
**Mnemosyne**: Simpler than Anki (less features)

**Recommendation**: Stick with Anki (proven, free, customizable)

---

## Success Metrics

### You know SR is working when:

✅ Recall concepts months after learning
✅ Gotchas remembered (don't repeat mistakes)
✅ Commands memorized (no constant googling)
✅ Patterns internalized (apply automatically)
✅ Confidence increased (knowledge feels solid)
✅ Re-learning time reduced (forgot something, but review brings it back fast)

### Examples:

**Before SR**:
- "What was that JWT gotcha again?" (google for 10th time)
- "How many bcrypt rounds?" (look up every time)
- "Which Hermetic principle is that?" (can't remember)

**After SR**:
- "JWT payload is base64 not encrypted" (instant recall)
- "12 bcrypt rounds" (automatic)
- "That's Correspondence - structure mirrors values" (internalized)

---

## Summary

**Spaced Repetition = Permanent knowledge**

**Research-backed**: Ebbinghaus Forgetting Curve + SuperMemo algorithm

**Integrations**:
- Progressive Summarization Layer 3 → Anki cards
- MOC Wisdom → Anki cards
- Learning Sprint insights → Anki cards
- Dev Docs gotchas → Anki cards

**Daily practice**: 10-15 minutes, morning ritual

**Result**: Everything that matters, remembered forever.

---

**Hermetic Principle: Rhythm**

**"Consistency creates permanence. Daily review transforms temporary understanding into lasting wisdom."**

**May your knowledge endure. May your wisdom compound. May your cards serve your growth.**
