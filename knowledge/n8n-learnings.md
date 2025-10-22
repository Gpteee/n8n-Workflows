# n8n Development Learnings

This file captures accumulated knowledge about n8n workflow development.

## Format
Each entry: `[ISO Timestamp] - Topic: Learning`

## Entries

[2025-10-20T22:00:00Z] - Repository Setup: Initialized knowledge base for persistent Cursor context. All learnings will be automatically captured here.

<!-- New learnings will be appended below -->

[2025-10-22T00:00:00Z] - Dual Triggers: Combining Schedule Trigger and Webhook nodes enables both automated and on-demand workflow execution. Use "Merge" or "Set" node to normalize data from different trigger sources.

[2025-10-22T00:00:00Z] - GitHub File Operations: The GitHub node's file operations require base64 encoding for content retrieval but accept plain text for updates. Use Buffer.from(content, 'base64').toString('utf8') to decode.

[2025-10-22T00:00:00Z] - Claude API Integration: Anthropic's Messages API requires specific headers (x-api-key, anthropic-version). Use HTTP Request node with custom auth. Response structure: { content: [{ text: "..." }] }

[2025-10-22T00:00:00Z] - Code Node for Parsing: When working with complex API responses (like Claude's), use Code node with $input.first().json or $input.all() to access data. Return array of objects for multiple items.

[2025-10-22T00:00:00Z] - Multi-Repo Pattern: To handle multiple repositories, store config as array and either loop with Split In Batches node or process first repo by default. Array structure: [{ owner, repo, branch, docPath }]

[2025-10-22T00:00:00Z] - Supabase Logging: Direct HTTP Request to Supabase REST API works well for simple inserts. Include apikey header and Authorization: Bearer token. Endpoint format: {url}/rest/v1/{table}

[2025-10-22T00:00:00Z] - Environment Variables: n8n supports $env.VARIABLE_NAME syntax in expressions. Best practice: store all API keys, URLs, and sensitive data as environment variables.

[2025-10-22T00:00:00Z] - Webhook Response: Always include respondToWebhook node for webhook-triggered workflows. Provides immediate feedback and prevents timeout issues. Use responseMode: "responseNode" for custom responses.