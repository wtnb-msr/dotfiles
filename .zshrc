# モジュール別に読み込む
function load() {
  lib=${1:?"You have to specify a library file"}
  if [ -f "$lib" ]; then
    . "$lib"
  fi
}

ZSHDIR=${HOME}/.zsh.d
load ${ZSHDIR}/zsh_alias
load ${ZSHDIR}/zsh_config
load ${ZSHDIR}/zsh_notify

# .zshrc
eval "$(rbenv init - zsh)"

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                   /usr/local/git/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 補完候補の選択・ハイライト
zstyle ':completion:*:default' menu select=1

# zsh-completions
fpath=(path/to/zsh-completions/src $fpath)


########################################
########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
# setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
#setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        ;;
esac

# vim:set ft=zsh:

##### Additional applications #####

# Homebrew
export PATH=/usr/local/bin:$PATH

# XAMPP MySQL
#export PATH=/Applications/XAMPP/xamppfiles/bin:$PATH

# Madever : evernote markdown
export PATH=$HOME/.cabal/bin:$PATH

# Vagrant
export PATH=/Applications/Vagrant/bin:$PATH

# Ruby environment
export PATH=$HOME/.rbenv/bin:$PATH

# Gem setting ローカル環境にインストール
export GEM_HOME=~/Applications/extlib/gems
export PATH=$GEM_HOME/bin:$PATH

# Java
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.6"`
export PATH=${JAVA_HOME}/bin:${PATH}
alias javac='javac -J-Dfile.encoding=utf-8'
alias java='java -Dfile.encoding=utf-8'

# ant opt
export ANT_OPTS=-Dfile.encoding=UTF8

# tmuxinator
#export EDITOR='vim'
#export SHELL='/usr/local/bin/zsh'
#source ~/.tmuxinator/tmuxinator.zsh

# Applications/apps
export PATH=${HOME}/Applications/apps:${PATH}
