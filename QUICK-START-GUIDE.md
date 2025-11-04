# Quick Start Guide - Modified Workflow

## 5-Minute Setup

### Step 1: Get Your API Keys (2 minutes)

1. **Replicate API Key**
   - Go to: https://replicate.com/signin
   - Sign up/login
   - Click your avatar → Account Settings
   - Go to API Tokens tab
   - Click "New Token"
   - Copy the token (starts with `r8_...`)

2. **You already have** (verify these):
   - OpenAI API Key
   - Google Sheets credentials
   - Blotato API Key

### Step 2: Import Workflow (1 minute)

1. Open your n8n instance
2. Click **Workflows** → **Import from File**
3. Select `modified-workflow-replicate.json`
4. Click Import

### Step 3: Configure Credentials (2 minutes)

#### A. Create Replicate Credential

1. In n8n, go to **Credentials** → **New**
2. Search for "HTTP Header Auth"
3. Click it and configure:
   ```
   Name: Replicate API
   Header Name: Authorization
   Header Value: Bearer YOUR_REPLICATE_TOKEN_HERE
   ```
4. Click **Save**

#### B. Update All Replicate Nodes

In the imported workflow, update these nodes with your new credential:

- ✅ Generate Video Clips (Replicate Luma AI)
- ✅ Retrieve Video Clips
- ✅ Generate ASMR Sound (Replicate AudioCraft)
- ✅ Retrieve Final Sound Output
- ✅ Merge Clips into Final Video (Replicate FFmpeg)
- ✅ Retrieve Final Merged Video

For each node:
1. Click the node
2. In the **Authentication** section
3. Select your "Replicate API" credential
4. Save

### Step 4: Test the Workflow (1 minute)

1. Click **Execute Workflow** (play button)
2. Watch the execution
3. Check the output in Google Sheets
4. Verify the final video URL

---

## Replicate Model Versions

You need to get the latest model version IDs from Replicate.

### Quick Method: Use Replicate Website

#### For Video Generation (Luma AI):
1. Go to: https://replicate.com/lumalabs/luma-photon
2. Click **API** tab
3. Look for "version": "abc123..."
4. Copy that ID
5. Update in node: "Generate Video Clips (Replicate Luma AI)"
6. Find this line in the JSON body:
   ```json
   "version": "a4a8bafd6089e1716b06057c42b19378250996bd3c59a65be71a2c1e575f5e2c"
   ```
7. Replace with your copied ID

#### For Audio Generation (AudioCraft):
1. Go to: https://replicate.com/meta/musicgen-large
2. Click **API** tab
3. Copy the version ID
4. Update in node: "Generate ASMR Sound (Replicate AudioCraft)"

#### For FFmpeg (if using cloud version):
1. Search on Replicate: "ffmpeg video concat"
2. Choose a suitable model (e.g., ffmpeg-video-concat)
3. Copy version ID
4. Update in node: "Merge Clips into Final Video (Replicate FFmpeg)"

---

## Alternative: Use Latest Models Automatically

Replicate allows you to use model names instead of version IDs (uses latest version):

### Update Video Generation Node:

Instead of:
```json
{
  "version": "specific-version-id",
  "input": { ... }
}
```

Use:
```json
{
  "model": "lumalabs/luma-photon",
  "input": { ... }
}
```

Change URL from:
```
https://api.replicate.com/v1/predictions
```

To:
```
https://api.replicate.com/v1/models/lumalabs/luma-photon/predictions
```

---

## Cost Estimates

### Per Video Generation:

**Using Replicate (Cloud Everything):**
- 3 video clips: $0.24 - $0.30
- 1 audio generation: $0.03
- 1 video stitch: $0.05
- **Total: ~$0.32 - $0.38 per video**

**Using Replicate + Self-hosted FFmpeg:**
- 3 video clips: $0.24 - $0.30
- 1 audio generation: $0.03
- 1 video stitch: $0.00 (free)
- **Total: ~$0.27 - $0.33 per video**

**Monthly Costs (30 videos/day):**
- Cloud: ~$288 - $342/month
- Hybrid: ~$243 - $297/month
- Self-hosted FFmpeg saves: ~$45/month

---

## Troubleshooting

### Error: "Unauthorized" on Replicate calls

**Fix:**
1. Check your API token is correct
2. Verify it starts with `r8_`
3. Make sure "Bearer " is before the token
4. Test token: `curl -H "Authorization: Bearer YOUR_TOKEN" https://api.replicate.com/v1/models`

### Error: "Model version not found"

**Fix:**
1. Get latest version IDs from Replicate
2. Or use model names instead of version IDs
3. Update the workflow nodes

### Error: "Rate limit exceeded"

**Fix:**
1. Wait a few minutes
2. Increase batch intervals in nodes
3. Consider Replicate Pro plan
4. Reduce number of concurrent executions

### Error: Video takes too long

**Fix:**
1. Increase wait time in Wait nodes (currently 4 minutes)
2. Check actual processing time in Replicate dashboard
3. Consider using faster models (Minimax instead of Luma)

### Audio doesn't sync with video

**Fix:**
1. Ensure audio duration = video duration (10 seconds)
2. Check FFmpeg command for audio sync options
3. Add `-shortest` flag to FFmpeg command

---

## Optimization Tips

### To Save Money:
1. ✅ Use self-hosted FFmpeg (saves $0.05 per video)
2. ✅ Reduce from 3 scenes to 2 scenes (saves $0.08-0.10 per video)
3. ✅ Use Minimax instead of Luma (saves $0.03-0.05 per clip)
4. ✅ Batch process videos during off-peak hours

### To Improve Quality:
1. ✅ Use Runway Gen-3 instead of Luma (+$0.10 per clip, better quality)
2. ✅ Use ElevenLabs for audio (+$0.07, much better sound)
3. ✅ Add upscaling step with ESRGAN (+$0.05, higher resolution)
4. ✅ Increase prompt detail in LLM nodes

### To Speed Up:
1. ✅ Use Minimax (2-3x faster than Luma)
2. ✅ Use polling instead of fixed wait times
3. ✅ Process multiple videos in parallel
4. ✅ Pre-generate prompts in batches

---

## Testing Checklist

Before running in production:

- [ ] Test video generation with one scene
- [ ] Verify video quality and aspect ratio (9:16)
- [ ] Test audio generation
- [ ] Verify audio quality and duration (10 seconds)
- [ ] Test video stitching
- [ ] Check final video plays correctly
- [ ] Verify Google Sheets logging
- [ ] Test social media upload to one platform
- [ ] Run complete workflow end-to-end
- [ ] Monitor costs in Replicate dashboard

---

## Common Questions

### Q: Can I use this with n8n Cloud?
**A:** Yes! The Replicate version works perfectly with n8n Cloud. Only the self-hosted FFmpeg option requires self-hosted n8n.

### Q: How long does each video take to generate?
**A:**
- Luma AI: 2-4 minutes per clip
- AudioCraft: 30-60 seconds
- FFmpeg stitching: 10-30 seconds
- **Total: ~7-13 minutes per video**

### Q: Can I use different video models?
**A:** Yes! See the main documentation for alternatives like Minimax, Runway Gen-3, Kling, etc.

### Q: What if Replicate goes down?
**A:** You can switch to alternative services. See the "Alternative Complete Solutions" section in the main guide.

### Q: Can I generate longer videos?
**A:** Yes! Adjust the `duration` parameter in the video generation nodes. Note: costs increase proportionally.

### Q: How do I add more scenes?
**A:** Modify the "Generate Detailed Video Prompts" agent to create more scenes (e.g., Scene 4, Scene 5). The workflow will automatically process them.

---

## Next Steps

1. ✅ Complete the 5-minute setup above
2. ✅ Run a test video
3. 📊 Monitor costs in Replicate dashboard
4. ⚙️ Optimize based on your needs
5. 📚 Read the full documentation (WORKFLOW-MODIFICATION-GUIDE.md)
6. 🚀 Scale to production

---

## Support Resources

- **Replicate Docs**: https://replicate.com/docs
- **n8n Community**: https://community.n8n.io
- **Replicate Discord**: https://discord.gg/replicate
- **Report Issues**: Create an issue in your repo

---

## Quick Reference: API Endpoints

### Replicate API Base
```
https://api.replicate.com/v1
```

### Create Prediction
```
POST /predictions
Body: { "version": "...", "input": {...} }
```

### Get Prediction Status
```
GET /predictions/{prediction_id}
```

### List Models
```
GET /models
```

### Authentication Header
```
Authorization: Bearer r8_YOUR_TOKEN
```

---

**Last Updated:** 2025-01-04
**Workflow Version:** 1.0
**Compatible with:** n8n v1.0+, Replicate API v1
