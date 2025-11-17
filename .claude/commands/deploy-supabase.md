---
description: Deploy application to Supabase (backend + database + edge functions)
tags: deployment, supabase, backend
---

You are deploying an application to Supabase. This workflow handles:
- Database migrations
- Edge Functions deployment
- Development branch testing
- Production deployment

## Pre-Deployment Checklist

Before deploying, verify:
1. ✅ Supabase MCP is configured (check ~/.mcp/config/active/current-config.json)
2. ✅ SUPABASE_ACCESS_TOKEN is set
3. ✅ Project has migrations or Edge Functions
4. ✅ Code is tested and ready

## Deployment Workflow

### Step 1: Gather Information

Ask the user:
- **Project ID** (if not set globally in MCP config)
- **Deployment type**:
  - [ ] Database migrations only
  - [ ] Edge Functions only
  - [ ] Full deployment (migrations + functions)
- **Target environment**:
  - [ ] Development branch (safe testing)
  - [ ] Production (direct deployment)

### Step 2: Development Branch Deployment (Recommended)

If user chooses development branch:

```
1. Create development branch:
   - Use: mcp__supabase__create_branch
   - Branch name: feature-{task-name} or dev-{date}
   - Cost confirmation: Run confirm_cost first

2. Apply migrations (if any):
   - List migrations: mcp__supabase__list_migrations
   - Apply new: mcp__supabase__apply_migration
   - Verify: mcp__supabase__execute_sql (SELECT to verify)

3. Deploy Edge Functions (if any):
   - List: mcp__supabase__list_edge_functions
   - Deploy: mcp__supabase__deploy_edge_function
   - Test: Call function endpoints

4. Run validation:
   - Check advisors: mcp__supabase__get_advisors (security + performance)
   - Review logs: mcp__supabase__get_logs (check for errors)
   - Run integration tests (Puppeteer if available)

5. If validation passes:
   - Merge to production: mcp__supabase__merge_branch
   - Monitor production logs
```

### Step 3: Direct Production Deployment (Use with Caution)

If user chooses production directly:

```
1. Warn user: "Deploying directly to production. No rollback without backup!"

2. Apply migrations:
   - Backup recommendation: Suggest manual backup first
   - Apply: mcp__supabase__apply_migration
   - Verify: Check tables/schema

3. Deploy Edge Functions:
   - Deploy: mcp__supabase__deploy_edge_function
   - Test immediately

4. Post-deployment validation:
   - Check advisors immediately
   - Monitor logs for errors
   - Run smoke tests
```

### Step 4: Post-Deployment

```
1. Generate TypeScript types:
   - mcp__supabase__generate_typescript_types
   - Update in project

2. Create PR (if using GitHub):
   - Document changes
   - Link to deployment
   - Tag for rollback

3. Celebrate!
   - /celebrate (Hermetic command)
```

## Security Checks

Always run these after deployment:
- `mcp__supabase__get_advisors` with type: "security"
- Review for:
  - Missing RLS policies
  - Exposed endpoints
  - Weak authentication

## Rollback Procedure

If deployment fails:

**Development branch:**
- Reset: `mcp__supabase__reset_branch`
- Delete: `mcp__supabase__delete_branch`

**Production:**
- Create rollback migration (undo changes)
- Apply rollback migration
- Monitor for stability

## Hermetic Principles

**Vibration** - Ship iteratively. Use dev branches.
**Cause & Effect** - Every migration has consequences. Test thoroughly.
**Rhythm** - Don't deploy on Day 7 (rest day).

---

**Execute the deployment workflow above. Ask clarifying questions. Validate thoroughly.**
