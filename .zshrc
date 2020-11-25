export ZSH="/home/zupzup/.oh-my-zsh"
ZSH_THEME="mz"

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"

plugins=(gitfast)

export LANG=en_US.UTF-8
source $ZSH/oh-my-zsh.sh

eval `keychain --eval --agents ssh id_rsa 2> /dev/null`

alias tig='gitui'
alias ll='exa -al'
alias l='exa -al'
alias ct='bat'
alias gows='cd ~/go/src/github.com/zupzup'
alias rst='cd ~/dev/oss/rust/'
alias tmlr='cd ~/dev/work/timeular'
alias git='LANG=en_US git'
alias tma='tmux attach -t'
alias cr='cargo run'
alias cck='cargo check --all-targets'
alias clp='cargo clippy --all-targets --all-features -- -D warnings'
alias vim='nvim'

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
export _JAVA_AWT_WM_NONREPARENTING=1

export PATH=$PATH:/home/zupzup/tools:/home/zupzup/tools/thunderbird:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin:/home/zupzup/go/bin:/home/zupzup/.local/bin:/home/zupzup/tools/ideac/bin:/usr/pgadmin4/bin
export LC_CTYPE="en_US.UTF-8"

export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=/home/zupzup/go
export GRADLE_OPTS=-Xmx1g

export CM_DIR=/home/zupzup
export CM_MAX_CLIPS=10000
export CM_IGNORE_WINDOW="1Password"

if [ -d "$HOME/adb-fastboot/platform-tools" ] ; then
 export PATH="$HOME/adb-fastboot/platform-tools:$PATH"
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode > /dev/null

xset r rate 220 80 > /dev/null
