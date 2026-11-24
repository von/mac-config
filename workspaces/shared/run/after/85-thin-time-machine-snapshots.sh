#!/bin/sh

# I've noticed snapshots seems to build up sometimes and take up
# a significant amount of disk space.
# This seems to delete any snapshots older than 24 hours
echo "Thining Time Machine snapshots..."
tmutil thinlocalsnapshots / || exit 1

exit 0
