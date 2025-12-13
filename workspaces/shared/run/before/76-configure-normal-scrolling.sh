#!/bin/sh

echo Configuring normal scrolling.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool FALSE && killall cfprefsd

exit 0
