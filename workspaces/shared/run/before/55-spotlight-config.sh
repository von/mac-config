#!/usr/bin/env bash
#
# Configure Spotlight
#
set -o errexit  # Exit on error

mdutil -s / | grep enabled > /dev/null

if test $? -ne 0 ; then
  echo "Turning spotlight on for '/'"
  sudo mdutil -i on /
fi

exit 0
