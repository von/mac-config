#!/usr/bin/env bash
# Add /usr/local/bin and ~/bin to my default path in OSX GUI
# Kudos: https://stackoverflow.com/a/32902449/197789
# XXX This doesn't see to work
#
set -o errexit  # Exit on error

echo "Adding /usr/local/bin and $HOME/bin to default path via launchctl"
echo "Reboot required to take effect."
sudo launchctl config user path /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/bin
exit 0
