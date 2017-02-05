dotfiles
========

> These are my dotfiles. There are many like it, but these are mine.
> My dotfiles are my best friend. They are my life. I must master them as I must master my life.

## Features

* Is pretty. Tuned iTerm2 colorscheme + powerline fonts + jellybeans colorscheme + unified shell and tmux style = neato burrito.
* _Mostly_ performant. Most language-specific vim plugins lazily loaded, scm shell sigils optimized for speed.
* Linux + OS X. Specific configs for programs like tmux conditionally loaded.

## Initial Installation

These dotfiles are laid out for installation and management with [homeshick].
While this repo contains standalone configuration files for various tools, there are some additional repositories that should be installed via [homeshick] as dependencies:

```shell
$ git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$ source "$HOME/.homesick/repos/homeshick/homeshick.sh"
$ homeshick clone zsh-users/antigen
$ homeshick clone junegunn/vim-plug
$ homeshick clone sjl/badwolf
```

Log out of the shell, log in again (antigen will install several dependencies at shell startup).

```shell
$ vim -c PlugInstall -c qa
# Or, for neovim
$ nvim -c PlugInstall -c qa
```

[homeshick]: https://github.com/andsens/homeshick
