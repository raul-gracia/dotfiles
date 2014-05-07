desc 'Installs the dotfiles'
task :install => :install_dotfiles do
 print_success 'Everything installed corectly!'
end

task :install_brew_modules do
  print_info 'Brewing...'
  `brew bundle > /dev/null 2>&1`
end

task :install_global_gems do
  print_info 'Bundling...'
  `bundle install && rm Gemfile.lock` # install global gems
end

task :install_tools => [:install_brew_modules, :install_global_gems] do
  print_info 'Installing tools...'
  `pip install --upgrade httpie`
  `pip install git+git://github.com/Lokaltog/powerline`
end

task :install_dotfiles => :install_tools do
  print_info 'Installing dotfiles...'
  excluded_files = %w{README.md Brewfile Gemfile Rakefile VimLauncher.app}
  print_info "Executing: rcup -fd . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}"
  `rcup -d . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}`
  Rake::Task["configure_tmux_powerline"].invoke
  Rake::Task["configure_vim_vundle"].invoke
end

task :configure_tmux_powerline do
  print_info 'Configuring powerline...'
  # Configure tmux-powerline
  unless File.exist? File.expand_path('~/powerline')
    `git clone git@github.com:Lokaltog/powerline.git ~/powerline`
  end

  unless File.exist? File.expand_path('~/Library/Fonts/Monaco_for_Powerline.otf')
    puts 'Downloading Patched Monaco font...'
    `http https://gist.githubusercontent.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco+for+Powerline.otf > ~/Library/Fonts/Monaco_for_Powerline.otf`
  end
end

task :configure_vim_vundle do
  print_info 'Configuring Vundle.vim...'
  unless File.exist? File.expand_path('~/.vim/bundle/vundle')
    `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
  end
  `vim +BundleInstall +qall`
end


def print_success(message)
 puts `echo '\033[0;32;40m#{message}\033[0m'`
end

def print_info(message)
 puts `echo '\033[0;33;40m#{message}\033[0m'`
end
