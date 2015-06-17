set -e
# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'robbyrussell'
Plugin 'theme'
Plugin 'brew'
Plugin 'gem'
Plugin 'node'
Plugin 'rails'
Plugin 'tmux'


if test -f $HOME/.config/fish/aliases.fish
  source $HOME/.config/fish/aliases.fish
end

if test -f $HOME/.config/fish/export.fish
  source $HOME/.config/fish/export.fish
end

function fish_title;end
function fish_greeting;end
set default_path /usr/bin /usr/sbin /bin /sbin
set homebrew /usr/local/bin /usr/local/sbin
set brew_rbenv "/usr/local/var/rbenv/shims"
set tmux_gen $HOME/.tmuxgen/bin $HOME/.tmuxgen
set npm_bin /usr/local/share/npm/bin

# Exports for go
set -xg GOPATH $HOME/go
set -xg GOBIN $GOPATH/bin

set appengine_python $HOME/Documents/go_appengine

set -gx PATH $homebrew $brew_rbenv $default_path $tmux_gen $npm_bin $GOBIN \
             '/usr/local/opt/go/libexec/bin' $appengine_python

set -gx RBENV_ROOT /usr/local/var/rbenv
set -e SHELL
status --is-interactive; and . (rbenv init -|psub)

function varclear --description 'Remove duplicates from environment variable'
  set -l unique_values (echo $argv[2..-1] | ruby -e 'puts $stdin.read.split.uniq.join("\n")')
  set $argv[1] $unique_values
end
varclear PATH $PATH
