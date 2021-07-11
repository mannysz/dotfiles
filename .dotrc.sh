# load git prompt if it exists
if [ -f $HOME/.git-prompt ]; then
    . $HOME/.git-prompt
fi

# load the custom aliases if it exists
if [ -f $HOME/.aliases ]; then
    . $HOME/.aliases
fi

# Node Version Manager Settings
export N_PREFIX=$HOME/.n

# Python Libraries Path (MacOS)
export PYVERSION=3.8
export PYLIBS=$HOME/Library/Python/$PYVERSION

# lookup path for "goto" custom function defined in .aliases
export LOOKUPPATH=$HOME/repo:$HOME/src

# Add Homebrew to Path
export PATH="$PATH:/opt/homebrew/bin"

# Add local Python bin to Path
export PATH="$PATH:$PYLIBS/bin"

# Add Node version manager to Path
export PATH="$PATH:$N_PREFIX/bin"

# pyenv initialization
if [ command -v pyenv 1>/dev/null 2>&1 ]; then
    eval "$(pyenv init -)"
fi

autoload bashcompinit
bashcompinit
autoload -Uz compinit
compinit
source $HOME/.bash_completion
