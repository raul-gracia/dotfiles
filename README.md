# My Computer Setup and Dotfiles Configuration

## Installation

```bash
curl -s https://raw.githubusercontent.com/raul-gracia/dotfiles/master/bootstrap.sh | bash
```

## Migration to GNU Stow

This repository now uses [GNU Stow](https://www.gnu.org/software/stow/) for managing dotfiles. If you have an existing setup using rcm, run:

```bash
cd ~/dotfiles
fish migrate-to-stow.fish
```

For new installations, after running bootstrap.sh:

```bash
cd ~/dotfiles
fish setup-stow.fish
```

## Description

This script will:
* Install/Update [Homebrew](https://brew.sh)
* Install/Update [Fish Shell](https://fishshell.com)
* Install [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish)
* Install [GNU Stow](https://www.gnu.org/software/stow/) for dotfile management
* Clone and symlink all my dotfiles organized as stow packages
* Install the most common OSX tools and UI Apps that I use
* Configure everything correctly (vim, tmux, Monaco font, ...)

## Package Organization

Dotfiles are organized into logical packages using GNU Stow:

- **git/** - Git configuration (.gitconfig, .gitignore, .gitmessage)
- **shell/** - Fish shell and Starship prompt configurations  
- **editor/** - Vim and Neovim configurations
- **terminal/** - Terminal emulator configs (tmux, wezterm)
- **languages/** - Language-specific configurations and default packages
- **tools/** - Development tools (ctags, ssh config, etc.)

### Managing Packages

```bash
# Install all packages
cd ~/dotfiles && stow */

# Install specific package
stow git

# Remove package
stow -D terminal

# Reinstall/update package
stow -R shell
```

For the complete list of tools check the Brewfiles:
- General/Work Only apps: [Brewfile.standard](Brewfile.standard)
- Personal apps: [Brewfile.personal](Brewfile.personal)
