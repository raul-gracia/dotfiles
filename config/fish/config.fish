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

# Exports for PATH
set -xg default_path ./node_modules/.bin /usr/bin /usr/sbin /bin /sbin /usr/local/mysql/bin/
set -xg homebrew /usr/local/bin /usr/local/sbin
set -xg tmux_gen $HOME/.tmuxgen/bin $HOME/.tmuxgen
set -xg RUBYOPT "-W0"
set -xg python_path /usr/local/opt/python/libexec/bin
set -xg rust $HOME/.cargo/bin
set -xg composer $HOME/.composer/vendor/bin

set -xg ANDROID_HOME /Users/maliciousmind/Library/Android/sdk
set -xg JAVA_HOME /usr/local/opt/openjdk/bin
set -gx CPPFLAGS "-I/usr/local/opt/openjdk/include"

set -gx PATH $python_path $homebrew $default_path $tmux_gen $rust $composer
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

set -xg OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

source (brew --prefix asdf)/asdf.fish

set uptime_days (string trim (uptime | grep -oEi '\\d+ days?'))
if test -n uptime_days
    echo "Days without restart:" $uptime_days
end