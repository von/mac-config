#!/bin/sh
# Set shell to zsh or, failing that, bash

shells="/usr/local/bin/zsh /bin/zsh /bin/bash"

sucess=0
for shell in $shells ; do
  test -x ${shell} || continue
  current_shell=$(id -P | cut -d : -f 10)
  if test ${shell} == ${current_shell} ; then
    echo "Shell is already ${shell}"
    exit 0
  fi
  echo "Setting shell to ${shell}"
  if grep ${shell} /etc/shells > /dev/null ; then
    :  # Is already a registered shell
  else
    echo "Adding ${shell} to /etc/shells"
    sudo -n bash -c "echo ${shell} >> /etc/shells" || exit 1
  fi
  sudo -n chsh -s ${shell} ${USER} || exit 1
  exit 0
done

echo "Could not set shell."
exit 1
