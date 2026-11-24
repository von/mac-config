#!/usr/bin/env bash
# Update any tmux tpm plugins

echo "Updating tmux tpm plugins..."

tpm_path="${HOME}/.tmux-plugins/tpm/"

if test -d "${tpm_path}" ;  then
  echo "Using ${tpm_path}"
else
  echo "tpm path does not exist: ${tpm_path}"
  exit 1
fi

${tpm_path}/bin/install_plugins || exit 1
${tpm_path}/bin/update_plugins all || exit 1
# Seems dangerous
#${tpm_path}/bin/clean_plugins || exit 1
echo "Success."
exit 0
