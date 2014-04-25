# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="steeef_simplified"
plugins=(git rails ruby brew bundler vundle gem heroku node npm pow powder rvm)

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.zsh/zsh-aliases ]; then
  source $HOME/.zsh/zsh-aliases
fi

if [ -f $HOME/.zsh/zsh-exports ]; then
  source $HOME/.zsh/zsh-exports
fi

PATH=$PATH:/usr/local/share/npm/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

setopt auto_cd
cdpath=($HOME/Documents/rails-apps $HOME/Documents/devops)

# Homebrew
PATH=/usr/local/bin:$PATH

# TmuxGEN
PATH=$PATH:$HOME/.tmuxgen/bin:$HOME/.tmuxgen
