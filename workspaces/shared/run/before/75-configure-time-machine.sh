#!/bin/sh

for path in ~/.vifm/Trash/ ; do
  if test -d ${path} ; then
    # Adding a path takes time so it is worth testing first
    tmutil isexcluded ${path} | grep "\[Excluded\]" > /dev/null
    if test $? -eq 0 ; then
      echo "Already excluded from Time Machine: ${path}"
    else
      echo "Adding ${path} to Time Machine exclusion list"
      tmutil addexclusion ${path} || exit 1
    fi
  fi
done

exit 0
