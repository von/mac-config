#!/bin/sh
# Allow installs into my base python install
export PIP_REQUIRE_VIRTUALENV=false

# Disable warning message about Python 2 expiration
# Kudos: https://github.com/pypa/pip/issues/6207
export PYTHONWARNINGS=ignore:DEPRECATION

error=0

# Python client for neovim: https://github.com/neovim/pynvim
echo "Installing pynvim"
# --break-system-packages needed since Python 3.11
# Kudos: https://stackoverflow.com/a/75722775/197789
echo "Using --break-system-packages: should fix at some point."
python3 -m pip install --break-system-packages --user --upgrade pynvim || error=1

exit $error
