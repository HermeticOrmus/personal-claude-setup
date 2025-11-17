# LSP-AI Setup Guide - Real-Time Code Intelligence

**Principle**: "AI assistance during coding, not just in chat"

**What is LSP-AI**: Language Server Protocol implementation providing AI-powered code intelligence in any LSP-compatible editor

**Why it matters**: Get AI suggestions while typing, not just when asking Claude Code

---

## What Problem Does LSP-AI Solve?

### The Current Workflow

**With Claude Code alone**:
```
1. Write code in editor
2. Get stuck or need help
3. Switch to Claude Code CLI
4. Ask question
5. Get response
6. Switch back to editor
7. Apply suggestion
```

**Pain point**: Context switching breaks flow

---

### The LSP-AI Enhancement

**With Claude Code + LSP-AI**:
```
1. Write code in editor
2. LSP-AI suggests completions as you type (real-time)
3. Accept suggestions inline
4. For complex questions, still use Claude Code CLI
5. Seamless flow
```

**Benefit**: AI assistance without leaving editor

---

## What LSP-AI Provides

### Feature 1: Intelligent Code Completion

**As you type**:
```typescript
// You type: function calculateTo
// LSP-AI suggests:
function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}
```

**Context-aware**: Understands your codebase, not just generic completions

---

### Feature 2: Inline Documentation

**Hover over function**:
```typescript
// Hover over "calculateTotal"
// LSP-AI shows:
/**
 * Calculates total price for cart items
 * @param items - Array of cart items with price and quantity
 * @returns Total price as number
 */
```

---

### Feature 3: Refactoring Suggestions

**Select code block**:
```typescript
// Selected: repetitive error handling
// LSP-AI suggests: "Extract to errorHandler function"
// One-click refactor
```

---

### Feature 4: Code Explanations

**Right-click complex code**:
```typescript
// Complex regex or algorithm
// LSP-AI explains: "This regex validates email format by..."
```

---

## Installation

### Prerequisites

**Required**:
- Node.js 18+ (for LSP server)
- LSP-compatible editor (VS Code, Neovim, Emacs, etc.)
- API key for AI model (Claude, OpenAI, or local model)

**Check Node.js version**:
```bash
node --version
# Should be v18 or higher
```

---

### Install LSP-AI Server

**Via npm** (recommended):
```bash
npm install -g lsp-ai

# Verify installation
lsp-ai --version
```

**Via cargo** (Rust alternative):
```bash
cargo install lsp-ai

# Verify
lsp-ai --version
```

---

### Editor Configuration

#### VS Code Setup

**1. Install extension**:
```
Extensions → Search "LSP-AI"
Install LSP-AI extension
```

**2. Configure** (`.vscode/settings.json`):
```json
{
  "lsp-ai.enabled": true,
  "lsp-ai.provider": "anthropic",
  "lsp-ai.model": "claude-sonnet-4",
  "lsp-ai.apiKey": "${env:ANTHROPIC_API_KEY}",
  "lsp-ai.contextWindow": 8000,
  "lsp-ai.temperature": 0.2,
  "lsp-ai.autoTrigger": true,
  "lsp-ai.inlineCompletions": true
}
```

**3. Set API key** (environment variable):
```bash
# Windows (PowerShell)
$env:ANTHROPIC_API_KEY = "your-api-key-here"

# Linux/Mac
export ANTHROPIC_API_KEY="your-api-key-here"
```

---

#### Neovim Setup (Lazy.nvim)

**Plugin config** (`~/.config/nvim/lua/plugins/lsp-ai.lua`):
```lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lsp_ai.setup({
        cmd = {"lsp-ai"},
        filetypes = {"typescript", "javascript", "python", "rust", "go"},
        settings = {
          lsp_ai = {
            provider = "anthropic",
            model = "claude-sonnet-4",
            apiKey = vim.env.ANTHROPIC_API_KEY,
            contextWindow = 8000,
            temperature = 0.2,
            autoTrigger = true
          }
        }
      })
    end
  }
}
```

---

#### Emacs Setup (lsp-mode)

**Configuration** (`~/.emacs.d/init.el`):
```elisp
(use-package lsp-mode
  :config
  (add-to-list 'lsp-language-id-configuration
               '(typescript-mode . "typescript"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "lsp-ai")
    :major-modes '(typescript-mode javascript-mode python-mode)
    :server-id 'lsp-ai
    :initialization-options
    (lambda ()
      `(:provider "anthropic"
        :model "claude-sonnet-4"
        :apiKey ,(getenv "ANTHROPIC_API_KEY")
        :contextWindow 8000
        :temperature 0.2)))))
```

---

## Configuration for Hermetic Development

### Hermetic LSP-AI Config

**File**: `~/.lsp-ai/config.json`

```json
{
  "provider": "anthropic",
  "model": "claude-sonnet-4",
  "apiKey": "${ANTHROPIC_API_KEY}",

  "contextWindow": 8000,
  "temperature": 0.2,

  "completionSettings": {
    "autoTrigger": true,
    "triggerCharacters": [".", "(", "{", "["],
    "minCharacters": 3,
    "maxSuggestions": 3,
    "debounceMs": 200
  },

  "hermeticRules": {
    "enforceGoldHat": true,
    "rejectDarkPatterns": true,
    "commentStyle": "why-not-what",
    "namingConvention": "descriptive-over-clever"
  },

  "codebaseContext": {
    "includeFiles": [
      "CLAUDE.md",
      ".hermetic/manifesto.md",
      "README.md"
    ],
    "excludePatterns": [
      "node_modules/**",
      "dist/**",
      ".git/**"
    ]
  },

  "customPrompts": {
    "completion": "You are helping a Gold Hat developer following Hermetic principles. Suggest code that empowers users and honors human dignity. Reject dark patterns.",

    "refactor": "Suggest refactorings that improve clarity (Mentalism) and align structure with purpose (Correspondence).",

    "explain": "Explain code by teaching the 'why' behind the 'what'. Help the developer understand, don't just describe."
  }
}
```

---

### Project-Specific Configuration

**Per-project override** (`.lsp-ai.json` in project root):

**Midnight-Sun project**:
```json
{
  "extends": "~/.lsp-ai/config.json",

  "customContext": {
    "projectType": "coaching-practice",
    "principles": ["Gold Hat", "Sacred Technology", "Midnight Sun communication"],
    "tone": "brief, genuine, grounded, peer-level"
  },

  "codebaseContext": {
    "includeFiles": [
      "CLAUDE.md",
      "THE-MIDNIGHT-SUN-MANIFESTO.md",
      "MIDNIGHT-SUN-COMMUNICATION-PRINCIPLES.md"
    ]
  },

  "customPrompts": {
    "completion": "Follow Midnight Sun communication: brief not verbose, genuine not effusive, grounded language. No spiritual bypassing."
  }
}
```

---

## Usage Workflows

### Workflow 1: Real-Time Completion

**Scenario**: Writing new function

```typescript
// You type:
async function authenticateUser

// LSP-AI suggests (Ctrl+Space or auto):
async function authenticateUser(email: string, password: string): Promise<User | null> {
  // Validate credentials with bcrypt
  const user = await db.user.findUnique({ where: { email } });

  if (!user) {
    return null; // Don't reveal if user exists (prevent enumeration)
  }

  const isValid = await bcrypt.compare(password, user.passwordHash);

  return isValid ? user : null;
}
```

**Notice**:
- Gold Hat principle: Comment about preventing enumeration
- Hermetic naming: `authenticateUser` (clear intent)
- Security best practice: bcrypt comparison

---

### Workflow 2: Inline Documentation

**Scenario**: Understanding existing function

```typescript
// Hover over function call
calculateTotal(cartItems)

// LSP-AI shows:
/**
 * Calculates total price for cart items
 *
 * Why this way: Reduces over map prevents intermediate arrays (performance)
 *
 * @param items - Cart items with price and quantity
 * @returns Total price in cents (prevents floating point errors)
 *
 * @example
 * calculateTotal([
 *   { price: 1000, quantity: 2 },
 *   { price: 500, quantity: 1 }
 * ]) // Returns 2500 (cents)
 */
```

---

### Workflow 3: Refactoring Assistance

**Scenario**: Code smell detected

```typescript
// Before (repetitive error handling):
try {
  await saveUser(user);
} catch (error) {
  console.error('Save user failed:', error);
  throw new Error('Database error');
}

try {
  await updateProfile(profile);
} catch (error) {
  console.error('Update profile failed:', error);
  throw new Error('Database error');
}

// Select both blocks
// LSP-AI suggests: "Extract error handler"

// After (LSP-AI refactor):
async function withErrorHandler<T>(
  operation: () => Promise<T>,
  context: string
): Promise<T> {
  try {
    return await operation();
  } catch (error) {
    console.error(`${context} failed:`, error);
    throw new Error('Database error');
  }
}

await withErrorHandler(() => saveUser(user), 'Save user');
await withErrorHandler(() => updateProfile(profile), 'Update profile');
```

---

### Workflow 4: Code Explanation

**Scenario**: Complex regex or algorithm

```typescript
// Select this complex code:
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

// Right-click → "LSP-AI: Explain"

// LSP-AI explains:
/*
Email validation regex breakdown:

^ - Start of string
[^\s@]+ - One or more characters that are NOT whitespace or @
@ - Literal @ symbol
[^\s@]+ - One or more characters that are NOT whitespace or @
\. - Literal dot (escaped)
[^\s@]+ - One or more characters that are NOT whitespace or @
$ - End of string

Why this regex:
- Simple validation (doesn't catch all edge cases)
- Prevents obviously invalid emails
- For production, use email validation library

Gotcha: This allows "test@test.c" (valid per regex, invalid TLD)
Better: Use validator.isEmail() from 'validator' package
*/
```

---

## Integration with Claude Code

### When to Use Each

**LSP-AI** (real-time, in-editor):
- ✅ Code completion (while typing)
- ✅ Quick refactors (extract function, rename)
- ✅ Inline documentation (hover hints)
- ✅ Simple explanations (what does this line do)

**Claude Code CLI** (deliberate, comprehensive):
- ✅ Architecture decisions (planning features)
- ✅ Complex refactoring (multi-file changes)
- ✅ Strategic planning (using `/strategic-plan-architect`)
- ✅ Learning and teaching (deep explanations)
- ✅ Code review (holistic analysis)

**Best practice**: Use both together
- LSP-AI: Flow state coding (inline suggestions)
- Claude Code: Intentional work (planning, reviewing)

---

### Workflow Integration

**Daily Development Flow**:
```
1. Morning: Plan with Claude Code
   - /strategic-plan-architect "feature description"
   - Create dev docs with /dev-docs

2. Implementation: Code with LSP-AI
   - Real-time completions
   - Inline refactors
   - Quick explanations

3. Checkpoints: Review with Claude Code
   - Mid-day code review
   - Test with Claude
   - Update dev docs Layer 3

4. Evening: Integrate with Claude Code
   - /update-dev-docs
   - Extract Anki cards
   - Update MOCs
```

---

## Advanced Features

### Feature 1: Custom Snippets with Context

**Configure custom snippets** (`~/.lsp-ai/snippets.json`):

```json
{
  "hermeticFunction": {
    "prefix": "hfn",
    "description": "Hermetic function template",
    "body": [
      "/**",
      " * ${1:functionName} - ${2:Brief description}",
      " * ",
      " * Why: ${3:Explain the reasoning}",
      " * ",
      " * Hermetic Principle: ${4|Mentalism,Correspondence,Vibration,Polarity,Rhythm,Cause-Effect,Gender|}",
      " */",
      "function ${1:functionName}(${5:params}): ${6:ReturnType} {",
      "  ${7:// Implementation}",
      "}"
    ]
  }
}
```

**Usage**: Type `hfn` → Tab → Fill placeholders

---

### Feature 2: Project-Aware Context

**LSP-AI automatically includes**:
- Recently edited files
- Files imported by current file
- Project README and CLAUDE.md
- Type definitions

**Result**: Suggestions match your codebase patterns, not generic examples

---

### Feature 3: Collaborative Refinement

**Multi-pass completion**:
```typescript
// First pass: Basic structure
function authenticateUser(email, password) {
  // TODO
}

// Accept, then request improvement
// Type comment: // Use bcrypt, return User | null

// Second pass: LSP-AI refines
async function authenticateUser(
  email: string,
  password: string
): Promise<User | null> {
  const user = await db.user.findUnique({ where: { email } });
  if (!user) return null;

  const isValid = await bcrypt.compare(password, user.passwordHash);
  return isValid ? user : null;
}
```

**Iterative**: Guide LSP-AI to exactly what you want

---

## Performance Optimization

### Reduce Latency

**Configuration** (`.lsp-ai/config.json`):
```json
{
  "performance": {
    "cacheEnabled": true,
    "cacheTTL": 3600,
    "maxConcurrentRequests": 3,
    "requestTimeout": 5000,
    "debounceMs": 200
  }
}
```

**Tips**:
- Cache frequent completions
- Debounce typing (don't request on every keystroke)
- Limit concurrent requests (prevent API throttling)

---

### Cost Management

**Track API usage**:
```json
{
  "costTracking": {
    "enabled": true,
    "dailyLimit": 1000,
    "warningThreshold": 800,
    "logFile": "~/.lsp-ai/usage.log"
  }
}
```

**Strategies**:
- Use smaller context window for simple completions
- Higher temperature (0.3-0.5) for creative suggestions
- Lower temperature (0.1-0.2) for predictable completions
- Disable auto-trigger for non-critical files (tests, configs)

---

## Hermetic Best Practices

### Practice 1: Teach Don't Just Complete

**Bad completion** (generic):
```typescript
// You type: function hash
// Generic AI suggests:
function hashPassword(password) {
  return bcrypt.hash(password, 10);
}
```

**Good completion** (teaching):
```typescript
// Hermetic LSP-AI suggests:
/**
 * Hash password using bcrypt
 *
 * Why 12 rounds: OWASP recommendation (security/performance balance)
 * Too low (< 10): Vulnerable to brute force
 * Too high (> 14): Slow user experience
 */
async function hashPassword(password: string): Promise<string> {
  const saltRounds = 12;
  return await bcrypt.hash(password, saltRounds);
}
```

**Configure to always include "Why"** in completions.

---

### Practice 2: Reject Dark Patterns

**Detection** (`.lsp-ai/rules.json`):
```json
{
  "rejectPatterns": [
    {
      "name": "infinite-scroll",
      "pattern": "infinite.*scroll|endless.*scroll",
      "message": "Infinite scroll is a dark pattern (addiction mechanic). Use pagination instead.",
      "severity": "error"
    },
    {
      "name": "pre-checked-boxes",
      "pattern": "checked.*true|defaultChecked.*true",
      "message": "Pre-checked consent boxes are manipulative. Default to unchecked.",
      "severity": "warning"
    }
  ]
}
```

**LSP-AI will warn** if you're about to implement dark pattern.

---

### Practice 3: Correspondence in Naming

**LSP-AI trained on Hermetic naming**:
```typescript
// Bad variable name: temp, x, data
let temp = fetchData();

// LSP-AI suggests rename:
let authenticatedUser = fetchUserData();
```

**Principle**: Names reveal purpose (Correspondence)

---

## Troubleshooting

### Issue 1: Completions are slow

**Cause**: Context window too large

**Solution**:
```json
{
  "contextWindow": 4000  // Reduce from 8000
}
```

---

### Issue 2: Suggestions are generic

**Cause**: Not reading project files

**Solution**:
```json
{
  "codebaseContext": {
    "includeFiles": [
      "CLAUDE.md",
      "README.md",
      "src/**/*.ts"  // Add project files
    ]
  }
}
```

---

### Issue 3: Too many suggestions

**Cause**: Auto-trigger too sensitive

**Solution**:
```json
{
  "completionSettings": {
    "minCharacters": 5,  // Increase from 3
    "debounceMs": 500    // Increase from 200
  }
}
```

---

## Metrics

### Success Indicators

✅ **Productivity**: Coding faster with fewer context switches
✅ **Quality**: Fewer bugs (suggestions include error handling)
✅ **Learning**: Understanding why (completions include explanations)
✅ **Flow**: Staying in editor (not switching to docs/Stack Overflow)

### Track Usage

**Monthly review**:
```bash
# Check usage log
cat ~/.lsp-ai/usage.log

# Metrics:
# - Completions accepted vs rejected
# - Average response time
# - API cost
# - Time saved (estimated)
```

---

## Summary

**LSP-AI = Real-time AI assistance in your editor**

**Benefits**:
- Completions while typing (flow state preserved)
- Context-aware suggestions (understands your codebase)
- Hermetic principles enforced (Gold Hat completions)
- Works alongside Claude Code (complementary tools)

**Setup**: 15 minutes (install + configure)

**Daily use**: Transparent (auto-suggests as you type)

**Result**: Faster coding with maintained quality

---

**Hermetic Principle: Polarity**

**Balance**: Real-time assistance (LSP-AI) ↔ Deliberate planning (Claude Code)

**Both needed**: Flow state coding + Strategic thinking

**May your completions serve wisdom. May your code flow. May AI augment consciousness.**
