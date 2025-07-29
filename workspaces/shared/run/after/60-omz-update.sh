#!/usr/bin/env bash
# Update oh-my-zsh and plugins
# See:
# https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-update-oh-my-zsh
#
# Note, if you get a "fatal: not a git repository" error, see:
# https://stackoverflow.com/a/33487142/197789
#
if test true ; then
  # Currently we use chezmoi to update omz rather than omz itself
  # See .chezmoiexternal.toml
  # If we try to mix the two, you get the git repo error above.
  # XXX Not sure how to make this conditional
  echo "Skipping oh-my-zsh update and letting chezmoi handle it."
else
  if test -d "${HOME}/.oh-my-zsh" ; then
    # '-v minimal' surpresses some fancy output
    zsh "${HOME}/.oh-my-zsh/tools/upgrade.sh" -v minimal
  fi
fi
exit 0
