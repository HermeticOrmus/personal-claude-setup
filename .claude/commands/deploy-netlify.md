---
description: Deploy frontend application to Netlify
tags: deployment, netlify, frontend
---

You are deploying a frontend application to Netlify.

Best for: Static sites, JAMstack, React, Vue, Svelte, Hugo, Jekyll

## Pre-Deployment Checklist

1. ✅ Netlify CLI installed (`npm install -g netlify-cli`)
2. ✅ Logged in to Netlify (`netlify login`)
3. ✅ Project builds successfully
4. ✅ Environment variables configured

## Deployment Workflow

### Step 1: Verify Netlify CLI

```bash
# Check if installed
netlify --version

# If not installed
npm install -g netlify-cli

# Login
netlify login

# Check authentication
netlify status
```

### Step 2: Analyze Project

Check for existing configuration:

```bash
# Look for Netlify config
cat netlify.toml

# Check build settings in package.json
cat package.json | grep -E "(build|scripts)"

# Check for _redirects or _headers
cat public/_redirects
cat public/_headers
```

If no netlify.toml, create one:

```toml
[build]
  command = "npm run build"
  publish = "dist"
  functions = "netlify/functions"

[build.environment]
  NODE_VERSION = "20"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/static/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"
```

### Step 3: Initialize Netlify

Link project to Netlify:

```bash
# Initialize (creates .netlify directory)
netlify init

# This will:
# 1. Create new site OR link existing
# 2. Configure build settings
# 3. Set up deployment
```

### Step 4: Test Build Locally

```bash
# Install dependencies
npm install

# Test build
netlify build

# This runs:
# - Build command
# - Post-processing
# - Functions bundling
```

### Step 5: Deploy to Preview (Draft)

```bash
# Deploy as draft (preview)
netlify deploy

# Select publish directory (e.g., dist, build, public)

# Get preview URL from output
# Example: https://5e1a2b3c4d5e6f7g.netlify.app
```

### Step 6: Test Preview Deployment

Test the preview URL:

```bash
# Manual testing checklist:
# 1. All pages load correctly
# 2. Forms work (if using Netlify Forms)
# 3. Functions work (if using Netlify Functions)
# 4. Redirects work as expected
# 5. No console errors

# If using Puppeteer MCP, run automated tests
```

### Step 7: Deploy to Production

If preview looks good:

```bash
# Deploy to production
netlify deploy --prod

# This will:
# 1. Build project
# 2. Deploy to production domain
# 3. Update production URL
# 4. Invalidate CDN cache
```

### Step 8: Configure Custom Domain

```bash
# Add custom domain
netlify domains:create yourdomain.com

# Configure DNS
# Netlify will show DNS records

# Enable HTTPS (automatic with Let's Encrypt)
# Already enabled by default

# Verify domain
netlify domains:list
```

### Step 9: Environment Variables

```bash
# Set environment variable
netlify env:set NEXT_PUBLIC_API_URL "https://api.example.com"

# List environment variables
netlify env:list

# Get specific variable
netlify env:get NEXT_PUBLIC_API_URL

# Import from .env file
netlify env:import .env
```

### Step 10: Post-Deployment Validation

```bash
# Check site status
netlify status

# View deployment info
netlify open:site

# Check logs
netlify logs

# Run functions locally (for testing)
netlify functions:serve
```

## Netlify Features

### Forms

Add to HTML:
```html
<form name="contact" netlify>
  <input type="text" name="name" />
  <input type="email" name="email" />
  <button type="submit">Submit</button>
</form>
```

Handle in netlify.toml:
```toml
[[forms]]
  name = "contact"
  fields = ["name", "email"]
```

### Functions (Serverless)

Create function:
```javascript
// netlify/functions/hello.js
exports.handler = async (event, context) => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello World" })
  };
};
```

Deploy:
```bash
netlify deploy --prod
```

Access:
```
https://yoursite.netlify.app/.netlify/functions/hello
```

### Redirects & Rewrites

In netlify.toml:
```toml
[[redirects]]
  from = "/api/*"
  to = "https://api.example.com/:splat"
  status = 200

[[redirects]]
  from = "/old-page"
  to = "/new-page"
  status = 301

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

Or in public/_redirects:
```
/api/*  https://api.example.com/:splat  200
/old-page  /new-page  301
/*  /index.html  200
```

### Edge Functions (Advanced)

```javascript
// netlify/edge-functions/hello.ts
export default async (request: Request, context: Context) => {
  return new Response("Hello from the edge!");
};

export const config = {
  path: "/edge-hello"
};
```

## GitHub Integration

Set up automatic deployments:

```bash
# Link GitHub repo in Netlify dashboard:
# 1. Go to Netlify dashboard
# 2. New site from Git
# 3. Connect GitHub
# 4. Select repository
# 5. Configure build settings

# This enables:
# - Auto-deploy on push to main
# - Deploy previews on PRs
# - Split testing
```

## Rollback Procedure

```bash
# List deployments
netlify deploy:list

# Restore previous deployment
netlify deploy:restore {deploy-id}

# Or re-deploy specific commit
git checkout {previous-commit}
netlify deploy --prod
```

## Performance Optimization

### Asset Optimization
```toml
[build.processing]
  skip_processing = false

[build.processing.css]
  bundle = true
  minify = true

[build.processing.js]
  bundle = true
  minify = true

[build.processing.images]
  compress = true
```

### Caching Headers
```toml
[[headers]]
  for = "/static/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"

[[headers]]
  for = "/*.js"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"
```

## Split Testing

Test two versions:
```toml
[[redirects]]
  from = "/*"
  to = "/version-a/:splat"
  status = 200
  conditions = {Cookie=[ab_test=a]}

[[redirects]]
  from = "/*"
  to = "/version-b/:splat"
  status = 200
  conditions = {Cookie=[ab_test=b]}
```

## Monitoring

```bash
# View site analytics
netlify open:admin

# Check logs
netlify logs

# Monitor functions
netlify functions:list
netlify functions:invoke {function-name}
```

## Troubleshooting

**Build fails:**
```bash
# Check build logs
netlify logs

# Test locally
netlify build

# Check environment variables
netlify env:list
```

**Form submissions not working:**
```bash
# Ensure form has netlify attribute
# Check form name matches HTML
# View submissions in Netlify dashboard
```

**Functions failing:**
```bash
# Test locally first
netlify functions:serve

# Check function logs
netlify logs --function={name}

# Verify function configuration
```

**Redirects not working:**
```bash
# Check _redirects file or netlify.toml
# Verify syntax
# Test with curl -I
curl -I https://yoursite.netlify.app/redirect-path
```

## Hermetic Principles

**Vibration** - Deploy drafts, test, iterate quickly
**Correspondence** - Infrastructure as code (netlify.toml)
**Rhythm** - Consistent deployment workflow

---

**Execute deployment workflow. Test locally, deploy draft, validate, deploy production.**
