# Skill Template - Copy to ~/.claude/skills/{skill-name}/SKILL.md

---
name: skill-name-here
description: One-line description of what this skill does
---

<!--
PURPOSE: [Describe what problem this skill solves]
PRINCIPLE: [Which Hermetic principle does this embody?]
WHEN TO USE: [Specific scenarios where this skill is valuable]

Example:
PURPOSE: Initialize new TypeScript projects with validation and guardrails
PRINCIPLE: Vibration - "Ship imperfect work, iterate rapidly"
WHEN TO USE: Starting any new TypeScript-based project
-->

## Context

[Provide background information the agent needs to understand this workflow]

Example:
- This project uses port/adapter architecture
- All external integrations go in src/ports/
- Business logic stays in src/domain/
- TypeScript strict mode is non-negotiable

## Prerequisites

[List what must exist before running this skill]

Example:
- Node.js 18+ installed
- Git repository initialized
- Package manager chosen (npm/yarn/pnpm)

## Workflow Steps

[Step-by-step instructions. Be explicit. Agent executes these in order.]

### 1. Initialize Project Structure

```bash
# Create directory structure
mkdir -p src/{ports,domain,adapters}
mkdir -p tests/{unit,integration}

# Initialize package.json
npm init -y
```

### 2. Install Dependencies

```bash
# Core dependencies
npm install zod

# Dev dependencies
npm install -D typescript @types/node
npm install -D eslint prettier
npm install -D vitest @vitest/ui
```

### 3. Create Configuration Files

**tsconfig.json:**
```json
{
  "compilerOptions": {
    "strict": true,
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "esModuleInterop": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

**package.json scripts:**
```json
{
  "scripts": {
    "build": "tsc",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint src/**/*.ts",
    "format": "prettier --write src/**/*.ts"
  }
}
```

### 4. Create Validation Layer

**src/ports/port-config.ts:**
```typescript
export const PORT_CONFIG = {
  directory: 'src/ports/',
  pattern: '{serviceName}/adapter.ts',
  requiredExports: ['handler', 'schema']
} as const;

export function validatePortStructure(config: typeof PORT_CONFIG) {
  // Validation logic here
  // Ensures all ports follow convention
}
```

### 5. Verify Setup

```bash
# Verify TypeScript compiles
npm run build

# Verify tests run
npm run test

# Verify linting passes
npm run lint
```

## Success Criteria

[How do we know this skill executed successfully?]

- [ ] All directories created
- [ ] Dependencies installed
- [ ] TypeScript compiles without errors
- [ ] Validation layer in place
- [ ] Tests pass
- [ ] No linting errors

## Common Issues

[Document common problems and solutions]

**Issue:** TypeScript version conflict
**Solution:** Remove node_modules and package-lock.json, reinstall

**Issue:** Strict mode shows too many errors initially
**Solution:** This is expected. Fix incrementally, don't disable strict mode.

## Next Steps

[What should happen after this skill completes?]

1. Create first port adapter following the pattern
2. Write tests for the port
3. Run validation to ensure compliance
4. Commit initial structure

## Related Skills

[Link to other skills that work well with this one]

- `validate-typescript-project` - Verify project follows standards
- `create-port-adapter` - Create new external integration
- `setup-ci-pipeline` - Add GitHub Actions workflow

---

**Hermetic Principle Applied:** [Explain how this skill embodies sacred technology]

Example:
This skill embodies **Mentalism** (clear mental models) and **Vibration** (ship quickly, iterate).
By creating explicit structure and validation upfront, we enable rapid iteration without
accumulating technical debt. The agent can't create poorly structured code because the
system enforces correctness from day one.
