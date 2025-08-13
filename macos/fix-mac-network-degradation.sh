#!/bin/bash

# Mac Network Performance Fix Script
# Fixes gradual network degradation issues on macOS
# Run with: bash fix-mac-network-degradation.sh

echo "========================================="
echo "Mac Network Performance Fix"
echo "========================================="

# Function to run command with status
run_cmd() {
    echo "→ $1"
    eval $2
    if [ $? -eq 0 ]; then
        echo "  ✓ Success"
    else
        echo "  ⚠ Warning: Command may have failed"
    fi
    echo ""
}

echo "Starting network performance fixes..."
echo ""

# 1. Clear DNS Cache
echo "[1/8] Clearing DNS cache..."
run_cmd "Flushing DNS cache" "sudo dscacheutil -flushcache"
run_cmd "Restarting mDNSResponder" "sudo killall -HUP mDNSResponder"

# 2. Reset Network Interface
echo "[2/8] Resetting network interface..."
run_cmd "Bringing en0 down" "sudo ifconfig en0 down"
sleep 1
run_cmd "Bringing en0 up" "sudo ifconfig en0 up"

# 3. Disable AWDL (Apple Wireless Direct Link)
echo "[3/8] Disabling AWDL to prevent interference..."
run_cmd "Disabling AWDL" "sudo ifconfig awdl0 down"

# 4. Kill problematic services
echo "[4/8] Restarting problematic services..."
run_cmd "Restarting Apple Push Service" "sudo killall apsd 2>/dev/null || true"
run_cmd "Restarting Mail" "sudo killall Mail 2>/dev/null || true"
run_cmd "Restarting Cursor Helper" "killall 'Cursor Helper' 2>/dev/null || true"

# 5. Optimize TCP settings
echo "[5/8] Optimizing TCP buffer settings..."
run_cmd "Setting TCP send buffer" "sudo sysctl -w net.inet.tcp.sendspace=262144"
run_cmd "Setting TCP receive buffer" "sudo sysctl -w net.inet.tcp.recvspace=262144"
run_cmd "Disabling delayed ACK" "sudo sysctl -w net.inet.tcp.delayed_ack=0"

# 6. Reduce apsd aggressiveness
echo "[6/8] Reducing Apple Push Service aggressiveness..."
run_cmd "Setting max keepalive interval" "defaults write com.apple.apsd MaxKeepAliveInterval 1800"
run_cmd "Setting connection timeout" "defaults write com.apple.apsd PersistentConnectionIdleTimeout 60"

# 7. Disable background activities
echo "[7/8] Disabling unnecessary background activities..."
run_cmd "Disabling Mail auto-fetch" "defaults write com.apple.mail AutoFetch -bool false"
run_cmd "Disabling TCP keepalive in sleep" "sudo pmset -a tcpkeepalive 0"

echo "========================================="
echo "Network fixes applied successfully!"
echo "========================================="
echo ""
echo "Your network performance should improve now."
echo "If issues persist, try rebooting your Mac."
echo ""
echo "To re-enable AWDL (for AirDrop/AirPlay): sudo ifconfig awdl0 up"
