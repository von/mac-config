#!/bin/sh
# Check if we have any outdated formula

echo "Running 'brew outdated'"
brew outdated || exit 1
exit 0
