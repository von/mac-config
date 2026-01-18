#!/bin/sh

set -e

# Remove any files in vifm trash not modified in last 30 days
vifm_trash="/Users/von/.local/share/vifm/Trash"

if test -d "${vifm_trasj}" ; then
  find "${vifm_trash}" -mtime +30d -type f -print -exec rm -f "{}" \;
  # And remove any empty directories
  # Kudos: http://www.thegeekstuff.com/2010/03/find-empty-directories-and-files/
  # The '-prune' prevents an error as find attempts to recurse into the
  # directory it just deleted.
  # '-mindepth 1' so we don't delete the Trash/ directory itself.
  find "${vifm_trash}" -type d -empty -mindepth 1 -print -exec rmdir "{}" \; -prune
else
  echo "No vifm Trash directory found."
fi
exit 0
