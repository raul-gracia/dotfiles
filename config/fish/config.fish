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

set -gx PATH $python_path $homebrew $default_path $tmux_gen

status --is-interactive
and source (rbenv init -|psub)
set -gx PATH '/Users/maliciousmind/.rbenv/shims' $PATH

function ggi --description 'Globally install a gem ie: for all ruby versions'
    set -l versions (rbenv versions | ruby -e '$stdin.read.split("\n").each { |l| version = l.match(/(\d\.\d\.\d-?p?\d{3}?)/); puts version[0] if version;}')
    for version in $versions
        echo Installing $argv[1] for $version
        rbenv local $version
        gem install $argv[1] >/dev/null
    end
end

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/maliciousmind/Downloads/google-cloud-sdk/path.fish.inc' ]
    . '/Users/maliciousmind/Downloads/google-cloud-sdk/path.fish.inc'
end
