# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gerard"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

if [ `uname -s` = "Darwin" ] ; then
  plugins+=(ruby rvm brew osx)
fi

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt correct

# ---------------- Custom settings ----------------------

######################
# OS-Specific settings
#
if [ `uname -s` = "Darwin" ] ; then
  # Customizations for OSX
  alias nup='sudo launchctl load -w /Library/LaunchDaemons/com.tenablesecurity.nessusd.plist'
  alias ndown='sudo launchctl unload -w /Library/LaunchDaemons/com.tenablesecurity.nessusd.plist'
  alias ls='ls -hFG'                 # classify files in colour
else
  if [ echo `uname -s` | grep -i 'cygwin' ] ; then
    # Customizations for Windows
    unset TMP
    unset TEMP
  fi
  # Classify files in colour
  alias ls='ls -hF --color=tty'
fi

############################
# PATH settings and the like

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

# Set PATH so it includes custom user binaries
if [ -d "/usr/local/bin" ] ; then
  PATH=/usr/local/bin:${PATH}
fi

# Include RVM scripts in PATH
if [ -d "${HOME}/.rvm/bin" ] ; then
  PATH=${PATH}:${HOME}/.rvm/bin
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/opt/share/man" ]; then
  MANPATH=${HOME}/opt/share/man:${MANPATH}
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ######
# Aliases

# df and du defaults
alias df='df -h'
alias du='du -h'
alias ds='du -h --max-depth=1 . 2> /dev/null | sort -hr'

# Raw control characters
alias less='less -r'

# Where, of a sort
alias whence='type -a'

# Show differences in colour
alias grep='grep --color'

# Screen reattachment
alias sr="screen -r"

# Some shortcuts for different directory listings
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
alias ll='ls -l'               # long list
alias la='ls -A'               # all but . and ..
alias l='ls -CF'
alias t='todo.sh'

# Should probably clean these up someday
alias gosl='ssh tylerjl@sl1web.byu.edu'
alias goet='ssh tylerjl@ssh.et.byu.edu'

# Shortcut to grab pineapple filesystem
alias piback='ssh hpi "tar -cvf - -X ~/rpi.excl /" | bzip2 > pineapple_$(date +"%Y%m%d").tar.bz2'

##########################
# Set some shell variables

# Default editors
export SVN_EDITOR=/usr/bin/vim
export EDITOR=vim

# Make directories more visible
export LS_COLORS='di=00;44'

# Bind Alt+(f|b) to word movement
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

