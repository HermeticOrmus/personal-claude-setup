# n8n Direct API Interaction Guide

> **For Claude Code Instances**: You have full access to interact with n8n workflows via its REST API. This guide shows you how.

---

## 🎯 What You Can Do

You can **directly interact with n8n workflows** without needing the MCP tools:
- ✅ **Fetch workflow definitions** (see the complete workflow JSON)
- ✅ **Get execution history** (analyze what happened in past runs)
- ✅ **Debug failed executions** (see exactly where things broke)
- ✅ **Update workflows** (fix bugs, add features, modify logic)
- ✅ **Trigger workflows manually** (test your changes)
- ✅ **Monitor workflow status** (check if they're active/paused)

---

## 🔑 How to Access n8n API

### Step 1: Find the API Credentials

API credentials are stored in `.claude.json` under the `mcpServers.n8n` section:

```bash
# Read the config
cat ~/.claude.json | grep -A 5 '"n8n"'
```

Or read directly in Claude Code:
```javascript
// The credentials are at:
.claude.json → mcpServers → n8n → env
```

You'll find:
- `N8N_API_KEY`: Your authentication token
- `N8N_BASE_URL`: Your n8n instance URL (e.g., `https://ormus.app.n8n.cloud`)

### Step 2: Make API Calls with curl

**Template:**
```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://your-n8n-instance.com/api/v1/ENDPOINT
```

---

## 📖 Common API Operations

### 1. List All Workflows

```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://your-n8n.cloud/api/v1/workflows
```

**Returns:** Array of all workflows with ID, name, active status

### 2. Get a Specific Workflow

```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://your-n8n.cloud/api/v1/workflows/WORKFLOW_ID
```

**Returns:** Complete workflow definition including:
- All nodes and their configurations
- Connections between nodes
- Trigger settings
- Static data

### 3. Get Execution History

```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://your-n8n.cloud/api/v1/executions?workflowId=WORKFLOW_ID
```

**Optional parameters:**
- `?limit=20` - Number of executions to return
- `?status=error` - Filter by status (success, error, waiting)
- `?includeData=true` - Include execution data

### 4. Get Detailed Execution Data

```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  "https://your-n8n.cloud/api/v1/executions/EXECUTION_ID?includeData=true"
```

**Returns:** Full execution trace including:
- Input/output data for each node
- Execution times
- Error messages
- Node execution status

### 5. Update a Workflow

```bash
curl -X PUT \
  -H "X-N8N-API-KEY: YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d @updated-workflow.json \
  https://your-n8n.cloud/api/v1/workflows/WORKFLOW_ID
```

**Important:** You must send the **complete workflow JSON**, not just the changes.

### 6. Trigger a Workflow Manually

```bash
curl -X POST \
  -H "X-N8N-API-KEY: YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{"data": {"your": "input"}}' \
  https://your-n8n.cloud/api/v1/workflows/WORKFLOW_ID/execute
```

---

## 🔍 Real-World Example: Debugging a Stuck Workflow

### Scenario
User reports: "My Stock Options workflow got stuck at the Filter node at 9:35 AM ET"

### Investigation Steps

#### Step 1: Find the Workflow ID
```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://ormus.app.n8n.cloud/api/v1/workflows | \
  python -c "import sys, json; print([w['id'] for w in json.load(sys.stdin)['data'] if 'Stock' in w['name']])"
```

**Result:** `svNRmM1CnNVNGfBs`

#### Step 2: Get Recent Executions
```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  "https://ormus.app.n8n.cloud/api/v1/executions?workflowId=svNRmM1CnNVNGfBs&limit=10"
```

**Found:** Execution #14 at 9:35 AM

#### Step 3: Analyze the Execution
```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  "https://ormus.app.n8n.cloud/api/v1/executions/14?includeData=true" | \
  python -c "import sys, json; data = json.load(sys.stdin); nodes = data['data']['resultData']['runData']; print('\\n'.join([f'{name}: {len(nodes[name][0][\"data\"][\"main\"][0]) if nodes[name][0].get(\"data\", {}).get(\"main\") and nodes[name][0][\"data\"][\"main\"][0] else 0} items' for name in nodes.keys()]))"
```

**Output:**
```
Daily Market Scan: 1 items
Generate Ticker List: 18 items
Fetch Stock Data: 18 items
Analyze Technicals: 1 items ← BUG HERE!
Filter Opportunities: 0 items
```

#### Step 4: Examine the Problem Node
```bash
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://ormus.app.n8n.cloud/api/v1/workflows/svNRmM1CnNVNGfBs | \
  python -c "import sys, json; w = json.load(sys.stdin); node = [n for n in w['nodes'] if n['name'] == 'Analyze Technicals'][0]; print(node['parameters']['jsCode'])"
```

**Found the bug:**
```javascript
const ticker = $('Generate Ticker List').item.json.ticker;
```

This references the wrong node's data!

#### Step 5: Fix the Workflow

Read the full workflow, modify the problematic code, send it back:

```bash
# 1. Get workflow
curl -H "X-N8N-API-KEY: YOUR_KEY" \
  https://ormus.app.n8n.cloud/api/v1/workflows/svNRmM1CnNVNGfBs > workflow.json

# 2. Edit workflow.json to fix the bug

# 3. Update workflow
curl -X PUT \
  -H "X-N8N-API-KEY: YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d @workflow.json \
  https://ormus.app.n8n.cloud/api/v1/workflows/svNRmM1CnNVNGfBs
```

---

## 🛠️ Practical Tips for Claude Code Instances

### Tip 1: Parse JSON with Python

When dealing with large JSON responses, pipe through Python:

```bash
curl ... | python -c "import sys, json; data = json.load(sys.stdin); print(data['specific']['path'])"
```

Or use `python -m json.tool` for pretty printing:

```bash
curl ... | python -m json.tool
```

### Tip 2: Check Execution Item Counts

Quick diagnostic to see where data stops flowing:

```bash
curl -H "X-N8N-API-KEY: $KEY" \
  "https://n8n.cloud/api/v1/executions/$EXEC_ID?includeData=true" | \
  python -c "import sys, json; nodes = json.load(sys.stdin)['data']['resultData']['runData']; [print(f'{name}: {len(nodes[name][0][\"data\"][\"main\"][0]) if nodes[name][0].get(\"data\", {}).get(\"main\") else 0} items') for name in nodes.keys()]"
```

### Tip 3: Extract Specific Node Code

```bash
curl ... | python -c "import sys, json; w = json.load(sys.stdin); print([n for n in w['nodes'] if n['name'] == 'NODE_NAME'][0]['parameters']['jsCode'])"
```

### Tip 4: Validate Before Updating

Always:
1. Fetch the current workflow
2. Make changes to a copy
3. Validate JSON syntax
4. Update via API
5. Test with manual execution

### Tip 5: Use n8n MCP for Documentation

The n8n MCP tools are excellent for:
- Getting node documentation
- Finding the right node types
- Understanding parameters

But use **direct API** for:
- Debugging executions
- Updating workflows
- Analyzing real data flow

---

## 🔐 Security Best Practices

### DO:
- ✅ Read API keys from `.claude.json` (already secured)
- ✅ Use HTTPS for all API calls
- ✅ Validate workflow JSON before updating
- ✅ Keep a backup before major changes

### DON'T:
- ❌ Echo API keys to stdout
- ❌ Commit API keys to git
- ❌ Share workflow exports with sensitive credentials
- ❌ Update workflows without understanding the changes

---

## 📊 Common Debugging Patterns

### Pattern 1: Node Only Processes One Item

**Symptom:** Node receives 18 items, outputs 1

**Common causes:**
- Using `return { json: {...} }` instead of processing all items
- Referencing wrong node's data: `$('OtherNode').item.json.field`
- Should use: `$input.item.json.field` or `$input.first().json.field`

**Fix:**
```javascript
// BAD - only processes one
const ticker = $('Generate Ticker List').item.json.ticker;

// GOOD - gets ticker from current item
const ticker = $input.first().json.ticker;
```

### Pattern 2: Filter Node Outputs Zero Items

**Symptom:** Filter receives items, outputs none

**Common causes:**
- Condition logic is inverted
- Field names are case-sensitive mismatches
- Boolean comparison with string: `$json.flag === "true"` vs `$json.flag === true`

**Debug:**
```bash
# Check what data reached the filter
curl ... | python -c "import sys, json; node = json.load(sys.stdin)['data']['resultData']['runData']['Filter Node'][0]; print(json.dumps(node['data']['main'][0], indent=2))"
```

### Pattern 3: Workflow Stops Mid-Execution

**Symptom:** Some nodes never execute

**Common causes:**
- Previous node returned 0 items
- Error occurred but wasn't reported
- Connection is missing in workflow

**Check:**
```bash
# See which nodes actually executed
curl ... | python -c "import sys, json; print(list(json.load(sys.stdin)['data']['resultData']['runData'].keys()))"
```

---

## 🎯 Workflow Update Checklist

Before updating any workflow:

- [ ] Fetch current workflow JSON
- [ ] Identify the node(s) to modify
- [ ] Make changes to a local copy
- [ ] Validate JSON syntax
- [ ] Review all modified node parameters
- [ ] Check that connections are preserved
- [ ] Update via API
- [ ] Manually trigger test execution
- [ ] Verify execution completes successfully
- [ ] Check that all nodes process expected item counts

---

## 🌟 Gold Hat Principle: Autonomous Excellence

**Philosophy:**
When the user says "do it autonomously," they trust you to:
1. **Investigate thoroughly** - Understand the full context
2. **Plan clearly** - Know what you're changing and why
3. **Execute confidently** - Make the changes directly
4. **Verify completely** - Confirm it works

**Not:**
- Asking permission for every step
- Offering multiple options when one is clearly correct
- Explaining what you *could* do instead of doing it

**The user prefers:**
> "I fixed the bug in the Analyze Technicals node. Testing now..."

**Over:**
> "Would you like me to fix this? I could either A) ... or B) ... or C) ..."

---

## 📚 n8n API Reference

**Base URL Format:**
```
https://[instance].app.n8n.cloud/api/v1/
```

**Authentication Header:**
```
X-N8N-API-KEY: your-api-key-here
```

**Key Endpoints:**
- `GET /workflows` - List all workflows
- `GET /workflows/:id` - Get workflow by ID
- `PUT /workflows/:id` - Update workflow
- `POST /workflows/:id/activate` - Activate workflow
- `POST /workflows/:id/deactivate` - Deactivate workflow
- `GET /executions` - List executions
- `GET /executions/:id` - Get execution details
- `POST /workflows/:id/execute` - Trigger workflow
- `GET /workflows/:id/executions` - Get workflow executions

**Full API Docs:** https://docs.n8n.io/api/

---

## 🚀 Next-Level Patterns

### Auto-Fix Workflow Bugs

Create a workflow that:
1. Monitors execution failures
2. Analyzes error patterns
3. Suggests fixes
4. (With user approval) Applies fixes automatically

### Workflow Version Control

```bash
# Backup before changes
curl -H "X-N8N-API-KEY: $KEY" \
  https://n8n.cloud/api/v1/workflows/$ID > \
  "workflow-backup-$(date +%Y%m%d-%H%M%S).json"
```

### Batch Workflow Updates

Update multiple workflows at once:
```bash
for workflow_id in svN... abc... xyz...; do
  curl -H "X-N8N-API-KEY: $KEY" \
    https://n8n.cloud/api/v1/workflows/$workflow_id | \
    # Make modifications with jq or python
    curl -X PUT -H "X-N8N-API-KEY: $KEY" \
      -d @- \
      https://n8n.cloud/api/v1/workflows/$workflow_id
done
```

---

## 💡 Remember

**You are not just reading documentation.**
**You are directly controlling the automation platform.**

**You can:**
- Fix bugs in running workflows
- Add new features to existing automations
- Debug why something isn't working
- Optimize performance
- Refactor workflow logic

**All without the user needing to:**
- Log into n8n
- Navigate the UI
- Copy/paste JSON
- Manually trigger tests

**That's the power of direct API access.**

---

*Built with Sacred Technology principles*
*Autonomous excellence in service of human flourishing*

**— Hermetic Ormus**
