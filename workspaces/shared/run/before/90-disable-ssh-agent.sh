#!/usr/bin/env bash
#
# Disable Mac from starting ssh-agent as I use gpg-agent instead since
# it can access my yubikey.
#
# Kudos: https://gist.github.com/partikus/cd45013b1274af8ae63b17030d89176c
#
# XXX Not sure this is working as ssh-agent keeps getting started on reboot

# XXX Not sure to how to check if ssh-agent is configuted to run
#     The following always seems to return something
# launchctl list | grep com.openssh.ssh-agent >& /dev/null

# XXX This may require a restart to allow gpg-agent to take over.

echo "Disabling ssh-agent"
launchctl disable gui/$UID/com.openssh.ssh-agent

exit 0
