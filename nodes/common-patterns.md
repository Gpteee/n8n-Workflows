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