#!/bin/sh
# Configure applications in the Dock

set -o errexit  # Exit on error

_already_configued=$(defaults read com.vwelch.macconfig MacConfigWasHere)
if test "${_already_configued}" -eq 1 ; then
  echo "Dock already configured."
else
  echo "Configuring applications in the Dock."


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
  defaults write com.vwelch.macconfig MacConfigWasHere -int 1
fi

exit 0
