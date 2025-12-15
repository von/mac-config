#!/usr/bin/env bash
#
# Back up select files to Google Drive

set -o errexit  # Exit on error

backup_path="${HOME}/Google Drive/My Drive/Backups/maint"

backup_files=(
  ${HOME}/.gnupg/pubring.kbx
  ${HOME}/.gnupg/trustdb.pgp
  )

if test -d "${backup_path}" ; then
  echo "Backing up to ${backup_path}"
else
  echo "Creating ${backup_path}"
  mkdir -p "${backup_path}"
fi

for file in "${backup_files[@]}"; do
  if test -f "${file}" ; then
    # Mac cp doesn't support -u so we use rsync
    rsync --verbose --update "${file}" "${backup_path}"
  else
    echo "Warning: back up file does not exist: ${file}"
  fi
done

exit 0
