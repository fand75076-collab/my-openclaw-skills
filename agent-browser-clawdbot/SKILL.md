---
name: agent-browser
description: Headless browser automation CLI optimized for AI agents with accessibility tree snapshots and ref-based element selection
metadata: {"clawdbot":{"emoji":"🌐","requires":{"commands":["agent-browser"]},"homepage":"https://github.com/vercel-labs/agent-browser"}}
---

# Agent Browser Skill

Fast browser automation using accessibility tree snapshots with refs for deterministic element selection.

## Why Use This Over Built-in Browser Tool

**Use agent-browser when:**
- Automating multi-step workflows
- Need deterministic element selection
- Performance is critical
- Working with complex SPAs
- Need session isolation

**Use built-in browser tool when:**
- Need screenshots/PDFs for analysis
- Visual inspection required
- Browser extension integration needed

## Installation

```bash
# Via npm (recommended)
npm install -g agent-browser
agent-browser install  # Download Chrome from Chrome for Testing

# Via Homebrew (macOS)
brew install agent-browser
agent-browser install

# Via Cargo
cargo install agent-browser
agent-browser install

# Upgrade to latest
agent-browser upgrade
```

## Core Workflow

```bash
# 1. Navigate and snapshot
agent-browser open https://example.com
agent-browser snapshot -i --json

# 2. Parse refs from JSON, then interact
agent-browser click @e2
agent-browser fill @e3 "text"

# 3. Re-snapshot after page changes
agent-browser snapshot -i --json
```

## Key Commands

### Navigation
```bash
agent-browser open <url>              # Navigate (aliases: goto, navigate)
agent-browser back | forward | reload | close
```

### Snapshot (Always use -i --json for AI)
```bash
agent-browser snapshot -i --json              # Interactive elements, JSON output
agent-browser snapshot -i -c -d 5 --json      # + compact, depth limit
agent-browser snapshot -s "#main" -i --json   # Scope to selector
agent-browser snapshot --annotate             # Annotated screenshot with numbered labels
```

### Interactions (Ref-based)
```bash
agent-browser click @e2
agent-browser fill @e3 "text"
agent-browser type @e3 "text"
agent-browser hover @e4
agent-browser check @e5 | uncheck @e5
agent-browser select @e6 "value"
agent-browser press "Enter"
agent-browser scroll down 500
agent-browser drag @e7 @e8
```

### Get Information
```bash
agent-browser get text @e1 --json
agent-browser get html @e2 --json
agent-browser get value @e3 --json
agent-browser get attr @e4 "href" --json
agent-browser get title --json
agent-browser get url --json
agent-browser get count ".item" --json
```

### Check State
```bash
agent-browser is visible @e2 --json
agent-browser is enabled @e3 --json
agent-browser is checked @e4 --json
```

### Wait
```bash
agent-browser wait @e2                      # Wait for element
agent-browser wait 1000                     # Wait ms
agent-browser wait --text "Welcome"         # Wait for text
agent-browser wait --url "**/dashboard"     # Wait for URL pattern
agent-browser wait --load networkidle       # Wait for network idle
agent-browser wait --fn "window.ready === true"
```

### Sessions (Isolated Browsers)
```bash
# Different sessions
agent-browser --session agent1 open site-a.com
agent-browser --session agent2 open site-b.com

# Or via environment variable
AGENT_BROWSER_SESSION=agent1 agent-browser click "#btn"

# List active sessions
agent-browser session list

# Auto-save/restore session state
agent-browser --session-name twitter open twitter.com
```

### State Persistence
```bash
# Save auth state
agent-browser state save auth.json

# Load saved state (skip login)
agent-browser --state auth.json open https://app.example.com

# Or use session-name for automatic persistence
agent-browser --session-name myapp state load auth.json
```

### Screenshots & PDFs
```bash
agent-browser screenshot page.png
agent-browser screenshot --full page.png
agent-browser screenshot --annotate        # With numbered element labels
agent-browser pdf page.pdf
```

### Network Control
```bash
# Block requests
agent-browser network route "**/ads/*" --abort

# Mock responses
agent-browser network route "**/api/*" --body '{"x":1}'

# View requests
agent-browser network requests --filter api

# HAR recording
agent-browser network har start
agent-browser network har stop output.har
```

### Cookies & Storage
```bash
agent-browser cookies                     # Get all
agent-browser cookies set name value
agent-browser storage local key           # Get localStorage
agent-browser storage local set key val
```

### Tabs & Frames
```bash
agent-browser tab new https://example.com
agent-browser tab 2                       # Switch to tab
agent-browser frame @e5                   # Switch to iframe
agent-browser frame main                  # Back to main
```

### Batch Commands (Performance)
```bash
# Pipe commands as JSON to avoid per-command startup overhead
echo '[
  ["open", "https://example.com"],
  ["snapshot", "-i", "--json"],
  ["click", "@e1"],
  ["screenshot", "result.png"]
]' | agent-browser batch --json

# Stop on first error
agent-browser batch --bail < commands.json
```

### Diff & Comparison
```bash
# Compare current vs last snapshot
agent-browser diff snapshot

# Compare current vs saved baseline
agent-browser diff snapshot --baseline before.txt

# Visual pixel diff
agent-browser diff screenshot --baseline before.png

# Compare two URLs
agent-browser diff url https://v1.com https://v2.com --screenshot
```

## Snapshot Output Format

```json
{
  "success": true,
  "data": {
    "snapshot": "...",
    "refs": {
      "e1": {"role": "heading", "name": "Example Domain"},
      "e2": {"role": "button", "name": "Submit"},
      "e3": {"role": "textbox", "name": "Email"}
    }
  }
}
```

## Snapshot Filtering Options

| Option | Description |
|--------|-------------|
| `-i, --interactive` | Only interactive elements (buttons, links, inputs) |
| `-C, --cursor` | Include cursor-interactive elements (onclick, etc.) |
| `-c, --compact` | Remove empty structural elements |
| `-d, --depth <n>` | Limit tree depth |
| `-s, --selector <sel>` | Scope to CSS selector |

## Best Practices

1. **Always use `-i --json`** - Focus on interactive elements, easier parsing
2. **Wait for stability** - `agent-browser wait --load networkidle`
3. **Save auth state** - Skip login flows with `state save/load`
4. **Use sessions** - Isolate different browser contexts
5. **Use batch for multi-step** - Avoid per-command overhead
6. **Use `--headed` for debugging** - See what's happening

## Example: Search and Extract

```bash
agent-browser open https://www.google.com
agent-browser snapshot -i --json
# AI identifies search box @e1
agent-browser fill @e1 "AI agents"
agent-browser press Enter
agent-browser wait --load networkidle
agent-browser snapshot -i --json
# AI identifies result refs
agent-browser get text @e3 --json
agent-browser get attr @e4 "href" --json
```

## Example: Multi-Session Testing

```bash
# Admin session
agent-browser --session admin open app.com
agent-browser --session admin state load admin-auth.json
agent-browser --session admin snapshot -i --json

# User session (simultaneous)
agent-browser --session user open app.com
agent-browser --session user state load user-auth.json
agent-browser --session user snapshot -i --json
```

## Example: Batch Workflow

```bash
echo '[
  ["open", "https://example.com/login"],
  ["wait", "--load", "networkidle"],
  ["snapshot", "-i", "--json"],
  ["fill", "@e1", "user@example.com"],
  ["fill", "@e2", "password"],
  ["click", "@e3"],
  ["wait", "--url", "**/dashboard"],
  ["screenshot", "dashboard.png"]
]' | agent-browser batch --json
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `AGENT_BROWSER_SESSION` | Use isolated session |
| `AGENT_BROWSER_SESSION_NAME` | Auto-save/load state persistence |
| `AGENT_BROWSER_PROFILE` | Persistent browser profile directory |
| `AGENT_BROWSER_STATE` | Load storage state from JSON file |
| `AGENT_BROWSER_HEADED` | Show browser window (not headless) |
| `AGENT_BROWSER_DEFAULT_TIMEOUT` | Default operation timeout in ms (default: 25000) |
| `AGENT_BROWSER_SCREENSHOT_DIR` | Default screenshot output directory |
| `AGENT_BROWSER_ALLOWED_DOMAINS` | Comma-separated allowed domain patterns |
| `AGENT_BROWSER_CONTENT_BOUNDARIES` | Wrap output in boundary markers |
| `AGENT_BROWSER_MAX_OUTPUT` | Max characters for page output |
| `AGENT_BROWSER_ENCRYPTION_KEY` | 64-char hex key for AES-256-GCM encryption |

## Cloud Providers

### Browserless
```bash
export BROWSERLESS_API_KEY="your-token"
agent-browser -p browserless open https://example.com
```

### Browserbase
```bash
export BROWSERBASE_API_KEY="your-key"
agent-browser -p browserbase open https://example.com
```

### Browser Use
```bash
export BROWSER_USE_API_KEY="your-key"
agent-browser -p browseruse open https://example.com
```

### Kernel
```bash
export KERNEL_API_KEY="your-key"
agent-browser -p kernel open https://example.com
```

## Security Features

- **Authentication Vault** - Store credentials locally (encrypted), reference by name
- **Content Boundary Markers** - Wrap page output in delimiters (`--content-boundaries`)
- **Domain Allowlist** - Restrict navigation (`--allowed-domains "example.com,*.example.com"`)
- **Action Policy** - Gate destructive actions with policy file (`--action-policy ./policy.json`)
- **Action Confirmation** - Require approval for sensitive actions (`--confirm-actions eval,download`)
- **Output Length Limits** - Prevent context flooding (`--max-output 50000`)

## Credits

Skill created by Yossi Elkrief ([@MaTriXy](https://github.com/MaTriXy))

agent-browser CLI by [Vercel Labs](https://github.com/vercel-labs/agent-browser)
