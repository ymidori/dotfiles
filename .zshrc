# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
zstyle ':completion:*:default' menu select

### zsh config
bindkey -e # シェル操作をvim互換にする
autoload -U compinit # ディレクトリ名をtabを押して補完するときに選択してるやつに色つける
compinit # ディレクトリ名をtabを押して補完するときに選択してるやつに色つける
setopt list_packed # 補完候補を詰めて表示
setopt noautoremoveslash # ディレクトリ選択時、最後の/を残す。好み。
setopt list_types # 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
zstyle ':completion:*:default' list-colors ${LS_COLORS} # lsコマンドの補完候補にも色付き表示

### alias
alias awk="gawk"
alias ll="ls -l"
alias la="ls -a"
alias mv="mv -i"
alias rm="rm -i"
alias grep="grep --color=auto -i"
alias rg="rg --color=auto -i"
alias vim="nvim"

### Zinit Config
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light mollifier/anyframe
# zinit light zdharma-continuum/fast-syntax-highlighting
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet PZTM::helper
### End of Zinit Config
# en_US.UTF-8
### peco関係の関数をキーバインドに登録
bindkey '^b' anyframe-widget-cdr
bindkey '^r' anyframe-widget-put-history
bindkey '^]' anyframe-widget-cd-ghq-repository
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

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

# compdef _gitignoreio gi

# export GITHUB_TOKEN=`cat ~/.ssh/github_token`
# ssh-add -K ~/.ssh/id_rsa
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# box autocomplete setup
# BOX_AC_ZSH_SETUP_PATH=/Users/y.midorikawa/Library/Caches/@box/cli/autocomplete/zsh_setup && test -f $BOX_AC_ZSH_SETUP_PATH && source $BOX_AC_ZSH_SETUP_PATH;


