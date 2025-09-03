#!/usr/bin/env fish

# Migration script from rcm to GNU Stow
# This script reorganizes dotfiles into a stow-compatible structure

set -g DOTFILES_DIR (pwd)
set -g BACKUP_DIR "$DOTFILES_DIR/backup-before-stow"

function log_info
    echo -e "\033[0;32m$argv\033[0m"
end

function log_warning
    echo -e "\033[0;33m$argv\033[0m"
end

function log_error
    echo -e "\033[0;31m$argv\033[0m"
end

function backup_current_setup
    log_info "Creating backup of current setup..."
    mkdir -p $BACKUP_DIR
    
    # List all current symlinks for reference
    log_info "Documenting current symlinks..."
    echo "# Current RCM symlinks" > $BACKUP_DIR/current-symlinks.txt
    echo "# Generated on "(date) >> $BACKUP_DIR/current-symlinks.txt
    find ~ -maxdepth 1 -type l -exec ls -la {} \; 2>/dev/null | grep dotfiles >> $BACKUP_DIR/current-symlinks.txt
    
    log_info "Backup created in $BACKUP_DIR"
end

function remove_rcm_symlinks
    log_info "Removing RCM symlinks..."
    
    # Check if rcdown is available
    if command -v rcdown > /dev/null
        log_info "Running rcdown to remove existing symlinks..."
        rcdown
    else
        log_warning "rcdown not found, manually removing symlinks..."
        # Manually remove symlinks pointing to dotfiles
        for link in (find ~ -maxdepth 1 -type l 2>/dev/null)
            if readlink $link | grep -q dotfiles
                log_info "Removing $link"
                rm $link
            end
        end
        
        # Remove config symlinks
        for link in (find ~/.config -type l 2>/dev/null)
            if readlink $link | grep -q dotfiles
                log_info "Removing $link"
                rm $link
            end
        end
        
        # Remove ssh config symlink
        if test -L ~/.ssh/config
            if readlink ~/.ssh/config | grep -q dotfiles
                log_info "Removing ~/.ssh/config"
                rm ~/.ssh/config
            end
        end
    end
end

function create_stow_structure
    log_info "Creating stow package structure..."
    
    # Create package directories
    mkdir -p git shell editor terminal languages tools
    
    # Git package
    log_info "Setting up git package..."
    mkdir -p git
    test -f gitconfig && mv gitconfig git/.gitconfig
    test -f gitignore && mv gitignore git/.gitignore
    test -f gitmessage && mv gitmessage git/.gitmessage
    
    # Shell package
    log_info "Setting up shell package..."
    mkdir -p shell/.config
    test -d config/fish && mv config/fish shell/.config/
    test -f config/starship.toml && mv config/starship.toml shell/.config/
    
    # Editor package
    log_info "Setting up editor package..."
    mkdir -p editor/.config
    test -f vimrc && mv vimrc editor/.vimrc
    test -f vimrc.bundles && mv vimrc.bundles editor/.vimrc.bundles
    test -f vimrc.good && mv vimrc.good editor/.vimrc.good
    test -f vimrc.leaders && mv vimrc.leaders editor/.vimrc.leaders
    test -f vimrc.plugs && mv vimrc.plugs editor/.vimrc.plugs
    test -d vim && mv vim editor/.vim
    test -f config/init.vim && begin
        mkdir -p editor/.config/nvim
        mv config/init.vim editor/.config/nvim/
    end
    
    # Terminal package
    log_info "Setting up terminal package..."
    mkdir -p terminal
    test -f tmux.conf && mv tmux.conf terminal/.tmux.conf
    test -d tmuxgen && mv tmuxgen terminal/.tmuxgen
    test -f wezterm.lua && mv wezterm.lua terminal/.wezterm.lua
    
    # Languages package
    log_info "Setting up languages package..."
    mkdir -p languages
    test -f asdfrc && mv asdfrc languages/.asdfrc
    test -f default-gems && mv default-gems languages/.default-gems
    test -f default-npm-packages && mv default-npm-packages languages/.default-npm-packages
    test -f default-python-packages && mv default-python-packages languages/.default-python-packages
    test -f gemrc && mv gemrc languages/.gemrc
    test -f iex.exs && mv iex.exs languages/.iex.exs
    test -f ~/.tool-versions && begin
        mv ~/.tool-versions languages/.tool-versions
        log_info "Moved .tool-versions to languages package"
    end
    
    # Tools package
    log_info "Setting up tools package..."
    mkdir -p tools/.ssh
    mkdir -p tools/.config
    test -f agignore && mv agignore tools/.agignore
    test -f ansible.cfg && mv ansible.cfg tools/.ansible.cfg
    test -f ctags && mv ctags tools/.ctags
    test -f ssh/config && mv ssh/config tools/.ssh/config
    
    # Add config directories for gh, btop, and zellij
    test -d ~/.config/gh && begin
        mv ~/.config/gh tools/.config/
        log_info "Moved gh config to tools package"
    end
    test -d ~/.config/btop && begin
        mv ~/.config/btop tools/.config/
        log_info "Moved btop config to tools package"
    end
    test -d ~/.config/zellij && begin
        mv ~/.config/zellij tools/.config/
        log_info "Moved zellij config to tools package"
    end
    
    # Clean up empty directories
    test -d config && rmdir config 2>/dev/null
    test -d ssh && rmdir ssh 2>/dev/null
    
    log_info "Stow structure created successfully!"
end

function create_stowrc
    log_info "Creating .stowrc configuration..."
    
    echo "# GNU Stow configuration" > .stowrc
    echo "--target=$HOME" >> .stowrc
    echo "--verbose" >> .stowrc
    echo "--ignore=\.DS_Store" >> .stowrc
    echo "--ignore=README.*" >> .stowrc
    echo "--ignore=LICENSE.*" >> .stowrc
    echo "--ignore=\.git" >> .stowrc
    echo "--ignore=\.gitignore" >> .stowrc
    
    log_info ".stowrc created"
end

function stow_packages
    log_info "Stowing packages..."
    
    # Stow each package
    for package in git shell editor terminal languages tools
        if test -d $package
            log_info "Stowing $package..."
            stow -v $package
        else
            log_warning "Package $package not found, skipping..."
        end
    end
    
    log_info "All packages stowed!"
end

function main
    log_info "Starting migration from RCM to GNU Stow..."
    log_info "Working directory: $DOTFILES_DIR"
    
    # Confirm with user
    echo ""
    log_warning "This will reorganize your dotfiles structure!"
    log_warning "A backup will be created, but please ensure you have committed any changes."
    echo -n "Continue? [y/N] "
    read -l response
    
    if test "$response" != "y"
        log_info "Migration cancelled"
        exit 0
    end
    
    # Run migration steps
    backup_current_setup
    remove_rcm_symlinks
    create_stow_structure
    create_stowrc
    stow_packages
    
    log_info ""
    log_info "Migration complete! 🎉"
    log_info ""
    log_info "Your dotfiles are now managed by GNU Stow."
    log_info "Backup saved in: $BACKUP_DIR"
    log_info ""
    log_info "Common stow commands:"
    log_info "  stow <package>    - Install a package"
    log_info "  stow -D <package> - Uninstall a package"
    log_info "  stow -R <package> - Reinstall a package"
    log_info "  stow */           - Install all packages"
    log_info ""
end

# Run the main function
main $argv