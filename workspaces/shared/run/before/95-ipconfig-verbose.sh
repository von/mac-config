#!/usr/bin/env bash
# Set up ipconfig to be verbose so we can get SSID.
# Kudos:
# https://discussions.apple.com/thread/256108303?answerId=261575020022&sortBy=rank#261575020022

# XXX I don't know how to test the verbosity level.
echo "Setting 'ipconfig setverbose 1' to allow getting SSID"
sudo ipconfig setverbose 1
