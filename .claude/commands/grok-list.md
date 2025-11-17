---
description: List previous Grok dialogue sessions
args: []
---

# /grok-list - List Previous Sessions

List all previous Grok dialogue sessions from the ai-dialogue project.

## Your Task

### 1. Detect ai-dialogue Project Path

Use the same multi-level detection as `/grok`:

```bash
# Level 1: Explicit environment variable
if [ -n "$GROK_PROJECT_PATH" ]; then
  PROJECT_PATH="$GROK_PROJECT_PATH"

# Level 2: User settings
elif [ -f "$HOME/.claude/settings.json" ] && command -v python3 >/dev/null 2>&1; then
  PROJECT_PATH=$(python3 -c "import json; print(json.load(open('$HOME/.claude/settings.json')).get('grok', {}).get('project_path', ''))" 2>/dev/null)
  if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH=""
  fi

# Level 3: Current directory
elif [ -f "pyproject.toml" ] && grep -q "ai-dialogue" pyproject.toml 2>/dev/null; then
  PROJECT_PATH=$(pwd)

# Level 4: Common locations
elif [ -d "$HOME/Documents/LUXOR/PROJECTS/ai-dialogue" ]; then
  PROJECT_PATH="$HOME/Documents/LUXOR/PROJECTS/ai-dialogue"
elif [ -d "$HOME/projects/ai-dialogue" ]; then
  PROJECT_PATH="$HOME/projects/ai-dialogue"
elif [ -d "$HOME/ai-dialogue" ]; then
  PROJECT_PATH="$HOME/ai-dialogue"
fi

# Level 5: Fail with setup instructions
if [ -z "$PROJECT_PATH" ] || [ ! -d "$PROJECT_PATH" ]; then
  echo "❌ Error: ai-dialogue project not found"
  echo "See: /grok --help for configuration instructions"
  exit 1
fi
```

### 2. List Sessions

```bash
cd "$PROJECT_PATH" || exit 1

SESSION_DIR="sessions"

if [ ! -d "$SESSION_DIR" ]; then
  echo "📂 No sessions directory found"
  echo "Location: $PROJECT_PATH/sessions/"
  echo ""
  echo "Tip: Run /grok to create your first dialogue session"
  exit 0
fi

# Count sessions
JSON_COUNT=$(find "$SESSION_DIR" -name "*.json" 2>/dev/null | wc -l | tr -d ' ')
MD_COUNT=$(find "$SESSION_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

if [ "$JSON_COUNT" -eq 0 ] && [ "$MD_COUNT" -eq 0 ]; then
  echo "📂 No sessions found"
  echo "Location: $PROJECT_PATH/sessions/"
  echo ""
  echo "Tip: Run /grok to create your first dialogue session"
  exit 0
fi

echo "📚 Grok Dialogue Sessions"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Location: $PROJECT_PATH/sessions/"
echo "Total: $JSON_COUNT JSON files, $MD_COUNT Markdown transcripts"
echo ""

# List JSON sessions (most recent first)
if [ "$JSON_COUNT" -gt 0 ]; then
  echo "Recent Sessions:"
  echo ""

  find "$SESSION_DIR" -name "*.json" -type f -print0 2>/dev/null | \
    xargs -0 ls -lt | \
    head -20 | \
    while read -r perms links owner group size month day time file; do
      filename=$(basename "$file")
      session_id="${filename%.json}"

      # Try to extract mode from JSON
      if [ -f "$file" ]; then
        mode=$(grep -o '"mode"[[:space:]]*:[[:space:]]*"[^"]*"' "$file" 2>/dev/null | head -1 | sed 's/.*"\([^"]*\)".*/\1/')
        turns=$(grep -o '"turns"[[:space:]]*:[[:space:]]*[0-9]*' "$file" 2>/dev/null | head -1 | sed 's/.*:[[:space:]]*//')

        if [ -n "$mode" ]; then
          printf "  • %-25s  %s %2s %5s  Mode: %-8s  Turns: %s\n" \
            "$session_id" "$month" "$day" "$time" "$mode" "${turns:-N/A}"
        else
          printf "  • %-25s  %s %2s %5s\n" "$session_id" "$month" "$day" "$time"
        fi
      fi
    done

  echo ""
  echo "Usage:"
  echo "  /grok-export <session-id>    # Export session to markdown"
  echo "  cat sessions/<session-id>.json | jq .    # View session details"
fi

# Show markdown transcripts
if [ "$MD_COUNT" -gt 0 ]; then
  echo ""
  echo "Markdown Transcripts:"
  echo ""

  find "$SESSION_DIR" -name "*.md" -type f -print0 2>/dev/null | \
    xargs -0 ls -lt | \
    head -10 | \
    while read -r perms links owner group size month day time file; do
      filename=$(basename "$file")
      filesize=$(du -h "$file" 2>/dev/null | cut -f1)
      printf "  • %-30s  %s %2s %5s  Size: %s\n" "$filename" "$month" "$day" "$time" "$filesize"
    done
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
```

## Examples

```bash
# List all sessions
/grok-list

# Export a session
/grok-list
# Copy session ID from output
/grok-export loop-quantum-20251114
```

## Notes

- Sessions are stored in `sessions/` directory of ai-dialogue project
- JSON files contain full session metadata
- Markdown files are human-readable transcripts
- Sessions are automatically created when you run `/grok`

---

**Status**: Production Ready ✅
**Companion to**: /grok
**Version**: 1.0.0
