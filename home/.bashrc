# .bashrc configuration file
# Heavy customization by Ty Langlois

# If not running interactively, just return.
[ -z "$PS1" ] && return

# History/Bash behavior configuration
# ######

# Ignore duplicated history entries
export HISTCONTROL=ignoredups

# Increase the history retention size (double the default)
export HISTSIZE=1000

# Upon exit, don't wipe the bash_history file.
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'
alias ds='du -h --max-depth=1 . 2> /dev/null | sort -hr'

alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour

alias sr="screen -r"						# Screen reattachment

export LS_COLORS='di=00;44'

# Some shortcuts for different directory listings
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #


# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

# Some customizations I (Ty) added:
# ###############

# Aliases, they're too small for their own scripts
alias gosl='ssh tylerjl@sl1web.byu.edu'
alias gotjl='ssh tylerjl@tjll.net'
alias goit='ssh -p 50036 webadmin@it.et.byu.edu'
alias goet='ssh tylerjl@ssh.et.byu.edu'
alias gonag='ssh tylerjl@nagios3.byu.edu'
alias goshaw='ssh tylerjl@shaw.byu.edu'

# These are for ease of use...
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

# Set the default SVN editor
export SVN_EDITOR=/usr/bin/vim

