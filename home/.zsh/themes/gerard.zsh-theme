#
# Custom zsh theme
#

# Load modules
autoload -U colors && colors

setopt prompt_subst

# Get RVM version, if available
if which rvm-prompt &> /dev/null; then
  local rvm_ruby='%F{red}‹$(rvm-prompt v g)›%{$reset_color%}'
elif which rbenv &> /dev/null; then
  local rvm_ruby='%F{red}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
else
  local rvm_ruby=''
fi

# Prompt vars
local return_code="%(?..%F{red}✗ %?%{$reset_color%})"
local user_host='%F{green}%n%{$reset_color%}%F{magenta}@%{$reset_color%}%F{cyan}%m%{$reset_color%}'
local current_dir='%B%F{blue}% %~%{$reset_color%}'
local current_time='[ %F{green}%D{%L:%M} %D{%p}%{$reset_color%} ]'
local shebang='$(get_shebang)'
local git_branch='$(git_prompt_info)'
local hg_branch='$(hg_prompt_branch)'

function get_shebang {
    if [ -n "`git_prompt_info`" ] ; then
        echo "%F{red}±%{$reset_color%}"
    elif [ -n "`hg_prompt_branch`" ] ; then
        echo "%F{red}☿%{$reset_color%}"
    else
        echo "%F{red}$%{$reset_color%}"
    fi
}

function hg_prompt_branch {
    b=`hg_get_branch_name`
    if [ -n "${b}" ] ; then
        echo "%F{yellow}‹$b›%{$reset_color%}"
    fi
}

PROMPT="╭ ${user_host} ${current_dir} ${rvm_ruby} ${git_branch}${hg_branch}
╰ ${shebang} "
RPROMPT="${return_code} ${current_time}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
