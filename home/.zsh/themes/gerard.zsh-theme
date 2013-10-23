# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$fg[green]%}%n%{$reset_color%}%{$fg[magenta]%}@%{$reset_color%}%{$fg[cyan]%}%m%{$reset_color%}'
local current_dir='%{$fg[blue]%} %~%{$reset_color%}'
local current_time='[ %{$fg[green]%}%D{%L:%M} %D{%p}%{$reset_color%} ]'
local shebang='%{$fg[red]%}$%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭ ${user_host} ${current_dir} ${rvm_ruby} ${git_branch}
╰ ${shebang} "
RPS1="${return_code}"
RPROMPT="${current_time}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
