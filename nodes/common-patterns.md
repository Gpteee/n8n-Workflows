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

### AI-Powered Documentation Generation
**Use Case**: Generate comprehensive project documentation using AI
**Nodes Used**:
- `n8n-nodes-base.anthropic` (Claude AI)
- `n8n-nodes-base.function` (data preparation and parsing)
- `n8n-nodes-base.github` (repository analysis and commits)

**Configuration**:
- Anthropic: maxTokens: 4000, temperature: 0.3
- Function: Structured prompt with clear sections
- GitHub: OAuth2 authentication with repo scope

**Example**: Automated Project Documentation Workflow

### Multi-Repository Batch Processing
**Use Case**: Process multiple repositories in a single workflow execution
**Nodes Used**:
- `n8n-nodes-base.splitInBatches` (repository iteration)
- `n8n-nodes-base.function` (batch data preparation)
- `n8n-nodes-base.if` (conditional processing)

**Configuration**:
- SplitInBatches: batchSize: 1 for sequential processing
- Function: Access batch data via $json.batchIndex
- If: Validate data before processing

### Tech Stack Detection Pattern
**Use Case**: Automatically identify project technologies from file structure
**Nodes Used**:
- `n8n-nodes-base.github` (file listing)
- `n8n-nodes-base.function` (analysis logic)

**Configuration**:
- GitHub: List repository files and directories
- Function: Pattern matching on filenames and extensions
- Categories: frontend, backend, database, deployment, tools

### Multi-Database Integration
**Use Case**: Log to PostgreSQL and cache in Redis simultaneously
**Nodes Used**:
- `n8n-nodes-base.postgres` (logging)
- `n8n-nodes-base.redis` (caching)
- `n8n-nodes-base.function` (data formatting)

**Configuration**:
- PostgreSQL: Structured logging with JSONB for complex data
- Redis: TTL-based caching for performance
- Function: Format data for each database's requirements

<!-- New patterns automatically added below -->