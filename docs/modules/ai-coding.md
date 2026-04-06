# AI Coding Stack

## Purpose

First-class support for AI-assisted development using Claude Code, Codex, tmux sessions, and agent tooling. The setup supports single-agent, multi-agent, and full swarm workflows.

## How It Works

### Components

| Component | Config Location | Purpose |
|---|---|---|
| Claude Code | `bin/a`, `tmux/aliases.zsh` | Primary AI coding agent |
| Codex | `codex/aliases.zsh` | Secondary agent |
| tmux | `tmux/` | Terminal multiplexer for agent workspaces |
| Beads (bd) | `agents/Brewfile` | Agent memory / task tracking |
| NTM | `zsh/zshrc.symlink` (shell integration) | Named tmux manager for agent orchestration |
| DCG | `zsh/zshrc.symlink` (hook check) | Destructive command guard |

### Workflows

**Solo Claude** (`bin/a` or `a` alias):
```sh
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions
```

**Claude + Codex workspace** (`ai-cli`):
tmux session with Claude (left) and Codex+Shell (right). Detects codex availability.

**Agent Swarm** (`ai-swarm`):
2x2 grid: 2 Claude Code instances + Codex + Shell. Flywheel-style parallel coding.

### Environment Variables

| Variable | Value | Purpose |
|---|---|---|
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | `1` | Enable Claude Code agent teams feature |

### Agent Tools (Optional)

Installed via `brew bundle --file=~/.dotfiles/agents/Brewfile`:
- `bd` (beads) — local-first task tracking for agent memory
- go, rust, node, uv — language runtimes for agent toolchain
- Additional tools (bv, cass, ubs, mcp-agent-mail) installed separately per `agents/Brewfile` comments

## Interfaces, APIs, and Contracts

### Shell Aliases and Functions

| Name | Type | Command |
|---|---|---|
| `a` | bin script | Claude Code with agent teams |
| `cca` | alias | Claude Code with agent teams (`agents/aliases.zsh`) |
| `codex` | alias | `codex` |
| `ai-cli` | function | tmux session (Claude + Codex or Claude-only) |
| `ai-swarm` | function | tmux 2x2 multi-agent workspace |

## Design Patterns and Conventions Used Here

- **Progressive complexity**: `a` for quick single-agent, `ai-cli` for workspace, `ai-swarm` for full parallel coding
- **Codex detection**: `ai-cli` checks `command -v codex` to decide layout
- **Consistent flags**: All Claude invocations use `--dangerously-skip-permissions` and `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
- **Session reuse**: All tmux functions reattach to existing sessions instead of creating duplicates
- **tmux as orchestrator**: Sessions and splits managed by tmux — Claude Code agent teams also spawn splits natively via tmux

## Code Examples and Gotchas

**Quick start:**
```sh
# Simplest: just launch Claude
a

# With workspace layout
ai-cli

# Full multi-agent swarm
ai-swarm
```

**Gotcha**: `--dangerously-skip-permissions` bypasses safety checks. This is intentional for personal dev but should not be used in shared or production environments.

**Gotcha**: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is an experimental flag. It may change or become default in future Claude Code versions.

**Gotcha**: The `cca` alias is defined in `agents/aliases.zsh` and does the same thing as `bin/a`.

## Maintenance & Accretion

Update this doc when the AI stack changes (new tools, new flags, new workflows). Track Claude Code flag changes — experimental features may stabilize or be removed.
