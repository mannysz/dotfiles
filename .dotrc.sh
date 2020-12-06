# load git prompt if it exists
if [ -f $HOME/.git-prompt ]; then
    . $HOME/.git-prompt
fi

# load the custom aliases is it exists
if [ -f $HOME/.aliases ]; then
    . $HOME/.aliases
fi

# PYENV Settings
export PYENV_ROOT=$HOME/.pyenv
export PATH=$HOME/bin:$PYENV_ROOT/shims:$PATH

# lookup path for "goto" custom function defined in .aliases
export LOOKUPPATH=$HOME/repo:$HOME/src


# virtualenv wrapper settings
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi


# pyenv initialization
if [ command -v pyenv 1>/dev/null 2>&1 ]; then
    eval "$(pyenv init -)"
fi

source $HOME/.bash_completion
