fish_update_completions
echo 'Brewing...'
brew tap Homebrew/bundle
brew bundle --file Brewfile.standard

echo 'Installing Ruby...'
rbenv install 2.7.2
rbenv global 2.7.2

echo 'Bundling...'
gem install bundler
and bundle install
and rm Gemfile.lock

echo 'Installing pip tools...'
set pip_tools 'pip' 'httpie' 'psutil' 'git+git://github.com/powerline/powerline' 'awscli' 'ansible'

for pip_tool in $pip_tools
    pip3 install --upgrade $pip_tool
end

echo 'Getting the encrypted exports'
echo 'Please log into github first to download Gist'
gist --login
gist -r 4c6216ef0cd3a8c80d8e74decc36a6b3 >/tmp/exports.gpg
gpg -d /tmp/exports.gpg >~/dotfiles/config/fish/exports.fish

echo 'Installing dotfiles...'
set excluded_files 'bootstrap.sh' 'Brewfile' 'Gemfile' 'install.rb' 'README.md' 'setup.fish' 'others'
echo 'Executing: rcup -fd . '(echo '-x '{$excluded_files})
rcup -fd . '-x '{excluded_files_args}

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
