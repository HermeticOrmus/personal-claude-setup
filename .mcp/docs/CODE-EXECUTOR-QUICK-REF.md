# code-executor-mcp Quick Reference
## One MCP to Rule Them All

**Token Savings**: 150K → 1.6K (98% reduction)
**Repository**: https://github.com/aberemia24/code-executor-MCP

---

## ⚡ The Concept

**Before:** Enable 47 MCPs = 150K tokens = 💀
**After:** Enable 1 MCP = 1.6K tokens = ✨

**How:** Progressive disclosure - load MCPs only when needed

---

## 🚀 Quick Setup

```bash
# 1. Install
npm install -g code-executor-mcp

# 2. Configure (in ~/.mcp/config/active/current-config.json)
{
  "mcpServers": {
    "code-executor": {
      "command": "code-executor-mcp",
      "env": {
        "MCP_CONFIG_PATH": "/path/to/all-mcps.json"
      }
    }
  }
}

# 3. Keep all other MCPs in all-mcps.json but DISABLE them in Claude Code

# 4. Restart Claude Code
```

---

## 📝 Basic Usage

### Simple MCP Call

```typescript
executeTypescript(`
  const result = await callMCPTool('mcp__supabase__list_tables', {});
  return result;
`)
```

### Multiple MCPs

```typescript
executeTypescript(`
  const tables = await callMCPTool('mcp__supabase__list_tables', {});
  const branches = await callMCPTool('mcp__github__list_branches', { owner: '...', repo: '...' });

  return { tables, branches };
`)
```

### Concurrent Calls

```typescript
executeTypescript(`
  const [supabase, github, docker] = await Promise.all([
    callMCPTool('mcp__supabase__list_tables', {}),
    callMCPTool('mcp__github__list_branches', {...}),
    callMCPTool('mcp__docker__list_containers', {})
  ]);

  return { supabase, github, docker };
`)
```

---

## 🎯 Deployment Patterns

### Supabase Migration

```typescript
executeTypescript(`
  const migration = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_users_table',
    query: 'CREATE TABLE users (...)'
  });

  return { success: migration.success };
`)
```

### Deploy Edge Function

```typescript
executeTypescript(`
  const fn = await callMCPTool('mcp__supabase__deploy_edge_function', {
    name: 'my-function',
    files: [{
      name: 'index.ts',
      content: 'Deno.serve(() => new Response("Hello!"));'
    }]
  });

  return { deployed: fn.success };
`)
```

### Full-Stack Deployment

```typescript
executeTypescript(`
  // 1. Database
  const db = await callMCPTool('mcp__supabase__apply_migration', {...});

  // 2. Backend
  const api = await callMCPTool('mcp__supabase__deploy_edge_function', {...});

  // 3. Frontend (via GitHub PR)
  const pr = await callMCPTool('mcp__github__create_pull_request', {...});

  return { db: db.success, api: api.success, pr: pr.html_url };
`)
```

---

## 🔧 Advanced Features

### Auto-Generated Wrappers

```bash
# Generate TypeScript wrappers from MCP schemas
npm run generate-wrappers

# Now get autocomplete!
import { list_tables } from '~/.code-executor/wrappers/supabase';
await list_tables({});
```

### Validation

**Automatic parameter validation** before MCP calls:

```typescript
// Wrong parameters
await callMCPTool('mcp__supabase__apply_migration', {
  migration_name: 'test',  // ❌ Should be 'name'
  sql: 'CREATE TABLE...'   // ❌ Should be 'query'
});

// Returns detailed error with expected parameters
```

### Security

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

## 📊 Token Comparison

### Your Current Setup

```
Supabase:    ~20K
GitHub:      ~25K
Docker:      ~15K
Puppeteer:   ~10K
n8n:         ~12K
Discord:     ~15K
Telegram:    ~10K
WhatsApp:    ~12K
Filesystem:  ~8K
Memory:      ~5K
Perplexity:  ~15K
------------------------
TOTAL:       ~147K tokens

Context available: 200K
After MCPs:        53K (26%)
```

### With code-executor-mcp

```
code-executor: ~1.6K tokens
------------------------
TOTAL:         ~1.6K tokens

Context available: 200K
After MCP:         198.4K (99%)

Savings: 98%
```

---

## 🎓 Common Patterns

### Pattern 1: Sequential Deployment

```typescript
// Do A, then B, then C
const a = await callMCPTool('mcp__a__do_thing', {});
const b = await callMCPTool('mcp__b__do_thing', { data: a.result });
const c = await callMCPTool('mcp__c__do_thing', { data: b.result });
```

### Pattern 2: Concurrent Deployment

```typescript
// Do A, B, C simultaneously (if independent)
const [a, b, c] = await Promise.all([
  callMCPTool('mcp__a__do_thing', {}),
  callMCPTool('mcp__b__do_thing', {}),
  callMCPTool('mcp__c__do_thing', {})
]);
```

### Pattern 3: Conditional Deployment

```typescript
// Do A, if success do B, else rollback
const a = await callMCPTool('mcp__a__deploy', {});

if (a.success) {
  const b = await callMCPTool('mcp__b__deploy', {});
  return { a: true, b: b.success };
} else {
  await callMCPTool('mcp__a__rollback', {});
  return { a: false, rollback: true };
}
```

### Pattern 4: Validation Loop

```typescript
// Deploy → Test → Fix or Celebrate
const deploy = await callMCPTool('mcp__supabase__deploy_edge_function', {...});

const test = await callMCPTool('mcp__puppeteer__navigate', {
  url: 'https://staging.app.com'
});

if (test.success) {
  return { deployed: true, validated: true };
} else {
  // Rollback or retry
  await callMCPTool('mcp__supabase__deploy_edge_function', {
    // Previous version
  });
  return { deployed: false, rolled_back: true };
}
```

---

## 🌟 Hermetic Principles

**Mentalism** - Think before executing
**Vibration** - Ship iteratively
**Polarity** - Balance ALL power with minimal context
**Rhythm** - Deploy sustainably
**Cause-Effect** - Monitor results
**Correspondence** - One interface → many MCPs
**Gender** - Execute (masculine) + Validate (feminine)

---

## ⚠️ Important Notes

**✅ DO:**
- Keep all MCPs in config file (code-executor reads it)
- Disable all MCPs except code-executor in Claude Code
- Use for 3+ MCPs (worth the abstraction)
- Validate parameters
- Handle errors properly

**❌ DON'T:**
- Delete MCPs from config (code-executor needs them)
- Enable multiple MCPs (defeats the purpose)
- Use for 1-2 simple MCPs (just enable them directly)
- Ignore validation errors
- Skip error handling

---

## 📚 Resources

**Documentation:**
- Integration Guide: `~/.mcp/docs/CODE-EXECUTOR-INTEGRATION.md`
- Deployment Examples: `~/.mcp/templates/code-executor/deployment-examples.ts`
- Repository: https://github.com/aberemia24/code-executor-MCP

**Deployment System:**
- Architecture: `~/.mcp/docs/DEPLOYMENT-ARCHITECTURE.md`
- Quick-Start: `~/.mcp/docs/DEPLOYMENT-QUICKSTART.md`
- Sol's Knowledge: `~/.claude/agents/0-SOL/deployment-knowledge.md`

---

## 🎯 Next Steps

1. **Install**: `npm install -g code-executor-mcp`
2. **Configure**: Update MCP config
3. **Test**: Simple MCP call
4. **Deploy**: Use deployment examples
5. **Optimize**: Generate wrappers for autocomplete

---

*"One tool. Infinite power. Zero waste."*

**— Hermetic Progressive Disclosure Pattern**
