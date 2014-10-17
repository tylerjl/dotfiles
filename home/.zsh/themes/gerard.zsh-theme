#
# Custom zsh theme
#

# Define some variables for later use
_HG_PROMPT='☿'
_GIT_PROMPT='±'
_DEFAULT_PROMPT='$'

# Modules & Initialization
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

# Define shebang function, and set it
function get_shebang {
    git branch &>/dev/null && echo $_GIT_PROMPT     && return
    hg root    &>/dev/null && echo $_HG_PROMPT      && return
                              echo $_DEFAULT_PROMPT && return }
local shebang='%F{red}$(get_shebang)%{$reset_color%}'

function get_vcs_branch {
    case "${1}" in
        $_GIT_PROMPT)
            git_prompt_info ;;
        $_HG_PROMPT)
            hg_prompt_info ;;
    esac
}

# Prompt vars
local return_code="%(?..%F{red}✗ %?%{$reset_color%})"
local user_host='%F{green}%n%{$reset_color%}%F{magenta}@%{$reset_color%}%F{cyan}%m%{$reset_color%}'
local current_dir='%B%F{blue}% %~%{$reset_color%}'
local current_time='[ %F{green}%D{%L:%M} %D{%p}%{$reset_color%} ]'
local branch='$(get_vcs_branch $(get_shebang))'

PROMPT="╭ ${user_host} ${current_dir} ${rvm_ruby} ${branch}
╰ ${shebang} "
RPROMPT="${return_code} ${current_time}"

_PROMPT_PRE="%F{yellow}‹"
_PROMPT_POST="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=$_PROMPT_PRE
ZSH_THEME_GIT_PROMPT_SUFFIX=$_PROMPT_POST
ZSH_THEME_HG_PROMPT_PREFIX=$_PROMPT_PRE
ZSH_THEME_HG_PROMPT_SUFFIX=$_PROMPT_POST
