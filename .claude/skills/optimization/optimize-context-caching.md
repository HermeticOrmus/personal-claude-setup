---
name: optimize-context-caching
description: Structure prompts for optimal Claude API context caching
category: optimization
principle: Rhythm
---

# Optimize Context Caching - Minimize Cost & Latency

**Hermetic Principle**: Rhythm - "Cache what repeats, compute what changes"

**When to use**: Every Claude Code session, especially with large static contexts

---

## Quick Win (2 Minutes)

### The Cache Structure

```markdown
# STATIC BLOCK - CACHE THIS
{CLAUDE.md}
{Hermetic manifesto}
{Dev docs Layer 1-3}
{Skill definitions}

--- CACHE BOUNDARY ---

# DYNAMIC BLOCK - FRESH EACH TIME
{User query}
{Code context}
{Layer 4 if needed}
```

**Result**: 90% cost reduction, 85% latency reduction on cache hits.

---

## The 90/10 Rule

**90% of your context is static** (same every request):
- CLAUDE.md
- Hermetic principles
- Brand guide
- Dev docs Layer 1-3
- Architecture
- Skill/agent definitions

**10% is dynamic** (changes per request):
- User query
- Current file
- Git diff
- Layer 4 (raw chronicle)

**Optimization**: Front-load the 90%, cache it once, reuse 50+ times.

---

## Cache Economics

### Without Caching (Typical Session)

```
50 requests × 18K static tokens = 900K tokens
Cost: 900K × $3/1M = $2.70 per session
Latency: +2-3 seconds per request (processing static context)
```

### With Optimal Caching

```
Request 1: 18K tokens → Write to cache ($0.07)
Requests 2-50: 18K tokens → Read from cache (49 × $0.005 = $0.25)
Total: $0.32 per session

Savings: $2.38 per session (88%)
Latency: Instant on cache hits (85% faster)
```

---

## The Decision Tree

### Should I Cache This Content?

**✅ YES - Cache it:**
- CLAUDE.md (changes yearly)
- Hermetic manifesto (never changes)
- Brand guide (changes quarterly)
- Dev docs Layer 1-2 (changes monthly)
- Architecture diagrams (stable)
- Skill definitions (curated list)

**❌ NO - Keep dynamic:**
- User query (unique each time)
- Current file being edited (changes constantly)
- Git diff (current changes)
- Dev docs Layer 4 (raw chronicle, too volatile)
- Real-time data (API responses, logs)

**Rule**: If content is >80% the same across requests, cache it.

---

## Practical Workflows

### Workflow 1: Optimize Session Start

**Morning session initialization:**

```markdown
# Request 1 (Cache Creation)

## STATIC CONTEXT (18K tokens - cache this)

### Core Identity
{Full CLAUDE.md}

### Hermetic Foundation
{Manifesto: 7 principles}

### Development Context
{Dev docs Layer 1-3 from CONTEXT.md}

### Active Toolkit
{Skills being used today}
{Agents available today}

--- CACHE BOUNDARY ---

## DYNAMIC CONTEXT (2K tokens - fresh)

### Today's Task
I'm working on [feature] in [file]. Need guidance on [specific question].

### Current State
{Git diff of current changes}
```

**Result**:
- First request: Creates cache (18K tokens)
- Requests 2-50: Cache hits (instant, 90% cheaper)

---

### Workflow 2: Sprint-Aligned Caching

**Cache refresh ceremony (Saturday PM - Sprint Opening):**

```markdown
# Sprint N Cache Refresh

## Updated Static Context

### Sprint N Plan
[New sprint goals, success criteria]

### Updated Dev Docs Layer 3
[Insights from Sprint N-1, compacted]

### Architecture (if changed)
[Updated diagrams if major refactoring]

--- CACHE BOUNDARY ---

## First Task of Sprint N
[Start with fresh cache for new sprint]
```

**Benefit**: Cache aligned with sprint rhythm - refreshes weekly naturally.

---

### Workflow 3: Dev Docs Layer Caching Strategy

**Map layers to cache strategy:**

```markdown
## Cache Configuration

**Layer 1: Executive Summary (100 words)**
Cache: ✅ Always (architecture baseline)
TTL: Effectively permanent
Update: Only on major refactoring

**Layer 2: Key Insights (500 words)**
Cache: ✅ Always (accumulated wisdom)
TTL: 1 week (refresh during Sprint Harvest)
Update: Saturday Sprint Integration

**Layer 3: Critical Details (1500 words)**
Cache: ✅ Current sprint only
TTL: 1 day (active development)
Update: During /update-dev-docs

**Layer 4: Full Chronicle (15K words)**
Cache: ❌ Never (too dynamic, compacted often)
Usage: Load on-demand when deep context needed
```

**Implementation**:

```bash
# Session start: Cache Layer 1-3 (2K tokens)
# During session: Layer 4 loaded only if needed (rare)
# Sprint Harvest: Layer 2 updated, cache refreshes
```

---

### Workflow 4: Batch Queries for Cache Efficiency

**Bad** (cache churning):

```
[Request 1] Show authentication code
[5 min gap - cache expires]
[Request 2] Show payment code [Cache MISS - reprocess static context]
[5 min gap]
[Request 3] Show user profile code [Cache MISS again]
```

**Good** (cache maximization):

```
[Request 1] I need to review authentication, payment, and user profile code. Starting with authentication.
[Request 2 - 2 min later] Next, payment code. [Cache HIT]
[Request 3 - 2 min later] Finally, user profile. [Cache HIT]
```

**Principle**: Batch related work within 5-minute cache TTL window.

---

## Integration with Hermetic Systems

### 1. Knowledge Graph Caching

**Cache frequently accessed subgraphs:**

```markdown
## Cached Knowledge (3K tokens)

**Hermetic Principles**:
{7 principle entities + core relations}

**Active Technologies**:
{Current stack entities: PostgreSQL, React, TypeScript}

**Current Project**:
{Midnight-Sun entity + key relations}

**Top 20 Patterns & Gotchas**:
{Most queried entities from recent sessions}

--- CACHE BOUNDARY ---

## Dynamic Graph Query
{Specific search or node retrieval}
```

**Benefit**: Core knowledge instantly available, specific queries fast.

---

### 2. Multi-Agent Orchestration

**Cache agent definitions:**

```markdown
## STATIC AGENT ROSTER (5K tokens - cache)

{Backend Architect definition}
{Frontend Developer definition}
{Security Engineer definition}
{Test Writer definition}
{DevOps Automator definition}
{... all available agents}

--- CACHE BOUNDARY ---

## DYNAMIC DELEGATION
Task: [Specific task for specific agent]
Context: [Task-specific context]
```

**Benefit**: Agent capabilities always in context, only delegation details change.

---

## Monitoring & Optimization

### Weekly Cache Audit (5 Minutes)

```markdown
## Cache Performance - Week N

**Metrics** (estimate based on usage):
- Sessions this week: ~20
- Avg requests per session: ~50
- Cache hit rate (estimated): ~90% (45/50 requests)

**Token Analysis**:
- Static context size: 18K tokens
- Dynamic avg: 2K tokens per request
- Total cached tokens: 18K × 45 hits = 810K tokens
- Token savings: 810K tokens at cache read rate vs input rate

**Cost Analysis**:
- Without cache: 50 req × 18K static = 900K tokens × $3/1M = $2.70/session
- With cache: 1 write ($0.07) + 49 reads ($0.25) = $0.32/session
- Savings: $2.38 per session × 20 sessions = $47.60/week

**Actions**:
- ✅ Cache hit rate >85%: Optimal
- ⚠️ If <80%: Review static content stability
- ⚠️ If costs still high: Check output token usage (separate from cache)
```

---

### Cache Invalidation Events

**When to refresh cache (send updated context):**

```markdown
## Cache Refresh Triggers

**Immediate refresh needed**:
- ✅ Sprint boundary (new sprint context)
- ✅ CLAUDE.md updated (core instructions changed)
- ✅ Major refactoring (architecture fundamentally different)

**Let TTL handle naturally**:
- ❌ Minor code changes (don't affect static context)
- ❌ New feature added (existing context still valid)
- ❌ Typo fixes in docs

**How to refresh**:
1. Wait 5+ minutes (TTL expiry - automatic)
2. Send updated content in next request (auto-refreshes cache)
3. No manual invalidation needed (API manages it)
```

---

## Common Pitfalls

### Pitfall 1: Caching Dynamic Content

**Problem**:

```markdown
## STATIC BLOCK (Oops - caching dynamic stuff!)
{CLAUDE.md}
{Dev docs Layer 4 - full chronicle} ← Changes constantly!
{Current git diff} ← Unique every time!

--- CACHE BOUNDARY ---

## DYNAMIC
{User query}
```

**Result**: Cache constantly invalidated, no benefit.

**Fix**: Move dynamic content below cache boundary.

---

### Pitfall 2: Too Much Static Content

**Problem**:

```markdown
## STATIC BLOCK (50K tokens - overkill!)
{CLAUDE.md}
{Entire codebase} ← Way too much!
{Full git history} ← Not needed every request!
{All possible skills} ← Only need active subset!
```

**Result**: Cache write expensive, content mostly unused.

**Fix**: Cache only essential static context (10-20K tokens sweet spot).

---

### Pitfall 3: Ignoring Cache TTL

**Problem**:

```
Morning session: Create cache
[30 min of focused work]
Lunch break: 1 hour
Afternoon session: Cache expired, re-process
[Another 30 min]
Dinner break: 2 hours
Evening session: Cache expired again
```

**Result**: Multiple cache writes per day, reduced benefit.

**Solutions**:
- Keep session active during short breaks (periodic request)
- Accept cache misses after long breaks (still cheaper than no cache)
- Batch work to fit within TTL windows when possible

---

## Advanced Techniques

### Technique 1: Hierarchical Caching

**For complex projects:**

```markdown
## Level 1: Foundation (10K tokens, cache TTL: effectively permanent)
{CLAUDE.md}
{Hermetic manifesto}
{Brand guide}

## Level 2: Project Context (6K tokens, cache TTL: 1 week)
{Dev docs Layer 1-2}
{Architecture diagrams}

## Level 3: Sprint Context (2K tokens, cache TTL: 1 day)
{Dev docs Layer 3}
{Current sprint plan}

--- CACHE BOUNDARY ---

## Dynamic (variable tokens)
{User query}
{Current file}
```

**Benefit**: Multi-layered cache with appropriate refresh rates.

---

### Technique 2: Lazy Loading

**Cache index, load details on-demand:**

```markdown
## CACHED INDEX (500 tokens)

**Available Contexts**:
1. Hermetic Philosophy (3K) - /load hermetic
2. Brand Guidelines (2K) - /load brand
3. Full Dev Docs (15K) - /load devdocs
4. Knowledge Graph - /query graph [topic]

**Auto-Loaded**:
- Sprint N plan (1K)
- Active features (1K)

Total cached: 2.5K tokens

--- CACHE BOUNDARY ---

## Dynamic Query
[Specific request - loads additional context if needed]
```

**Benefit**: Minimal cache size, maximum flexibility.

---

## Quick Reference

### Optimal Cache Structure

```markdown
STATIC (Cache this):
- CLAUDE.md (5K)
- Manifesto (3K)
- Brand guide (2K)
- Dev docs Layer 1-3 (8K)
- Skills/agents (2K)
Total: ~20K tokens

--- BOUNDARY ---

DYNAMIC (Fresh):
- User query
- Code context
- Layer 4 (when needed)
Total: ~2K tokens
```

---

### Cache Economics Quick Math

```
Cache write:  $3.75/1M tokens (one-time, 1.25x input)
Cache read:   $0.30/1M tokens (repeating, 0.1x input)
No cache:     $3.00/1M tokens (every request, 1x)

50 requests with 18K static:
- No cache: 50 × 18K × $3/1M = $2.70
- With cache: (1 × $3.75 + 49 × $0.30) × 18/1000 = $0.32
- Savings: 88%
```

---

### When to Cache

✅ **Cache if**:
- Content >80% same across requests
- Size: 1K-50K tokens (sweet spot: 10-20K)
- Update frequency: <1x per day

❌ **Don't cache if**:
- Content unique per request
- Changes constantly (more than daily)
- Very large (>100K tokens - overkill)

---

### Monitoring Checklist

```markdown
Weekly:
- [ ] Cache hit rate >85%
- [ ] Static context size: 10-20K tokens
- [ ] Cost savings >80% vs no cache
- [ ] Review what's cached (still static?)
- [ ] Check for dynamic content in cache block
```

---

**Complete guide:** `.hermetic/docs/context-caching-guide.md`

**May your cache hit rates be high. May your costs be low. May your responses be instant.**
