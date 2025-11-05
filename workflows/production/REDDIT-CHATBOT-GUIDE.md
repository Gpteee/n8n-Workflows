# Enhanced Reddit Research Chatbot - Usage Guide

## 🚀 Quick Setup

### Step 1: Import the Workflow
1. Open your n8n instance
2. Go to **Workflows** → **Import from File**
3. Select `reddit-chatbot-enhanced.json`
4. Click **Import**

### Step 2: Configure Credentials
The workflow requires three API credentials:

1. **Reddit OAuth2 API**
   - Go to: https://www.reddit.com/prefs/apps
   - Create a new app (type: web app)
   - Copy Client ID and Secret
   - In n8n: Add Reddit OAuth2 credential with your keys
   
2. **OpenAI API**
   - Get API key from: https://platform.openai.com/api-keys
   - In n8n: Add OpenAI credential
   - Recommended model: `gpt-4o-mini` (fast + cost-effective)

3. **Perplexity API** (Optional - for fallback)
   - Get API key from: https://www.perplexity.ai/settings/api
   - In n8n: Add Perplexity credential

### Step 3: Update Credential IDs
Replace these credential IDs in the workflow with your own:
- `redditOAuth2Api`: `"id": "nVwLKoaJx1iUvpTF"` → Your Reddit credential ID
- `openAiApi`: `"id": "4hoG8Z9NudrR6KTo"` → Your OpenAI credential ID
- `perplexityApi`: `"id": "P33cvUfJXG8YsARr"` → Your Perplexity credential ID

### Step 4: Activate the Workflow
1. Click **Active** toggle in top-right
2. Copy the Chat URL from the **Chat Trigger** node
3. Open the URL to start chatting!

---

## 📊 What's New vs Original Workflow

### ✅ Major Improvements

| Feature | Original | Enhanced |
|---------|----------|----------|
| **Time Filtering** | ❌ None | ✅ Week/Month/Year options |
| **Result Limits** | ❌ Unlimited | ✅ Top 10 default |
| **Scope** | ❌ 2 subreddits only | ✅ All of Reddit |
| **Search Tools** | 3 basic tools | 6 time-filtered tools |
| **System Prompt** | ChatGPT-focused | General Reddit research |
| **Output Format** | Basic | Structured with citations |

### 🎯 Key Features

1. **Time-Filtered Searches**
   - Last Week (top posts from past 7 days)
   - Last Month (past 30 days)
   - Last Year (past 12 months)
   - All Time (best ever)

2. **Multiple Search Strategies**
   - **Relevance**: Best keyword match
   - **Top**: Highest upvoted posts
   - **Hot**: Currently trending
   - **Time-based**: Filtered by recency

3. **Smart Tool Selection**
   - AI automatically picks the right search tool based on your query
   - Detects time phrases: "last month", "this week", "recently"
   - Falls back to Perplexity for non-Reddit questions

4. **Structured Output**
   - Includes upvote counts
   - Direct Reddit links
   - Subreddit tags
   - Timestamps
   - Top 10 ranking

---

## 💬 Example Queries

### Finding Tools/Products
```
"Best AI tools for productivity from the last month"
```
**What happens:**
- Uses "Search Last Month" tool
- Returns top 10 tools mentioned
- Ranks by frequency + upvotes
- Includes source links

### Trending Topics
```
"What's trending in r/MachineLearning right now?"
```
**What happens:**
- Uses "Search Hot" tool
- Filters to r/MachineLearning
- Returns current hot discussions
- Shows upvote/comment counts

### Time-Specific Research
```
"Most discussed Python frameworks this year"
```
**What happens:**
- Uses "Search Last Year" tool
- Aggregates framework mentions
- Ranks by community engagement
- Lists top 10 results

### General Subreddit Search
```
"Top discussions about NextJS in r/webdev"
```
**What happens:**
- Uses "Search by Relevance"
- Limited to r/webdev subreddit
- Returns top 10 relevant posts
- Includes summaries

### Comparison Queries
```
"React vs Vue - what does Reddit prefer in 2024?"
```
**What happens:**
- Uses "Search Last Year"
- Searches both frameworks
- Aggregates sentiment
- Provides comparison data

---

## 🔧 Customization Options

### Change Result Limit
In each Reddit tool node, find:
```json
"limit": 10
```
Change to any number (1-100)

### Modify Time Periods
Current options in `time` field:
- `"hour"` - Last hour
- `"day"` - Last 24 hours  
- `"week"` - Last 7 days
- `"month"` - Last 30 days
- `"year"` - Last 12 months
- `"all"` - All time

### Change Default Search
Modify `sort` field:
- `"relevance"` - Best keyword match
- `"hot"` - Currently trending
- `"top"` - Highest votes
- `"new"` - Most recent
- `"comments"` - Most discussed

### Adjust AI Temperature
In OpenAI Chat Model node:
```json
"temperature": 0.7
```
- Lower (0.3): More focused, deterministic
- Higher (0.9): More creative, varied

### Switch AI Model
Current: `gpt-4o-mini` (recommended)

Alternatives:
- `gpt-4o` - More powerful, slower, pricier
- `gpt-3.5-turbo` - Faster, cheaper, less capable

---

## 📋 Troubleshooting

### "No results found"
**Causes:**
- Keywords too specific
- Time filter too narrow
- Subreddit has limited content

**Solutions:**
- Broaden search terms
- Extend time period
- Search "allReddit" instead of specific subreddit

### "Rate limit exceeded"
**Cause:** Reddit API limits (60 requests/minute)

**Solutions:**
- Wait 1 minute between queries
- Add delay in workflow (Wait node)
- Upgrade to Reddit Premium API

### "Credential error"
**Solutions:**
- Verify API keys are correct
- Check credential IDs match in JSON
- Ensure Reddit app has correct redirect URI

### Slow responses
**Causes:**
- Large result sets
- Multiple tool calls
- API latency

**Solutions:**
- Reduce result limit to 5-10
- Use faster AI model (gpt-3.5-turbo)
- Filter to specific subreddits

---

## 🎓 Advanced Usage

### Search Multiple Subreddits
```
"Search r/python, r/learnpython for beginner tutorials"
```
AI will make multiple calls and aggregate results.

### Get Comment Analysis
```
"What are the top comments saying about [topic]?"
```
AI will retrieve post comments (future enhancement: add dedicated comment node)

### Trend Analysis Over Time
```
"Compare mentions of [tool] - last month vs last year"
```
AI will use multiple time filters and compare results.

### Extract Specific Data
```
"List only the product names mentioned, no descriptions"
```
AI will parse results and format as simple list.

---

## 🔐 Security Notes

- **Chat is PUBLIC** by default (see `"public": true` in Chat Trigger)
- To make private: Change to `"public": false`
- Add authentication via n8n webhook settings
- Never expose API keys in system prompts
- Use environment variables for sensitive data

---

## 📈 Performance Tips

1. **Use specific subreddits** when possible (faster than "allReddit")
2. **Limit time ranges** (narrower = faster queries)
3. **Cache frequent searches** (add Redis/Memory node)
4. **Reduce conversation memory** if hitting token limits
5. **Use gpt-4o-mini** over gpt-4o (5x faster, 20x cheaper)

---

## 🚀 Future Enhancements

Ideas for extending the workflow:

1. **Comment Retrieval Node**
   - Add Reddit "Get Post Comments" node
   - Analyze comment sentiment
   - Extract top comment insights

2. **Multi-Subreddit Parallel Search**
   - Add Split in Batches node
   - Search multiple subreddits simultaneously
   - Merge and rank results

3. **Result Caching**
   - Add Redis/Memory node
   - Cache popular queries
   - Reduce API calls

4. **Sentiment Analysis**
   - Add sentiment classification
   - Detect positive/negative discussions
   - Track community mood

5. **Data Export**
   - Add Google Sheets integration
   - Auto-export research findings
   - Create weekly trend reports

6. **Web Scraping Fallback**
   - Add HTTP Request node
   - Scrape Reddit if API fails
   - Use Cheerio for parsing

---

## 📞 Support

- **n8n Community**: https://community.n8n.io
- **n8n Docs**: https://docs.n8n.io
- **Reddit API Docs**: https://www.reddit.com/dev/api

---

## 📄 License

This workflow is provided as-is for personal and commercial use.

**Created:** 2025-10-24  
**Version:** 1.0  
**Compatibility:** n8n v1.0+
