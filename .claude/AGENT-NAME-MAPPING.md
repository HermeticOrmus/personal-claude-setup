# Agent Name Mapping: Mythological vs Functional

**Critical Issue Identified 2025-11-10:**
- AGENT-CATALOG.md uses mythological names (Metis, Titan, etc.)
- Task tool uses functional names (ux-researcher, visual-storyteller, etc.)
- Sol was calling wrong names → agents not found

---

## The Correct Mapping

### Design Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Metis | `ux-researcher` | UX research, journey mapping |
| Titan | `visual-storyteller` | Visual narratives, infographics |
| Eros | `whimsy-injector` | Delightful UX elements |
| Hera | `brand-guardian` | Brand consistency, guidelines |
| (UI Designer) | `ui-designer` | Interface design, components |

### Marketing Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Psyche | `tiktok-strategist` | TikTok marketing, viral content |
| Fortuna | `app-store-optimizer` | ASO, keywords, conversion |
| Eris | (not implemented?) | Growth hacking |
| Calliope | (not implemented?) | Content creation |
| Vesta | (not implemented?) | Community building |
| Juno | (not implemented?) | Social media management |
| (Trend Researcher) | `trend-researcher` | Market opportunities, trends |
| (Feedback Synthesizer) | `feedback-synthesizer` | User feedback analysis |

### Product Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Echo | `feedback-synthesizer` | Feedback synthesis |
| Chronos | `analytics-reporter` | Analytics, metrics |
| Janus | (not implemented?) | Product strategy |
| (Sprint Prioritizer) | `sprint-prioritizer` | 6-day development cycles |
| (Workflow Optimizer) | `workflow-optimizer` | Human-agent collaboration |

### Engineering Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Uranus | `ai-engineer` | AI/ML development |
| Neptune | `backend-architect` | Backend architecture |
| Ceres | `devops-automator` | DevOps, CI/CD |
| Pallas | `mobile-app-builder` | Mobile development |
| Iris | (not implemented?) | Rapid MVP |
| (Frontend Developer) | `frontend-developer` | UI components, React/Vue |
| (Database Architect) | `database-architect` | Schema design, queries |
| (Security Engineer) | `security-engineer` | Security, privacy, trust |
| (CLI Expert) | `cli-expert` | CLI applications |

### Testing Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Ganymede | `api-tester` | API testing, load testing |
| Europa | (not implemented?) | Integration testing |
| Callisto | (not implemented?) | Load testing |
| Prometheus | (not implemented?) | Security testing |
| Daedalus | (not implemented?) | Test architecture |
| (Test Writer/Fixer) | `test-writer-fixer` | Write/run/fix tests |
| (Performance Benchmarker) | `performance-benchmarker` | Performance testing |

### Project Management Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Saturn | `saturn` | Discipline, elimination |
| (Studio Producer) | `studio-producer` | Cross-functional coordination |
| (Project Shipper) | `project-shipper` | Launch coordination |
| (Experiment Tracker) | `experiment-tracker` | A/B tests, experiments |

### Life Advisory Agents

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Themis | `themis-legal` | Legal guidance, contracts |
| Plutus | `plutus-finance` | Financial guidance, budgets |
| Hygieia | `hygieia-wellness` | Health, fitness, wellness |

### Sacred Arsenal

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| (Hermetic Compass) | `hermetic-compass-advisor` | Decision alignment (9 realms) |
| (Alchemical Forge) | `alchemical-forge-guide` | 6-day sprint structure |
| (Sacred Mirror) | `sacred-mirror-auditor` | Testing audit (9 reflections) |
| (Divine Anchor) | `divine-anchor-auditor` | Infrastructure audit |
| (Frequency Tuner) | `frequency-tuner-optimizer` | Performance (9 frequencies) |
| (Cosmic Lens) | `cosmic-lens-analytics` | Multi-scale analytics |
| (Rainbow Bridge) | `rainbow-bridge-designer` | Sacred API architecture |

### Hermetic Principles

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| (Mentalism) | `mentalism` | Mental models, clarity |
| (Correspondence) | `correspondence` | Patterns across levels |
| (Vibration) | `vibration` | Energy, momentum |
| (Polarity) | `polarity` | Balance opposites |
| (Rhythm) | `rhythm` | Cycles, sustainable pace |
| (Cause-Effect) | `cause-effect` | Consequences, root causes |
| (Gender) | `gender` | Masculine/feminine balance |
| (Law Translator) | `hermetic-law-translator` | Language transformation |

### Consciousness Guardrails

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| (Ethics Auditor) | `ethics-auditor` | Dark pattern detection |
| (Boundary Guard) | `consciousness-boundary-guard` | AI augmentation validation |
| (Extraction Detector) | `extraction-pattern-detector` | Business model audit |
| (Shadow Integrator) | `shadow-integrator` | Dark pattern knowledge |

### Life Integration

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| (Sabbath Guide) | `sabbath-guide` | Day 7 integration |
| (Flow Unlocker) | `creative-flow-unlocker` | Creative block diagnosis |
| (Resistance Diagnostician) | `resistance-diagnostician` | Resistance pattern diagnosis |
| (Rainbow Warrior Academy) | `rainbow-warrior-academy` | 54-week mastery curriculum |

### Bonus/Utility

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| Joker | `joker` | Genuine humor, sacred joy |
| (Studio Coach) | `studio-coach` | Elite performance coaching |
| (Momus) | (not implemented?) | Code review |
| (Mentor) | (not implemented?) | Pair programming |

### General Purpose

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| (General Purpose) | `general-purpose` | Complex multi-step tasks |
| (Explore) | `Explore` | Fast codebase exploration |
| (Plan) | `Plan` | Fast planning |

### Platform-Specific

| Mythological Name (Catalog) | Functional Name (Task Tool) | Domain |
|------------------------------|------------------------------|--------|
| (Unix Expert) | `unix-expert` | UNIX philosophy, POSIX |
| (Linux Expert) | `linux-expert` | Linux expertise |
| (Terminal Expert) | `terminal-expert` | Terminal productivity |

---

## Complete Available Agent List (from Task Tool)

```
general-purpose
statusline-setup
Explore
Plan
hermetic-compliance-checker
workflow-optimizer
tool-evaluator
test-results-analyzer
performance-benchmarker
api-tester
support-responder
legal-compliance-checker
infrastructure-maintainer
finance-tracker
analytics-reporter
sacred-mirror-auditor
rainbow-bridge-designer
hermetic-compass-advisor
frequency-tuner-optimizer
divine-anchor-auditor
cosmic-lens-analytics
alchemical-forge-guide
studio-producer
saturn
project-shipper
experiment-tracker
trend-researcher
sprint-prioritizer
feedback-synthesizer
resistance-diagnostician
rainbow-warrior-academy
tiktok-strategist
app-store-optimizer
shadow-integrator
sabbath-guide
creative-flow-unlocker
themis-legal
plutus-finance
hygieia-wellness
hermetic-law-translator
gender
cause-effect
rhythm
polarity
vibration
correspondence
mentalism
unix-expert
test-writer-fixer
terminal-expert
security-engineer
mobile-app-builder
linux-expert
frontend-developer
devops-automator
database-architect
cli-expert
backend-architect
ai-engineer
whimsy-injector
visual-storyteller
ux-researcher
ui-designer
brand-guardian
extraction-pattern-detector
ethics-auditor
consciousness-boundary-guard
studio-coach
joker
sol
```

---

## Action Required

**1. Update AGENT-CATALOG.md**
Add "Functional Name" column showing Task tool names

**2. Update Sol Agent Definition**
Use functional names, not mythological names

**3. Update All Agent Documentation**
Reference correct names in collaboration patterns

**4. Create Alias System (Optional Future)**
Allow mythological names as aliases → map to functional names

---

## When Calling Agents (CRITICAL)

**✅ CORRECT:**
```xml
<invoke name="Task">
<parameter name="subagent_type">ux-researcher