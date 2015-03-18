#
# Powerline: because anything else would be too easy.
#
# Save these for something?
# ✖ ➜ ═ ✭

# Provides source control utilities
autoload -Uz vcs_info

# Configure vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}✘%F{15}"
zstyle ':vcs_info:*' stagedstr "%{$fg[cyan]%}✚%F{15}"
zstyle ':vcs_info:*' formats "  %b %c%u%m"
zstyle ':vcs_info:*+set-message:*' hooks vcs-set-clean

# Easiest way I found to do clean repo logic
function +vi-vcs-set-clean() {
    # Detect absence of pending changes
    if [ -z "${hook_com[staged]}${hook_com[unstaged]}" ] ; then
        hook_com[misc]="%{$fg[green]%}✔%f%F{15}"
    fi
}

# Set relevant vcs variables before each prompt render
function precmd() { vcs_info }

# Only worry about setting the prompt character after moving directories
# (using this over precmd to avoid as much PROMPT rendering latency as possible)
function chpwd() {
    case ${vcs_info_msg_0_## \(} in
        git*) export _PROMPT_CHAR='±' ;;
        hg*)  export _PROMPT_CHAR='☿' ;;
        *)    export _PROMPT_CHAR='$' ;;
    esac
}
# Set the initial prompt to a one-time "new prompt" symbol
_PROMPT_CHAR='✹'

# OS detection and logo settings
[[ -n "${OS}" ]] || OS=$(uname)
if [ $OS = "Darwin" ]; then
    LOGO=""
else
    LOGO="🐧 "
fi

# Time format string
_ZSH_TIME="%D{%L:%M} %D{%p}"

# Set some multiple-use colors
BG_COLOR_SEAGREEN=%K{8}
FG_COLOR_SEAGREEN=%F{8}
BG_COLOR_DARKBLUE=%K{0}
FG_COLOR_DARKBLUE=%F{0}

reset_color=%f%k%b
RESET=%{$reset_color%}

# BUILD DAT PROMPT
# ################

# Newline and username
PROMPT="
%{$fg[blue]%}%{$bg[white]%}%n"

# Machine name, powerline transition
PROMPT="${PROMPT}%{$fg[green]%} @%{$fg[red]%} %m "
PROMPT="${PROMPT}%{$fg[white]%}${BG_COLOR_SEAGREEN}"

# Interpolate timestamp, powerline transition
PROMPT="${PROMPT}%{$fg[white]%}${BG_COLOR_SEAGREEN} ${_ZSH_TIME} "
PROMPT="${PROMPT}${FG_COLOR_SEAGREEN}${BG_COLOR_DARKBLUE}"

# Logo, directory, vcs info
PROMPT="${PROMPT}%{$fg[white]%}${BG_COLOR_DARKBLUE} ${LOGO} %2~"'${vcs_info_msg_0_}'

# Powerline transition, newline, prompt, powerline transition
PROMPT="${PROMPT} ${RESET}${FG_COLOR_DARKBLUE}
${RESET}%{$fg[white]%}${BG_COLOR_SEAGREEN} "'${_PROMPT_CHAR} '
PROMPT="${PROMPT}${RESET}${FG_COLOR_SEAGREEN}${RESET}"

# Right prompt return code rendering (with zsh ternary!)
RPROMPT="%(?..%{$fg[red]%}%? ↵${RESET})"
