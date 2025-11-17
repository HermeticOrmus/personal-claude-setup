# Obsidian MCP

## Overview
Obsidian MCP connects Claude to your Obsidian vault, enabling AI-powered note management, searching, and knowledge base interaction.

## Status
⏳ **Pending Setup** - Requires Obsidian Local REST API plugin

## Configuration
- **Package**: `obsidian-mcp-server` (npm)
- **API Key**: Generated in Obsidian plugin
- **Base URL**: `http://localhost:27124` (default)

---

## Setup Steps

### 1. Install Obsidian Local REST API Plugin

**In Obsidian:**
1. **Open Settings** → **Community Plugins**
2. **Disable Safe Mode** (if enabled)
3. **Browse Community Plugins**
4. **Search for** "Local REST API"
5. **Install and Enable** the plugin

### 2. Generate API Key

**In Plugin Settings:**
1. Go to **Settings** → **Local REST API**
2. Click **Generate API Key**
3. **Copy the API key** (shown only once!)
4. Note the **port number** (usually `27124`)

### 3. Update Claude Config

Replace in `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`:

```json
"OBSIDIAN_API_KEY": "YOUR_ACTUAL_API_KEY_HERE"
```

With your actual API key from step 2.

### 4. Restart Claude Desktop

Close and reopen Claude Desktop for changes to take effect.

---

## Capabilities

### Note Management
- **List notes** in vault
- **Read note** content
- **Create new notes**
- **Update existing notes**
- **Delete notes**
- **Rename notes**

### Search & Discovery
- **Search notes** by content
- **Search by tags**
- **Search by frontmatter**
- **Full-text search** across vault

### Organization
- **List folders**
- **Create folders**
- **Manage tags**
- **Update frontmatter**
- **Link management**

### Advanced Features
- **Backlink tracking**
- **Graph analysis**
- **Daily notes integration**
- **Template application**

---

## Usage Examples

### Create a Note
```
Create a new Obsidian note called "Project Ideas" with this content:
# Project Ideas
- Build MCP automation system
- Learn Hermetic principles
- Practice Gold Hat development
```

### Search Notes
```
Search my Obsidian vault for notes containing "automation"
```

### Update Note
```
Add this task to my "TODO" note in Obsidian:
- [ ] Set up Qdrant vector database
```

### Read Daily Note
```
Show me today's daily note from Obsidian
```

### Tag Management
```
List all notes in Obsidian tagged with #projects
```

---

## Gold Hat Guidelines

### ✅ Ethical Use
- Personal knowledge management
- Research organization
- Creative ideation
- Learning documentation
- Journal/reflection automation

### ❌ Anti-Patterns
- Don't delete notes without confirmation
- Don't overwrite important content carelessly
- Respect your own note-taking workflow
- Don't automate what should be mindful

---

## Security Notes

### Local-First
- All data stored locally on your machine
- API only accessible from localhost
- No cloud sync required (but compatible with Obsidian Sync if you use it)

### API Key Security
- API key grants full vault access
- Store securely in Claude config
- Don't share or commit to git
- Regenerate if compromised

---

## Integration Patterns

### Knowledge Capture
```
Telegram Message → Claude → Obsidian Note
(Save important messages as notes)
```

### Research Workflow
```
Puppeteer Scrape → Claude Process → Obsidian Note
(Web research to structured notes)
```

### Daily Workflow
```
Discord Discussion → Claude Summarize → Obsidian Daily Note
(Capture team discussions)
```

---

## Troubleshooting

### "Connection Refused" Error
1. Check Obsidian is running
2. Verify Local REST API plugin is enabled
3. Confirm port is 27124 (or update config)
4. Try restarting Obsidian

### "Unauthorized" Error
1. Verify API key is correct
2. Check for typos in config
3. Regenerate API key if needed
4. Restart Claude Desktop

### Notes Not Found
1. Check vault is open in Obsidian
2. Verify note paths/names
3. Use full path if needed
4. Check case sensitivity

---

## Best Practices

### Note Naming
- Use clear, descriptive names
- Consistent naming conventions
- Avoid special characters
- Use folders for organization

### Frontmatter
- Add metadata consistently
- Tag strategically
- Include creation date
- Note status/type

### Search Strategy
- Use specific keywords
- Combine tag + content search
- Leverage backlinks
- Use graph for discovery

---

## Advanced: Obsidian Templates

Create templates in Obsidian and use Claude to apply them:

**Template**: `Templates/Meeting Note.md`
```markdown
---
date: {{date}}
type: meeting
tags: [meetings]
---

# {{title}}

## Attendees
-

## Agenda
-

## Notes
-

## Action Items
- [ ]
```

**Usage:**
```
Create a meeting note for "Project Alpha Standup" using my meeting template
```

---

## Resources
- **Plugin**: https://github.com/coddingtonbear/obsidian-local-rest-api
- **MCP Package**: https://www.npmjs.com/package/obsidian-mcp-server
- **Obsidian**: https://obsidian.md/
