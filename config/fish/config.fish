# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'robbyrussell'
Plugin 'theme'
Plugin 'brew'
Plugin 'bundler'
Plugin 'gem'
Plugin 'node'
Plugin 'pbcopy'
Plugin 'rails'
Plugin 'rbenv'
Plugin 'tmux'


if test -f $HOME/.config/fish/aliases.fish
  source $HOME/.config/fish/aliases.fish
end

if test -f $HOME/.config/fish/export.fish
  source $HOME/.config/fish/export.fish
end

function fish_title;end
function fish_greeting;end
set -gx PATH $PATH /usr/local/share/npm/bin
# TmuxGEN
set -gx PATH $PATH $HOME/.tmuxgen/bin $HOME/.tmuxgen
set -gx RBENV_ROOT /usr/local/var/rbenv
status --is-interactive; and . (rbenv init -|psub)
