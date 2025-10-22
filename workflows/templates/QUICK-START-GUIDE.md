# Quick Start Guide: Project Documentation Automation

## 🚀 5-Minute Setup

### Step 1: Get API Keys
```bash
# Claude API (required)
# Visit: https://console.anthropic.com/
export CLAUDE_API_KEY="sk-ant-api..."

# GitHub Personal Access Token (required)
# Visit: https://github.com/settings/tokens
# Scopes needed: repo, workflow
export GITHUB_TOKEN="ghp_..."

# Supabase (optional)
# Visit: https://app.supabase.com/project/_/settings/api
export SUPABASE_URL="https://xxx.supabase.co"
export SUPABASE_ANON_KEY="eyJ..."
```

### Step 2: Configure n8n Environment
Add to n8n environment variables (Settings → Environments):
```
CLAUDE_API_KEY=sk-ant-api...
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=eyJ...
```

### Step 3: Add GitHub Credentials
1. n8n → Credentials → New Credential
2. Select "GitHub API"
3. Authentication Method: Access Token
4. Paste your `GITHUB_TOKEN`
5. Save as "GitHub account"

### Step 4: Import Workflow
1. Download `project-documentation-automation.json`
2. n8n → Workflows → Import from File
3. Select the downloaded file
4. Click "Save"

### Step 5: Configure Your Repository
Edit the "Merge Triggers" node:

```javascript
// Find this line and replace with your repo details:
{
  "owner": "your-github-username",
  "repo": "your-repository-name",
  "branch": "main",
  "docPath": ""
}
```

### Step 6: Test Run
1. Click "Execute Workflow" in n8n
2. Wait ~30-60 seconds
3. Check your GitHub repo for updated documentation!

## 📝 What Gets Generated

The workflow creates/updates these files in your repo:
- **README.md** - Project overview, setup, tech stack
- **ARCHITECTURE.md** - System design and components
- **CHANGELOG.md** - Recent updates

## 🔄 Automation Options

### Option A: Schedule (Set and Forget)
Already configured! Runs every 6 hours automatically.

**To change frequency:**
1. Edit "Schedule Trigger" node
2. Modify interval (e.g., 12 hours, daily, weekly)
3. Save workflow

### Option B: GitHub Webhook (On Every Commit)
1. Copy webhook URL from "GitHub Webhook" node
2. GitHub repo → Settings → Webhooks → Add webhook
3. Paste URL, select "push" events
4. Save

### Option C: Manual API Call
```bash
curl -X POST https://your-n8n-url.com/webhook/doc-update \
  -H "Content-Type: application/json" \
  -d '{
    "repositories": [{
      "owner": "username",
      "repo": "project-name",
      "branch": "main",
      "docPath": ""
    }]
  }'
```

## 🎯 For Multiple Repositories

To track multiple repos, send array in webhook:

```bash
curl -X POST https://your-n8n-url.com/webhook/doc-update \
  -H "Content-Type: application/json" \
  -d '{
    "repositories": [
      {"owner": "you", "repo": "frontend", "branch": "main"},
      {"owner": "you", "repo": "backend", "branch": "main"},
      {"owner": "you", "repo": "mobile", "branch": "develop"}
    ]
  }'
```

**Note:** Current version processes first repo. For parallel processing:
1. Add "Split In Batches" node after "Load Configuration"
2. Set batch size to 1
3. Enable loop

## 🛠️ Customization Ideas

### Change Documentation Style
Edit "Prepare Claude Prompt" node → modify the prompt template

### Add More Files
Update Claude prompt to request additional files:
- CONTRIBUTING.md
- API.md
- DEPLOYMENT.md

### Add Notifications
After "Respond to Webhook" node, add:
- **Slack** node → Team notifications
- **Discord** node → Community updates
- **Email** node → Stakeholder reports

### Filter Commits
In "Analyze Project Structure" node:
```javascript
// Only analyze commits from last 24 hours
const yesterday = new Date(Date.now() - 86400000);
const recentCommits = commits.filter(c => 
  new Date(c.commit.author.date) > yesterday
);
```

## 🐛 Common Issues

**"GitHub authentication failed"**
- Re-check GitHub token in credentials
- Verify token has `repo` scope
- Try regenerating token

**"Claude API error"**
- Check `CLAUDE_API_KEY` is set
- Verify API quota isn't exhausted
- Test key: `curl https://api.anthropic.com/v1/messages -H "x-api-key: $CLAUDE_API_KEY"`

**"No documentation generated"**
- Check n8n execution logs
- Verify repository name/owner are correct
- Ensure branch exists

**"Workflow times out"**
- Large repos may take longer
- Increase n8n workflow timeout in settings
- Consider splitting into smaller batches

## 📊 Monitoring

### Check Workflow Health
- n8n → Workflow → Executions tab
- Look for green (success) or red (error) indicators

### View Documentation History (if using Supabase)
```sql
SELECT repository, file, updated_at, trigger_source
FROM documentation_history
ORDER BY updated_at DESC
LIMIT 10;
```

### GitHub Commit History
```bash
git log --all --grep="automated documentation"
```

## 🎓 Next Steps

1. **Review generated documentation** - Make manual edits if needed
2. **Customize prompt** - Tailor to your project's style
3. **Add team workflows** - Extend with your custom nodes
4. **Set up monitoring** - Add Slack/Discord notifications
5. **Document learnings** - Update this knowledge base!

## 💡 Pro Tips

- **First run may be slow** - Claude analyzes entire repo structure
- **Review before autopilot** - Test a few runs before full automation
- **Version control matters** - All doc changes are git commits, fully reversible
- **Customize for your stack** - Update tech stack in prompt for better results
- **Use with CI/CD** - Trigger via webhook in GitHub Actions

## 📚 Resources

- [Full Documentation](./PROJECT-DOCUMENTATION-AUTOMATION-README.md)
- [n8n Documentation](https://docs.n8n.io)
- [Claude API Docs](https://docs.anthropic.com)
- [GitHub API Reference](https://docs.github.com/rest)

---

**Need help?** Check the troubleshooting section in the full README or review the workflow's execution logs in n8n.
