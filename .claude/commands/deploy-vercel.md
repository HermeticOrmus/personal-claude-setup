---
description: Deploy frontend application to Vercel
tags: deployment, vercel, frontend
---

You are deploying a frontend application to Vercel.

Best for: Next.js, React, Vue, Svelte, static sites

## Pre-Deployment Checklist

1. ✅ Vercel CLI installed (`npm install -g vercel`)
2. ✅ Logged in to Vercel (`vercel login`)
3. ✅ Project builds successfully
4. ✅ Environment variables configured

## Deployment Workflow

### Step 1: Verify Vercel CLI

```bash
# Check if installed
vercel --version

# If not installed
npm install -g vercel

# Login
vercel login

# Check authentication
vercel whoami
```

### Step 2: Analyze Project

Check for existing configuration:

```bash
# Look for Vercel config
cat vercel.json

# Check build settings in package.json
cat package.json | grep -E "(build|scripts)"

# Check environment variables
ls -la .env .env.local .env.production
```

If no vercel.json, create one:

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm install",
  "framework": "nextjs",
  "env": {
    "NEXT_PUBLIC_API_URL": "@api_url"
  }
}
```

### Step 3: Test Build Locally

Before deploying, ensure build works:

```bash
# Install dependencies
npm install

# Run build
npm run build

# Test production build locally
npm run start
# or
npx serve dist
```

If build fails, fix errors before proceeding.

### Step 4: Deploy to Preview (Development)

Deploy to preview environment first:

```bash
# Deploy to preview
vercel

# This will:
# 1. Build your project
# 2. Deploy to preview URL
# 3. Return preview URL

# Get deployment URL from output
# Example: https://your-project-abc123.vercel.app
```

### Step 5: Test Preview Deployment

```bash
# If Puppeteer MCP available, run automated tests
# Otherwise, manual testing:

# 1. Visit preview URL
# 2. Test all pages
# 3. Check console for errors
# 4. Test API connections
# 5. Verify environment variables

# Check deployment logs
vercel logs {deployment-url}
```

### Step 6: Deploy to Production

If preview looks good:

```bash
# Deploy to production
vercel --prod

# This will:
# 1. Build project
# 2. Deploy to production domain
# 3. Update production URL

# Alternative: Promote preview to production
vercel promote {preview-url}
```

### Step 7: Configure Custom Domain (Optional)

```bash
# Add custom domain
vercel domains add yourdomain.com

# Configure DNS
# Vercel will show DNS records to add

# Verify domain
vercel domains inspect yourdomain.com
```

### Step 8: Environment Variables

```bash
# List environment variables
vercel env ls

# Add environment variable
vercel env add NEXT_PUBLIC_API_URL production

# Pull environment variables to local
vercel env pull .env.local
```

### Step 9: Post-Deployment Validation

```bash
# Check deployment status
vercel inspect {url}

# View logs
vercel logs {url}

# Check performance
# Use Vercel Analytics or Lighthouse

# Test edge functions (if any)
curl https://your-domain.com/api/endpoint
```

## GitHub Integration (Recommended)

Set up automatic deployments:

```bash
# Link GitHub repo
vercel link

# This enables:
# - Auto-deploy on push to main (production)
# - Auto-deploy on PR (preview)
# - Deployment comments on PRs
```

Configuration in GitHub:
1. Go to Vercel dashboard
2. Connect GitHub repository
3. Configure:
   - Production branch: main
   - Preview branches: all others
   - Build settings
   - Environment variables

## Rollback Procedure

If deployment has issues:

```bash
# List recent deployments
vercel ls

# Promote previous deployment
vercel promote {previous-url}

# Or re-deploy specific commit
git checkout {previous-commit}
vercel --prod
```

## Framework-Specific Tips

### Next.js
```json
{
  "framework": "nextjs",
  "buildCommand": "next build",
  "devCommand": "next dev",
  "installCommand": "npm install"
}
```

### React (Vite)
```json
{
  "framework": "vite",
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm install"
}
```

### Vue
```json
{
  "framework": "vue",
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm install"
}
```

### Static Site
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "build",
  "routes": [
    { "src": "/api/(.*)", "dest": "/api/$1" },
    { "src": "/(.*)", "dest": "/index.html" }
  ]
}
```

## Performance Optimization

```bash
# Enable Edge Network
# (Already enabled by default)

# Configure caching headers
# In vercel.json:
{
  "headers": [
    {
      "source": "/static/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    }
  ]
}

# Enable Image Optimization (Next.js)
# Already built-in with next/image
```

## Monitoring

```bash
# View real-time logs
vercel logs --follow

# Check deployment analytics
# Visit Vercel dashboard → Analytics

# Set up alerts
# Vercel dashboard → Settings → Notifications
```

## Troubleshooting

**Build fails:**
```bash
# Check build logs
vercel logs {url}

# Test locally
npm run build

# Check environment variables
vercel env ls
```

**404 errors:**
```bash
# Check routes in vercel.json
# For SPA, ensure catch-all route:
{
  "routes": [
    { "src": "/(.*)", "dest": "/index.html" }
  ]
}
```

**API routes not working:**
```bash
# Ensure API routes in /api directory
# Check serverless function logs
vercel logs {url} --follow
```

## Hermetic Principles

**Vibration** - Deploy preview first, validate, then production
**Polarity** - Balance speed (automatic deploys) with quality (testing)
**Rhythm** - Use preview → test → production cycle consistently

---

**Execute deployment workflow. Deploy to preview, test, then production.**
