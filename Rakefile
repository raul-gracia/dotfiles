desc 'Installs the dotfiles'
task :install do
  require 'pry'
  excluded_files = %w{README.md Brewfile Gemfile Rakefile}
  `brew bundle`
  `bundle install`
  `rm Gemfile.lock`
  `rcup -d . #{excluded_files.map{|f| "-x #{f}"}.join(' ')}`
end
