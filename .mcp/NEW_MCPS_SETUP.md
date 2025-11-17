# New MCPs Setup Guide

> **Obsidian**, **Qdrant**, and **Scheduler** - Configuration walkthrough

---

## 📋 What We're Installing

| MCP | Purpose | Status | Priority |
|-----|---------|--------|----------|
| **Obsidian** | AI-powered note management | ⏳ Setup needed | High |
| **Qdrant** | Semantic search & AI memory | ⏳ Setup needed | High |
| **Scheduler** | Cron-based task automation | ⏸️ Optional (manual) | Medium |

---

## 🎯 Setup Order

**Recommended order:**
1. **Obsidian** (easiest, 5 minutes)
2. **Qdrant** (moderate, 10-15 minutes)
3. **Scheduler** (optional, for later)

---

## 1️⃣ Obsidian MCP Setup

### What You Need
- Obsidian installed
- 5 minutes

### Step-by-Step

#### A. Install Plugin in Obsidian

1. **Open Obsidian**
2. **Settings** (gear icon) → **Community Plugins**
3. **Disable Safe Mode** if asked
4. **Browse** button
5. Search: **"Local REST API"**
6. **Install** by coddingtonbear
7. **Enable** the plugin

#### B. Generate API Key

1. **Settings** → **Local REST API** (in left sidebar)
2. Click **"Generate API Key"**
3. **Copy the API key** (save it somewhere temporarily!)
4. Note the **port** (usually `27124`)

#### C. Update Claude Config

**Edit:** `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`

**Find this section:**
```json
"obsidian": {
  "env": {
    "OBSIDIAN_API_KEY": "YOUR_OBSIDIAN_API_KEY_HERE",
```

**Replace with your actual API key:**
```json
"OBSIDIAN_API_KEY": "1234567890abcdef...",
```

#### D. Test

Restart Claude Desktop, then try:
```
List my Obsidian notes
```

✅ **Success!** You should see your notes listed.

---

## 2️⃣ Qdrant MCP Setup

### What You Need
- Docker installed **OR** Qdrant binary
- OpenAI API key **OR** Ollama (free)
- 10-15 minutes

### Choose Your Path

**Option A: Quick Start (Docker + OpenAI)** - Easiest
**Option B: Free (Docker + Ollama)** - No API costs
**Option C: Cloud (Qdrant Cloud)** - No local install

---

### Option A: Docker + OpenAI (Recommended)

#### Step 1: Start Qdrant with Docker

```bash
docker run -d -p 6333:6333 --name qdrant qdrant/qdrant
```

**Verify it's running:**
```bash
docker ps
```

You should see `qdrant` in the list.

#### Step 2: Get OpenAI API Key

1. Go to: https://platform.openai.com/api-keys
2. Sign up/login (credit card required)
3. **Create new secret key**
4. **Copy the key** (starts with `sk-...`)

#### Step 3: Update Claude Config

**Edit:** `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`

**Find:**
```json
"qdrant": {
  "env": {
    "OPENAI_API_KEY": "YOUR_OPENAI_API_KEY_HERE"
```

**Replace:**
```json
"OPENAI_API_KEY": "sk-your-actual-key-here"
```

#### Step 4: Test

Restart Claude Desktop, then:
```
Create a Qdrant collection called "test-collection"
```

✅ **Success!** Collection created.

---

### Option B: Docker + Ollama (Free)

#### Step 1: Start Qdrant

```bash
docker run -d -p 6333:6333 --name qdrant qdrant/qdrant
```

#### Step 2: Install Ollama

**Download:** https://ollama.ai/download
**Install** the application for Windows

#### Step 3: Pull Embedding Model

```bash
ollama pull nomic-embed-text
```

#### Step 4: Start Ollama Server

```bash
ollama serve
```

(Keep this running in the background)

#### Step 5: Update Claude Config

**Edit:** `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`

**Replace the qdrant section:**
```json
"qdrant": {
  "command": "npx",
  "args": ["-y", "better-qdrant-mcp-server"],
  "env": {
    "QDRANT_URL": "http://localhost:6333",
    "OLLAMA_ENDPOINT": "http://localhost:11434",
    "EMBEDDING_MODEL": "nomic-embed-text"
  }
}
```

(Remove `OPENAI_API_KEY`, add `OLLAMA_ENDPOINT` and `EMBEDDING_MODEL`)

#### Step 6: Test

Same as Option A - create a test collection.

---

### Option C: Qdrant Cloud (No Docker)

#### Step 1: Create Cluster

1. Go to: https://cloud.qdrant.io/
2. Sign up (free tier available)
3. **Create cluster**
4. Copy **Cluster URL** and **API Key**

#### Step 2: Get OpenAI Key

(Same as Option A, Step 2)

#### Step 3: Update Claude Config

```json
"qdrant": {
  "env": {
    "QDRANT_URL": "https://your-cluster.qdrant.cloud:6333",
    "QDRANT_API_KEY": "your-qdrant-cloud-api-key",
    "OPENAI_API_KEY": "sk-your-openai-key"
  }
}
```

---

## 3️⃣ Scheduler MCP (Optional - For Later)

**Note:** Scheduler requires manual Python setup. Skip for now if you want.

**Alternative:** Use your existing **n8n** for scheduling! It's already configured and works great for cron jobs.

**If you want to install Scheduler later:**
See: `.mcp/docs/mcps/scheduler.md` for full instructions.

---

## 🧪 Testing All MCPs

After setup, test each one:

### Test Obsidian
```
Show me my recent Obsidian notes
```

### Test Qdrant
```
Create a Qdrant collection called "knowledge-base"
```

Then:
```
Add this to my knowledge-base collection:
"The Principle of Mentalism: The All is Mind. The Universe is Mental."
```

Then search:
```
Search my knowledge-base for information about consciousness
```

### Test Integration
```
Take my most recent Obsidian note and add it to my Qdrant knowledge-base collection for semantic search
```

---

## 📊 Current MCP Status

After completing this setup:

| MCP | Status | Purpose |
|-----|--------|---------|
| Filesystem | ✅ Active | File operations |
| Memory | ✅ Active | Knowledge graph |
| GitHub | ✅ Active | Repository management |
| Puppeteer | ✅ Active | Browser automation |
| Telegram | ✅ Active | Personal messaging |
| WhatsApp | ⏳ Pending | Needs Go + QR auth |
| n8n | ✅ Active | Workflow orchestration |
| Discord | ✅ Active | Bot management |
| **Obsidian** | ⏳ **Setup today** | Note management |
| **Qdrant** | ⏳ **Setup today** | Semantic search |
| Scheduler | ⏸️ Optional | Cron automation |

---

## 🚨 Troubleshooting

### Obsidian: "Connection refused"
1. Check Obsidian is running
2. Verify plugin is enabled
3. Check port (should be 27124)
4. Restart both Obsidian and Claude

### Qdrant: "Connection refused"
1. Check Qdrant is running:
   ```bash
   docker ps
   ```
2. Verify port 6333 is not blocked
3. Try restart:
   ```bash
   docker restart qdrant
   ```

### Qdrant: "Invalid API key"
1. Test OpenAI key:
   ```bash
   curl https://api.openai.com/v1/models \
     -H "Authorization: Bearer YOUR_KEY"
   ```
2. Regenerate if needed
3. Check for typos in config

### General: MCP not loading
1. Check JSON syntax (no trailing commas!)
2. Restart Claude Desktop completely
3. Check logs in Claude Desktop

---

## 💰 Cost Tracking

### Qdrant with OpenAI
- **Embedding cost**: ~$0.0001 per 1,000 tokens
- **Average document**: ~500 tokens = $0.00005
- **10,000 documents**: ~$0.50

**To minimize costs:**
- Use Ollama for development (free!)
- Only use OpenAI for production
- Cache embeddings (don't re-embed same content)

### Other MCPs
- **Obsidian**: Free (local)
- **Scheduler**: Free (local)

---

## 🎯 Next Steps

After setup:

1. **Read the docs:**
   - `.mcp/docs/mcps/obsidian.md`
   - `.mcp/docs/mcps/qdrant.md`
   - `.mcp/docs/mcps/scheduler.md`

2. **Try integration patterns:**
   - `.mcp/integrations/patterns/cross-platform-messaging.md`

3. **Build your first workflow:**
   - Use n8n to orchestrate MCPs
   - Create automation pipelines
   - Document in `.mcp/workflows/`

4. **Explore use cases:**
   - Personal knowledge management (Obsidian + Qdrant)
   - Automated research (Puppeteer + Qdrant + Obsidian)
   - Smart notifications (n8n + Telegram/Discord)

---

## 🏆 Gold Hat Reminder

With Qdrant, you now have **AI memory** and **semantic search**. Use it wisely:

✅ **Empower yourself:**
- Build personal knowledge systems
- Create intelligent assistants
- Organize research effectively

❌ **Don't exploit:**
- Don't scrape without permission
- Don't build surveillance systems
- Don't create manipulative AI
- Respect data privacy

**The Litmus Test:**
> "Would I be proud to explain this system to someone affected by it?"

---

**Ready to set up? Start with Obsidian (easiest), then Qdrant!**
