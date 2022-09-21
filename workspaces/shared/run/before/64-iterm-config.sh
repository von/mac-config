#!/bin/sh
# Kudos: https://github.com/mathiasbynens/dotfiles/blob/master/.osx

set -o errexit  # Exit on error

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

exit 0
