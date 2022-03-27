#!/bin/sh
# My best attempt at detecting if XCode is installed.
# This will launch a GUI to install XCode CLI if needed
xcode-select --install 2>&1 | grep "already installed" > /dev/null
if test $? -ne 0 ; then
  # We need to update
  echo "Exiting to allow XCode CLI installation."
  exit 2
fi
# This is my best attempt at detecting if I need to appove the license.
xcodebuild -list >& /dev/null
if test $? -eq 69 ; then
  echo "Approving XCode license"
  sudo -n xcodebuild -license accept || exit 1
fi
exit 0
