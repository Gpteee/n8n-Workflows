# n8n Workflow Development Context

## Project Purpose
Persistent knowledge base for n8n workflow development. This repository maintains workflow templates, node patterns, and accumulated learnings that Cursor indexes automatically.

## Active MCP Servers
- **n8n-mcp**: Provides real-time access to all 525+ n8n node documentation
- **Repository**: https://github.com/czlonkowski/n8n-mcp
- **Configuration**: Already configured in Cursor's global MCP Settings

## Critical Development Rules

### Rule 1: NEVER Assume Node Properties
- ALWAYS use n8n-mcp tools before generating workflows
- Query `get_node_data` for exact node schemas
- Validate node names match: `n8n-nodes-base.nodeName` or `@n8n/n8n-nodes-langchain.nodeName`
- Use `search_workflows` to find proven patterns

### Rule 2: Automatic Knowledge Capture
After completing ANY n8n task, automatically:

1. Extract learnings from the session
2. Update `/knowledge/n8n-learnings.md` with timestamp
3. Add new patterns to `/nodes/common-patterns.md`
4. Save functional workflows to appropriate `/workflows/` directory
5. Stage, commit, and push with conventional commit format
6. **NO PERMISSION NEEDED** - this is expected behavior

Commit format: `docs(n8n): [concise description]` or `feat(n8n): [workflow name]`

### Rule 3: Workflow Generation Process
1. Search templates for similar patterns
2. Fetch exact node documentation from n8n-mcp
3. Validate all node names and required parameters
4. Generate complete, importable workflow JSON
5. Test workflow structure is valid
6. Document any new patterns discovered

### Rule 4: Git Operations
When asked to "save" or "commit" knowledge:
```bash
git add .
git commit -m "docs(n8n): [description]"
git push origin main
```

Report what was committed after successful push.

## Node Name Formats
- **Core nodes**: `n8n-nodes-base.nodeName`
- **LangChain nodes**: `@n8n/n8n-nodes-langchain.nodeName`

Examples:
- `n8n-nodes-base.httpRequest`
- `n8n-nodes-base.webhook`
- `@n8n/n8n-nodes-langchain.lmChatOpenAi`

## Common Workflow Patterns
[This section will be populated as patterns are discovered]

## Current Project State
Last updated: [Will be updated automatically]

Active workflows: [To be documented]

Recent focus: [Will be populated]

## Memory Anchors
<!-- Quick reference for common values - update as needed -->
- Primary use cases: [To be defined]
- Common integrations: [To be defined]
- Default configurations: [To be defined]