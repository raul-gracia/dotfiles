# Path to your oh-my-fish.
set -g OMF_PATH $HOME/.local/share/omf

# Path to your oh-my-fish configuration.
set -g OMF_CONFIG $HOME/.config/omf

### Configuration required to load oh-my-fish ###
# Note: Only add configurations that are required to be set before oh-my-fish is loaded.
# For common configurations, we advise you to add them to your $OMF_CONFIG/init.fish file or
# to create a custom plugin instead.

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

if test -f $HOME/.config/fish/aliases.fish
  source $HOME/.config/fish/aliases.fish
end

if test -f $HOME/.config/fish/exports.fish
  source $HOME/.config/fish/exports.fish
end

function fish_title;end
function fish_greeting;end

# Exports for PATH
set -xg default_path ./node_modules/.bin /usr/bin /usr/sbin /bin /sbin /usr/local/mysql/bin/
set -xg homebrew /usr/local/bin
set -xg tmux_gen $HOME/.tmuxgen/bin $HOME/.tmuxgen
set -xg rust_path $HOME/.cargo/bin
set -xg RUBYOPT "-W0"

# Exports for go
set -xg GOPATH $HOME/go
set -xg GOBIN $GOPATH/bin
set -xg go_root /usr/local/opt/go/libexec/bin

set -gx PATH $go_root $homebrew \
$default_path $tmux_gen $GOBIN $rust_path

# Android
set -xg ANDROID_HOME $HOME/Library/Android/sdk
set -xg PATH $PATH $ANDROID_HOME/tools
set -xg PATH $PATH $ANDROID_HOME/tools/bin
set -xg PATH $PATH $ANDROID_HOME/platform-tools
set -xg PATH $PATH $ANDROID_HOME/build-tools/25.0.2

status --is-interactive; and source (rbenv init -|psub)
set -gx PATH '/Users/maliciousmind/.rbenv/shims' $PATH

function ggi --description 'Globally install a gem ie: for all ruby versions'
  set -l versions (rbenv versions | ruby -e '$stdin.read.split("\n").each { |l| version = l.match(/(\d\.\d\.\d-?p?\d{3}?)/); puts version[0] if version;}')
  for version in $versions
    echo Installing $argv[1] for $version
    rbenv local $version
    gem install $argv[1] > /dev/null
  end
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
