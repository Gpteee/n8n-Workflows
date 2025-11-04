# Modified AI Video Generation Workflow - No Seedance/Wavespeed/Fal AI

## Overview

This modified workflow replaces the original dependencies (Seedance, Wavespeed AI, and Fal AI) with alternative services that provide similar functionality.

## Original vs Modified Services

| Component | Original | Modified | Reason |
|-----------|----------|----------|--------|
| Video Generation | Seedance via Wavespeed AI | **Replicate (Luma AI)** | More accessible API, competitive pricing |
| Sound Generation | Fal AI (MMAudio) | **Replicate (AudioCraft)** | Unified platform, open-source models |
| Video Stitching | Fal AI (FFmpeg API) | **Replicate FFmpeg** or **Self-hosted** | Multiple options available |

---

## Modified Workflow Architecture

### Step 1: Video Idea Generation (Unchanged)
- **OpenAI GPT-4.1/GPT-5**: Generates creative concepts
- **Google Sheets**: Logs ideas and metadata

### Step 2: Video Clip Generation (Modified)
- **Replicate Luma AI Dream Machine**
  - Endpoint: `lumalabs/luma-photon`
  - Model version: Latest stable
  - Input: Text prompt (scene description)
  - Output: 9:16 video clip (10 seconds)
  - Pricing: ~$0.08-0.10 per generation

### Step 3: Sound Generation (Modified)
- **Replicate AudioCraft (Meta)**
  - Model: `meta/musicgen-large` or `facebook/audio-craft`
  - Input: Text description of sound
  - Output: 10-second audio file
  - Pricing: ~$0.003 per second

### Step 4: Video Stitching (Modified)
- **Option A: Replicate FFmpeg** (recommended for cloud)
- **Option B: Self-hosted FFmpeg** (recommended for cost savings)

### Step 5: Social Media Publishing (Unchanged)
- Blotato multi-platform upload

---

## Setup Instructions

### 1. Get Replicate API Key

1. Go to [Replicate.com](https://replicate.com)
2. Sign up or log in
3. Navigate to Account Settings → API Tokens
4. Create a new token and copy it

### 2. Configure n8n Credentials

#### Create Replicate HTTP Header Auth:
1. In n8n, go to **Credentials** → **New**
2. Select **HTTP Header Auth**
3. Configure:
   - **Name**: `Replicate API`
   - **Header Name**: `Authorization`
   - **Header Value**: `Bearer YOUR_REPLICATE_API_TOKEN`
4. Save

### 3. Import Modified Workflow

1. Open n8n
2. Click **Import** → **From File**
3. Select `modified-workflow-replicate.json`
4. Configure credentials for each node

### 4. Update Credential IDs

Replace the placeholder credential ID `REPLICATE_AUTH_ID` in these nodes:
- Generate Video Clips (Replicate Luma AI)
- Retrieve Video Clips
- Generate ASMR Sound (Replicate AudioCraft)
- Retrieve Final Sound Output
- Merge Clips into Final Video (Replicate FFmpeg)
- Retrieve Final Merged Video

---

## Alternative Video Generation Models

If Luma AI doesn't meet your needs, you can use these alternatives on Replicate:

### Option 1: Minimax (Faster, Lower Cost)
```json
{
  "version": "minimax-latest-version-id",
  "input": {
    "prompt": "your prompt here",
    "aspect_ratio": "9:16"
  }
}
```

### Option 2: Runway Gen-3 (Cinematic Quality)
```json
{
  "version": "runway-gen3-version-id",
  "input": {
    "prompt": "your prompt here",
    "duration": 10,
    "resolution": "1080p"
  }
}
```

### Option 3: Kling AI
```json
{
  "version": "kling-version-id",
  "input": {
    "prompt": "your prompt here",
    "aspect_ratio": "9:16"
  }
}
```

---

## Alternative Audio Generation

### Option 1: ElevenLabs Sound Effects (Premium)
- Better quality for specific sound effects
- More expensive (~$0.10 per generation)
- Setup:
  ```javascript
  // HTTP Request Node
  URL: https://api.elevenlabs.io/v1/sound-generation
  Method: POST
  Auth: API Key in header
  Body: {
    "text": "sound description",
    "duration_seconds": 10
  }
  ```

### Option 2: Suno AI (Music & Ambient)
- Better for background music
- Currently no official API (use Replicate wrapper)

### Option 3: Replicate MusicGen
- Open-source alternative
- Model: `meta/musicgen-large`
- Good for ambient sounds and simple effects

---

## Video Stitching Options

### Option A: Replicate FFmpeg (Cloud-based)

**Pros:**
- No infrastructure needed
- Scales automatically
- Simple API

**Cons:**
- Costs per execution
- Dependent on third-party

**Implementation:**
```javascript
// Find an FFmpeg model on Replicate
// Example: video-concat or ffmpeg-api models
{
  "version": "ffmpeg-model-version-id",
  "input": {
    "video_urls": ["url1", "url2", "url3"],
    "audio_url": "audio_url",
    "output_format": "mp4"
  }
}
```

### Option B: Self-hosted FFmpeg (Cost-effective)

**Pros:**
- No API costs
- Full control
- Faster for local execution

**Cons:**
- Requires n8n self-hosted
- Need to install FFmpeg

**Implementation:**
See `alternative-ffmpeg-node.json` for complete node configuration.

**Quick Setup:**
```bash
# Install FFmpeg on your n8n server
sudo apt-get install ffmpeg

# Test installation
ffmpeg -version
```

**n8n Execute Command Node:**
```javascript
// Command to concatenate videos and add audio
ffmpeg -i video1.mp4 -i video2.mp4 -i video3.mp4 -i audio.mp3 \
  -filter_complex "[0:v][1:v][2:v]concat=n=3:v=1:a=0[outv]" \
  -map "[outv]" -map 3:a -c:v libx264 -c:a aac output.mp4
```

---

## Cost Comparison

### Original Workflow (Seedance + Fal AI)
- Video clips (3x): ~$0.45-0.90
- Sound generation: ~$0.05
- Video stitching: ~$0.02
- **Total per video: ~$0.52-0.97**

### Modified Workflow (Replicate - All Cloud)
- Video clips (3x Luma): ~$0.24-0.30
- Sound generation: ~$0.03
- Video stitching: ~$0.01-0.05
- **Total per video: ~$0.28-0.38**
- **Savings: ~40-60%**

### Modified Workflow (Replicate + Self-hosted FFmpeg)
- Video clips (3x Luma): ~$0.24-0.30
- Sound generation: ~$0.03
- Video stitching: ~$0.00 (self-hosted)
- **Total per video: ~$0.27-0.33**
- **Savings: ~50-66%**

---

## Alternative Complete Solutions

If Replicate doesn't work for you, consider these alternatives:

### Option 1: Runway ML + ElevenLabs + Self-hosted FFmpeg
- **Video**: Runway ML direct API
- **Audio**: ElevenLabs Sound Effects
- **Stitching**: Self-hosted FFmpeg
- **Cost**: Higher quality, higher price (~$1-2 per video)

### Option 2: Leonardo AI + AudioCraft + Cloudinary
- **Video**: Leonardo AI Motion API
- **Audio**: Hugging Face AudioCraft
- **Stitching**: Cloudinary video transformations
- **Cost**: Moderate (~$0.40-0.70 per video)

### Option 3: Stability AI + Replicate Audio + AWS MediaConvert
- **Video**: Stable Video Diffusion
- **Audio**: Replicate AudioCraft
- **Stitching**: AWS MediaConvert
- **Cost**: Enterprise-grade (~$0.50-1.00 per video)

---

## Replicate Model Version IDs

You'll need to get the latest version IDs from Replicate. Here's how:

### Method 1: Via Replicate Website
1. Go to https://replicate.com/explore
2. Search for the model (e.g., "luma-photon")
3. Click on the model
4. Copy the version ID from the API tab

### Method 2: Via API
```bash
curl -s "https://api.replicate.com/v1/models/lumalabs/luma-photon" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" | jq -r '.latest_version.id'
```

### Current Recommended Models (as of 2025):

**Video Generation:**
- `lumalabs/luma-photon` - Latest version
- `minimax/video-01` - Latest version
- `runway/gen-3-alpha` - Latest version

**Audio Generation:**
- `meta/musicgen-large:671ac645...` (get latest)
- `facebook/audiocraft:v1.2.0` (get latest)

**Video Processing:**
- Search "ffmpeg" on Replicate for available models

---

## Troubleshooting

### Issue: Replicate API rate limits
**Solution:**
- Add retry logic in HTTP Request nodes
- Increase wait times between batches
- Consider Pro plan for higher limits

### Issue: Video generation timeout
**Solution:**
- Increase wait node duration (currently 4 minutes)
- Check Replicate dashboard for actual completion times
- Consider polling instead of fixed wait

### Issue: Audio doesn't match video length
**Solution:**
- Ensure audio generation duration matches video
- Use FFmpeg to trim/extend audio in stitching step

### Issue: Model version not found
**Solution:**
- Get latest version IDs from Replicate
- Update workflow JSON with new IDs
- Some models update frequently

---

## Testing the Workflow

### 1. Test Video Generation Only
1. Disable all nodes after "Retrieve Video Clips"
2. Run workflow with one scene
3. Check output quality

### 2. Test Audio Generation Only
1. Start from "Generate ASMR Sound"
2. Manually input a test video URL
3. Verify audio quality

### 3. Test Complete Flow
1. Start with manual trigger
2. Use simple test prompt
3. Monitor each step in execution log

---

## Optimization Tips

### 1. Reduce Costs
- Use Minimax instead of Luma for video (faster, cheaper)
- Generate fewer scenes (2 instead of 3)
- Self-host FFmpeg for stitching

### 2. Improve Quality
- Use Runway Gen-3 for critical videos
- Add upscaling step with Replicate ESRGAN
- Use ElevenLabs for premium sound

### 3. Speed Up Execution
- Reduce wait times if models complete faster
- Use polling instead of fixed waits
- Batch process multiple videos

---

## Support and Resources

### Official Documentation
- [Replicate Docs](https://replicate.com/docs)
- [Replicate API Reference](https://replicate.com/docs/reference/http)
- [n8n Docs](https://docs.n8n.io)

### Community
- [Replicate Discord](https://discord.gg/replicate)
- [n8n Community Forum](https://community.n8n.io)

### Video Model Comparison
- [Luma AI Showcase](https://lumalabs.ai/dream-machine)
- [Runway ML Examples](https://runwayml.com/gen-3)
- [Minimax Demos](https://platform.minimax.com)

---

## Next Steps

1. ✅ Import modified workflow
2. ✅ Configure Replicate credentials
3. ✅ Test with one video
4. ⚙️ Optimize for your use case
5. 📊 Monitor costs and quality
6. 🚀 Scale to production

---

## License and Attribution

This modified workflow is based on the original Seedance/Fal AI workflow.

**Modified by:** AI Assistant
**Date:** 2025
**License:** Use according to n8n and service provider terms

---

## Changelog

### Version 1.0 (Current)
- Replaced Seedance/Wavespeed with Replicate Luma AI
- Replaced Fal AI audio with Replicate AudioCraft
- Replaced Fal AI stitching with Replicate FFmpeg
- Added alternative options documentation
- Added cost comparison
- Added troubleshooting guide
