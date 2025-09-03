#!/usr/bin/env fish

# Setup script for dotfiles using GNU Stow
# This replaces the rcup-based setup with stow

fish_update_completions

echo 'Brewing...'
brew tap Homebrew/bundle
brew bundle --file Brewfile.standard --no-lock

echo 'Installing dotfiles with GNU Stow...'

# Check if we're in the new stow structure or need to migrate
if test -d git -a -d shell -a -d editor
    echo 'Stow structure detected, installing packages...'
    
    # Stow all packages
    for package in git shell editor terminal languages tools
        if test -d $package
            echo "Stowing $package..."
            stow -v $package
        end
    end
else
    echo 'Legacy structure detected. Please run ./migrate-to-stow.fish first!'
    exit 1
end

echo 'Installing Ruby...'
if not mise ls | grep -q ruby
    mise use --global ruby@latest
end

echo 'Installing Python...'
if not mise ls | grep -q python
    mise use --global python@latest
end

echo 'Installing Erlang...'
if not mise ls | grep -q erlang
    mise use --global erlang@latest
end

echo 'Installing Elixir...'
if not mise ls | grep -q elixir
    mise use --global elixir@latest
end

echo 'Installing Rust...'
if not mise ls | grep -q rust
    mise use --global rust@latest
end

echo 'Installing Golang...'
if not mise ls | grep -q go
    mise use --global go@latest
end

echo 'Installing Nodejs...'
if not mise ls | grep -q node
    mise use --global node@latest
end

echo 'Installing default npm packages...'
if test -f ~/.default-npm-packages
    cat ~/.default-npm-packages | while read -l package
        if test -n "$package"
            npm install -g $package
        end
    end
end

echo 'Getting the encrypted exports'
echo 'Please log into github first to download Gist'
gist --login
gist -r 4c6216ef0cd3a8c80d8e74decc36a6b3 >/tmp/exports.gpg
gpg -d /tmp/exports.gpg >~/dotfiles/shell/.config/fish/exports.fish

echo 'Installing Neovim plugins...'
nvim --headless +':Lazy update' +':Lazy sync' +':qall'

echo 'Installing zellij...'
if not command -v zellij > /dev/null
    cargo install --locked zellij
end

echo 'Installing oh-my-fish...'
if not test -d ~/.local/share/omf
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    omf theme install bira
end

echo 'Everything installed correctly!'
echo ''
echo 'Your dotfiles are now managed by GNU Stow!'
echo 'To manage packages:'
echo '  stow <package>    - Install a package'
echo '  stow -D <package> - Uninstall a package'
echo '  stow -R <package> - Reinstall a package'