# Custom bash_profile from Cygwin, modified.

# ~/.bash_profile: executed by bash for login shells. (upon first login)

# source the system wide bashrc if it exists
if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# source the users bashrc if it exists
if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Cross-shell $PATH setup file
. $HOME/.shell_paths
