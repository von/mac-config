#!/usr/bin/env bash
# Pin some Homebrew casks so that Homebrewk doesn't try to update them
casks_to_pin="google-chrome signal slack"

for cask in ${casks_to_pin} ; do
  brew list --pinned | grep ${cask} > /dev/null
  if test $? -ne 0 ; then
    echo "Pinning Homebrew cask ${cask}"
    brew pin ${cask}
  fi
done
exit 0
