# Hermetic Plugin System

**Extend the living machine with custom functionality**

---

## 🔌 Plugin Architecture

The Hermetic system supports plugins to extend functionality without modifying core code.

### Plugin Types

1. **Agent Plugins** - Custom specialized agents
2. **Command Plugins** - New slash commands
3. **Skill Plugins** - Additional Hermetic skills
4. **Analyzer Plugins** - Custom analytics
5. **Integration Plugins** - External tool connections

---

## 📁 Plugin Structure

```
.hermetic/plugins/
├── README.md (this file)
├── plugin-template/
│   ├── plugin.json          # Plugin metadata
│   ├── agent.md             # Agent definition (if applicable)
│   ├── command.md           # Command definition (if applicable)
│   ├── skill.md             # Skill definition (if applicable)
│   ├── analyzer.py          # Analyzer script (if applicable)
│   └── integration.sh       # Integration script (if applicable)
└── [your-plugin-name]/
    └── ...
```

---

## 🎯 Creating a Plugin

### Step 1: Create Plugin Directory

```bash
mkdir -p ~/.hermetic/plugins/my-plugin
cd ~/.hermetic/plugins/my-plugin
```

### Step 2: Create plugin.json

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "type": "agent",
  "description": "Brief description of what this plugin does",
  "author": "Your Name",
  "hermetic_version": "2.0.0",
  "dependencies": [],
  "activation": {
    "auto": true,
    "requires": ["python3"]
  },
  "files": {
    "agent": "my-agent.md",
    "script": "handler.py"
  }
}
```

### Step 3: Create Your Plugin Files

**Example Agent Plugin** (`my-agent.md`):

```markdown
# My Custom Agent

**Type**: agent
**Category**: custom
**Hermetic Principle**: Mentalism

## Purpose

This agent does [specific thing] by applying [approach].

## When to Use

- Use case 1
- Use case 2
- Use case 3

## Capabilities

1. Capability 1
2. Capability 2
3. Capability 3

## Example Usage

\`\`\`
User: "[example request]"
Agent: [example response]
\`\`\`

## Implementation

[How this agent works internally]
```

**Example Script** (`handler.py`):

```python
#!/usr/bin/env python3
"""
Custom plugin handler
"""

def process(context):
    """Main plugin logic"""
    # Your custom logic here
    return {
        'status': 'success',
        'message': 'Plugin executed successfully',
        'data': {}
    }

if __name__ == '__main__':
    import sys
    import json

    if len(sys.argv) > 1:
        context = json.loads(sys.argv[1])
        result = process(context)
        print(json.dumps(result))
    else:
        print("Usage: handler.py '<json_context>'")
```

### Step 4: Activate Plugin

```bash
# Link to agents directory (if agent plugin)
ln -s ~/.hermetic/plugins/my-plugin/my-agent.md ~/.claude/agents/custom/my-agent.md

# Or use plugin manager
hm plugin activate my-plugin
```

---

## 🎨 Plugin Examples

### Example 1: Code Review Agent

```bash
mkdir -p ~/.hermetic/plugins/code-reviewer
cd ~/.hermetic/plugins/code-reviewer

cat > plugin.json <<'EOF'
{
  "name": "code-reviewer",
  "version": "1.0.0",
  "type": "agent",
  "description": "Intelligent code review agent",
  "author": "Hermetic Community",
  "hermetic_version": "2.0.0"
}
EOF

cat > code-reviewer.md <<'EOF'
# Code Reviewer Agent

**Type**: agent
**Category**: engineering
**Hermetic Principle**: Mentalism + Cause-Effect

## Purpose

Provides thorough code review focusing on:
- Code quality and patterns
- Potential bugs
- Performance implications
- Security vulnerabilities
- Hermetic principle alignment

## When to Use

- Before committing code
- During pull request review
- When refactoring
- Learning from others' code

## Approach

1. Analyze code structure (Mentalism)
2. Trace execution paths (Cause-Effect)
3. Identify anti-patterns
4. Suggest improvements
5. Rate code quality

## Example Usage

\`\`\`
User: "Review this authentication function"
Agent: [Provides detailed analysis of security, patterns, improvements]
\`\`\`
EOF
```

### Example 2: Daily Standup Generator

```bash
mkdir -p ~/.hermetic/plugins/daily-standup
cd ~/.hermetic/plugins/daily-standup

cat > daily-standup.py <<'EOF'
#!/usr/bin/env python3
import csv
from datetime import datetime, timedelta
from pathlib import Path
import os

HERMETIC_HOME = Path(os.environ.get('HERMETIC_HOME', Path.home() / '.hermetic'))
USAGE_LOG = HERMETIC_HOME / 'analytics' / 'usage.csv'

def generate_standup():
    """Generate standup report from yesterday's work"""
    yesterday = (datetime.now() - timedelta(days=1)).strftime('%Y-%m-%d')

    yesterday_work = []
    with open(USAGE_LOG) as f:
        reader = csv.DictReader(f)
        for row in reader:
            if row['timestamp'].startswith(yesterday):
                yesterday_work.append(row)

    if not yesterday_work:
        print("No work logged yesterday")
        return

    print(f"📅 Daily Standup - {yesterday}\n")
    print("What I did yesterday:")

    # Group by type
    agents_used = [w for w in yesterday_work if w['type'] == 'agent']
    commands_used = [w for w in yesterday_work if w['type'] == 'command']

    for agent in set(a['name'] for a in agents_used):
        contexts = [a['context'] for a in agents_used if a['name'] == agent and a['context']]
        if contexts:
            print(f"  - Used {agent}: {', '.join(set(contexts))}")
        else:
            print(f"  - Used {agent}")

    print(f"\nTotal work sessions: {len(yesterday_work)}")

if __name__ == '__main__':
    generate_standup()
EOF

chmod +x daily-standup.py
```

---

## 🔧 Plugin Manager

```bash
# hm plugin commands

hm plugin list           # List installed plugins
hm plugin activate <name>    # Activate a plugin
hm plugin deactivate <name>  # Deactivate a plugin
hm plugin info <name>        # Show plugin info
hm plugin validate <name>    # Validate plugin structure
```

---

## 📚 Plugin Categories

### Agent Plugins
Custom specialized agents for specific tasks

**Ideas**:
- Domain-specific agents (e.g., Kubernetes expert, AWS architect)
- Industry-specific agents (e.g., healthcare, finance)
- Language-specific agents (e.g., Rust guru, Python expert)

### Command Plugins
New ceremonial workflows

**Ideas**:
- `/retrospective` - Team retrospective facilitator
- `/decision-matrix` - Multi-criteria decision analysis
- `/refactor` - Systematic refactoring guidance

### Skill Plugins
Additional practical workflows

**Ideas**:
- `negotiate-salary` - Salary negotiation workflow
- `write-documentation` - Documentation creation process
- `onboard-teammate` - Team onboarding workflow

### Analyzer Plugins
Custom analytics and insights

**Ideas**:
- Productivity pattern detector
- Burnout predictor
- Learning trajectory analyzer
- Team collaboration analyzer

### Integration Plugins
Connect to external tools

**Ideas**:
- Jira integration
- Slack notification
- GitHub webhook handler
- Calendar sync
- Email digests

---

## 🎯 Best Practices

### 1. Follow Hermetic Principles
Every plugin should embody at least one Hermetic principle

### 2. Document Thoroughly
Clear README and usage examples

### 3. Respect User Autonomy
Plugins should empower, not control

### 4. Maintain Compatibility
Test against current Hermetic version

### 5. Handle Errors Gracefully
Don't break the system if plugin fails

### 6. Log Usage
Integrate with analytics system

---

## 🌟 Community Plugins

Share your plugins with the community:

1. Create plugin following standards
2. Document thoroughly
3. Test extensively
4. Share on GitHub
5. Submit to community registry

---

## 🔍 Plugin Validation

Before activating, plugins are checked for:

- Valid `plugin.json` structure
- Required files present
- No conflicts with existing plugins
- Safe code (no obvious malicious patterns)
- Hermetic principle alignment

---

## 🚀 Advanced: Plugin API

Plugins can access Hermetic system APIs:

```python
from hermetic import api

# Log usage
api.log_usage(type='agent', name='my-agent', context='custom-work')

# Get patterns
patterns = api.get_patterns()

# Check health
health = api.get_health_score()

# Get context
context = api.detect_context()
```

---

## 📖 Example: Full Plugin

See `plugin-template/` directory for complete example plugin with all features.

---

## 🤝 Contributing

To contribute plugins to the official collection:

1. Create high-quality plugin
2. Follow all best practices
3. Submit pull request with:
   - Plugin code
   - Documentation
   - Tests
   - Usage examples

---

**Plugin System Version**: 1.0.0
**Created**: 2025-10-29

*"Extend consciousness through modular wisdom."*
