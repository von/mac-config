#!/usr/bin/env bash
# Configure sudo to allow TouchId
# Kudos: https://apple.stackexchange.com/a/306324/104604
# Doesn't seem to cause a problem on a mac w/o TouchId
# Needs iTerm option set per https://apple.stackexchange.com/a/355880
# Turn off: iTerm2->Preferences > Advanced > (Goto the Session heading)
#                  > Allow sessions to survive logging out and back in

# XXX Make sure we have pam_tid and pam_reattach, or we won't be able to sudo
# If that happens, enable root: https://support.apple.com/en-us/HT204012

# Guard to make sure we're not already configured.
grep "pam_tid.so" /etc/pam.d/sudo > /dev/null
if test $? -ne 0 ; then
  set -o errexit  # Exit on error
  echo "Configuring sudo to allow TouchId"
  # Use sed to insert new line at start of pam configuration
  # '-i .bak' does the replacement in place, creating a backup with
  # '.bak' extension.
  # The '&' is replaced with the match. Literal newline as standard sed
  # doesn't recognize '\n'
  # Kudos: https://stackoverflow.com/a/41251049/197789
  sudo sed -i .bak 's/# sudo.*/&\
auth       sufficient     pam_tid.so/' /etc/pam.d/sudo
  set +o errexit
fi

# Use pam_reattach to allow TouchId to work with tmux
# https://github.com/fabianishere/pam_reattach
# Note order of this and pam_tid.so is important, pam_reattach needs
# to appear first.
# Need to use full path if not in /usr/lib/pam or /usr/local/lib/pam
# TODO: Use homebrew prefix determined dynamically
grep "pam_reattach.so" /etc/pam.d/sudo > /dev/null
if test $? -ne 0 ; then
  set -o errexit  # Exit on error
  echo "Configuring sudo to work with tmux via pam_reattach"
  if test -z "${HOMEBREW_PREFIX}" ; then
    echo "HOMEBREW_PREFIX not set. Aborting."
    exit 1
  fi
  # See comments above regarding details of following
  sudo sed -i .bak 's|# sudo.*|&\
auth       optional     '${HOMEBREW_PREFIX}'/lib/pam/pam_reattach.so|' /etc/pam.d/sudo
  set +o errexit
fi
exit 0
