set fish_greeting ""

set DOTNET_CLI_TELEMETRY_OPTOUT 1
set HAXE_STD_PATH "/opt/homebrew/lib/haxe/std"
set PLAYDATE_SDK_PATH "$HOME/Developer/PlaydateSDK"

set PATH $HOME/bin /opt/homebrew/bin $HOME/.cargo/bin $HOME/Developer/devops/bin /opt/homebrew/opt/mongodb-community@4.4/bin $HOME/.jenv/bin /Applications/tic80.app/Contents/MacOS $PATH

status --is-interactive; and source (jenv init -|psub)

alias ls "exa"
alias lss "exa -al"
alias cat "bat"
alias vim "nvim"
alias neo "neovide"

set -x NVM_DIR ~/.nvm
nvm use default --silent

starship init fish | source
