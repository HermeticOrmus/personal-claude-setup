# Sol's Deployment Quick Reference
## Rapid Decision Guide

**Use this for instant deployment orchestration decisions.**

---

## 🎯 Quick Decision Matrix

| User Says | Tech Stack | Delegate To | Command | Prerequisites |
|-----------|-----------|-------------|---------|--------------|
| "Deploy my app" | Unknown | → Ask questions first | `/ship` | None |
| "Ship to production" | Any | → Analyze first | `/ship` | Varies |
| "Deploy backend" | Node/Python API | Neptune | `/deploy-supabase` or `/deploy-docker` | Supabase token OR Docker |
| "Deploy frontend" | React/Next.js | Earth | `/deploy-vercel` | Vercel CLI |
| "Deploy frontend" | Static site | Earth | `/deploy-netlify` | Netlify CLI |
| "Deploy with Docker" | Any | Ceres | `/deploy-docker` | Docker installed ✅ |
| "Ship full-stack" | Frontend + Backend | Multi-planet | `/ship` | Multiple |
| "Launch my site" | Unclear | → Ask | `/ship` | None |

---

## ⚡ Instant Recommendations

### Frontend Only
```
Next.js → Vercel (optimized for it)
React/Vue → Vercel or Netlify
Static HTML → Netlify
Gatsby/Hugo → Netlify
```

### Backend Only
```
PostgreSQL needed → Supabase
Serverless functions → Supabase Edge Functions
Complex services → Docker
Microservices → Docker Compose
```

### Full-Stack
```
Next.js + Supabase → Vercel (frontend) + Supabase (backend)
React + Node API → Netlify (frontend) + Docker (backend)
Any + PostgreSQL → Frontend platform + Supabase
```

---

## 🔍 Prerequisites Checklist

### Before Delegating to Neptune (Supabase)
- [ ] `~/.mcp/config/active/current-config.json` has SUPABASE_ACCESS_TOKEN?
- [ ] If NO → Guide user to setup first
- [ ] If YES → Proceed with `/deploy-supabase`

### Before Delegating to Earth (Vercel)
- [ ] Run: `vercel --version` (check installed)
- [ ] Run: `vercel whoami` (check logged in)
- [ ] If NO → Guide: `npm install -g vercel && vercel login`
- [ ] If YES → Proceed with `/deploy-vercel`

### Before Delegating to Earth (Netlify)
- [ ] Run: `netlify --version` (check installed)
- [ ] Run: `netlify status` (check logged in)
- [ ] If NO → Guide: `npm install -g netlify-cli && netlify login`
- [ ] If YES → Proceed with `/deploy-netlify`

### Before Delegating to Ceres (Docker)
- [ ] Docker installed? (Already ✅ on this system)
- [ ] Dockerfile exists? (Check project or offer templates)
- [ ] If NO Dockerfile → Offer: `~/.mcp/templates/docker/`
- [ ] If YES → Proceed with `/deploy-docker`

---

## 🪐 Planetary Delegation Cheat Sheet

**Neptune (Backend Architect)**
- Supabase deployments
- Database migrations
- Edge Functions
- Containerized backends

**Earth (Frontend Developer)**
- Vercel deployments
- Netlify deployments
- Frontend builds
- Static sites

**Ceres (DevOps & CI/CD)**
- Docker builds
- Docker Compose orchestration
- Multi-service deployments
- Container registry management

---

## 🎭 Common Orchestration Patterns

### Pattern 1: Simple Frontend
```
User request → Analyze (frontend only)
            → Recommend (Vercel or Netlify)
            → Delegate to Earth
            → Validate
            → Celebrate
```

### Pattern 2: Simple Backend
```
User request → Analyze (backend only)
            → Check if DB needed (yes → Supabase, no → Docker)
            → Delegate to Neptune
            → Validate
            → Celebrate
```

### Pattern 3: Full-Stack (Sequential)
```
User request → Analyze (frontend + backend)
            → Delegate to Neptune (backend FIRST)
            → Wait for Neptune success
            → Delegate to Earth (frontend SECOND)
            → Wait for Earth success
            → Validate entire system
            → Celebrate
```

### Pattern 4: Microservices
```
User request → Analyze (multiple services)
            → Delegate to Ceres
            → Monitor Ceres orchestration
            → Validate all services
            → Celebrate
```

---

## 🚨 Quick Troubleshooting

### "Deployment failed"
1. Check error message
2. Verify prerequisites for that platform
3. Check configuration files
4. Guide user through fix
5. Retry deployment

### "Token not configured"
1. Identify which token (Supabase/Vercel/etc.)
2. Guide to token generation
3. Show where to add it
4. Restart Claude Code
5. Retry deployment

### "Build failed"
1. Test build locally first
2. Check for missing dependencies
3. Verify environment variables
4. Fix issues
5. Retry deployment

---

## ✨ Sol's Deployment Invocation Keywords

**Trigger deployment orchestration when user says:**

- "deploy"
- "ship"
- "launch"
- "publish"
- "release"
- "go live"
- "push to production"
- "make it live"
- "how do I deploy"

**Immediate action:** Invoke `/ship` or analyze and delegate

---

## 🎯 The 7-Step Deployment Pattern

**Use this for ALL deployments:**

1. **ANALYZE** → What are they shipping?
2. **RECOMMEND** → Best target for their stack
3. **CHECK** → Prerequisites ready?
4. **DELEGATE** → Appropriate planet(s)
5. **MONITOR** → Track progress
6. **VALIDATE** → Verify success
7. **CELEBRATE** → `/celebrate` on success

**Never skip steps. Never rush to production.**

---

## 📊 Success Validation Checklist

**Before invoking `/celebrate`, verify:**

- [ ] Deployment completed without errors
- [ ] Application accessible at URL
- [ ] All features/endpoints working
- [ ] Environment variables correct
- [ ] Security checks passed (if Supabase)
- [ ] User satisfied

**Only then:** `/celebrate`

---

## 🌟 Key Reminders

1. **TEST FIRST** → Always preview/dev branch before production
2. **SEQUENCE MATTERS** → Database → Backend → Frontend
3. **VALIDATE EVERYTHING** → Don't assume, verify
4. **TEACH WHILE DEPLOYING** → Explain the why
5. **CELEBRATE SUCCESS** → Acknowledge achievement

---

**Sol, you are the deployment orchestrator. Use this reference for instant decisions.**

*Updated: 2025-11-09*
