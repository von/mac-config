#!/bin/sh
# Deactivate any virtual to keep 'brew docter' from complaining about python-config
# XXX This doesn't work because deactivate is a function.
if test -n "$VIRTUAL_ENV" ; then
  echo "Deactivating virtualenv"
  deactivate
fi

echo "Running 'brew cleanup'"
brew cleanup
exit 0
