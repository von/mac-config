#!/usr/bin/env bash
# Warn if last Time Machine backup is too old.
# Kudos: https://www.macworld.com/article/220774/control-time-machine-from-the-command-line.html

# Warn if older than one week
threshold=7

echo "Checking age of last Time Machine backup..."

# 'tmutil lastbackup' requires that the Time Machine volume be present.
# Instead we get the last backiup from logs.
# Kudos: https://superuser.com/a/1846629/128341
tm_timestamp=$(/usr/libexec/PlistBuddy -c "Print Destinations:0:SnapshotDates" /Library/Preferences/com.apple.TimeMachine.plist | tail -n 2 | head -n 1 | awk '{$1=$1};1')

if test -z "${tm_timestamp}" ; then
  echo "Failed to get last backup time."
  exit 1
fi

# Results in something like: 2023-02-11-172049
echo "Last backup was ${tm_timestamp}"

# Convert to epoch seconds
# tm_timestamp format is, e.g.: Wed May 06 16:05:53 EST 2026
# Kudos: https://stackoverflow.com/a/38349184/197789
backup_seconds=$(date -j -f "%a %b %d %T %Z %Y" "${tm_timestamp}" +"%s")
if test -z "${backup_seconds}" ; then
  echo "Failed to parse backup time: $tm_timestamp"
  exit 1
fi

now_seconds=$( date +"%s" )

(( diff = ${now_seconds} - ${backup_seconds} ))
(( diff_days = diff / (24 * 60 * 60 ) ))

if (( ${diff_days} > ${threshold} )) ; then
  echo "Warning: last backup is ${diff_days} days old."
  exit 1
fi

echo "Last backup is ${diff_days} days old."
exit 0
