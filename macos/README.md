# Mac Network Degradation Fixes

## Problem Description
macOS network performance degrades over time, with internet speeds becoming progressively slower despite other devices on the same network maintaining normal speeds. Performance temporarily improves after restart but degrades again.

## Root Causes
1. **apsd (Apple Push Service Daemon)** - Creates persistent connections that degrade over time
2. **AWDL interference** - Apple Wireless Direct Link causes channel interference
3. **DNS cache poisoning** - DNS cache becomes corrupted over time
4. **TCP buffer congestion** - Default TCP settings not optimized for modern networks
5. **Background services** - Mail and other services creating excessive network traffic

## Diagnostic Commands

### Check Network Configuration
```bash
# View network interfaces
ifconfig | grep -A 5 "en0\|en1"

# Check DNS settings
scutil --dns | head -20

# View active connections count
netstat -an | grep ESTABLISHED | wc -l
```

### Monitor Network Traffic
```bash
# See bandwidth usage by process
nettop -P -L 1 -J bytes_in,bytes_out -t wifi -m tcp

# Check Wi-Fi signal strength
system_profiler SPAirPortDataType | grep -A 10 "Current Network Information"

# Test latency and packet loss
ping -c 10 8.8.8.8
```

### Check System Resources
```bash
# Memory statistics
vm_stat | head -10
memory_pressure | head -5

# Swap usage
sysctl vm.swapusage

# TCP settings
sysctl net.inet.tcp | grep -E "sendspace|recvspace|delayed_ack"
```

## Manual Fixes

### 1. DNS and Network Reset
```bash
# Clear DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Reset network interface
sudo ifconfig en0 down
sudo ifconfig en0 up
```

### 2. Disable Interfering Services
```bash
# Disable AWDL (affects AirDrop/AirPlay)
sudo ifconfig awdl0 down
```

### 3. Restart Problematic Services
```bash
# Kill and restart Apple Push Service
sudo killall apsd

# Restart Mail app
sudo killall Mail

# Kill Cursor Helper processes
killall "Cursor Helper"
```

### 4. Optimize TCP Settings
```bash
# Increase TCP buffer sizes (default is 131072)
sudo sysctl -w net.inet.tcp.sendspace=262144
sudo sysctl -w net.inet.tcp.recvspace=262144

# Disable delayed ACK for better responsiveness
sudo sysctl -w net.inet.tcp.delayed_ack=0
```

### 5. Reduce apsd Aggressiveness
```bash
# Increase keepalive interval (30 minutes)
defaults write com.apple.apsd MaxKeepAliveInterval 1800

# Reduce connection timeout (60 seconds)
defaults write com.apple.apsd PersistentConnectionIdleTimeout 60

# Restart apsd to apply changes
sudo killall apsd
```

### 6. Disable Background Activities
```bash
# Disable Mail auto-fetch
defaults write com.apple.mail AutoFetch -bool false

# Disable TCP keepalive during sleep
sudo pmset -a tcpkeepalive 0
```

## Automated Script
Save the included `fix-mac-network-degradation.sh` script to your dotfiles and run it when experiencing network degradation:

```bash
# Make executable
chmod +x ~/dotfiles/fix-mac-network-degradation.sh

# Run the fix
~/dotfiles/fix-mac-network-degradation.sh
```

## When to Use Each Fix

| Symptom | Recommended Fix |
|---------|----------------|
| Slow DNS resolution | Clear DNS cache, restart mDNSResponder |
| High latency | Disable AWDL, optimize TCP settings |
| Gradual slowdown | Kill apsd, reduce its aggressiveness |
| High bandwidth usage | Check nettop, kill problematic processes |
| Poor Wi-Fi performance | Disable AWDL, check signal strength |

## Permanent Solutions

### Make TCP Settings Persistent
Create `/etc/sysctl.conf`:
```bash
net.inet.tcp.sendspace=262144
net.inet.tcp.recvspace=262144
net.inet.tcp.delayed_ack=0
```

### Create Launch Agent for Regular Fixes
Create `~/Library/LaunchAgents/com.user.networkfix.plist`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.networkfix</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>~/dotfiles/fix-mac-network-degradation.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>7200</integer>
</dict>
</plist>
```

Load it with:
```bash
launchctl load ~/Library/LaunchAgents/com.user.networkfix.plist
```

## Understanding the Services

### AWDL (Apple Wireless Direct Link)
- **Purpose**: Enables AirDrop, AirPlay, Handoff
- **Problem**: Creates channel interference with main Wi-Fi
- **Safe to disable**: Yes, if not using Apple continuity features

### apsd (Apple Push Service Daemon)
- **Purpose**: Handles all Apple push notifications (iMessage, Mail, iCloud)
- **Problem**: Creates persistent connections that degrade
- **Safe to disable**: Partially - limiting is better than disabling

### mDNSResponder
- **Purpose**: Handles DNS resolution and Bonjour services
- **Problem**: DNS cache becomes corrupted
- **Safe to restart**: Yes, always safe

## Verification Commands

After running fixes, verify improvements:
```bash
# Check connection count decreased
netstat -an | grep ESTABLISHED | wc -l

# Verify AWDL is disabled
ifconfig awdl0

# Test speed
curl -o /dev/null http://speedtest.tele2.net/10MB.zip

# Check latency improvement
ping -c 10 8.8.8.8
```

## Alternative DNS Servers

If Google DNS (8.8.8.8) is slow, try:
- **Cloudflare**: 1.1.1.1, 1.0.0.1
- **Quad9**: 9.9.9.9, 149.112.112.112
- **OpenDNS**: 208.67.222.222, 208.67.220.220

Change in System Settings > Network > Wi-Fi > Details > DNS

## Nuclear Options

If nothing else works:

### Reset Network Configuration Completely
```bash
sudo rm /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist
sudo rm /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist
sudo rm /Library/Preferences/SystemConfiguration/com.apple.wifi.message-tracer.plist
sudo rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
sudo rm /Library/Preferences/SystemConfiguration/preferences.plist
```
Then restart Mac.

### Reset SMC and NVRAM
1. **SMC Reset**: Shut down → Press Shift-Control-Option (left side) + Power for 10 seconds
2. **NVRAM Reset**: Restart → Hold Command-Option-P-R until you hear startup sound twice

## Related Issues
- If using VPN, check for DNS leaks
- Corporate proxies may interfere with apsd
- Some antivirus software creates network filters that degrade
- Docker Desktop can cause network issues with its vpnkit