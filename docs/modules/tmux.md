# tmux — Terminal Multiplexer for AI Coding

## Purpose

tmux is the standard terminal multiplexer for all AI coding workflows. Claude Code agent teams spawn teammates as native tmux splits. Shell functions provide preset layouts for solo, team, and swarm workflows.

## How It Works

### Key Files

| File | Purpose |
|---|---|
| `tmux/install.sh` | Installs tmux and reattach-to-user-namespace via Homebrew |
| `tmux/tmux.conf` | Core tmux config: prefix key, vim keys, split bindings, resize |
| `tmux/aliases.zsh` | Shell functions: `ai-cli`, `claude-teams`, `ai-swarm` |

### Config Highlights

- Prefix: `Ctrl-a` (not default `Ctrl-b`)
- Vim-style copy mode and pane navigation (`h/j/k/l`)
- Split shortcuts: `PREFIX + -` (horizontal), `PREFIX + |` (vertical)
- Pane resize: `Alt + Arrow Keys` (no prefix needed)
- Reload config: `PREFIX + r`

## Interfaces, APIs, and Contracts

### Shell Functions

- `ai-cli` — Creates a tmux session with Claude Code + Codex (if available) + Shell
- `ai-swarm` — Creates a 2x2 tmux session: 2 Claude Code instances + Codex + Shell

All functions reattach to an existing session if one already exists (no duplicates).

### Session Names

| Function | Session Name |
|---|---|
| `ai-cli` | `ai-coding` |
| `ai-swarm` | `ai-swarm` |

### Layouts

| Function | Layout |
|---|---|
| `ai-cli` (with codex) | Left: Claude \| Top-right: Codex, Bottom-right: Shell |
| `ai-cli` (no codex) | Left: Claude \| Right: Shell |
| `ai-swarm` | 2x2: Claude-1, Claude-2, Codex, Shell |

## Design Patterns and Conventions Used Here

- **Guard clauses**: All shell functions check `command -v tmux` before proceeding.
- **Session reuse**: Check `tmux has-session` before creating — reattach if exists.
- **send-keys pattern**: Use `send-keys` + `C-m` to launch commands in panes (keeps pane alive if command exits).
- **Codex detection**: `ai-cli` and `ai-swarm` check `command -v codex` to decide layout.

## Code Examples and Gotchas

**List active AI sessions:**
```sh
tmux list-sessions
```

**Attach to an existing session:**
```sh
tmux attach-session -t ai-coding
```

**Kill a session:**
```sh
tmux kill-session -t ai-coding
```

**Gotcha**: The `reattach-to-user-namespace` dependency is needed for macOS pasteboard access inside tmux. The install script handles this.

**Gotcha**: If you're already inside a tmux session, `ai-cli` / `ai-swarm` will fail to attach (nested sessions). Detach first with `PREFIX + d`, or use `tmux switch-client -t <session>`.

## Maintenance & Accretion

Update this doc when tmux config changes, workspace layouts are added/removed, or the AI workflow patterns shift. The shell functions in `tmux/aliases.zsh` should match what's documented here.
