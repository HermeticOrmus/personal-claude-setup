#!/bin/bash
#
# HOOK TEMPLATE - Copy this to ~/.claude/hooks/{hook-name}.sh
#
# Hook types available:
# - UserPromptSubmit: Runs BEFORE agent sees your prompt
# - PreBash: Runs BEFORE every bash command
# - PostToolUse: Runs AFTER every tool use (Edit, Write, etc.)
# - StopEvent: Runs when agent FINISHES responding
#
# PURPOSE: [Describe what this hook does and why]
# PRINCIPLE: [Which Hermetic principle does this embody?]
#
# Example: Context injection hook
# PURPOSE: Add project context when working on TypeScript projects
# PRINCIPLE: Correspondence - "Context travels with code"
#

# Environment variables available:
# - USER_PROMPT: The user's prompt text (UserPromptSubmit)
# - BASH_COMMAND: The bash command to execute (PreBash)
# - TOOL_NAME: Name of tool used (PostToolUse)
# - CWD: Current working directory (all hooks)

# Example 1: UserPromptSubmit - Context Injection
if [[ "$USER_PROMPT" =~ "TypeScript" ]]; then
  cat <<EOF

═══════════════════════════════════════════
📋 TYPESCRIPT PROJECT CONTEXT
═══════════════════════════════════════════

Standards enforced in this project:
- Strict mode enabled (no 'any' types)
- Zod for runtime validation
- ESLint + Prettier configured
- Tests required for new features

Current architecture:
- src/ports/ for external integrations
- src/domain/ for business logic
- src/adapters/ for infrastructure

═══════════════════════════════════════════
EOF
fi

# Example 2: PreBash - Security Validation
if echo "$BASH_COMMAND" | grep -qE "(rm -rf|> /dev/|mkfs|dd if=)"; then
  echo '{"permissionDecision": "deny", "reason": "Dangerous command blocked by security hook"}'
  exit 0
fi

# Example 3: PostToolUse - Track File Changes
if [[ "$TOOL_NAME" == "Edit" ]] || [[ "$TOOL_NAME" == "Write" ]]; then
  # Log the file path for build checking later
  echo "$FILE_PATH" >> ~/.claude/edit-log.json
fi

# Allow by default
echo '{"permissionDecision": "allow"}'
