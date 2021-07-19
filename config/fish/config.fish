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
set -xg default_path ./node_modules/.bin /usr/bin /usr/sbin /bin /sbin /usr/local/mysql/bin/
set -xg homebrew /usr/local/bin /usr/local/sbin
set -xg tmux_gen $HOME/.tmuxgen/bin $HOME/.tmuxgen
set -xg python_path /usr/local/opt/python/libexec/bin
set -xg rust $HOME/.cargo/bin
set -xg composer $HOME/.composer/vendor/bin
set -xg ANDROID_HOME /Users/maliciousmind/Library/Android/sdk
set -xg JAVA_HOME /usr/local/opt/openjdk/bin
set -gx CPPFLAGS -I/usr/local/opt/openjdk/include
set -gx PATH $python_path $homebrew $default_path $tmux_gen $rust $composer
set -g fish_user_paths /usr/local/opt/openjdk/bin $fish_user_paths

set -gx KERL_BUILD_DOCS yes
set -xg RUBYOPT -W0
set -xg HOMEBREW_NO_ANALYTICS 1
set -xg FISH_CLIPBOARD_CMD pbcopy
set -xg EDITOR vim
set -xg MYSQL_USERNAME root
set -xg COVERAGE true
set -xg GPG_TTY (tty)
set -xg OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -xg STARSHIP_CONFIG ~/.config/starship.toml


test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

source (brew --prefix asdf)/asdf.fish
starship init fish | source

set uptime_days (string trim (uptime | grep -oEi '\\d+ days?'))
if test -n uptime_days
    echo "Days without restart:" $uptime_days
end
