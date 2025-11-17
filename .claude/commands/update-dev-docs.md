---
description: Update dev docs (context + tasks) before compaction to preserve state
---

# Update Development Documentation

You're about to **update the dev docs** to preserve the current state before context compaction.

This embodies the **Hermetic Principle of Rhythm** - maintaining continuity through deliberate documentation.

---

## Your Task

### 1. Locate Active Dev Docs

**Search for active dev docs**:
```bash
# Check project-specific location
~/projects/[current-project]/dev/active/

# Check general location
~/dev/active/
```

**Identify** which task directory to update based on:
- User's recent messages
- Files you've been editing
- Current work context

**If multiple tasks exist**: Ask user which one to update.

**If no dev docs exist**: Tell user to run `/dev-docs` first.

---

### 2. Update Context File (All 4 Layers)

**File**: `[task-name]-context.md`

**CRITICAL**: Update ALL 4 layers to maintain Progressive Summarization integrity.

#### Layer 4: Executive Summary (ALWAYS UPDATE)
```markdown
## 🔮 Layer 4: Executive Summary (Your Words)

**Essence**: Building JWT-based auth system with HttpOnly cookies. Critical choice: refresh tokens in DB, access tokens in memory. Currently implementing login endpoint.

**Critical Decision**: Refresh tokens stored in database (revocable), access tokens in-memory only (XSS protection)

**Current Focus**: POST /auth/login - implementing JWT generation and cookie handling

**Immediate Next**: Complete logout endpoint, then token refresh mechanism
```

**Why Layer 4 matters**: This is what you read first after compaction. Captures essence in YOUR words.

---

#### Layer 3: Critical Insights (UPDATE WHEN DISCOVERIES HAPPEN)
```markdown
## ⚡ Layer 3: Critical Insights (Highlighted)

**🎯 Key Patterns**:
- **HttpOnly Cookie Pattern**: Prevents XSS by storing refresh token in secure cookie
- **Dual Token Strategy**: Short-lived access (15min) + long-lived refresh (7 days)

**⚠️ Gotchas**:
- **Prisma migrations**: Schema changes need manual `prisma migrate dev` - auto-gen doesn't work
- **CORS with credentials**: Must set `credentials: 'include'` AND specific origin (not wildcard)

**💎 Breakthroughs**:
- **Token rotation**: Discovered refresh token rotation prevents session hijacking
```

**Why Layer 3 matters**: Quick-scan critical patterns and gotchas. Add new discoveries here IMMEDIATELY.

---

#### Layer 2: Important Details (BOLD NEW CRITICAL ITEMS)
```markdown
## 📋 Layer 2: Important Details (Bolded Emphasis)

### Key Files

#### `backend/auth/controller.ts`
**Role**: Handles authentication endpoints
**Key functions**:
- `login()` - **Validates credentials, generates JWT pair, sets HttpOnly cookie**
- `logout()` - Invalidates refresh token in database

**Patterns to follow**:
- **Always hash passwords with bcrypt (12 rounds minimum)** - Security requirement
- Return 401 for invalid credentials, not 404 (prevent user enumeration)

---

### Architecture Decisions

#### Decision 1: Token Storage Strategy
**Decision**: **Refresh tokens in PostgreSQL Session table, access tokens in-memory only**
**Rationale**: Enables token revocation while preventing XSS theft
**Impact**: **Requires database call on token refresh (acceptable latency trade-off for security)**
**Date**: 2025-01-04
```

**Why Layer 2 matters**: Bolded items surface critical behaviors. Update when new critical patterns emerge.

---

#### Layer 1: Full Context (KEEP COMPREHENSIVE)
Update the detailed sections in Layer 1:

**Current State** (detailed progress):
```markdown
### Current State

**Completed phases**:
- ✅ Phase 1: Database Schema - 2025-01-04
  - User table with email, passwordHash fields
  - Session table with userId, refreshToken, expiresAt
  - Unique constraint on User.email
  - Migration applied successfully

**Current phase**:
- 🔄 Phase 2: Backend API Endpoints - Started 2025-01-04
  - Current task: Implementing POST /auth/login
  - Current file being edited: `backend/auth/controller.ts`
  - Current line of work: JWT generation logic (lines 45-78)
  - Progress: 80% complete (missing error handling)

**Next phase**:
- ⏭️ Phase 3: Frontend Integration
  - Prerequisites: Login/logout/refresh endpoints complete
  - Estimated start: 2025-01-05
```

**Detailed Notes & Learnings**:
```markdown
### Detailed Notes & Learnings

**Discoveries during implementation**:
- **JWT token expiry research**: Investigated OWASP recommendations, settled on 15min access + 7-day refresh
  - How discovered: Hit rate-limiting issues with 5min tokens
  - Impact: Reduced API calls by 3x while maintaining security
  - Action taken: Updated token config, documented in .env.example

**Gotchas and workarounds**:
- **Prisma migration gotcha**: `prisma db push` doesn't create migration files
  - Why it happens: db push is for prototyping only
  - How to detect: Check `prisma/migrations/` directory
  - How to fix: Always use `prisma migrate dev --name description`
  - Prevention: Added to project README

**Security considerations**:
- **Password hashing**: Using bcrypt with 12 rounds (OWASP recommendation)
  - Threat model: Rainbow table attacks, brute force
  - Mitigation: Salted hashing with computationally expensive algorithm
```

**Why Layer 1 matters**: Complete detailed history. Never delete from Layer 1, only add.

---

#### Last Updated (ALL LAYERS)
**CRITICAL**: Update the timestamp at the very top!
```markdown
**Last Updated**: 2025-01-04 18:45
```

---

### 3. Update Tasks File

**File**: `[task-name]-tasks.md`

**Mark completed tasks**:
```markdown
## Phase 1: Database Schema

- [x] Create User table with email, password_hash fields
- [x] Add unique constraint on email column
- [x] Create Session table for JWT refresh tokens
- [x] Write Prisma migration

**Phase complete when**: All migrations run successfully ✅ COMPLETE
```

**Add newly discovered tasks**:
```markdown
## Added Tasks (discovered during work):

- [ ] Add password reset token field to User table
- [ ] Create index on session.userId for faster lookups
- [ ] Add email verification flow
```

**Update progress counter**:
```markdown
**Progress**: 8/15 tasks complete (53%)
```

**Update timestamp**:
```markdown
**Last Updated**: 2025-01-04 18:45
```

---

### 4. Add Critical Context

If you discovered **important files, patterns, or decisions** while working, add them to the context file:

#### New Key File
```markdown
### `backend/middleware/auth-middleware.ts`
**Role**: Validates JWT tokens on protected routes
**Key functions**:
- `verifyToken()` - Decodes and validates JWT
- `attachUser()` - Adds user object to request

**Patterns to follow**:
- Always check token expiry
- Return 401 for invalid/expired tokens
- Use async/await for database lookups
```

#### New Architecture Decision
```markdown
### Decision 3: Token Storage Strategy
**Decision**: Access tokens in-memory, refresh tokens in database
**Rationale**: Prevents XSS attacks while enabling token revocation
**Alternatives considered**: Both in DB (slower), both in memory (can't revoke)
**Date**: 2025-01-04
```

---

### 5. Preserve Important State

**Ask yourself**: If context gets compacted right now, what would I need to remember?

**Include**:
- Files currently being edited
- Patterns discovered
- Decisions made
- Blockers encountered
- Dependencies identified
- Next immediate steps

**Example**:
```markdown
## Current State

**Files being edited**:
- `backend/auth/controller.ts` - Login endpoint 80% complete
- `backend/middleware/auth.ts` - Token validation done
- `database/schema.prisma` - User/Session tables finalized

**Current blocker**:
- Need to research JWT refresh token rotation best practices
- Considering short-lived access tokens (15min) vs long-lived (24hr)

**Next immediate task**:
- Complete login endpoint implementation
- Test with Postman
- Handle error cases (wrong password, user not found)
```

---

### 6. Verify Completeness

**Before finishing, check**:
- ✅ Context file updated with current state
- ✅ Context file has new learnings/discoveries
- ✅ Tasks file shows correct completion status
- ✅ New tasks added if discovered
- ✅ Both files have current timestamps
- ✅ Enough detail to resume after compaction

---

### 7. Confirm with User

**Output to user**:
```
✅ Dev docs updated successfully!

**Updated**:
- [task-name]-context.md
  - Current state: Phase 2 in progress
  - Added 3 new learnings
  - Documented JWT token strategy
  - Last Updated: 2025-01-04 18:45

- [task-name]-tasks.md
  - Marked 8/15 tasks complete (53%)
  - Added 3 newly discovered tasks
  - Updated progress counter
  - Last Updated: 2025-01-04 18:45

**Status**: Ready for compaction

**After compaction**: Simply say "continue" and I'll read the updated dev docs to resume exactly where we left off.

**Hermetic Principle: Rhythm**
"Context preserved. Momentum maintained. Work continues."
```

---

## Important Guidelines

### ✅ DO:
- Be thorough with current state
- Include specific file paths being worked on
- Document learnings and discoveries
- Mark completed tasks immediately
- Add blockers if any exist
- Update timestamps
- Capture "next immediate steps"

### ❌ DON'T:
- Leave timestamps unchanged
- Mark tasks complete that aren't done
- Skip documenting important discoveries
- Use vague descriptions ("working on stuff")
- Forget to update progress counter
- Leave out context about current work

---

## What Makes a Good Update

**Good Context Update**:
```markdown
## Current State

**What's done**:
- ✅ Login endpoint complete with JWT generation
- ✅ Password validation using bcrypt
- ✅ Refresh token stored in Session table

**What's in progress**:
- 🔄 Logout endpoint (85% complete)
- Currently: Invalidating refresh token in database
- Next: Clear HttpOnly cookie
- Then: Return 200 OK response

**Next steps**:
- Test logout flow
- Implement token refresh endpoint
- Add rate limiting to auth endpoints
```

**Bad Context Update**:
```markdown
## Current State

**What's done**:
- Some stuff

**What's in progress**:
- Working on it
```

---

## Hermetic Principles Applied

**Mentalism**: Clear documentation of current mental state
**Rhythm**: Preserving momentum across session breaks
**Cause-Effect**: Tracking decisions and their impacts
**Correspondence**: File state mirrors implementation state

---

**May your context be preserved. May your work continue seamlessly. May compaction be conquered.**

**Now update the dev docs and confirm with the user.**
