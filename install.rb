#!/usr/bin/ruby

puts 'Installing dotfiles...'
excluded_files = %w{README.md Brewfile Gemfile install.rb others
setup.fish bootstrap.sh}
excluded_files_args = excluded_files.map{|f| "-x #{f}"}.join(' ')
puts "Executing: rcup -fd . #{excluded_file_args}"
`rcup -fd . #{excluded_file_args}`

unless File.exist? File.expand_path('~/Library/Fonts/Monaco_for_Powerline.otf')
  puts 'Downloading Patched Monaco font...'
  `cp others/Monaco_for_Powerline.otf > ~/Library/Fonts/Monaco_for_Powerline.otf`
end

puts 'Configuring Vundle.vim...'
unless File.exist? File.expand_path('~/.vim/bundle/vundle')
  `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
end
`vim +BundleInstall +qall`

puts 'Installing tmux plugins...'
unless File.exist? File.expand_path('~/.tmux/plugins/tpm')
  `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
end
puts 'Everything installed corectly!'
