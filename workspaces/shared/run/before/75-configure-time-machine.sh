#!/bin/sh

for path in ~/.vifm/Trash/ ; do
  if test -d ${path} ; then
    echo "Adding ${path} to Time Machine exclusion list"
    tmutil addexclusion ${path} || exit 1
  fi
done

exit 0
