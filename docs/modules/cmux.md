# cmux — Native macOS Terminal for AI Coding

## Purpose

cmux is the primary terminal multiplexer, replacing zellij. It's a native macOS app built on libghostty, purpose-built for running multiple AI coding agents simultaneously with sidebar metadata, notifications, and a socket API.

## How It Works

### Key Files

| File | Purpose |
|---|---|
| `cmux/install.sh` | Installs via `brew tap manaflow-ai/cmux && brew install --cask cmux`, symlinks CLI and config |
| `cmux/settings.json` | App settings: dark mode, automation socket, Claude Code integration, notifications |
| `cmux/cmux.json` | Custom workspace commands (accessible via Cmd+Shift+P command palette) |
| `cmux/aliases.zsh` | Shell functions: `ai-cli`, `claude-teams`, `cmux-swarm` |

### Terminal Config

cmux reads Ghostty's config at `~/.config/ghostty/config` (symlinked from `ghostty/config`):
```
font-family = FiraCode Nerd Font
font-size = 12
theme = iTerm2 Solarized Dark
```

### Hierarchy

```
Window → Workspace (sidebar entry) → Pane (split) → Surface (tab) → Panel (terminal/browser)
```

## Interfaces, APIs, and Contracts

### Shell Functions

- `ai-cli` — Creates a workspace with Claude Code. Detects codex availability.
- `claude-teams` — Launches `cmux claude-teams` for native agent teammate splits.
- `cmux-swarm` — Creates a multi-agent workspace with splits.

### Custom Commands (cmux.json)

Available via Cmd+Shift+P in cmux:

| Command | Layout | Color |
|---|---|---|
| AI Coding (Claude + Codex) | 50/50: Claude \| Codex+Shell | Purple |
| AI Coding (Claude Only) | 70/30: Claude \| Shell | Blue |
| Claude Teams | Native teammate splits | — |
| Agent Swarm | 2x2: 2 Claude + Codex + Shell | Magenta |

### Socket API

Enabled via `"socketControlMode": "automation"` in settings.json. CLI commands:
- `cmux list-workspaces`, `cmux new-workspace`, `cmux new-split`
- `cmux send "text"`, `cmux send-key enter`
- `cmux notify --title "T" --body "B"`
- `cmux set-status`, `cmux set-progress`, `cmux log`

### Trusted Directories

`cmux.json` custom commands only run in directories listed in settings.json `trustedDirectories`: `~/Code` and `~/.dotfiles`.

## Design Patterns and Conventions Used Here

- **Guard clauses**: All shell functions check `command -v cmux` before proceeding.
- **Workspace layouts**: Use cmux's recursive binary tree layout (horizontal/vertical splits with ratios).
- **Environment passthrough**: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` set in command strings.
- **Config symlinks**: Settings and custom commands are symlinked from dotfiles to `~/.config/cmux/`.

## Code Examples and Gotchas

**Launch a quick Claude workspace from the terminal:**
```sh
cmux new-workspace --name "Claude" --command "claude --dangerously-skip-permissions"
```

**Send a notification from a running agent:**
```sh
cmux notify --title "Done" --body "Agent finished task"
```

**Gotcha**: cmux is macOS-only (14.0+). The `cmux claude-teams` command creates a tmux shim that translates tmux commands to cmux's socket API — this is how Claude Code's agent teams feature works natively in cmux.

**Gotcha**: The CLI symlink (`/usr/local/bin/cmux`) requires `sudo` to create. The install script handles this.

## Maintenance & Accretion

Update this doc when cmux settings change, workspace layouts are added/removed, or the cmux version introduces breaking changes. The custom commands in `cmux.json` should match what's documented here.
