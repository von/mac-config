#!/bin/sh
#
# Configure default applications using duti
#
# duti installed via Homebrew, see https://github.com/moretension/duti
#
# Get App identifier via:
# mdls -name kMDItemCFBundleIdentifier -r /Applications/<app>.app
#
# For a list of Apple applications identifiers:
# https://support.apple.com/guide/deployment/bundle-ids-for-native-ios-and-ipados-apps-depece748c41/web
#
# To get a file's uti:
# mdls -name kMDItemContentType /path/to/file
#
# For a list of uti:
# https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html

set -e  # Exit on error

# Use Quicktime for all audio files (instead of iTunes)
duti -s com.apple.QuickTimePlayerX public.audio all
duti -s com.apple.QuickTimePlayerX public.mp3 all
duti -s com.apple.QuickTimePlayerX com.microsoft.waveform-audio all

# And use Quicktime for video files
duti -s com.apple.QuickTimePlayerX public.mpeg-4 all

exit 0
