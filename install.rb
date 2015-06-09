#!/usr/bin/ruby

echo 'Bundling...'
`gem install bundle && bundle install && rm Gemfile.lock` # install global gems

echo 'Installing tools...'
`pip install --upgrade httpie`
`pip install git+git://github.com/Lokaltog/powerline`

echo 'Installing dotfiles...'
excluded_files = %w{README.md Brewfile Gemfile install.rb VimLauncher.app
alfred-workflows setup.fish Solarized-Dark.itermcolors Solarized-Light.itermcolors}
echo "Executing: rcup -fd . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}"
`rcup -d . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}`

echo 'Configuring powerline...'
# Configure tmux-powerline
unless File.exist? File.expand_path('~/powerline')
  `git clone git@github.com:Lokaltog/powerline.git ~/powerline`
end

unless File.exist? File.expand_path('~/Library/Fonts/Monaco_for_Powerline.otf')
  puts 'Downloading Patched Monaco font...'
  `http https://gist.githubusercontent.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco+for+Powerline.otf > ~/Library/Fonts/Monaco_for_Powerline.otf`
end

task :configure_vim_vundle do
  echo 'Configuring Vundle.vim...'
  unless File.exist? File.expand_path('~/.vim/bundle/vundle')
    `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
  end
  `vim +BundleInstall +qall`
end

echo 'Everything installed corectly!'
