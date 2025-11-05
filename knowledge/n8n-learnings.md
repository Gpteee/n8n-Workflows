# n8n Development Learnings

This file captures accumulated knowledge about n8n workflow development.

## Format
Each entry: `[ISO Timestamp] - Topic: Learning`

## Entries

[2025-10-20T22:00:00Z] - Repository Setup: Initialized knowledge base for persistent Cursor context. All learnings will be automatically captured here.

[2025-10-22T00:00:00Z] - Complex Workflow Architecture: Created comprehensive automated documentation workflow with multi-repository support. Key learnings:
- Split complex workflows into logical processing batches using splitInBatches node
- Use function nodes for data transformation and tech stack detection
- Implement proper error handling with conditional branches
- Structure AI prompts for consistent documentation output
- Integrate multiple data stores (PostgreSQL, Redis) for logging and caching
- Design webhook responses for both success and error cases

[2025-10-22T00:00:00Z] - AI Integration Patterns: Successfully integrated Claude AI for documentation generation:
- Use structured prompts with clear sections and formatting requirements
- Limit token usage with maxTokens parameter (4000 for comprehensive docs)
- Set temperature to 0.3 for consistent, factual output
- Parse AI responses systematically to extract multiple document types
- Handle AI response structure variations gracefully

[2025-10-22T00:00:00Z] - Multi-Service Integration: Developed pattern for connecting multiple external services:
- GitHub for repository analysis and documentation commits
- PostgreSQL for audit logging and analytics
- Redis for performance caching and status tracking
- Slack for team notifications
- Anthropic for AI-powered content generation

[2025-10-22T00:00:00Z] - Tech Stack Detection: Implemented automated technology detection:
- Analyze file structure patterns (package.json, requirements.txt, Dockerfile)
- Detect modern tools (Supabase, Lovable, Cursor) by configuration files
- Categorize technologies by type (frontend, backend, database, deployment, tools)
- Use detection results to customize documentation content

<!-- New learnings will be appended below -->