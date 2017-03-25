# Set PATH per several locations. Important that this is set early (before
# antigen bundles get applied).
. $HOME/.shell_paths

export ZSH=$HOME/.oh-my-zsh

# Path to your oh-my-zsh configuration.
ZSH_CUSTOM=$HOME/.zsh

fpath=($HOME/.homesick/repos/homeshick/completions $HOME/.zsh/site-functions $fpath)

# Plugin settings
#
# When opening or closing a shell, automatically (dis)connect to tmux
# ZSH_TMUX_AUTOSTART=true

plugins=(osx git brew bundler rbenv ruby tmux vundle vagrant mercurial web-search wd)

#################################
# Source general-purpose defaults
. $HOME/.shell_defaults

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
