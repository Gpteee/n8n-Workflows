# n8n Development Learnings

This file captures accumulated knowledge about n8n workflow development.

## Format
Each entry: `[ISO Timestamp] - Topic: Learning`

## Entries

[2025-10-20T22:00:00Z] - Repository Setup: Initialized knowledge base for persistent Cursor context. All learnings will be automatically captured here.

[2025-10-24T00:00:00Z] - Reddit Chatbot Enhancement: Built production-ready Reddit research chatbot with time-filtered searches. Key learnings:
  - Reddit tools support time filtering: hour/day/week/month/year/all
  - AI Agent tool selection requires explicit logic in system prompt
  - Default limit of 10 results prevents overwhelming responses
  - Multiple search strategies (relevance/top/hot) serve different use cases
  - System prompts should match actual tool capabilities (avoid false promises)
  - LangChain AI tools use $fromAI() for dynamic parameter extraction
  - Chat Trigger webhookId should be descriptive for easy identification

<!-- New learnings will be appended below -->