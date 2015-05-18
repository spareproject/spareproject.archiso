# /etc/bash.bashrc
##########################################################################################################################################################################################
[[ $- != *i* ]] && return
if [[ $(id -u) != 0 ]];then
  if [[ $(id -g) == "10" ]];then
    PS1="\[\e[32m\][\u@archiso]\[\e[37m\][\w]:\[\e[m\] "
  else
  PS1="\[\e[32m\][\u@archiso]\[\e[33m\][\w]:\[\e[m\] "
  fi
else
    PS1="\[\e[32m\][\u@archiso]\[\e[31m\][\w]:\[\e[m\] "
fi
PS2='> '
PS3='> '
PS4='+ '
##########################################################################################################################################################################################
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
##########################################################################################################################################################################################
alias ls='ls --color=auto'
alias l='ls -lh'
alias ll='ls -alh'
alias c='clear; cat /etc/banner'
alias cl='clear;cat /etc/banner;ls -lAh'
alias cll='clear;cat /etc/banner;ls -alh'
alias ..='cd ..'
export EDITOR=vim
##########################################################################################################################################################################################
function passwdgen { cat /dev/random | tr -cd 'a-zA-Z0-9' | fold -w 32 | head -n 1; }
