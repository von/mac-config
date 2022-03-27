#!/bin/sh
# Set the timezone
# See `sudo systemsetup -listtimezones` for other values
set -e
mytimezone="America/Indiana/Indianapolis"
currenttimezone=$(sudo -n systemsetup -gettimezone | sed -e "s/Time Zone: //")
if test "${mytimezone}" != "${currenttimezone}" ; then
  echo "Setting timezone to ${mytimezone}"
  sudo -n systemsetup -settimezone "${mytimezone}"
fi
exit 0
