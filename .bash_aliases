alias ls="ls --color=auto"
if [[ -z "${VIM}" ]]; then
    alias vim="nvim"
else
    alias vim="nvr"
fi
alias t="tmux new -ADs"
alias tls="tmux ls"
