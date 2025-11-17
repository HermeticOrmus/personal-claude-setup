# VS Code Integration for Hermetic System

**Transform VS Code into a Hermetic-aware development environment**

---

## 🎯 Quick Setup

### 1. Settings Configuration

Create or edit `.vscode/settings.json` in your project:

```json
{
  "hermetic.enabled": true,
  "hermetic.autoContext": true,
  "hermetic.autoLog": true,
  "hermetic.dailyReminder": true,

  "terminal.integrated.env.linux": {
    "HERMETIC_HOME": "${env:HOME}/.hermetic"
  },
  "terminal.integrated.env.osx": {
    "HERMETIC_HOME": "${env:HOME}/.hermetic"
  },
  "terminal.integrated.env.windows": {
    "HERMETIC_HOME": "${env:USERPROFILE}/.hermetic"
  }
}
```

### 2. Keyboard Shortcuts

Create or edit `.vscode/keybindings.json`:

```json
[
  {
    "key": "ctrl+h ctrl+g",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "/gnosis "
    },
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+h ctrl+a",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "/align "
    },
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+h ctrl+v",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "/verify "
    },
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+h ctrl+i",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "/illuminate "
    },
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+h ctrl+h",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "hm context\n"
    }
  },
  {
    "key": "ctrl+h ctrl+d",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "hm dashboard\n"
    }
  },
  {
    "key": "ctrl+h ctrl+s",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "hm stats\n"
    }
  }
]
```

### 3. Tasks Configuration

Create `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Hermetic: Start Day",
      "type": "shell",
      "command": "hm start-day",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Hermetic: Close Day",
      "type": "shell",
      "command": "hm close-day",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Hermetic: Dashboard",
      "type": "shell",
      "command": "${env:HOME}/.hermetic/intelligence/dashboard-generator.sh full",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Hermetic: Context Check",
      "type": "shell",
      "command": "hm context",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Hermetic: Health Check",
      "type": "shell",
      "command": "hm health",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Hermetic: AI Insights",
      "type": "shell",
      "command": "python3 ${env:HOME}/.hermetic/intelligence/ai-insights.py && cat ${env:HOME}/.hermetic/intelligence/ai-insights.md",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Hermetic: Pattern Analysis",
      "type": "shell",
      "command": "python3 ${env:HOME}/.hermetic/intelligence/pattern-recognition.py && cat ${env:HOME}/.hermetic/intelligence/insights.md",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    }
  ]
}
```

---

## ⌨️ Keyboard Shortcuts Reference

### Hermetic Commands
- `Ctrl+H Ctrl+G` - Invoke /gnosis
- `Ctrl+H Ctrl+A` - Invoke /align
- `Ctrl+H Ctrl+V` - Invoke /verify
- `Ctrl+H Ctrl+I` - Invoke /illuminate

### Quick Actions
- `Ctrl+H Ctrl+H` - Show context
- `Ctrl+H Ctrl+D` - Show dashboard
- `Ctrl+H Ctrl+S` - Show stats

### Tasks (via Command Palette)
- `Tasks: Run Task` → "Hermetic: Start Day"
- `Tasks: Run Task` → "Hermetic: Dashboard"
- `Tasks: Run Task` → "Hermetic: AI Insights"

---

## 🎨 Custom Snippets

Create `.vscode/hermetic.code-snippets`:

```json
{
  "Hermetic Gnosis": {
    "prefix": "hm-gnosis",
    "body": [
      "// Hermetic: Gnosis - ${1:Understanding goal}",
      "// Principle: Mentalism - Clear thinking creates clear code",
      "",
      "$0"
    ],
    "description": "Add Hermetic gnosis comment"
  },
  "Hermetic Align": {
    "prefix": "hm-align",
    "body": [
      "// Hermetic: Align - ${1:Ethical consideration}",
      "// Does this serve genuine needs or extract value?",
      "",
      "$0"
    ],
    "description": "Add Hermetic alignment check"
  },
  "Hermetic Function": {
    "prefix": "hm-func",
    "body": [
      "/**",
      " * Hermetic: ${1:Principle Applied}",
      " * Purpose: ${2:What this does and why}",
      " * ",
      " * @param {${3:type}} ${4:param} - ${5:description}",
      " * @returns {${6:type}} ${7:description}",
      " */",
      "function ${8:functionName}(${4:param}) {",
      "  $0",
      "}"
    ],
    "description": "Create Hermetic-documented function"
  },
  "Hermetic TODO": {
    "prefix": "hm-todo",
    "body": [
      "// TODO (Hermetic): ${1:Task}",
      "// Principle: ${2:Relevant Principle}",
      "// Context: ${3:Why this matters}",
      "$0"
    ],
    "description": "Add Hermetic TODO"
  }
}
```

---

## 🔧 Extension Recommendations

Add to `.vscode/extensions.json`:

```json
{
  "recommendations": [
    "ms-vscode.vscode-speech",
    "streetsidesoftware.code-spell-checker",
    "eamodio.gitlens",
    "alefragnani.project-manager",
    "gruntfuggly.todo-tree"
  ]
}
```

---

## 📊 Status Bar Integration

Create custom status bar script `.vscode/hermetic-status.sh`:

```bash
#!/bin/bash
# Hermetic Status Bar Info

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Get compact status
if [ -f "$HERMETIC_HOME/intelligence/dashboard-generator.sh" ]; then
    $HERMETIC_HOME/intelligence/dashboard-generator.sh compact
else
    echo "🔮 Hermetic"
fi
```

Then configure in VS Code settings:

```json
{
  "terminal.integrated.rightClickBehavior": "default",
  "terminal.integrated.commandsToSkipShell": [
    "hermetic.showStatus"
  ]
}
```

---

## 🎯 Daily Workflow in VS Code

### Morning

1. Open VS Code
2. `Ctrl+Shift+P` → "Tasks: Run Task" → "Hermetic: Start Day"
3. `Ctrl+H Ctrl+H` to see context
4. Start coding with Hermetic awareness

### During Work

1. Before implementing feature:
   - `Ctrl+H Ctrl+G` → Type feature description
   - Get gnosis from Claude Code

2. Before committing:
   - `Ctrl+H Ctrl+A` → Check alignment
   - Git hooks will also check

3. When stuck:
   - `Ctrl+H Ctrl+H` → Get context suggestions
   - Apply suggested agents/skills

### Evening

1. `Ctrl+Shift+P` → "Tasks: Run Task" → "Hermetic: Close Day"
2. Review health and stats
3. Rate effectiveness of agents used

---

## 🚀 Advanced: Custom Extension

For maximum integration, create a custom VS Code extension.

### Extension Scaffold

```typescript
// extension.ts
import * as vscode from 'vscode';
import { exec } from 'child_process';

export function activate(context: vscode.ExtensionContext) {
    // Show Hermetic status in status bar
    const statusBarItem = vscode.window.createStatusBarItem(
        vscode.StatusBarAlignment.Right,
        100
    );
    statusBarItem.text = "$(pulse) Hermetic";
    statusBarItem.tooltip = "Hermetic Consciousness System";
    statusBarItem.command = 'hermetic.showDashboard';
    statusBarItem.show();

    // Update status periodically
    setInterval(() => {
        exec('hm health', (error, stdout) => {
            if (!error) {
                // Parse health score and update status bar
                const match = stdout.match(/Health Score: (\d+)/);
                if (match) {
                    const score = parseInt(match[1]);
                    if (score >= 80) {
                        statusBarItem.text = "$(check) Hermetic";
                    } else if (score >= 60) {
                        statusBarItem.text = "$(pulse) Hermetic";
                    } else {
                        statusBarItem.text = "$(warning) Hermetic";
                    }
                }
            }
        });
    }, 60000); // Update every minute

    // Register commands
    context.subscriptions.push(
        vscode.commands.registerCommand('hermetic.showDashboard', () => {
            const terminal = vscode.window.createTerminal('Hermetic Dashboard');
            terminal.sendText('hm dashboard');
            terminal.show();
        })
    );

    context.subscriptions.push(
        vscode.commands.registerCommand('hermetic.startDay', () => {
            const terminal = vscode.window.createTerminal('Hermetic');
            terminal.sendText('hm start-day');
            terminal.show();
        })
    );

    context.subscriptions.push(
        vscode.commands.registerCommand('hermetic.closeDay', () => {
            const terminal = vscode.window.createTerminal('Hermetic');
            terminal.sendText('hm close-day');
            terminal.show();
        })
    );

    // Context-aware suggestions
    context.subscriptions.push(
        vscode.commands.registerCommand('hermetic.showContext', () => {
            exec('hm context', (error, stdout) => {
                if (!error) {
                    vscode.window.showInformationMessage(
                        stdout,
                        'View Full Dashboard'
                    ).then(selection => {
                        if (selection) {
                            vscode.commands.executeCommand('hermetic.showDashboard');
                        }
                    });
                }
            });
        })
    );

    // Auto-suggest on file open
    vscode.workspace.onDidOpenTextDocument((document) => {
        // Detect language and suggest relevant agents
        const lang = document.languageId;
        // Show suggestion notification
    });
}

export function deactivate() {}
```

### package.json for Extension

```json
{
  "name": "hermetic-vscode",
  "displayName": "Hermetic Consciousness",
  "description": "Hermetic System integration for VS Code",
  "version": "1.0.0",
  "engines": {
    "vscode": "^1.80.0"
  },
  "categories": ["Other"],
  "activationEvents": ["*"],
  "main": "./out/extension.js",
  "contributes": {
    "commands": [
      {
        "command": "hermetic.showDashboard",
        "title": "Hermetic: Show Dashboard"
      },
      {
        "command": "hermetic.startDay",
        "title": "Hermetic: Start Day"
      },
      {
        "command": "hermetic.closeDay",
        "title": "Hermetic: Close Day"
      },
      {
        "command": "hermetic.showContext",
        "title": "Hermetic: Show Context"
      }
    ],
    "keybindings": [
      {
        "command": "hermetic.showContext",
        "key": "ctrl+h ctrl+h"
      }
    ]
  }
}
```

---

## 📝 User Workspace Settings

For per-project customization, add to workspace `.vscode/settings.json`:

```json
{
  "hermetic.project.agents": ["neptune", "hera"],
  "hermetic.project.principle": "mentalism",
  "hermetic.project.context": "web-backend",
  "hermetic.notifications.enabled": true,
  "hermetic.notifications.dailyReminder": "09:00",
  "hermetic.notifications.sabbathReminder": true
}
```

---

## 🎨 Theme Customization

Add Hermetic-inspired colors to your theme:

```json
{
  "workbench.colorCustomizations": {
    "statusBar.background": "#4A148C",
    "statusBar.foreground": "#FFD700",
    "statusBar.noFolderBackground": "#4A148C",
    "titleBar.activeBackground": "#311B92",
    "titleBar.activeForeground": "#FFD700"
  }
}
```

---

## 🔔 Notifications Setup

Create notification script `.vscode/hermetic-notify.sh`:

```bash
#!/bin/bash
# Hermetic VS Code Notifications

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"

# Check health and notify if low
health_score=$(tail -1 "$HERMETIC_HOME/health/health-history.csv" 2>/dev/null | cut -d',' -f7)

if [ ! -z "$health_score" ] && [ "$health_score" -lt 60 ]; then
    notify-send "🔮 Hermetic Health Alert" "Health score: $health_score/100. Run 'hm health' for details."
fi

# Check for high-priority AI insights
if [ -f "$HERMETIC_HOME/intelligence/ai-insights.md" ]; then
    if grep -q "🔴" "$HERMETIC_HOME/intelligence/ai-insights.md"; then
        notify-send "🔮 Hermetic AI Alert" "High-priority insights available. Run 'hm insights' to view."
    fi
fi
```

Run via cron or as startup script.

---

## 📚 Quick Reference Card

Create `.vscode/hermetic-reference.md` for quick access:

```markdown
# Hermetic Quick Reference

## Keyboard Shortcuts
- `Ctrl+H Ctrl+G` - /gnosis (deep understanding)
- `Ctrl+H Ctrl+A` - /align (ethics check)
- `Ctrl+H Ctrl+V` - /verify (validation)
- `Ctrl+H Ctrl+H` - Context check

## Daily Workflow
1. Morning: Tasks → "Hermetic: Start Day"
2. During: Use shortcuts for commands
3. Evening: Tasks → "Hermetic: Close Day"

## Code Snippets
- `hm-gnosis` - Add gnosis comment
- `hm-align` - Add alignment check
- `hm-func` - Hermetic function template

## Terminal Commands
- `hm stats` - Usage statistics
- `hm health` - Health dashboard
- `hm context` - Smart suggestions
```

---

## 🎯 Installation Checklist

- [ ] Copy settings to `.vscode/settings.json`
- [ ] Copy keybindings to `.vscode/keybindings.json`
- [ ] Copy tasks to `.vscode/tasks.json`
- [ ] Create snippets in `.vscode/hermetic.code-snippets`
- [ ] Install recommended extensions
- [ ] Test keyboard shortcuts
- [ ] Run first "Hermetic: Start Day" task
- [ ] Configure workspace-specific settings
- [ ] (Optional) Build custom extension

---

## 🚀 Next Level

Once basic integration is working:

1. **Build custom extension** (see scaffold above)
2. **Add CodeLens** for inline Hermetic suggestions
3. **Integrate with GitHub Copilot** for Hermetic-aware completions
4. **Create debugging integration** with Hermetic principles
5. **Add test runner integration** with effectiveness tracking

---

**VS Code Integration Version**: 1.0.0
**Created**: 2025-10-29

*"Transform your editor into a consciousness amplifier."*
