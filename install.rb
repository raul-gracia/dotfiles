#!/usr/bin/ruby

puts 'Installing dotfiles...'
excluded_files = %w{README.md Brewfile Gemfile install.rb VimLauncher.app
alfred-workflows setup.fish Solarized-Dark.itermcolors Solarized-Light.itermcolors
bootstrap.sh}
puts "Executing: rcup -fd . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}"
`rcup -fd . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}`

unless File.exist? File.expand_path('~/Library/Fonts/Monaco_for_Powerline.otf')
  puts 'Downloading Patched Monaco font...'
  `http https://gist.githubusercontent.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco+for+Powerline.otf > ~/Library/Fonts/Monaco_for_Powerline.otf`
end

puts 'Configuring Vundle.vim...'
unless File.exist? File.expand_path('~/.vim/bundle/vundle')
  `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
end
`vim +BundleInstall +qall`

puts 'Everything installed corectly!'
