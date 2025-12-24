# Repository Guidelines

## Project Structure & Module Organization
This repository is a topic-oriented dotfiles setup. Each top-level directory represents a domain (for example `git/`, `zsh/`, `vim/`, `macos/`). Files are loaded based on naming conventions rather than a build system.

- `bin/` holds executable utilities that are added to `$PATH`.
- `script/` contains entry points like `script/bootstrap` and `script/install`.
- `topic/*.zsh` files are sourced automatically; `topic/path.zsh` loads first and `topic/completion.zsh` loads last.
- `topic/*.symlink` files are symlinked into `$HOME` (for example `zsh/zshrc.symlink` → `~/.zshrc`).
- Platform helpers live in directories such as `macos/` and `homebrew/`.

## Build, Test, and Development Commands
- `script/bootstrap`: symlinks `*.symlink` files into `$HOME` and sets up git config.
- `script/install`: runs every `install.sh` found under topics for optional setup tasks.
- `bin/dot`: runs macOS defaults, Homebrew install/update, and then `script/install`.
- `macos/set-defaults.sh`: applies macOS defaults (called by `bin/dot`).

## Coding Style & Naming Conventions
- Shell scripts use existing conventions in the file: 2-space indentation and POSIX `sh` or `bash` as declared by the shebang.
- Use topical naming: new areas should be added as a new top-level directory (for example `python/`).
- Follow loader patterns: use `path.zsh`, `completion.zsh`, `install.sh`, and `*.symlink` as appropriate.

## Testing Guidelines
There is no automated test suite. Validate changes by running the relevant scripts (for example `script/bootstrap` for symlinks or `script/install` for installers) and manually verifying the expected shell behavior.

## Commit & Pull Request Guidelines
Recent commit messages use concise, imperative summaries (for example “Update README.md”). Follow that pattern and keep the subject focused on the primary change.

For pull requests, include:
- a short description of the impact (what changed and why),
- any manual verification you performed (commands run, platform), and
- screenshots only when changing user-facing prompts or output.

## Configuration Tips
Local machine-specific values belong in `~/.localrc` and `git/gitconfig.local.symlink`. Avoid committing secrets or machine-specific paths into shared topic files.
