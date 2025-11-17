# MCP Management Hub

> **Sacred Technology Infrastructure**
> Central hub for managing all Model Context Protocol integrations, workflows, and automation architecture.

---

## Purpose

This directory organizes:
- MCP configurations and credentials
- Workflow templates and automation patterns
- Data storage for MCP-related activities
- Documentation and usage examples
- Integration architecture and designs

---

## Directory Structure

```
.mcp/
├── README.md                    # This file
├── config/                      # MCP configurations
│   ├── active/                  # Currently active MCP configs
│   ├── templates/               # Config templates for new MCPs
│   └── backup/                  # Configuration backups
├── workflows/                   # Automation workflows
│   ├── n8n/                     # n8n workflow exports
│   ├── templates/               # Reusable workflow patterns
│   └── scripts/                 # Helper scripts
├── data/                        # MCP data storage
│   ├── telegram/                # Telegram session data
│   ├── whatsapp/                # WhatsApp local database
│   ├── discord/                 # Discord logs and cache
│   └── logs/                    # MCP activity logs
├── docs/                        # Documentation
│   ├── mcps/                    # Per-MCP documentation
│   ├── guides/                  # How-to guides
│   ├── architecture/            # System architecture docs
│   └── examples/                # Usage examples
└── integrations/                # Cross-MCP integrations
    ├── patterns/                # Integration patterns
    ├── bridges/                 # MCP-to-MCP bridges
    └── webhooks/                # Webhook handlers
```

---

## Active MCPs

| MCP | Status | Purpose | Documentation |
|-----|--------|---------|---------------|
| **Telegram** | ✅ Active | Personal messaging automation | [docs/mcps/telegram.md](docs/mcps/telegram.md) |
| **Discord** | ✅ Active | Community & bot management | [docs/mcps/discord.md](docs/mcps/discord.md) |
| **n8n** | ✅ Active | Workflow orchestration | [docs/mcps/n8n.md](docs/mcps/n8n.md) |
| **Puppeteer** | ✅ Active | Browser automation | [docs/mcps/puppeteer.md](docs/mcps/puppeteer.md) |
| **WhatsApp** | ⏳ Pending | Personal messaging (needs Go + QR) | [docs/mcps/whatsapp.md](docs/mcps/whatsapp.md) |
| **Qdrant** | ⏳ Setup | Semantic search & AI memory | [docs/mcps/qdrant.md](docs/mcps/qdrant.md) |
| **GitHub** | ✅ Active | Repository management | [docs/mcps/github.md](docs/mcps/github.md) |
| **Filesystem** | ✅ Active | File operations | Built-in |
| **Memory** | ✅ Active | Knowledge graph | Built-in |

---

## Quick Start

### Adding a New MCP

1. **Research the MCP** in `docs/mcps/`
2. **Copy template** from `config/templates/`
3. **Configure credentials** in Claude config
4. **Document** in `docs/mcps/[mcp-name].md`
5. **Test** and create example in `docs/examples/`

### Creating a Workflow

1. **Design** workflow in `workflows/templates/`
2. **Implement** in n8n or as script
3. **Export** to `workflows/n8n/`
4. **Document** usage and triggers

### Integration Patterns

Common patterns are documented in `integrations/patterns/`:
- Telegram → n8n → Discord (cross-platform notifications)
- Puppeteer → GitHub (automated PRs from web scraping)
- WhatsApp → Telegram (message bridging)

---

## Gold Hat Principles

### ✅ Empowering Architecture
- Transparent data storage (you own it)
- Clear documentation (you understand it)
- Modular design (you can extend it)
- Version control (you can rollback)

### ❌ Anti-Patterns We Reject
- Hidden configuration files
- Unclear data ownership
- Vendor lock-in
- Black box operations

---

## Security & Privacy

### Credential Management
- All tokens stored in Claude config: `C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json`
- **Never commit tokens** to git
- Rotate credentials regularly
- Use `.gitignore` for sensitive files

### Data Ownership
- All data stored **locally** in `.mcp/data/`
- You control retention and deletion
- No cloud sync without explicit consent
- Transparent data formats (JSON, SQLite)

---

## Maintenance

### Regular Tasks
- **Weekly**: Review MCP logs for issues
- **Monthly**: Rotate API tokens if needed
- **Quarterly**: Backup workflows and configs
- **Annually**: Audit MCP usage and remove unused

### Backups
Backup configs before changes:
```bash
xcopy C:\Users\ormus\AppData\Roaming\Claude\claude_desktop_config.json .mcp\config\backup\config-backup-%date%.json
```

---

## Architecture Philosophy

This structure follows **Hermetic Principles**:

### Principle of Correspondence
"As above, so below" - folder structure mirrors conceptual organization

### Principle of Order
Everything has a place, making the system maintainable

### Principle of Transparency
Clear documentation makes the system understandable

---

## Contributing

When adding new MCPs or workflows:

1. **Document thoroughly** - future you will thank you
2. **Test extensively** - verify before documenting
3. **Share patterns** - reusable templates help others
4. **Stay ethical** - Gold Hat principles always

---

## Resources

- **MCP Official Docs**: https://github.com/modelcontextprotocol/servers
- **Awesome MCP Servers**: https://github.com/punkpeye/awesome-mcp-servers
- **n8n Documentation**: https://docs.n8n.io/
- **Hermetic Philosophy**: `C:\Users\ormus\CLAUDE.md`

---

*Built with Sacred Technology principles*
*Organized systems empower conscious automation*

**— Hermetic Ormus**
