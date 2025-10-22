# Common n8n Node Patterns

Reusable node configurations and patterns that have proven effective.

## Pattern Format
```
### Pattern Name
**Use Case**: [When to use this]
**Nodes Used**: [List of nodes]
**Configuration**: [Key settings]
**Example**: [JSON snippet or workflow ID]
```

## Patterns

### Basic Webhook → Process → Response
**Use Case**: Simple API endpoint
**Nodes Used**: 
- `n8n-nodes-base.webhook` (trigger)
- `n8n-nodes-base.function` (process)
- `n8n-nodes-base.respondToWebhook` (response)

**Configuration**: 
- Webhook: POST method, return response from last node
- Function: Transform incoming data
- Respond: Send processed result

<!-- New patterns automatically added below -->

### GitHub Repository Analysis Pattern
**Use Case**: Analyze GitHub repository structure and recent activity
**Nodes Used**:
- `n8n-nodes-base.github` (multiple instances)
- `n8n-nodes-base.code` (analysis)

**Configuration**:
1. Get Recent Commits: operation=getAll, limit=50
2. Get Current README: resource=file, operation=get
3. List Repository Files: resource=file, operation=list
4. Code node merges all data with $input.all()

**Key Points**:
- Use `__rl: true` for resource locator fields (owner, repository)
- FilePath format: `{branch}:{path}` for file operations
- README content comes base64-encoded, requires decoding

### AI Documentation Generation Pattern
**Use Case**: Generate documentation using Claude API
**Nodes Used**:
- `n8n-nodes-base.set` (prompt preparation)
- `n8n-nodes-base.httpRequest` (API call)
- `n8n-nodes-base.code` (response parsing)

**Configuration**:
- API URL: https://api.anthropic.com/v1/messages
- Headers: x-api-key, anthropic-version (2023-06-01)
- Model: claude-3-5-sonnet-20241022
- Max tokens: 4000+ for long documentation

**Key Points**:
- Use JSON.stringify() for prompt in JSON body
- Response extraction: response.content[0].text
- Parse structured output with regex or JSON.parse()

### Dual Storage Pattern
**Use Case**: Store results in both git repository and database
**Nodes Used**:
- `n8n-nodes-base.github` (file edit)
- `n8n-nodes-base.httpRequest` (Supabase)

**Configuration**:
- GitHub: resource=file, operation=edit
- Supabase: POST to /rest/v1/{table}
- Both execute in parallel from same data

**Key Points**:
- GitHub commits are permanent - Supabase enables rollback
- Use same timestamp for both operations
- Conventional commit format: "docs: Update {file} - automated"