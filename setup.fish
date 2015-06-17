omf install
fish_update_completions
echo 'Brewing...'
brew tap Homebrew/bundle
brew bundle
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
rbenv install 2.2.2
rbenv global 2.2.2

echo 'Bundling...'
gem install bundle; and bundle install; and rm Gemfile.lock
echo 'Installing pip tools...'
set formulae  'pip' 'httpie' 'psutil' \
              'git+git://github.com/powerline/powerline' 'awscli' \

for pip_tool in $pip_tools
  pip install --upgrade $pip_tool
end

ruby install.rb
