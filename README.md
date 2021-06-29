# My Computer Setup and Dotfiles Configuration

## Installation

```bash
curl -s https://raw.githubusercontent.com/raul-gracia/dotfiles/master/bootstrap.sh | bash
```

# Description

This script will:
* Install/Update [Homebrew](https://brew.sh)
* Install/Update [Fish Shell](https://fishshell.com)
* Install [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish)
* Clone and symlink all my dotfiles (vim, tmux, fish aliases, etc..)
* Install the most common OSX tools and UI Apps that I use
* Configure everything correctly (vim, tmux, Monaco font, ...)

For the complete list of tools check the Brewfiles:
- General/Work Only apps: [Brewfile.standard](Brewfile.standard)
- Personal apps: [Brewfile.personal](Brewfile.personal)
