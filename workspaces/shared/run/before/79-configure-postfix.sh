#!/bin/sh
#
# Configure postfix so I can send email from the commandline.
#
# Kudos:
# http://apple.stackexchange.com/a/92205/104604
# https://easyengine.io/tutorials/linux/ubuntu-postfix-gmail-smtp/
# http://stackoverflow.com/a/26451135/197789

set -e  # Exit on error

restart_postfix=0

if test ! -f /etc/postfix/main.cf ; then
  echo "Creating /etc/postfix/main.cf"
  sudo -n tee -a /etc/postfix/main.cf > /dev/null << EOF

# Configuration added by $0
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/postfix/cacert.pem
smtp_use_tls = yes
smtp_sasl_mechanism_filter = plain
EOF
  restart_postfix=1
fi

if test ! -f /etc/postfix/cacert.pem ; then
  echo "Creating /etc/postfix/cacert.pem"
  sudo -n tee -a /etc/postfix/cacert.pem > /dev/null << EOF
-----BEGIN CERTIFICATE-----
MIIEgDCCA2igAwIBAgIIULcWHCWjMMowDQYJKoZIhvcNAQELBQAwSTELMAkGA1UE
BhMCVVMxEzARBgNVBAoTCkdvb2dsZSBJbmMxJTAjBgNVBAMTHEdvb2dsZSBJbnRl
cm5ldCBBdXRob3JpdHkgRzIwHhcNMTYwNjA4MTMwNzUyWhcNMTYwODMxMTIzMDAw
WjBoMQswCQYDVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwN
TW91bnRhaW4gVmlldzETMBEGA1UECgwKR29vZ2xlIEluYzEXMBUGA1UEAwwOc210
cC5nbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqB8TO
gL4aHNV0QcVd7JVEkEZVt13MyCkso7IFUOT7iBLjH883n/rDHzrJzzV3rqT65eou
YeZ1htQUalsJgB/B3E1kc+grE9LR2xO7d2amdXf4Gvtv8fIFDltgQ5nSzhzoupCJ
6hRTUcjCEjZweANUkymISkJLBbGKbkNn37uAwky7FlCL2cVqAus2y1oJNneLhXkW
XLnJiJmYQzC97EVx9+c4I3kn4QkLiTx/n7fSGxzeCnJaCaCZJR/DOnqWKXmj1qj6
gg+XD3bkNWWi6MGhGTxP7J7nUirVttWGu+dOQFgHqKuVF3reKITEe4STHR7kq2A3
PLzv/xXuf9lA7gXVAgMBAAGjggFLMIIBRzAdBgNVHSUEFjAUBggrBgEFBQcDAQYI
KwYBBQUHAwIwGQYDVR0RBBIwEIIOc210cC5nbWFpbC5jb20waAYIKwYBBQUHAQEE
XDBaMCsGCCsGAQUFBzAChh9odHRwOi8vcGtpLmdvb2dsZS5jb20vR0lBRzIuY3J0
MCsGCCsGAQUFBzABhh9odHRwOi8vY2xpZW50czEuZ29vZ2xlLmNvbS9vY3NwMB0G
A1UdDgQWBBTuI5MHI+xsMdNmLpmcgHK5r00bCjAMBgNVHRMBAf8EAjAAMB8GA1Ud
IwQYMBaAFErdBhYbvPZotXb1gba7Yhq6WoEvMCEGA1UdIAQaMBgwDAYKKwYBBAHW
eQIFATAIBgZngQwBAgIwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDovL3BraS5nb29n
bGUuY29tL0dJQUcyLmNybDANBgkqhkiG9w0BAQsFAAOCAQEAcNtP1UGT/klD8l8O
z8FsIKDOJMbPgooMYeV4hHeDz0eTIlObgWKrSRmkyP3OnEDGjlvbRlVR+5UCYjLB
66xAbydXiDWxYv94B+8yP1zPKhpbby0tOy43L0asJLUYvrCoKYHd6J0Qxh8AwDGe
Akb10pW+4ef4q8Vafp7OK2wRz0ZdOOs4XqORnzZjDQSk0mdoUo+5o9SNipEI511e
BmHaYpXEzouuekj/flB48H9ntZNODfOUjMxWi8DMIzIkDwgOREVpNdIRRR+ofsJE
wdx/VOmYsefxSbBTw97JfXEPb84ZgwFt3EEIB0Wn4KPSVb71TXCwOYx3C9FWRB5j
dXKnCA==
-----END CERTIFICATE-----
EOF
  restart_postfix=1
fi

if test $restart_postfix -eq 1 ; then
  echo "Restarting postfix"
  sudo -n launchctl stop org.postfix.master
  sudo -n launchctl start org.postfix.master
fi

if test ! -f /etc/postfix/sasl_passwd ; then
  echo "Creating /etc/postfix/sasl_passwd"
  sudo -n tee -a /etc/postfix/sasl_passwd > /dev/null << EOF
[smtp.gmail.com]:587    USERNAME@gmail.com:PASSWORD
EOF
  sudo -n chmod 400 /etc/postfix/sasl_passwd
  cat << EOF
You need to manually edit /etc/postfix/sasl_passwd and add your credentials

sudo vim /etc/postfix/sasl_passwd

And then run:

sudo postmap /etc/postfix/sasl_passwd
EOF
fi

exit 0
