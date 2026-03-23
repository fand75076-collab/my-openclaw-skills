---
name: opencli
description: Universal CLI Hub - Turn any website, Electron app, or local tool into a command-line interface
metadata: {"clawdbot":{"emoji":"🔧","requires":{"commands":["opencli"]},"homepage":"https://github.com/jackwener/opencli"}}
---

# OpenCLI Skill

Make any website, Electron app, or local tool your CLI. AI-native runtime with browser session reuse.

## Installation

```bash
# Via npm (recommended)
npm install -g @jackwener/opencli

# Via source
git clone git@github.com:jackwener/opencli.git
cd opencli
npm install
npm run build
npm link

# Upgrade
npm install -g @jackwener/opencli@latest
```

## Prerequisites

- **Node.js**: >= 20.0.0
- **Chrome**: Running and logged into target sites
- **Browser Bridge Extension**: Required for browser commands

### Browser Bridge Extension Setup

**Method 1: Download Pre-built (Recommended)**
1. Go to [GitHub Releases](https://github.com/jackwener/opencli/releases) and download `opencli-extension.zip`
2. Unzip and open `chrome://extensions`, enable **Developer mode**
3. Click **Load unpacked** and select the unzipped folder

**Method 2: From npm Package**
1. Open `chrome://extensions`, enable Developer mode
2. Click **Load unpacked** and select `node_modules/@jackwener/opencli/extension`

**Method 3: From Source**
1. Open `chrome://extensions`, enable Developer mode
2. Click **Load unpacked** and select `extension/` directory from repo

## Core Commands

### Discovery & Listing
```bash
opencli list                    # List all available commands
opencli list -f yaml           # List as YAML
opencli list -f json           # List as JSON
opencli list -f table          # Default: rich terminal table
```

### Diagnostics
```bash
opencli doctor                  # Check extension + daemon connectivity
opencli doctor --live          # Also test live browser commands
opencli setup                  # Verify Browser Bridge connectivity
```

### AI-Powered Discovery
```bash
# Deep explore - discover APIs, infer capabilities
opencli explore https://example.com --site mysite

# Synthesize - generate YAML adapters from explore artifacts
opencli synthesize mysite

# Generate - one-shot: explore → synthesize → register
opencli generate https://example.com --goal "hot"

# Strategy Cascade - auto-probe auth strategies
opencli cascade https://api.example.com/data
```

### External CLI Hub
```bash
# Use external CLIs directly (auto-install if missing)
opencli gh pr list --limit 5
opencli docker ps
opencli kubectl get pods
opencli obsidian search query="AI"

# Register your own local CLI
opencli register mycli
```

## Built-in Browser Commands

| Site | Commands | Mode |
|------|----------|------|
| **twitter** | trending, bookmarks, profile, search, timeline, thread, following, followers, notifications, post, reply, delete, like, article, follow, unfollow, bookmark, unbookmark, download, accept, reply-dm | Browser |
| **reddit** | hot, frontpage, popular, search, subreddit, read, user, user-posts, user-comments, upvote, save, comment, subscribe, saved, upvoted | Browser |
| **bilibili** | hot, search, me, favorite, history, feed, subtitle, dynamic, ranking, following, user-videos, download | Browser |
| **zhihu** | hot, search, question, download | Browser |
| **xiaohongshu** | search, notifications, feed, user, download, creator-notes, creator-note-detail, creator-notes-summary, creator-profile, creator-stats | Browser |
| **youtube** | search, video, transcript | Browser |
| **weibo** | hot | Browser |
| **jike** | feed, search, create, like, comment, repost, notifications, post, topic, user | Browser |
| **boss** | search, detail, recommend, joblist, greet, batchgreet, send, chatlist, chatmsg, invite, mark, exchange, resume, stats | Browser |
| **weread** | shelf, search, book, highlights, notes, notebooks, ranking | Browser |
| **douban** | search, top250, subject, marks, reviews | Browser |
| **xueqiu** | feed, hot-stock, hot, search, stock, watchlist, earnings-date | Browser |
| **v2ex** | hot, latest, topic, daily, me, notifications | Public / Browser |
| **stackoverflow** | hot, search, bounties, unanswered | Public |
| **hackernews** | top | Public |
| **arxiv** | search, paper | Public |
| **wikipedia** | search, summary | Public |
| **devto** | top, tag, user | Public |
| **linux-do** | hot, latest, search, categories, category, topic | Public |
| **steam** | top-sellers | Public |
| **apple-podcasts** | search, episodes, top | Public |
| **xiaoyuzhou** | podcast, podcast-episodes, episode | Public |
| **bbc** | news | Public |
| **bloomberg** | main, markets, economics, industries, tech, politics, businessweek, opinions, feeds, news | Public / Browser |
| **reuters** | search | Browser |
| **smzdm** | search | Browser |
| **yahoo-finance** | quote | Browser |
| **sinafinance** | news | Public |
| **barchart** | quote, options, greeks, flow | Browser |
| **chaoxing** | assignments, exams | Browser |
| **ctrip** | search | Browser |
| **linkedin** | search | Browser |
| **coupang** | search, add-to-cart | Browser |
| **hf** | top | Public |
| **jimeng** | generate, history | Browser |

## Desktop App Adapters

| App | Commands | Description |
|-----|----------|-------------|
| **cursor** | status, send, read, new, dump, composer, model, extract-code, ask, screenshot, history, export | Cursor IDE control |
| **codex** | status, send, read, new, dump, extract-diff, model, ask, screenshot, history, export | OpenAI Codex CLI |
| **chatwise** | status, new, send, read, ask, model, history, export, screenshot | Multi-LLM client |
| **notion** | status, search, read, new, write, sidebar, favorites, export | Notion pages |
| **discord-app** | status, send, read, channels, servers, search, members | Discord Desktop |
| **antigravity** | status, send, read, new, dump, extract-code, model, watch, serve | Antigravity Ultra |
| **chatgpt** | status, new, send, read, ask | ChatGPT macOS app |
| **grok** | ask | Grok Desktop |

## Download Support

```bash
# Install yt-dlp first (for video downloads)
pip install yt-dlp
# or
brew install yt-dlp

# Xiaohongshu - Images & Videos
opencli xiaohongshu download abc123 --output ./xhs

# Bilibili - Videos
opencli bilibili download BV1xxx --output ./bilibili
opencli bilibili download BV1xxx --quality 1080p

# Twitter - Images & Videos
opencli twitter download elonmusk --limit 20 --output ./twitter
opencli twitter download --tweet-url "https://x.com/user/status/123" --output ./twitter

# Zhihu - Articles to Markdown
opencli zhihu download "https://zhuanlan.zhihu.com/p/xxx" --output ./zhihu
opencli zhihu download "https://zhuanlan.zhihu.com/p/xxx" --download-images
```

## Output Formats

All commands support `-f / --format`:

```bash
opencli bilibili hot -f table    # Default: rich terminal table
opencli bilibili hot -f json     # JSON (pipe to jq or LLMs)
opencli bilibili hot -f yaml     # YAML (human-readable)
opencli bilibili hot -f md       # Markdown
opencli bilibili hot -f csv      # CSV
opencli bilibili hot -v          # Verbose: show pipeline debug steps
```

## Examples

### Social Media
```bash
# Twitter/X
opencli twitter trending --limit 10
opencli twitter profile elonmusk
opencli twitter search "AI agents" --limit 20

# Reddit
opencli reddit hot --limit 5
opencli reddit subreddit programming --limit 10

# Bilibili
opencli bilibili hot --limit 10
opencli bilibili search "AI教程" --limit 5

# Zhihu
opencli zhihu hot
opencli zhihu question "123456"
```

### News & Content
```bash
# HackerNews
opencli hackernews top --limit 10

# BBC
opencli bbc news

# Bloomberg (RSS-backed commands work without browser)
opencli bloomberg main
opencli bloomberg markets
opencli bloomberg tech

# Wikipedia
opencli wikipedia search "Artificial Intelligence"
opencli wikipedia summary "Machine Learning"
```

### Desktop Apps
```bash
# Cursor
opencli cursor status
opencli cursor ask "Explain this code"
opencli cursor composer "Create a React component"

# ChatWise
opencli chatwise status
opencli chatwise new
opencli chatwise ask "What is quantum computing?"

# Notion
opencli notion search "Project notes"
opencli notion read "page-id"
```

### External CLIs
```bash
# GitHub CLI
opencli gh pr list --limit 5
opencli gh issue create --title "Bug report"

# Docker
opencli docker ps
opencli docker logs container-name

# kubectl
opencli kubectl get pods
opencli kubectl logs deployment/app
```

## YAML Pipeline (Advanced)

```yaml
pipeline:
  - fetch: https://api.example.com/media
  - download:
      url: ${{ item.imageUrl }}
      dir: ./downloads
      filename: ${{ item.title | sanitize }}.jpg
      concurrency: 5
      skip_existing: true
```

## Troubleshooting

### Extension not connected
- Ensure Browser Bridge extension is installed and enabled in `chrome://extensions`

### "attach failed: Cannot access a chrome-extension:// URL"
- Another Chrome extension may be interfering (e.g., youmind, New Tab Override)
- Try disabling other extensions temporarily

### Empty data or 'Unauthorized' error
- Login session in Chrome may have expired
- Open Chrome, navigate to the target site, and refresh/log in again

### Node API errors
- Ensure Node.js >= 20.0.0

### Daemon issues
```bash
# Check daemon status
curl localhost:19825/status

# View extension logs
curl localhost:19825/logs
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENCLI_HEADLESS` | Run browser in headless mode (set to `1`) |

## For AI Agents

To enable AI agents to discover and use OpenCLI tools, add to your `AGENT.md` or `.cursorrules`:

```markdown
## CLI Tools

Use `opencli` for website and app automation. Run `opencli list` to discover available tools.

### Workflow
1. Check available commands: `opencli list -f yaml`
2. For browser commands, ensure Chrome is logged into the target site
3. Run command with desired output format: `-f json` for programmatic use
4. Handle errors by checking login status if "Unauthorized"
```

## Credits

OpenCLI by [jackwener](https://github.com/jackwener)
