# Qdrant MCP

## Overview
Qdrant MCP provides semantic search and vector embedding capabilities, enabling AI-powered knowledge retrieval, RAG (Retrieval Augmented Generation) systems, and intelligent memory.

## Status
⏳ **Pending Setup** - Requires Qdrant running + OpenAI API key

## Configuration
- **Package**: `better-qdrant-mcp-server` (npm)
- **Qdrant URL**: `http://localhost:6333` (default local)
- **Embedding Provider**: OpenAI (or Ollama/OpenRouter)

---

## What is Qdrant?

Qdrant is a vector database optimized for:
- **Semantic Search** - Find similar content by meaning, not keywords
- **AI Memory** - Long-term memory for AI agents
- **RAG Systems** - Retrieval Augmented Generation
- **Similarity Matching** - Find related documents/code/data

**Think of it as:** Google search for AI agents, but understanding meaning instead of just matching words.

---

## Setup Steps

### 1. Install Qdrant (Choose One Method)

#### **Option A: Docker (Recommended)**
```bash
docker run -p 6333:6333 qdrant/qdrant
```

####  **Option B: Local Binary**
Download from: https://qdrant.tech/download/
Run the executable

#### **Option C: Qdrant Cloud** (Free tier available)
1. Sign up at https://cloud.qdrant.io/
2. Create a cluster
3. Get API key and URL
4. Update config with cloud URL

### 2. Get OpenAI API Key

**If you don't have one:**
1. Go to https://platform.openai.com/api-keys
2. Create account (credit card required for usage)
3. Generate new API key
4. Copy the key (shown once!)

**Alternative: Use Ollama (Free, Local)**
- Install Ollama: https://ollama.ai/
- Run: `ollama serve`
- Update config to use `OLLAMA_ENDPOINT` instead

### 3. Update Claude Config

Replace in `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`:

```json
"OPENAI_API_KEY": "sk-your-actual-openai-api-key-here"
```

**If using Qdrant Cloud:**
```json
"QDRANT_URL": "https://your-cluster.qdrant.cloud:6333",
"QDRANT_API_KEY": "your-qdrant-cloud-api-key"
```

**If using Ollama (free local):**
```json
"OLLAMA_ENDPOINT": "http://localhost:11434",
"EMBEDDING_MODEL": "nomic-embed-text"
```

### 4. Restart Claude Desktop

Close and reopen Claude Desktop.

---

## Capabilities

### Collection Management
- **Create collections** - Organize vector data
- **List collections** - See all available collections
- **Delete collections** - Clean up old data
- **Get collection info** - Check size, config

### Document Operations
- **Add documents** - Store text with embeddings
- **Search documents** - Semantic similarity search
- **Update documents** - Modify existing entries
- **Delete documents** - Remove entries
- **Batch operations** - Process multiple docs at once

### Search Features
- **Semantic search** - Find by meaning
- **Metadata filtering** - Combine vector + traditional search
- **Similarity threshold** - Control result quality
- **Top-K results** - Get best N matches

---

## Usage Examples

### Create Knowledge Base
```
Create a Qdrant collection called "hermetic-knowledge" for storing philosophy notes
```

### Add Documents
```
Add these documents to my "hermetic-knowledge" collection:
1. "The Principle of Mentalism states: The All is Mind"
2. "The Principle of Correspondence: As above, so below"
3. "The Principle of Vibration: Nothing rests, everything moves"
```

### Semantic Search
```
Search my "hermetic-knowledge" collection for information about consciousness and thought
```

### Build RAG System
```
When I ask about Hermetic principles, search my Qdrant collection first, then answer using that context
```

---

## Gold Hat Use Cases

### 1. Personal Knowledge Base
**Store your learning:**
- Book notes and highlights
- Article summaries
- Course materials
- Research papers

**Benefits:**
- Semantic search your knowledge
- Find related concepts
- Never lose an insight

### 2. Code Knowledge
**Index your codebase:**
- Function descriptions
- Architecture decisions
- Code patterns
- Bug solutions

**Benefits:**
- Find similar code
- Answer "how did I solve X?"
- Onboard faster

### 3. Conversation Memory
**Remember context:**
- Important discussions
- Project decisions
- User preferences
- Historical context

**Benefits:**
- Long-term memory for AI
- Consistent interactions
- Context-aware responses

### 4. Research Assistant
**Organize research:**
- Academic papers
- Web articles
- Documentation
- Expert insights

**Benefits:**
- Find relevant sources
- Cross-reference ideas
- Synthesize knowledge

---

## Integration Patterns

### Pattern 1: Obsidian + Qdrant
```
Obsidian Notes → Qdrant Vectors
Claude can semantically search your notes
```

### Pattern 2: Telegram + Qdrant Memory
```
Important Telegram Messages → Qdrant
Claude remembers context across sessions
```

### Pattern 3: Web Research Pipeline
```
Puppeteer Scrape → Claude Process → Qdrant Store
Build knowledge base from web research
```

### Pattern 4: Chat History Archive
```
Discord/Telegram History → Qdrant
Semantic search across all conversations
```

---

## Understanding Embeddings

### What are Embeddings?

**Simple explanation:**
Text converted to numbers (vectors) that represent meaning.

**Example:**
- "dog" and "puppy" = similar vectors (close in meaning)
- "dog" and "car" = different vectors (unrelated)

### How Search Works

**Traditional keyword search:**
```
Query: "autonomous vehicle"
Finds: Documents with exact words "autonomous" and "vehicle"
Misses: Documents about "self-driving cars"
```

**Semantic search with Qdrant:**
```
Query: "autonomous vehicle"
Finds: Documents about:
- Self-driving cars
- Autonomous vehicles
- Driverless technology
- AI-powered transportation
```

### Embedding Models

**OpenAI** (default):
- High quality
- Costs money ($0.0001 per 1K tokens)
- Best for production

**Ollama** (free):
- Run locally
- No API costs
- Privacy-first
- Good quality

---

## Cost Management

### OpenAI Costs
**Embedding pricing:**
- ~$0.0001 per 1,000 tokens
- Average document = ~500 tokens = $0.00005
- 10,000 documents = ~$0.50

**Tips to reduce costs:**
1. Use smaller chunks (fewer tokens)
2. Cache embeddings (don't re-embed)
3. Use Ollama for development
4. Switch to OpenAI for production

### Ollama (Free Alternative)

**Setup:**
```bash
# Install Ollama
# Download from: https://ollama.ai/

# Pull embedding model
ollama pull nomic-embed-text

# Run server
ollama serve
```

**Update config:**
```json
"OLLAMA_ENDPOINT": "http://localhost:11434",
"EMBEDDING_MODEL": "nomic-embed-text"
```

---

## Advanced Features

### Metadata Filtering

**Add metadata when storing:**
```
Add to Qdrant with metadata:
{
  "text": "The Principle of Mentalism...",
  "metadata": {
    "category": "hermetic-principles",
    "principle_number": 1,
    "source": "The Kybalion"
  }
}
```

**Search with filters:**
```
Search Qdrant for "consciousness" where category = "hermetic-principles"
```

### Hybrid Search

Combine semantic + keyword:
```
Find documents semantically similar to "automation"
AND containing the word "ethical"
```

---

## Troubleshooting

### "Connection Refused"
**Solutions:**
1. Check Qdrant is running: `docker ps` or check process
2. Verify URL is correct (`localhost:6333`)
3. Check firewall isn't blocking port 6333
4. Try restart: `docker restart qdrant`

### "Invalid API Key"
**Solutions:**
1. Verify OpenAI key is valid
2. Check for typos in config
3. Test key: `curl https://api.openai.com/v1/models -H "Authorization: Bearer YOUR_KEY"`
4. Regenerate if compromised

### "Collection Not Found"
**Solutions:**
1. List collections to verify name
2. Create collection first
3. Check spelling/case

### Slow Performance
**Solutions:**
1. Use batch operations
2. Reduce embedding size
3. Add more RAM to Qdrant
4. Use Qdrant Cloud (optimized)

---

## Best Practices

### Collection Design
- **Separate collections** for different data types
- **Consistent metadata schema** per collection
- **Meaningful names** (not "collection1")
- **Document size**: Aim for 200-500 tokens per doc

### Chunking Strategy
**For long documents:**
- Split into logical sections
- Overlap chunks slightly
- Preserve context
- Store source reference in metadata

**Example:**
```
Long article → Split into paragraphs → Each paragraph = 1 document
Store metadata: {source: "article-title", chunk: 1, total_chunks: 10}
```

### Search Quality
- **Test different similarity thresholds** (0.7 - 0.9)
- **Adjust top-K** based on use case (5-20 results)
- **Use filters** to narrow scope
- **Re-rank results** if needed

---

## Resources
- **Qdrant Docs**: https://qdrant.tech/documentation/
- **MCP Package**: https://www.npmjs.com/package/better-qdrant-mcp-server
- **Ollama**: https://ollama.ai/
- **OpenAI API**: https://platform.openai.com/docs/
