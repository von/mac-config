#!/bin/sh

set -e

# Remove any files in ~/Downloads/ not modified in last 30 days
find ~/Downloads/ -mtime +30d -type f -print -exec rm -f "{}" \;
# And remove any empty directories
# Kudos: http://www.thegeekstuff.com/2010/03/find-empty-directories-and-files/
# The '-prune' prevents an error as find attempts to recurse into the
# directory it just deleted.
find ~/Downloads/ -type d -empty -print -exec rmdir "{}" \; -prune
exit 0
