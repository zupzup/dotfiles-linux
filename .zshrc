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
alias gows='cd ~/go/src/github.com/zupzup'
alias rst='cd ~/dev/oss/rust/'
alias tmlr='cd ~/dev/work/timeular'
alias bitcr='cd ~/dev/work/bitcr'
alias git='LANG=en_US git'
alias cr='cargo run'
alias cck='cargo check --all-targets'
alias ckc='cargo check --all-targets'
alias clp='cargo clippy --all-targets'
alias vim='nvim'
alias ivm='nvim'
alias vi='nvim'
alias ltxmk='latexmk -verbose -pdf -file-line-error -synctex=1 -interaction=nonstopmode'
alias notes="cd ~/Tresorit/mario\'s\ tresor/notes/md"
alias orange='vmd'

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

export PATH=$PATH:/home/mario/tools:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin:/home/mario/go/bin:/home/mario/.local/bin:/home/mario/tools/ideac/bin
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH=/home/mario/.surrealdb:$PATH
export LC_CTYPE="en_US.UTF-8"

export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=/home/mario/go

# ~/tools/cameractrls/cameractrls.py -d /dev/video5 -l -c power_line_frequency=50_hz > /dev/null 2> /dev/null

export FZF_DEFAULT_COMMAND='rg -g ""'

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
