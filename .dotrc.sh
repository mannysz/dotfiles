source $HOME/.git-prompt
source $HOME/.aliases
COLOR_BLUE='\[\033[0;36m\]'
COLOR_GOLD='\[\033[0;33m\]'
COLOR_DEFAULT='\[\033[0;0m\]'
PS1="$COLOR_BLUE[\u@\h \W$COLOR_GOLD\$(__git_ps1 ' (%s)')$COLOR_BLUE]\$ $COLOR_DEFAULT"

# enabling git completion on bash
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# enable path for home binary
PATH=$PATH:$HOME/bin
