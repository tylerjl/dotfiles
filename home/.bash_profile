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

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH=${HOME}/bin:${PATH}
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/opt/bin" ] ; then
  PATH=${HOME}/opt/bin:${PATH}
fi

# Set PATH so it includes custom sbinaries
if [ -d "/usr/local/sbin" ] ; then
  PATH=/usr/local/sbin:${PATH}
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/opt/share/man" ]; then
  MANPATH=${HOME}/opt/share/man:${MANPATH}
fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH=${HOME}/info:${INFOPATH}
# fi

# This is for development on pyramid on arvixe
if [ -d "$HOME/opt/lib" ] ; then
  export PYTHONPATH=${HOME}/opt/lib
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

