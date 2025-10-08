#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
eval "$(atuin init bash)"

. "$HOME/.local/bin/env"

# Custom alias for my theme switcher
alias theme='~/.scripts/theme-switcher.sh'
alias u='warp-cli connect'
alias d='warp-cli disconnect'
