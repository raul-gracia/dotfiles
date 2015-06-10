if test -f $HOME/.config/fish/aliases.fish
  source $HOME/.config/fish/aliases.fish
end

if test -f $HOME/.config/fish/export.fish
  source $HOME/.config/fish/export.fish
end

function fish_title;end
function fish_greeting;end
#plugins=(git rails ruby brew bundler vundle gem heroku node npm pow powder rvm zsh-syntax-highlighting)
set -x PATH $PATH:/usr/local/share/npm/bin
# Homebrew
set -x PATH "/usr/local/bin:$PATH"
# TmuxGEN
set -x PATH $PATH:$HOME/.tmuxgen/bin:$HOME/.tmuxgen
set -g CDPATH (pwd) $HOME/Documents/development/magnetic
set -gx RBENV_ROOT /usr/local/var/rbenv
#source (rbenv init -|psub)
