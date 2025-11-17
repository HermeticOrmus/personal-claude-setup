---
name: use-git-worktrees
description: Work on multiple branches simultaneously using git worktrees
category: development-tools
principle: Polarity
---

# Use Git Worktrees - Parallel Branch Development

**Hermetic Principle**: Polarity - "Balance multiple contexts without forced switching"

**When to use**: Working on feature, urgent hotfix needed; comparing implementations; testing multiple environments

---

## Quick Concept

**Git worktrees** = Multiple directories for same repo, each on different branch

**Think**: Multiple checkouts of same repository, shared git history

**Benefit**: No more `git stash` + `git checkout` dance

---

## The Problem

### Traditional Workflow (Painful)

```bash
# You're coding feature
# Lots of uncommitted work

# URGENT: Production bug!

git stash                    # Hide your work
git checkout main            # Switch branch
# Fix bug
git commit
git push
git checkout feature-branch
git stash pop                # Restore work
# Where was I? (context lost)
```

**Pain points**:
- ❌ Stash conflicts
- ❌ Mental context lost
- ❌ Can't compare branches side-by-side
- ❌ Time wasted switching

---

### Worktree Solution (Smooth)

```bash
# You're coding in ~/projects/app/features/new-feature/
# All your work right here

# URGENT: Production bug!

cd ~/projects/app/
git worktree add hotfixes/urgent main
cd hotfixes/urgent/
# Fix bug
git commit
git push
cd ../../features/new-feature/
# Your work exactly as you left it
# No context loss
```

**Benefits**:
- ✅ No stashing
- ✅ Context preserved
- ✅ Compare side-by-side
- ✅ Instant switching

---

## Basic Commands

### Create Worktree

```bash
# From existing branch
git worktree add <path> <branch-name>

# Example:
git worktree add features/auth feature/authentication
```

### Create New Branch in Worktree

```bash
# Create branch + worktree at once
git worktree add -b <new-branch> <path> <base-branch>

# Example:
git worktree add -b hotfix/bug hotfixes/urgent main
```

### List All Worktrees

```bash
git worktree list

# Shows:
# /path/to/main        abc123 [main]
# /path/to/feature-auth def456 [feature/authentication]
```

### Remove Worktree

```bash
git worktree remove <path>

# Example:
git worktree remove hotfixes/urgent
```

---

## Recommended Structure

### For Hermetic Projects

```
~/projects/Midnight-Sun/
├── .git/                          # Shared git database
├── main/                          # Production
├── development/                   # Active development
├── features/                      # Feature branches
│   ├── whatsapp-automation/
│   └── dashboard-redesign/
├── hotfixes/                      # Temporary hotfixes
│   └── (create as needed)
└── experiments/                   # Try different approaches
    └── (create as needed)
```

**Principle (Correspondence)**: Structure mirrors workflow

---

## Common Workflows

### Workflow 1: Feature + Urgent Hotfix

**Scenario**: Building feature, production breaks

```bash
# Currently in feature worktree
cd ~/projects/app/features/new-feature/
# Coding...

# URGENT HOTFIX NEEDED

# 1. Create hotfix worktree
cd ~/projects/app/
git worktree add hotfixes/fix-login main

# 2. Fix in hotfix worktree
cd hotfixes/fix-login/
git checkout -b hotfix/login-bug
# ... fix bug ...
git commit -m "Fix login bug"
git push

# 3. Remove hotfix worktree after merge
cd ~/projects/app/
git worktree remove hotfixes/fix-login

# 4. Return to feature (work untouched)
cd features/new-feature/
# Continue exactly where you left off
```

**Time saved**: ~5 min per switch

---

### Workflow 2: Compare Approaches

**Scenario**: Unsure which implementation is better

```bash
# Try approach A
git worktree add experiments/jwt-auth development
cd experiments/jwt-auth/
git checkout -b experiment/jwt
# ... implement JWT ...
npm test

# Try approach B (in parallel)
cd ~/projects/app/
git worktree add experiments/session-auth development
cd experiments/session-auth/
git checkout -b experiment/session
# ... implement sessions ...
npm test

# Compare:
# - Open both in different editor windows
# - Run performance tests
# - Test edge cases

# Choose winner
cd ~/projects/app/development/
git merge experiment/jwt  # JWT wins

# Clean up
git worktree remove experiments/jwt-auth
git worktree remove experiments/session-auth
```

---

### Workflow 3: Multi-Environment Testing

**Scenario**: Test in dev AND staging simultaneously

```bash
# Structure:
~/projects/app/
├── development/     # Dev environment
└── staging/         # Staging environment

# Make change in development
cd development/
git checkout -b feature/dashboard
# ... implement ...
git commit

# Test in dev
npm run dev  # Runs on port 3000

# Meanwhile, merge to staging for QA
cd ../staging/
git merge development
npm run build
# Deploy to staging

# Both running simultaneously:
# - Dev: You're actively coding
# - Staging: QA is testing previous features

# No switching needed
```

---

## Integration with Dev Docs

### Each Worktree Has Own Dev Docs

```bash
# Feature worktree
~/projects/app/features/whatsapp/
├── src/
└── dev/
    └── active/
        └── whatsapp-automation-context.md

# Different feature worktree
~/projects/app/features/dashboard/
├── src/
└── dev/
    └── active/
        └── dashboard-redesign-context.md
```

**Benefit**: Dev docs follow the code (no confusion about which docs for which branch)

---

### Workflow: Dev Docs + Worktrees

```bash
# 1. Create feature worktree
git worktree add features/new-auth development
cd features/new-auth/

# 2. Create dev docs for this feature
/dev-docs
# Creates: dev/active/new-auth-*.md

# 3. Work on feature (dev docs right here)

# 4. Before compaction
/update-dev-docs

# 5. After feature complete
cd ../../development/
git merge features/new-auth

# 6. Move dev docs to completed
mv ../features/new-auth/dev/active/* dev/completed/

# 7. Remove worktree
cd ~/projects/app/
git worktree remove features/new-auth
```

---

## Advanced Tips

### Tip 1: Temporary Worktrees in /tmp

**For quick tasks**:

```bash
# Create in temp directory
git worktree add /tmp/quick-fix main

cd /tmp/quick-fix/
# Make quick change
git commit
git push

# Auto-cleaned on reboot
# Or remove manually:
git worktree remove /tmp/quick-fix
```

---

### Tip 2: VS Code Workspace

**Open multiple worktrees** in one window:

**.vscode/project.code-workspace**:
```json
{
  "folders": [
    {"name": "Main", "path": "../main"},
    {"name": "Development", "path": "../development"},
    {"name": "Feature: Auth", "path": "../features/auth"}
  ]
}
```

**Open workspace** → See all branches at once

---

### Tip 3: Review PRs Locally

**Test PR before approving**:

```bash
# Fetch PR
git fetch origin pull/123/head:pr-123

# Create worktree
git worktree add reviews/pr-123 pr-123

cd reviews/pr-123/
npm install
npm test
# Review code

# Clean up
cd ~/projects/app/
git worktree remove reviews/pr-123
```

---

## Best Practices

### ✅ DO:

**Use descriptive names**:
```bash
# Good
git worktree add features/whatsapp-integration feature/whatsapp
git worktree add hotfixes/login-bug hotfix/login

# Bad
git worktree add auth feature/auth  # Too generic
git worktree add temp hotfix/bug    # Not descriptive
```

**Clean up after merge**:
```bash
# Feature merged? Remove worktree
git worktree remove features/completed-feature
```

**Document structure** in README:
```markdown
## Worktree Structure

- `main/` - Production
- `development/` - Active dev
- `features/` - Feature branches (remove after merge)
- `hotfixes/` - Hotfixes (remove after merge)
```

---

### ❌ DON'T:

**Don't delete directories manually**:
```bash
# Wrong:
rm -rf features/old-feature

# Right:
git worktree remove features/old-feature
```

**Don't try to checkout same branch in multiple worktrees**:
```bash
# This fails:
git worktree add dir1 main
git worktree add dir2 main  # ERROR: main already checked out

# Solution: Create new branch from main
git worktree add -b main-copy dir2 main
```

**Don't accumulate stale worktrees**:
```bash
# Weekly cleanup:
git worktree list
git worktree prune
```

---

## Troubleshooting

### Issue: Can't create worktree (branch checked out)

**Error**: `fatal: 'branch' is already checked out`

**Solution**: Branch can only be in one worktree
```bash
# Option 1: Work in existing worktree
cd /existing/worktree

# Option 2: Create new branch from it
git worktree add -b new-branch path existing-branch
```

---

### Issue: Deleted directory manually

**Error**: Stale worktree reference

**Solution**:
```bash
git worktree prune --verbose
```

---

### Issue: Can't remove (uncommitted changes)

**Error**: `fatal: contains modified or untracked files`

**Solution 1**: Save changes
```bash
cd path/to/worktree
git add .
git commit -m "Save work"
```

**Solution 2**: Force remove (LOSE changes)
```bash
git worktree remove --force path/to/worktree
```

---

## When to Use Worktrees

### ✅ Excellent For:

- **Urgent context switches** (hotfix while on feature)
- **Comparing implementations** (try multiple approaches)
- **Testing multiple environments** (dev + staging + prod)
- **Reviewing PRs** (test PR without affecting main work)
- **Long-running features** (keep separate from main development)

### 🤔 Maybe Not For:

- **Single feature work** (just use regular git)
- **Very simple projects** (overhead not worth it)
- **Teams unfamiliar with worktrees** (training needed)

---

## Hermetic Principles

### Rhythm - Sustainable Workflow

**Without worktrees**: Constant stashing/switching (mental drain)
**With worktrees**: Smooth transitions (sustainable pace)

**Honors rhythm** of deep work (no interruption)

---

### Polarity - Balance Multiple Contexts

**Forces balanced**:
- Feature work ↔ Production fixes
- Exploration ↔ Stability
- Current ↔ Future

**Worktrees allow both** (not either/or)

---

### Correspondence - Structure Mirrors Mind

**Directory structure** = **Mental model of work**:
- `features/` = Creative exploration
- `hotfixes/` = Immediate response
- `main/` = Production truth

**Clear structure** → **Clear thinking**

---

## Quick Reference

**Create**:
```bash
git worktree add <path> <branch>
git worktree add -b <new> <path> <base>
```

**Manage**:
```bash
git worktree list
git worktree remove <path>
git worktree prune
```

**Common patterns**:
```bash
# Feature
git worktree add features/name branch

# Hotfix
git worktree add hotfixes/urgent main

# Experiment
git worktree add experiments/try-this dev
```

---

**For complete guide, see** `.hermetic/docs/git-worktree-guide.md`

**May your branches coexist. May your flow be unbroken. May your context remain clear.**
