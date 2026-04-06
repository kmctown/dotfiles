# Documentation Index

## Overview

Topic-centric macOS dotfiles with first-class AI coding support (tmux, Claude Code, Codex). Each top-level directory is an independent topic — files are auto-loaded by naming convention.

## How to Use This Documentation

Start with [AGENTS.md](../AGENTS.md) for rules and commands. Come here for deeper context. Module docs cover individual topics; reference docs cover cross-cutting concerns.

## Reference Docs

| Document | Covers |
|---|---|
| [architecture.md](reference/architecture.md) | System map, install flow, load order, tech stack |
| [design-patterns-and-conventions.md](reference/design-patterns-and-conventions.md) | Naming, shell, install, symlink, and error-handling patterns |
| [lessons-learned.md](reference/lessons-learned.md) | Anti-patterns, migration notes, gotchas |

## Module Docs

| Document | Covers |
|---|---|
| [tmux.md](modules/tmux.md) | tmux config, AI coding workspaces, agent integration |
| [shell.md](modules/shell.md) | Zsh config, aliases, load order, oh-my-zsh, completions |
| [ai-coding.md](modules/ai-coding.md) | Claude Code, Codex, agent teams, tmux workspaces, agent tooling |
| [macos.md](modules/macos.md) | System defaults, hostname, display fixes, network fixes |
| [git.md](modules/git.md) | Git config, aliases, credential helper, custom commands |

## Change Tracking

See [updates.md](updates.md) for documentation changelog.

## Maintenance & Accretion

Update this index when docs are added, removed, or restructured. Every doc in `docs/` should be linked here.
