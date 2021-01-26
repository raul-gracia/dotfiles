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
set -xg JAVA_HOME /Library/Java/Home
set -xg JAVA_HOME (/usr/libexec/java_home)
set -gx CPPFLAGS "-I/usr/local/opt/openjdk/include"



set -gx PATH $python_path $homebrew $default_path $tmux_gen $rust $composer

set -xg OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

function ggi
    ggdo install $argv[1]
end
function ggiu
    ggdo uninstall $argv[1]
end

function ggdo --description 'Globally install/uninstall a gem for all ruby versions'
    set -l versions (rbenv versions | ruby -e 'puts $stdin.read.split("\n").map { |l| l.scan(/(\d\.\d\.\d-?p?\d{3}?)/)}')
    echo 1 $argv[1]
    echo 2 $argv[2]
    for i in $versions
        echo $argv[1] $argv[2] for $i
        rbenv local $i
        gem $argv[1] $argv[2] >/dev/null
    end
end

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

source (brew --prefix asdf)/asdf.fish
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

set uptime_days (string trim (uptime | grep -oEi '\\d+ days?'))
if test -n uptime_days
    echo "Days without restart:" $uptime_days
end
