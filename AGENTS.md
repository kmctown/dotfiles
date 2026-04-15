# Dotfiles — Agent Guidelines

Read this file first. Follow links for deeper context.

## What This Repo Is

Topic-centric macOS dotfiles. Each top-level directory is a topic (git, zsh, tmux, etc.). Files are discovered by naming convention, not manifest. See [docs/INDEX.md](docs/INDEX.md) for full documentation.

## Core Rules

1. **Convention over configuration.** New topics go in a new top-level directory. Files are auto-loaded by name — don't add manual registration.
2. **Never commit secrets.** Use `~/.localrc` for private env vars and `git/gitconfig.local.symlink` for local git identity.
3. **Idempotent installs.** Every `install.sh` must check before acting. Guard optional tools with `command -v`.
4. **No destructive git commands** without explicit user approval.
5. **Keep shell startup fast.** Don't add expensive operations to `*.zsh` files.
6. **macOS only.** This repo targets macOS (Apple Silicon and Intel).

## File Conventions

| Pattern | Behavior |
|---|---|
| `topic/*.zsh` | Auto-sourced into shell |
| `topic/path.zsh` | Sourced first (PATH setup) |
| `topic/completion.zsh` | Sourced last (autocomplete) |
| `topic/*.symlink` | Symlinked to `$HOME` as dotfiles |
| `topic/install.sh` | Run by `script/install` |
| `bin/*` | Added to `$PATH` |

## Key Commands

| Command | What It Does |
|---|---|
| `script/bootstrap` | Fresh machine setup: symlinks, Homebrew, all installers |
| `script/install` | Run all `topic/install.sh` scripts |
| `bin/dot` | Pull repo, apply macOS defaults, update brew, run installers |
| `bin/a` | Launch Claude Code with agent teams |
| `bin/c` | Launch Codex without approvals or sandbox |
| `ai-cli` | Launch tmux AI coding workspace |

## Coding Style

- Shell scripts: 2-space indentation, POSIX `sh` or `bash` per shebang
- Commit messages: imperative, concise, prefixed (`feat:`, `fix:`, `chore:`)
- No automated test suite — validate by running scripts manually
- Follow existing patterns in the topic you're modifying

## AI Coding Stack

Primary multiplexer: **tmux**.
Config: `tmux/tmux.conf`, `tmux/aliases.zsh`. Details in [docs/modules/tmux.md](docs/modules/tmux.md).

## Documentation

- Start here, then follow links to `docs/`
- [docs/INDEX.md](docs/INDEX.md) — central navigation
- [docs/reference/architecture.md](docs/reference/architecture.md) — system design
- [docs/reference/design-patterns-and-conventions.md](docs/reference/design-patterns-and-conventions.md) — patterns
- On significant code changes, update the relevant docs or add a dated note to [docs/updates.md](docs/updates.md)

## Maintenance & Accretion

Update this file when the repo's core conventions, entry points, or topic structure change. Route detail into `docs/` — keep this file under 200 lines.
