#!/usr/bin/env bash
# Check for available disk space on main system disk

# Warn if free space is below this percentage
warning_threshold="20"

# Filesystem to check
filesystem_to_check="/"

# Kudos: https://apple.stackexchange.com/a/325721/104604
#
# df arguments:
#   -m      Use megabyte blocks
size=$(df -m ${filesystem_to_check} | tail -1 | awk '{printf("%s", $2)}')
# used=$(df -m ${filesystem_to_check} | tail -1 | awk '{printf("%s", $3)}')
available=$(df -m ${filesystem_to_check} | tail -1 | awk '{printf("%s", $4)}')
percent_available=$(bc <<< "scale=2; 100 * ${available} / ${size}")

echo "${available}/${size} MB available on ${filesystem_to_check}"
echo "${percent_available} percent available"

# Will be "0" or "1"
warn=$(bc -l <<< "${percent_available} < ${warning_threshold}")
if test "${warn}" -eq 0 ; then
  echo "All is good."
else
  echo "Warning: free space below ${warning_threshold}%"
fi

exit 0
