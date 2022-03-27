#!/bin/sh

echo Disable Time Machine from prompting to use new Hard Drives for backup
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true || exit 1

for path in ~/.vifm/Trash/ ; do
  if test -d ${path} ; then
    echo "Adding ${path} to Time Machine exclusion list"
    tmutil addexclusion ${path} || exit 1
  fi
done

exit 0
