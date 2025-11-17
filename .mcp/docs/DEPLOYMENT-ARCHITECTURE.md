# Sacred Deployment Architecture
## Hermetic Multi-Target Deployment System

> **Philosophy**: Ship with consciousness. Every deployment serves human flourishing.

**Last Updated**: 2025-11-09
**Status**: Active Development

---

## 🎯 Vision

A complete deployment pipeline that allows shipping from Claude Code terminal to any target:
- **Supabase** (backend + database + serverless)
- **Docker** (containerized services)
- **Vercel/Netlify** (frontend)
- **Cloud Providers** (AWS/GCP/Azure)

**Inspired by**: Tomás's automated AI deployment system
**Adapted for**: Ormus's sacred technology practice

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    CLAUDE CODE (Orchestrator)                │
│                  "The Sacred Intelligence"                   │
└───────────────────────┬─────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┬──────────────┐
        │               │               │              │
        ▼               ▼               ▼              ▼
    ┌───────┐      ┌────────┐     ┌─────────┐   ┌──────────┐
    │GitHub │      │Supabase│     │  Docker │   │   n8n    │
    │  MCP  │      │  MCP   │     │Container│   │   MCP    │
    └───┬───┘      └───┬────┘     └────┬────┘   └────┬─────┘
        │              │               │             │
        │              │               │             │
        ▼              ▼               ▼             ▼
   ┌─────────┐   ┌──────────┐    ┌─────────┐  ┌──────────┐
   │ Version │   │ Backend  │    │Self-Host│  │Automation│
   │ Control │   │ Deploy   │    │ Deploy  │  │Workflows │
   │  + PRs  │   │+ DB Mgmt │    │+ Scaling│  │+ Orchestr│
   └─────────┘   └──────────┘    └─────────┘  └──────────┘
```

---

## 🔧 Available MCPs

### Currently Configured

1. **filesystem** - File operations
2. **memory** - Knowledge graph persistence
3. **github** ✅ - Repository management, PRs, branches
4. **puppeteer** ✅ - Browser testing (validation)
5. **telegram** - Messaging integration
6. **whatsapp** - WhatsApp automation
7. **n8n** ✅ - Workflow orchestration
8. **discord** - Community management
9. **supabase** ✅ - **NEWLY ADDED** - Backend deployment

### Supabase MCP Capabilities

**Database Management:**
- Execute SQL queries
- Apply migrations
- List tables and extensions
- Manage database schema

**Edge Functions:**
- Deploy serverless functions
- List and get function code
- Update existing functions

**Development Branches:**
- Create development branches
- Merge to production
- Reset and rebase branches
- Isolated testing environments

**Project Management:**
- Get project URL and API keys
- Generate TypeScript types
- Monitor logs and advisors
- Security and performance checks

---

## 🚀 Deployment Workflows

### 1. Supabase Full-Stack Deployment

**Use Case**: Backend + Database + Serverless Functions

**Workflow:**
```
1. Development
   ├─ Write code in local project
   ├─ Create migrations (schema changes)
   └─ Develop Edge Functions

2. Testing (Development Branch)
   ├─ supabase.create_branch("feature-branch")
   ├─ supabase.apply_migration(...)
   ├─ supabase.deploy_edge_function(...)
   └─ Test in isolated environment

3. Validation
   ├─ Run tests (Puppeteer MCP)
   ├─ Check advisors (security/performance)
   └─ Get logs for debugging

4. Production Deployment
   ├─ supabase.merge_branch("feature-branch")
   └─ Monitor production logs

5. Version Control
   ├─ github.create_pull_request(...)
   └─ Document changes
```

**Commands (to be created):**
- `/deploy-supabase` - Full deployment workflow
- `/test-supabase` - Run validation suite
- `/rollback-supabase` - Emergency rollback

---

### 2. Docker Containerized Deployment

**Use Case**: Self-hosted services, microservices, complex apps

**Workflow:**
```
1. Development
   ├─ Write Dockerfile
   ├─ Create docker-compose.yml
   └─ Define services

2. Local Testing
   ├─ docker-compose up -d
   ├─ Run integration tests
   └─ Check logs

3. Build & Push
   ├─ docker build -t registry/image:tag .
   ├─ docker push registry/image:tag
   └─ Tag versions

4. Deployment
   ├─ SSH to server (or use orchestrator)
   ├─ docker-compose pull
   ├─ docker-compose up -d
   └─ Health checks

5. Version Control
   ├─ github.create_pull_request(...)
   └─ Tag release
```

**Commands (to be created):**
- `/deploy-docker` - Build and deploy containers
- `/docker-compose` - Manage multi-service apps
- `/docker-logs` - Monitor container logs

**Templates Needed:**
- Dockerfile templates (Node, Python, Go, etc.)
- docker-compose.yml templates
- Deployment scripts

---

### 3. Frontend Deployment (Vercel/Netlify)

**Use Case**: Static sites, SPAs, Next.js/React apps

**Workflow:**
```
1. Development
   ├─ Build frontend code
   ├─ Optimize assets
   └─ Configure deployment

2. Testing
   ├─ Run build locally
   ├─ Test with Puppeteer
   └─ Performance checks

3. Deployment
   ├─ Push to GitHub (triggers auto-deploy)
   │  OR
   ├─ Use Vercel/Netlify CLI
   └─ Monitor deployment

4. Validation
   ├─ Check deployment logs
   ├─ Test live site
   └─ Performance metrics
```

**Commands (to be created):**
- `/deploy-vercel` - Deploy to Vercel
- `/deploy-netlify` - Deploy to Netlify
- `/test-frontend` - Run frontend tests

**Tools Needed:**
- Vercel CLI setup
- Netlify CLI setup
- GitHub Actions workflows

---

### 4. n8n Orchestration Workflow

**Use Case**: Complex multi-step deployments, automation

**Workflow:**
```
1. Define Workflow
   ├─ Create n8n workflow
   ├─ Define deployment steps
   └─ Configure error handling

2. Trigger Options
   ├─ Webhook (from GitHub)
   ├─ Manual trigger
   ├─ Schedule
   └─ Event-based

3. Execution
   ├─ Build code
   ├─ Run tests
   ├─ Deploy to target
   ├─ Notify on completion
   └─ Rollback on failure

4. Monitoring
   ├─ Track execution
   ├─ Log results
   └─ Alert on errors
```

**Example Workflows:**
- Full-stack deployment (Frontend → Backend → Database)
- Multi-environment deployment (Dev → Staging → Prod)
- Automated testing + deployment
- Continuous deployment pipeline

---

## 🤖 AI Agent Architecture (Inspired by Tomás)

### The Sacred Agents

**1. Code Generator Agent (Claude Code)**
- Receives task/issue
- Writes code
- Runs initial tests
- Submits for validation

**2. Validator Agent (Claude Code + Puppeteer)**
- Reviews code quality
- Runs automated tests
- Checks security advisors
- Provides feedback to Generator

**3. Orchestrator (n8n + GitHub)**
- Manages workflow
- Coordinates agents
- Handles deployment
- Monitors progress

### Feedback Loop

```
Issue Created (GitHub)
     │
     ▼
Code Generator (Claude) ──► Code + Tests
     │
     ▼
Validator (Claude + Puppeteer) ──► Pass/Fail
     │                                │
     │ FAIL ◄──────────────────────────┘
     │ (Feedback)
     │
     ▼ PASS
Deployment (Supabase/Docker/etc.)
     │
     ▼
Pull Request (GitHub)
     │
     ▼
Human Review
```

---

## 📋 Deployment Checklist Template

**Pre-Deployment:**
- [ ] Code reviewed
- [ ] Tests passing
- [ ] Security advisors checked
- [ ] Performance validated
- [ ] Documentation updated
- [ ] Environment variables configured
- [ ] Database migrations ready

**Deployment:**
- [ ] Create development branch (if Supabase)
- [ ] Run deployment workflow
- [ ] Monitor logs
- [ ] Verify deployment success
- [ ] Run smoke tests

**Post-Deployment:**
- [ ] Create PR with changes
- [ ] Update changelog
- [ ] Notify stakeholders
- [ ] Monitor metrics
- [ ] Celebrate! (/celebrate)

---

## 🛠️ Configuration Requirements

### Supabase Setup

**Required:**
1. Create Supabase account at https://supabase.com
2. Create project or use existing
3. Generate access token:
   - Go to Account Settings → Access Tokens
   - Create new token with project permissions
4. Get project ID (optional, can be set per-project)
5. Configure in MCP:
   ```json
   "SUPABASE_ACCESS_TOKEN": "sbp_xxxxx..."
   "SUPABASE_PROJECT_ID": "your-project-id" // optional
   ```

### Docker Setup

**Already Installed:**
- Docker v28.3.2 ✅
- Docker Compose ✅

**Recommended:**
- Docker Hub account (for registry)
- Private registry (optional)

### Vercel/Netlify Setup

**Needed:**
1. Install Vercel CLI: `npm install -g vercel`
2. Login: `vercel login`
3. Configure project: `vercel link`

OR

1. Install Netlify CLI: `npm install -g netlify-cli`
2. Login: `netlify login`
3. Configure project: `netlify link`

---

## 🎯 Next Steps

### Phase 1: Core Infrastructure ✅
- [x] Add Supabase MCP
- [x] Document architecture
- [ ] Create deployment templates

### Phase 2: Automation
- [ ] Create slash commands (`/deploy-*`)
- [ ] Build n8n workflows
- [ ] Set up GitHub Actions

### Phase 3: Testing
- [ ] Integration tests
- [ ] End-to-end deployment test
- [ ] Rollback procedures

### Phase 4: Documentation
- [ ] Video walkthroughs
- [ ] Example projects
- [ ] Troubleshooting guide

---

## 🌟 Hermetic Principles Applied

**Mentalism** - Clear intention before deployment. Know WHY you're shipping.

**Correspondence** - Infrastructure reflects values. Clean code → Clean deployment.

**Vibration** - Ship iteratively. Use dev branches. Test in production-like environments.

**Polarity** - Balance speed and quality. Automation + human oversight.

**Rhythm** - 6-day cycles. Don't deploy on Day 7 (rest/integrate).

**Cause & Effect** - Every deployment has consequences. Monitor, measure, learn.

**Gender** - Combine masculine building with feminine intuition. Trust tests + trust gut.

---

## 📚 Resources

**Documentation:**
- Supabase Docs: https://supabase.com/docs
- Docker Docs: https://docs.docker.com
- n8n Docs: https://docs.n8n.io
- GitHub Actions: https://docs.github.com/actions

**Templates:**
- `~/.mcp/templates/docker/` - Docker templates
- `~/.mcp/templates/supabase/` - Supabase templates
- `~/.mcp/templates/workflows/` - n8n workflows

**Commands:**
- `~/.claude/commands/deploy-*.md` - Deployment commands

---

## 🔮 Future Enhancements

**Advanced Features:**
- [ ] Blue-green deployments
- [ ] Canary releases
- [ ] A/B testing infrastructure
- [ ] Multi-region deployment
- [ ] Automated scaling
- [ ] Cost optimization
- [ ] Security scanning
- [ ] Performance monitoring

**Integration:**
- [ ] Slack/Discord notifications
- [ ] Monitoring dashboards
- [ ] Error tracking (Sentry)
- [ ] Analytics integration

---

*"Ship with consciousness. Every deployment is an act of creation."*

**— Hermetic Ormus**
