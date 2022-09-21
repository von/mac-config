#!/bin/sh
# Deactivate any virtual to keep 'brew docter' from complaining about python-config
# XXX This doesn't work because deactivate is a function.
if test -n "$VIRTUAL_ENV" ; then
  echo "Deactivating virtualenv"
  deactivate
fi

# Don't exit on brew warnings
echo "Running 'brew doctor'"
brew doctor
exit 0
