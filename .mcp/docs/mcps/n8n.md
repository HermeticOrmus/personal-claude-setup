# n8n MCP

## Overview
n8n MCP provides AI-powered access to your n8n workflow automation platform, enabling Claude to build, trigger, and manage workflows through natural language.

## Status
✅ **Active** - Connected to cloud instance

## Configuration
- **API Key**: Configured via `N8N_API_KEY`
- **Base URL**: `https://ormus.app.n8n.cloud`
- **Package**: `n8n-mcp` (npm)

## Capabilities

### Workflow Management
- List all workflows
- Get workflow details
- Create new workflows
- Update existing workflows
- Activate/deactivate workflows
- Delete workflows

### Execution
- Trigger workflows manually
- Pass parameters to workflows
- Get execution results
- Check execution status
- View execution history

### Node Knowledge
- Access 525+ n8n node documentation
- Get node properties and operations
- Understand workflow patterns
- Build workflows from descriptions

## Usage Examples

### List Workflows
```
Show me all my active n8n workflows
```

### Trigger Workflow
```
Trigger my "Daily Report Generator" n8n workflow
```

### Create Workflow
```
Create an n8n workflow that:
1. Monitors a Google Sheet for new rows
2. Sends data to Airtable
3. Notifies me on Telegram
```

### Get Execution Status
```
Check the status of my last n8n workflow execution
```

## Gold Hat Guidelines

### ✅ Ethical Use
- Automate legitimate business processes
- Create transparent data pipelines
- Build consent-based integrations
- Sync your own data across platforms
- Notification systems that respect attention

### ❌ Prohibited
- Scraping without permission
- Automated spam systems
- Dark pattern workflows
- Data harvesting without consent
- Circumventing platform limits

## Workflow Categories

### Data Integration
- Sync databases
- ETL pipelines
- Data transformation
- API orchestration

### Notifications
- Event-driven alerts
- Status updates
- Report distribution
- Reminder systems

### Content Management
- Social media automation
- Content distribution
- Publishing workflows
- Media processing

### Business Automation
- Invoice processing
- Customer onboarding
- Order fulfillment
- Report generation

## Data Storage
- Workflow exports: `C:\Users\ormus\.mcp\workflows\n8n\`
- Templates: `C:\Users\ormus\.mcp\workflows\templates\`
- Logs: `C:\Users\ormus\.mcp\data\logs\n8n.log`

## Best Practices

### Workflow Design
1. **Start simple** - Single trigger, clear path
2. **Error handling** - Always add error nodes
3. **Test thoroughly** - Use test data first
4. **Document** - Add notes to complex nodes
5. **Version control** - Export workflows regularly

### Performance
- Use batch operations when possible
- Implement rate limiting
- Set reasonable intervals
- Monitor execution times

## Security Notes
- API key stored in Claude config
- Key has full n8n access
- Rotate keys quarterly
- Review workflow permissions
- No secrets in workflow exports

## Backup Strategy

### Export Workflows
```bash
# Export all workflows regularly
Save to: C:\Users\ormus\.mcp\workflows\n8n\backup\
```

### Version Control
- Export before major changes
- Tag versions meaningfully
- Keep old versions for rollback

## Integration Patterns

### n8n as Orchestrator
```
Telegram → n8n → [Process] → Discord
```

### n8n as Data Bridge
```
Google Sheets → n8n → Airtable → Slack
```

### n8n as Scheduler
```
Cron Trigger → n8n → [Multiple actions]
```

See: `.mcp/integrations/patterns/n8n-workflows.md`

## Troubleshooting

### "Unauthorized" error
- Check API key is valid
- Verify key permissions
- Regenerate if compromised

### "Workflow not found"
- Check workflow is activated
- Verify workflow name/ID
- Ensure not deleted

### Execution fails
- Check node credentials
- Review error logs in n8n UI
- Test individual nodes

## Resources
- n8n Documentation: https://docs.n8n.io/
- n8n Cloud: https://ormus.app.n8n.cloud
- MCP Package: https://www.npmjs.com/package/n8n-mcp
- Community Forum: https://community.n8n.io/
