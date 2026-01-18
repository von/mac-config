#!/usr/bin/env bash
# Kudos: https://apple.stackexchange.com/a/287775/104604

_hostname="Vons-PL"
_current_hostname=$(scutil --get HostName)

if test "${_current_hostname}" == "${_hostname}" ; then
  echo "Hostname already set: ${_current_hostname}"
else
  echo "Setting hostname to ${_hostname} from ${_current_hostname}"

  set -o errexit  # Exit on error

  # primary hostname
  sudo scutil --set HostName "${_hostname}"

  # Bonjour hostname
  sudo scutil --set LocalHostName "${_hostname}"

  # computer name
  # This is the user-friendly computer name you see in Finder.
  sudo scutil --set ComputerName "${_hostname}"

  dscacheutil -flushcache

  # XXX Restart may be required.
fi

exit 0
