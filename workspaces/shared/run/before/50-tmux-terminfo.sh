#!/bin/sh
# Set up terminal types for tmux that support italics
# This creates (or adds to) ~/.terminfo
# Kudos:
#  https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
#  https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/

tmpdir=$(mktemp -d)

toe -a | grep -E '\bxterm-256color-italic\b' > /dev/null
if test $? -ne 0 ; then
  echo "Adding xterm-256color-italic to terminfo"
  cat <<EOF > ${tmpdir}/xterm-256color-italic.terminfo
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
EOF
  tic -x ${tmpdir}/xterm-256color-italic.terminfo
fi

toe -a | grep -E '\btmux-256color\b' > /dev/null
if test $? -ne 0 ; then
  echo "Adding tmux-256color to terminfo"
  cat <<EOF > ${tmpdir}/tmux-256color.terminfo
tmux-256color|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color,
EOF
  tic -x ${tmpdir}/tmux-256color.terminfo
fi

toe -a | grep -E '\btmux-256color-italic\b' > /dev/null
if test $? -ne 0 ; then
  echo "Adding tmux-256color-italic to terminfo"
  cat <<EOF > ${tmpdir}/tmux-256color-italic.terminfo
tmux-256color|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color,

tmux-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m, Ms@,
  use=tmux-256color,
EOF
  tic -x ${tmpdir}/tmux-256color-italic.terminfo
fi
