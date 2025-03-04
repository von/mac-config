#!/bin/sh
#
# Bootstrap a new Mac with Xcode, Homebrew, and use zero to configure.
#
# Intended for OSX and untested.
#
######################################################################
#
# Constants

_zero="zero"

# Path to directory containing this script
# Kudos: https://stackoverflow.com/a/246128/197789
_setup_path=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

_config_file=${HOME}/.mac_config

######################################################################
#
# Source configuration file (~/.mac-config) if it exists
#

if test -f "${_config_file}" ; then
  echo "Sourcing ${_config_file}"
  source ${_config_file}
fi

######################################################################
#
# Make sure we specify a workspace if required
#

if test $# -gt 0 ; then
  workspace=$1; shift
fi

if test -d "${_setup_path}/workspaces" ; then
  if test -z "${workspace}" ; then
    echo "Workspace required but not given."
    exit 1
  else
    if test -d "${_setup_path}/workspaces/${workspace}" ; then
      echo "Using workspace ${workspace}"
    else
      echo "No such workspace ${workspace}"
      exit 1
    fi
  fi
fi

######################################################################

echo "Checking for XCode command-line tools..."
xcode-select --install 2>&1 | grep "already installed" > /dev/null
if test $? -ne 0 ; then
  # This will launch a GUI to install XCode CLI if needed
  echo "Exiting to allow XCode CLI installation."
  exit 2
fi
echo "Checking for approved XCode license..."
# This is my best attempt at detecting if I need to appove the license.
xcodebuild -list >& /dev/null
if test $? -eq 69 ; then
  echo "Approving XCode license"
  sudo -n xcodebuild -license accept || exit 1
fi

######################################################################

echo "Checking for homebrew..."
command -v brew >/dev/null 2>&1
if test $? -ne 0 ; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

for prefix in /usr/local /opt/homebrew ; do
  if test -e ${prefix}/bin/brew ; then
    echo "Using homebrew from ${prefix}"
    eval $(${prefix}/bin/brew shellenv)
    break
  fi
done

######################################################################
#
# Exit on any error from here forward.

set -o errexit

######################################################################
#
# Install packages needed for bootstrap.

echo "Installing basic Homebrew packages for bootstrap..."
brew bundle --file=/dev/stdin upgrade <<EOF
brew "git"
brew "curl"
brew "chezmoi"
brew "myrepos"
brew "zero-sh/tap/zero"
EOF

######################################################################
#
# Execute zero using this directory as its configuration directory.

echo "Executing zero.sh to configure system..."
${_zero} setup --directory "${_setup_path}" ${workspace}

echo "Success."
exit 0
