# ai-cli: launch cmux AI coding workspace
# Uses codex+claude layout if codex is installed, otherwise claude-only
function ai-cli() {
    if ! command -v cmux &> /dev/null; then
        echo "cmux not installed. Run: ~/.dotfiles/cmux/install.sh"
        return 1
    fi

    # Open command palette with "AI" pre-filtered — user picks the workspace
    # Or launch directly via CLI:
    if command -v codex &> /dev/null; then
        cmux new-workspace --name "AI Coding" --command "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions"
    else
        cmux new-workspace --name "Claude" --command "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions"
    fi
}

# claude-teams: launch Claude Code with native cmux teammate splits
function claude-teams() {
    if ! command -v cmux &> /dev/null; then
        echo "cmux not installed. Run: ~/.dotfiles/cmux/install.sh"
        return 1
    fi
    cmux claude-teams "$@"
}

# cmux-swarm: quick 2x2 agent grid (flywheel-style)
function cmux-swarm() {
    if ! command -v cmux &> /dev/null; then
        echo "cmux not installed. Run: ~/.dotfiles/cmux/install.sh"
        return 1
    fi
    # Create workspace, then split into a 2x2 grid
    cmux new-workspace --name "Swarm" --command "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions"
    sleep 1
    cmux new-split right
    cmux send-surface --surface "$(cmux identify --json | jq -r '.surfaceId')" "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions"
    cmux send-key-surface --surface "$(cmux identify --json | jq -r '.surfaceId')" enter
}
