#!/bin/sh
# Disable chime on startup
# Kudos: https://osxdaily.com/2020/04/29/how-enable-startup-boot-sound-newer-mac/
set -e

nvram -p | grep StartupMute | grep "%01" > /dev/null
if test $? -ne 0 ; then
  echo "Disable chime on boot"
  sudo nvram StartupMute=%01
fi

exit 0
