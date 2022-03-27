#!/bin/sh
# Allow installs into my base python install
export PIP_REQUIRE_VIRTUALENV=false

# Disable warning message about Python 2 expiration
# Kudos: https://github.com/pypa/pip/issues/6207
export PYTHONWARNINGS=ignore:DEPRECATION

error=0

echo "Installing pynvim"
python3 -m pip install --user --upgrade pynvim || error=1

exit $error
