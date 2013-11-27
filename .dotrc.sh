source $HOME/git-prompt.sh
COLOR_BLUE='\[\033[0;36m\]'
COLOR_GOLD='\[\033[0;33m\]'
COLOR_DEFAULT='\[\033[0;0m\]'
PS1="$COLOR_BLUE[\u@\h \W$COLOR_GOLD`__git_ps1`$COLOR_BLUE]\$ $COLOR_DEFAULT"
