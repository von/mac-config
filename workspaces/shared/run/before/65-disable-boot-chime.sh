#!/bin/sh

set -e

echo "Disable chime on boot"
sudo nvram SystemAudioVolume=" "

exit 0
