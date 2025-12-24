#!/bin/bash

# DisplayLink Display Fix Script
# Fixes issues when docking/undocking with DisplayLink monitors

LOG_FILE="$HOME/Library/Logs/displaylink-fix.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log_message "=== Display fix script started ==="

# Wait a moment for USB devices to settle
sleep 2

# Restart DisplayLink Manager service
log_message "Restarting DisplayLink Manager..."
killall "DisplayLinkManager" 2>/dev/null
sleep 1

# The DisplayLink app should auto-restart, but we can help it along
open -a "DisplayLinkManager" 2>/dev/null || log_message "DisplayLinkManager not found in Applications"

# Wait for DisplayLink to initialize
sleep 3

# Detect all displays and force refresh
log_message "Detecting displays..."
system_profiler SPDisplaysDataType >> "$LOG_FILE" 2>&1

# Force macOS to re-detect displays using displayplacer (if installed)
# This is optional but very effective
if command -v displayplacer &> /dev/null; then
    log_message "Using displayplacer to refresh displays..."
    displayplacer list >> "$LOG_FILE" 2>&1
else
    log_message "displayplacer not installed (optional)"
fi

# Alternative: Use built-in display detection
# This simulates pressing Cmd+F1 (Detect Displays)
log_message "Triggering display detection..."
/System/Library/PrivateFrameworks/DisplayServices.framework/Versions/A/Resources/display_detector 2>/dev/null || log_message "display_detector not available"

# Additional fix: Restart Dock and WindowServer if issues persist
# Uncomment these if you need more aggressive fixes (will cause brief screen flash)
# killall Dock
# sudo killall -HUP WindowServer

log_message "Display fix completed"
log_message "==================================="

exit 0
