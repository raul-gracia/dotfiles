# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="steeef_simplified"
plugins=(git rails ruby brew bundler vundle gem heroku node npm pow powder rvm zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.zsh/zsh-aliases ]; then
  source $HOME/.zsh/zsh-aliases
fi

if [ -f $HOME/.zsh/zsh-exports ]; then
  source $HOME/.zsh/zsh-exports
fi

export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Homebrew
export PATH="/usr/local/bin:$PATH"

# TmuxGEN
PATH=$PATH:$HOME/.tmuxgen/bin:$HOME/.tmuxgen

setopt auto_cd
cdpath=($HOME/Documents/rails-apps $HOME/Documents/devops $HOME/Documents/development/magnetic)

# Brew Cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
