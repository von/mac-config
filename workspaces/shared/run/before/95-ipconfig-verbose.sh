#!/usr/bin/env bash
# Set up ipconfig to be verbose so we can get SSID.
# Kudos:
# https://discussions.apple.com/thread/256108303?answerId=261575020022&sortBy=rank#261575020022

# We use the "MacConfigWasHere" to indicate we have configured the Dock.
# One can zero this value to force re-configuration, e.g.:
#   defaults write com.apple.doc MacConfigWasHere -int 0
#
_already_configued=$(defaults read com.apple.doc MacConfigWasHere)
if test "${_already_configued}" -eq 1 ; then
  echo "mac-config already run."
else
  echo "Setting 'ipconfig setverbose 1' to allow getting SSID"
  sudo ipconfig setverbose 1
fi
