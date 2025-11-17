#!/usr/bin/env python3
"""
Hermetic Pattern Recognition Engine
Analyzes usage patterns and provides intelligent insights
"""

import csv
import json
from datetime import datetime, timedelta
from collections import defaultdict, Counter
from pathlib import Path
import os

HERMETIC_HOME = Path(os.environ.get('HERMETIC_HOME', Path.home() / '.hermetic'))
USAGE_LOG = HERMETIC_HOME / 'analytics' / 'usage.csv'
PATTERNS_FILE = HERMETIC_HOME / 'intelligence' / 'patterns.json'
INSIGHTS_FILE = HERMETIC_HOME / 'intelligence' / 'insights.md'


class PatternRecognizer:
    def __init__(self):
        self.patterns = self.load_patterns()
        self.usage_data = self.load_usage_data()

    def load_patterns(self):
        """Load existing patterns or create new structure"""
        if PATTERNS_FILE.exists():
            with open(PATTERNS_FILE) as f:
                return json.load(f)
        return {
            'agent_sequences': [],
            'time_patterns': {},
            'context_patterns': {},
            'effectiveness_patterns': {},
            'workflow_patterns': []
        }

    def load_usage_data(self):
        """Load usage data from CSV"""
        if not USAGE_LOG.exists():
            return []

        data = []
        with open(USAGE_LOG) as f:
            reader = csv.DictReader(f)
            for row in reader:
                data.append(row)
        return data

    def analyze_agent_sequences(self):
        """Find common agent usage sequences"""
        sequences = []
        current_sequence = []

        for entry in self.usage_data:
            if entry['type'] == 'agent':
                current_sequence.append(entry['name'])
                if len(current_sequence) >= 2:
                    sequences.append(tuple(current_sequence[-2:]))

        # Count sequences
        sequence_counts = Counter(sequences)
        common_sequences = [
            {'sequence': list(seq), 'count': count}
            for seq, count in sequence_counts.most_common(10)
        ]

        self.patterns['agent_sequences'] = common_sequences
        return common_sequences

    def analyze_time_patterns(self):
        """Identify productive time patterns"""
        time_effectiveness = defaultdict(list)

        for entry in self.usage_data:
            if entry.get('effectiveness'):
                try:
                    dt = datetime.strptime(entry['timestamp'], '%Y-%m-%d %H:%M:%S')
                    hour = dt.hour
                    effectiveness = float(entry['effectiveness'])
                    time_effectiveness[hour].append(effectiveness)
                except (ValueError, KeyError):
                    continue

        # Calculate average effectiveness by hour
        hourly_avg = {}
        for hour, ratings in time_effectiveness.items():
            hourly_avg[hour] = sum(ratings) / len(ratings)

        self.patterns['time_patterns'] = hourly_avg
        return hourly_avg

    def analyze_context_patterns(self):
        """Find which agents work best in which contexts"""
        context_agent_effectiveness = defaultdict(lambda: defaultdict(list))

        for entry in self.usage_data:
            if entry.get('effectiveness') and entry.get('context'):
                try:
                    effectiveness = float(entry['effectiveness'])
                    context = entry['context']
                    name = entry['name']
                    context_agent_effectiveness[context][name].append(effectiveness)
                except (ValueError, KeyError):
                    continue

        # Calculate averages
        patterns = {}
        for context, agents in context_agent_effectiveness.items():
            patterns[context] = {
                agent: sum(ratings) / len(ratings)
                for agent, ratings in agents.items()
            }

        self.patterns['context_patterns'] = patterns
        return patterns

    def detect_workflow_patterns(self):
        """Detect common workflows (command + agent combinations)"""
        workflows = []

        i = 0
        while i < len(self.usage_data) - 1:
            current = self.usage_data[i]
            next_entry = self.usage_data[i + 1]

            # Check if command followed by agent
            if current['type'] == 'command' and next_entry['type'] == 'agent':
                workflows.append({
                    'command': current['name'],
                    'agent': next_entry['name'],
                    'context': current.get('context', 'general')
                })

            i += 1

        # Count workflow patterns
        workflow_counts = Counter(
            (w['command'], w['agent']) for w in workflows
        )

        common_workflows = [
            {
                'command': cmd,
                'agent': agent,
                'count': count
            }
            for (cmd, agent), count in workflow_counts.most_common(10)
        ]

        self.patterns['workflow_patterns'] = common_workflows
        return common_workflows

    def analyze_effectiveness_patterns(self):
        """Find which combinations are most effective"""
        effectiveness = {
            'agents': defaultdict(list),
            'commands': defaultdict(list),
            'skills': defaultdict(list)
        }

        for entry in self.usage_data:
            if entry.get('effectiveness'):
                try:
                    rating = float(entry['effectiveness'])
                    type_key = entry['type'] + 's'  # agent -> agents
                    if type_key in effectiveness:
                        effectiveness[type_key][entry['name']].append(rating)
                except (ValueError, KeyError):
                    continue

        # Calculate averages and rank
        ranked = {}
        for type_name, items in effectiveness.items():
            ranked[type_name] = sorted(
                [
                    {
                        'name': name,
                        'avg_effectiveness': sum(ratings) / len(ratings),
                        'count': len(ratings)
                    }
                    for name, ratings in items.items()
                ],
                key=lambda x: x['avg_effectiveness'],
                reverse=True
            )

        self.patterns['effectiveness_patterns'] = ranked
        return ranked

    def generate_insights(self):
        """Generate human-readable insights from patterns"""
        insights = []

        # Agent sequence insights
        if self.patterns['agent_sequences']:
            insights.append("## 🔗 Common Agent Sequences\n")
            for seq in self.patterns['agent_sequences'][:5]:
                insights.append(
                    f"- {' → '.join(seq['sequence'])} "
                    f"(used {seq['count']} times)\n"
                )
            insights.append("\n")

        # Time pattern insights
        if self.patterns['time_patterns']:
            best_hours = sorted(
                self.patterns['time_patterns'].items(),
                key=lambda x: x[1],
                reverse=True
            )[:3]

            insights.append("## ⏰ Most Productive Hours\n")
            for hour, effectiveness in best_hours:
                time_str = f"{hour:02d}:00"
                insights.append(
                    f"- {time_str} - Average effectiveness: "
                    f"{effectiveness:.2f}/5.0\n"
                )
            insights.append("\n")

        # Workflow insights
        if self.patterns['workflow_patterns']:
            insights.append("## 🔄 Common Workflows\n")
            for workflow in self.patterns['workflow_patterns'][:5]:
                insights.append(
                    f"- `{workflow['command']}` → {workflow['agent']} "
                    f"(used {workflow['count']} times)\n"
                )
            insights.append("\n")

        # Effectiveness insights
        if self.patterns['effectiveness_patterns']:
            insights.append("## ⭐ Top Performers\n")

            if self.patterns['effectiveness_patterns'].get('agents'):
                top_agents = self.patterns['effectiveness_patterns']['agents'][:5]
                insights.append("\n**Agents:**\n")
                for agent in top_agents:
                    insights.append(
                        f"- {agent['name']}: {agent['avg_effectiveness']:.2f}/5.0 "
                        f"({agent['count']} uses)\n"
                    )

            if self.patterns['effectiveness_patterns'].get('commands'):
                top_commands = self.patterns['effectiveness_patterns']['commands'][:5]
                insights.append("\n**Commands:**\n")
                for cmd in top_commands:
                    insights.append(
                        f"- {cmd['name']}: {cmd['avg_effectiveness']:.2f}/5.0 "
                        f"({cmd['count']} uses)\n"
                    )

            insights.append("\n")

        # Context insights
        if self.patterns['context_patterns']:
            insights.append("## 🎯 Context-Specific Recommendations\n")
            for context, agents in list(self.patterns['context_patterns'].items())[:3]:
                best_agent = max(agents.items(), key=lambda x: x[1])
                insights.append(
                    f"- **{context}**: Best agent is {best_agent[0]} "
                    f"({best_agent[1]:.2f}/5.0)\n"
                )
            insights.append("\n")

        return ''.join(insights)

    def save_patterns(self):
        """Save patterns to file"""
        PATTERNS_FILE.parent.mkdir(parents=True, exist_ok=True)
        with open(PATTERNS_FILE, 'w') as f:
            json.dump(self.patterns, f, indent=2)

    def save_insights(self, insights):
        """Save insights to markdown file"""
        INSIGHTS_FILE.parent.mkdir(parents=True, exist_ok=True)

        header = f"""# Hermetic Intelligence Insights

**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
**Data Points Analyzed**: {len(self.usage_data)}

> These insights are automatically generated from your usage patterns.

---

"""

        with open(INSIGHTS_FILE, 'w') as f:
            f.write(header + insights)

    def run_full_analysis(self):
        """Run complete pattern analysis"""
        print("🔮 Analyzing usage patterns...")

        self.analyze_agent_sequences()
        print("  ✅ Agent sequences analyzed")

        self.analyze_time_patterns()
        print("  ✅ Time patterns analyzed")

        self.analyze_context_patterns()
        print("  ✅ Context patterns analyzed")

        self.detect_workflow_patterns()
        print("  ✅ Workflow patterns detected")

        self.analyze_effectiveness_patterns()
        print("  ✅ Effectiveness patterns analyzed")

        insights = self.generate_insights()

        self.save_patterns()
        print(f"  ✅ Patterns saved to {PATTERNS_FILE}")

        self.save_insights(insights)
        print(f"  ✅ Insights saved to {INSIGHTS_FILE}")

        print("\n📊 Analysis complete!")
        print(f"\nView insights: cat {INSIGHTS_FILE}")

        return insights


def get_smart_suggestions(context='general'):
    """Get intelligent suggestions based on learned patterns"""
    recognizer = PatternRecognizer()

    suggestions = []

    # Context-based suggestions
    if context in recognizer.patterns.get('context_patterns', {}):
        context_agents = recognizer.patterns['context_patterns'][context]
        best_agent = max(context_agents.items(), key=lambda x: x[1])
        suggestions.append(
            f"💡 For {context}, try {best_agent[0]} "
            f"(avg effectiveness: {best_agent[1]:.2f})"
        )

    # Time-based suggestions
    current_hour = datetime.now().hour
    time_patterns = recognizer.patterns.get('time_patterns', {})
    if str(current_hour) in time_patterns:
        effectiveness = time_patterns[str(current_hour)]
        if effectiveness > 4.0:
            suggestions.append(
                f"⚡ Peak productivity hour! (avg: {effectiveness:.2f}/5.0)"
            )
        elif effectiveness < 3.0:
            suggestions.append(
                f"⚠️  Low productivity hour historically (avg: {effectiveness:.2f}/5.0). "
                "Consider taking a break."
            )

    # Workflow suggestions
    workflows = recognizer.patterns.get('workflow_patterns', [])
    if workflows:
        top_workflow = workflows[0]
        suggestions.append(
            f"🔄 Popular workflow: {top_workflow['command']} → "
            f"{top_workflow['agent']}"
        )

    return suggestions


if __name__ == '__main__':
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == 'suggest':
        context = sys.argv[2] if len(sys.argv) > 2 else 'general'
        suggestions = get_smart_suggestions(context)
        for suggestion in suggestions:
            print(suggestion)
    else:
        recognizer = PatternRecognizer()
        recognizer.run_full_analysis()
