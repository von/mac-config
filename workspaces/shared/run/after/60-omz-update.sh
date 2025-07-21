#!/usr/bin/env bash
# Update oh-my-zsh and plugins
# See:
# https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-update-oh-my-zsh
#
# Note, if you get a "fatal: not a git repository" error, see:
# https://stackoverflow.com/a/33487142/197789
#
if test -d "${HOME}/.oh-my-zsh" ; then
  # '-v minimal' surpresses some fancy output
  zsh "${HOME}/.oh-my-zsh/tools/upgrade.sh" -v minimal
fi
exit 0
