#!/usr/bin/env bash
#
# Configure Spotlight
#
set -o errexit  # Exit on error

# Check to see if indexing of '/' is enabled
indexing_status=$(mdutil -s /)
case "${indexing_status}" in
  *enabled*)
    echo "Indexing for / enabled."
    ;;
  *unknown*)
    echo "Turning spotlight on for '/'"
    sudo mdutil -i on /
    ;;
  *)
    echo "Unrecognized state of indexing for /: ${indexing_status}"
    ;;
esac

exit 0
