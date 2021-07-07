#!/bin/zsh

# add submodule
git submodule update --init --recursive

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# dein
if [ -n "$HOME/.vim/dein" ]; then
    mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
fi

git clone https://github.com/Shougo/dein.vim \
    ~/.vim/dein/repos/github.com/Shougo/dein.vim

# symlink dotfiles
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zpreztorc ~/.zpreztorc

# change shell
chsh -s $(which zsh)

source ~/dotfiles/.zshrc
source ~/dotfiles/.zpreztorc