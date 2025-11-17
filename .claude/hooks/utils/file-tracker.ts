/**
 * File Tracker - Track modifications for build checking
 *
 * Principle: Rhythm - Maintain awareness of changes across sessions
 */

import { readFileSync, writeFileSync, existsSync } from 'fs';
import { join } from 'path';
import { homedir } from 'os';

export interface EditLog {
  editedFiles: string[];
  timestamp: string;
  repos: Set<string>;
}

export class FileTracker {
  private static readonly LOG_PATH = join(homedir(), '.claude', 'edit-log.json');

  static addEdit(filePath: string): void {
    const log = this.readLog();

    if (!log.editedFiles.includes(filePath)) {
      log.editedFiles.push(filePath);
    }

    // Extract repo name if in projects directory
    if (filePath.includes('/projects/') || filePath.includes('\\projects\\')) {
      const match = filePath.match(/projects[\\/]([^\\/]+)/);
      if (match) {
        log.repos.add(match[1]);
      }
    }

    log.timestamp = new Date().toISOString();
    this.writeLog(log);
  }

  static readLog(): EditLog {
    if (!existsSync(this.LOG_PATH)) {
      return {
        editedFiles: [],
        timestamp: new Date().toISOString(),
        repos: new Set<string>()
      };
    }

    try {
      const data = JSON.parse(readFileSync(this.LOG_PATH, 'utf-8'));
      return {
        editedFiles: data.editedFiles || [],
        timestamp: data.timestamp || new Date().toISOString(),
        repos: new Set(data.repos || [])
      };
    } catch (error) {
      return {
        editedFiles: [],
        timestamp: new Date().toISOString(),
        repos: new Set<string>()
      };
    }
  }

  static writeLog(log: EditLog): void {
    const data = {
      editedFiles: log.editedFiles,
      timestamp: log.timestamp,
      repos: Array.from(log.repos)
    };

    writeFileSync(this.LOG_PATH, JSON.stringify(data, null, 2));
  }

  static clearLog(): void {
    this.writeLog({
      editedFiles: [],
      timestamp: new Date().toISOString(),
      repos: new Set<string>()
    });
  }

  static getModifiedRepos(): string[] {
    const log = this.readLog();
    return Array.from(log.repos);
  }

  static getEditedFiles(): string[] {
    const log = this.readLog();
    return log.editedFiles;
  }
}
