#!/bin/sh
# Set the timezone
# See `sudo systemsetup -listtimezones` for other values
set -e
mytimezone="America/Indiana/Indianapolis"
# Non-sudo test kudos: https://apple.stackexchange.com/a/117995/104604
#   (See comment from Jon Church)
tz=$(date +"%Z")
if test "$tz" != "EDT" -a "$tz" != "EST" ; then
  echo "Setting timezone to ${mytimezone}"
  sudo systemsetup -settimezone "${mytimezone}"
fi
exit 0
