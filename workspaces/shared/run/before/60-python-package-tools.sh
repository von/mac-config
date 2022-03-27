#!/bin/sh
# Allow installation into root python install
export PIP_REQUIRE_VIRTUALENV=false

# Disable warning message about Python 2 expiration
export PYTHONWARNINGS=ignore:DEPRECATION

echo "Installing/upgrading Python package tools"
python3 -m pip install --upgrade pip setuptools wheel || exit 1

exit 0
