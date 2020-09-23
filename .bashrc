BLOCKSIZE=K;	export BLOCKSIZE
EDITOR=nvim;   	export EDITOR
PAGER=less;  	export PAGER

# Enable the builtin emacs(1) command line editor in sh(1),
# e.g., C-a -> beginning-of-line.
set -o emacs

# Uncomment this and comment the above to enable the builtin vi(1) command
# line editor in sh(1), e.g., ESC to go into normal mode.
# set -o vi

# set prompt: ``username@hostname:path$ ''
PS1="\u@\h:\w"
case `id -u` in
	0) PS1="${PS1}# ";;
	*) PS1="${PS1}$ ";;
esac

source ~/.bash_aliases

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# We use \C-s for fzf file location.
# stty -ixon is required to disable the default \C-s behavior.
bind -x '"\C-s": fzf-file-widget'
stty -ixon
