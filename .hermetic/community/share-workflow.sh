#!/bin/bash
# Hermetic Community Sharing System
# Share your agents, workflows, and insights with the community

HERMETIC_HOME="${HERMETIC_HOME:-$HOME/.hermetic}"
COMMUNITY_DIR="$HERMETIC_HOME/community"
SHARED_DIR="$COMMUNITY_DIR/shared"

mkdir -p "$SHARED_DIR"/{agents,workflows,insights,patterns}

# Package an agent for sharing
package_agent() {
    local agent_name=$1
    local agent_file="$HERMETIC_HOME/../.claude/agents"

    # Find the agent file
    local found_agent=$(find "$agent_file" -name "${agent_name}.md" | head -1)

    if [ -z "$found_agent" ]; then
        echo "❌ Agent '$agent_name' not found"
        return 1
    fi

    echo "📦 Packaging agent: $agent_name"

    # Create package
    local package_dir="$SHARED_DIR/agents/$agent_name"
    mkdir -p "$package_dir"

    # Copy agent file
    cp "$found_agent" "$package_dir/agent.md"

    # Create metadata
    cat > "$package_dir/metadata.json" <<EOF
{
  "name": "$agent_name",
  "type": "agent",
  "shared_by": "$(git config user.name 2>/dev/null || echo 'Anonymous')",
  "shared_date": "$(date +%Y-%m-%d)",
  "version": "1.0.0",
  "hermetic_version": "2.0.0",
  "effectiveness_rating": $(get_agent_effectiveness "$agent_name"),
  "usage_count": $(get_agent_usage_count "$agent_name")
}
EOF

    # Create README
    cat > "$package_dir/README.md" <<EOF
# $agent_name Agent

**Shared by**: $(git config user.name 2>/dev/null || echo 'Anonymous')
**Date**: $(date +%Y-%m-%d)
**Type**: Agent

## Description

$(grep -A 5 "## Purpose" "$found_agent" | tail -n +2)

## Usage Statistics

- Times used: $(get_agent_usage_count "$agent_name")
- Average effectiveness: $(get_agent_effectiveness "$agent_name")/5.0

## Installation

\`\`\`bash
# Copy to your agents directory
cp agent.md ~/.claude/agents/community/$agent_name.md
\`\`\`

## License

Gold Hat Philosophy - Use for empowerment, not extraction
EOF

    echo "✅ Agent packaged at: $package_dir"
    echo ""
    echo "To share publicly:"
    echo "  1. Review $package_dir/README.md"
    echo "  2. Create gist or repo with contents"
    echo "  3. Share link with community"
}

# Get agent effectiveness from usage log
get_agent_effectiveness() {
    local agent_name=$1
    awk -F',' -v agent="$agent_name" '
        $2 == "agent" && $3 == agent && $5 != "" {
            sum += $5
            count++
        }
        END {
            if (count > 0) printf "%.2f", sum/count
            else print "0"
        }
    ' "$HERMETIC_HOME/analytics/usage.csv" 2>/dev/null
}

# Get agent usage count
get_agent_usage_count() {
    local agent_name=$1
    grep ",agent,$agent_name," "$HERMETIC_HOME/analytics/usage.csv" 2>/dev/null | wc -l
}

# Package a workflow
package_workflow() {
    local workflow_name=$1

    echo "📦 Packaging workflow: $workflow_name"

    local package_dir="$SHARED_DIR/workflows/$workflow_name"
    mkdir -p "$package_dir"

    # Interactive workflow builder
    echo ""
    echo "Describe your workflow step by step:"
    echo ""

    local steps=()
    local step_num=1

    while true; do
        echo -n "Step $step_num (or 'done'): "
        read step

        if [ "$step" = "done" ]; then
            break
        fi

        steps+=("$step")
        ((step_num++))
    done

    # Create workflow file
    cat > "$package_dir/workflow.md" <<EOF
# $workflow_name Workflow

**Shared by**: $(git config user.name 2>/dev/null || echo 'Anonymous')
**Date**: $(date +%Y-%m-%d)
**Type**: Workflow

## Steps

EOF

    for i in "${!steps[@]}"; do
        echo "$((i+1)). ${steps[$i]}" >> "$package_dir/workflow.md"
    done

    cat >> "$package_dir/workflow.md" <<EOF

## Hermetic Principles Applied

[List which of the 7 principles this workflow embodies]

## When to Use

[Describe scenarios where this workflow is effective]

## Expected Outcomes

[What results does this workflow produce?]
EOF

    # Create metadata
    cat > "$package_dir/metadata.json" <<EOF
{
  "name": "$workflow_name",
  "type": "workflow",
  "shared_by": "$(git config user.name 2>/dev/null || echo 'Anonymous')",
  "shared_date": "$(date +%Y-%m-%d)",
  "steps": ${#steps[@]},
  "hermetic_version": "2.0.0"
}
EOF

    echo "✅ Workflow packaged at: $package_dir"
    echo "   Edit $package_dir/workflow.md to add details"
}

# Share insights
share_insight() {
    echo "💡 Share Your Insight"
    echo ""

    echo -n "Insight title: "
    read title

    echo -n "Category (pattern/technique/principle): "
    read category

    echo ""
    echo "Describe your insight (end with Ctrl+D):"
    local content=$(cat)

    local safe_title=$(echo "$title" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local insight_file="$SHARED_DIR/insights/${safe_title}.md"

    cat > "$insight_file" <<EOF
# $title

**Category**: $category
**Shared by**: $(git config user.name 2>/dev/null || echo 'Anonymous')
**Date**: $(date +%Y-%m-%d)

## Insight

$content

## Application

[How to apply this insight in practice]

## Results

[What outcomes have you seen from applying this?]

---

*Gold Hat Philosophy: Build what elevates*
EOF

    echo "✅ Insight saved to: $insight_file"
}

# Export patterns
export_patterns() {
    echo "📊 Exporting Usage Patterns"

    if [ ! -f "$HERMETIC_HOME/intelligence/patterns.json" ]; then
        echo "⚠️  No patterns found. Run pattern analysis first:"
        echo "   python3 $HERMETIC_HOME/intelligence/pattern-recognition.py"
        return 1
    fi

    local export_file="$SHARED_DIR/patterns/my-patterns-$(date +%Y%m%d).json"

    # Anonymize and export
    jq '{
        agent_sequences,
        time_patterns,
        workflow_patterns,
        effectiveness_patterns,
        shared_by: "Anonymous",
        shared_date: now | strftime("%Y-%m-%d"),
        hermetic_version: "2.0.0"
    }' "$HERMETIC_HOME/intelligence/patterns.json" > "$export_file"

    echo "✅ Patterns exported to: $export_file"
    echo ""
    echo "This file contains:"
    echo "  - Common agent sequences"
    echo "  - Productive time patterns"
    echo "  - Effective workflows"
    echo "  - Effectiveness ratings"
    echo ""
    echo "Share to help others learn from your patterns!"
}

# Import shared content
import_shared() {
    local import_url=$1
    local import_type=$2

    echo "📥 Importing shared content..."
    echo "   URL: $import_url"
    echo "   Type: $import_type"

    # Create temp directory
    local temp_dir=$(mktemp -d)

    case "$import_type" in
        agent)
            # Download agent
            curl -sL "$import_url" -o "$temp_dir/agent.md"

            # Validate
            if grep -q "^#" "$temp_dir/agent.md"; then
                local agent_name=$(basename "$import_url" .md)
                cp "$temp_dir/agent.md" "$HERMETIC_HOME/../.claude/agents/community/${agent_name}.md"
                echo "✅ Agent imported: $agent_name"
            else
                echo "❌ Invalid agent file"
            fi
            ;;
        workflow)
            curl -sL "$import_url" -o "$temp_dir/workflow.md"
            echo "✅ Workflow downloaded to: $temp_dir/workflow.md"
            echo "   Review and adapt to your needs"
            ;;
        patterns)
            curl -sL "$import_url" -o "$temp_dir/patterns.json"
            echo "✅ Patterns downloaded"
            echo "   Analyze and compare with your patterns"
            ;;
    esac

    rm -rf "$temp_dir"
}

# Generate community report
community_report() {
    echo "🌍 Hermetic Community Contribution Report"
    echo ""

    local shared_agents=$(find "$SHARED_DIR/agents" -type d -mindepth 1 -maxdepth 1 | wc -l)
    local shared_workflows=$(find "$SHARED_DIR/workflows" -type d -mindepth 1 -maxdepth 1 | wc -l)
    local shared_insights=$(find "$SHARED_DIR/insights" -name "*.md" | wc -l)
    local shared_patterns=$(find "$SHARED_DIR/patterns" -name "*.json" | wc -l)

    echo "📊 Your Contributions:"
    echo "  Agents:    $shared_agents"
    echo "  Workflows: $shared_workflows"
    echo "  Insights:  $shared_insights"
    echo "  Patterns:  $shared_patterns"
    echo ""

    if [ $((shared_agents + shared_workflows + shared_insights + shared_patterns)) -eq 0 ]; then
        echo "💡 Start sharing your learnings with the community!"
        echo ""
        echo "Commands:"
        echo "  hm share agent <name>      - Share an agent"
        echo "  hm share workflow <name>   - Share a workflow"
        echo "  hm share insight           - Share an insight"
        echo "  hm share patterns          - Share your patterns"
    else
        echo "🙏 Thank you for contributing to the Hermetic community!"
        echo ""
        echo "Your shared knowledge helps elevate humanity's"
        echo "relationship with technology."
    fi
}

# Main router
case "$1" in
    agent)
        package_agent "$2"
        ;;
    workflow)
        package_workflow "$2"
        ;;
    insight)
        share_insight
        ;;
    patterns)
        export_patterns
        ;;
    import)
        import_shared "$2" "$3"
        ;;
    report)
        community_report
        ;;
    *)
        echo "Hermetic Community Sharing"
        echo ""
        echo "Usage: hm share <command> [args]"
        echo ""
        echo "Commands:"
        echo "  agent <name>              Package an agent for sharing"
        echo "  workflow <name>           Package a workflow for sharing"
        echo "  insight                   Share an insight or technique"
        echo "  patterns                  Export your usage patterns"
        echo "  import <url> <type>       Import shared content"
        echo "  report                    View your contributions"
        echo ""
        exit 1
        ;;
esac
