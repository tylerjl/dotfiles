#
# Custom zsh theme
#
# Save these for later
#
# local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
# RPS1="${return_code}"
# local vcs="%F{yellow}${branch}%{$reset_color%}"
# # Get vcs branch
# local branch="$(hg_get_branch_name)"
# if [ -n "${branch}" ] ; then
#     local branch="$(git_prompt_info)"
# fi

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
local user_host='%F{green}%n%{$reset_color%}%F{magenta}@%{$reset_color%}%F{cyan}%m%{$reset_color%}'
local current_dir='%B%F{blue}% %~%{$reset_color%}'
local current_time='[ %F{green}%D{%L:%M} %D{%p}%{$reset_color%} ]'
local shebang='%F{red}$%{$reset_color%}'


PROMPT="╭ ${user_host} ${current_dir} ${rvm_ruby}
╰ ${shebang} "

RPROMPT="${current_time}"
