#!/usr/bin/env bash

# Unlimited Scrollback
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Unlimited Scrollback' true" ~/Library/Preferences/com.googlecode.iTerm2.plist

# Mute bell
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Silence Bell' true" ~/Library/Preferences/com.googlecode.iTerm2.plist

# Import Solarized Theme
/usr/libexec/PlistBuddy -c "Add 'Custom Color Presets':'Solarized Dark' dict" ~/Library/Preferences/com.googlecode.iTerm2.plist
/usr/libexec/PlistBuddy -c "Merge '$DOTFILES/iterm2/Solarized Dark.itermcolors' 'Custom Color Presets':'Solarized Dark'" ~/Library/Preferences/com.googlecode.iTerm2.plist

# reset the preferences cache
killall cfprefsd
