---
name: use-lsp-ai
description: Effective LSP-AI usage for real-time code intelligence
category: development-tools
principle: Polarity
---

# Use LSP-AI - Real-Time Code Intelligence

**Hermetic Principle**: Polarity - "Balance real-time flow (LSP-AI) with deliberate planning (Claude Code)"

**When to use**: Coding in editor, need inline suggestions, want flow state preserved

---

## Quick Context

**LSP-AI** = AI completions in your editor as you type

**NOT a replacement for Claude Code** = Complementary tool

**Think**: Autocomplete on steroids + understands your codebase

---

## When to Use LSP-AI vs Claude Code

### Use LSP-AI For:

✅ **Real-time completions** (while typing)
```typescript
// Type: async function fetch
// LSP-AI completes instantly
```

✅ **Quick refactors** (extract function, rename)
```typescript
// Select code → Right-click → Refactor
```

✅ **Inline docs** (hover over function)
```typescript
// Hover → See what function does
```

✅ **Simple explanations** (what does this regex do)
```typescript
// Select → Explain
```

---

### Use Claude Code For:

✅ **Architecture decisions** (planning features)
```bash
/strategic-plan-architect "user authentication system"
```

✅ **Complex refactoring** (multi-file changes)
```bash
"Refactor authentication to use JWT instead of sessions"
```

✅ **Code review** (holistic analysis)
```bash
"Review this authentication implementation for security issues"
```

✅ **Learning** (deep explanations)
```bash
"Explain how JWT signatures prevent tampering"
```

✅ **Strategic work** (dev docs, MOCs, planning)
```bash
/dev-docs
/update-dev-docs
```

---

## Best Workflow: Use Both

**Morning** (Claude Code):
```
1. Plan the feature
2. /strategic-plan-architect if complex
3. /dev-docs to create task files
4. Understand architecture
```

**Implementation** (LSP-AI):
```
5. Open editor
6. Start coding
7. LSP-AI suggests as you type
8. Accept inline completions
9. Stay in flow
```

**Checkpoints** (Claude Code):
```
10. Mid-day: Quick code review
11. Update dev docs Layer 3
12. Extract any gotchas discovered
```

**End of day** (Claude Code):
```
13. /update-dev-docs
14. Extract Anki cards from Layer 3
15. Update MOCs
16. Plan tomorrow
```

**Result**: Strategic planning + Flow state coding

---

## LSP-AI Key Features

### Feature 1: Context-Aware Completion

**Understands your codebase**:
```typescript
// You have this function in utils.ts:
export function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}

// In another file, you type:
import { calc

// LSP-AI suggests:
import { calculateTotal } from './utils';
```

**Not generic** - knows YOUR functions

---

### Feature 2: Hermetic Completions

**If configured with Hermetic rules**:
```typescript
// You type: function validatePassword

// Bad (generic) completion:
function validatePassword(password) {
  return password.length > 8;
}

// Hermetic completion:
/**
 * Validate password meets security requirements
 *
 * Why these rules: OWASP password guidelines
 * - Min 12 chars (not 8): Modern security standard
 * - Complexity not required: Length > complexity
 */
function validatePassword(password: string): boolean {
  return password.length >= 12;
}
```

**Includes "why"** (Mentalism principle)

---

### Feature 3: Real-Time Refactoring

**Scenario**: Repetitive code detected

```typescript
// Before:
if (!user) {
  throw new Error('User not found');
}

if (!user.email) {
  throw new Error('Email required');
}

if (!user.password) {
  throw new Error('Password required');
}

// Select all three
// LSP-AI suggests: "Extract validation function"

// After (one-click refactor):
function validateUser(user: User | null): asserts user is User {
  if (!user) throw new Error('User not found');
  if (!user.email) throw new Error('Email required');
  if (!user.password) throw new Error('Password required');
}

validateUser(user);
```

---

## Effective Usage Patterns

### Pattern 1: Iterative Refinement

**Start broad, refine with comments**:

```typescript
// Step 1: Basic structure
function authenticate

// LSP-AI suggests:
function authenticate(credentials) {
  // TODO
}

// Step 2: Add type hint in comment
function authenticate(credentials) {
  // email and password, return User | null

// LSP-AI refines:
async function authenticate(
  email: string,
  password: string
): Promise<User | null> {
  // TODO
}

// Step 3: Add implementation hint
async function authenticate(
  email: string,
  password: string
): Promise<User | null> {
  // Use bcrypt to compare, prevent timing attacks

// LSP-AI completes:
async function authenticate(
  email: string,
  password: string
): Promise<User | null> {
  const user = await db.user.findUnique({ where: { email } });
  if (!user) return null;

  // Prevent timing attacks: always run bcrypt even if user doesn't exist
  const isValid = await bcrypt.compare(
    password,
    user?.passwordHash ?? ''
  );

  return isValid ? user : null;
}
```

**Guide LSP-AI** with comments → Get exactly what you want

---

### Pattern 2: Learn from Suggestions

**LSP-AI as teacher**:

```typescript
// You type: regex for email

// LSP-AI suggests with explanation:
/**
 * Email validation regex
 *
 * Pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
 *
 * What it does:
 * - [^\s@]+ = One or more non-whitespace, non-@ characters
 * - @ = Literal @ symbol
 * - \. = Literal dot (escaped)
 *
 * Gotcha: This is BASIC validation only
 * For production: Use 'validator' library's isEmail()
 *
 * Why: Email spec is complex (RFC 5322). Simple regex misses edge cases.
 */
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
```

**Learn while coding** - suggestions teach, not just complete

---

### Pattern 3: Project Pattern Recognition

**LSP-AI learns your patterns**:

**In Midnight-Sun project** (configured with communication principles):
```typescript
// You type: function sendMessage

// LSP-AI suggests (following project style):
/**
 * Send message to client
 *
 * Communication: Brief, genuine, grounded (Midnight Sun principles)
 */
async function sendMessage(
  clientId: string,
  message: string
): Promise<void> {
  // Validate message length (brief, not verbose)
  if (message.length > 500) {
    throw new Error('Message too long - keep it brief');
  }

  await messaging.send({ clientId, message });
}
```

**Project-aware** - follows YOUR style guides

---

## Keyboard Shortcuts (VS Code)

**Essential shortcuts**:

| Action | Shortcut | Use |
|--------|----------|-----|
| Trigger completion | `Ctrl+Space` | Force suggestion when needed |
| Accept suggestion | `Tab` | Accept inline completion |
| Next suggestion | `Alt+]` | Cycle through options |
| Previous suggestion | `Alt+[` | Go back |
| Explain selection | `Ctrl+Shift+E` | Get explanation |
| Refactor | `Ctrl+Shift+R` | Show refactor options |
| Show hover | `Ctrl+K Ctrl+I` | See documentation |

**Customize** in editor settings if defaults don't work for you

---

## Common Patterns

### Pattern: Error Handling Completion

**You type**:
```typescript
try {
  await saveUser(user);
```

**LSP-AI completes**:
```typescript
try {
  await saveUser(user);
} catch (error) {
  // Log error with context
  console.error('Failed to save user:', {
    userId: user.id,
    error: error.message
  });

  // Don't expose internal errors to user (security)
  throw new Error('Failed to save user data');
}
```

**Includes**: Logging, user-facing message, security consideration

---

### Pattern: Type-Safe API Calls

**You type**:
```typescript
async function fetchUser(id
```

**LSP-AI suggests**:
```typescript
async function fetchUser(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);

  if (!response.ok) {
    throw new Error(`HTTP error ${response.status}`);
  }

  const data: unknown = await response.json();

  // Validate shape before casting (runtime safety)
  if (!isUser(data)) {
    throw new Error('Invalid user data from API');
  }

  return data;
}

// Helper (LSP-AI can generate this too)
function isUser(data: unknown): data is User {
  return (
    typeof data === 'object' &&
    data !== null &&
    'id' in data &&
    'email' in data
  );
}
```

**Type-safe** + **Runtime validation** = Production-ready

---

## Integration with Dev Docs

### Workflow: Capture LSP-AI Insights

**During coding**:
```
1. LSP-AI suggests pattern you didn't know
2. Accept suggestion
3. Add to dev docs Layer 3:

## ⚡ Layer 3: Critical Insights

**🎯 Key Patterns**:
- **Runtime Type Validation**: LSP-AI taught me to validate API responses with type guards, not just TypeScript types
```

**Later**:
```
4. Extract to Anki card:
   Q: Why validate API responses at runtime if TypeScript has types?
   A: TypeScript types are compile-time only. Runtime data (from APIs) can be anything. Use type guards to validate shape before casting.

5. Add to MOC:
   In TypeScript MOC → "Patterns" section → Link to note on type guards
```

**LSP-AI insights** → **Dev docs** → **Anki** → **MOC** = **Permanent knowledge**

---

## Troubleshooting

### Issue: Suggestions are wrong/unhelpful

**Cause**: Not enough context

**Solution**: Add comments describing what you want
```typescript
// Instead of just typing: function calc

// Type this:
// Calculate cart total using reduce, handle empty array case
function calc
```

**Better suggestions** with more context

---

### Issue: Too many suggestions (distracting)

**Cause**: Auto-trigger too aggressive

**Solution**: Adjust settings
```json
{
  "lsp-ai.autoTrigger": false,  // Disable auto
  "lsp-ai.triggerOnDemand": true // Use Ctrl+Space manually
}
```

**Or**: Increase minimum characters before triggering

---

### Issue: Suggestions don't match project style

**Cause**: LSP-AI not reading project files

**Solution**: Configure codebase context
```json
{
  "lsp-ai.codebaseContext": {
    "includeFiles": [
      "CLAUDE.md",
      "README.md",
      "src/**/*.ts"
    ]
  }
}
```

---

## Cost Management

### Reduce API Costs

**Strategies**:
1. **Cache completions** (same code → same suggestion)
2. **Debounce typing** (wait 200ms before requesting)
3. **Smaller context** for simple files (reduce tokens)
4. **Disable for tests/configs** (non-critical files)

**Config**:
```json
{
  "lsp-ai.performance": {
    "cacheEnabled": true,
    "debounceMs": 200
  },
  "lsp-ai.contextWindow": 4000,  // Smaller for most cases
  "lsp-ai.disableForPatterns": [
    "**/*.test.ts",
    "**/*.config.js"
  ]
}
```

---

## Success Metrics

### You're using LSP-AI well when:

✅ **Staying in flow** (not switching to docs/Stack Overflow)
✅ **Accepting 50%+ suggestions** (useful completions)
✅ **Learning new patterns** (suggestions teach you)
✅ **Faster coding** (measurable productivity increase)
✅ **Fewer bugs** (suggestions include error handling)

### Needs adjustment if:

❌ **Ignoring all suggestions** (too generic/unhelpful)
❌ **Distracted by popups** (too many auto-triggers)
❌ **High API costs** (need to optimize settings)
❌ **Context switching still** (not using LSP-AI properly)

---

## Hermetic Principles Applied

### Mentalism - Clear Intent → Clear Code

**LSP-AI configured to ask "why"**:
```typescript
// Generic completion:
const timeout = 5000;

// Hermetic completion:
const REQUEST_TIMEOUT_MS = 5000; // 5 seconds - balance UX (responsive) vs reliability (network latency)
```

---

### Correspondence - Structure Reflects Purpose

**LSP-AI suggests names that reveal intent**:
```typescript
// Bad: temp, data, result
let temp = fetch();

// LSP-AI suggests:
let authenticatedUser = fetchUserWithValidation();
```

---

### Polarity - Balance Automation with Intention

**Use LSP-AI**:
- Automate boilerplate (error handling, type definitions)
- Free mental energy for creative work

**Don't let LSP-AI**:
- Make architectural decisions
- Choose algorithms without understanding
- Replace your thinking

**Balance**: AI suggests, you decide

---

## Quick Reference

### Setup
1. Install: `npm install -g lsp-ai`
2. Configure: Add to editor settings
3. Set API key: `ANTHROPIC_API_KEY` env var

### Daily Use
- Type normally, accept suggestions with Tab
- Force suggestion: Ctrl+Space
- Explain code: Select → Ctrl+Shift+E
- Refactor: Select → Ctrl+Shift+R

### Best Practices
- Use with Claude Code (not instead of)
- Guide with comments for better suggestions
- Extract insights to dev docs → Anki → MOCs
- Adjust settings to your workflow

---

**For complete setup guide, see** `.hermetic/docs/lsp-ai-setup-guide.md`

**May your completions flow. May your code teach. May AI augment wisdom.**
