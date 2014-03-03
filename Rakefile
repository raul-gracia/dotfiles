desc 'Installs the dotfiles'
task :install => :install_dotfiles do
 puts `echo '\033[0;32;40mEverything installed corectly!\033[0m'`
end

task :install_brew_modules do
  `brew bundle > /dev/null 2>&1`
end

task :install_global_gems do
  `bundle install && rm Gemfile.lock` # install global gems
end

task :install_tools => [:install_brew_modules, :install_global_gems] do
  `pip install --upgrade httpie`
end

task :install_dotfiles => :install_tools do
  excluded_files = %w{README.md Brewfile Gemfile Rakefile}
  `rcup -d . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}`
  Rake::Task["configure_tmux_powerline"].invoke
end

task :configure_tmux_powerline do
  # Configure tmux-powerline
  unless File.exist? File.expand_path('~/tmux-powerline')
    puts 'Cloning tmux powerline repo...'
    `git clone https://github.com/erikw/tmux-powerline.git ~/tmux-powerline`
  end

  unless File.exist? File.expand_path('~/Library/Fonts/Monaco_for_Powerline.otf')
    puts 'Downloading Monaco font...'
    `http https://gist.githubusercontent.com/maliciousmind/2025875805a07d5defc6/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco+for+Powerline.otf > ~/Library/Fonts/Monaco_for_Powerline.otf`
  end
end
