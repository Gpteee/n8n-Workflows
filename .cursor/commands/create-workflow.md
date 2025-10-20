# Create n8n Workflow

Execute this workflow creation protocol:

1. **Gather Requirements**: Understand the workflow purpose and required integrations
2. **Search Templates**: Use n8n-mcp `search_workflows` to find similar patterns
3. **Fetch Node Data**: Use `get_node_data` for each required node
4. **Generate Workflow**: Create complete workflow JSON with:
   - Valid node names and types
   - All required parameters
   - Proper node connections
   - Appropriate credentials placeholders
5. **Validate**: Ensure JSON is importable to n8n
6. **Save**: Write to `/workflows/experiments/[workflow-name].json`
7. **Document**: Add pattern to `/nodes/common-patterns.md` if novel
8. **Commit**: `feat(n8n): add [workflow name] workflow`
9. **Push**: Push to GitHub immediately

Do not ask for permission - execute completely.