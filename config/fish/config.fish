if test -f $HOME/.config/fish/aliases.fish
    source $HOME/.config/fish/aliases.fish
end

if test -f $HOME/.config/fish/exports.fish
    source $HOME/.config/fish/exports.fish
end

function fish_title
end
function fish_greeting
end

# Exports for PATHs
set -xg default_path ./node_modules/.bin /usr/bin /usr/sbin /bin /sbin /usr/local/mysql/bin/ /usr/local/bin /usr/local/texlive/2023basic/bin/universal-darwin/

set -xg homebrew /opt/homebrew/bin /opt/homebrew/sbin
set -xg rust $HOME/.cargo/bin
set -xg composer $HOME/.composer/vendor/bin
set -xg ANDROID_HOME /Users/(whoami)/Library/Android/sdk
set -xg ANDROID_SDK_ROOT /Users/(whoami)/Library/Android/sdk
set -xg JAVA_HOME (java -XshowSettings:properties -version 2>&1 >/dev/null | grep 'java.home' | sed -E 's/^\ +java\.home = //')
set -xg rover_path /Users/(whoami)/.rover/bin
set -xg PATH $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator $ANDROID_HOME/tools/bin $homebrew $default_path $rust $composer $rover_path 
set -g fish_user_paths $JAVA_HOME $fish_user_paths


set -gx KERL_BUILD_DOCS yes
set -xg RUBYOPT -W0
set -xg RUBY_CFLAGS -w
set -xg HOMEBREW_NO_ANALYTICS 1
set -xg FISH_CLIPBOARD_CMD pbcopy
set -xg EDITOR nvim
set -xg MYSQL_USERNAME root
set -xg COVERAGE true
set -xg GPG_TTY (tty)
set -xg OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -xg STARSHIP_CONFIG ~/.config/starship.toml

set -xg PATH $homebrew $PATH

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

starship init fish | source

if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end

thefuck --alias | source
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

if command -s zellij >/dev/null
  zellij setup --generate-completion fish | source
end