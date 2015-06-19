# Pull in antigen
source ~/.homesick/repos/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle rvm
antigen bundle brew
antigen bundle ruby
antigen bundle vundle
antigen bundle vagrant
antigen bundle mercurial

if [ `uname -s` = "Darwin" ] ; then
  antigen bundle osx
fi

antigen apply

# Path to your oh-my-zsh configuration.
ZSH_CUSTOM=$HOME/.zsh

fpath=($HOME/.homesick/repos/homeshick/completions $HOME/.zsh/site-functions $fpath)

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
# POWERLINE_DETECT_SSH="true"
ZSH_THEME="tjl-powerline"

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

# Use direnv if available
if (( $+commands[direnv] )) ; then
    eval "$(direnv hook zsh)"
fi

# Turn off zsh errors when globbing appears to fail. This fixes the problem
# that comes up when attempting to scp something remotely with *, or when
# switching to a git branch with # in the name.
unsetopt nomatch

# Beeps are really just annoying
setopt no_beep
