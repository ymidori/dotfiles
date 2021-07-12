#!/bin/zsh

# symlink dotfiles
ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.zshrc ~/.zshrc
ln -sf `pwd`/.zpreztorc ~/.zpreztorc

# add submodule
git submodule update --init --recursive

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Install vim
# echo "Install VIM from github online repository vim/vim."
# if [ -d "$HOME/src" ]; then
#     cd "$HOME/src"
# else
#     echo "Not found [ $HOME/src ]"
#     exit 1
# fi
# pwd

# if [ ! -d "${HOME}/src/vim" ]; then
#     echo "clone vim/vim repository"
#     git clone https://github.com/vim/vim.git && cd vim
# else
#     echo "pull vim/vim"
#     cd vim
#     git pull
# fi

# make clean

# ./configure \
#     --prefix=$HOME \
#     --enable-multibyte \
#     --with-features=huge \
#     --enable-luainterp \
#     --enable-perlinterp \
#     --enable-pythoninterp=dynamic \
#     --enable-python3interp=dynamic \
#     --enable-rubyinterp \
#     --disable-gui \
#     --enable-fontset \
#     &&

# make; make install
apt-get install vim -y

# if [ -n "$HOME/.vim/dein" ]; then
#     mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
# fi

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

# change shell
chsh -s $(which zsh)

source `pwd`/.zshrc
source `pwd`/.zpreztorc