/**
 * Hermetic Logger - Sacred output formatting
 *
 * Principle: Correspondence - Visual structure mirrors conceptual hierarchy
 */

export class HermeticLogger {
  private static readonly HEADER = '\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n';
  private static readonly FOOTER = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n';

  static section(title: string, content: string): string {
    return `${this.HEADER}${title}\n${this.HEADER}\n${content}\n${this.FOOTER}`;
  }

  static skillActivation(skills: Array<{name: string, priority: string}>): string {
    if (skills.length === 0) return '';

    let message = `${this.HEADER}🎯 HERMETIC SKILL ACTIVATION\n${this.HEADER}\n`;
    message += `Detected relevant skills for this task:\n\n`;

    skills.forEach(skill => {
      const emoji = skill.priority === 'high' ? '⚡' :
                    skill.priority === 'medium' ? '📖' : '💡';
      message += `  ${emoji} ${skill.name} [${skill.priority.toUpperCase()} PRIORITY]\n`;
    });

    message += `\n💎 Gold Hat Wisdom: These skills guide conscious creation.\n`;
    message += this.FOOTER;

    return message;
  }

  static buildErrors(errors: Array<{repo: string, output: string}>): string {
    if (errors.length === 0) return '';

    let message = `${this.HEADER}⚠️  BUILD ERRORS DETECTED\n${this.HEADER}\n`;
    message += `Found ${errors.length} error(s) in modified repos:\n\n`;

    errors.forEach(err => {
      message += `📦 ${err.repo}:\n`;
      message += err.output.split('\n').slice(0, 10).join('\n');
      message += '\n\n';
    });

    message += `❗ Principle of Cause-Effect: Fix consequences before proceeding.\n`;
    message += this.FOOTER;

    return message;
  }

  static selfCheck(checks: {backend?: boolean, async?: boolean, database?: boolean}): string {
    if (!checks.backend && !checks.async && !checks.database) return '';

    let message = `${this.HEADER}📋 HERMETIC SELF-CHECK\n${this.HEADER}\n`;
    message += `⚠️  Sacred patterns detected - verify your work:\n\n`;

    if (checks.backend) {
      message += `   🔱 Backend Code:\n`;
      message += `      ❓ Did you add proper error handling?\n`;
      message += `      ❓ Are errors captured to monitoring?\n`;
      message += `      ❓ Does this serve user flourishing?\n\n`;
    }

    if (checks.async) {
      message += `   ⚡ Async Operations:\n`;
      message += `      ❓ Are promises wrapped in try-catch?\n`;
      message += `      ❓ Are race conditions considered?\n`;
      message += `      ❓ Is error propagation clear?\n\n`;
    }

    if (checks.database) {
      message += `   💎 Database Operations:\n`;
      message += `      ❓ Are queries optimized?\n`;
      message += `      ❓ Are transactions used where needed?\n`;
      message += `      ❓ Is data integrity protected?\n\n`;
    }

    message += `💡 Gold Hat Principle: Every technical decision has consequences.\n`;
    message += `   Honor the Law of Cause-Effect through conscious verification.\n`;
    message += this.FOOTER;

    return message;
  }
}
