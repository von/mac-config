#!/usr/bin/env bash
# Warn if last Time Machine backup is too old.
# Kudos: https://www.macworld.com/article/220774/control-time-machine-from-the-command-line.html

# Warn if older than one week
threshold=7

echo "Checking age of last Time Machine backup (will take a while)..."

tm_timestamp=$(tmutil latestbackup -t)

if test -z "${tm_timestamp}" ; then
  echo "Failed to get last backup time."
  # We might just be off of the home network, so don't make this
  # a failure.
  exit 0
fi

# Results in something like: 2023-02-11-172049
echo "Last backup was ${tm_timestamp}"

# Convert to epoch seconds
# Kudos: https://stackoverflow.com/a/38349184/197789
backup_seconds=$(date -j -f "%Y-%m-%d-%H%M%S" ${tm_timestamp} +"%s")

now_seconds=$( date +"%s" )

(( diff = ${now_seconds} - ${backup_seconds} ))
(( diff_days = diff / (24 * 60 * 60 ) ))

if (( ${diff_days} > ${threshold} )) ; then
  echo "Warning: last backup is ${diff_days} days old."
  exit 1
fi

echo "Last backup is ${diff_days} days old."
exit 0
