#!/bin/sh

set -e

echo "Disable chime on boot"
sudo -n nvram SystemAudioVolume=" "

exit 0
