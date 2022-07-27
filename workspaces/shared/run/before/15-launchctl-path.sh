#!/usr/bin/env bash
# Add /usr/local/bin and ~/bin to my default path in OSX GUI
# Kudos: https://stackoverflow.com/a/32902449/197789
# XXX This doesn't see to work
#
set -o errexit  # Exit on error

_path="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/bin"
if test -n "${HOMEBREW_PREFIX}" ; then
  _path="${_path}:${HOMEBREW_PREFIX}/bin"
fi
if test "${_path}" != "$(launchctl getenv PATH)" ; then
  echo "Setting default path via launchctl: ${_path}"
  echo "Reboot required to take effect."
  sudo launchctl config user path "${_path}"
fi
exit 0
