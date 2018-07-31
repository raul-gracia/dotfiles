alias vim='nvim'

# Fish
alias fr='source ~/.config/fish/config.fish > /dev/null 2>&1'
alias fe='vim ~/.config/fish/config.fish'
alias fexports='vim ~/.config/fish/exports.fish'
alias faliases='vim ~/.config/fish/aliases.fish'

# Typos
alias cl='clear'
alias clar='clear'
alias dofiles='dotfiles'

# Shortcuts
alias drop='cd ~/Dropbox'
alias dev='cd ~/Dropbox/development'
alias sq='cd ~/Dropbox/Development/storiq/storiq'
alias dotfiles='cd ~/dotfiles; and vim .; and cd -'
alias serve_dir='ruby -run -e httpd . -p 5055'
alias tat='tmux attach -t'
alias tls='tmux ls'
alias chr='cd ~/Dropbox/development/digital-chronos'
alias dc='docker-compose'
alias dce='dc exec'
alias dcew='dce web'
alias kt='dc run -e MIX_ENV=test web mix test'
alias add-ssh-keys='ssh-add -K ~/.ssh/github; and ssh-add -K ~/.ssh/raulgracialario'

function time_in_london
  cd ~/Dropbox/time_in_london/; bundle check > /dev/null 2>&1; or bundle install > /dev/null 2>&1; bundle exec ruby time_in_london.rb $argv; cd -
end
alias time_in_salsa='cd ~/Dropbox/time_in_london/; bundle check > /dev/null 2>&1; or bundle install > /dev/null 2>&1; bundle exec ruby time_in_salsa.rb; cd -'
function time_until
  cd ~/Dropbox/time_in_london/; bundle check > /dev/null 2>&1; or bundle install > /dev/null 2>&1; bundle exec ruby time_until.rb $argv; cd -
end

function time_till_end
  time_until '(date +"%Y-%m-%d") 18:00:00' --sort
end
alias tte='time_till_end'

function time_since
  cd ~/Dropbox/time_in_london/; bundle check > /dev/null 2>&1; or bundle install > /dev/null 2>&1; bundle exec ruby time_since.rb $argv; and cd -
end

alias docs='cd ~/Documents'
alias upgradeall="brew update; and brew upgrade; and omf update; and nvim --headless +':PlugUpdate' +':PlugUpgrade' +':qall'"

# Rails
alias be='bundle exec'
alias rdb='bundle exec rake db:migrate'
alias rdbt='bundle exec rake db:migrate db:test:prepare'
alias beg='bundle exec guard -c'
alias rs='./bin/rails s --binding 127.0.0.1; or be rails s --binding 127.0.0.1'
alias berc='bundle exec rails console'
alias bec='bundle exec cucumber'
alias berr='bundle exec rake routes'
alias berrg='bundle exec rake routes | grep '
alias berg='bundle exec rails g'
alias bergg='bundle exec rails g | grep'
alias latest_ruby2="brew upgrade; ruby-build --definitions | grep '^2.\d.\d\$' | tail -n 1"

# Phoenix
alias mps='mix phoenix.server'
alias mpr='mix phoenix.routes'
alias mdp='mix deps.get'
alias mpc='iex -S mix'

# Docker
alias dc='docker-compose'
alias dce='dc exec'
alias dcew='dce web'

# Git
alias g='git'
alias gb='g branch'
alias gbd='g branch -d'
alias gc='g c -S'
alias gca='gc --amend'
alias gcn='gc --no-verify'
alias gco='g co'
alias gcob='gco -b'
alias gcom='gco master'
alias gst='g st -s'
alias gaa='g add --all'
alias gap='g add -p'
alias ga='g add'
alias gup='g up'
alias glg='g lg'
alias gdfc='g diff --cached --color-words'
alias gdf='g diff --color-words'
alias gdfcp='gdfc --patience'
alias gdfp='gdf --patience'
alias gp='g push -u origin (current_branch)'
alias gpf='gp --force-with-lease'
alias gpt='gp --tags'
alias gtags='g ctags'
alias gsl='g stash list'
alias gsts='g stash save -u'
alias gstl='g stash list'
alias gstp='g stash pop'
alias current_branch='g rev-parse --abbrev-ref HEAD'
alias hbb='hub browse (git_remote_owner)/(git_remote_repo_name)'

function hb
  hub browse (git_remote_owner)/(git_remote_repo_name)
end

function clean_merged_branches
  if string length -q $argv[1]
    set branch $argv[1]
  else
    set branch develop
  end
  g branch --merged $branch | grep -v master | grep -v develop | xargs git branch -d
end

function create_remote_branch
  gcob $argv
  gp
end

function gcp
  gc $argv
  gp
end

alias crb='create_remote_branch'
alias hpr='gp; and hub pull-request -b'
alias bbpr='gp; and bitbucket pull_request (current_branch) -r (git_remote_repo_name) -w (git_remote_owner)'
alias current_branch='g rev-parse --abbrev-ref HEAD'
alias last_commit_message_long='g --no-pager log -1 --pretty=%B'
alias last_commit_message_short='g --no-pager log -1 --pretty=%s'
alias previous_commit_hash='g rev-parse HEAD~1'

alias last_commit='g rev-parse HEAD'
function gph
  g push $argv (current_branch):master
end

function branch_creation_commit
  g merge-base master (current_branch)
end

function git_remote
  g remote show origin -n | grep 'Push  URL' | sed -n 's/  Push  URL: \(.*\)/\1/p'
end

function git_remote_owner
  git_remote | sed -n 's/git@.*\..*:\(.*\)\/.*\.git/\1/p'
end

function git_remote_repo_name
  git_remote | sed -n 's/git@.*\..*:.*\/\(.*\)\.git/\1/p'
end

function circleci
  if test (count $argv) = 0
    open "https://circleci.com/gh/"(git_remote_owner)"/"(git_remote_repo_name)"/tree/"(current_branch)
  else
    open "https://circleci.com/gh/"(git_remote_owner)"/"(git_remote_repo_name)"/tree/$argv"
  end
end

function pulls
  open "https://github.com/"(git_remote_owner)"/"(git_remote_repo_name)"/pulls"
end
alias prs='pulls'

function issues
  open "https://github.com/"(git_remote_owner)"/"(git_remote_repo_name)"/issues"
end

function issue
  set issue_number (current_branch | grep -Eo "[0-9]+" | head -n 1)
  if test $issue_number
    open "https://github.com/"(git_remote_owner)"/"(git_remote_repo_name)"/issues/"$issue_number
  end
end

function jissue
  set issue_number (current_branch | grep -Eo "MD-[0-9]+" | head -n 1)
  if test $issue_number
    open "https://motivii.atlassian.net/browse/"$issue_number
  end
end

function releasing_tickets
  glg master..develop | grep -o 'MD-\d\+' | sort | uniq | sed -E 's/(.*)/https:\/\/motivii\.atlassian\.net\/browse\/\1/'
end

# heroku
alias hk='/usr/local/bin/heroku'
alias hlog='hk logs -t -a'
alias hlg='hk logs -t'
alias hconf='hk config -a'
alias hp='g push heroku (current_branch):master'

function railsgirls
  eval $argv --app desolate-coast-9056
end

function rcruit
  eval $argv --app rcruit
end

function rcruit-stag
  eval $argv --app rcruit-staging
end

alias bb='cd ~/dotfiles; brew update; and brew upgrade; and brew bundle; cd -'
alias redis='redis-server --daemonize yes; and redis-cli flushall'


function dark_theme
  echo -e "\033]50;SetProfile=Dark\a"
  vim -c '%s/\(set background=\)\w*/\1dark/g' +wq ~/.vimrc
end

function light_theme
  echo -e "\033]50;SetProfile=Light\a"
  vim -c '%s/\(set background=\)\w*/\1light' +wq ~/.vimrc
end

alias localip="ifconfig | grep 'inet ' | grep -Fv 127.0.0.1 | awk '{print \$2}'"



# Motivii
alias mot='cd ~/Dropbox/development/motivii'
alias mas='cd ~/Dropbox/development/motivii/Maslow'
function mot-stag
  eval $argv --app motivii-maslow-staging
end

function mot-prod
  eval $argv --app motivii-maslow-production
end

function mot-prod-console
  mot-prod hk run rails c
end
alias mpc="mot-prod-console"
alias mpl='mot-prod hk logs -t'

function mot-stag-console
  mot-stag hk run rails c
end
alias msc="mot-stag-console"
alias msl='mot-stag hk logs -t'

function mot-prod-deploy
  mot-prod hk pg:backups capture
  g push production master
  mot-prod hk run rails db:migrate
end

function mot-prod-deploy-light
  g push production master $argv
end

function mot-prod-ssh-analysis
  ssh ubuntu@ec2-52-30-80-71.eu-west-1.compute.amazonaws.com
end

function mot-stag-ssh-analysis
  ssh ubuntu@ec2-34-240-244-168.eu-west-1.compute.amazonaws.com
end

function mot-wordpress-ssh
  ssh bitnami@ec2-52-48-225-67.eu-west-1.compute.amazonaws.com
end

function mot-stag-deploy
  g push staging (current_branch):master -f
  mot-stag hk run rails db:migrate
end

function mot-stag-deploy-light
  g push staging (current_branch):master -f
end

#### Motivii


###### TRELLO #############
function trello-title
  ruby -rtrello -e "Trello.configure do |config|;config.developer_public_key = ENV['TRELLO_KEY'];config.member_token = ENV['TRELLO_TOKEN'];end;t=Trello::Card.find(ARGV[0]);puts t.name.gsub(' ', '-').downcase;" $argv
end

function trello-id
  ruby -rtrello -e "Trello.configure do |config|;config.developer_public_key = ENV['TRELLO_KEY'];config.member_token = ENV['TRELLO_TOKEN'];end;t=Trello::Card.find(ARGV[0]);puts t.short_id;" $argv
end

function trello-move-to-list
  set id $argv[1]
  set list $argv[2]
  ruby -rtrello -e "Trello.configure do |config|;config.developer_public_key = ENV['TRELLO_KEY'];config.member_token = ENV['TRELLO_TOKEN'];end;c=Trello::Card.find(ARGV[0]);list_id=c.board.lists.find{|l| l.name == ARGV[1]}.id;begin;c.move_to_list(list_id);rescue;end;" $id $list
end

function trello-add-member
  set id $argv[1]
  set username $argv[2]
  ruby -rtrello -e "Trello.configure do |config|;config.developer_public_key = ENV['TRELLO_KEY'];config.member_token = ENV['TRELLO_TOKEN'];end;c=Trello::Card.find(ARGV[0]);begin;m=c.board.members.find{|m| m.username == ARGV[1]};c.add_member(m);rescue;end;" $id $username
end

function branch-from-trello
  set title (trello-title $argv)
  set id (trello-id $argv)
  gco master
  gup
  gcob feature/$id/$title
  trello-move-to-list $argv 'In Progress'
  trello-add-member $argv 'raulgracialario'
  cl
end
###### TRELLO #############



alias time_vera="time_since '7/11/2017 23:30:00'"

function mot-cuc
  yarn run webpack:deploy
  bundle exec cucumber
end

alias mot-stag-last-commit="mot-stag hk releases | grep Deploy | head -n 1 | awk '{print \$3}'"
alias mot-prod-last-commit="mot-prod hk releases | grep Deploy | head -n 1 | awk '{print \$3}'"

alias mot-stag-releasing="hub compare (mot-stag-last-commit)..develop"
alias mot-prod-releasing="hub compare (mot-prod-last-commit)..master"



alias update_alchemist="cd /Users/maliciousmind/Dropbox/Training/Alchemist.Camp; and youtube-dl 'https://www.youtube.com/channel/UCp5Nix6mJCoLkH_GqcRRp1A/videos'; cd -"
