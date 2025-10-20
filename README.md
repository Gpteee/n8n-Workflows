# n8n Workflows Knowledge Base

Persistent knowledge repository for n8n workflow development, automatically indexed by Cursor IDE.

## Purpose
This repository serves as external memory for AI-assisted n8n development. All workflow patterns, learnings, and decisions are captured here and automatically available in every Cursor session.

## Structure
```
.cursor/
├── rules.md              # Core Cursor instructions (auto-read)
└── commands/             # Reusable agent commands
workflows/
├── templates/            # Reusable workflow templates
├── production/            # Live, tested workflows
└── experiments/          # Development/testing workflows
nodes/
├── common-patterns.md    # Proven node usage patterns
└── custom-configs.md     # Project-specific configurations
knowledge/
├── n8n-learnings.md      # Accumulated knowledge
├── workflow-decisions.md # Architectural decisions
└── troubleshooting.md    # Issue resolutions
```

## Usage with Cursor

### Setup
1. Clone this repo into your workspace
2. Configure n8n-mcp server in Cursor (see `.cursor/rules.md`)
3. Open repo in Cursor - it will automatically index all content

### Workflow Development
Use slash commands in Cursor Agent:
- `/create-workflow` - Generate new workflow from requirements
- `/validate-workflow` - Check workflow JSON validity
- `/debug-workflow` - Troubleshoot workflow issues
- `/save-knowledge` - Commit current session learnings

### Automatic Knowledge Capture
After any n8n task, Cursor automatically:
- Extracts learnings from the session
- Updates relevant knowledge files
- Commits changes with descriptive messages
- Pushes to GitHub

## Integration

This repository integrates with:
- **n8n-mcp**: Live node documentation and templates
- **Cursor IDE**: Automatic context loading
- **GitHub**: Version-controlled knowledge base

## Maintenance

The repository self-maintains through AI agents. Manual updates needed only for:
- Major architectural decisions
- Project-specific configurations
- Repository structure changes

## Current Status

**Last Updated**: [Auto-populated]
**Active Workflows**: [Auto-populated]
**Total Learnings Captured**: [Auto-populated]