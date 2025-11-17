---
description: Export Grok dialogue session to markdown
args:
  - name: session_id
    description: Session ID to export
  - name: flags
    description: Optional --output <file>, --format <type>, --verbose
---

# /grok-export - Export Session to Markdown

Export a Grok dialogue session to markdown format.

## Arguments Provided

$ARGUMENTS

## Your Task

### 1. Detect ai-dialogue Project Path

Use **multi-level detection** for portability (no hardcoded paths):

```bash
# Level 1: Explicit environment variable (highest priority)
if [ -n "$GROK_PROJECT_PATH" ]; then
  PROJECT_PATH="$GROK_PROJECT_PATH"

# Level 2: User settings (~/.claude/settings.json)
elif [ -f "$HOME/.claude/settings.json" ] && command -v python3 >/dev/null 2>&1; then
  PROJECT_PATH=$(python3 -c "import json; print(json.load(open('$HOME/.claude/settings.json')).get('grok', {}).get('project_path', ''))" 2>/dev/null)
  if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH=""
  fi

# Level 3: Current directory (if we're IN ai-dialogue project)
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

### 2. Parse Arguments

```bash
# Parse session ID and flags
SESSION_ID=""
OUTPUT_FILE=""
FORMAT="markdown"
VERBOSE=false

# Extract session ID (first non-flag argument)
for arg in $ARGUMENTS; do
  if [[ "$arg" == --* ]]; then
    continue
  elif [ -z "$SESSION_ID" ]; then
    SESSION_ID="$arg"
  fi
done

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --output)
      OUTPUT_FILE="$2"
      shift 2
      ;;
    --format)
      FORMAT="$2"
      shift 2
      ;;
    --verbose)
      VERBOSE=true
      shift
      ;;
    *)
      shift
      ;;
  esac
done

# Validate session ID
if [ -z "$SESSION_ID" ]; then
  echo "❌ Error: Session ID required"
  echo ""
  echo "Usage: /grok-export <session-id> [--output <file>] [--format <type>]"
  echo ""
  echo "Examples:"
  echo "  /grok-export loop-quantum-20251114"
  echo "  /grok-export debate-agi-20251114 --output research.md"
  echo "  /grok-export podcast-ai-20251114 --format json"
  echo ""
  echo "Tip: Use /grok-list to see available sessions"
  exit 1
fi
```

### 3. Locate Session Files

```bash
cd "$PROJECT_PATH" || exit 1

SESSION_DIR="sessions"
JSON_FILE="$SESSION_DIR/$SESSION_ID.json"
MD_FILE="$SESSION_DIR/$SESSION_ID.md"

# Check if session exists
if [ ! -f "$JSON_FILE" ] && [ ! -f "$MD_FILE" ]; then
  echo "❌ Error: Session not found: $SESSION_ID"
  echo ""
  echo "Searched in: $PROJECT_PATH/$SESSION_DIR/"
  echo ""
  echo "Available sessions:"
  /grok-list
  exit 1
fi

if [ "$VERBOSE" = true ]; then
  echo "📂 Session Location: $PROJECT_PATH/$SESSION_DIR/"
  echo "🔍 Session ID: $SESSION_ID"
  echo ""
fi
```

### 4. Export Session

```bash
# Determine output destination
if [ -z "$OUTPUT_FILE" ]; then
  OUTPUT_DEST="stdout"
  OUTPUT_FILE="/dev/stdout"
else
  OUTPUT_DEST="$OUTPUT_FILE"

  # Create output directory if needed
  OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
  if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
  fi
fi

case "$FORMAT" in
  markdown|md)
    # Markdown export
    if [ -f "$MD_FILE" ]; then
      # Use existing markdown file
      if [ "$VERBOSE" = true ]; then
        echo "📄 Using existing markdown transcript"
      fi

      cat "$MD_FILE" > "$OUTPUT_FILE"

    elif [ -f "$JSON_FILE" ]; then
      # Generate markdown from JSON
      if [ "$VERBOSE" = true ]; then
        echo "📄 Generating markdown from JSON session"
      fi

      # Activate venv if needed
      if [ ! -f "venv/bin/activate" ]; then
        echo "❌ Error: Virtual environment not found"
        echo "Expected: $PROJECT_PATH/venv"
        echo ""
        echo "Setup:"
        echo "  cd $PROJECT_PATH"
        echo "  python3 -m venv venv"
        echo "  source venv/bin/activate"
        echo "  pip install -e ."
        exit 1
      fi

      source venv/bin/activate

      # Generate markdown using Python
      python3 << EOF > "$OUTPUT_FILE"
import json
from pathlib import Path

# Load session
with open("$JSON_FILE") as f:
    session = json.load(f)

# Extract metadata
session_id = session.get("session_id", "$SESSION_ID")
mode = session.get("mode", "unknown")
topic = session.get("topic", "N/A")
turns_count = session.get("turns", 0)
created_at = session.get("created_at", "N/A")

# Generate markdown header
print(f"# Grok Dialogue Session: {session_id}")
print()
print(f"**Mode**: {mode}")
print(f"**Topic**: {topic}")
print(f"**Turns**: {turns_count}")
print(f"**Created**: {created_at}")
print()
print("---")
print()

# Extract dialogue turns
dialogue = session.get("dialogue", [])

for i, turn in enumerate(dialogue, 1):
    role = turn.get("role", "unknown")
    content = turn.get("content", "")
    timestamp = turn.get("timestamp", "")

    # Format role
    if role == "user":
        role_label = "🧑 User"
    elif role == "assistant":
        role_label = "🤖 Grok"
    else:
        role_label = f"**{role.title()}**"

    print(f"## Turn {i}: {role_label}")
    if timestamp:
        print(f"*{timestamp}*")
    print()
    print(content)
    print()
    print("---")
    print()

# Summary
tokens_total = session.get("tokens_total", 0)
if tokens_total > 0:
    print(f"**Total Tokens**: {tokens_total:,}")
    print()

print("---")
print(f"*Generated with /grok-export*")
EOF
    fi
    ;;

  json)
    # JSON export (raw session data)
    if [ ! -f "$JSON_FILE" ]; then
      echo "❌ Error: JSON session file not found: $JSON_FILE"
      exit 1
    fi

    if [ "$VERBOSE" = true ]; then
      echo "📄 Exporting JSON session data"
    fi

    # Pretty-print JSON
    if command -v jq >/dev/null 2>&1; then
      jq . "$JSON_FILE" > "$OUTPUT_FILE"
    else
      cat "$JSON_FILE" > "$OUTPUT_FILE"
    fi
    ;;

  text|txt)
    # Plain text export (no markdown formatting)
    if [ -f "$MD_FILE" ]; then
      # Strip markdown formatting
      if command -v pandoc >/dev/null 2>&1; then
        pandoc "$MD_FILE" -f markdown -t plain -o "$OUTPUT_FILE"
      else
        # Fallback: basic markdown stripping
        cat "$MD_FILE" | sed 's/^#\+ //' | sed 's/\*\*//g' | sed 's/\*//g' > "$OUTPUT_FILE"
      fi
    elif [ -f "$JSON_FILE" ]; then
      # Generate plain text from JSON
      source venv/bin/activate
      python3 << EOF > "$OUTPUT_FILE"
import json

with open("$JSON_FILE") as f:
    session = json.load(f)

print(f"Session: {session.get('session_id', '$SESSION_ID')}")
print(f"Mode: {session.get('mode', 'unknown')}")
print(f"Topic: {session.get('topic', 'N/A')}")
print(f"Turns: {session.get('turns', 0)}")
print()
print("="*60)
print()

dialogue = session.get("dialogue", [])
for i, turn in enumerate(dialogue, 1):
    role = turn.get("role", "unknown").upper()
    content = turn.get("content", "")

    print(f"TURN {i} - {role}")
    print("-"*60)
    print(content)
    print()
EOF
    fi
    ;;

  *)
    echo "❌ Error: Unknown format: $FORMAT"
    echo "Supported formats: markdown, json, text"
    exit 1
    ;;
esac

# Success message
if [ "$OUTPUT_DEST" != "stdout" ]; then
  FILE_SIZE=$(du -h "$OUTPUT_FILE" 2>/dev/null | cut -f1)

  echo "✅ Session exported successfully"
  echo ""
  echo "📄 Output: $OUTPUT_FILE"
  echo "📊 Size: $FILE_SIZE"
  echo "📋 Format: $FORMAT"

  if [ "$VERBOSE" = true ]; then
    echo ""
    echo "Preview:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    head -20 "$OUTPUT_FILE"
    echo "..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  fi
fi
```

## Usage Examples

```bash
# Export to stdout (preview)
/grok-export loop-quantum-20251114

# Export to file
/grok-export debate-agi-20251114 --output ~/research/agi-debate.md

# Export as JSON
/grok-export podcast-ai-20251114 --format json --output session.json

# Export as plain text
/grok-export research-ml-20251114 --format text --output summary.txt

# Verbose output
/grok-export loop-quantum-20251114 --output quantum.md --verbose
```

## Format Options

### Markdown (default)
- Human-readable format
- Preserves dialogue structure
- Includes metadata and timestamps
- Best for sharing and reviewing

### JSON
- Raw session data
- Complete conversation history
- Machine-readable
- Best for programmatic processing

### Text
- Plain text format
- No markdown formatting
- Minimal structure
- Best for simple text processing

## Notes

- Sessions are stored in `sessions/` directory of ai-dialogue project
- Markdown files are preferred if they exist (faster)
- JSON files are used to generate markdown if .md doesn't exist
- Export to stdout by default (no --output flag)
- Supports custom output paths with --output
- Use /grok-list to discover available session IDs

---

**Status**: Production Ready ✅
**Companion to**: /grok, /grok-list
**Version**: 1.0.0
