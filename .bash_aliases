alias ls="ls --color=auto"
if [[ -z "${VIM}" ]]; then
    alias vim="nvim"
else
    alias vim="nvr"
fi
alias t="tmux attach -dt"
alias tn="tmux new -s"
alias tx="tmux kill-session -t"
alias tls="tmux ls"
