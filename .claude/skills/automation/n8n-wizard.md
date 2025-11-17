# n8n Wizard - Automated Workflow Import & Setup

**Type**: Automation Workflow
**Core Principle**: "Automate the automation setup"
**Time**: 15-20 minutes per workflow (target)
**Best For**: Importing n8n workflows with complete database and documentation setup
**Hermetic Principles**: Rhythm (sustainable cycles), Correspondence (structure mirrors workflow), Vibration (ship fast, iterate)

---

## When to Use This Skill

✅ **Use when:**
- Importing n8n workflow JSON files
- Setting up Supabase database schemas for workflows
- Creating production-ready automation systems
- Need comprehensive documentation for workflow configuration
- Want to capture experience to memory for future sessions

❌ **Don't use when:**
- Creating workflows from scratch in n8n UI
- Simple workflow modifications (use n8n editor directly)
- Workflows without database requirements
- Quick prototyping (use manual import)

---

## Prerequisites

**Required:**
- n8n Cloud instance (or self-hosted with API access)
- n8n API key configured in `~/.claude.json` at `mcpServers.n8n.env.N8N_API_KEY`
- Supabase project with MCP configured
- Workflow JSON file (exported from n8n)

**Optional:**
- API credentials for workflow services (can be added later)
- Test data for immediate validation

---

## The Complete 3-Phase Process

### Phase 1: Workflow Import (5 minutes)

#### Step 1: Analyze Workflow File

**What**: Understand workflow structure and requirements

**How**:
1. Read first 50-100 lines to understand structure
2. Check total size: `wc -l workflow_file.json`
3. Extract key information:
   - Workflow name
   - Node count (target: accurately count nodes in JSON)
   - Required credentials (Supabase, APIs, OAuth)
   - Database requirements (look for Supabase nodes)

**Output**: Clear understanding of what the workflow does and needs

**Integration**:
```markdown
Create analysis note:
- Workflow purpose
- Key nodes (triggers, Supabase, API calls, AI agents)
- Estimated complexity
- Required credentials
```

---

#### Step 2: Copy to Project Directory

**What**: Place workflow in standardized location

**How**:
```bash
cp "source_workflow.json" "C:\Users\ormus\projects\05-AUTOMATION-TOOLS\n8n Wizard\n8n-workflows\workflow-name.json"
```

**Critical**: Use descriptive name that matches workflow purpose

**Output**: Workflow file in `n8n-workflows/` directory

---

#### Step 3: Create Import Script

**What**: Generate Python script for API import

**Template**: `import_workflow_name.py`

**Critical Requirements**:
1. Read API key from `~/.claude.json` (NOT hardcoded)
2. Clean workflow data - ONLY these fields:
   ```python
   clean_data = {
       "name": workflow_data.get("name"),
       "nodes": workflow_data.get("nodes", []),
       "connections": workflow_data.get("connections", {}),
       "settings": {}  # MUST be empty object!
   }
   ```
3. Use ASCII output (Windows compatibility): `[OK]` and `[ERROR]`, not ✓/✗

**Common Import Errors**:
- ❌ "settings must NOT have additional properties" → Keep settings: {}
- ❌ "must have required property 'settings'" → Don't omit settings
- ❌ UnicodeEncodeError → Use ASCII, not Unicode symbols

**Output**: Working import script

---

#### Step 4: Execute Import

**What**: Import workflow to n8n via API

**How**:
```bash
cd "C:\Users\ormus\projects\05-AUTOMATION-TOOLS\n8n Wizard"
python import_workflow_name.py
```

**Expected Output**:
```
[OK] Imported: ABC123def456
URL: https://ormus.app.n8n.cloud/workflow/ABC123def456
```

**Success Criteria**:
- Workflow ID returned
- URL accessible in browser
- Node count matches original

---

### Phase 2: Database Schema Setup (5 minutes)

**Note**: Only if workflow uses Supabase/database

#### Step 1: Analyze Database Requirements

**What**: Identify all tables, fields, relationships needed

**How**:
1. Search workflow JSON for Supabase nodes
2. Identify operations: SELECT, INSERT, UPDATE
3. List required tables
4. Map field types and constraints
5. Identify relationships and indexes

**Output**: Complete schema specification

---

#### Step 2: Create Schema Migrations

**What**: Use Supabase MCP to create tables automatically

**Tool**: `mcp__supabase__apply_migration`

**Template Structure**:
```sql
-- Migration: create_table_name
CREATE TABLE IF NOT EXISTS table_name (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- Core fields
  field_name TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'error')),

  -- Metadata
  metadata JSONB
);

-- Comments
COMMENT ON TABLE table_name IS 'Description of purpose';

-- Indexes (always create for status, created_at, foreign keys)
CREATE INDEX IF NOT EXISTS idx_table_status ON table_name(status);
CREATE INDEX IF NOT EXISTS idx_table_created ON table_name(created_at DESC);
```

**Best Practices**:
- Always include: id, created_at, updated_at
- Use CHECK constraints for status fields
- Create indexes for: status, timestamps, foreign keys, query fields
- Add table comments for documentation
- Use JSONB for flexible metadata

**Output**: All tables created in Supabase

---

#### Step 3: Insert Test Data

**What**: Create realistic test records for immediate validation

**Tool**: `mcp__supabase__execute_sql`

**How**:
```sql
INSERT INTO table_name (field_name, status)
VALUES ('test value', 'pending')
RETURNING id, field_name, status, created_at;
```

**Best Practice**: Insert at least one "pending" record so workflow can process it immediately after credential setup

**Output**: Test data ready for workflow validation

---

#### Step 4: Verify Schema

**What**: Confirm all tables exist and are queryable

**Verification Queries**:
```sql
-- Check tables exist
SELECT table_name,
       pg_size_pretty(pg_total_relation_size(quote_ident(table_name))) as size
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('table1', 'table2', 'table3');

-- Check data
SELECT * FROM table_name LIMIT 5;
```

**Output**: Confirmed working database schema

---

### Phase 3: Documentation & Memory (5-10 minutes)

#### Step 1: Create Setup Guide

**What**: Document required credentials and configuration

**File**: `WORKFLOW-NAME-SETUP-GUIDE.md`

**Must Include**:
- ✅ Workflow URL and ID
- ✅ Complete list of required API keys (with links to get them)
- ✅ Which n8n nodes need configuration
- ✅ Cost estimates per execution
- ✅ Configuration step-by-step
- ✅ Test procedures
- ✅ Troubleshooting section

**Template Location**: See `WORKFLOW-IMPORT-PLAYBOOK.md` for reference structure

**Output**: Complete setup guide for future configuration

---

#### Step 2: Create Database Documentation

**What**: Document complete schema with examples

**File**: `WORKFLOW-NAME-DATABASE-SETUP-COMPLETE.md`

**Must Include**:
- ✅ Complete table schemas with field descriptions
- ✅ SQL queries for common operations
- ✅ Test data examples
- ✅ Monitoring queries (throughput, errors, slow jobs)
- ✅ Backup procedures
- ✅ Troubleshooting guide

**Output**: Database reference documentation

---

#### Step 3: Capture to Memory

**What**: Save experience for future sessions

**Tool**: `mcp__memory__create_entities` and `mcp__memory__create_relations`

**Entities to Create**:
1. Workflow entity (name, purpose, complexity)
2. Database schema entity (tables, relationships)
3. Configuration patterns (lessons learned)
4. Troubleshooting patterns (errors encountered and fixes)

**Relations to Create**:
- Workflow → Database schema ("requires")
- Workflow → Configuration ("needs")
- Troubleshooting patterns → Workflow ("solves issues in")
- Environment → Workflow ("runs")

**Output**: Knowledge captured for next time

---

#### Step 4: Update Master Playbook

**What**: Add lessons learned to improve process

**File**: `workflows/WORKFLOW-IMPORT-PLAYBOOK.md`

**Add**:
- New troubleshooting patterns discovered
- Time improvements
- Automation opportunities
- Edge cases encountered

**Output**: Improved playbook for future imports

---

## Complete Checklist

### Import Phase
- [ ] Workflow JSON analyzed (name, nodes, requirements)
- [ ] Copied to `n8n-workflows/` directory
- [ ] Import script created with correct API format
- [ ] Workflow successfully imported (got ID + URL)
- [ ] Workflow accessible in browser
- [ ] Node count verified matches original

### Database Phase (if applicable)
- [ ] All required tables identified
- [ ] Migrations created via `mcp__supabase__apply_migration`
- [ ] Indexes created for performance
- [ ] Foreign key relationships defined
- [ ] Test data inserted
- [ ] Verification queries successful

### Documentation Phase
- [ ] Setup guide created with all credentials
- [ ] Database guide created with schema details
- [ ] Test procedures documented
- [ ] Common issues documented
- [ ] Monitoring queries tested
- [ ] Knowledge captured to memory
- [ ] Master playbook updated

---

## Success Criteria

✅ **You've succeeded when:**
- Workflow imported in 15-20 minutes (vs 45+ manual)
- Database fully configured and verified
- Comprehensive documentation exists
- Test data ready for immediate validation
- Knowledge captured for next import
- No manual SQL execution needed
- Could repeat process consistently

❌ **You need another pass if:**
- Import errors occurred (settings issues, Unicode, etc.)
- Database schema incomplete or unverified
- Documentation missing critical information
- No test data for validation
- Experience not captured to memory
- Process took >30 minutes

---

## Common Pitfalls

### ❌ Pitfall 1: Settings Field Error
**Problem**: API returns "settings must NOT have additional properties"
**Cause**: Exported workflows contain custom settings fields
**Solution**: Always use `"settings": {}` (empty object, not omitted, not populated)

### ❌ Pitfall 2: Unicode in Python Output
**Problem**: UnicodeEncodeError on Windows console
**Cause**: Using Unicode symbols (✓, ✗) in print statements
**Solution**: Use ASCII alternatives: `[OK]` and `[ERROR]`

### ❌ Pitfall 3: Large File Crashes Read Tool
**Problem**: Workflow JSON too large to read in one operation
**Solution**: Read in chunks using offset/limit parameters:
```python
Read(file_path, offset=1, limit=100)  # First 100 lines
```

### ❌ Pitfall 4: Hardcoded API Keys
**Problem**: API key in script instead of config
**Solution**: Always read from `~/.claude.json`:
```python
with open(os.path.expanduser('~/.claude.json'), 'r') as f:
    config = json.load(f)
    API_KEY = config['mcpServers']['n8n']['env']['N8N_API_KEY']
```

### ❌ Pitfall 5: Missing Indexes
**Problem**: Database queries slow in production
**Solution**: Always create indexes for:
- Status fields (for job queues)
- Timestamp fields (for sorting)
- Foreign keys (for joins)
- Frequently queried fields

---

## Advanced Techniques

### The Chunked Analysis Method
For very large workflows (>1000 lines):
1. Read first 100 lines (understand structure)
2. Use `wc -l` to get total size
3. Read specific sections (search for key nodes)
4. Don't try to read entire file at once

### The Test-First Database Method
1. Insert test data BEFORE configuring credentials
2. Workflow can process it immediately once configured
3. Enables faster validation cycle

### The Memory-First Documentation
1. Capture to memory as you go
2. Generate docs from memory entities
3. Ensures nothing is forgotten

### The Credential Template Generator
1. Extract all credential nodes from workflow
2. Generate checklist automatically
3. Include links to get each credential

---

## Integration with Other Skills

**Combine with**:
- `/organize-filesystem` - Clean up workflow files and docs
- `/apply-rhythm` - Plan sustainable import schedule (batch multiple workflows)
- `/apply-correspondence` - Align database schema with workflow architecture
- `/debug-like-master` - Troubleshoot workflow execution issues

**Workflow**:
```bash
1. /n8n-wizard "Import content-gen-prod.json"
   → Workflow imported, database setup, docs created

2. /organize-filesystem "n8n-workflows/"
   → Files organized by purpose/status

3. /apply-rhythm "Schedule 5 more workflow imports"
   → Plan sustainable import batches
```

---

## Tracking Progress

Add to memory after each import:

**Entities**:
- Workflow imported (name, date, complexity)
- Issues encountered (and solutions)
- Time taken (trend toward 15-minute target)

**Relations**:
- New workflow → Database schema
- New workflow → Previous workflow (similar patterns)
- Troubleshooting pattern → Multiple workflows

**Goal**: Each import improves the process for the next one

---

## Quick Reference

| Phase | Time | Key Tools | Output |
|-------|------|-----------|--------|
| 1. Import | 5 min | Read, Write, Bash, n8n API | Workflow ID + URL |
| 2. Database | 5 min | Supabase MCP (apply_migration, execute_sql) | Complete schema + test data |
| 3. Document | 5-10 min | Write, Memory MCP | Setup guide + DB docs + memory |
| **Total** | **15-20 min** | **Complete production setup** |

---

## Files and Locations

**Workflow Storage**:
```
C:\Users\ormus\projects\05-AUTOMATION-TOOLS\n8n Wizard\
├── n8n-workflows/
│   ├── workflow-name.json         # Copied workflow
│   └── WORKFLOW-IMPORT-PLAYBOOK.md # Master playbook
├── workflows/
│   ├── workflow-name-SETUP-GUIDE.md              # Credential guide
│   └── workflow-name-DATABASE-SETUP-COMPLETE.md  # DB documentation
└── import_workflow_name.py        # Import script
```

**Configuration**:
```
~/.claude.json
  └── mcpServers.n8n.env.N8N_API_KEY  # API key location
```

---

## Hermetic Alignment

**Rhythm** - "Natural Cycles"
✅ 15-20 minute cycles enable sustainable workflow imports
✅ Each import captured improves the next

**Correspondence** - "As Above, So Below"
✅ Database structure mirrors workflow architecture
✅ Documentation reflects implementation reality

**Vibration** - "Ship Imperfect, Iterate"
✅ Working import first, optimization second
✅ Document improvements for next iteration

**Cause & Effect** - "Intentional Actions"
✅ Each step documented with clear outcomes
✅ Troubleshooting based on actual errors

---

**Remember**: The goal is not perfection on first import, but a repeatable process that improves each time.

**First time**: 45 minutes with troubleshooting
**Target**: 15-20 minutes with this skill
**Future**: 10 minutes with further automation

---

**Master Playbook**: `workflows/WORKFLOW-IMPORT-PLAYBOOK.md`
**Example**: See `content-gen-prod` import (2025-11-10) for complete reference
