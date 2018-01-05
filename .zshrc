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
    $HOME/.pyenv/bin(N-/)
    $HOME/.swiftenv/shims(N-/)
    $HOME/.opam/packages(N-/)
    $HOME/.cabal/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    /usr/local/Celllar(N-/)
    /usr/local/Cellar/ruby/2.4.2_1/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/local/opt/llvm/bin(N-/)
    $HOME/bin(N-/)
    $HOME/.local/bin(N-/)
    $HOME/.fastlane/bin(N-/)
    $HOME/Library/Android/sdk/platform-tools(N-/)
    /Library/TeX/texbin(N-/)
    $path
)

eval "$(plenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(swiftenv init -)"
eval "$(hub alias -s)"

export EDITOR=/usr/local/bin/vim
export PAGER=/usr/local/bin/vimpager
export GOPATH=$HOME/go
export TOOLCHAINS=swift
export ANDROID_HOME=$HOME/Library/Android/sdk
# brew
if [ -f $(brew --prefix)/etc/brew-wrap ];then
    source $(brew --prefix)/etc/brew-wrap
fi
function title {
    echo -ne "\033]0;"$*"\007"
}
export HOMEBREW_GITHUB_API_TOKEN="cfe7c7310a73e661166d1eb470c486315c8e7b74"


function show_open_issue_on_web {
    ghi show -w $(ghi list --filter 'all' | peco)
}
alias si=show_open_issue_on_web
alias sudo='sudo '
alias pip-update='pip freeze --local | grep -v '\''^\-e'\'' | cut -d = -f 1 | xargs pip install -U'
alias pip3-update='pip3 freeze --local | grep -v '\''^\-e'\'' | cut -d = -f 1 | xargs pip3 install -U'
alias octave='octave --no-gui'
alias ocaml='rlwrap ocaml'

function brup() {
    brew upgrade;
    brew cleanup;
    brew cask_upgrade -C;
    brew cask cleanup
}

function allupdate() {
    brup;
    pip-update;
    pip3-update;
    sudo gem update
}

function gifo() { git-foresta --style=10 "$@" | less -RSX }
function gifa() { git-foresta --all --style=10 "$@" | less -RSX }
compdef _git gifo=git-log
compdef _git gifa=git-log

# OPAM configuration
. /Users/touyou/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
export OCAMLPARAM="_,bin-annot=1"
export OPAMKEEPBUILDDIR=1
