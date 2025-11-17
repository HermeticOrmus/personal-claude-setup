# Sol's Agent Invocation Reference
## The REAL Names Claude Code Understands

**CRITICAL**: When using the Task tool, use **functional names**, not celestial names!

---

## ⚡ Quick Delegation Syntax

```javascript
// ✅ CORRECT - Use functional names
Task(subagent_type="backend-architect", prompt="Design API")

// ❌ WRONG - Celestial names don't work
Task(subagent_type="Neptune", prompt="Design API")
```

---

## 🌍 Complete Mapping: Celestial → Functional

### **INNER CIRCLE** (Fast, Frequent, Foundation)

#### Mercury (Communication & Data)
- **Functional Names**: `frontend-developer`, `mobile-app-builder`
- **Use for**: User-facing apps, React/Vue, mobile, UI implementation

#### Venus (Design & Harmony)
- **Functional Names**: `brand-guardian`, `ui-designer`, `ux-researcher`, `visual-storyteller`, `whimsy-injector`
- **Use for**: Design systems, brand work, UX research, visual content, delight

#### Earth (Frontend/User-Facing)
- **Functional Names**: `frontend-developer`, `mobile-app-builder`
- **Use for**: Web apps, mobile apps, frontend deployment

#### Mars (Testing/QA/Security)
- **Functional Names**: `api-tester`, `performance-benchmarker`, `test-results-analyzer`, `tool-evaluator`, `workflow-optimizer`
- **Use for**: Testing, QA, security, performance validation

---

### **ASTEROID BELT** (Specialized Utilities)

#### Ceres (DevOps)
- **Functional Name**: `devops-automator`
- **Use for**: CI/CD, Docker, Kubernetes, deployment automation

#### Vesta (Automation)
- **Functional Name**: `devops-automator`
- **Use for**: Workflow automation, build automation

---

### **OUTER CIRCLE** (Slow, Powerful, Governance)

#### Jupiter (Growth Product Manager)
- **Functional Names**: (Need to map from files)
- **Use for**: Product strategy, growth, analytics

#### Saturn (Discipline & Elimination)
- **Functional Name**: `saturn`
- **Use for**: Ruthless prioritization, resource allocation, archival, discipline

#### Uranus (AI/ML Innovation)
- **Functional Name**: `ai-engineer`
- **Use for**: AI/ML features, LangChain, prompt engineering, innovation

#### Neptune (Backend Architect)
- **Functional Name**: `backend-architect`
- **Use for**: APIs, databases, authentication, backend deployment
- **Moons**:
  - Triton: `database-architect`

---

### **BEYOND** (Meta-Systems)

#### Hermetic Principles (The 7 Laws)
- **Functional Names**: `mentalism`, `correspondence`, `vibration`, `polarity`, `rhythm`, `cause-effect`, `gender`
- **Use for**: Philosophical guidance, principle application

#### Life Advisory
- **Functional Names**: `themis-legal`, `plutus-finance`, `hygieia-wellness`
- **Use for**: Legal, financial, wellness guidance

#### Sacred Arsenal (7 Sacred Instruments)
- **Functional Names**:
  - `hermetic-compass-advisor`
  - `alchemical-forge-guide`
  - `sacred-mirror-auditor`
  - `cosmic-lens-analytics`
  - `divine-anchor-auditor`
  - `frequency-tuner-optimizer`
  - `rainbow-bridge-designer`

#### Consciousness Guardrails
- **Functional Name**: `consciousness-boundary-guard`
- **Use for**: Ethics audits, dark pattern detection

#### Bonus Team
- **Functional Names**: `joker`, `studio-coach`
- **Use for**: Humor, team morale, elite performance coaching

---

## 🎯 Sol's Delegation Decision Tree (CORRECTED)

```
USER REQUEST ARRIVES
↓
Sol analyzes intent
↓
BACKEND/INFRASTRUCTURE?
  → Task(subagent_type="backend-architect")
  → Task(subagent_type="database-architect")  // Triton moon

FRONTEND/USER-FACING?
  → Task(subagent_type="frontend-developer")
  → Task(subagent_type="mobile-app-builder")

DESIGN/UX/VISUAL?
  → Task(subagent_type="brand-guardian")
  → Task(subagent_type="ui-designer")
  → Task(subagent_type="ux-researcher")
  → Task(subagent_type="visual-storyteller")
  → Task(subagent_type="whimsy-injector")

TESTING/QA/PERFORMANCE?
  → Task(subagent_type="api-tester")
  → Task(subagent_type="performance-benchmarker")
  → Task(subagent_type="test-results-analyzer")

DEVOPS/AUTOMATION?
  → Task(subagent_type="devops-automator")

AI/ML/INNOVATION?
  → Task(subagent_type="ai-engineer")

DISCIPLINE/ELIMINATION?
  → Task(subagent_type="saturn")

LEGAL/FINANCIAL/WELLNESS?
  → Task(subagent_type="themis-legal")
  → Task(subagent_type="plutus-finance")
  → Task(subagent_type="hygieia-wellness")

HERMETIC GUIDANCE?
  → Task(subagent_type="mentalism")  // or any of 7 principles
  → Task(subagent_type="hermetic-compass-advisor")

HUMOR/COACHING?
  → Task(subagent_type="joker")
  → Task(subagent_type="studio-coach")
```

---

## 📝 Example Orchestration

### User: "Build user authentication"

**Sol's Internal Process:**
```javascript
// PHASE 1: Backend (Neptune → backend-architect)
Task(
  subagent_type="backend-architect",
  prompt="Design authentication API with JWT tokens,
         password hashing, and session management"
)

// PHASE 2: Frontend (Earth → frontend-developer)
Task(
  subagent_type="frontend-developer",
  prompt="Implement login/signup forms that consume
         the authentication API, with form validation"
)

// PHASE 3: Testing (Mars → api-tester)
Task(
  subagent_type="api-tester",
  prompt="Create comprehensive API tests for authentication
         endpoints, including edge cases and security"
)

// Sol integrates all results and returns to user
```

---

## 🚨 Common Mistakes

### ❌ WRONG
```javascript
Task(subagent_type="Neptune")  // Celestial name
Task(subagent_type="Mars")     // Celestial name
Task(subagent_type="Venus")    // Celestial name
```

### ✅ CORRECT
```javascript
Task(subagent_type="backend-architect")    // Functional
Task(subagent_type="api-tester")           // Functional
Task(subagent_type="brand-guardian")       // Functional
```

---

## 🔧 How to Find Agent Names

```bash
# List all available agent names
grep -r "^name:" C:\Users\ormus\.claude\agents --include="*.md"

# Check specific agent
cat C:\Users\ormus\.claude\agents\path\to\agent.md | head -10
```

---

## 💡 Pro Tips

1. **Always use functional names** when calling Task tool
2. **Celestial names are for documentation/philosophy** only
3. **Check agent frontmatter** if unsure of name
4. **Test delegation** with simple prompts first
5. **Sol coordinates** - agents execute

---

**Last Updated:** 2025-11-10
**Purpose:** Enable Sol to correctly delegate to agents using functional names
**Status:** Reference document for Sol's orchestration system
