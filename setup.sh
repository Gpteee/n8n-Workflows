#!/bin/bash
# Quick n8n Knowledge Base Setup
# Save this file as setup.sh and run: bash setup.sh

set -e
cd "$(git rev-parse --show-toplevel)" || { echo "Error: Not in a git repository"; exit 1; }

echo "🚀 Setting up n8n Knowledge Base..."

# Create directories
mkdir -p .cursor/commands workflows/{templates,production,experiments} nodes knowledge

# Create all files inline
cat > .cursorrules << 'END'
Always read .cursor/rules.md for complete instructions.

Core behavior:
- Query n8n-mcp before any workflow generation
- Automatically capture learnings after tasks
- Commit knowledge updates without asking
- Use conventional commit format
END

cat > README.md << 'END'
# n8n Workflows Knowledge Base
Persistent knowledge repository for n8n workflow development, automatically indexed by Cursor IDE.

## Purpose
This repository serves as external memory for AI-assisted n8n development.

## Structure
See .cursor/rules.md for complete documentation.

## Usage
- `/create-workflow` - Generate workflows
- `/validate-workflow` - Validate workflows  
- `/debug-workflow` - Debug workflows
- `/save-knowledge` - Save learnings
END

# Create placeholder files for all knowledge base components
touch knowledge/{n8n-learnings.md,troubleshooting.md,workflow-decisions.md}
touch nodes/{common-patterns.md,custom-configs.md}
touch .cursor/rules.md
touch .cursor/commands/{create-workflow.md,validate-workflow.md,save-knowledge.md,debug-workflow.md}

echo "✅ Directory structure created"
echo "✅ Placeholder files created"
echo ""
echo "📋 Next: Fill in the file contents (see Claude's response for full content)"
echo "Then run:"
echo "  git add ."
echo "  git commit -m 'feat(n8n): initialize knowledge base'"
echo "  git push origin main"