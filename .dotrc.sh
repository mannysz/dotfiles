# load git prompt if it exists
if [ -f $HOME/.git-prompt ]; then
    . $HOME/.git-prompt
fi

# load the custom aliases is it exists
if [ -f $HOME/.aliases ]; then
    . $HOME/.aliases
fi

# loading autoenv if it exists
if [ -f /usr/local/opt/autoenv/activate.sh ]; then
    . /usr/local/opt/autoenv/activate.sh
fi

# enabling git completion on bash
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# enable path for home binary
PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH:$HOME/bin

# define prompt colors
COLOR_BLUE='\[\033[0;36m\]'
COLOR_GOLD='\[\033[0;33m\]'
COLOR_DEFAULT='\[\033[0;0m\]'
PS1="$COLOR_BLUE[\u@\h \W$COLOR_GOLD\$(__git_ps1 ' (%s)')$COLOR_BLUE]\$ $COLOR_DEFAULT"

source /usr/local/bin/virtualenvwrapper.sh
