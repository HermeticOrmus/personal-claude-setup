/**
 * StopEvent Hook - Build Checker + Error Handling Reminder
 *
 * Runs when Claude FINISHES responding
 * Purpose: Check builds on modified repos + remind about error handling
 *
 * Hermetic Principles: Vibration + Cause-Effect
 * "Quality checks maintain momentum. Verify consequences immediately."
 */

import { execSync } from 'child_process';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import { homedir } from 'os';
import { FileTracker } from './utils/file-tracker.js';
import { HermeticLogger } from './utils/hermetic-logger.js';

interface ExecuteArgs {
  claudeCodePath: string;
}

interface BuildError {
  repo: string;
  output: string;
}

export async function execute({ claudeCodePath }: ExecuteArgs): Promise<string> {
  try {
    const editedFiles = FileTracker.getEditedFiles();

    if (editedFiles.length === 0) {
      return ''; // No files edited, skip
    }

    let output = '';

    // ═══════════════════════════════════════════════════════
    // PART 1: BUILD CHECKING
    // ═══════════════════════════════════════════════════════

    const modifiedRepos = FileTracker.getModifiedRepos();
    const errors: BuildError[] = [];

    for (const repo of modifiedRepos) {
      try {
        const repoPath = join(homedir(), 'projects', repo);

        // Check if package.json exists (Node project)
        const packageJsonPath = join(repoPath, 'package.json');
        if (!existsSync(packageJsonPath)) {
          continue; // Not a Node project, skip
        }

        // Read package.json to find build script
        const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));

        if (!packageJson.scripts || !packageJson.scripts.build) {
          continue; // No build script, skip
        }

        // Determine package manager
        const hasPnpm = existsSync(join(repoPath, 'pnpm-lock.yaml'));
        const hasYarn = existsSync(join(repoPath, 'yarn.lock'));
        const packageManager = hasPnpm ? 'pnpm' : hasYarn ? 'yarn' : 'npm';

        const buildCmd = `${packageManager} run build`;

        // Run build (timeout after 2 minutes)
        execSync(buildCmd, {
          cwd: repoPath,
          stdio: 'pipe',
          timeout: 120000
        });

      } catch (error: any) {
        // Build failed - capture error output
        const errorOutput = error.stdout?.toString() || error.stderr?.toString() || '';

        // Only report if it's a TypeScript error (not just warnings)
        if (errorOutput.includes('error TS') || errorOutput.includes('Build failed')) {
          errors.push({
            repo,
            output: errorOutput
          });
        }
      }
    }

    // Display build errors if any
    if (errors.length > 0) {
      output += HermeticLogger.buildErrors(errors);
    }

    // ═══════════════════════════════════════════════════════
    // PART 2: ERROR HANDLING SELF-CHECK
    // ═══════════════════════════════════════════════════════

    const riskyPatterns = {
      backend: false,
      async: false,
      database: false
    };

    // Check edited files for risky patterns
    for (const filePath of editedFiles) {
      if (!existsSync(filePath)) continue;

      try {
        const content = readFileSync(filePath, 'utf-8');

        // Backend patterns
        if (
          content.includes('controller') ||
          content.includes('router.') ||
          content.includes('app.get') ||
          content.includes('app.post') ||
          content.includes('BaseController')
        ) {
          riskyPatterns.backend = true;
        }

        // Async patterns
        if (
          content.includes('async ') ||
          content.includes('await ') ||
          content.includes('Promise') ||
          content.includes('.then(') ||
          content.includes('.catch(')
        ) {
          riskyPatterns.async = true;
        }

        // Database patterns
        if (
          content.includes('prisma') ||
          content.includes('db.') ||
          content.includes('database') ||
          content.includes('query') ||
          content.includes('transaction')
        ) {
          riskyPatterns.database = true;
        }
      } catch (error) {
        // Can't read file, skip
        continue;
      }
    }

    // Display self-check reminder if risky patterns found
    if (riskyPatterns.backend || riskyPatterns.async || riskyPatterns.database) {
      output += HermeticLogger.selfCheck(riskyPatterns);
    }

    // ═══════════════════════════════════════════════════════
    // CLEANUP
    // ═══════════════════════════════════════════════════════

    // Clear edit log for next session
    FileTracker.clearLog();

    return output;

  } catch (error) {
    // Fail silently - don't break workflow
    console.error('[Hermetic Hook Error]', error);
    return '';
  }
}
