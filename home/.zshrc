# Set PATH per several locations. Important that this is set early (before
# zsh plugins get applied).
source $HOME/.shell_paths

export ZSH=$HOME/.oh-my-zsh

# Path to your oh-my-zsh customizations.
ZSH_CUSTOM=$HOME/.zsh

fpath=(
  $HOME/.homesick/repos/homeshick/completions
  $HOME/.zsh/site-functions
  $fpath
)

# Plugin settings

# When opening or closing a shell, automatically (dis)connect to tmux
# ZSH_TMUX_AUTOSTART=true

# Multi selection seems generally useful?
FZF_DEFAULT_OPTIONS="--multi"

# Lazily load node stuff
# export NVM_LAZY_LOAD=true

plugins=(
  brew
  bundler
  docker
  encode64
  git
  mercurial
  osx
  rbenv
  ruby
  tmux
  vagrant
  vundle
  wd
  web-search
  zsh-nvm
  zsh-syntax-highlighting
)

#################################
# Source general-purpose defaults. Any plugin aliases may be overwritten.
source $HOME/.shell_defaults

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# POWERLINE_DETECT_SSH="true"
ZSH_THEME="tjl-powerline"

# Custom oh-my-zsh switches.
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"

# In some cases (as when tramp initiates an ssh connection), we want a plain
# terminal. This sets a generic prompt and leaves aside everything oh-my-zsh
# related.
case "$TERM" in
  "dumb")
    PROMPT="> "
    ;;
  *)
    source $ZSH/oh-my-zsh.sh

    ###############
    # Utility hooks

    # Use direnv if available
    if (( $+commands[direnv] )) ; then
      eval "$(direnv hook zsh)"
    fi

    # fzf (get the shell sources with the `install` utility)
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    ;;
esac

# ---------------- Custom settings ----------------------

# Bind Alt+(f|b) to word movement
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# Make directories more visible
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Turn off zsh errors when globbing appears to fail. This fixes the problem
# that comes up when attempting to scp something remotely with *, or when
# switching to a git branch with # in the name.
unsetopt nomatch

# Beeps are really just annoying
setopt no_beep
