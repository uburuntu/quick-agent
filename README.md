# Quick Agent

Right-click any folder in macOS Finder to instantly open it in your favorite AI coding agent.

<p align="center">
  <img src="assets/demo.gif" alt="Quick Agent demo" width="720">
</p>

> **Demo not loading?** Run `vhs demo.tape` locally to generate it, or see the [install output](#install) below.

## Supported Agents

| Agent | CLI | Type |
|-------|-----|------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | `claude` | Terminal |
| [Codex](https://github.com/openai/codex) | `codex` | Terminal |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | `gemini` | Terminal |
| [Aider](https://aider.chat) | `aider` | Terminal |
| [Cursor](https://cursor.com) | `cursor` | GUI App |

## Supported Terminals

Terminal.app, [iTerm2](https://iterm2.com), [Ghostty](https://ghostty.org), [Warp](https://warp.dev)

## Install

**Homebrew:**

```bash
brew install uburuntu/tap/quick-agent
quick-agent install
```

**Or one-liner (no Homebrew needed):**

```bash
curl -fsSL https://raw.githubusercontent.com/uburuntu/quick-agent/main/install.sh | bash
```

The installer auto-detects your AI agents and terminal, picks smart defaults, and sets everything up:

```
  ⚡ Quick Agent v1.0.0

    ✓ Installed CLI to ~/.local/bin/quick-agent

  Scanning for AI coding agents...
    ✓ claude   — Claude Code
    ✓ codex    — Codex
    ✗ gemini   — not found
    ✓ aider    — Aider
    ✗ cursor   — not found

  Scanning for terminal apps...
    ✓ iTerm2
    ✓ Ghostty

  ─────────────────────────────────
  Default agent:  Claude Code
  Terminal:       iTerm2
  ─────────────────────────────────

  Install with these settings? [Y/n/c]
```

Press `c` to customize your default agent or terminal before installing.

## How It Works

Quick Agent installs three [macOS Quick Actions](https://support.apple.com/guide/automator/use-quick-action-workflows-aut73234890a/mac) into Finder's right-click menu:

| Quick Action | What it does |
|---|---|
| **Open in Claude Code** | Instantly launches your default agent in the selected folder |
| **Open in Agent...** | Shows a native macOS picker dialog to choose any installed agent |
| **Quick Agent Settings** | Opens the configuration menu |

When you right-click a **file**, Quick Agent opens its parent folder. When you right-click a **folder**, it opens that folder directly.

## Configuration

### Change settings anytime

**From Finder:** Right-click → Quick Actions → **Quick Agent Settings**

**From terminal:**

```bash
quick-agent config
```

```
  ⚡ Quick Agent — Settings

  Default agent:  Claude Code
  Terminal:       iTerm2

  [1] Change default agent
  [2] Change terminal
  [3] Reinstall Quick Actions
  [q] Quit
```

### Manual config

Edit `~/.config/quick-agent/config`:

```ini
default_agent=claude
terminal=iterm2
```

Available values:
- `default_agent`: `claude`, `codex`, `gemini`, `aider`, `cursor`
- `terminal`: `terminal`, `iterm2`, `ghostty`, `warp`

## CLI Reference

```bash
quick-agent install       # Install Finder Quick Actions
quick-agent uninstall     # Remove everything
quick-agent config        # Change settings interactively
quick-agent status        # Show current setup
quick-agent --version     # Show version
```

## Uninstall

```bash
quick-agent uninstall
```

To also remove the CLI binary:

```bash
rm $(which quick-agent)
```

## Troubleshooting

### Quick Actions don't appear in right-click menu

1. Right-click any folder → **Quick Actions → Customize...** → enable the Quick Agent actions
2. Or: **System Settings → Privacy & Security → Extensions → Finder Extensions**
3. Try restarting Finder: `killall Finder`
4. Or flush the services cache: `/System/Library/CoreServices/pbs -flush`

### "Automator wants to control Terminal" permission dialog

This is expected on first use. Click **Allow** — Quick Agent needs this permission to open terminal windows.

Grant in **System Settings → Privacy & Security → Automation**.

### Agent CLI not found

Quick Agent checks these directories for CLI tools:
- `/usr/local/bin`, `/opt/homebrew/bin`
- `~/.local/bin`, `~/.cargo/bin`
- nvm and pyenv paths

If your agent is installed elsewhere, make sure it's in your `PATH`.

## Recording the Demo

The demo GIF is generated from `demo.tape` using [VHS](https://github.com/charmbracelet/vhs):

```bash
brew install vhs
vhs demo.tape
```

A [GitHub Action](.github/workflows/demo.yml) auto-regenerates it when the tape file or script changes.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup, adding new agents/terminals, and the release process.

The Homebrew formula auto-updates via [GitHub Action](.github/workflows/homebrew-bump.yml) on each release.

## Requirements

- macOS 12 (Monterey) or later
- At least one AI coding agent installed

## License

[MIT](LICENSE)
