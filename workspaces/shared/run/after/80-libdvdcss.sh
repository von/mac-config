#!/bin/sh
# HandBrakeCLI expects libdvdcss to be in /usr/local/lib.
# If $HOMEBREW_PREFIX is not /usr/local, then create symlinks
# from $HOMEBREW_PREFIX/lib/ to /usr/local/bin for libdvdcss
# libraries.
if test -z "${HOMEBREW_PREFIX}" ; then
  echo "\$HOMEBREW_PREFIX not defined."
  exit 1
fi

if test "${HOMEBREW_PREFIX}" = "/usr/local" ; then
  # No linking needed
  exit 0
fi

# Make sure /usr/local/lib exists
if test -d /usr/local/lib ; then
  :
else
  sudo mkdir -p /usr/local/lib
fi

for lib in ${HOMEBREW_PREFIX}/lib/libdvdcss* ; do
  libname=$(basename $lib)
  target=/usr/local/lib/${libname}
  if test -f ${target} ; then
    continue
  fi
  echo "Linking ${lib} to ${target}"
  sudo ln -s ${lib} ${target}
done
exit 0
