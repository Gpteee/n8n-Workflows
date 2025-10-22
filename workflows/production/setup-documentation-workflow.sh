#!/bin/bash

# Automated Project Documentation Workflow Setup Script
# This script sets up the required database tables and configurations

set -e

echo "🚀 Setting up Automated Project Documentation Workflow..."

# Database configuration
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-project_docs}
DB_USER=${DB_USER:-postgres}

# Redis configuration
REDIS_HOST=${REDIS_HOST:-localhost}
REDIS_PORT=${REDIS_PORT:-6379}

echo "📊 Creating PostgreSQL database and tables..."

# Create database if it doesn't exist
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "CREATE DATABASE $DB_NAME;" 2>/dev/null || echo "Database $DB_NAME already exists"

# Create the logging table
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME << EOF
-- Create project documentation log table
CREATE TABLE IF NOT EXISTS project_documentation_log (
    id SERIAL PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    repository_name VARCHAR(255) NOT NULL,
    document_type VARCHAR(100) NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    tech_stack JSONB,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_project_docs_project_name ON project_documentation_log(project_name);
CREATE INDEX IF NOT EXISTS idx_project_docs_generated_at ON project_documentation_log(generated_at);
CREATE INDEX IF NOT EXISTS idx_project_docs_status ON project_documentation_log(status);
CREATE INDEX IF NOT EXISTS idx_project_docs_repo_name ON project_documentation_log(repository_name);

-- Create a view for easy querying
CREATE OR REPLACE VIEW project_documentation_summary AS
SELECT 
    project_name,
    repository_name,
    COUNT(*) as total_documents,
    MAX(generated_at) as last_generated,
    array_agg(DISTINCT document_type) as document_types,
    (tech_stack->>'frontend')::jsonb as frontend_tech,
    (tech_stack->>'backend')::jsonb as backend_tech,
    (tech_stack->>'database')::jsonb as database_tech
FROM project_documentation_log 
WHERE status = 'completed'
GROUP BY project_name, repository_name, tech_stack;

-- Insert sample configuration
INSERT INTO project_documentation_log (
    project_name, 
    repository_name, 
    document_type, 
    generated_at, 
    tech_stack, 
    status
) VALUES (
    'setup-test',
    'setup-test-repo',
    'README.md',
    NOW(),
    '{"frontend": ["React"], "backend": ["Node.js"], "database": ["PostgreSQL"]}',
    'completed'
) ON CONFLICT DO NOTHING;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;

EOF

echo "✅ PostgreSQL setup completed"

# Test Redis connection
echo "🔄 Testing Redis connection..."
redis-cli -h $REDIS_HOST -p $REDIS_PORT ping > /dev/null && echo "✅ Redis connection successful" || echo "❌ Redis connection failed"

# Create n8n workflow directory if it doesn't exist
mkdir -p ~/.n8n/workflows

echo "📋 Setup checklist:"
echo "✅ Database tables created"
echo "✅ Indexes and views configured"
echo "✅ Sample data inserted"
echo ""
echo "🔧 Next steps:"
echo "1. Import the workflow JSON into n8n"
echo "2. Configure credentials for:"
echo "   - GitHub OAuth2"
echo "   - Anthropic (Claude AI)"
echo "   - PostgreSQL"
echo "   - Redis"
echo "3. Set up Slack webhook URL in workflow parameters"
echo "4. Test the workflow with a sample repository"
echo ""
echo "📖 For detailed setup instructions, see:"
echo "   workflows/production/automated-project-documentation-README.md"
echo ""
echo "🎉 Setup completed successfully!"