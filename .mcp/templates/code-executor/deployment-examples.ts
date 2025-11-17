/**
 * Deployment Examples Using code-executor-mcp
 * Progressive Disclosure Pattern for Sacred Technology Deployment
 *
 * These examples show how to use code-executor-mcp to orchestrate
 * deployments across multiple platforms while maintaining minimal context usage.
 */

// ========================================
// Example 1: Simple Supabase Migration
// ========================================

const simpleSupabaseMigration = await executeTypescript(`
  // Apply database migration to Supabase
  const migration = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_users_table',
    query: \`
      CREATE TABLE users (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        email TEXT UNIQUE NOT NULL,
        name TEXT,
        created_at TIMESTAMPTZ DEFAULT NOW()
      );

      -- Enable RLS
      ALTER TABLE users ENABLE ROW LEVEL SECURITY;

      -- Create policy
      CREATE POLICY "Users can read own data"
        ON users FOR SELECT
        USING (auth.uid() = id);
    \`
  });

  return {
    success: migration.success,
    message: migration.error || 'Migration applied successfully'
  };
`);

// ========================================
// Example 2: Deploy Edge Function
// ========================================

const deployEdgeFunction = await executeTypescript(`
  // Deploy serverless function to Supabase

  const functionCode = \`
    import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

    serve(async (req) => {
      const { name } = await req.json();

      return new Response(
        JSON.stringify({
          message: \\\`Hello, \\\${name}!\\\`,
          timestamp: new Date().toISOString()
        }),
        {
          headers: { "Content-Type": "application/json" }
        }
      );
    });
  \`;

  const deployment = await callMCPTool('mcp__supabase__deploy_edge_function', {
    name: 'hello-function',
    files: [{
      name: 'index.ts',
      content: functionCode
    }],
    entrypoint_path: 'index.ts'
  });

  return {
    deployed: deployment.success,
    function_url: \`https://your-project.functions.supabase.co/hello-function\`
  };
`);

// ========================================
// Example 3: Full-Stack Deployment (Sequential)
// ========================================

const fullStackDeployment = await executeTypescript(`
  /**
   * Complete full-stack deployment:
   * 1. Database migrations (Supabase)
   * 2. Edge Functions (Supabase)
   * 3. Frontend deployment (via GitHub PR)
   */

  // PHASE 1: Database
  const migration = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_posts_table',
    query: \`
      CREATE TABLE posts (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id UUID REFERENCES users(id),
        title TEXT NOT NULL,
        content TEXT,
        published BOOLEAN DEFAULT false,
        created_at TIMESTAMPTZ DEFAULT NOW(),
        updated_at TIMESTAMPTZ DEFAULT NOW()
      );

      ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

      CREATE POLICY "Users can CRUD own posts"
        ON posts FOR ALL
        USING (auth.uid() = user_id);
    \`
  });

  if (!migration.success) {
    throw new Error(\`Migration failed: \${migration.error}\`);
  }

  // PHASE 2: Edge Function
  const edgeFunction = await callMCPTool('mcp__supabase__deploy_edge_function', {
    name: 'posts-api',
    files: [{
      name: 'index.ts',
      content: \`
        import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
        import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

        serve(async (req) => {
          const supabase = createClient(
            Deno.env.get('SUPABASE_URL')!,
            Deno.env.get('SUPABASE_ANON_KEY')!
          );

          const { data, error } = await supabase
            .from('posts')
            .select('*')
            .eq('published', true);

          if (error) {
            return new Response(JSON.stringify({ error: error.message }), {
              status: 500,
              headers: { 'Content-Type': 'application/json' }
            });
          }

          return new Response(JSON.stringify({ posts: data }), {
            headers: { 'Content-Type': 'application/json' }
          });
        });
      \`
    }]
  });

  if (!edgeFunction.success) {
    throw new Error(\`Edge function deployment failed: \${edgeFunction.error}\`);
  }

  // PHASE 3: Create GitHub PR for frontend deployment
  const pr = await callMCPTool('mcp__github__create_pull_request', {
    owner: 'ormus',
    repo: 'my-project',
    title: 'Deploy posts feature to production',
    body: \`
## Deployment Summary

### Backend (Supabase)
✅ Database migration applied
✅ Edge Function deployed

### Changes
- Added \\\`posts\\\` table with RLS policies
- Deployed \\\`posts-api\\\` Edge Function
- API endpoint: https://your-project.functions.supabase.co/posts-api

### Testing
- [ ] Test Edge Function
- [ ] Verify RLS policies
- [ ] Frontend integration

### Deployment Checklist
- [x] Database migration
- [x] Edge Function
- [ ] Frontend build
- [ ] Production deploy

🤖 Generated with Claude Code deployment system
    \`,
    head: 'feature/posts',
    base: 'main'
  });

  return {
    migration: {
      success: migration.success,
      table: 'posts'
    },
    edgeFunction: {
      success: edgeFunction.success,
      name: 'posts-api',
      url: 'https://your-project.functions.supabase.co/posts-api'
    },
    pr: {
      url: pr.html_url,
      number: pr.number
    }
  };
`);

// ========================================
// Example 4: Concurrent Deployments
// ========================================

const concurrentDeployments = await executeTypescript(`
  /**
   * Deploy multiple components concurrently
   * (when they don't depend on each other)
   */

  const [migration1, migration2, edgeFunction] = await Promise.all([
    // Migration 1: Users table
    callMCPTool('mcp__supabase__apply_migration', {
      name: 'add_users_table',
      query: 'CREATE TABLE users (...)'
    }),

    // Migration 2: Posts table (independent)
    callMCPTool('mcp__supabase__apply_migration', {
      name: 'add_posts_table',
      query: 'CREATE TABLE posts (...)'
    }),

    // Edge Function (independent of migrations)
    callMCPTool('mcp__supabase__deploy_edge_function', {
      name: 'analytics',
      files: [{
        name: 'index.ts',
        content: 'Deno.serve(() => new Response("Analytics"));'
      }]
    })
  ]);

  return {
    migrations: {
      users: migration1.success,
      posts: migration2.success
    },
    edgeFunction: {
      analytics: edgeFunction.success
    }
  };
`);

// ========================================
// Example 5: Complete Deployment with Validation
// ========================================

const completeDeploymentWithValidation = await executeTypescript(`
  /**
   * Complete deployment workflow with validation:
   * 1. Database migrations
   * 2. Edge Functions
   * 3. Security checks (advisors)
   * 4. Frontend deployment
   * 5. End-to-end testing
   */

  // PHASE 1: Backend deployment
  const backend = await Promise.all([
    callMCPTool('mcp__supabase__apply_migration', {
      name: 'add_schema',
      query: 'CREATE TABLE ...'
    }),
    callMCPTool('mcp__supabase__deploy_edge_function', {
      name: 'api',
      files: [{ name: 'index.ts', content: '...' }]
    })
  ]);

  // PHASE 2: Security validation
  const securityCheck = await callMCPTool('mcp__supabase__get_advisors', {
    type: 'security'
  });

  if (securityCheck.warnings && securityCheck.warnings.length > 0) {
    console.warn('Security warnings detected:', securityCheck.warnings);
    // Decide: Continue or abort based on severity
  }

  // PHASE 3: Frontend deployment via GitHub
  const pr = await callMCPTool('mcp__github__create_pull_request', {
    owner: 'ormus',
    repo: 'frontend',
    title: 'Deploy to production',
    body: \`
Backend Status:
- Migration: \${backend[0].success ? '✅' : '❌'}
- Edge Function: \${backend[1].success ? '✅' : '❌'}
- Security Warnings: \${securityCheck.warnings?.length || 0}
    \`,
    head: 'deploy',
    base: 'main'
  });

  // PHASE 4: End-to-end testing (Puppeteer)
  const test = await callMCPTool('mcp__puppeteer__navigate', {
    url: 'https://staging.yourapp.com'
  });

  await callMCPTool('mcp__puppeteer__screenshot', {
    name: 'deployment-validation',
    width: 1920,
    height: 1080
  });

  return {
    backend: {
      migration: backend[0].success,
      edgeFunction: backend[1].success
    },
    security: {
      warnings: securityCheck.warnings?.length || 0,
      passed: !securityCheck.warnings || securityCheck.warnings.length === 0
    },
    frontend: {
      pr_url: pr.html_url,
      pr_number: pr.number
    },
    testing: {
      navigation: test.success,
      screenshot: 'deployment-validation.png'
    },
    overall_success:
      backend[0].success &&
      backend[1].success &&
      pr.html_url &&
      test.success
  };
`);

// ========================================
// Example 6: Multi-Environment Deployment
// ========================================

const multiEnvironmentDeployment = await executeTypescript(`
  /**
   * Deploy to multiple environments:
   * 1. Development branch (Supabase)
   * 2. Test and validate
   * 3. Merge to production
   */

  // Step 1: Create development branch
  const devBranch = await callMCPTool('mcp__supabase__create_branch', {
    branch: 'feature-posts',
    confirm_cost_id: 'confirmed' // Assume cost confirmed
  });

  // Step 2: Deploy to dev branch
  const devDeployment = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_posts',
    query: 'CREATE TABLE posts (...)',
    project_id: devBranch.project_id // Target dev branch
  });

  // Step 3: Run tests on dev branch
  const devTest = await callMCPTool('mcp__puppeteer__navigate', {
    url: \`https://\${devBranch.project_id}.supabase.co\`
  });

  // Step 4: If tests pass, merge to production
  let production = null;
  if (devTest.success) {
    production = await callMCPTool('mcp__supabase__merge_branch', {
      branch_id: devBranch.branch_id
    });
  }

  return {
    dev: {
      branch_created: !!devBranch.branch_id,
      deployment: devDeployment.success,
      tests: devTest.success
    },
    production: {
      merged: !!production?.success,
      url: production?.url
    }
  };
`);

// ========================================
// Example 7: Docker + Supabase Deployment
// ========================================

const dockerSupabaseDeployment = await executeTypescript(`
  /**
   * Deploy backend services with Docker + Supabase:
   * 1. Deploy database to Supabase
   * 2. Deploy containerized API service with Docker
   * 3. Connect them together
   */

  // PHASE 1: Supabase database
  const database = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'init_schema',
    query: \`
      CREATE TABLE users (...);
      CREATE TABLE posts (...);
      -- More schema
    \`
  });

  const dbUrl = await callMCPTool('mcp__supabase__get_project_url', {});
  const anonKey = await callMCPTool('mcp__supabase__get_anon_key', {});

  // PHASE 2: Docker API service
  // Note: This would use Docker MCP when available
  // For now, we'll create the configuration

  const dockerComposeConfig = \`
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - SUPABASE_URL=\${dbUrl}
      - SUPABASE_ANON_KEY=\${anonKey}
      - DATABASE_URL=postgresql://...
    restart: unless-stopped
  \`;

  // Save docker-compose.yml via filesystem MCP
  await callMCPTool('mcp__filesystem__write_file', {
    path: '/path/to/project/docker-compose.yml',
    content: dockerComposeConfig
  });

  return {
    database: {
      deployed: database.success,
      url: dbUrl,
      anon_key: anonKey
    },
    docker: {
      config_created: true,
      next_step: 'Run: docker-compose up -d'
    }
  };
`);

// ========================================
// Example 8: Deployment with Rollback
// ========================================

const deploymentWithRollback = await executeTypescript(`
  /**
   * Deploy with automatic rollback on failure
   */

  let migrationApplied = false;
  let edgeFunctionDeployed = false;

  try {
    // PHASE 1: Apply migration
    const migration = await callMCPTool('mcp__supabase__apply_migration', {
      name: 'add_feature_x',
      query: 'CREATE TABLE feature_x (...)'
    });

    if (!migration.success) {
      throw new Error(\`Migration failed: \${migration.error}\`);
    }
    migrationApplied = true;

    // PHASE 2: Deploy Edge Function
    const edgeFunction = await callMCPTool('mcp__supabase__deploy_edge_function', {
      name: 'feature-x-api',
      files: [{ name: 'index.ts', content: '...' }]
    });

    if (!edgeFunction.success) {
      throw new Error(\`Edge function deployment failed: \${edgeFunction.error}\`);
    }
    edgeFunctionDeployed = true;

    // PHASE 3: Test deployment
    const test = await callMCPTool('mcp__puppeteer__navigate', {
      url: 'https://staging.yourapp.com/feature-x'
    });

    if (!test.success) {
      throw new Error('Deployment test failed');
    }

    return {
      success: true,
      migration: true,
      edgeFunction: true,
      test: true
    };

  } catch (error) {
    console.error('Deployment failed, initiating rollback:', error);

    // ROLLBACK: Create rollback migration
    if (migrationApplied) {
      await callMCPTool('mcp__supabase__apply_migration', {
        name: 'rollback_feature_x',
        query: 'DROP TABLE IF EXISTS feature_x;'
      });
    }

    // Note: Edge Functions don't have direct rollback,
    // would need to redeploy previous version

    return {
      success: false,
      error: error.message,
      rollback_performed: migrationApplied
    };
  }
`);

// ========================================
// Example 9: Progressive Enhancement Deployment
// ========================================

const progressiveEnhancementDeployment = await executeTypescript(`
  /**
   * Deploy features progressively:
   * 1. Core functionality
   * 2. Validate core
   * 3. Add enhancements if core succeeds
   */

  // PHASE 1: Core feature
  const core = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'add_core_feature',
    query: 'CREATE TABLE core_feature (...)'
  });

  if (!core.success) {
    return {
      success: false,
      stage: 'core',
      error: core.error
    };
  }

  // PHASE 2: Test core
  const coreTest = await callMCPTool('mcp__puppeteer__navigate', {
    url: 'https://staging.app.com/core'
  });

  if (!coreTest.success) {
    return {
      success: false,
      stage: 'core_test',
      deployed: 'core',
      enhancements_skipped: true
    };
  }

  // PHASE 3: Enhancements (only if core works)
  const enhancements = await Promise.all([
    callMCPTool('mcp__supabase__apply_migration', {
      name: 'add_analytics',
      query: 'CREATE TABLE analytics (...)'
    }),
    callMCPTool('mcp__supabase__deploy_edge_function', {
      name: 'analytics-processor',
      files: [{ name: 'index.ts', content: '...' }]
    })
  ]);

  const allEnhancementsSucceeded = enhancements.every(e => e.success);

  return {
    success: true,
    core: {
      deployed: true,
      tested: true
    },
    enhancements: {
      deployed: allEnhancementsSucceeded,
      analytics_table: enhancements[0].success,
      analytics_function: enhancements[1].success
    }
  };
`);

// ========================================
// Example 10: Continuous Deployment Pipeline
// ========================================

const continuousDeploymentPipeline = await executeTypescript(`
  /**
   * Complete CI/CD pipeline:
   * 1. Pull latest code from GitHub
   * 2. Run tests
   * 3. Build
   * 4. Deploy to staging
   * 5. Run integration tests
   * 6. Deploy to production (if all pass)
   */

  // PHASE 1: Get latest code
  const commits = await callMCPTool('mcp__github__list_commits', {
    owner: 'ormus',
    repo: 'my-project'
  });

  const latestCommit = commits[0];

  // PHASE 2: Deploy to staging (Supabase dev branch)
  const stagingBranch = await callMCPTool('mcp__supabase__create_branch', {
    branch: \`deploy-\${latestCommit.sha.slice(0, 7)}\`,
    confirm_cost_id: 'confirmed'
  });

  const stagingMigration = await callMCPTool('mcp__supabase__apply_migration', {
    name: 'deploy_latest',
    query: '-- Migration SQL from code',
    project_id: stagingBranch.project_id
  });

  // PHASE 3: Integration tests on staging
  const tests = await callMCPTool('mcp__puppeteer__navigate', {
    url: \`https://\${stagingBranch.project_id}.supabase.co\`
  });

  await callMCPTool('mcp__puppeteer__screenshot', {
    name: 'staging-test',
    width: 1920,
    height: 1080
  });

  // PHASE 4: If tests pass, deploy to production
  let productionDeploy = null;
  if (tests.success) {
    productionDeploy = await callMCPTool('mcp__supabase__merge_branch', {
      branch_id: stagingBranch.branch_id
    });

    // Create GitHub release
    await callMCPTool('mcp__github__create_pull_request', {
      owner: 'ormus',
      repo: 'my-project',
      title: \`Release: \${latestCommit.sha.slice(0, 7)}\`,
      body: \`
## Deployment

✅ Staged on branch: \${stagingBranch.branch_id}
✅ Integration tests passed
✅ Deployed to production

Commit: \${latestCommit.sha}
Message: \${latestCommit.message}

🤖 Automated deployment via Claude Code
      \`,
      head: 'main',
      base: 'releases'
    });
  }

  return {
    commit: {
      sha: latestCommit.sha,
      message: latestCommit.message
    },
    staging: {
      deployed: stagingMigration.success,
      tested: tests.success,
      branch_id: stagingBranch.branch_id
    },
    production: {
      deployed: !!productionDeploy?.success,
      merged: !!productionDeploy
    },
    pipeline_success: tests.success && productionDeploy?.success
  };
`);

/**
 * HERMETIC PRINCIPLES IN ACTION
 *
 * These examples embody:
 *
 * MENTALISM - Clear intention before each deployment
 * VIBRATION - Deploy iteratively, test continuously
 * POLARITY - Balance automation with validation
 * RHYTHM - Sustainable deployment cycles
 * CAUSE-EFFECT - Every deployment monitored for results
 * CORRESPONDENCE - Local dev → Staging → Production (as above, so below)
 * GENDER - Build (masculine) + Validate (feminine)
 */

export {
  simpleSupabaseMigration,
  deployEdgeFunction,
  fullStackDeployment,
  concurrentDeployments,
  completeDeploymentWithValidation,
  multiEnvironmentDeployment,
  dockerSupabaseDeployment,
  deploymentWithRollback,
  progressiveEnhancementDeployment,
  continuousDeploymentPipeline
};
