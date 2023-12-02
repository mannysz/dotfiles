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

# lookup path for "goto" custom function defined in .aliases
export LOOKUPPATH=$HOME/repo:$HOME/src

# Add Homebrew to Path
export PATH="$PATH:/opt/homebrew/bin"

# Add Node version manager to Path
export PATH="$PATH:$N_PREFIX/bin"

# pyenv initialization
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


autoload bashcompinit
bashcompinit
autoload -Uz compinit
compinit

source $HOME/.bash_completion
source $HOME/.sdkman/bin/sdkman-init.sh
