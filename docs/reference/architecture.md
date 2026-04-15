# Architecture

## System Map

```
~/.dotfiles/
├── AGENTS.md              # Agent guidelines (router)
├── CLAUDE.md              # Claude pointer
├── README.md              # Human-facing setup guide
├── Brewfile               # Core Homebrew dependencies
├── docs/                  # Documentation suite
├── script/
│   ├── bootstrap          # Fresh machine setup
│   └── install            # Run all topic installers
├── bin/                   # Executables added to $PATH (30+ scripts)
├── [topic]/               # One directory per domain
│   ├── *.zsh              # Auto-sourced shell config
│   ├── path.zsh           # PATH setup (loaded first)
│   ├── completion.zsh     # Autocomplete (loaded last)
│   ├── *.symlink          # Symlinked to $HOME
│   └── install.sh         # Optional installer
└── zsh/zshrc.symlink      # Shell entry point → ~/.zshrc
```

## Topics

| Topic | Purpose | Has install.sh | Has aliases |
|---|---|---|---|
| agents | AI agent tooling (beads) | no (separate Brewfile) | yes (empty) |
| atuin | Shell history sync | no | yes (env.zsh) |
| cmux | **Deprecated** (replaced by tmux) | yes (no-op) | yes (empty) |
| codex | Codex AI alias | no | yes |
| docker | Docker aliases | no | yes |
| editors | Windsurf PATH | no | yes |
| fonts | Nerd fonts | yes | no |
| functions | Zsh utility functions | no | no |
| ghostty | Terminal config | yes | no |
| git | Git config, aliases, completion | no | yes |
| go | Go environment | no | yes (path.zsh) |
| homebrew | Homebrew setup | yes | yes (path.zsh) |
| iterm2 | Color schemes | yes | no |
| macos | System defaults, fixes | no (scripts only) | no |
| ngrok | Tunnel alias | no | yes |
| ntm | NTM shell integration | no | no |
| oh-my-zsh | Framework setup | yes | yes (index.zsh) |
| ruby | Ruby/rbenv config | no | yes |
| system | Core aliases, env, keys, grc | no | yes |
| tmux | Tmux config + AI coding workspaces | yes | yes |
| vim | Vim with Vundle | yes | no |
| vscode | VS Code + extensions | yes | no |
| xcode | iOS simulator alias | no | yes |
| zellij | **Deprecated** (replaced by tmux) | yes (no-op) | yes (empty) |
| zsh | Core shell config | no | yes |

## Install Flow

### Fresh Machine (`script/bootstrap`)

```
1. Set working directory to ~/.dotfiles
2. Prompt for git author name/email → git/gitconfig.local.symlink
3. Symlink all *.symlink files to $HOME
4. Install Homebrew (Apple Silicon aware)
5. Run bin/dot:
   a. git pull (update dotfiles)
   b. macos/set-defaults.sh
   c. macos/set-hostname.sh
   d. homebrew/install.sh
   e. brew update && brew upgrade
   f. script/install (all topic install.sh scripts)
6. Re-symlink dotfiles (oh-my-zsh overwrites ~/.zshrc)
```

### Periodic Update (`bin/dot`)

Steps 5a-5f above. Run `dot` to keep everything fresh.

### Agent Tools (optional)

```sh
brew bundle --file=~/.dotfiles/agents/Brewfile
```

## Shell Load Order

Defined in `zsh/zshrc.symlink`:

```
1. ~/.localrc                    # Private env vars (if exists)
2. */path.zsh                    # PATH setup (homebrew, go, cargo, system)
3. */*.zsh                       # Everything else (aliases, config, env)
4. compinit                      # Initialize autocomplete
5. */completion.zsh              # Completion scripts (git, ruby, zsh)
6. Post-init: mise, bun, LM Studio, dcg check
```

## Symlink Transform

```
zsh/zshrc.symlink → ~/.zshrc
git/gitconfig.symlink → ~/.gitconfig
vim/vimrc.symlink → ~/.vimrc
```

Rule: strip `.symlink` suffix, add `.` prefix, place in `$HOME`.

## Tech Stack

| Layer | Tool |
|---|---|
| Shell | zsh + oh-my-zsh (agnoster theme) |
| Terminal | Ghostty + tmux |
| Editor | Cursor (`$EDITOR`), VS Code, Vim |
| Package manager | Homebrew |
| Tool versions | mise |
| AI coding | Claude Code (agent teams), Codex |
| Agent orchestration | tmux sessions, NTM |
| Agent memory | beads (`bd`) |
| Git | gh CLI credential helper, pull rebase |

## Maintenance & Accretion

Update this doc when the install flow changes, new topics are added, or the tech stack shifts. The topic table should reflect the actual directory listing.
