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
While this repo contains standalone configuration files for various tools, there are some additional repositories that should be installed via [homeshick] as dependencies.
Not all of these are strictly required.

```shell
$ git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$ source "$HOME/.homesick/repos/homeshick/homeshick.sh"
$ for castle in syl20bnr/spacemacs \
                rbenv/rbenv \
                rbenv/ruby-build \
                robbyrussell/oh-my-zsh \
                zsh-users/zsh-syntax-highlighting \
                lukechilds/zsh-nvm \
                junegunn/vim-plug \
                sjl/badwolf \
                tomasr/molokai \
                pyenv/pyenv ; do homeshick clone --batch $castle ; done
```

Log out of the shell, log in again (antigen will install several dependencies at shell startup).

```shell
$ vim -c PlugInstall -c qa
# Or, for neovim
$ nvim -c PlugInstall -c qa
```

[homeshick]: https://github.com/andsens/homeshick
