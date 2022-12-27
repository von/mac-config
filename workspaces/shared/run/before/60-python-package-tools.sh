#!/bin/sh
# Allow installation into root python install
export PIP_REQUIRE_VIRTUALENV=false

# Disable warning message about Python 2 expiration
export PYTHONWARNINGS=ignore:DEPRECATION

echo "Installing/upgrading Python package tools"
python3 -m pip install --upgrade pip wheel || exit 1
# https://setuptools.pypa.io/en/latest/userguide/quickstart.html
python3 -m pip install --upgrade build || exit 1

exit 0
