#/bin/zsh

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install packages
brew insatll git
brew install tmux
brew install fzf
brew install ag
brew install ctags
brew install n
brew install python@3.9
brew install lua
brew install luajit
brew install neovim
brew install hub

# installing tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# installing vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Python
pyenv install 3.8.5
pyenv global 3.8.5
pyenv local 3.8.5
pip3 install neovim

# NodeJS
n lts
npm install -g neovim eslint prettier eslint-plugin-prettier
