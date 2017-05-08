fish_update_completions
echo 'Brewing...'
brew tap Homebrew/bundle
brew bundle
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
rbenv install 2.3.1
rbenv global 2.3.1

echo 'Bundling...'
gem install bundler; and bundle install; and rm Gemfile.lock
echo 'Installing pip tools...'
set pip_tools 'pip' 'httpie' 'psutil' \
              'git+git://github.com/powerline/powerline' 'awscli' \
              'ansible'

for pip_tool in $pip_tools
  pip install --upgrade $pip_tool
end

echo 'Installing dotfiles...'
set excluded_files 'bootstrap.sh' 'Brewfile' 'Gemfile' 'install.rb' \
                   'README.md' 'setup.fish' 'others'
echo 'Executing: rcup -fd . '(echo '-x '{$excluded_files})
rcup -fd . '-x '{excluded_files_args}

echo 'Configuring Vundle.vim...'
if not test -d '/Users/'(whoami)'/.vim/bundle/vundle'
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
end
vim +BundleInstall +qall
vim +BundleUpdate +qall

echo 'Installing tmux plugins...'
if not test -d '/Users/'(whoami)'/.tmux/plugins/tpm'
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
end

echo 'Everything installed corectly!'
