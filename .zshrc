CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"

export LANG=en_US.UTF-8

eval `keychain --eval --agents ssh id_ed25519 2> /dev/null`

alias cw='calories -w'
alias ca='calories add'
alias tig='gitui'
alias ll='exa -al'
alias l='exa -al'
alias ct='bat'
alias gows='cd ~/go/src/github.com/zupzup'
alias rst='cd ~/dev/oss/rust/'
alias tmlr='cd ~/dev/work/timeular'
alias bitcr='cd ~/dev/work/bitcr'
alias git='LANG=en_US git'
alias tma='tmux attach -t'
alias cr='cargo run'
alias ccov='cargo tarpaulin --out html --skip-clean'
alias cck='cargo check --all-targets --all-features'
alias clp='cargo clippy --all-targets --all-features'
alias vim='nvim'
alias vi='nvim'
alias is='cd ~/tools/infosec'
alias wrt="cd ~/Tresors/mario\'s\ tresor/writing"
alias ltxmk='latexmk -verbose -pdf -file-line-error -synctex=1 -interaction=nonstopmode'
alias notes="cd ~/Tresors/mario\'s\ tresor/notes/md"

export HISTSIZE=1000000
export HISTFILESIZE=2000000
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
export PATH=$HOME/.local/bin:$PATH

export PATH=$PATH:/home/zupzup/tools:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin:/home/zupzup/go/bin:/home/zupzup/.local/bin:/home/zupzup/tools/ideac/bin:/usr/pgadmin4/bin
export PATH="$PATH:/opt/nvim-linux64/bin"
export LC_CTYPE="en_US.UTF-8"

export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=/home/zupzup/go
export GRADLE_OPTS=-Xmx2g

if [ -d "$HOME/adb-fastboot/platform-tools" ] ; then
 export PATH="$HOME/adb-fastboot/platform-tools:$PATH"
fi

~/tools/cameractrls/cameractrls.py -d /dev/video2 -l -c power_line_frequency=50_hz > /dev/null


export FZF_DEFAULT_COMMAND='ag -g ""'

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
