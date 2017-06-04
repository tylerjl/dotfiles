#
# Powerline: because anything else would be too easy.
#
# Save these for something? ✖ ➜ ═ ✭
#
# By convention:
# psvar[1]: Custom prompt sigil ($, #, etc.) If nothing is set, default to '$'

# Provides source control utilities
autoload -Uz vcs_info

# Configure vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:hg:*' get-revision true # req'd for hg unstaged
zstyle ':vcs_info:hg:*' hgrevformat '' # nuke the rev hash rendering in hg
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}✘%F{15}"
zstyle ':vcs_info:*' stagedstr "%{$fg[cyan]%}✚%F{15}"
zstyle ':vcs_info:*' formats "  %b %m%c%u"
zstyle ':vcs_info:*+set-message:*' hooks vcs-set-misc-clean vcs-set-sigil

# Set %m with custom content
function +vi-vcs-set-misc-clean() {
    # Easiest way I found to do clean repo logic
    if [ -z "${hook_com[staged]}${hook_com[unstaged]}" ] ; then
        hook_com[misc]="%{$fg[green]%}✔%f%F{15}"
    elif [ -n "${hook_com[staged]}" ] && [ -n "${hook_com[unstaged]}" ] ; then
        # Space out {,un}staged sigils
        hook_com[staged]="${hook_com[staged]} "
    fi
}

# If in a vcs repo, set a custom sigil
function +vi-vcs-set-sigil {
    case $vcs in
        git) psvar[1]='±' ;;
        hg)  psvar[1]='☿' ;;
    esac
}

# Initialize psvar and set up vcs_info
function precmd() { psvar=() ; vcs_info }

# OS detection and logo settings
[[ -n "${OS}" ]] || OS=$(uname)
if [ $OS = "Darwin" ]; then
    LOGO=""
else
    LOGO="🐧 "
fi

# Time format string (1:00 PM)
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
#
# Note that the entirety is wrapped in a check for TERM, since things like
# tramp will request a dumb prompt
#
# Newline and username
case "$TERM" in
"dumb")
PROMPT="> "
;;
*)
PROMPT="
%{$fg[blue]%}%{$bg[white]%}%n"

# Machine name, powerline transition
PROMPT="${PROMPT}%{$fg[green]%} @%{$fg[red]%} %m "
PROMPT="${PROMPT}%{$fg[white]%}${BG_COLOR_SEAGREEN}"

# Timestamp, powerline transition
PROMPT="${PROMPT}%{$fg[white]%}${BG_COLOR_SEAGREEN} ${_ZSH_TIME} "
PROMPT="${PROMPT}${FG_COLOR_SEAGREEN}${BG_COLOR_DARKBLUE}"

# Logo, directory, vcs info
PROMPT="${PROMPT}%{$fg[white]%}${BG_COLOR_DARKBLUE} ${LOGO} %2~"'${vcs_info_msg_0_}'

# Powerline transition, newline, sigil, powerline transition
PROMPT="${PROMPT} ${RESET}${FG_COLOR_DARKBLUE}
${RESET}%{$fg[white]%}${BG_COLOR_SEAGREEN} %(1v.%1v.$) "
PROMPT="${PROMPT}${RESET}${FG_COLOR_SEAGREEN}${RESET}"

# Right prompt return code
RPROMPT="%(?..%{$fg[red]%}%? ↵${RESET})"
;;
esac
