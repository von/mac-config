#!/bin/sh
# Disable chime on startup
# Kudos: https://osxdaily.com/2020/04/29/how-enable-startup-boot-sound-newer-mac/
set -e

if test $(nvram StartupMute) != "%01" ; then
  echo "Disable chime on boot"
  sudo nvram StartupMute=%01
fi

exit 0
