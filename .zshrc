export ZSH="/home/zupzup/.oh-my-zsh"
ZSH_THEME="mz"

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"

plugins=(gitfast)

export LANG=en_US.UTF-8
source $ZSH/oh-my-zsh.sh

alias ls='ls -G'
alias ll='ls -lG'
alias gows='cd ~/go/src/github.com/zupzup'
alias rst='cd ~/dev/oss/rust/'
alias tmlr='cd ~/dev/work/timeular'
alias gotmlr='cd ~/go/src/gitlab.com/timeular'
alias git='LANG=en_US git'
alias tma='tmux attach -t'
alias cr='cargo run'
alias ct='cargo test'
alias cck='cargo check'
alias clp='cargo clippy --all-targets --all-features -- -D warnings'
alias orange='/home/zupzup/tools/orange'

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

export GREP_OPTIONS="--color"

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export EDITOR=vi
set -o emacs

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export WORDCHARS='*?[]~&;!$%^<>'
export ACK_COLOR_MATCH='red'

export PATH="/usr/local/bin:$PATH"

export PATH=$PATH:/home/zupzup/tools:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/home/zupzup/go/bin
export LC_CTYPE="en_US.UTF-8"

export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=/home/zupzup/go
export GRADLE_OPTS=-Xmx1g

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
