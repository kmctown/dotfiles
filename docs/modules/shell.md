# Shell Configuration

## Purpose

Zsh setup with oh-my-zsh, auto-loaded topic configs, and a convention-based loading system. The shell is the glue that makes the topic-centric dotfiles work.

## How It Works

### Key Files

| File | Purpose |
|---|---|
| `zsh/zshrc.symlink` | Entry point (`~/.zshrc`). Discovers and loads all `*.zsh` files. |
| `zsh/config.zsh` | History (10000 lines, shared, timestamped), terminal options, keybindings |
| `zsh/aliases.zsh` | `reload!` (re-source zshrc), `cls`, Terraform alias |
| `zsh/completion.zsh` | Case-insensitive matching, pending tab insertion |
| `zsh/fpath.zsh` | Function path for `functions/` directory |
| `oh-my-zsh/index.zsh` | oh-my-zsh bootstrap: agnoster theme, plugins (docker, git, z) |
| `system/env.zsh` | `EDITOR='cursor'` |
| `ntm/completion.zsh` | Guarded NTM shell integration |
| `system/aliases.zsh` | `ls` with color, `caf` (caffeinate) |

### Load Order

```
~/.zshrc (zsh/zshrc.symlink)
  1. Source ~/.localrc (private env vars)
  2. Glob all **/*.zsh from $DOTFILES
  3. Source */path.zsh first  → homebrew, go, cargo, system PATH
  4. Source */*.zsh (except path/completion)  → aliases, config, env, oh-my-zsh
  5. compinit  → initialize autocomplete
  6. Source */completion.zsh  → git, ruby, zsh completions
  7. Post-init: mise, bun, LM Studio, dcg check
```

### Oh-My-Zsh

- Theme: agnoster (with custom prompt override showing `kmc@hostname`)
- Plugins: docker, git, yarn, z
- Installed via `oh-my-zsh/install.sh` (uses `--unattended --keep-zshrc` to avoid overwriting symlink)

## Interfaces, APIs, and Contracts

### Adding a New Topic

1. Create directory: `mkdir mytopic/`
2. Add shell config: `mytopic/aliases.zsh` (auto-sourced)
3. Add PATH: `mytopic/path.zsh` (loaded first)
4. Add completion: `mytopic/completion.zsh` (loaded last)
5. Add installer: `mytopic/install.sh` (run by `script/install`)
6. Add dotfile: `mytopic/thing.symlink` → `~/.thing`

No registration needed. The naming convention handles discovery.

### Key Shell Aliases

| Alias | Command | Source |
|---|---|---|
| `gs` | `git status -sb` | `git/aliases.zsh` |
| `gl` | `git pull --prune` | `git/aliases.zsh` |
| `gp` | `git push origin HEAD` | `git/aliases.zsh` |
| `gd` | `git diff` (colored) | `git/aliases.zsh` |
| `gdm` | `git diff main...HEAD` | `git/aliases.zsh` |
| `gac` | `git add -A && git commit -m` | `git/aliases.zsh` |
| `d` | `docker` | `docker/aliases.zsh` |
| `d-c` | `docker-compose` | `docker/aliases.zsh` |
| `caf` | `caffeinate` | `system/aliases.zsh` |
| `reload!` | re-source `~/.zshrc` | `zsh/aliases.zsh` |

## Design Patterns and Conventions Used Here

- **Glob-based discovery**: `config_files=($DOTFILES/**/*.zsh)` with zsh array filtering
- **Three-pass loading**: path → config → completion (ensures PATH is set before tools are configured)
- **Re-symlink safety**: Bootstrap re-links after oh-my-zsh install to recover `~/.zshrc`
- **Conditional init**: Optional tools use guard clauses; completion-aware init like `ntm/completion.zsh` loads after `compinit` so generated `compdef` calls work correctly

## Code Examples and Gotchas

**Gotcha**: `oh-my-zsh/install.sh` used to overwrite `~/.zshrc`. Fixed by using `--keep-zshrc` flag and re-symlinking in bootstrap.

**Gotcha**: The glob `$DOTFILES/**/*.zsh` catches ALL `.zsh` files, including those in nested directories like `zellij/layouts/`. This is fine because KDL layout files don't have `.zsh` extensions.

**Adding private config**: Create `~/.localrc`:
```sh
export ANTHROPIC_API_KEY="sk-..."
export OPENAI_API_KEY="sk-..."
```

## Maintenance & Accretion

Update this doc when the load order changes, new oh-my-zsh plugins are added, or new post-init integrations are added to `zshrc.symlink`.
