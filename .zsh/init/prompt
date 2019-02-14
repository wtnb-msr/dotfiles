# Enable vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}

# Enable add-zsh-hook
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info_msg

# Left side prompt
#PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
#> %* $ "
PROMPT="%{${fg[green]}%}[%n@%*]%{${reset_color}%} %~
$ "

# Right side prompt
RPROMPT="${vcs_info_msg_0_}"

# Update prompt every second
#TRAPALRM () { zle reset-prompt }
#TMOUT=1
