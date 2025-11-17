# New Project Setup Workflow

**Purpose**: Initialize new projects with Hermetic structure, Gold Hat principles, and sustainable practices from day one

**Hermetic Principles**: Mentalism, Correspondence, Vibration, Rhythm, All Principles

**Estimated Time**: 2-4 hours (one-time setup)

**Prerequisites**:
- Project idea/requirements
- Development environment ready
- Hermetic system activated

---

## Philosophy

**"As you begin, so shall you continue."** (Correspondence)

The foundation you build determines the ease of everything that follows. This workflow creates:
- **Clear mental models** (Mentalism)
- **Aligned architecture** (Correspondence)
- **Shipping momentum** (Vibration)
- **Sustainable rhythm** (Rhythm)
- **Ethical foundation** (Gold Hat)

---

## Phase 1: Clarity & Alignment (30-60 min)

### Step 1: Deep Understanding (Mentalism)

**Before writing any code**, understand what you're building and WHY.

**Command**: `/gnosis "project description and goals"`

**Example**:
```
/gnosis "I want to build a personal finance tracker that helps people
understand their spending patterns without selling their data or
manipulating them into premium subscriptions. It should be
privacy-first, empowering, and sustainable to maintain."
```

**Gnosis provides**:
- Clarity on the problem space
- Technical considerations
- Potential approaches
- Ecosystem overview

**Log usage**:
```bash
hm cmd gnosis "project: finance-tracker"
```

**Deliverable**: Crystal-clear understanding of what and why

---

### Step 2: Gold Hat Alignment Check (Ethics Foundation)

**Command**: `/align`

**Critical questions**:

1. **Does this serve genuine human flourishing?**
   - ✓ Good: Help people understand their finances
   - ✗ Bad: Maximize engagement through FOMO tactics

2. **How will this make money** (if commercial)?
   - ✓ Good: Fair pricing for value delivered
   - ✗ Bad: Free tier with dark patterns to force upgrade

3. **What data will it collect, and why?**
   - ✓ Good: Only what's needed, user controls, export available
   - ✗ Bad: Everything possible, sell to third parties

4. **Will it respect user autonomy?**
   - ✓ Good: Users own their data, can delete anytime
   - ✗ Bad: Lock-in tactics, hard to export

5. **Is it accessible to all?**
   - ✓ Good: Screen reader support, keyboard navigation
   - ✗ Bad: Only works for certain demographics

**Deliverable**: Ethical foundation documented

**Document answers** in `MANIFESTO.md`:
```markdown
# Project Manifesto

## Purpose
Help people understand their finances without manipulation.

## Gold Hat Commitments
- Privacy-first: Data stays local or encrypted
- No dark patterns: No engagement manipulation
- User autonomy: Export data anytime, delete anytime
- Fair pricing: Pay for value, not forced upgrades
- Accessibility: Works for everyone

## What We Reject
- Selling user data
- Addictive notification patterns
- Forced subscriptions
- Lock-in tactics
```

---

### Step 3: Technical Architecture (Correspondence)

**Agent**: `backend-architect` or relevant domain expert

```
"backend-architect, design architecture for a privacy-first
personal finance tracker. Requirements:
- Local-first data storage
- Optional cloud sync (encrypted)
- Works offline
- Fast and lightweight
- Sustainable to maintain solo"
```

**Log usage**:
```bash
hm agent backend-architect "project: finance-tracker setup"
```

**Key decisions**:
- Tech stack
- Data architecture
- Deployment strategy
- Testing approach
- Security model

**Deliverable**: Architecture document (`ARCHITECTURE.md`)

---

## Phase 2: Foundation Setup (1-2 hours)

### Step 4: Initialize Repository (Vibration)

**Create project structure**:

```bash
# Create project directory
mkdir finance-tracker
cd finance-tracker

# Initialize git
git init

# Create fundamental structure
mkdir -p src/{components,services,utils}
mkdir -p tests/{unit,integration}
mkdir -p docs
```

**Initial files**:
```bash
# README with clear purpose
cat > README.md <<EOF
# Finance Tracker

**Purpose**: Privacy-first personal finance tracker that empowers
users to understand their spending without manipulation.

## Gold Hat Principles
- Privacy-first
- No dark patterns
- User autonomy
- Fair pricing
- Accessibility

## Quick Start
[Installation instructions]

## Documentation
- [Architecture](docs/ARCHITECTURE.md)
- [Manifesto](docs/MANIFESTO.md)
- [Contributing](docs/CONTRIBUTING.md)
EOF
```

---

### Step 5: Development Environment (Correspondence)

**Set up consistent tooling**:

```bash
# Package manager (example: Node.js)
npm init -y

# Install essential dependencies
npm install --save [production dependencies]
npm install --save-dev [dev dependencies]

# Linting and formatting
npm install --save-dev eslint prettier
npx eslint --init
```

**Create configuration files**:

`.eslintrc.json`:
```json
{
  "extends": "eslint:recommended",
  "rules": {
    "no-console": "warn",
    "no-unused-vars": "error"
  }
}
```

`.prettierrc`:
```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80
}
```

---

### Step 6: Testing Foundation (Cause-Effect)

**Set up testing from day one**:

```bash
# Install test framework
npm install --save-dev jest

# Create test structure
mkdir -p tests/{unit,integration,e2e}
```

**`package.json` scripts**:
```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/",
    "format": "prettier --write \"src/**/*.js\""
  }
}
```

**Write first test** (even before code):
```javascript
// tests/unit/app.test.js
describe('Finance Tracker', () => {
  it('should exist', () => {
    expect(true).toBe(true);
  });
});
```

**Run it**:
```bash
npm test
```

Should pass (starting green).

---

### Step 7: Git Integration (Hermetic Hooks)

**Install Hermetic git hooks**:

```bash
# If in git repo
~/.hermetic/integrations/git-hooks-installer.sh install
```

**Create `.gitignore`**:
```
node_modules/
dist/
.env
.env.local
*.log
.DS_Store
coverage/
```

**Initial commit**:
```bash
git add .
git commit -m "Initial project setup

- Project structure established
- Testing framework configured
- Linting and formatting setup
- Gold Hat manifesto documented
- Architecture designed

Hermetic Principle: Correspondence - Strong foundation enables
everything that follows.

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Step 8: Documentation Structure (Mentalism)

**Create essential docs**:

```bash
mkdir -p docs
```

**`docs/ARCHITECTURE.md`**:
```markdown
# Architecture

## Overview
[High-level system design]

## Components
[Key components and their responsibilities]

## Data Flow
[How data moves through the system]

## Security Model
[How privacy and security are maintained]

## Decisions
[Key technical decisions and why]
```

**`docs/CONTRIBUTING.md`**:
```markdown
# Contributing

## Development Setup
[How to get started]

## Testing
[How to run tests]

## Code Style
[Style guidelines]

## Pull Request Process
[How to contribute]

## Hermetic Principles
This project follows Gold Hat principles:
- Empower users
- Respect privacy
- No dark patterns
- Sustainable development
```

---

## Phase 3: Core Infrastructure (1-2 hours)

### Step 9: Basic Application Scaffold

**Agent**: `rapid-prototyper`

```
"rapid-prototyper, create a minimal working scaffold for a
privacy-first finance tracker using [your chosen stack]"
```

**Log usage**:
```bash
hm agent rapid-prototyper "project: finance-tracker scaffold"
```

**Deliverable**: Minimal working application (even if it does nothing yet)

---

### Step 10: CI/CD Pipeline (Cause-Effect)

**Set up automated testing and deployment**:

**`.github/workflows/test.yml`** (if using GitHub):
```yaml
name: Test Suite

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '18'
      - run: npm install
      - run: npm run lint
      - run: npm test
      - run: npm run test:coverage
```

**Verify it works**:
```bash
git add .github/
git commit -m "Add CI pipeline for automated testing"
git push
```

Check that tests run automatically.

---

### Step 11: Security Baseline (Cause-Effect)

**Agent**: `security-engineer`

```
"security-engineer, review the initial project setup for any
security issues and recommend baseline security measures"
```

**Log usage**:
```bash
hm agent security-engineer "project: finance-tracker security"
```

**Implement**:
- Dependency scanning
- Environment variable security
- Input validation patterns
- Authentication strategy (if needed)
- Data encryption (if storing sensitive data)

---

### Step 12: Dark Pattern Prevention (Gold Hat Critical)

**Agent**: `extraction-pattern-detector`

```
"extraction-pattern-detector, review the project architecture
and initial plans to ensure no extraction patterns are being
designed in from the start"
```

**Log usage**:
```bash
hm agent extraction-pattern-detector "project: finance-tracker"
```

**Create `GOLD-HAT-CHECKLIST.md`**:
```markdown
# Gold Hat Checklist

Before every release, verify:

## Data & Privacy
- [ ] User data encrypted at rest
- [ ] User data encrypted in transit
- [ ] Easy data export available
- [ ] Easy account deletion
- [ ] No data sold to third parties
- [ ] Minimal data collection
- [ ] Clear privacy policy

## User Experience
- [ ] No dark patterns
- [ ] No engagement manipulation
- [ ] No forced upgrades
- [ ] No lock-in tactics
- [ ] Accessible to all users
- [ ] Clear, honest communication

## Business Model
- [ ] Fair pricing
- [ ] No hidden fees
- [ ] Value-aligned monetization
- [ ] Sustainable for developer
```

---

## Phase 4: Development Rhythm (Ongoing)

### Step 13: Sprint Planning (Rhythm + Vibration)

**Agent**: `sprint-prioritizer`

```
"sprint-prioritizer, help me plan the first 6-day development
sprint for this finance tracker project"
```

**Log usage**:
```bash
hm agent sprint-prioritizer "project: finance-tracker sprint-1"
```

**First Sprint Goals** (example):
1. Basic expense entry
2. Simple categorization
3. Daily summary view
4. Local storage
5. Basic export

**Document in** `docs/SPRINTS.md`

---

### Step 14: Daily Workflow Integration

**Add project-specific context** to daily workflow:

```bash
# Create project notes
cat > .hermetic-project <<EOF
PROJECT_NAME="Finance Tracker"
PROJECT_TYPE="web-app"
MAIN_STACK="typescript,react,node"
HERMETIC_FOCUS="privacy,simplicity,no-manipulation"
EOF
```

**Start each day**:
```bash
cd finance-tracker
hm start-day
hm context  # Will detect .hermetic-project and provide relevant suggestions
```

---

### Step 15: VS Code Integration (if using VS Code)

**Add project-specific tasks** (`.vscode/tasks.json`):
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Hermetic: Start Day",
      "type": "shell",
      "command": "hm start-day"
    },
    {
      "label": "Hermetic: Health Check",
      "type": "shell",
      "command": "hm health"
    },
    {
      "label": "Run Tests",
      "type": "shell",
      "command": "npm test"
    }
  ]
}
```

---

## Phase 5: First Feature (Proof of Concept)

### Step 16: Implement MVP Feature (Vibration)

**Goal**: Ship something working in first 6-day sprint

**Use**: `feature-implementation.md` workflow

**Example first feature**: "Add expense"

**Process**:
1. Design the mental model (Mentalism)
2. Write tests first (Cause-Effect)
3. Implement minimum version (Vibration)
4. Verify quality (Correspondence)
5. Ship and learn (Rhythm)

---

### Step 17: Celebrate First Milestone (Rhythm)

**When first feature works**:

```
/celebrate "First feature working in Finance Tracker - can add expenses!"
```

**Log**:
```bash
hm agent rapid-prototyper "project: finance-tracker first-feature"
hm rate agent rapid-prototyper 5
```

**Why celebrate**: Establishes positive momentum, honors rhythm

---

## Success Metrics

**After setup (Day 1)**:
- [ ] Repository initialized
- [ ] Tests passing (even if trivial)
- [ ] CI/CD working
- [ ] Documentation created
- [ ] Gold Hat principles documented
- [ ] First commit made

**After first sprint (Day 6)**:
- [ ] At least one feature working
- [ ] Tests covering core functionality
- [ ] No dark patterns present
- [ ] Architecture holding up
- [ ] Momentum established

**After first month**:
- [ ] Multiple features working
- [ ] Users can use it (even if rough)
- [ ] Gold Hat checklist consistently passing
- [ ] Sustainable development pace
- [ ] Clear next steps

---

## Common Pitfalls

### ❌ Diving Into Code Before Clarity
**Consequence**: Build wrong thing, need to redo
**Fix**: Always start with `/gnosis` and `/align`

### ❌ Skipping Tests Initially
**Consequence**: Technical debt from day one
**Fix**: Set up testing before writing features

### ❌ No Documentation
**Consequence**: Future confusion, hard to onboard
**Fix**: Document as you build, not after

### ❌ Over-Engineering the Start
**Consequence**: Never ship, analysis paralysis
**Fix**: Minimal viable architecture, iterate

### ❌ Ignoring Gold Hat Alignment
**Consequence**: Build extraction patterns in from start
**Fix**: Make `/align` check mandatory from day zero

### ❌ No CI/CD
**Consequence**: Manual testing burden, bugs slip through
**Fix**: Set up automation early

---

## Project Templates by Type

### Web Application
**Stack**: React + Node + PostgreSQL
**Agents**: `frontend-developer`, `backend-architect`, `database-architect`
**First Sprint**: Authentication, basic CRUD, deployment

---

### Mobile App
**Stack**: React Native
**Agents**: `mobile-app-builder`, `ui-designer`
**First Sprint**: Basic navigation, one core screen, deploy to TestFlight

---

### CLI Tool
**Stack**: Node.js or Python
**Agents**: `cli-expert`, `terminal-expert`
**First Sprint**: Core command, help system, basic functionality

---

### API Service
**Stack**: Node.js + Express + PostgreSQL
**Agents**: `backend-architect`, `api-tester`, `database-architect`
**First Sprint**: Core endpoints, authentication, documentation

---

## Effectiveness Tracking

After project setup:

```bash
hm rate workflow new-project-setup 5
hm rate agent backend-architect 5
hm rate agent rapid-prototyper 4
hm rate command gnosis 5
hm rate command align 5
```

**Track over time**:
- Time to first feature
- Test coverage from day one
- Gold Hat violations (should be zero)
- Development velocity
- Technical debt accumulation

---

## Long-term Project Health

**Weekly check** (during Sabbath):
```bash
hm sabbath
```

**Review**:
- Is architecture still serving you?
- Any technical debt accumulating?
- Gold Hat checklist still passing?
- Development pace sustainable?
- Learning and growing?

**Monthly check**:
```
/align "Project still aligned with original vision and Gold Hat principles?"
```

**Adjust** based on reality, not plans.

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: All principles applied
**Gold Hat Alignment**: Critical
**Effectiveness**: Track with `hm rate workflow new-project-setup <1-5>`

*"As you begin, so shall you continue. Build the foundation with consciousness."*
