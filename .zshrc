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

path=(
    $HOME/.pyenv/bin(N-/)
    $HOME/.swiftenv/shims(N-/)
    /usr/local/Celllar(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/bin(N-/)
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
function title {
    echo -ne "\033]0;"$*"\007"
}

function show_open_issue_on_web {
    ghi show -w $(ghi list --filter 'all' | peco)
}
alias si=show_open_issue_on_web
