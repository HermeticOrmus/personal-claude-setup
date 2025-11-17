#!/usr/bin/env node

/**
 * Claude Code Telegram Bridge
 *
 * WHY: Enables remote control of Claude Code via Telegram messages
 * Following Hermetic Principle of Correspondence - connecting phone → cloud → local
 *
 * This webhook listener receives commands from n8n and executes Claude Code
 */

const http = require('http');
const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Configuration
const PORT = 3737; // Sacred number sequence
const LOG_FILE = path.join(__dirname, 'claude-bridge.log');
const ALLOWED_TOKEN = process.env.BRIDGE_TOKEN || 'hermetic-bridge-token-change-this';

// WHY: Logging helps debug and track command execution
function log(message) {
  const timestamp = new Date().toISOString();
  const logMessage = `[${timestamp}] ${message}\n`;
  console.log(logMessage.trim());
  fs.appendFileSync(LOG_FILE, logMessage);
}

// WHY: Execute Claude Code with the prompt from Telegram
function executeClaudeCode(prompt, callback) {
  log(`Executing Claude Code with prompt: "${prompt}"`);

  // WHY: Wrap prompt with instructions for direct, concise answers
  // This prevents Claude from giving interactive greetings
  const enhancedPrompt = `${prompt}\n\nProvide a direct, concise answer. This is a one-shot command from Telegram, not an interactive session.`;

  // Use non-interactive mode for remote execution
  const claudeProcess = spawn('claude', ['-p', enhancedPrompt], {
    shell: true,
    stdio: 'pipe'
  });

  // WHY: Close stdin immediately so Claude doesn't wait for input
  if (claudeProcess.stdin) {
    claudeProcess.stdin.end();
  }

  let output = '';
  let errorOutput = '';

  claudeProcess.stdout.on('data', (data) => {
    output += data.toString();
  });

  claudeProcess.stderr.on('data', (data) => {
    errorOutput += data.toString();
  });

  claudeProcess.on('close', (code) => {
    if (code === 0) {
      log(`Claude Code execution successful`);
      callback(null, output);
    } else {
      log(`Claude Code execution failed with code ${code}: ${errorOutput}`);
      callback(new Error(`Execution failed: ${errorOutput}`), null);
    }
  });

  // Timeout after 5 minutes
  setTimeout(() => {
    claudeProcess.kill();
    callback(new Error('Execution timeout after 5 minutes'), null);
  }, 5 * 60 * 1000);
}

// WHY: HTTP server receives webhook calls from n8n
const server = http.createServer((req, res) => {
  // WHY: Health check endpoint for monitoring
  if (req.method === 'GET' && req.url === '/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      status: 'healthy',
      service: 'Claude Code Telegram Bridge',
      uptime: process.uptime()
    }));
    return;
  }

  // Only accept POST requests to /execute
  if (req.method !== 'POST' || req.url !== '/execute') {
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Not found' }));
    return;
  }

  let body = '';

  req.on('data', chunk => {
    body += chunk.toString();
  });

  req.on('end', () => {
    try {
      const data = JSON.parse(body);

      // WHY: Security check - verify token to prevent unauthorized access
      if (data.token !== ALLOWED_TOKEN) {
        log(`Unauthorized access attempt with token: ${data.token}`);
        res.writeHead(401, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Unauthorized' }));
        return;
      }

      const prompt = data.prompt;

      if (!prompt) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Missing prompt' }));
        return;
      }

      log(`Received command from Telegram: "${prompt}"`);

      // Respond immediately to n8n
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({
        status: 'received',
        message: 'Claude Code execution started',
        prompt: prompt
      }));

      // Execute Claude Code asynchronously
      executeClaudeCode(prompt, (error, output) => {
        if (error) {
          log(`Error: ${error.message}`);
        } else {
          log(`Output: ${output.substring(0, 200)}...`); // Log first 200 chars
        }
      });

    } catch (error) {
      log(`Error parsing request: ${error.message}`);
      res.writeHead(400, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Invalid JSON' }));
    }
  });
});

server.listen(PORT, '0.0.0.0', () => {
  log(`🔱 Claude Code Telegram Bridge started on port ${PORT}`);
  log(`📡 Listening for commands from n8n`);
  log(`🔐 Security token required: ${ALLOWED_TOKEN.substring(0, 10)}...`);
  log(`💡 Health check: http://localhost:${PORT}/health`);
  console.log('\n✨ Ready to receive Telegram commands!\n');
});

// WHY: Graceful shutdown preserves logs and cleans up
process.on('SIGINT', () => {
  log('🛑 Bridge shutting down gracefully...');
  server.close(() => {
    log('✅ Server closed');
    process.exit(0);
  });
});
