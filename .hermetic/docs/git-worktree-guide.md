# Git Worktree Guide - Parallel Branch Development

**Principle**: "Work on multiple branches simultaneously without context switching"

**What are worktrees**: Multiple working directories for the same repository, each checked out to different branches

**Why it matters**: No more `git stash`, `git checkout`, `git stash pop` dance

---

## The Problem: Branch Context Switching

### Traditional Git Workflow

**Scenario**: You're building a feature, urgent hotfix needed

**Old way**:
```bash
# You're on feature/authentication
git status
# Changes: Modified 5 files

# Urgent: Production bug in main branch
git stash                    # Stash your work
git checkout main            # Switch to main
git pull                     # Update
git checkout -b hotfix/bug   # Create hotfix branch
# Fix the bug
git commit -m "Fix bug"
git checkout main
git merge hotfix/bug
git push
git checkout feature/authentication
git stash pop                # Restore your work
# Resume feature work
```

**Problems**:
- ❌ Context switching (lose mental state)
- ❌ Risk of stash conflicts
- ❌ Can't compare branches side-by-side
- ❌ Can't run both versions simultaneously

---

### Git Worktree Solution

**New way**:
```bash
# You're working in ~/projects/app/feature-authentication/
# (This is a worktree for feature/authentication branch)

# Urgent: Production bug
cd ~/projects/app/
git worktree add hotfix-bug main
# Creates ~/projects/app/hotfix-bug/ checked out to main

cd hotfix-bug/
# Fix the bug
git commit -m "Fix bug"
git push

cd ../feature-authentication/
# Your feature work untouched, continue immediately
```

**Benefits**:
- ✅ No stashing (both branches exist simultaneously)
- ✅ No context loss (mental state preserved)
- ✅ Compare side-by-side (open both in different windows)
- ✅ Run both versions (test compatibility)

---

## What Are Git Worktrees?

### Concept: Multiple Working Directories

**Traditional git**:
```
~/projects/app/               # One working directory
├── .git/                     # Git metadata
├── src/
└── ...
```

**One branch at a time**: Switch with `git checkout`

---

**With worktrees**:
```
~/projects/app/               # Main directory (could be bare repo)
├── .git/                     # Shared git metadata
├── feature-authentication/   # Worktree for feature/authentication
│   ├── src/
│   └── ...
├── feature-dashboard/        # Worktree for feature/dashboard
│   ├── src/
│   └── ...
└── hotfix-bug/              # Worktree for hotfix/bug
    ├── src/
    └── ...
```

**Multiple branches simultaneously**: Each directory is different branch

---

### How It Works

**Shared .git directory**:
- All worktrees share ONE `.git` database
- Commits, branches, history all synchronized
- Changes in one worktree visible in all others (after commit/pull)

**Separate working directories**:
- Each worktree has own files
- Can edit different files in each
- Can run different versions simultaneously

---

## Setting Up Worktrees

### Method 1: Convert Existing Repo

**Current structure**:
```
~/projects/Midnight-Sun/      # Regular repo
├── .git/
├── src/
└── ...
```

**Convert to worktree structure**:
```bash
cd ~/projects/

# 1. Rename existing directory
mv Midnight-Sun Midnight-Sun-main

# 2. Make it a worktree
cd Midnight-Sun-main/

# 3. Create worktrees for other branches
git worktree add ../Midnight-Sun-development development
git worktree add ../Midnight-Sun-staging staging

# 4. Result:
~/projects/
├── Midnight-Sun-main/           # main branch
├── Midnight-Sun-development/    # development branch
└── Midnight-Sun-staging/        # staging branch
```

---

### Method 2: Start Fresh with Bare Repo

**For new projects** or **clean slate**:

```bash
cd ~/projects/

# 1. Clone as bare repository
git clone --bare git@github.com:user/repo.git repo/.git

cd repo/

# 2. Configure bare repo
git config core.bare false
git config core.worktree ../

# 3. Create worktrees for each branch
git worktree add main main
git worktree add development development
git worktree add feature-auth feature/authentication

# 4. Result:
~/projects/repo/
├── .git/                    # Shared metadata (bare)
├── main/                    # main branch
├── development/             # development branch
└── feature-auth/            # feature/authentication branch
```

**Benefit**: Clean separation, `.git` not in any working directory

---

## Hermetic Worktree Structure

### Recommended Layout

**For Midnight-Sun**:
```
~/projects/Midnight-Sun/
├── .git/                          # Shared git metadata
├── main/                          # Production code
│   ├── src/
│   ├── CLAUDE.md
│   └── dev/                       # Dev docs for main
├── development/                   # Development branch
│   ├── src/
│   └── dev/
├── feature-whatsapp-automation/   # Feature branch
│   ├── src/
│   └── dev/
│       └── active/
│           └── whatsapp-automation-context.md
└── hotfixes/                      # Temporary hotfix worktrees
    └── (created as needed, removed after merge)
```

**Principle**: Each worktree is self-contained with its own dev docs

---

## Common Workflows

### Workflow 1: Feature Development + Urgent Hotfix

**Scenario**: Building feature, production bug appears

```bash
# 1. Currently working on feature
cd ~/projects/Midnight-Sun/feature-whatsapp-automation/
# Coding...

# 2. Urgent production bug reported
cd ~/projects/Midnight-Sun/

# 3. Create hotfix worktree from main
git worktree add hotfixes/fix-login-bug main

cd hotfixes/fix-login-bug/

# 4. Create hotfix branch
git checkout -b hotfix/login-bug

# 5. Fix the bug
# ... make changes ...
git add .
git commit -m "Fix login bug - handle null user"

# 6. Push and create PR
git push origin hotfix/login-bug

# 7. After merge, remove hotfix worktree
cd ~/projects/Midnight-Sun/
git worktree remove hotfixes/fix-login-bug

# 8. Return to feature work immediately
cd feature-whatsapp-automation/
# All your work exactly as you left it
```

**Time saved**: ~5 minutes per context switch

---

### Workflow 2: Compare Implementations

**Scenario**: Trying two different approaches to same feature

```bash
cd ~/projects/Midnight-Sun/

# 1. Create worktrees for both approaches
git worktree add experiments/approach-a feature/auth-jwt
git worktree add experiments/approach-b feature/auth-session

# 2. Implement approach A
cd experiments/approach-a/
# ... implement JWT authentication ...
npm run build
npm test

# 3. Implement approach B (in parallel)
cd ../approach-b/
# ... implement session authentication ...
npm run build
npm test

# 4. Compare side-by-side
# Open both in separate editor windows
# Test both implementations
# Run performance benchmarks

# 5. Choose winner, merge
git checkout main
git merge approach-a  # JWT wins

# 6. Clean up
cd ~/projects/Midnight-Sun/
git worktree remove experiments/approach-a
git worktree remove experiments/approach-b
git branch -d feature/auth-session  # Delete losing branch
```

**Benefit**: Try multiple solutions without losing work

---

### Workflow 3: Multiple Environments

**Scenario**: Test feature in development AND staging simultaneously

```bash
# 1. You have worktrees for each environment
~/projects/Midnight-Sun/
├── development/      # development branch
└── staging/          # staging branch

# 2. Make feature in development
cd development/
git checkout -b feature/new-dashboard
# ... implement feature ...
git commit -m "Add dashboard"

# 3. Test in development environment
npm run dev
# Visit http://localhost:3000
# Test thoroughly

# 4. Merge to staging for QA
cd ../staging/
git merge development
npm run build
# Deploy to staging server
# QA team tests

# 5. Both environments running simultaneously
# Development: Active coding
# Staging: QA testing previous features

# 6. No context switching between environments
```

---

## Worktree Commands Reference

### Create Worktree

```bash
# Create from existing branch
git worktree add <path> <branch>

# Create new branch in new worktree
git worktree add -b <new-branch> <path> <base-branch>

# Examples:
git worktree add ../feature-auth feature/authentication
git worktree add -b hotfix/bug ../hotfix main
```

---

### List Worktrees

```bash
git worktree list

# Output:
# /Users/ormus/projects/Midnight-Sun/main        abc123 [main]
# /Users/ormus/projects/Midnight-Sun/development def456 [development]
# /Users/ormus/projects/Midnight-Sun/feature-auth ghi789 [feature/authentication]
```

---

### Remove Worktree

```bash
# Remove worktree
git worktree remove <path>

# Force remove (if uncommitted changes)
git worktree remove --force <path>

# Example:
git worktree remove hotfixes/fix-login-bug
```

---

### Move Worktree

```bash
# Move to new location
git worktree move <current-path> <new-path>

# Example:
git worktree move feature-auth features/authentication
```

---

### Prune Worktrees

**Clean up stale worktree references** (if directory deleted manually):

```bash
git worktree prune

# With verbose output
git worktree prune --verbose
```

---

## Integration with Dev Docs

### Per-Worktree Dev Docs

**Each worktree has its own dev docs**:

```
~/projects/Midnight-Sun/feature-whatsapp-automation/
├── src/
└── dev/
    └── active/
        ├── whatsapp-automation-plan.md
        ├── whatsapp-automation-context.md
        └── whatsapp-automation-tasks.md
```

**When you switch worktrees**: Relevant dev docs right there

**No confusion**: Each branch's dev docs in its directory

---

### Workflow: Feature in Separate Worktree

```bash
# 1. Create feature worktree
cd ~/projects/Midnight-Sun/
git worktree add features/whatsapp-automation development

cd features/whatsapp-automation/

# 2. Create dev docs
/dev-docs

# Creates:
# ~/projects/Midnight-Sun/features/whatsapp-automation/dev/active/whatsapp-automation-*.md

# 3. Work on feature
# Dev docs are right here in this directory

# 4. Update dev docs before compaction
/update-dev-docs

# 5. After feature complete, merge
git checkout development
cd ../../development/
git merge features/whatsapp-automation

# 6. Copy dev docs to main development directory
mv ../features/whatsapp-automation/dev/active/* dev/completed/

# 7. Remove feature worktree
cd ~/projects/Midnight-Sun/
git worktree remove features/whatsapp-automation
```

---

## Advanced Patterns

### Pattern 1: Bare Repo in Dropbox/Cloud

**Share worktrees across machines**:

```bash
# Machine 1: Create bare repo in Dropbox
cd ~/Dropbox/git-repos/
git clone --bare git@github.com:user/repo.git repo.git

# Create worktrees locally
cd ~/projects/
git worktree add -b main repo-main ~/Dropbox/git-repos/repo.git

# Machine 2: Use same bare repo
cd ~/projects/
git worktree add -b development repo-dev ~/Dropbox/git-repos/repo.git
```

**Result**: Shared git database, local working directories

---

### Pattern 2: Temporary Worktrees

**For quick tasks**:

```bash
# Create temporary worktree
git worktree add /tmp/quick-fix main

cd /tmp/quick-fix/
# Make quick change
git commit -m "Quick fix"
git push

# Remove immediately
git worktree remove /tmp/quick-fix
```

**Benefit**: No cluttering main project directory

---

### Pattern 3: Review PRs Locally

**Test PR before merging**:

```bash
# 1. Fetch PR branch
git fetch origin pull/123/head:pr-123

# 2. Create worktree for PR
git worktree add reviews/pr-123 pr-123

cd reviews/pr-123/

# 3. Test the PR
npm install
npm run build
npm test

# 4. Review code
# ... examine changes ...

# 5. Approve or request changes

# 6. Clean up
cd ~/projects/Midnight-Sun/
git worktree remove reviews/pr-123
git branch -d pr-123
```

---

## VS Code Integration

### Open Multiple Worktrees

**Workspace file** (`.vscode/midnight-sun.code-workspace`):

```json
{
  "folders": [
    {
      "name": "Main",
      "path": "../main"
    },
    {
      "name": "Development",
      "path": "../development"
    },
    {
      "name": "Feature: WhatsApp",
      "path": "../features/whatsapp-automation"
    }
  ],
  "settings": {
    "git.enabled": true,
    "git.autofetch": true
  }
}
```

**Open workspace**: All worktrees visible in one VS Code window

**Benefit**: Compare files across branches, copy code between worktrees

---

## Best Practices

### Practice 1: Naming Convention

**Use descriptive directory names**:

```bash
# Bad (confusing):
git worktree add auth feature/authentication
git worktree add auth2 feature/authentication-v2

# Good (clear):
git worktree add features/authentication feature/authentication
git worktree add features/authentication-v2 feature/authentication-v2
git worktree add hotfixes/login-bug hotfix/login-bug
```

---

### Practice 2: Clean Up Regularly

**Don't accumulate stale worktrees**:

```bash
# Weekly: List worktrees
git worktree list

# Remove merged features
git worktree remove features/completed-feature

# Prune stale references
git worktree prune
```

---

### Practice 3: Document Active Worktrees

**README in project root**:

```markdown
# Midnight Sun - Worktree Structure

## Active Worktrees

- `main/` - Production code
- `development/` - Development branch
- `features/whatsapp-automation/` - Active feature development

## Temporary (remove after use)

- `hotfixes/` - Hotfix worktrees (create as needed)
- `reviews/` - PR review worktrees
- `experiments/` - Experimental branches

## Workflow

- Feature work: Create in `features/`
- Hotfixes: Create in `hotfixes/`, remove after merge
- Reviews: Create in `reviews/`, remove after review
```

---

## Troubleshooting

### Issue: Can't create worktree (branch already checked out)

**Error**:
```
fatal: 'feature/auth' is already checked out at '/path/to/other/worktree'
```

**Cause**: Branch can only be checked out in one worktree at a time

**Solution 1**: Work in existing worktree
```bash
cd /path/to/other/worktree
```

**Solution 2**: Create new branch from that branch
```bash
git worktree add -b feature/auth-v2 new-worktree feature/auth
```

---

### Issue: Worktree directory deleted manually

**Error**: Worktree reference exists but directory gone

**Solution**:
```bash
# Prune stale references
git worktree prune --verbose

# Verify cleaned up
git worktree list
```

---

### Issue: Can't remove worktree (uncommitted changes)

**Error**:
```
fatal: 'path/to/worktree' contains modified or untracked files
```

**Solution 1**: Commit or stash changes
```bash
cd path/to/worktree
git add .
git commit -m "Save work"
# or
git stash
```

**Solution 2**: Force remove (lose changes)
```bash
git worktree remove --force path/to/worktree
```

---

## Hermetic Principles Applied

### Rhythm - Sustainable Development

**Without worktrees**: Constant context switching (draining)
**With worktrees**: Smooth flow between tasks (sustainable)

**Principle**: Honor natural rhythm of work (deep focus periods)

---

### Polarity - Balance Multiple Contexts

**Opposite forces**:
- Feature development ↔ Production hotfixes
- Experimental code ↔ Stable code
- Current work ↔ Future work

**Worktrees enable both** simultaneously (no forced choice)

---

### Correspondence - Structure Reflects Workflow

**Directory structure mirrors mental structure**:
```
features/           # Creative exploration
hotfixes/          # Immediate response
main/              # Production truth
development/       # Active iteration
```

**External organization** = **Internal clarity**

---

## Quick Reference

### Create Worktree
```bash
git worktree add <path> <branch>
git worktree add -b <new-branch> <path> <base>
```

### Manage Worktrees
```bash
git worktree list
git worktree remove <path>
git worktree prune
```

### Common Patterns
```bash
# Feature branch
git worktree add features/new-feature development

# Hotfix
git worktree add hotfixes/urgent-fix main

# PR review
git worktree add reviews/pr-123 pr-123

# Experiment
git worktree add experiments/try-this development
```

---

**For complete guide, see** `.hermetic/docs/git-worktree-guide.md`

**May your branches coexist. May your context remain unbroken. May your flow be preserved.**
