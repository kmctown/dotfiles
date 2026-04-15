# Documentation Updates

## 2026-04-04 — Initial documentation suite

Created full DocForge documentation suite:

- `AGENTS.md` — root router with rules, commands, and conventions
- `CLAUDE.md` — pointer to AGENTS.md
- `docs/INDEX.md` — central navigation
- `docs/reference/architecture.md` — system map, install flow, load order, tech stack
- `docs/reference/design-patterns-and-conventions.md` — naming, shell, install, symlink, error-handling patterns
- `docs/reference/lessons-learned.md` — oh-my-zsh overwrite, zellij key conflicts, zellij→cmux migration, Claude permission modes, DCG hook check
- `docs/modules/cmux.md` — cmux terminal config, workspaces, socket API
- `docs/modules/shell.md` — zsh load order, oh-my-zsh, aliases
- `docs/modules/ai-coding.md` — Claude Code, Codex, agent workflows
- `docs/modules/macos.md` — system defaults, fix scripts
- `docs/modules/git.md` — git config, aliases, credential helper

### Resolved during creation

- `cca` alias: was referenced in README but missing from committed files. Added to `agents/aliases.zsh`.

## 2026-04-06 — Migrate from cmux to tmux

Standardized on tmux as the terminal multiplexer for all AI coding workflows. Reasons: Claude Code agent teams work natively with tmux, tmux is universally available, and it's useful beyond just AI coding.

- `tmux/aliases.zsh` — new `ai-cli`, `claude-teams`, `ai-swarm` functions using tmux sessions
- `cmux/` — deprecated (aliases stubbed, install.sh is no-op, config preserved)
- `zellij/` — deprecation notice updated (zellij → tmux)
- `docs/modules/tmux.md` — new module doc replacing cmux.md
- Updated: AGENTS.md, INDEX.md, architecture.md, ai-coding.md, lessons-learned.md

## 2026-04-13 — Canonicalize NTM shell integration

Moved NTM shell integration out of `zsh/zshrc.symlink` into a dedicated `ntm/` topic so it follows the repo's topic-centric shell loading conventions.

- Added: `ntm/completion.zsh` with guarded init: `(( $+commands[ntm] )) && eval "$(ntm shell zsh)"`
- Updated: `zsh/zshrc.symlink` to remove the unguarded direct `ntm` eval
- Updated: `docs/modules/shell.md`, `docs/modules/ai-coding.md`, `docs/reference/architecture.md`

## 2026-04-14 — Add Codex launcher script

Added a `bin/c` shortcut that mirrors `bin/a` and launches Codex with approvals and sandboxing disabled.

- Added: `bin/c`
- Updated: `AGENTS.md`, `docs/modules/ai-coding.md`

## Maintenance & Accretion

Add a dated entry here whenever documentation is created, updated, or when a gap is identified. Each entry should describe what changed and why.
