# Context Caching Optimization - Maximize Claude Performance

**Principle**: "Cache what repeats, compute what changes"

**What is context caching**: Claude API feature that caches portions of prompts to reduce cost and latency

**Why optimize caching**: 90% cost reduction and 85% latency reduction for repeated contexts

---

## The Problem: Redundant Context Processing

### Without Caching

**Scenario**: Daily dev sessions with Claude Code

**Every request includes**:
- CLAUDE.md (5,000 tokens)
- Hermetic manifesto (3,000 tokens)
- Dev docs Layer 1-3 (8,000 tokens)
- Skill definitions (2,000 tokens)
- **Total static context**: 18,000 tokens

**Every session**:
- 50 requests × 18,000 tokens = 900,000 tokens processed
- All redundant (same context every time)
- Cost: ~$11/session (input tokens)
- Latency: +2-3 seconds per request (processing static context)

---

### With Optimal Caching

**Same scenario with caching**:

**First request**:
- Process 18,000 tokens (static context)
- Cache for 5 minutes
- Cost: ~$0.22 (one-time cache creation)

**Remaining 49 requests**:
- Cache hit (18,000 tokens reused)
- Only process dynamic content (user queries)
- Cost: ~$0.55 (cache read cost is 10% of input cost)
- Latency: Instant (no static context processing)

**Total session cost**: $0.77 vs $11 (**93% savings**)
**Total latency**: Reduced by **85%** (cache hits instant)

---

## Quick Concept

**Problem**: Sending same context repeatedly wastes tokens and time

**Solution**: Cache static portions, only send what changes

**Result**: 90% cost reduction, 85% latency reduction, identical quality

---

## How Context Caching Works

### Cache Lifecycle

```
Request 1:
  Static context (18K tokens) → Process + Cache → Cache stored (5 min TTL)
  Dynamic content (500 tokens) → Process normally

Request 2 (within 5 min):
  Static context → Cache HIT → Instant retrieval (90% cost reduction)
  Dynamic content → Process normally

Request 3 (after 5+ min):
  Static context → Cache MISS → Process + Re-cache
  Dynamic content → Process normally
```

**Key insight**: Cache is session-scoped with 5-minute TTL (automatically managed by Claude API)

---

### Cache Economics

**Cost structure** (Claude 3.5 Sonnet):

| Token Type | Cost per 1M tokens | Multiplier |
|------------|-------------------|-----------|
| Input (no cache) | $3.00 | 1x |
| Cache write | $3.75 | 1.25x (one-time) |
| Cache read | $0.30 | 0.1x (90% savings) |
| Output | $15.00 | 5x |

**Example calculation**:

**Without cache** (50 requests × 18K static tokens):
- Input cost: 900K tokens × $3/1M = $2.70
- Over 100 sessions: $270

**With cache** (50 requests, first creates cache, rest read):
- Cache write: 18K × $3.75/1M = $0.07
- Cache reads: 49 × 18K × $0.30/1M = $0.26
- Total: $0.33 per session
- Over 100 sessions: $33

**Savings**: $237 (87% reduction)

---

## Caching Strategies

### Strategy 1: Front-Load Static Content

**Bad structure** (no caching benefit):

```
User query (dynamic)
→ Dev docs (static)
→ CLAUDE.md (static)
→ Code context (dynamic)
```

Cache boundary can only form at end (minimal benefit).

---

**Good structure** (optimal caching):

```
CLAUDE.md (static) ────────┐
Manifesto (static)         │ Cacheable block
Dev docs Layer 1-3 (static)│ (18K tokens)
Skill definitions (static) ┘
─────────────────────────── Cache boundary
User query (dynamic)
Code context (dynamic)
```

Cache forms at boundary, entire static block cached.

**Implementation**:

```markdown
# In Claude Code session initialization

## Static Context (CACHE THIS)
{CLAUDE.md content}
{Manifesto content}
{Dev docs Layer 1-3}
{Active skill definitions}

## Dynamic Context (DON'T CACHE)
{User query}
{Current file contents}
{Recent changes}
```

**Result**: 18K tokens cached, only dynamic content processed per request.

---

### Strategy 2: Hierarchical Caching

**For large projects with multiple contexts:**

```
Level 1: Project-wide (rarely changes)
  - CLAUDE.md (5K tokens)
  - Hermetic manifesto (3K tokens)
  - Brand guide (2K tokens)
  Total: 10K tokens, cache TTL: 1 hour

Level 2: Feature-specific (changes weekly)
  - Dev docs Layer 1-2 (5K tokens)
  - Architecture diagrams (1K tokens)
  Total: 6K tokens, cache TTL: 30 min

Level 3: Session-specific (changes per session)
  - Dev docs Layer 3-4 (current sprint) (2K tokens)
  - Active file context (variable)
  Total: 2K+ tokens, cache TTL: 5 min

Dynamic: Per-request
  - User query
  - Code changes
```

**Benefit**: Multiple cache layers, each with appropriate TTL.

---

### Strategy 3: Cache Invalidation Strategy

**When to invalidate cache** (send updated context):

**Invalidate immediately:**
- ✅ CLAUDE.md updated (core instructions changed)
- ✅ Major refactoring (architecture fundamentally different)
- ✅ New sprint started (dev docs Layer 3-4 reset)

**Don't invalidate (let TTL expire naturally):**
- ❌ Minor code changes (don't affect static context)
- ❌ New feature added (doesn't change existing docs)
- ❌ Typo fixes in docs

**Implementation**:

```bash
# Explicit cache invalidation
# Method 1: Wait 5+ minutes (automatic TTL expiry)

# Method 2: Modify static content slightly
# (Forces re-cache on next request)
echo "<!-- Cache bust: $(date) -->" >> CLAUDE.md
```

**Note**: Claude API manages cache automatically. You don't manually invalidate - just send updated context when needed.

---

## Integration with Hermetic Systems

### 1. Session Initialization

**Optimal prompt structure for Claude Code sessions:**

```markdown
# STATIC CONTEXT - CACHE THIS BLOCK

## Identity & Philosophy
{Contents of C:\Users\ormus\CLAUDE.md}

## Hermetic Principles
{Contents of .hermetic/manifesto.md}

## Brand Guidelines
{Contents of .hermetic/brand/brand-guide-complete.md}

## Development Context (Layer 1-3)
{Contents of dev/CONTEXT.md - Layers 1-3 only}

## Active Skills
{List of skill definitions for current work}

## Active Agents
{List of agent definitions for current work}

--- CACHE BOUNDARY ---

# DYNAMIC CONTEXT - PROCESS FRESH

## Current Task
{User's immediate request}

## Relevant Files
{Only files being modified this session}

## Recent Changes
{Git diff for context}
```

**Result**: ~20K tokens cached (static), only 2-5K dynamic per request.

---

### 2. Sprint-Based Caching

**Cache strategy aligned with 6-day sprint cycle:**

**Sprint Opening (Saturday PM)**:
```markdown
# Cache Structure for Sprint N

## Static (Cache TTL: 1 week)
- CLAUDE.md
- Hermetic manifesto
- Brand guide
- Dev docs Layer 1-2 (architectural foundation)

## Sprint-Scoped (Cache TTL: 1 day)
- Sprint goal and plan
- Dev docs Layer 3 (current insights)
- Active feature branch context

## Session-Scoped (Cache TTL: 5 min)
- Dev docs Layer 4 (raw chronological)
- Current file being edited
```

**Benefit**: Cache refreshes naturally with sprint rhythm.

---

### 3. Dev Docs Layer Caching

**Map dev docs layers to cache strategy:**

```markdown
## Layer 1: Executive Summary (100 words)
Cache TTL: ∞ (effectively permanent - architecture rarely changes)
Update: Only on major refactoring

## Layer 2: Key Insights (500 words)
Cache TTL: 1 week (insights accumulate slowly)
Update: During Sprint Harvest

## Layer 3: Critical Details (1500 words)
Cache TTL: 1 day (changes during sprint)
Update: During /update-dev-docs

## Layer 4: Full Chronicle (15K words)
Cache TTL: Never cache (always fresh, compacted often)
Usage: Read on-demand, not in every request
```

**Workflow**:

```bash
# Daily session start
# Cache: Layer 1 + 2 + 3 (total ~2K tokens)
# Dynamic: Layer 4 only when needed

# During sprint
# Layer 3 updates → Let cache TTL expire → Auto-refresh

# Sprint Harvest
# Layer 2 updates → Force cache refresh (updated insights)
```

---

### 4. Knowledge Graph Caching

**Cache frequently accessed entities:**

```markdown
## Cached Knowledge Subgraph

**Hermetic Principles**:
{7 principle entities + relations}

**Active Technologies**:
{Current stack: PostgreSQL, React, TypeScript entities}

**Current Project**:
{Midnight-Sun entity + related entities}

**Patterns & Gotchas**:
{Most accessed 20 entities from recent queries}

Total: ~3K tokens, refreshed weekly
```

**Benefit**: Instant access to core knowledge without repeated graph queries.

---

## Practical Workflows

### Workflow 1: Optimize Existing Session

**Audit current token usage:**

```bash
# Check what's being sent every request
# (Hypothetical - actual analysis requires API logs)

Total tokens per request: 25,000
  - CLAUDE.md: 5,000 (STATIC - should cache)
  - Manifesto: 3,000 (STATIC - should cache)
  - Dev docs full: 15,000 (MIXED - cache Layer 1-3, not Layer 4)
  - User query: 500 (DYNAMIC - never cache)
  - Code context: 1,500 (DYNAMIC - never cache)

Cacheable: 8,000 tokens (Layer 1-3 only, not full dev docs)
Dynamic: 17,000 tokens (user query + code + Layer 4)
```

**Optimize**:

```markdown
# Restructure prompt

## STATIC BLOCK (Cache this - 8K tokens)
- CLAUDE.md (5K)
- Hermetic manifesto (3K)
- Dev docs Layer 1-3 (pulled from CONTEXT.md, not full file)

## DYNAMIC BLOCK (Fresh each time - 2K tokens)
- User query (500)
- Code context (1.5K)
```

**Result**: 8K cached vs 25K processed = 68% reduction.

---

### Workflow 2: Monitor Cache Performance

**Metrics to track:**

```markdown
## Cache Performance - Week 15

**Cache hit rate**: 92% (49 hits / 53 requests)
**Avg tokens cached per hit**: 18,000
**Total tokens saved**: 882,000 (49 × 18K)
**Cost savings**: $2.38 this week
**Latency reduction**: 85% (cache hits ~instant)

**Cache misses**: 4 (TTL expiry after long breaks)

**Optimization opportunities**:
- Increase Layer 1-2 TTL (they rarely change)
- Reduce Layer 3 inclusion (only cache stable insights)
```

**Action**:
- If hit rate <80%: Increase cache TTL or consolidate static content
- If tokens cached <10K: Review what's being marked static
- If cost savings <50%: Restructure prompt (more static content first)

---

### Workflow 3: Cache-Aware Prompting

**When asking questions, optimize for cache reuse:**

**Bad** (breaks cache):

```
Show me the authentication code.

[New request 30 seconds later]
Now show me the payment code.

[Claude re-processes all static context both times]
```

**Good** (maximizes cache):

```
I need to review several code modules. First, authentication.

[Response received]

Next, payment code.

[Claude reuses cached context, only processes "payment code" query]
```

**Principle**: Batch related queries within cache TTL window (5 min).

---

### Workflow 4: Sprint Integration Caching

**Sprint Opening (Saturday PM)**:

```markdown
## Cache Refresh Ceremony

**Action**: Deliberately send updated context to refresh cache for new sprint

**Static context to cache**:
1. CLAUDE.md (if updated)
2. Hermetic manifesto (stable)
3. Brand guide (stable)
4. Dev docs Layer 1-2 (stable architecture)
5. Sprint N plan (new - cache for this sprint)

**Dynamic context** (don't cache):
- Layer 4 from previous sprint (will be compacted)
- Old feature branch context (archived)

**Result**: Fresh cache aligned with new sprint scope
```

**Implementation**:

```bash
# First request of Sprint N
/gnosis "Review Sprint N plan and integrate Hermetic context"

# This request:
# - Sends updated static context (creates cache)
# - Establishes sprint scope
# - Subsequent requests benefit from cached context
```

---

## Advanced Optimization

### Technique 1: Compressed Representation

**For very large static contexts, use compressed summaries:**

**Original** (15K tokens):
```markdown
# Complete Dev Docs Layer 1-4
[Full 15,000 word chronicle]
```

**Compressed for caching** (3K tokens):
```markdown
# Dev Docs Summary for Caching

## Layer 1: Executive (100 words)
[Summary]

## Layer 2: Key Insights (500 words)
[Insights]

## Layer 3: Critical Details (1500 words)
[Recent critical details only]

## Layer 4: Available on request
[Not included in cache - retrieve when needed]
```

**Benefit**: 80% token reduction, 95% information retention for most queries.

---

### Technique 2: Lazy Loading with Cache

**Don't cache everything - cache index, load on demand:**

```markdown
# Cached Index (500 tokens)

## Available Contexts
1. Hermetic Philosophy (3K tokens) - /load hermetic
2. Brand Guidelines (2K tokens) - /load brand
3. Dev Docs Full (15K tokens) - /load devdocs
4. Knowledge Graph (variable) - /query graph [topic]

## Current Sprint Context (Auto-loaded)
- Sprint N plan (1K tokens)
- Active features (1K tokens)

Total cached: 2.5K tokens (minimal)
```

**Workflow**:

```
User: "I need to review brand colors"
Claude: [Uses cached index] → Knows brand guide available → /load brand
[Loads 2K token brand guide on-demand]

User: "Now check code structure"
Claude: [Uses cached sprint context] → Has architecture from Sprint N plan
[No additional load needed - already in cache]
```

**Benefit**: Cache only what's always needed, load rest on-demand.

---

### Technique 3: Differential Updates

**Instead of re-caching entire context, send only changes:**

```markdown
# Initial Cache (18K tokens)
[Full CLAUDE.md + Manifesto + Dev Docs]

# Update 1 week later (only 500 tokens)
## Differential Update to Cached Context

**Dev Docs Layer 3 - New Insights**:
- Pattern: Async work takes 2x estimates (Sprint 14)
- Gotcha: Wednesday meetings kill Thursday flow (validated)
- Breakthrough: Feature flags prevented payment disaster

**Instructions**: Merge these insights into cached Layer 3 context.

[Claude updates internal cache representation]
```

**Benefit**: Avoid re-sending 18K tokens when only 500 changed.

**Note**: This is a conceptual optimization. Actual Claude API handles cache updates automatically when you send modified content.

---

## Cache Best Practices

### Practice 1: Structure for Stability

**Principle**: Most stable content first, most dynamic last.

```markdown
# Stability Hierarchy (Most → Least)

1. Core identity (CLAUDE.md) - Changes yearly
2. Hermetic principles - Never changes
3. Brand guide - Changes quarterly
4. Dev docs Layer 1-2 - Changes monthly
5. Dev docs Layer 3 - Changes weekly
6. Current sprint plan - Changes per sprint
7. Code files - Changes daily
8. User query - Changes per request

Cache boundary: After #6
```

**Benefit**: Maximize cache lifetime by grouping stable content.

---

### Practice 2: Monitor and Adjust

**Weekly cache audit checklist:**

```markdown
## Cache Optimization Checklist - Week N

**Metrics**:
- [ ] Cache hit rate: ___% (target: >85%)
- [ ] Avg cached tokens: ___ (target: >10K)
- [ ] Cost savings vs no cache: ___% (target: >80%)

**Content audit**:
- [ ] Review what's cached: Still mostly static?
- [ ] Check dynamic content: Accidentally caching changing data?
- [ ] Validate boundaries: Cache line in right place?

**Optimizations**:
- [ ] Move stable content earlier in prompt
- [ ] Remove dynamic content from cache block
- [ ] Compress verbose static content (if >20K tokens)

**Actions**:
- [ ] Update prompt structure if needed
- [ ] Document changes in dev docs
- [ ] Measure improvement next week
```

---

### Practice 3: Cache-Aware Development

**When modifying cached content, consider impact:**

```markdown
## Before Editing CLAUDE.md

**Current state**: Cached in 100+ active sessions
**Edit impact**: All caches invalid on next request
**Timing**: Edit during off-hours (fewer active sessions)

**Edit types**:
- **Additive** (new section): Low impact (cache still valid for existing queries)
- **Modification** (change existing): Medium impact (related queries affected)
- **Restructure** (move sections): High impact (all references affected)

**Best practice**:
- Batch CLAUDE.md edits (don't edit daily)
- Edit during Sprint Integration (cache refreshes for new sprint anyway)
- Announce to team: "Refreshing core context - expect slight latency on first request"
```

---

## Troubleshooting

### Issue: Cache hit rate low (<50%)

**Diagnosis**:

```markdown
Possible causes:
1. TTL too short (sessions last >5 min with gaps)
2. Static content changing frequently
3. Cache boundary in wrong place (dynamic content in cache block)
4. Multiple contexts not reusing same cache
```

**Fix**:

```bash
# 1. Check session duration
# If sessions >5 min with breaks, consider:
# - Keeping session active (periodic ping)
# - Accepting some cache misses (still cheaper than no cache)

# 2. Stabilize static content
# - Batch CLAUDE.md edits
# - Don't include Layer 4 in cache (too dynamic)

# 3. Move cache boundary
# Review prompt structure - move dynamic content AFTER cache block

# 4. Consolidate contexts
# Use same static context across all requests
```

---

### Issue: Cached content stale

**Problem**: Cache contains outdated information.

**Solution**: Deliberate cache refresh

```markdown
## Cache Refresh Workflow

**When to refresh**:
- Sprint boundary (new sprint context)
- Major refactoring (architecture changed)
- CLAUDE.md updated (core instructions changed)

**How to refresh**:
1. Wait 5+ minutes (TTL expiry) OR
2. Modify static content (add cache-bust comment) OR
3. Send updated content in next request (auto-refreshes)

**Verification**:
- First request after refresh: Slightly higher latency (cache write)
- Subsequent requests: Back to instant (cache read)
```

---

### Issue: Token costs still high despite caching

**Diagnosis**:

```markdown
Check:
1. Is output token count high? (Cache doesn't reduce output cost)
2. Is dynamic content large? (Cache only helps with static)
3. Are you sending fresh context every request? (Breaking cache)

Example:
- Cached static: 18K tokens × $0.30/1M = $0.005 per request ✅
- Dynamic content: 50K tokens × $3/1M = $0.15 per request 😐
- Output: 20K tokens × $15/1M = $0.30 per request 😰

Total: $0.455 per request
Issue: Output tokens dominating cost (66% of total)
```

**Fix**:

```bash
# Output cost is separate from cache optimization
# To reduce output cost:
# 1. Request concise responses
# 2. Use structured output (JSON vs prose)
# 3. Batch requests (fewer separate responses)

# But don't sacrifice quality to save pennies
# Cache optimization already achieved 90% savings on input
```

---

## Success Metrics

### You're caching optimally when:

**Qualitative:**
- ✅ Instant responses for routine queries
- ✅ Consistent context across session
- ✅ No need to repeat background information
- ✅ Sessions feel smooth and fast

**Quantitative:**
- ✅ Cache hit rate: >85%
- ✅ Tokens cached: >10K per hit
- ✅ Cost reduction: >80% vs no cache
- ✅ Latency reduction: >70% on cache hits
- ✅ Cache structure: <5 min to optimize new prompt

---

## Quick Reference

### Cache Economics

```
Input (no cache):  $3.00 / 1M tokens  (1x)
Cache write:       $3.75 / 1M tokens  (1.25x, one-time)
Cache read:        $0.30 / 1M tokens  (0.1x, 90% savings)
Output:           $15.00 / 1M tokens  (5x, not cached)
```

---

### Optimal Prompt Structure

```markdown
# STATIC (Cache this)
- CLAUDE.md
- Hermetic manifesto
- Brand guide
- Dev docs Layer 1-3
- Active skills/agents

--- CACHE BOUNDARY ---

# DYNAMIC (Fresh each time)
- User query
- Code context
- Layer 4 (if needed)
```

---

### Cache TTL Strategy

```
Permanent:  Layer 1 (architecture - changes yearly)
1 week:     Layer 2 (insights - updated Sprint Harvest)
1 day:      Layer 3 (details - updated during sprint)
5 min:      API default (session-scoped)
Never:      Layer 4 (always fresh, too dynamic)
```

---

### When to Invalidate

**Invalidate** (send updated context):
- Sprint boundary
- CLAUDE.md updated
- Major refactoring

**Don't invalidate** (let TTL handle):
- Minor code changes
- Typo fixes
- New features (don't affect static context)

---

### Monitoring Checklist

```markdown
Weekly audit:
- [ ] Cache hit rate >85%
- [ ] Avg cached tokens >10K
- [ ] Cost savings >80%
- [ ] Static content still stable
- [ ] Dynamic content not in cache block
```

---

**Complete implementation guide**: Above

**Integration with**:
- Dev docs: Cache Layer 1-3, refresh Layer 4 dynamically
- Sprints: Refresh cache at sprint boundaries
- Knowledge graph: Cache frequent subgraphs

**May your context be cached. May your responses be instant. May your costs be minimal.**
