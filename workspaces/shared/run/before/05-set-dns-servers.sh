#!/usr/bin/env bash
# Use Google DNS servers
# Kudos:
# https://osxdaily.com/2015/06/02/change-dns-command-line-mac-os-x/
# https://developers.google.com/speed/public-dns/docs/using
# XXX Handle more than Wi-Fi service?

dns_servers="8.8.8.8 8.8.4.4"

current_servers=$(networksetup -getdnsservers Wi-Fi)
# Convert carriage returns into spaces
current_servers="${current_servers/$'\n'/' '}"

if test "${current_servers}" != "${dns_servers}" ; then
  echo "Configuring to use Google DNS"
  networksetup -setdnsservers Wi-Fi ${dns_servers} || exit 1
fi

exit 0
