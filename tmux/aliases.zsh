# ai-cli: launch tmux with AI coding layout
# Open a terminal, type ai-cli, get your panes. That's it.
function ai-cli() {
    if ! command -v tmux &> /dev/null; then
        echo "tmux not installed. Run: brew install tmux"
        return 1
    fi

    local session_name="ai-$(date +%H%M%S)"
    local claude_cmd="CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions"

    # Create session — Claude in first pane
    tmux new-session -d -s "$session_name"
    tmux send-keys -t "$session_name" "$claude_cmd" C-m

    if command -v codex &> /dev/null; then
        # Right pane: Codex
        tmux split-window -h -t "$session_name"
        tmux send-keys -t "$session_name" "codex" C-m
        # Bottom-right: Shell
        tmux split-window -v -t "$session_name"
    else
        # Right pane: Shell
        tmux split-window -h -t "$session_name"
    fi

    # Focus Claude pane (leftmost)
    tmux select-pane -t "$session_name:1.1"
    tmux attach-session -t "$session_name"
}

# ai-swarm: multi-agent workspace — 2x Claude + Codex + Shell
function ai-swarm() {
    if ! command -v tmux &> /dev/null; then
        echo "tmux not installed. Run: brew install tmux"
        return 1
    fi

    local session_name="swarm-$(date +%H%M%S)"
    local claude_cmd="CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions"

    # Top-left: Claude-1
    tmux new-session -d -s "$session_name"
    tmux send-keys -t "$session_name" "$claude_cmd" C-m

    # Top-right: Claude-2
    tmux split-window -h -t "$session_name"
    tmux send-keys -t "$session_name" "$claude_cmd" C-m

    # Bottom-right: Shell
    tmux split-window -v -t "$session_name"

    # Bottom-left: Codex or Shell
    tmux select-pane -t "$session_name:1.1"
    tmux split-window -v -t "$session_name"
    if command -v codex &> /dev/null; then
        tmux send-keys -t "$session_name" "codex" C-m
    fi

    # Focus first Claude pane
    tmux select-pane -t "$session_name:1.1"
    tmux attach-session -t "$session_name"
}
