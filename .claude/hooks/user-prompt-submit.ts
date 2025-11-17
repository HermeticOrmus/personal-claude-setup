/**
 * UserPromptSubmit Hook - Skill Auto-Activation
 *
 * Runs BEFORE Claude sees your prompt
 * Purpose: Auto-activate relevant skills based on context
 *
 * Hermetic Principle: Mentalism
 * "The All is Mind - Load wisdom before action begins"
 */

import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import { homedir } from 'os';
import { HermeticLogger } from './utils/hermetic-logger.js';

interface SkillRule {
  type: string;
  enforcement: 'suggest' | 'require' | 'block';
  priority: 'high' | 'medium' | 'low';
  hermetic_principle?: string;
  learning_master?: string;
  promptTriggers?: {
    keywords?: string[];
    intentPatterns?: string[];
  };
  fileTriggers?: {
    pathPatterns?: string[];
    contentPatterns?: string[];
  };
}

interface SkillRulesConfig {
  skills: {
    [skillName: string]: SkillRule;
  };
}

interface ExecuteArgs {
  userPrompt: string;
  claudeCodePath: string;
}

export async function execute({ userPrompt, claudeCodePath }: ExecuteArgs): Promise<string> {
  try {
    // Load skill rules configuration
    const skillRulesPath = join(homedir(), '.claude', 'skill-rules.json');

    if (!existsSync(skillRulesPath)) {
      return ''; // No rules configured, skip silently
    }

    const config: SkillRulesConfig = JSON.parse(readFileSync(skillRulesPath, 'utf-8'));
    const { skills } = config;

    const activatedSkills: Array<{ name: string; priority: string; principle?: string }> = [];
    const promptLower = userPrompt.toLowerCase();

    // Check each skill's trigger conditions
    for (const [skillName, rule] of Object.entries(skills)) {
      if (!rule.promptTriggers) continue;

      let matched = false;

      // Check keywords
      if (rule.promptTriggers.keywords) {
        matched = rule.promptTriggers.keywords.some((keyword) =>
          promptLower.includes(keyword.toLowerCase())
        );
      }

      // Check intent patterns (regex)
      if (!matched && rule.promptTriggers.intentPatterns) {
        matched = rule.promptTriggers.intentPatterns.some((pattern) => {
          try {
            const regex = new RegExp(pattern, 'i');
            return regex.test(userPrompt);
          } catch (error) {
            // Invalid regex, skip
            return false;
          }
        });
      }

      if (matched) {
        activatedSkills.push({
          name: skillName,
          priority: rule.priority,
          principle: rule.hermetic_principle || rule.learning_master
        });
      }
    }

    // No skills matched, return empty
    if (activatedSkills.length === 0) {
      return '';
    }

    // Sort by priority (high > medium > low)
    activatedSkills.sort((a, b) => {
      const priorityOrder = { high: 3, medium: 2, low: 1 };
      return priorityOrder[b.priority as keyof typeof priorityOrder] -
             priorityOrder[a.priority as keyof typeof priorityOrder];
    });

    // Format activation message using Hermetic Logger
    return HermeticLogger.skillActivation(
      activatedSkills.map((s) => ({ name: s.name, priority: s.priority }))
    );

  } catch (error) {
    // Fail silently - don't break Claude's workflow
    console.error('[Hermetic Hook Error]', error);
    return '';
  }
}
