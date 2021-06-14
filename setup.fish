fish_update_completions
echo 'Brewing...'
brew tap Homebrew/bundle
brew bundle --file Brewfile.standard --no-lock

echo 'Installing dotfiles...'
set excluded_files 'bootstrap.sh' 'Brewfile.personal' 'Brewfile.standard' 'install.rb' 'README.md' 'setup.fish' others
echo 'Executing: rcup -fd . '(echo '-x '{$excluded_files})
rcup -fd . '-x '{excluded_files_args}

echo 'Installing Ruby...'
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf_install_latest_version_of 'ruby'

echo 'Installing Python...'
asdf plugin-add python
asdf_install_latest_version_of 'python'

echo 'Installing Erlang...'
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf_install_latest_version_of 'erlang'

echo 'Installing Elixir...'
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf_install_latest_version_of 'elixir'

echo 'Installing Rust...'
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf_install_latest_version_of 'rust'

echo 'Installing Golang...'
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf_install_latest_version_of 'golang'

echo 'Installing Nodejs...'
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf_install_latest_version_of 'nodejs'


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
