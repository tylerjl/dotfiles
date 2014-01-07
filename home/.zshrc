# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh

#################################
# Source general-purpose defaults
. $HOME/.shell_defaults

############################
# PATH settings and the like

. $HOME/.shell_paths

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gerard"

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

DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial vundle)

if [ `uname -s` = "Darwin" ] ; then
  plugins+=(ruby rvm brew osx)
fi

source $ZSH/oh-my-zsh.sh

# ---------------- Custom settings ----------------------

##########################
# Set some shell variables

# Make directories more visible
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Fix colorscheme kinda
export TERM='xterm-256color'

# Bind Alt+(f|b) to word movement
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word
