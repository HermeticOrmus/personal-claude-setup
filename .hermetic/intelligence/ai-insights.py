#!/usr/bin/env python3
"""
Hermetic AI-Powered Insights
Uses pattern recognition and heuristics to generate intelligent recommendations
"""

import json
import csv
from datetime import datetime, timedelta
from pathlib import Path
from collections import defaultdict, Counter
import os

HERMETIC_HOME = Path(os.environ.get('HERMETIC_HOME', Path.home() / '.hermetic'))
USAGE_LOG = HERMETIC_HOME / 'analytics' / 'usage.csv'
HEALTH_LOG = HERMETIC_HOME / 'health' / 'health-history.csv'
PATTERNS_FILE = HERMETIC_HOME / 'intelligence' / 'patterns.json'
INSIGHTS_OUTPUT = HERMETIC_HOME / 'intelligence' / 'ai-insights.md'


class AIInsightEngine:
    def __init__(self):
        self.usage_data = self.load_usage_data()
        self.health_data = self.load_health_data()
        self.patterns = self.load_patterns()
        self.insights = []

    def load_usage_data(self):
        if not USAGE_LOG.exists():
            return []

        data = []
        with open(USAGE_LOG) as f:
            reader = csv.DictReader(f)
            for row in reader:
                data.append(row)
        return data

    def load_health_data(self):
        if not HEALTH_LOG.exists():
            return []

        data = []
        with open(HEALTH_LOG) as f:
            reader = csv.DictReader(f)
            for row in reader:
                data.append(row)
        return data

    def load_patterns(self):
        if not PATTERNS_FILE.exists():
            return {}

        with open(PATTERNS_FILE) as f:
            return json.load(f)

    def detect_underutilized_agents(self):
        """Find agents that haven't been used but might be valuable"""
        # Get all available agents (103 total)
        used_agents = set(
            entry['name'] for entry in self.usage_data
            if entry['type'] == 'agent'
        )

        # Known valuable agents that should be tried
        recommended_agents = {
            'themis-legal': 'legal questions and contract review',
            'plutus-finance': 'financial planning and budgeting',
            'hygieia-wellness': 'health and wellness guidance',
            'sabbath-guide': 'weekly integration and rest',
            'debug-like-master': 'systematic debugging',
            'design-perfect-architecture': 'system architecture',
            'sacred-mirror-auditor': 'test suite quality',
            'hermetic-compass-advisor': 'decision guidance'
        }

        unused_valuable = []
        for agent, purpose in recommended_agents.items():
            if agent not in used_agents:
                unused_valuable.append((agent, purpose))

        if unused_valuable:
            insight = {
                'type': 'underutilized_resources',
                'priority': 'medium',
                'title': 'Valuable Agents You Haven\'t Tried',
                'description': 'These agents could significantly enhance your work:',
                'recommendations': [
                    f"**{agent}**: Try for {purpose}"
                    for agent, purpose in unused_valuable
                ]
            }
            self.insights.append(insight)

    def detect_burnout_patterns(self):
        """Identify potential burnout from usage patterns"""
        # Check for consecutive days without rest
        if not self.usage_data:
            return

        dates = sorted(set(
            entry['timestamp'][:10] for entry in self.usage_data
        ))

        consecutive_days = 1
        max_consecutive = 1

        for i in range(1, len(dates)):
            prev_date = datetime.strptime(dates[i-1], '%Y-%m-%d')
            curr_date = datetime.strptime(dates[i], '%Y-%m-%d')

            if (curr_date - prev_date).days == 1:
                consecutive_days += 1
                max_consecutive = max(max_consecutive, consecutive_days)
            else:
                consecutive_days = 1

        if max_consecutive >= 7:
            insight = {
                'type': 'burnout_risk',
                'priority': 'high',
                'title': 'Rhythm Violation Detected',
                'description': f'You\'ve worked {max_consecutive} consecutive days without Sabbath rest.',
                'recommendations': [
                    '**Schedule immediate Sabbath**: Use sabbath-guide agent',
                    '**Review /rhythm principle**: Sustainable pace prevents burnout',
                    '**Set calendar reminder**: Block every 7th day for integration'
                ]
            }
            self.insights.append(insight)

    def detect_workflow_inefficiencies(self):
        """Find inefficient workflow patterns"""
        # Look for repeated failed attempts (low effectiveness)
        low_effectiveness = [
            entry for entry in self.usage_data
            if entry.get('effectiveness') and float(entry['effectiveness']) < 3.0
        ]

        if len(low_effectiveness) > 5:
            # Group by type
            low_by_type = defaultdict(list)
            for entry in low_effectiveness:
                low_by_type[entry['type']].append(entry['name'])

            recommendations = []
            for type_name, names in low_by_type.items():
                most_common = Counter(names).most_common(1)[0]
                recommendations.append(
                    f"**{most_common[0]}** ({type_name}): Rated low {most_common[1]} times - "
                    f"Consider alternative approach or request optimization"
                )

            if recommendations:
                insight = {
                    'type': 'workflow_inefficiency',
                    'priority': 'medium',
                    'title': 'Low Effectiveness Patterns Detected',
                    'description': 'These tools consistently receive low ratings:',
                    'recommendations': recommendations
                }
                self.insights.append(insight)

    def detect_learning_opportunities(self):
        """Identify skills not being applied"""
        # Check which skills have been used
        used_skills = set(
            entry['name'] for entry in self.usage_data
            if entry['type'] == 'skill'
        )

        # All 12 skills
        all_skills = [
            ('apply-mentalism', 'mental model clarity'),
            ('apply-correspondence', 'pattern alignment'),
            ('apply-vibration', 'momentum creation'),
            ('apply-polarity', 'balancing opposites'),
            ('apply-rhythm', 'sustainable cycles'),
            ('apply-cause-effect', 'understanding consequences'),
            ('apply-gender', 'balancing doing/being'),
            ('design-perfect-architecture', 'elegant system design'),
            ('ship-sustainably', 'fast without burnout'),
            ('master-complex-decisions', 'wise high-stakes choices'),
            ('debug-like-master', 'systematic debugging'),
            ('learn-any-skill-fast', 'rapid skill acquisition')
        ]

        unused_skills = [
            (skill, purpose) for skill, purpose in all_skills
            if skill not in used_skills
        ]

        if len(unused_skills) >= 9:  # Most skills unused
            insight = {
                'type': 'learning_opportunity',
                'priority': 'high',
                'title': 'Hermetic Skills Underutilized',
                'description': 'You have powerful skills available that you haven\'t applied yet:',
                'recommendations': [
                    f"**{skill}**: Apply for {purpose}"
                    for skill, purpose in unused_skills[:5]  # Top 5
                ]
            }
            self.insights.append(insight)

    def detect_time_optimization(self):
        """Suggest optimal working times based on effectiveness"""
        if not self.patterns.get('time_patterns'):
            return

        time_patterns = self.patterns['time_patterns']

        # Find best and worst hours
        if len(time_patterns) < 3:
            return

        sorted_hours = sorted(
            [(int(hour), eff) for hour, eff in time_patterns.items()],
            key=lambda x: x[1],
            reverse=True
        )

        best_hours = sorted_hours[:3]
        worst_hours = sorted_hours[-3:]

        recommendations = []
        recommendations.append(
            f"**Peak hours**: {', '.join(f'{h:02d}:00' for h, _ in best_hours)} "
            f"(avg effectiveness: {sum(e for _, e in best_hours) / 3:.2f})"
        )
        recommendations.append(
            '**Schedule deep work during peak hours**'
        )
        recommendations.append(
            f"**Low energy hours**: {', '.join(f'{h:02d}:00' for h, _ in worst_hours)} - "
            f"Consider breaks or shallow work"
        )

        insight = {
            'type': 'time_optimization',
            'priority': 'medium',
            'title': 'Optimize Your Schedule',
            'description': 'Your effectiveness varies significantly by time of day:',
            'recommendations': recommendations
        }
        self.insights.append(insight)

    def detect_missing_integrations(self):
        """Suggest useful integrations not yet set up"""
        # Check if git hooks are set up
        git_hooks_exist = (Path.home() / '.hermetic' / 'automation' / 'git-hooks-installed').exists()

        # Check if daily reminders exist
        # Check if editor integration exists

        recommendations = []

        if not git_hooks_exist:
            recommendations.append(
                '**Git integration**: Add pre-push hooks for automatic /align checks'
            )

        recommendations.append(
            '**Calendar integration**: Set daily reminders for hm start-day and hm close-day'
        )
        recommendations.append(
            '**Editor shortcuts**: Add keyboard shortcuts for quick command invocation'
        )

        if recommendations:
            insight = {
                'type': 'missing_integration',
                'priority': 'low',
                'title': 'Enhance Automation',
                'description': 'These integrations could streamline your workflow:',
                'recommendations': recommendations
            }
            self.insights.append(insight)

    def detect_health_trends(self):
        """Analyze health score trends"""
        if len(self.health_data) < 7:
            return

        recent_health = [
            float(entry['health_score'])
            for entry in self.health_data[-7:]
        ]

        avg_health = sum(recent_health) / len(recent_health)
        trend = 'stable'

        # Simple trend detection
        if recent_health[-1] > recent_health[0] + 10:
            trend = 'improving'
        elif recent_health[-1] < recent_health[0] - 10:
            trend = 'declining'

        if trend == 'declining':
            insight = {
                'type': 'health_decline',
                'priority': 'high',
                'title': 'Health Score Declining',
                'description': f'Your health score has dropped from {recent_health[0]:.0f} to {recent_health[-1]:.0f} over the past week.',
                'recommendations': [
                    '**Review usage patterns**: Run `hm health` for details',
                    '**Check effectiveness**: Are you rating your usage?',
                    '**Ensure Sabbath**: Weekly rest is essential',
                    '**Simplify workflows**: Focus on what works best'
                ]
            }
            self.insights.append(insight)
        elif trend == 'improving':
            insight = {
                'type': 'health_improving',
                'priority': 'low',
                'title': 'Health Score Improving',
                'description': f'Excellent progress! Health score increased from {recent_health[0]:.0f} to {recent_health[-1]:.0f}.',
                'recommendations': [
                    '**Document what works**: Capture successful patterns',
                    '**Share learnings**: Help others with your insights',
                    '**Continue momentum**: Maintain current practices'
                ]
            }
            self.insights.append(insight)

    def generate_personalized_recommendations(self):
        """Generate recommendations based on complete profile"""
        total_uses = len(self.usage_data)

        if total_uses < 10:
            insight = {
                'type': 'getting_started',
                'priority': 'high',
                'title': 'Build Consistent Usage',
                'description': 'You\'re just getting started with the Hermetic system.',
                'recommendations': [
                    '**Start simple**: Use /gnosis, /align, /verify daily',
                    '**Pick 3 core agents**: Neptune, Hera, and one advisor',
                    '**Apply 1 skill**: Choose debug-like-master or ship-sustainably',
                    '**Daily ritual**: Run hm start-day every morning',
                    '**Track effectiveness**: Rate everything to build intelligence'
                ]
            }
            self.insights.append(insight)
        elif total_uses > 100:
            insight = {
                'type': 'advanced_user',
                'priority': 'low',
                'title': 'You\'re a Power User',
                'description': f'With {total_uses} invocations, you\'re deeply integrated!',
                'recommendations': [
                    '**Create custom agents**: Address your specific needs',
                    '**Share your workflows**: Help the community',
                    '**Optimize patterns**: Review intelligence insights',
                    '**Teach others**: Onboard teammates to the system'
                ]
            }
            self.insights.append(insight)

    def run_all_analysis(self):
        """Run all insight detection"""
        print("🤖 Running AI insight analysis...")

        self.detect_underutilized_agents()
        self.detect_burnout_patterns()
        self.detect_workflow_inefficiencies()
        self.detect_learning_opportunities()
        self.detect_time_optimization()
        self.detect_missing_integrations()
        self.detect_health_trends()
        self.generate_personalized_recommendations()

        return self.insights

    def format_insights(self):
        """Format insights as markdown"""
        if not self.insights:
            return "# No insights available yet\n\nUse the system more to generate insights!"

        # Sort by priority
        priority_order = {'high': 0, 'medium': 1, 'low': 2}
        sorted_insights = sorted(
            self.insights,
            key=lambda x: priority_order.get(x['priority'], 3)
        )

        output = [f"""# 🤖 AI-Powered Hermetic Insights

**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
**Total Insights**: {len(self.insights)}

> These insights are automatically generated from your usage patterns and health data.

---

"""]

        for insight in sorted_insights:
            priority_emoji = {
                'high': '🔴',
                'medium': '🟡',
                'low': '🟢'
            }.get(insight['priority'], '⚪')

            output.append(f"## {priority_emoji} {insight['title']}\n\n")
            output.append(f"**Priority**: {insight['priority'].title()}\n\n")
            output.append(f"{insight['description']}\n\n")

            if insight.get('recommendations'):
                output.append("**Recommendations**:\n\n")
                for rec in insight['recommendations']:
                    output.append(f"- {rec}\n")
                output.append("\n")

            output.append("---\n\n")

        return ''.join(output)

    def save_insights(self):
        """Save insights to file"""
        insights_md = self.format_insights()

        INSIGHTS_OUTPUT.parent.mkdir(parents=True, exist_ok=True)
        with open(INSIGHTS_OUTPUT, 'w') as f:
            f.write(insights_md)

        print(f"✅ Insights saved to: {INSIGHTS_OUTPUT}")

        # Print summary
        if self.insights:
            high_priority = sum(1 for i in self.insights if i['priority'] == 'high')
            if high_priority > 0:
                print(f"\n🔴 {high_priority} high-priority insights require attention!")
            print(f"\nView full report: cat {INSIGHTS_OUTPUT}")


if __name__ == '__main__':
    engine = AIInsightEngine()
    engine.run_all_analysis()
    engine.save_insights()
