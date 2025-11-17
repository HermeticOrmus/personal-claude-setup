#!/bin/bash
# Hermetic Plugin Manager

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
PLUGIN_DIR="$HERMETIC_HOME/plugins"
ACTIVE_PLUGINS="$HERMETIC_HOME/plugins/.active"

# Initialize
mkdir -p "$PLUGIN_DIR"
touch "$ACTIVE_PLUGINS"

# List installed plugins
list_plugins() {
    echo "📦 Installed Plugins:"
    echo ""

    for plugin_path in "$PLUGIN_DIR"/*/; do
        if [ -d "$plugin_path" ] && [ -f "$plugin_path/plugin.json" ]; then
            local plugin_name=$(basename "$plugin_path")
            local version=$(jq -r '.version // "unknown"' "$plugin_path/plugin.json" 2>/dev/null)
            local description=$(jq -r '.description // "No description"' "$plugin_path/plugin.json" 2>/dev/null)

            if grep -q "^$plugin_name$" "$ACTIVE_PLUGINS" 2>/dev/null; then
                echo -e "  ✅ $plugin_name (v$version) - $description"
            else
                echo -e "  ⭕ $plugin_name (v$version) - $description"
            fi
        fi
    done

    echo ""
    echo "Legend: ✅ Active | ⭕ Inactive"
}

# Show plugin info
plugin_info() {
    local plugin_name=$1
    local plugin_path="$PLUGIN_DIR/$plugin_name"

    if [ ! -f "$plugin_path/plugin.json" ]; then
        echo "❌ Plugin '$plugin_name' not found"
        return 1
    fi

    echo "📋 Plugin Information:"
    echo ""
    jq -r '. | "  Name: \(.name)\n  Version: \(.version)\n  Type: \(.type)\n  Author: \(.author // "Unknown")\n  Description: \(.description)"' "$plugin_path/plugin.json"
    echo ""

    # Check activation status
    if grep -q "^$plugin_name$" "$ACTIVE_PLUGINS" 2>/dev/null; then
        echo "  Status: ✅ Active"
    else
        echo "  Status: ⭕ Inactive"
    fi
}

# Validate plugin structure
validate_plugin() {
    local plugin_name=$1
    local plugin_path="$PLUGIN_DIR/$plugin_name"

    echo "🔍 Validating plugin '$plugin_name'..."

    # Check plugin.json exists
    if [ ! -f "$plugin_path/plugin.json" ]; then
        echo "  ❌ Missing plugin.json"
        return 1
    fi
    echo "  ✅ plugin.json found"

    # Validate JSON structure
    if ! jq empty "$plugin_path/plugin.json" 2>/dev/null; then
        echo "  ❌ Invalid JSON in plugin.json"
        return 1
    fi
    echo "  ✅ Valid JSON structure"

    # Check required fields
    local required_fields=("name" "version" "type" "description")
    for field in "${required_fields[@]}"; do
        if [ "$(jq -r ".$field // empty" "$plugin_path/plugin.json")" = "" ]; then
            echo "  ❌ Missing required field: $field"
            return 1
        fi
    done
    echo "  ✅ All required fields present"

    # Check type-specific files
    local plugin_type=$(jq -r '.type' "$plugin_path/plugin.json")
    case "$plugin_type" in
        agent)
            local agent_file=$(jq -r '.files.agent // "agent.md"' "$plugin_path/plugin.json")
            if [ ! -f "$plugin_path/$agent_file" ]; then
                echo "  ❌ Agent file not found: $agent_file"
                return 1
            fi
            echo "  ✅ Agent file found"
            ;;
        command)
            local command_file=$(jq -r '.files.command // "command.md"' "$plugin_path/plugin.json")
            if [ ! -f "$plugin_path/$command_file" ]; then
                echo "  ❌ Command file not found: $command_file"
                return 1
            fi
            echo "  ✅ Command file found"
            ;;
        skill)
            local skill_file=$(jq -r '.files.skill // "skill.md"' "$plugin_path/plugin.json")
            if [ ! -f "$plugin_path/$skill_file" ]; then
                echo "  ❌ Skill file not found: $skill_file"
                return 1
            fi
            echo "  ✅ Skill file found"
            ;;
    esac

    echo ""
    echo "✅ Plugin validation passed!"
    return 0
}

# Activate plugin
activate_plugin() {
    local plugin_name=$1
    local plugin_path="$PLUGIN_DIR/$plugin_name"

    # Validate first
    if ! validate_plugin "$plugin_name"; then
        echo "❌ Cannot activate invalid plugin"
        return 1
    fi

    # Check if already active
    if grep -q "^$plugin_name$" "$ACTIVE_PLUGINS" 2>/dev/null; then
        echo "⚠️  Plugin '$plugin_name' is already active"
        return 0
    fi

    echo "🔌 Activating plugin '$plugin_name'..."

    # Get plugin type and files
    local plugin_type=$(jq -r '.type' "$plugin_path/plugin.json")

    case "$plugin_type" in
        agent)
            local agent_file=$(jq -r '.files.agent // "agent.md"' "$plugin_path/plugin.json")
            local target_dir="$HERMETIC_HOME/../.claude/agents/custom"
            mkdir -p "$target_dir"
            ln -sf "$plugin_path/$agent_file" "$target_dir/$plugin_name.md"
            echo "  ✅ Agent linked to $target_dir"
            ;;
        command)
            local command_file=$(jq -r '.files.command // "command.md"' "$plugin_path/plugin.json")
            local target_dir="$HERMETIC_HOME/../.claude/commands/custom"
            mkdir -p "$target_dir"
            ln -sf "$plugin_path/$command_file" "$target_dir/$plugin_name.md"
            echo "  ✅ Command linked to $target_dir"
            ;;
        skill)
            local skill_file=$(jq -r '.files.skill // "skill.md"' "$plugin_path/plugin.json")
            local target_dir="$HERMETIC_HOME/../.claude/skills/custom"
            mkdir -p "$target_dir"
            ln -sf "$plugin_path/$skill_file" "$target_dir/$plugin_name.md"
            echo "  ✅ Skill linked to $target_dir"
            ;;
    esac

    # Mark as active
    echo "$plugin_name" >> "$ACTIVE_PLUGINS"

    echo "✅ Plugin '$plugin_name' activated successfully!"
}

# Deactivate plugin
deactivate_plugin() {
    local plugin_name=$1

    # Check if active
    if ! grep -q "^$plugin_name$" "$ACTIVE_PLUGINS" 2>/dev/null; then
        echo "⚠️  Plugin '$plugin_name' is not active"
        return 0
    fi

    echo "🔌 Deactivating plugin '$plugin_name'..."

    # Remove symlinks
    find "$HERMETIC_HOME/../.claude" -type l -name "$plugin_name.md" -delete

    # Remove from active list
    grep -v "^$plugin_name$" "$ACTIVE_PLUGINS" > "$ACTIVE_PLUGINS.tmp"
    mv "$ACTIVE_PLUGINS.tmp" "$ACTIVE_PLUGINS"

    echo "✅ Plugin '$plugin_name' deactivated"
}

# Create new plugin from template
create_plugin() {
    local plugin_name=$1
    local plugin_type=${2:-agent}

    if [ -z "$plugin_name" ]; then
        echo "Usage: hm plugin create <name> [type]"
        echo "Types: agent, command, skill, analyzer, integration"
        return 1
    fi

    local plugin_path="$PLUGIN_DIR/$plugin_name"

    if [ -d "$plugin_path" ]; then
        echo "❌ Plugin '$plugin_name' already exists"
        return 1
    fi

    echo "🎨 Creating new $plugin_type plugin: $plugin_name"
    mkdir -p "$plugin_path"

    # Create plugin.json
    cat > "$plugin_path/plugin.json" <<EOF
{
  "name": "$plugin_name",
  "version": "1.0.0",
  "type": "$plugin_type",
  "description": "Description of $plugin_name",
  "author": "$(git config user.name 2>/dev/null || echo 'Your Name')",
  "hermetic_version": "2.0.0",
  "dependencies": [],
  "activation": {
    "auto": false,
    "requires": []
  },
  "files": {
    "$plugin_type": "$plugin_name.md"
  }
}
EOF

    # Create type-specific file
    cat > "$plugin_path/$plugin_name.md" <<EOF
# $plugin_name

**Type**: $plugin_type
**Category**: custom
**Hermetic Principle**: [Choose principle]

## Purpose

[What this $plugin_type does]

## When to Use

- Use case 1
- Use case 2
- Use case 3

## Approach

[How it works]

## Example

\`\`\`
[Example usage]
\`\`\`
EOF

    echo "✅ Plugin created at $plugin_path"
    echo ""
    echo "Next steps:"
    echo "  1. Edit $plugin_path/$plugin_name.md"
    echo "  2. Customize $plugin_path/plugin.json"
    echo "  3. Run: hm plugin validate $plugin_name"
    echo "  4. Run: hm plugin activate $plugin_name"
}

# Main command router
case "${1:-list}" in
    list)
        list_plugins
        ;;
    info)
        plugin_info "$2"
        ;;
    validate)
        validate_plugin "$2"
        ;;
    activate)
        activate_plugin "$2"
        ;;
    deactivate)
        deactivate_plugin "$2"
        ;;
    create)
        create_plugin "$2" "$3"
        ;;
    *)
        echo "Hermetic Plugin Manager"
        echo ""
        echo "Usage: hm plugin <command> [args]"
        echo ""
        echo "Commands:"
        echo "  list                    List installed plugins"
        echo "  info <name>             Show plugin information"
        echo "  validate <name>         Validate plugin structure"
        echo "  activate <name>         Activate a plugin"
        echo "  deactivate <name>       Deactivate a plugin"
        echo "  create <name> [type]    Create new plugin from template"
        echo ""
        exit 1
        ;;
esac
