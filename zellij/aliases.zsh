# ai-cli: launch zellij with ai-coding layout
# Uses codex+claude layout if codex is installed, otherwise claude-only
function ai-cli() {
    if command -v codex &> /dev/null; then
        zellij --layout ai-coding
    else
        zellij --layout ai-coding-claude-only
    fi
}
