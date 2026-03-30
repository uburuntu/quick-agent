# Contributing to Quick Agent

Thanks for your interest in improving Quick Agent!

## Development Setup

```bash
git clone https://github.com/uburuntu/quick-agent.git
cd quick-agent

# Run directly from the repo
./quick-agent install

# Lint with shellcheck
brew install shellcheck
shellcheck quick-agent install.sh
```

## Making Changes

1. Fork the repo
2. Create a branch: `git checkout -b my-feature`
3. Edit the `quick-agent` script (it's the entire project — one file)
4. Test your changes: `./quick-agent install` then right-click a folder in Finder
5. Run shellcheck: `shellcheck quick-agent`
6. Submit a PR

## Adding a New Agent

Add your agent to these four functions in `quick-agent`:

```bash
agent_name()          # Display name (e.g., "Claude Code")
agent_cmd()           # CLI command (e.g., "claude")
agent_type()          # "terminal" or "gui"
agent_install_hint()  # Install instructions shown when not found
```

Then add the agent ID to the `ALL_AGENTS` list.

If the agent is a GUI app (like Cursor), also update `agent_is_installed()` to check for the `.app` bundle.

## Adding a New Terminal

Add your terminal to:

```bash
terminal_name()          # Display name (e.g., "Ghostty")
terminal_is_installed()  # Check if the .app exists
```

Then add a `_launch_<terminal>()` function and wire it up in `_launch_in()`.

Add the terminal ID to `ALL_TERMINALS`.

## Releasing a New Version

### 1. Bump the version

Update `VERSION="X.Y.Z"` at the top of the `quick-agent` script.

### 2. Commit and tag

```bash
git add quick-agent
git commit -m "Release vX.Y.Z"
git tag vX.Y.Z
git push origin main --tags
```

### 3. Create a GitHub Release

```bash
gh release create vX.Y.Z --generate-notes
```

### 4. The Homebrew formula updates automatically

A GitHub Action (`.github/workflows/homebrew-bump.yml`) runs on every new release.
It automatically:
- Computes the SHA256 of the new release tarball
- Updates the formula in [uburuntu/homebrew-tap](https://github.com/uburuntu/homebrew-tap)
- Opens a PR to the homebrew-tap repo

If the action fails, you can update the formula manually:

```bash
# Get the new SHA
curl -fsSL https://github.com/uburuntu/quick-agent/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256

# Update homebrew-tap/Formula/quick-agent.rb:
#   url "...vX.Y.Z.tar.gz"
#   sha256 "<new-sha>"
```

## Architecture

The entire project is a single `quick-agent` shell script. Here's how it's organized:

```
quick-agent (the script)
├── Agent Registry        — agent_name(), agent_cmd(), agent_type(), etc.
├── Terminal Registry     — terminal_name(), terminal_is_installed()
├── PATH Augmentation     — _augment_path() for Automator's limited env
├── Config                — config_get(), config_set() → ~/.config/quick-agent/
├── Terminal Launchers    — _launch_terminal_app(), _launch_iterm2(), etc.
├── Workflow Generation   — _generate_info_plist(), _generate_document_wflow()
├── Commands              — cmd_install(), cmd_uninstall(), cmd_config(), etc.
└── Internal (_run)       — Called by workflows via: quick-agent _run <mode> <path>
```

When you run `quick-agent install`, it:
1. Auto-installs the CLI to `~/.local/bin/` or `/usr/local/bin/`
2. Detects installed agents and terminals
3. Generates `.workflow` bundles (Automator Quick Actions) at `~/Library/Services/`
4. Restarts Finder to register the new actions

When you right-click a folder → "Open in Claude Code":
1. macOS runs the `.workflow` shell script
2. That script calls `quick-agent _run default <path>`
3. `quick-agent` reads config, resolves the directory, opens your terminal, runs the agent
