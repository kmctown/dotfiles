# macOS Configuration

## Purpose

System defaults, hostname management, and troubleshooting scripts for macOS. Applied during bootstrap and periodic `dot` updates.

## How It Works

### Key Files

| File | Purpose |
|---|---|
| `macos/set-defaults.sh` | System preferences via `defaults write` |
| `macos/set-hostname.sh` | Set machine hostname |
| `macos/fix-displays.sh` | DisplayLink dock/undock fix |
| `macos/fix-mac-network-degradation.sh` | DNS flush, TCP tuning, AWDL disable |
| `macos/README.md` | Network troubleshooting guide |

### Defaults Applied

**Keyboard**: fast key repeat (`KeyRepeat -int 2`), disable press-and-hold, disable autocorrect/autocap/smart quotes.

**Finder**: list view default, show `~/Library`, expanded save/print panels.

**Trackpad**: bottom-right corner click, two-finger click.

**General**: natural scrolling disabled, fast window resize.

### Execution

`macos/set-defaults.sh` is called by `bin/dot` on every update. Changes take effect immediately for most settings; some require logout or restart.

## Interfaces, APIs, and Contracts

### Scripts

All scripts in `macos/` are standalone — they can be run independently:
```sh
macos/set-defaults.sh      # Apply all defaults
macos/set-hostname.sh      # Set hostname interactively
macos/fix-displays.sh      # Fix DisplayLink issues
macos/fix-mac-network-degradation.sh  # Network troubleshooting
```

### bin/ shortcut

`bin/set-defaults` runs `macos/set-defaults.sh`.

## Design Patterns and Conventions Used Here

- **Domain-specific writes**: Each `defaults write` targets a specific preference domain (e.g., `com.apple.Finder`, `NSGlobalDomain`)
- **No conditional logic**: Defaults are applied unconditionally — they represent the desired state
- **Separate fix scripts**: Troubleshooting scripts are distinct from defaults (fixes are run on-demand, not on every update)

## Code Examples and Gotchas

**Gotcha**: `set-defaults.sh` runs on every `dot` invocation. If you manually change a macOS preference, it will be reverted next time you run `dot`.

**Gotcha**: Some defaults require specific app restarts (Finder, Dock) or full logout to take effect.

## Maintenance & Accretion

Update this doc when macOS defaults are added/removed or new fix scripts are created. The defaults list should match what `set-defaults.sh` actually applies.
