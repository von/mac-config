#!/bin/sh
# Find and add homebrew bin/ and sbin/ to PATH
# Kudos: http://stackoverflow.com/a/12133341/197789
# Note this just gets them into the path after /usr/bin and /usr/sbin
# which will cause warnings from 'brew doctor'
if test ! -f /etc/paths.d/homebrew ; then
  for prefix in /usr/local/ /opt/homebrew/ ; do
    if test -x "${prefix}/bin/brew" ; then 
      echo "Creating /etc/paths.d/homebrew with ${path}"
      cmd="echo \"${prefix}bin:${prefix}sbin\" > /etc/paths.d/homebrew"
      echo $cmd
      sudo -n bash -c "${cmd}" || exit 1
      break
    fi
  done
fi
exit 0
