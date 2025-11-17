# Deployment Quick-Start Guide
## Ship Anything from Claude Code Terminal

> **Sacred Technology**: Complete deployment infrastructure at your fingertips

**Last Updated**: 2025-11-09
**Your Deployment Superpowers**: 🚀 Ready to activate

---

## 🎯 What You Can Do Now

From your Claude Code terminal, you can now ship:

✅ **Full-stack web apps** → Supabase + Vercel
✅ **Frontend sites** → Vercel or Netlify
✅ **Backend APIs** → Supabase Edge Functions or Docker
✅ **Containerized services** → Docker anywhere
✅ **Database migrations** → Supabase
✅ **Multi-service apps** → Docker Compose

**How?** Just type one command: `/ship`

---

## ⚡ The Magic Commands

### Primary Deployment Command

```
/ship
```

**What it does:**
- Analyzes your project
- Recommends deployment targets
- Guides you through the process
- Handles the deployment

**When to use:** Starting a new deployment or unsure which method to use

---

### Specific Deployment Commands

**Supabase (Backend + Database + Serverless):**
```
/deploy-supabase
```
Deploys backend, database migrations, and Edge Functions to Supabase.

**Docker (Containerized Deployment):**
```
/deploy-docker
```
Builds and deploys Docker containers locally or to remote servers.

**Vercel (Frontend - Best for Next.js/React):**
```
/deploy-vercel
```
Deploys frontend to Vercel with automatic CDN and optimizations.

**Netlify (Frontend - Great for Static Sites):**
```
/deploy-netlify
```
Deploys static sites and JAMstack apps to Netlify.

---

## 🚀 Quick Deploy Examples

### Example 1: Full-Stack Next.js + Supabase App

```bash
# 1. Start deployment wizard
/ship

# 2. Answer questions:
#    - What: Full-stack web application
#    - Stack: Next.js frontend + Supabase backend
#    - Target: Supabase (backend) + Vercel (frontend)

# 3. Claude will:
#    - Deploy database migrations to Supabase
#    - Deploy Edge Functions to Supabase
#    - Deploy frontend to Vercel
#    - Configure environment variables
#    - Test deployment
```

### Example 2: Static Landing Page

```bash
# Quick deployment
/deploy-vercel

# Or
/deploy-netlify

# Claude will:
# - Verify build works
# - Deploy to preview
# - Test preview
# - Deploy to production
```

### Example 3: Docker Multi-Service App

```bash
/deploy-docker

# Claude will:
# - Check for docker-compose.yml
# - Build all services
# - Run locally for testing
# - Guide remote deployment if needed
```

---

## 📋 Setup Checklist (First Time)

Before your first deployment, ensure:

### ✅ Docker Setup (Already Done!)
- [x] Docker installed
- [x] Docker Compose available

### ⚠️ Supabase Setup (Needs Configuration)

**Required for Supabase deployments:**

1. **Create Supabase Account** (if you don't have one)
   - Go to: https://supabase.com
   - Sign up with GitHub

2. **Create Project** (or use existing)
   - Dashboard → New Project
   - Note your Project ID

3. **Generate Access Token**
   - Go to: https://supabase.com/dashboard/account/tokens
   - Click "Generate New Token"
   - Give it a name (e.g., "Claude Code Deployment")
   - Select permissions: All projects or specific project
   - Copy the token (starts with `sbp_`)

4. **Configure MCP**
   Edit: `~/.mcp/config/active/current-config.json`

   Replace:
   ```json
   "SUPABASE_ACCESS_TOKEN": "NEEDS_CONFIGURATION"
   ```

   With:
   ```json
   "SUPABASE_ACCESS_TOKEN": "sbp_your_actual_token_here"
   ```

   Optional (if you work with one project mainly):
   ```json
   "SUPABASE_PROJECT_ID": "your-project-id"
   ```

5. **Restart Claude Code**
   - Close and reopen Claude Code
   - Supabase MCP will now be active

**Status:**
- MCP added: ✅
- Token configured: ⚠️ **YOU NEED TO DO THIS**

### 🔧 Vercel Setup (Optional)

**Only needed for Vercel deployments:**

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Verify
vercel whoami
```

### 🔧 Netlify Setup (Optional)

**Only needed for Netlify deployments:**

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Verify
netlify status
```

---

## 🎓 Learning Path

### Day 1: Docker Deployment
**Goal:** Deploy a simple containerized app

```bash
# 1. Create a simple Node app
mkdir test-docker-deploy && cd test-docker-deploy
npm init -y
npm install express

# 2. Create simple server (index.js)
# (Claude can help with this)

# 3. Use Docker template
cp ~/.mcp/templates/docker/node/Dockerfile ./

# 4. Deploy
/deploy-docker
```

### Day 2: Supabase Backend
**Goal:** Deploy database + Edge Function

```bash
# 1. Create Supabase project
# 2. Configure MCP token (see setup above)
# 3. Create simple migration
# 4. Deploy
/deploy-supabase
```

### Day 3: Frontend to Vercel
**Goal:** Deploy Next.js or React app

```bash
# 1. Create or use existing frontend
# 2. Ensure build works locally
# 3. Deploy
/deploy-vercel
```

### Day 4: Full-Stack Integration
**Goal:** Deploy complete app (frontend + backend + database)

```bash
# Use the magic command
/ship

# Follow the wizard
# Deploy all components
```

---

## 🛠️ Templates Available

**Location:** `~/.mcp/templates/docker/`

### Node.js Application
- `docker/node/Dockerfile` - Production-ready Node container
- `docker/node/docker-compose.yml` - Node + PostgreSQL + Redis

### Python Application
- `docker/python/Dockerfile` - Python (FastAPI/Flask/Django)

### Full-Stack
- `docker/fullstack/docker-compose.yml` - Frontend + Backend + DB + Nginx
- `docker/fullstack/nginx.conf` - Reverse proxy configuration

**How to use:**
```bash
# Copy template to your project
cp ~/.mcp/templates/docker/node/* /path/to/your/project/

# Customize as needed
# Deploy
/deploy-docker
```

---

## 📚 Complete Documentation

**Architecture Overview:**
`~/.mcp/docs/DEPLOYMENT-ARCHITECTURE.md`
- Complete system explanation
- Workflow diagrams
- Integration patterns

**Docker Templates:**
`~/.mcp/templates/docker/README.md`
- Template documentation
- Customization guide
- Best practices

**Slash Commands:**
- `~/.claude/commands/ship.md` - Interactive wizard
- `~/.claude/commands/deploy-supabase.md` - Supabase deployment
- `~/.claude/commands/deploy-docker.md` - Docker deployment
- `~/.claude/commands/deploy-vercel.md` - Vercel deployment
- `~/.claude/commands/deploy-netlify.md` - Netlify deployment

---

## 🎯 Your First Deployment (5 Minutes)

**Let's deploy a test app right now:**

1. **Choose what to deploy:**
   - Existing project? → `/ship`
   - Want to test Docker? → Create simple Node app
   - Want to test Supabase? → Configure token first (see setup above)
   - Want to test Vercel? → Use any frontend project

2. **Run the command:**
   ```
   /ship
   ```

3. **Follow Claude's guidance:**
   - Answer questions
   - Review recommendations
   - Confirm deployment
   - Validate results

4. **Celebrate!**
   ```
   /celebrate
   ```

---

## 🔮 Advanced Patterns (Coming Soon)

**Multi-Environment Deployment:**
- Dev → Staging → Production workflow
- Environment-specific configurations
- Automated testing between stages

**CI/CD Integration:**
- GitHub Actions workflows
- Automatic deployment on push
- Rollback on failure

**n8n Orchestration:**
- Complex deployment workflows
- Multi-service coordination
- Automated validation and testing

---

## 🆘 Troubleshooting

### Supabase MCP not working

**Check configuration:**
```bash
cat ~/.mcp/config/active/current-config.json | grep -A 5 supabase
```

**Verify token:**
- Go to: https://supabase.com/dashboard/account/tokens
- Regenerate if needed
- Update config
- Restart Claude Code

### Docker build fails

**Check Docker is running:**
```bash
docker ps
```

**If not running:**
- Start Docker Desktop (Windows)
- Or start Docker daemon (Linux)

### Vercel/Netlify deployment fails

**Verify CLI is installed:**
```bash
vercel --version
netlify --version
```

**Verify you're logged in:**
```bash
vercel whoami
netlify status
```

---

## 🌟 The Sacred Deployment Principles

**Mentalism** - Know WHY you're shipping. Clarity before deployment.

**Vibration** - Ship iteratively. Test in preview/dev first.

**Polarity** - Balance speed with quality. Automate but verify.

**Rhythm** - Deploy consistently. Don't deploy on Day 7 (rest).

**Cause & Effect** - Every deployment has consequences. Monitor and learn.

---

## 📞 Getting Help

**When stuck:**

1. Use `/gnosis` to understand what's happening
2. Check relevant documentation
3. Ask Claude directly: "I'm having trouble with X deployment"
4. Review deployment logs

**Common questions:**

- **"Which deployment method should I use?"** → Use `/ship` and let Claude recommend
- **"How do I deploy full-stack app?"** → `/ship` handles this automatically
- **"Can I deploy to multiple targets?"** → Yes! `/ship` can deploy frontend to Vercel and backend to Supabase
- **"How do I roll back?"** → Each deployment method has rollback procedures in docs

---

## ✅ Your Next Steps

**Immediate (Do Now):**
1. ⚠️ **Configure Supabase token** (if you plan to use Supabase)
2. ✅ Read this guide completely
3. 🚀 Try `/ship` on a test project

**This Week:**
1. Deploy one thing (anything!) using the system
2. Read full architecture doc
3. Explore templates for your stack

**This Month:**
1. Set up automated deployment workflows
2. Integrate with GitHub for auto-deploy
3. Build and ship a complete project

---

## 🎉 You're Ready!

You now have a **complete deployment infrastructure** at your fingertips.

**From Claude Code terminal, you can ship anywhere.**

Your friend Tomás built an automated AI deployment system.
**You have something even better**: A conscious deployment system that teaches as it deploys.

**Go build. Go ship. Go empower.**

---

*"Technology that serves consciousness. Deployment that empowers creators."*

**— Hermetic Ormus**

---

## 📋 Quick Reference Card

```
ESSENTIAL COMMANDS
═══════════════════

/ship                 → Deploy anything (interactive wizard)
/deploy-supabase      → Deploy to Supabase (backend + DB)
/deploy-docker        → Deploy with Docker
/deploy-vercel        → Deploy to Vercel (frontend)
/deploy-netlify       → Deploy to Netlify (frontend)

TEMPLATES
═══════════════════

~/.mcp/templates/docker/node/
~/.mcp/templates/docker/python/
~/.mcp/templates/docker/fullstack/

DOCUMENTATION
═══════════════════

~/.mcp/docs/DEPLOYMENT-ARCHITECTURE.md
~/.mcp/docs/DEPLOYMENT-QUICKSTART.md
~/.mcp/templates/docker/README.md

SETUP REQUIRED
═══════════════════

⚠️ Supabase token: Edit ~/.mcp/config/active/current-config.json
✅ Docker: Already installed
🔧 Vercel: npm install -g vercel (optional)
🔧 Netlify: npm install -g netlify-cli (optional)
```
