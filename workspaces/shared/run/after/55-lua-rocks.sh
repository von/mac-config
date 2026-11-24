#!/usr/bin/env bash
#
# Install lua rocks

if command -v luarocks >/dev/null 2>&1; then

  echo "Installing lua rocks..."
  # Lua table-to-HTML converter
  # https://github.com/carlosmpv/lua_to_html
  # This installed into /opt/homebrew/share/lua/<version>
  # My Hammerspoons configuration should configure package.path to
  # find these rocks.
  luarocks install lua_to_html

else
  echo "luarocks not found."
  exit 1
fi
exit 0
