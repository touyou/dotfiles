#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

setopt nonomatch

path=(
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/bin(N-/)
    $path
)

eval "$(hub alias -s)"

export EDITOR=/usr/local/bin/vim
export PAGER=/usr/local/bin/vimpager
export GOPATH=$HOME/go
function title {
    echo -ne "\033]0;"$*"\007"
}

function show_open_issue_on_web {
    ghi show -w $(ghi list --filter 'all' | peco)
}
alias si=show_open_issue_on_web
alias sudo='sudo '
alias pip-update='pip freeze --local | grep -v '\''^\-e'\'' | cut -d = -f 1 | xargs pip install -U'
alias pip3-update='pip3 freeze --local | grep -v '\''^\-e'\'' | cut -d = -f 1 | xargs pip3 install -U'
alias ocaml='rlwrap ocaml'

function apt-update() {
    sudo apt-get update;
    sudo apt-get upgrade;
    sudo apt-get clean
}

function gifo() { git-foresta --style=10 "$@" | less -RSX }
function gifa() { git-foresta --all --style=10 "$@" | less -RSX }
compdef _git gifo=git-log
compdef _git gifa=git-log
