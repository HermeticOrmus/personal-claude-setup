# Progressive Summarization Guide

**Principle**: "Information flows from comprehensive (bottom) to essence (top)"

**Integration**: Tiago Forte's technique applied to Hermetic dev docs system

---

## What is Progressive Summarization?

**Core Idea**: Compress information in layers without losing detail. Each layer summarizes the layer below it.

**Origin**: Developed by Tiago Forte (Building a Second Brain) as solution to:
- Information overload
- Re-reading entire documents to find key insights
- Loss of context over time

**Hermetic Application**: Perfect for dev docs that must survive context compaction.

---

## The 4-Layer System

### Layer 1: Full Context (Bottom - Most Detailed)

**What**: Complete, comprehensive information
**Purpose**: Permanent record of all details
**Rule**: NEVER delete from Layer 1, only add
**When to read**: When you need specific implementation details

**Example**:
```markdown
### Detailed Architecture Decisions

#### Decision 1: Token Storage Strategy
**Decision**: Refresh tokens stored in PostgreSQL Session table with userId foreign key, accessToken field, and expiresAt timestamp. Access tokens never persisted, generated fresh on each request validation.
**Rationale**:
  - Reason 1: Database storage enables token revocation (logout, security breach response)
  - Reason 2: PostgreSQL ACID guarantees prevent race conditions in token validation
  - Reason 3: In-memory access tokens reduce DB load (no storage on every request)
  - Reason 4: HttpOnly cookies prevent XSS token theft
**Alternatives considered**:
  - Alternative A: Both tokens in database - Rejected: Too much DB load (every API request hits DB)
  - Alternative B: Both tokens in-memory - Rejected: Can't revoke sessions remotely
  - Alternative C: Redis for session storage - Rejected: Additional infrastructure complexity
**Trade-offs accepted**:
  - Trade-off 1: Refresh endpoint requires DB call (acceptable: only once per 15min)
  - Trade-off 2: Requires database migration for Session table
**Impact**: Balances security (revocable) with performance (minimal DB load)
**References**:
  - OWASP Token Storage Best Practices
  - RFC 6749 (OAuth 2.0) Section 1.5
**Date**: 2025-01-04
```

---

### Layer 2: Important Details (Bolded Emphasis)

**What**: Layer 1 content with **critical items bolded**
**Purpose**: Highlight what matters most when skimming
**Rule**: Bold the core choices, critical behaviors, must-know items
**When to read**: When you need to refresh on important patterns

**Example** (same decision, Layer 2):
```markdown
### Architecture Decisions

#### Decision 1: Token Storage Strategy
**Decision**: **Refresh tokens in PostgreSQL Session table, access tokens in-memory only**
**Rationale**: Enables token revocation while preventing XSS theft
**Alternatives considered**: Both in DB (too slow), both in memory (can't revoke), Redis (too complex)
**Impact**: **Requires database call on token refresh (acceptable latency trade-off for security)**
**Date**: 2025-01-04
```

**Notice**: Condensed, but bolding surfaces the critical choice instantly.

---

### Layer 3: Critical Insights (Highlighted)

**What**: Extracted key patterns, gotchas, breakthroughs
**Purpose**: Quick-scan reminders of critical knowledge
**Rule**: Add immediately when discoveries happen
**When to read**: Second thing after Layer 4, to remember critical patterns

**Example** (same decision, Layer 3):
```markdown
## ⚡ Layer 3: Critical Insights

**🎯 Key Patterns**:
- **Dual Token Strategy**: Short-lived access (15min) + long-lived refresh (7 days) in DB

**⚠️ Gotchas**:
- **CORS with credentials**: Must set specific origin, wildcard breaks HttpOnly cookies

**💎 Breakthroughs**:
- **Token rotation**: Refresh token rotation on use prevents session hijacking
```

**Notice**: Only the insights that change how you work.

---

### Layer 4: Executive Summary (Top - Most Compressed)

**What**: Essence in YOUR words (2-3 sentences), critical decision, current focus
**Purpose**: Instant orientation after compaction (30 seconds)
**Rule**: Update EVERY time you work on the task
**When to read**: FIRST thing when resuming work

**Example** (same decision, Layer 4):
```markdown
## 🔮 Layer 4: Executive Summary

**Essence**: Building JWT auth with HttpOnly cookies. Critical choice: refresh tokens in DB (revocable), access tokens in memory (XSS-proof). Currently on login endpoint.

**Critical Decision**: Dual token strategy - database persistence for revocation, in-memory for performance

**Current Focus**: POST /auth/login - JWT generation and cookie handling

**Immediate Next**: Logout endpoint, then token refresh mechanism
```

**Notice**: You know exactly what's happening, what was decided, and what's next - in 30 seconds.

---

## How to Read (Bottom-Up Creation, Top-Down Reading)

### When Creating Dev Docs:
1. Write Layer 1 first (full comprehensive detail)
2. Bold critical items in Layer 2 (emphasize what matters)
3. Extract Layer 3 insights (patterns, gotchas, breakthroughs)
4. Compress to Layer 4 summary (essence in your words)

**Flow**: Comprehensive → Emphasized → Extracted → Compressed

---

### When Resuming Work (After Compaction):
1. Read Layer 4 (30 sec) - Get oriented: what is this, what was decided, what's current
2. Scan Layer 3 (1-2 min) - Remember: key patterns, critical gotchas, major breakthroughs
3. Skim Layer 2 (3-5 min) - Refresh: bolded critical behaviors and decisions
4. Reference Layer 1 (as needed) - Deep dive: when you need specific implementation details

**Flow**: Essence → Insights → Important → Complete

---

## Updating Guidelines

### Layer 4: Update EVERY time
**When**: Every work session, even if just 30 minutes
**What to update**:
- Essence: Rewrite in your current mental model
- Critical Decision: Change if decision evolved
- Current Focus: Always reflects what you're actively working on
- Immediate Next: Always the next action

**Example update**:
```markdown
Before (yesterday):
**Current Focus**: POST /auth/login - JWT generation

After (today):
**Current Focus**: POST /auth/logout - invalidating refresh tokens in database
```

---

### Layer 3: Update when discoveries happen
**When**: You discover a pattern, hit a gotcha, or have a breakthrough
**What to add**:
- New pattern that you'll use repeatedly
- Gotcha that cost you time (save future self)
- Breakthrough that changed approach

**Example addition**:
```markdown
**💎 Breakthroughs**:
- **Refresh token rotation**: Discovered that rotating refresh token on each use prevents session hijacking attacks (attacker's stolen token becomes invalid after victim's next refresh)
```

---

### Layer 2: Bold new critical items
**When**: You add new files, decisions, or patterns to Layer 1
**What to bold**:
- Core architectural choices
- Critical security behaviors
- Must-follow patterns
- Performance-critical code paths

**Example**:
```markdown
#### `backend/middleware/auth.ts`
**Key functions**:
- `verifyAccessToken()` - **Validates JWT signature, checks expiry, returns userId**
```

---

### Layer 1: Never delete, always add
**When**: Any new information discovered
**What to add**:
- New files and their complete roles
- Detailed decisions with full rationale
- Complete patterns with examples
- All integration details
- Full gotcha explanations with root causes

**Rule**: Layer 1 is the permanent record. It grows but never shrinks.

---

## Integration with Dev Docs System

### `/dev-docs` Command
Creates new dev docs with all 4 layers pre-structured:
```bash
/dev-docs
```

**Creates**:
1. `[task-name]-plan.md` - Implementation plan (not layered)
2. `[task-name]-context.md` - **4-layer Progressive Summarization structure**
3. `[task-name]-tasks.md` - Task checklist (not layered)

---

### `/update-dev-docs` Command
Updates all 4 layers before compaction:
```bash
/update-dev-docs
```

**Updates**:
1. Layer 4 - Current essence, focus, and next steps
2. Layer 3 - New patterns, gotchas, breakthroughs discovered
3. Layer 2 - Bolds new critical items in existing sections
4. Layer 1 - Adds complete new information
5. Timestamp - Updates "Last Updated" at top

---

## Benefits for Hermetic Development

### Hermetic Principle: Correspondence
"As above, so below. As the summary, so the detail."

**Layer 4** (above) corresponds to **Layer 1** (below). Same information, different compressions.

**Structure mirrors cognition**:
- Layer 4 = Executive function (strategic overview)
- Layer 3 = Pattern recognition (critical insights)
- Layer 2 = Focused attention (important details)
- Layer 1 = Deep storage (comprehensive memory)

---

### Hermetic Principle: Rhythm
"Sustainable documentation across cycles"

**Progressive Summarization prevents burnout**:
- Don't re-read entire docs every time
- Layer 4 gives instant context (30 sec vs 30 min)
- Preserves momentum across compaction boundaries

**Daily rhythm**:
- Start session: Read Layer 4 (orient)
- During session: Update Layer 3 when discoveries happen
- End session: Update Layer 4 + timestamp

---

### Hermetic Principle: Polarity
"Balance detail with brevity"

**Avoids extremes**:
- Too detailed: Can't find anything, overwhelmed
- Too brief: Missing critical context, reinvent wheel

**Progressive Summarization balances**:
- Comprehensive detail (Layer 1) ↔ Essential brevity (Layer 4)
- Permanent record ↔ Quick reference
- Deep knowledge ↔ Rapid recall

---

## Common Mistakes

### ❌ Mistake 1: Only updating Layer 4
**Problem**: Loses comprehensive detail, can't reference full context later
**Fix**: Always maintain all 4 layers. Update L4 every time, L3 when discoveries happen, L2 when critical items emerge, L1 continuously.

---

### ❌ Mistake 2: Deleting from Layer 1
**Problem**: Loses historical context, can't understand why decisions were made
**Fix**: Layer 1 is append-only. Mark items as outdated if needed, but never delete.

**Good**:
```markdown
### Detailed Architecture Decisions

#### Decision 1: Token Storage Strategy (OUTDATED - see Decision 4)
...original decision...

#### Decision 4: Revised Token Storage Strategy
**Supersedes**: Decision 1
**Why changed**: Discovered Redis is already in production stack
...new decision...
```

---

### ❌ Mistake 3: Writing Layer 4 in technical jargon
**Problem**: Doesn't serve its purpose (instant orientation)
**Fix**: Write Layer 4 in YOUR words, how you'd explain it to yourself. Natural language.

**Bad**:
```markdown
**Essence**: Implementing OAuth 2.0 token-based authentication mechanism utilizing JWT with RS256 asymmetric encryption and refresh token rotation per RFC 6749 specifications.
```

**Good**:
```markdown
**Essence**: Building login system with two types of tokens - one short-lived (15min) in memory, one long-lived (7 days) in database. Can log users out remotely.
```

---

### ❌ Mistake 4: Not bolding in Layer 2
**Problem**: Layer 2 looks identical to Layer 1, defeats the purpose
**Fix**: Aggressively bold the critical 20% - the things that matter most.

**Bad** (no bolding):
```markdown
#### Decision 1: Token Storage
**Decision**: Refresh tokens in database, access tokens in memory
```

**Good** (critical choice bolded):
```markdown
#### Decision 1: Token Storage
**Decision**: **Refresh tokens in database (revocable), access tokens in-memory only (XSS-proof)**
```

---

### ❌ Mistake 5: Layer 3 is just a bullet list
**Problem**: No visual distinction between patterns, gotchas, and breakthroughs
**Fix**: Use emoji categories to make scanning instant.

**Bad**:
```markdown
## Layer 3: Critical Insights
- Dual token pattern
- CORS needs specific origin
- Token rotation prevents hijacking
```

**Good**:
```markdown
## ⚡ Layer 3: Critical Insights

**🎯 Key Patterns**:
- **Dual token pattern**: Short access + long refresh

**⚠️ Gotchas**:
- **CORS**: Must use specific origin, not wildcard

**💎 Breakthroughs**:
- **Token rotation**: Prevents session hijacking
```

---

## Examples: Good vs Bad

### Bad Progressive Summarization

**Problems**:
- Layer 4 too vague ("working on auth")
- Layer 3 missing gotchas and breakthroughs
- Layer 2 has no bolding
- Layer 1 incomplete

```markdown
## Layer 4: Summary
Working on authentication.

## Layer 3: Insights
- Using JWT
- Database for sessions

## Layer 2: Details
Using JWT tokens for authentication with database session storage.

## Layer 1: Full Context
Implementation in progress.
```

**If you saw this after compaction**: You'd have NO idea what decisions were made, what's current, or what's next.

---

### Good Progressive Summarization

**Strengths**:
- Layer 4 captures essence in natural language
- Layer 3 categorizes insights clearly
- Layer 2 bolds critical behaviors
- Layer 1 comprehensive and detailed

```markdown
## 🔮 Layer 4: Executive Summary

**Essence**: Building JWT login system where users get two tokens - 15min access token (in memory, can't be stolen via XSS) and 7-day refresh token (in database, can be revoked remotely).

**Critical Decision**: Dual token strategy - database for revocation capability, in-memory for XSS protection

**Current Focus**: POST /auth/login - generating JWT pair and setting HttpOnly cookie

**Immediate Next**: Implement logout (invalidate refresh token in DB), then token refresh endpoint

---

## ⚡ Layer 3: Critical Insights

**🎯 Key Patterns**:
- **Dual Token Strategy**: Access (short, in-memory) + Refresh (long, in-DB) balances security and performance
- **HttpOnly Cookies**: Storing refresh token in HttpOnly cookie prevents XSS attacks

**⚠️ Gotchas**:
- **CORS with credentials**: Must set specific origin (`http://localhost:3000`), wildcard (`*`) breaks HttpOnly cookies
- **Prisma migrations**: `prisma db push` doesn't create migration files - always use `prisma migrate dev`

**💎 Breakthroughs**:
- **Refresh token rotation**: Rotating refresh token on each use prevents session hijacking (stolen token invalidated after victim's next refresh)
- **Password timing attacks**: Using `bcrypt.compare()` prevents timing attacks better than manual comparison

---

## 📋 Layer 2: Important Details

### Key Files

#### `backend/auth/controller.ts`
**Role**: Handles authentication endpoints
**Key functions**:
- `login()` - **Validates credentials with bcrypt, generates JWT pair, sets HttpOnly cookie, stores refresh token in DB**
- `logout()` - **Finds session by refresh token, deletes from DB, clears cookie**
- `refresh()` - Validates refresh token, generates new access token

**Patterns to follow**:
- **Always hash passwords with bcrypt.hash() using 12 rounds** - OWASP recommendation
- Return 401 for invalid credentials, not 404 (prevents user enumeration)
- **Use constant-time comparison for tokens** - prevents timing attacks

---

### Architecture Decisions

#### Decision 1: Token Storage Strategy
**Decision**: **Refresh tokens in PostgreSQL Session table (id, userId, refreshToken, expiresAt), access tokens never persisted**
**Rationale**: Database enables revocation (logout, security breach), in-memory reduces load
**Impact**: **Token refresh requires single DB query (SELECT + UPDATE) - acceptable <50ms latency**
**Date**: 2025-01-04

---

## 📚 Layer 1: Full Context

### All Files and Roles

#### `backend/auth/controller.ts`
**Role**: HTTP request handlers for authentication endpoints - login, logout, refresh, verify
**Key functions**:
- `login(req, res)` -
  - Validates email format with regex
  - Queries User table for account by email
  - Returns 401 if not found (prevents enumeration)
  - Compares password using `bcrypt.compare(input, hash)` (constant-time, prevents timing attacks)
  - Returns 401 if password mismatch
  - Generates access token: `jwt.sign({ userId }, ACCESS_SECRET, { expiresIn: '15m' })`
  - Generates refresh token: `jwt.sign({ userId }, REFRESH_SECRET, { expiresIn: '7d' })`
  - Stores refresh token in Session table: `INSERT INTO sessions (userId, refreshToken, expiresAt) VALUES (?, ?, ?)`
  - Sets HttpOnly cookie: `res.cookie('refreshToken', token, { httpOnly: true, secure: true, sameSite: 'strict' })`
  - Returns access token in response body: `{ accessToken }`
- `logout(req, res)` -
  - Extracts refresh token from cookie: `req.cookies.refreshToken`
  - Queries Session table: `DELETE FROM sessions WHERE refreshToken = ?`
  - Clears cookie: `res.clearCookie('refreshToken')`
  - Returns 200 OK
- `refresh(req, res)` -
  - Extracts refresh token from cookie
  - Verifies JWT signature: `jwt.verify(token, REFRESH_SECRET)`
  - Queries Session table to ensure not revoked
  - Generates new access token
  - (Optional) Rotates refresh token for enhanced security
  - Returns new access token

**Patterns to follow**:
- Password hashing: `bcrypt.hash(password, 12)` - 12 rounds per OWASP
- Token generation: Use crypto-random secrets (32+ bytes)
- Error responses: Generic messages (don't leak info: "Invalid credentials" not "User not found")
- Cookie settings: `httpOnly: true` (XSS), `secure: true` (HTTPS only), `sameSite: 'strict'` (CSRF)
- Database queries: Always use parameterized queries (SQL injection prevention)

**Testing approach**:
- Unit tests: Mock database, verify bcrypt called correctly, verify JWT structure
- Integration tests: Real database (test DB), verify cookie set correctly, verify session stored
- Security tests: Attempt timing attacks, XSS attempts, CSRF attempts

---

[...continues with complete detail for all files, decisions, patterns, integration points, environment, dependencies, state, notes...]
```

**If you saw this after compaction**: You know everything - essence (30 sec), patterns (2 min), details (5 min), or can deep-dive Layer 1.

---

## Summary

**Progressive Summarization transforms dev docs from "must re-read everything" to "instant context recovery".**

**4 Layers**:
- **Layer 4**: Essence (30 sec orientation)
- **Layer 3**: Insights (patterns, gotchas, breakthroughs)
- **Layer 2**: Important (bolded critical items)
- **Layer 1**: Complete (permanent comprehensive record)

**Read top-down** (L4 → L3 → L2 → L1) for speed.
**Write bottom-up** (L1 → L2 → L3 → L4) for compression.

**Update rhythm**:
- L4: Every session
- L3: When discoveries happen
- L2: When critical items emerge
- L1: Continuously (never delete)

**Result**: Context survives compaction. Work flows across sessions. Knowledge compounds.

---

**Hermetic Truth**: "Wisdom compressed is wisdom preserved."

**May your layers compress without loss. May your context survive all cycles. May your knowledge flow.**
