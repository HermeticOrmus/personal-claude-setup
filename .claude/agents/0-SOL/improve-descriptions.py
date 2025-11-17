#!/usr/bin/env python3
"""
Description Improvement Tool
Analyzes and suggests improvements for weak agent descriptions
"""

import os
import re
from pathlib import Path
from typing import Dict, List, Tuple

class DescriptionImprover:
    def __init__(self, agents_dir: str):
        self.agents_dir = Path(agents_dir)
        self.weak_descriptions = []

    def analyze_all_agents(self):
        """Analyze all agent descriptions"""
        # Process numbered directories
        agent_dirs = [
            "1-INNER-CIRCLE",
            "2-ASTEROID-BELT",
            "3-OUTER-CIRCLE",
            "4-DWARF-PLANETS",
            "5-BEYOND"
        ]

        for agent_dir in agent_dirs:
            dir_path = self.agents_dir / agent_dir
            if dir_path.exists():
                self.process_directory(dir_path)

        return self.weak_descriptions

    def process_directory(self, directory: Path):
        """Process all markdown files in directory"""
        for md_file in directory.rglob("*.md"):
            if any(skip in md_file.name for skip in ["README", "TEMPLATE", "GUIDE"]):
                continue

            with open(md_file, 'r', encoding='utf-8') as f:
                content = f.read()

            if not content.strip().startswith('---'):
                continue

            match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
            if not match:
                continue

            frontmatter = match.group(1)
            desc_match = re.search(r'description:\s*[|>]?\s*(.*?)(?=\n[a-z_]+:|$)', frontmatter, re.DOTALL)

            if desc_match:
                description = desc_match.group(1).strip()
                issue = self.analyze_description(description)

                if issue:
                    self.weak_descriptions.append({
                        "file": str(md_file.relative_to(self.agents_dir)),
                        "name": md_file.stem,
                        "description": description,
                        "issue": issue,
                        "suggested_improvement": self.suggest_improvement(md_file.stem, description)
                    })

    def analyze_description(self, description: str) -> str:
        """Analyze description and return issue if found"""
        desc_lower = description.lower()

        if len(description) < 50:
            return "Too short (< 50 chars)"

        if "use this agent" in desc_lower:
            return "Starts with 'Use this agent' (should be expert role)"

        if "proactive" not in desc_lower and "automatically" not in desc_lower:
            return "Missing PROACTIVE trigger"

        # Check for vague phrases
        vague_phrases = ["helps with", "assists in", "for when you need"]
        for phrase in vague_phrases:
            if phrase in desc_lower:
                return f"Vague phrase: '{phrase}'"

        # Check for missing technology specificity
        has_tech = any(tech in description for tech in [
            "React", "Python", "Node", "TypeScript", "PostgreSQL",
            "AWS", "Docker", "Kubernetes", "API", "CI/CD", "Terraform",
            "Redis", "MongoDB", "GraphQL", "REST", "Vue", "Angular"
        ])

        technical_agents = ["developer", "architect", "engineer", "tester", "automator"]
        is_technical = any(role in description.lower() for role in technical_agents)

        if is_technical and not has_tech:
            return "Missing technology stack"

        return None

    def suggest_improvement(self, agent_name: str, current_desc: str) -> str:
        """Suggest improved description based on agent name and current description"""
        # Extract any technology mentions
        tech_pattern = r'(React|Python|Node|TypeScript|PostgreSQL|AWS|Docker|Kubernetes|CI/CD|Terraform)'
        tech_mentions = re.findall(tech_pattern, current_desc)

        # Common agent role mappings
        role_map = {
            "frontend-developer": ("Expert frontend developer", "UI frameworks and accessible web applications"),
            "backend-architect": ("Expert backend architect", "scalable API design and microservices"),
            "mobile-app-builder": ("Expert mobile developer", "native iOS/Android and React Native"),
            "database-architect": ("Expert database architect", "schema design and query optimization"),
            "devops-automator": ("Expert DevOps engineer", "CI/CD pipelines and Infrastructure as Code"),
            "ai-engineer": ("Expert AI/ML engineer", "language models and intelligent automation"),
            "ui-designer": ("Expert UI/UX designer", "interface design and user experience"),
            "brand-guardian": ("Strategic brand guardian", "visual identity systems and brand consistency"),
        }

        # Try to map agent name to role
        for key, (role, spec) in role_map.items():
            if key in agent_name.lower():
                tech_stack = ", ".join(tech_mentions) if tech_mentions else "[Tech Stack]"
                return f"{role} specializing in {spec}. Masters {tech_stack}. Use PROACTIVELY when [trigger condition]."

        return "Expert [Role] specializing in [Specialization]. Masters [Tech Stack]. Use PROACTIVELY when [Triggers]."

def main():
    agents_dir = r"C:\Users\ormus\.claude\agents"
    improver = DescriptionImprover(agents_dir)

    print("Analyzing all agent descriptions...")
    weak_descriptions = improver.analyze_all_agents()

    print(f"\nFound {len(weak_descriptions)} agents with weak descriptions\n")
    print("=" * 80)

    for i, agent in enumerate(weak_descriptions, 1):
        print(f"\n{i}. {agent['file']}")
        print(f"   Issue: {agent['issue']}")
        print(f"   Current: {agent['description'][:100]}...")
        print(f"   Suggested: {agent['suggested_improvement']}")

    # Save to file for manual review
    output_file = os.path.join(agents_dir, "0-SOL", "description-improvements.txt")
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("AGENT DESCRIPTION IMPROVEMENTS\n")
        f.write("=" * 80 + "\n\n")

        for i, agent in enumerate(weak_descriptions, 1):
            f.write(f"{i}. {agent['file']}\n")
            f.write(f"   Issue: {agent['issue']}\n")
            f.write(f"   Current:\n")
            f.write(f"   {agent['description']}\n\n")
            f.write(f"   Suggested:\n")
            f.write(f"   {agent['suggested_improvement']}\n")
            f.write("\n" + "-" * 80 + "\n\n")

    print(f"\nDetailed report saved to: {output_file}")

if __name__ == "__main__":
    main()
