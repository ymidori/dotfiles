# zplug init
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi
source ~/.zplug/init.zsh

# LANG
export LANG=ja_JP.UTF-8

# Use vim
export EDITOR="vim"

# PATH
# local pip
export PATH=$HOME/.local/bin:$PATH

# Add zplug bin
export PATH=$HOME/.zplug/bin:$PATH

# poetry
export PATH=$PATH:$HOME/.poetry/bin

# 個人的に作ったスクリプトのパスを追加
export PATH=$PATH:$HOME/bin

# サーバ個別のPATH設定をインポート
if [ -f ~/.zshrc.path ]; then
    source ~/.zshrc.path
fi

# alias
alias awk="gawk"
alias ll="ls -l"
alias la="ls -a"
alias mv="mv -i"
alias rm="rm -i"
alias grep="grep --color=auto -i"
alias rg="rg --color=auto -i"

# サーバ個別のalias設定をインポート
if [ -f ~/.zshrc.alias ]; then
    source ~/.zshrc.alias
fi

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 使いたいzshのプラグイン
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting"

# prezto用のプラグイン
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/homebrew", from:prezto
zplug "modules/ruby", from:prezto

# pecoで履歴を検索する
function peco-history-selection() {
    cmd='tac'
    case "${OSTYPE}" in
        freebsd*|darwin*)
            cmd=('tail' '-r')
        ;;
    esac
    BUFFER=`history -n 1 | $cmd | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection

# pecoでスニペットを読み込む
function peco-snippets-loader() {
    if ls ~/.peco.snippet* >/dev/null 2>&1; then
        snippet=`cat ~/.peco.snippet* | grep -v "^#" | peco`
        BUFFER="$(echo $snippet | sed -e 's/^\[.*\] *//') "
        CURSOR=$#BUFFER
    else
        echo "~/.peco.snippet* is not found."
    fi
    zle reset-prompt
}
zle -N peco-snippets-loader

# peco ghq search
function peco-ghq-search() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq-search

# peco関係の関数をキーバインドに登録
if type peco >/dev/null 2>&1; then
    bindkey '^r' peco-history-selection
    bindkey '^]' peco-ghq-search
    bindkey '^x' peco-snippets-loader
fi

# gitignore.io
function gi() {
    curl -sL https://www.gitignore.io/api/$@
}

_gitignoreio_get_command_list() {
    curl -sL https://www.gitignore.io/api/list | tr "," "\n"
}

_gitignoreio () {
    compset -P '*,'
    compadd -S '' `_gitignoreio_get_command_list`
}

compdef _gitignoreio gi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


# Then, source plugins and add commands to $PATH
zplug load --verbose
