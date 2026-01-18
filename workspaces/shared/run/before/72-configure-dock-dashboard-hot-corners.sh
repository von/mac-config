#!/bin/sh
# Kudos:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#   https://macowners.club/posts/brief-macos-dock-settings-terminal/
#   https://joshtronic.com/2024/12/15/set-dock-icon-size-on-macos-cli/
#
# See also: https://github.com/kcrawford/dockutil
#
# FYI:
# This removes all the settings. macOS recreates them with factory defaults
# defaults delete com.apple.dock

set -o errexit  # Exit on error

# We use the "MacConfigWasHere" to indicate we have configured the Dock.
# One can zero this value to force re-configuration, e.g.:
#   defaults write com.apple.doc MacConfigWasHere -int 0
#
_already_configued=$(defaults read com.apple.doc MacConfigWasHere)
if test "${_already_configued}" -eq 1 ; then
  echo "Dock already configured."
else
  echo "Configuring Dock."

  # Put Dock at bottom:
  defaults write com.apple.dock orientation bottom

  # Enable highlight hover effect for the grid view of a stack (Dock)
  defaults write com.apple.dock mouse-over-hilite-stack -bool true

  # Set the icon size of Dock items to 36 pixels
  defaults write com.apple.dock tilesize -int 36

  # Turn on magnification (options are "yes" or "no")
  defaults write com.apple.dock magnification -boolean yes

  # Change minimize/maximize window effect
  defaults write com.apple.dock mineffect -string "scale"

  # Do not minimize windows into their application’s icon
  defaults write com.apple.dock minimize-to-application -bool false

  # Enable spring loading for all Dock items
  defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

  # Show indicator lights for open applications in the Dock
  defaults write com.apple.dock show-process-indicators -bool true

  # Don’t animate opening applications from the Dock
  defaults write com.apple.dock launchanim -bool false

  # Speed up Mission Control animations
  defaults write com.apple.dock expose-animation-duration -float 0.1

  # Don’t group windows by application in Mission Control
  # (i.e. use the old Exposé behavior instead)
  defaults write com.apple.dock expose-group-by-app -bool false

  # Don’t show Dashboard as a Space
  defaults write com.apple.dock dashboard-in-overlay -bool true

  # Don’t automatically rearrange Spaces based on most recent use
  defaults write com.apple.dock mru-spaces -bool false

  # Remove the auto-hiding Dock delay
  defaults write com.apple.dock autohide-delay -float 0
  # Remove the animation when hiding/showing the Dock
  defaults write com.apple.dock autohide-time-modifier -float 0

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Make Dock icons of hidden applications translucent
  defaults write com.apple.dock showhidden -bool true

  # Disable the Launchpad gesture (pinch with thumb and three fingers)
  defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

  # Hot corners
  # Possible values:
  #  0: no-op
  #  2: Mission Control
  #  3: Show application windows
  #  4: Desktop
  #  5: Start screen saver
  #  6: Disable screen saver
  #  7: Dashboard
  # 10: Put display to sleep
  # 11: Launchpad
  # 12: Notification Center
  # Top left screen corner → Start screen saver
  defaults write com.apple.dock wvous-tl-corner -int 5
  defaults write com.apple.dock wvous-tl-modifier -int 0
  # Top right screen corner → Disable screen saver
  defaults write com.apple.dock wvous-tr-corner -int 6
  defaults write com.apple.dock wvous-tr-modifier -int 0
  # Bottom left screen corner → Mission Control
  defaults write com.apple.dock wvous-bl-corner -int 2
  defaults write com.apple.dock wvous-bl-modifier -int 0
  # Bottom right screen corner → Mission Control
  defaults write com.apple.dock wvous-br-corner -int 2
  defaults write com.apple.dock wvous-br-modifier -int 0

  # Set up applications in the Dock
  #
  # Start by removing all applications from the Dock
  # (Finder always seems to be present)
  # Kudos: https://apple.stackexchange.com/a/436311/104604
  defaults write com.apple.dock persistent-apps -array

  # Now add applications to the Doc
  # Note that additions are not idempotent, it is possible for an application to appear
  # multiple times.
  # Kudos: https://stackoverflow.com/a/23077911/197789
  for _app in \
    "/Applications/Google Chrome.app" \
    "/Applications/Hammerspoon.app" \
    "/Applications/iTerm.app" \
    ; do
    if test -e "${_app}" ; then
      defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${_app}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    else
      echo "Application does not exist: ${_app}"
    fi
  done

  echo "Restarting Dock so changes take effect."
  killall -HUP Dock

  # Indicate we have configued the Dock
  defaults write com.apple.doc MacConfigWasHere -int 1
fi

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

exit 0
