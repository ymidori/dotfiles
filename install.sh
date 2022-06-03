#!/bin/zsh

# symlink dotfiles
# ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.zshrc ~/.zshrc
# ln -sf `pwd`/.zpreztorc ~/.zpreztorc

# if [ -n "$HOME/.vim/dein" ]; then
#     mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
# fi

# curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# # For example, we just use `~/.cache/dein` as installation directory
# sh ./installer.sh ~/.cache/dein

# change shell
chsh -s $(which zsh)

source `pwd`/.zshrc
