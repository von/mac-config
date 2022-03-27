#!/bin/sh

set -e

echo Disabling swipe to go back/forward. Restart of Chrome required.
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
exit 0
