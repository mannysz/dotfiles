#/bin/zsh

DIRNAME=$(dirname $0)

# Shell & Terminal Settings
ln -s $DIRNAME/.aliases $HOME/.aliases
ln -s $DIRNAME/.dotrc.sh $HOME/.dotrc.sh
ln -s $DIRNAME/.zshrc $HOME/.zshrc
ln -s $DIRNAME/.bash_completion $HOME/.bash_completion

# Tmux Settings
ln -s $DIRNAME/.tmux.conf $HOME/.tmux.conf

# NeoVim Settings
#ln -s $DIRNAME/.config $HOME/.config
#ln -s $DIRNAME/.vimrc $HOME/.vimrc

# Git Configuration
ln -s $DIRNAME/.git_template $HOME/.git_template
ln -s $DIRNAME/.git-prompt $HOME/.git-prompt
ln -s $DIRNAME/.gitconfig $HOME/.git-config
ln -s $DIRNAME/bin $HOME/bin

source $HOME/.dotrc.sh

# install packages
brew install tmux
brew install fzf
brew install ag
brew install n
brew install bun
brew install pyenv
brew install lua
brew install luajit
brew install neovim
brew install hub
brew install ripgrep
brew install tig

# installing tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Python
pyenv install 3.14.0
pyenv global 3.14.0

# NodeJS
n lts

# Language Servers
brew install bash-language-server
pyenv exec pip install python-lsp-server
npm install -g pyright
pip install python-lsp-server
npm install -g typescript-language-server typescript
bun install -g typescript-language-server typescript
npm install -g vscode-langservers-extracted
bun install -g vscode-langservers-extracted

# Installing VIM Plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall
