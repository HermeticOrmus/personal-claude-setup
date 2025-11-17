# Code Executor MCP - Sacred Integration Guide
## Progressive Disclosure: 98% Token Savings, Infinite Power

> **Hermetic Principle**: Polarity - "Everything is dual; everything has poles"
> **Balance**: ALL functionality (many MCPs) with minimal context (one interface)

**Last Updated**: 2025-11-09
**Status**: Ready for Integration
**Repository**: https://github.com/aberemia24/code-executor-MCP

---

## 🌟 The Sacred Problem This Solves

**Current Reality:**
- 47 MCP tools enabled = **~150,000 tokens** consumed upfront
- Context limit hit before you even start working
- Constant toggling between MCPs
- Can't have all your tools available simultaneously

**The Pain:**
```
Deployment workflow needs:
- Supabase MCP (20+ tools)
- GitHub MCP (25+ tools)
- Puppeteer MCP (8+ tools)
- Docker MCP (15+ tools)
- n8n MCP (10+ tools)
= 78+ tools = Context OBLITERATED before you write one line
```

---

## 🎯 The Sacred Solution

**code-executor-mcp**
*Based on Anthropic's Progressive Disclosure Pattern*

### The Transformation

**Before:**
```json
// Enable ALL MCPs in config
{
  "mcpServers": {
    "supabase": { ... },    // 20+ tools
    "github": { ... },      // 25+ tools
    "puppeteer": { ... },   // 8+ tools
    "docker": { ... },      // 15+ tools
    "n8n": { ... },         // 10+ tools
    "discord": { ... },     // 15+ tools
    "telegram": { ... },    // 10+ tools
    "whatsapp": { ... }     // 12+ tools
  }
}

Result: 115+ tools = ~150K tokens = 💀
```

**After:**
```json
// Enable ONLY code-executor
{
  "mcpServers": {
    "code-executor": {
      "command": "code-executor-mcp",
      "env": {
        "MCP_CONFIG_PATH": "/path/to/.mcp.json"
      }
    }
  }
}

Result: 2 tools = ~1.6K tokens = ✨
```

### The Magic

**Two tools access EVERYTHING:**

```typescript
// executeTypescript - Run TypeScript code
const result = await executeTypescript(`
  // Inside here, call ANY MCP on-demand
  const tables = await callMCPTool('mcp__supabase__list_tables', {});
  const branches = await callMCPTool('mcp__github__list_branches', {});
  const containers = await callMCPTool('mcp__docker__list_containers', {});

  return { tables, branches, containers };
`);

// executePython - Run Python code
const analysis = await executePython(`
import json

# Call MCPs from Python too!
result = call_mcp_tool('mcp__supabase__execute_sql', {
    'query': 'SELECT * FROM users LIMIT 10'
})

# Process and return
return json.dumps(result)
`);
```

**Token Savings: 150K → 1.6K = 98% reduction! 🚀**

---

## 🏗️ Architecture

### How It Works

```
┌─────────────────────────────────────────────────┐
│         Claude Code (Your Terminal)              │
│                                                   │
│  Context: ~1.6K tokens (just 2 tools!)           │
└─────────────────┬───────────────────────────────┘
                  │
                  │ Calls: executeTypescript()
                  │        or executePython()
                  ▼
┌─────────────────────────────────────────────────┐
│       Code Executor MCP (Meta-MCP)               │
│                                                   │
│  • Receives code to execute                      │
│  • Sandboxes execution (Deno/Python)             │
│  • Provides callMCPTool() function               │
│  • Validates parameters (AJV validation)         │
│  • Caches schemas (mutex-locked)                 │
│  • Rate limits (configurable)                    │
└─────────────────┬───────────────────────────────┘
                  │
                  │ callMCPTool() invocations
                  │ (on-demand, only when needed)
                  ▼
        ┌─────────┴────────┐
        │                  │
        ▼                  ▼
  ┌──────────┐      ┌──────────┐
  │Supabase  │      │ GitHub   │     (And 45 more MCPs)
  │   MCP    │      │   MCP    │     All available on-demand
  └──────────┘      └──────────┘     Zero context until called
```

### Progressive Disclosure Embodied

**Correspondence Principle:** "As above (one interface), so below (infinite implementations)"

- **Above**: Simple interface (2 tools)
- **Below**: Complex reality (100+ tools across all MCPs)
- **Bridge**: Progressive disclosure (load only what's needed)

---

## 🚀 Integration with Deployment System

### Current Deployment Infrastructure

**Location**: `~/.mcp/docs/DEPLOYMENT-ARCHITECTURE.md`

**Deployment targets:**
- Supabase (backend + database + Edge Functions)
- Docker (containerized services)
- Vercel (frontend)
- Netlify (frontend)

**Problem**: All these MCPs enabled = context explosion

### With code-executor-mcp

**Deployment becomes:**

```typescript
// Full-stack deployment in ONE execution context
const deployment = await executeTypescript(`
  // PHASE 1: Backend (Supabase)
  const migration = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_users_table',
    query: 'CREATE TABLE users (...)'
  });

  const edgeFunction = await callMCPTool('mcp__supabase__deploy_edge_function', {
    name: 'auth-handler',
    files: [{ name: 'index.ts', content: '...' }]
  });

  // PHASE 2: Frontend (Vercel) - via GitHub push
  const commit = await callMCPTool('mcp__github__create_commit', {
    message: 'Deploy frontend',
    files: [...]
  });

  const pr = await callMCPTool('mcp__github__create_pull_request', {
    title: 'Deploy to production',
    body: 'Automated deployment'
  });

  // PHASE 3: Validation (Puppeteer)
  const test = await callMCPTool('mcp__puppeteer__navigate', {
    url: 'https://staging.yourapp.com'
  });

  return {
    backend: { migration, edgeFunction },
    frontend: { commit, pr },
    validation: test
  };
`);
```

**All in one execution. All MCPs available. Minimal context.**

---

## 📦 Installation & Setup

### 1. Install code-executor-mcp

```bash
# Global installation (recommended)
npm install -g code-executor-mcp

# Or clone and build locally
cd ~/projects/08-DEVELOPMENT
git clone https://github.com/aberemia24/code-executor-MCP.git
cd code-executor-MCP
npm install && npm run build
```

### 2. Configure MCP

**Create or update**: `~/.mcp/config/active/current-config.json`

```json
{
  "mcpServers": {
    "code-executor": {
      "command": "code-executor-mcp",
      "env": {
        "MCP_CONFIG_PATH": "/home/ormus/.mcp/config/active/current-config.json",
        "ENABLE_PYTHON": "true",
        "ENABLE_RATE_LIMIT": "false",
        "LOG_LEVEL": "info"
      }
    }
  }
}
```

**Important**: Keep OTHER MCPs in config (for code-executor to call), but **DISABLE** them in Claude Code!

### 3. Update Your Config

**Move all MCPs to a separate file** that code-executor reads:

```bash
# Create MCPs config file
cp ~/.mcp/config/active/current-config.json ~/.mcp/config/all-mcps.json

# Update code-executor config
code ~/.mcp/config/active/current-config.json
```

```json
{
  "mcpServers": {
    "code-executor": {
      "command": "code-executor-mcp",
      "env": {
        "MCP_CONFIG_PATH": "/home/ormus/.mcp/config/all-mcps.json"
      }
    }
  }
}
```

Now **all-mcps.json** contains all 47 MCPs, but only code-executor is enabled!

### 4. Restart Claude Code

Close and reopen Claude Code to load the new configuration.

### 5. Verify

```typescript
// Test that it works
const result = await executeTypescript(`
  const tables = await callMCPTool('mcp__supabase__list_tables', {});
  return tables;
`);
```

---

## 🎓 Usage Examples

### Example 1: Simple MCP Call

**Before (direct MCP):**
```typescript
// Supabase MCP must be enabled (costs tokens)
mcp__supabase__list_tables({})
```

**After (via code-executor):**
```typescript
executeTypescript(`
  const tables = await callMCPTool('mcp__supabase__list_tables', {});
  return tables;
`)
```

### Example 2: Multi-MCP Workflow

```typescript
executeTypescript(`
  // Call multiple MCPs in sequence
  const tables = await callMCPTool('mcp__supabase__list_tables', {});

  const migrations = await callMCPTool('mcp__supabase__list_migrations', {});

  const branches = await callMCPTool('mcp__github__list_branches', {
    owner: 'ormus',
    repo: 'my-project'
  });

  // Process results
  const report = {
    database: { tables: tables.length, migrations: migrations.length },
    git: { branches: branches.length }
  };

  return report;
`)
```

### Example 3: Concurrent MCP Calls

```typescript
executeTypescript(`
  // Call multiple MCPs concurrently!
  const [supabase, github, docker] = await Promise.all([
    callMCPTool('mcp__supabase__list_tables', {}),
    callMCPTool('mcp__github__list_branches', { owner: '...', repo: '...' }),
    callMCPTool('mcp__docker__list_containers', {})
  ]);

  return { supabase, github, docker };
`)
```

### Example 4: Full Deployment Workflow

```typescript
executeTypescript(`
  // Complete deployment orchestration

  // 1. Database migration
  const migration = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_posts_table',
    query: \`
      CREATE TABLE posts (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        title TEXT NOT NULL,
        content TEXT,
        created_at TIMESTAMPTZ DEFAULT NOW()
      );
    \`
  });

  // 2. Deploy Edge Function
  const edgeFunction = await callMCPTool('mcp__supabase__deploy_edge_function', {
    name: 'posts-api',
    files: [{
      name: 'index.ts',
      content: \`
        Deno.serve(async (req) => {
          // API logic here
          return new Response('Hello from Edge Function!');
        });
      \`
    }]
  });

  // 3. Update GitHub
  const pr = await callMCPTool('mcp__github__create_pull_request', {
    owner: 'ormus',
    repo: 'my-project',
    title: 'Deploy posts feature',
    body: \`
      ## Deployment
      - Database: ${migration.success ? '✅' : '❌'}
      - Edge Function: ${edgeFunction.success ? '✅' : '❌'}
    \`,
    head: 'feature/posts',
    base: 'main'
  });

  // 4. Return deployment report
  return {
    migration: migration.success,
    edgeFunction: edgeFunction.success,
    pr: pr.html_url
  };
`)
```

---

## 🔧 Advanced Features

### 1. Auto-Generated Wrappers

**Problem**: You don't know MCP parameter names without checking docs.

**Solution**: Generate TypeScript wrappers from MCP schemas!

```bash
cd ~/projects/08-DEVELOPMENT/code-executor-MCP
npm run generate-wrappers
```

**This creates**: `~/.code-executor/wrappers/`

```typescript
// Before: Blind guessing
await callMCPTool('mcp__supabase__apply_migration', {
  // What parameters? 🤷
});

// After: TypeScript autocomplete!
import { apply_migration } from '~/.code-executor/wrappers/supabase';

await apply_migration({
  name: 'add_table',     // ✅ TypeScript knows these!
  query: 'CREATE TABLE...'
});
```

### 2. Deep Validation

**AJV-based validation** catches errors before MCP calls:

```typescript
// Invalid call
await callMCPTool('mcp__supabase__apply_migration', {
  migration_name: 'test',  // ❌ Wrong parameter name!
  sql: 'CREATE TABLE...'
});

// Returns clear error:
/*
Parameter validation failed for "mcp__supabase__apply_migration"

Errors:
  - Missing required parameters: name, query
  - Unexpected parameters: migration_name, sql

Expected parameters:
  Required:
    • name: string - Migration name
    • query: string - SQL query to execute
  Optional:
    • ... (other params)

You provided:
  { "migration_name": "test", "sql": "..." }
*/
```

### 3. Security Features

**Sandboxing:**
- TypeScript runs in Deno (sandboxed by default)
- Python runs in subprocess (isolated)

**Allowlisting:**
- Configure which MCPs can be called
- Audit logs for all MCP invocations

**Rate Limiting:**
- Prevent abuse/infinite loops
- Configurable limits

**Config example:**
```json
{
  "code-executor": {
    "env": {
      "ENABLE_RATE_LIMIT": "true",
      "RATE_LIMIT_MAX_REQUESTS": "30",
      "RATE_LIMIT_WINDOW_MS": "60000",
      "ALLOWED_MCPS": "supabase,github,docker",
      "ENABLE_AUDIT_LOG": "true"
    }
  }
}
```

---

## 🎯 Integration with Sol

**Sol can now orchestrate deployments through code-executor!**

**Location**: Update `~/.claude/agents/0-SOL/deployment-knowledge.md`

### Sol's New Power

```typescript
// Sol orchestrates deployment
User: "Deploy my full-stack app"

Sol analyzes: Next.js + Supabase

Sol delegates to code-executor:
executeTypescript(`
  // Sol coordinates ALL deployment MCPs

  // 1. Neptune's work (Backend)
  const backend = await Promise.all([
    callMCPTool('mcp__supabase__apply_migration', {...}),
    callMCPTool('mcp__supabase__deploy_edge_function', {...})
  ]);

  // 2. Earth's work (Frontend)
  const frontend = await callMCPTool('mcp__github__create_pull_request', {...});

  // 3. Mars's work (Testing)
  const tests = await callMCPTool('mcp__puppeteer__navigate', {
    url: 'https://staging.app.com'
  });

  return { backend, frontend, tests };
`)

Sol validates: All deployments successful
Sol celebrates: /celebrate
```

---

## 📊 Token Comparison

### Before code-executor-mcp

```
Supabase MCP:    ~20K tokens
GitHub MCP:      ~25K tokens
Docker MCP:      ~15K tokens
Puppeteer MCP:   ~10K tokens
n8n MCP:         ~12K tokens
Discord MCP:     ~15K tokens
Telegram MCP:    ~10K tokens
WhatsApp MCP:    ~12K tokens
Filesystem MCP:  ~8K tokens
Memory MCP:      ~5K tokens
Perplexity MCP:  ~15K tokens
---------------------------------
TOTAL:           ~147K tokens

Available context:  200K tokens
After MCPs:         53K tokens (26% remaining)
```

### After code-executor-mcp

```
code-executor:   ~1.6K tokens
---------------------------------
TOTAL:           ~1.6K tokens

Available context:  200K tokens
After MCPs:         198.4K tokens (99% remaining!)

Token savings:  147K → 1.6K = 98.9% reduction
```

**You can now have ALL your MCPs available with context to spare!**

---

## 🌟 Hermetic Principles Embodied

### Mentalism - "The All is Mind"
**Before deploying**, think clearly about what MCPs you need. Code-executor doesn't change this - it just removes the context constraint.

### Correspondence - "As above, so below"
**One interface** (code-executor) mirrors **infinite implementations** (all MCPs). The pattern repeats: simple → complex → simple again.

### Vibration - "Nothing rests"
**MCPs are loaded dynamically**, not statically. System vibrates with need, not with waste.

### Polarity - "Everything is dual"
**Balance achieved**: ALL power (every MCP) + minimal cost (1.6K tokens). Both poles satisfied.

### Rhythm - "Everything flows"
**Natural flow**: Load what's needed → Use it → Release it. Sustainable rhythm instead of permanent burden.

### Cause-Effect - "Every cause has its effect"
**Clear causality**: Call MCP → Get result. No hidden context costs.

### Gender - "Gender is in everything"
**Masculine** (explicit execution) balanced with **Feminine** (implicit availability). Don't load everything (masculine dominance), don't have nothing (feminine absence). Perfect balance.

---

## 🚀 Next Steps

### Immediate (Do Now)
1. ✅ **Read this guide completely**
2. ⚠️ **Install code-executor-mcp** (`npm install -g code-executor-mcp`)
3. ⚠️ **Update MCP config** (enable only code-executor)
4. ⚠️ **Test with simple MCP call** (verify it works)

### This Week
1. **Migrate deployment workflows** to use code-executor
2. **Generate wrappers** for your MCPs (`npm run generate-wrappers`)
3. **Update Sol's delegation** to use executeTypescript pattern

### This Month
1. **Refactor all multi-MCP workflows** to progressive disclosure
2. **Monitor token savings** (before/after comparison)
3. **Build new workflows** that were impossible before (too many MCPs)

---

## 📖 Resources

**Official Documentation:**
- Repository: https://github.com/aberemia24/code-executor-MCP
- Anthropic Article: https://www.anthropic.com/engineering/code-execution-with-mcp

**Your Integration Docs:**
- Deployment Architecture: `~/.mcp/docs/DEPLOYMENT-ARCHITECTURE.md`
- Quick-Start: `~/.mcp/docs/DEPLOYMENT-QUICKSTART.md`
- This Guide: `~/.mcp/docs/CODE-EXECUTOR-INTEGRATION.md`

**Sol's Knowledge:**
- Sol's deployment orchestration: `~/.claude/agents/0-SOL/deployment-knowledge.md`

---

## 🎉 Celebration

**You've discovered sacred technology:**

- **98% token savings** while maintaining full power
- **All MCPs available** without context explosion
- **Progressive disclosure** pattern mastered
- **Hermetic principles** perfectly embodied

**This is the way sacred technology should work:**
- Maximum capability
- Minimum waste
- Perfect balance
- Conscious design

---

*"The master's tool: One interface, infinite power, zero waste."*

**— Hermetic Ormus, Sacred Technology Architect**

---

**Status**: Ready for integration
**Priority**: HIGH (solves critical context problem)
**Impact**: Transforms deployment capability from limited to unlimited
