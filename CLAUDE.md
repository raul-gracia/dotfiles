# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files and setup scripts for macOS development environments. The repository uses Fish shell as the primary shell, Neovim for editing, and manages language versions through mise (formerly rtx). Dotfiles are organized into packages and managed using GNU Stow.

## Key Setup Commands

### Initial Installation
```bash
# Bootstrap new machine
curl -s https://raw.githubusercontent.com/raul-gracia/dotfiles/master/bootstrap.sh | bash

# For new stow-based setup
fish setup-stow.fish

# Or migrate from rcm to stow
fish migrate-to-stow.fish
```

### Daily Operations
```bash
# Update all tools and dependencies
upgradeall

# Push dotfiles with encrypted exports
dotpush

# Pull dotfiles and decrypt exports  
dotpull

# Reload fish configuration
fr
```

## Architecture & Structure

### Package Organization (GNU Stow)
- **git/**: Git configuration files (.gitconfig, .gitignore, .gitmessage)
- **shell/**: Fish shell and starship configurations
- **editor/**: Vim and Neovim configurations
- **terminal/**: Terminal emulator configs (tmux, wezterm)
- **languages/**: Language-specific configs and default packages
- **tools/**: Development tools configuration (ctags, ssh, etc.)

### Core Components
- **bootstrap.sh**: Initial machine setup (Homebrew, Fish shell, dotfiles clone)
- **setup-stow.fish**: Main installation script using GNU Stow
- **migrate-to-stow.fish**: Migration script from rcm to stow
- **Brewfile.standard**: Essential development tools and applications
- **.stowrc**: GNU Stow configuration

### Key Dependencies
- **Shell**: Fish with Oh My Fish framework (bira theme)
- **Version Manager**: mise for Ruby, Python, Elixir, Rust, Go, Node.js
- **Editor**: Neovim with custom configuration
- **Git**: Configured with GPG signing, difftastic, custom aliases
- **Terminal**: iTerm2 with custom profile and themes

### Important Patterns
- Exports are encrypted via GPG and stored as a private Gist (ID: 4c6216ef0cd3a8c80d8e74decc36a6b3)
- Alfred workflows stored in `others/alfred-workflows/`
- All language installations go through mise (not asdf anymore)
- Fish functions defined inline in aliases.fish for complex operations

## Working with this Repository

### Package Management with Stow
```bash
# Install all packages
cd ~/dotfiles && stow */

# Install specific package
stow git

# Remove package  
stow -D terminal

# Reinstall/update package
stow -R shell

# Dry run (see what would happen)
stow -n -v git
```

### Adding New Dotfiles
1. Choose appropriate package (or create new one)
2. Place file in package directory with proper structure (mirrors home)
3. Run `stow <package>` to create symlinks
4. Test configuration
5. Commit changes

### Adding New Tools
1. Add Homebrew packages to `Brewfile.standard` (work) or `Brewfile.personal` (personal)
2. Add npm packages to `languages/.default-npm-packages`
3. Run `brew bundle --file Brewfile.standard --no-lock` to install

### Modifying Shell Configuration
- Edit `shell/.config/fish/aliases.fish` for aliases and functions
- Edit `shell/.config/fish/config.fish` for PATH and environment setup
- Private exports go in `shell/.config/fish/exports.fish` (encrypted)
- Run `stow -R shell` to update symlinks

### Git Workflow
- Feature branches: `gcob feature/name` creates and pushes branch
- Pull requests: `hpr [base-branch]` creates GitHub PR
- Clean branches: `clean_merged_branches` or `delete_squashed_branches`
- All commits are GPG signed automatically

### Testing Changes
After modifying dotfiles:
1. Run `stow -R <package>` to update symlinks for that package
2. Run `fr` to reload Fish configuration
3. Test functionality before running `dotpush`