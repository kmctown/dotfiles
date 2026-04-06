# Lessons Learned

## oh-my-zsh Overwrites ~/.zshrc

**Problem**: oh-my-zsh's installer overwrites `~/.zshrc`, breaking the dotfiles symlink.
**Fix**: `script/bootstrap` re-runs `install_dotfiles` after all installers complete (commit `98c141d`).
**Rule**: Any installer that touches `$HOME` dotfiles must be followed by a re-symlink pass.

## Zellij Key Conflicts with Claude Code

**Problem**: Alt+f in zellij conflicts with macOS Option+Right (word-forward) in Claude Code. Other zellij bindings also interfere.
**Fix**: Removed conflicting Alt+f binding from zellij config (commit `24f7d55`). Eventually migrated away from zellij entirely (commit `863b554`).
**Rule**: Terminal multiplexer keybindings must not conflict with tools running inside them. tmux uses `Ctrl-a` prefix which avoids conflicts with application keybindings.

## Zellij → cmux → tmux Migration (2026-04)

**Context**: Started with zellij (key conflicts with Claude Code), tried cmux (native macOS, purpose-built for agents), settled on tmux (universal, Claude Code agent teams work natively with tmux, useful beyond just AI coding).
**Decision**: Deprecated both zellij and cmux. tmux is the standard multiplexer.
**Files**: `tmux/tmux.conf`, `tmux/aliases.zsh`, `tmux/install.sh`.
**Rule**: Prefer widely-adopted tools over niche alternatives when the standard tool meets the requirements.

## Claude Code Permission Modes

**History**: Switched between `--auto` mode and `--dangerously-skip-permissions` over several commits.
**Current**: Using `--dangerously-skip-permissions` (commit `0aa6be9`).
**Tradeoff**: Skip-permissions is faster for trusted local dev but bypasses safety checks. Acceptable for personal dotfiles; reconsider for shared environments.

## DCG Hook Integrity Check

**Problem**: Claude Code settings can silently lose hooks (e.g., DCG pre-tool-use hook).
**Fix**: Added a zshrc check that warns on shell startup if the DCG hook is missing from `~/.claude/settings.json`.
**Pattern**: Validate external tool integrations at shell startup when they're critical to workflow safety.

## Maintenance & Accretion

Add entries here when something breaks unexpectedly, when a migration happens, or when a pattern that seemed right turns out to be wrong. Each entry should have: problem, fix, and a forward-looking rule.
