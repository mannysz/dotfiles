source `dirname $0`/.git-prompt
source `dirname $0`/.aliases
COLOR_BLUE='\[\033[0;36m\]'
COLOR_GOLD='\[\033[0;33m\]'
COLOR_DEFAULT='\[\033[0;0m\]'
PS1="$COLOR_BLUE[\u@\h \W$COLOR_GOLD\$(__git_ps1 ' (%s)')$COLOR_BLUE]\$ $COLOR_DEFAULT"
