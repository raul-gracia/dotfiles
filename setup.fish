fish_update_completions
echo 'Brewing...'
brew tap Homebrew/bundle
brew bundle --file Brewfile.standard --no-lock

echo 'Installing dotfiles...'
set excluded_files 'bootstrap.sh' 'Brewfile.personal' 'Brewfile.standard' 'install.rb' 'README.md' 'setup.fish' 'others'
echo 'Executing: rcup -fd . '(echo '-x '{$excluded_files})
rcup -fd . '-x '{excluded_files_args}

echo 'Installing Ruby...'
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby latest
asdf global ruby (asdf list ruby | head | string trim)

echo 'Installing Python...'
asdf plugin-add python
asdf install python latest
asdf global python (asdf list python | head | string trim)

echo 'Installing Erlang...'
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang latest
asdf global erlang (asdf list erlang | head | string trim)

echo 'Installing Elixir...'
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install elixir latest
asdf global elixir (asdf list elixir | head | string trim)

echo 'Installing Rust...'
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust latest
asdf global rust (asdf list rust | head | string trim)

echo 'Getting the encrypted exports'
echo 'Please log into github first to download Gist'
gist --login
gist -r 4c6216ef0cd3a8c80d8e74decc36a6b3 >/tmp/exports.gpg
gpg -d /tmp/exports.gpg >~/dotfiles/config/fish/exports.fish

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugUpgrade +qall
vim +PlugInstall +qall
vim +PlugUpdate +qall

echo 'Installing tmux plugins...'
if not test -d '/Users/'(whoami)'/.tmux/plugins/tpm'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/./install_plugins
end

echo 'Everything installed corectly!'
