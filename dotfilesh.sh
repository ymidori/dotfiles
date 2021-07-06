# zshをインストール
$ brew install zsh
# zshをデフォルトに設定
$ chsh -s /bin/zsh

brew install zplug

ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto $HOME/.zprezto

mv ~/.zshrc ~/.zshrc.backup

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
   ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
