# Validate n8n Workflow

Validation protocol for workflow JSON:

1. **Parse JSON**: Verify valid JSON structure
2. **Check Nodes**: Verify each node:
   - Node type exists in n8n (query n8n-mcp if uncertain)
   - All required parameters present
   - Parameter types match schema
3. **Check Connections**: Validate all node connections reference existing nodes
4. **Check Credentials**: Identify required credentials (don't validate values)
5. **Report**: List any issues found with specific line numbers
6. **Fix**: If issues found, correct them using n8n-mcp data

Execute completely without asking permission.