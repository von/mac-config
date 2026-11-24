#!/bin/sh
#
# Bootstrap a new Mac with Xcode, Homebrew, and use zero to configure.
#
# Intended for OSX and untested.
#
# Installs and uses zero-sh:
# https://github.com/zero-sh/zero.sh
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
# Check for Rosetta and install if not present.
# Needed for old Intel-based applications.
# Kudos:
#   https://apple.stackexchange.com/a/427996/104604
#   https://stackoverflow.com/a/71331071/197789
if test -f /Library/Apple/usr/libexec/oah/libRosettaRuntime ; then
  echo "Rosetta detected."
else
  echo "Installing Rosetta"
  softwareupdate --install-rosetta --agree-to-license
fi

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

_already_configued=$(defaults read com.vwelch.macconfig MacConfigWasHere || echo notset 2> /dev/null)
if test ${_already_configued} = "notset" ; then
  echo "Running for first time. Setting up com.vwelch.macconfig MacConfigWasHere"
  defaults write com.vwelch.macconfig MacConfigWasHere -int 0
else
  echo "Detected we've run before."
fi

######################################################################
#
# Execute zero using this directory as its configuration directory.

echo "Executing zero.sh to configure system..."
${_zero} setup --directory "${_setup_path}" ${workspace}

if test "${_already_configued}" -eq 0 ; then
  # Indicate we have already run.
  # One can zero this value to force re-configuration, e.g.:
  #   defaults write con.vwelch.macconfig MacConfigWasHere -int 0
  echo "Finished first run. Setting com.vwelch.macconfig MacConfigWasHere to 1"
  defaults write com.vwelch.macconfig MacConfigWasHere -int 1
fi

echo "Success."
exit 0
