#!/usr/bin/env python3
"""
Agent Improvement Scanner
Systematically analyzes all 174 agents for missing best practices
"""

import os
import re
import yaml
import json
from pathlib import Path
from typing import Dict, List, Optional, Tuple

class AgentScanner:
    def __init__(self, agents_dir: str):
        self.agents_dir = Path(agents_dir)
        self.results = {
            "total_agents": 0,
            "missing_frontmatter": [],
            "missing_model": [],
            "missing_version": [],
            "weak_descriptions": [],
            "missing_behavioral_traits": [],
            "excellent_agents": [],
            "by_category": {}
        }

    def scan_all_agents(self):
        """Scan all agent markdown files"""
        agent_files = list(self.agents_dir.rglob("*.md"))

        # Exclude certain directories and files
        excluded_patterns = [
            "/0-SOL/",
            "/_",
            "README",
            "AGENT-",
            "TEMPLATE",
            "FRAMEWORK"
        ]

        for agent_file in agent_files:
            agent_path_str = str(agent_file)

            # Skip excluded files
            if any(pattern in agent_path_str for pattern in excluded_patterns):
                continue

            self.results["total_agents"] += 1
            self.analyze_agent(agent_file)

        return self.results

    def analyze_agent(self, agent_file: Path):
        """Analyze a single agent file"""
        with open(agent_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract frontmatter
        frontmatter = self.extract_frontmatter(content)
        relative_path = agent_file.relative_to(self.agents_dir)

        # Get category
        category = self.get_category(agent_file)
        if category not in self.results["by_category"]:
            self.results["by_category"][category] = []

        agent_info = {
            "path": str(relative_path),
            "name": frontmatter.get("name", "MISSING") if frontmatter else "MISSING",
            "category": category
        }

        # Check for missing frontmatter
        if frontmatter is None:
            self.results["missing_frontmatter"].append(agent_info)
            self.results["by_category"][category].append(agent_info)
            return

        # Check for missing model field
        if "model" not in frontmatter:
            self.results["missing_model"].append(agent_info)

        # Check for missing version field
        if "version" not in frontmatter:
            self.results["missing_version"].append(agent_info)

        # Check description quality
        description = frontmatter.get("description", "")
        if self.is_weak_description(description):
            agent_info["description"] = description
            self.results["weak_descriptions"].append(agent_info)

        # Check for behavioral traits section
        if not self.has_behavioral_traits(content):
            self.results["missing_behavioral_traits"].append(agent_info)

        # Check if agent is excellent
        if self.is_excellent_agent(frontmatter, content):
            self.results["excellent_agents"].append(agent_info)

        self.results["by_category"][category].append(agent_info)

    def extract_frontmatter(self, content: str) -> Optional[Dict]:
        """Extract YAML frontmatter from markdown content"""
        match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
        if not match:
            return None

        try:
            return yaml.safe_load(match.group(1))
        except yaml.YAMLError:
            return None

    def get_category(self, agent_file: Path) -> str:
        """Get category from agent file path"""
        parts = agent_file.parts
        for part in parts:
            if part.startswith(("1-", "2-", "3-", "4-", "5-", "6-")):
                return part
        return "uncategorized"

    def is_weak_description(self, description: str) -> bool:
        """Check if description is weak"""
        if len(description) < 50:
            return True

        # Check for vague phrases
        weak_phrases = [
            "helps with",
            "assists in",
            "this agent",
            "for when you need",
        ]

        description_lower = description.lower()
        if any(phrase in description_lower for phrase in weak_phrases):
            return True

        # Check for missing PROACTIVE trigger
        if "proactive" not in description_lower and "automatically" not in description_lower:
            return True

        # Check for missing technology stack
        if not any(tech in description for tech in [
            "React", "Python", "Node", "TypeScript", "PostgreSQL",
            "AWS", "Docker", "Kubernetes", "API", "CI/CD"
        ]):
            # Only flag if it's likely a technical agent
            pass

        return False

    def has_behavioral_traits(self, content: str) -> bool:
        """Check if agent has behavioral traits section"""
        patterns = [
            r"##\s*Behavioral Traits",
            r"##\s*I ALWAYS:",
            r"##\s*I NEVER:",
            r"##\s*I PROACTIVELY:"
        ]

        for pattern in patterns:
            if re.search(pattern, content, re.IGNORECASE):
                return True

        return False

    def is_excellent_agent(self, frontmatter: Dict, content: str) -> bool:
        """Check if agent meets excellent criteria"""
        if not frontmatter:
            return False

        has_model = "model" in frontmatter
        has_version = "version" in frontmatter
        has_good_description = not self.is_weak_description(frontmatter.get("description", ""))
        has_traits = self.has_behavioral_traits(content)

        return has_model and has_version and has_good_description and has_traits

    def save_results(self, output_file: str):
        """Save results to JSON file"""
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(self.results, f, indent=2)

def main():
    agents_dir = r"C:\Users\ormus\.claude\agents"
    scanner = AgentScanner(agents_dir)

    print("Scanning all agents...")
    results = scanner.scan_all_agents()

    print(f"\nSCAN COMPLETE")
    print(f"=" * 60)
    print(f"Total agents scanned: {results['total_agents']}")
    print(f"Missing frontmatter: {len(results['missing_frontmatter'])}")
    print(f"Missing model field: {len(results['missing_model'])}")
    print(f"Missing version field: {len(results['missing_version'])}")
    print(f"Weak descriptions: {len(results['weak_descriptions'])}")
    print(f"Missing behavioral traits: {len(results['missing_behavioral_traits'])}")
    print(f"Excellent agents: {len(results['excellent_agents'])}")
    print(f"=" * 60)

    # Save detailed results
    output_file = os.path.join(agents_dir, "0-SOL", "agent-scan-results.json")
    scanner.save_results(output_file)
    print(f"\nDetailed results saved to: {output_file}")

    # Print priority items
    if results['missing_frontmatter']:
        print(f"\nCRITICAL - Agents missing frontmatter:")
        for agent in results['missing_frontmatter'][:5]:
            print(f"  - {agent['path']}")

    if results['missing_model']:
        print(f"\nP1 - Agents missing model field (first 10):")
        for agent in results['missing_model'][:10]:
            print(f"  - {agent['path']}")

    if results['weak_descriptions']:
        print(f"\nP1 - Agents with weak descriptions (first 10):")
        for agent in results['weak_descriptions'][:10]:
            print(f"  - {agent['path']}")

if __name__ == "__main__":
    main()
