# dotfiles

Topic-centric dotfiles for macOS. Forked from [holman/dotfiles](https://github.com/holman/dotfiles).

## fresh machine setup

```sh
# 1. install xcode command line tools
xcode-select --install

# 2. clone and bootstrap
git clone https://github.com/kmctown/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

`script/bootstrap` will:
- prompt for git author name/email
- symlink all `*.symlink` files to `$HOME`
- install Homebrew (Apple Silicon compatible)
- run `macos/set-defaults.sh` (key repeat, Finder, trackpad, etc.)
- run all `topic/install.sh` scripts (oh-my-zsh, fonts, vim, cmux, etc.)

## post-install

```sh
# set macos defaults (keyboard, Finder, trackpad, dock, etc.)
macos/set-defaults.sh

# install mise (tool version manager) - replaces pyenv/nvm/rbenv
curl https://mise.run | sh

# create ~/.localrc for private env vars (API keys, tokens, etc.)
touch ~/.localrc
```

### optional: AI tooling

```sh
# agent tools (beads, go, rust, node, uv)
brew bundle --file=~/.dotfiles/agents/Brewfile

# cmux AI coding workspace (claude + codex + shell)
ai-cli

# or use native Claude Code teammate splits
claude-teams
```

## how it works

Everything is organized by topic. Add a `java/` directory and drop files in - it just works.

| Convention | Behavior |
|---|---|
| `topic/*.zsh` | Auto-loaded into shell |
| `topic/path.zsh` | Loaded first (for `$PATH`) |
| `topic/completion.zsh` | Loaded last (for autocomplete) |
| `topic/*.symlink` | Symlinked to `$HOME` as dotfiles |
| `topic/install.sh` | Run by `script/install` |
| `bin/*` | Added to `$PATH` |

### load order

1. `~/.localrc` (private env vars)
2. `*/path.zsh` (PATH setup)
3. `*/*.zsh` (aliases, config, env)
4. `*/completion.zsh` (autocomplete)
5. mise, bun, LM Studio paths

## what's inside

### shell & editor
- **zsh** - oh-my-zsh with agnoster theme, plugins: docker, git, z
- **vim** - Vundle + airline + NERDTree + vim-go + YouCompleteMe
- **git** - aliases (`gs`, `gl`, `gp`, `gd`, `gdm`, `gac`), gh credential helper

### dev tools
- **homebrew** - Apple Silicon path setup, auto-install
- **go** - GOPATH config
- **rust** - cargo bin path
- **node** - npm setup
- **docker** - aliases (`d`, `d-c`)

### AI coding
- **claude** - `cca` alias (agent teams mode)
- **codex** - `codex` alias (yolo mode)
- **cmux** - native macOS terminal for multi-agent coding (replaces zellij)
  - `ai-cli` — workspace with Claude + Codex + shell
  - `claude-teams` — Claude Code with native teammate splits
  - `cmux-swarm` — multi-agent grid (flywheel-style)
  - Custom commands in command palette (Cmd+Shift+P): "AI Coding", "Agent Swarm"
- **agents** - beads (`bd`) for agent memory

### macOS
- **set-defaults.sh** - fast key repeat, Finder list view, trackpad, screenshots, etc.
- **fix-displays.sh** - DisplayLink dock/undock fix
- **fix-mac-network-degradation.sh** - DNS flush, TCP tuning, AWDL disable ([details](macos/README.md))

### key aliases

| Alias | Command |
|---|---|
| `gs` | `git status -sb` |
| `gl` | `git pull --prune` |
| `gp` | `git push origin HEAD` |
| `gdm` | `git diff main...HEAD` |
| `gac` | `git add -A && git commit -m` |
| `cca` | claude agent teams (skip permissions) |
| `ai-cli` | cmux AI coding workspace |
| `claude-teams` | cmux native Claude teammate splits |
| `cmux-swarm` | multi-agent grid workspace |
| `caf` | caffeinate (prevent sleep) |
| `ng` | ngrok to k2kris.ngrok.dev |

### useful bin/ scripts

| Script | What it does |
|---|---|
| `dot` | Re-run installers, update everything |
| `e` | Open in $EDITOR |
| `extract` | Extract any archive format |
| `git-nuke` | Delete branch locally + remotely |
| `git-delete-local-merged` | Clean up merged branches |
| `dns-flush` | Flush DNS cache |

## updating

Run `dot` periodically to re-run installers and keep things fresh.

## credits

Originally forked from [Zach Holman's dotfiles](https://github.com/holman/dotfiles), inspired by [Ryan Bates'](https://github.com/ryanb/dotfiles).
