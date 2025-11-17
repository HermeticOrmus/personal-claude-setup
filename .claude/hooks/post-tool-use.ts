/**
 * PostToolUse Hook - File Edit Tracker
 *
 * Runs AFTER every Edit/Write/MultiEdit operation
 * Purpose: Track file modifications for build checking
 *
 * Hermetic Principle: Cause-Effect
 * "Track all changes to verify their consequences"
 */

import { FileTracker } from './utils/file-tracker.js';

interface ExecuteArgs {
  toolName: string;
  toolInput: {
    file_path?: string;
    path?: string;
    paths?: string[];
    files?: Array<{ path: string }>;
  };
  toolOutput: string;
}

export async function execute({ toolName, toolInput }: ExecuteArgs): Promise<string> {
  try {
    // Only track file modification operations
    const fileModificationTools = ['Edit', 'Write', 'MultiEdit', 'NotebookEdit'];

    if (!fileModificationTools.includes(toolName)) {
      return ''; // Not a file modification, skip
    }

    // Extract file path(s) from different tool types
    let filePaths: string[] = [];

    if (toolInput.file_path) {
      filePaths.push(toolInput.file_path);
    }

    if (toolInput.path) {
      filePaths.push(toolInput.path);
    }

    if (toolInput.paths) {
      filePaths.push(...toolInput.paths);
    }

    if (toolInput.files) {
      filePaths.push(...toolInput.files.map((f) => f.path));
    }

    // Track each modified file
    filePaths.forEach((path) => {
      FileTracker.addEdit(path);
    });

    // Silent operation - no output needed
    return '';

  } catch (error) {
    // Fail silently - don't break workflow
    console.error('[Hermetic Hook Error]', error);
    return '';
  }
}
