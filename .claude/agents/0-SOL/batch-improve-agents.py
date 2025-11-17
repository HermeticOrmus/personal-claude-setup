#!/usr/bin/env python3
"""
Batch Agent Improvement Tool
Systematically improves agents by adding missing fields and enhancing descriptions
"""

import os
import re
from pathlib import Path
from typing import Dict, List, Optional

# Model assignment: Complex agents get sonnet, simple utilities get haiku
COMPLEX_AGENT_CATEGORIES = [
    "engineering", "design", "product", "testing", "sacred-arsenal",
    "learning-masters", "hermetic-principles", "project-management",
    "consciousness-guardrails", "life-advisory"
]

SIMPLE_AGENT_CATEGORIES = [
    "utilities", "bonus", "meta-orchestration"
]

class AgentImprover:
    def __init__(self, agents_dir: str):
        self.agents_dir = Path(agents_dir)
        self.stats = {
            "processed": 0,
            "model_added": 0,
            "version_added": 0,
            "description_improved": 0,
            "skipped": 0,
            "errors": []
        }

    def process_all_agents(self, dry_run: bool = True):
        """Process all agent files in numbered directories"""
        # Only process numbered directories (the actual agent organization)
        agent_dirs = [
            "1-INNER-CIRCLE",
            "2-ASTEROID-BELT",
            "3-OUTER-CIRCLE",
            "4-DWARF-PLANETS",
            "5-BEYOND"
        ]

        for agent_dir in agent_dirs:
            dir_path = self.agents_dir / agent_dir
            if not dir_path.exists():
                continue

            print(f"\nProcessing {agent_dir}...")
            self.process_directory(dir_path, dry_run)

        return self.stats

    def process_directory(self, directory: Path, dry_run: bool):
        """Recursively process all markdown files in directory"""
        for md_file in directory.rglob("*.md"):
            # Skip documentation files
            if any(skip in md_file.name for skip in ["README", "TEMPLATE", "GUIDE", "CATALOG"]):
                continue

            try:
                self.improve_agent(md_file, dry_run)
            except Exception as e:
                self.stats["errors"].append({
                    "file": str(md_file),
                    "error": str(e)
                })

    def improve_agent(self, agent_file: Path, dry_run: bool):
        """Improve a single agent file"""
        with open(agent_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # Skip if no frontmatter at all
        if not content.strip().startswith('---'):
            self.stats["skipped"] += 1
            return

        self.stats["processed"] += 1
        original_content = content

        # Extract frontmatter
        match = re.match(r'^---\s*\n(.*?)\n---\s*\n', content, re.DOTALL)
        if not match:
            self.stats["skipped"] += 1
            return

        frontmatter_text = match.group(1)
        frontmatter_end = match.end()
        body = content[frontmatter_end:]

        # Parse frontmatter (simple line-by-line parsing)
        fm_lines = frontmatter_text.split('\n')
        fm_dict = {}
        current_key = None
        current_value = []

        for line in fm_lines:
            if ':' in line and not line.startswith(' '):
                # Save previous key-value
                if current_key:
                    fm_dict[current_key] = '\n'.join(current_value).strip()

                # New key
                key, value = line.split(':', 1)
                current_key = key.strip()
                current_value = [value.strip()]
            elif current_key:
                # Continuation of multiline value
                current_value.append(line)

        # Save last key-value
        if current_key:
            fm_dict[current_key] = '\n'.join(current_value).strip()

        # Track changes
        changes_made = []

        # Add model field if missing
        if 'model' not in fm_dict:
            category = self.get_category(agent_file)
            if any(cat in str(agent_file).lower() for cat in COMPLEX_AGENT_CATEGORIES):
                fm_dict['model'] = 'sonnet'
            else:
                fm_dict['model'] = 'haiku'
            changes_made.append(f"Added model: {fm_dict['model']}")
            self.stats["model_added"] += 1

        # Add version field if missing
        if 'version' not in fm_dict:
            fm_dict['version'] = '1.0'
            changes_made.append("Added version: 1.0")
            self.stats["version_added"] += 1

        # Check description quality
        if 'description' in fm_dict:
            desc = fm_dict['description']
            if self.needs_description_improvement(desc):
                # Only flag, don't auto-improve (needs manual review)
                changes_made.append("Description needs improvement (manual review)")

        # If changes were made, reconstruct frontmatter
        if changes_made:
            new_frontmatter = self.reconstruct_frontmatter(fm_dict)
            new_content = f"---\n{new_frontmatter}\n---\n{body}"

            if not dry_run:
                with open(agent_file, 'w', encoding='utf-8') as f:
                    f.write(new_content)

            print(f"  {agent_file.name}: {', '.join(changes_made)}")

    def get_category(self, agent_file: Path) -> str:
        """Get category from file path"""
        parts = str(agent_file).lower()
        for cat in COMPLEX_AGENT_CATEGORIES + SIMPLE_AGENT_CATEGORIES:
            if cat in parts:
                return cat
        return "unknown"

    def needs_description_improvement(self, description: str) -> bool:
        """Check if description needs improvement"""
        if len(description) < 50:
            return True

        weak_phrases = ["helps with", "this agent", "use when you need"]
        desc_lower = description.lower()

        return any(phrase in desc_lower for phrase in weak_phrases)

    def reconstruct_frontmatter(self, fm_dict: Dict) -> str:
        """Reconstruct frontmatter from dictionary"""
        # Preferred order of fields
        field_order = [
            'name', 'description', 'model', 'version', 'color', 'realm',
            'tools', 'celestial_name', 'hermetic_nature'
        ]

        lines = []
        added_fields = set()

        # Add fields in preferred order
        for field in field_order:
            if field in fm_dict:
                value = fm_dict[field]
                if field == 'description' and '\n' in value:
                    # Multiline description
                    lines.append(f"{field}: |")
                    for line in value.split('\n'):
                        if line.strip():
                            lines.append(f"  {line}")
                elif field == 'tools' and (value.startswith('[') or value.startswith('-')):
                    # List of tools
                    lines.append(f"{field}:")
                    if value.startswith('['):
                        # Convert from array format
                        tools = value.strip('[]').split(',')
                        for tool in tools:
                            lines.append(f"  - {tool.strip()}")
                    else:
                        lines.append(f"  {value}")
                else:
                    lines.append(f"{field}: {value}")
                added_fields.add(field)

        # Add remaining fields not in preferred order
        for field, value in fm_dict.items():
            if field not in added_fields:
                lines.append(f"{field}: {value}")

        return '\n'.join(lines)

def main():
    import argparse

    parser = argparse.ArgumentParser(description="Batch improve agent files")
    parser.add_argument('--execute', action='store_true', help='Actually modify files (default is dry-run)')
    args = parser.parse_args()

    agents_dir = r"C:\Users\ormus\.claude\agents"
    improver = AgentImprover(agents_dir)

    print(f"{'=' * 60}")
    print(f"Agent Batch Improvement Tool")
    print(f"Mode: {'EXECUTE' if args.execute else 'DRY-RUN'}")
    print(f"{'=' * 60}")

    stats = improver.process_all_agents(dry_run=not args.execute)

    print(f"\n{'=' * 60}")
    print(f"RESULTS")
    print(f"{'=' * 60}")
    print(f"Agents processed: {stats['processed']}")
    print(f"Model field added: {stats['model_added']}")
    print(f"Version field added: {stats['version_added']}")
    print(f"Skipped: {stats['skipped']}")
    print(f"Errors: {len(stats['errors'])}")

    if stats['errors']:
        print(f"\nErrors encountered:")
        for error in stats['errors'][:5]:
            print(f"  {error['file']}: {error['error']}")

    if not args.execute:
        print(f"\nThis was a DRY-RUN. Use --execute to apply changes.")

if __name__ == "__main__":
    main()
