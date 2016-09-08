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
alias rapps='cd ~/Dropbox/rails-apps'
alias dev='cd ~/Dropbox/development'
alias mot='cd ~/Dropbox/development/motivii'
alias mas='cd ~/Dropbox/development/motivii/Maslow'
alias fx='cd ~/Dropbox/development/gaincapital/foreign-exchange'
alias dotfiles='cd ~/dotfiles; and vim .; and cd -'
alias godev='cd $GOPATH/src/github.com/maliciousmind'
alias serve_dir='ruby -run -e httpd . -p 5055'
alias tat='tmux attach -t'
alias tls='tmux ls'
alias chr='cd ~/Dropbox/development/digital-chronos'

alias time_in_london='cd ~/Dropbox/time_in_london/; and bundle exec ruby time_in_london.rb; and cd -'
alias time_until='cd ~/Dropbox/time_in_london/; and bundle exec ruby time_until.rb $argv; and cd -'

alias docs='cd ~/Documents'
alias upgradeall='brew update; and brew upgrade; and omf update; and omf self-update'

# Rails
alias rdb='bundle exec rake db:migrate'
alias rdbt='bundle exec rake db:migrate db:test:prepare'
alias be='bundle exec'
alias beg='bundle exec guard -c'
alias rs='bundle exec rails server --binding 127.0.0.1'
alias berc='bundle exec rails console'
alias bec='bundle exec cucumber'

# Phoenix
alias mps='mix phoenix.server'

# Git
alias g='git'
alias gb='g branch'
alias gpt='bundle exec rake test; and bundle exec rake jshint; and gp'
alias gc='g c -S'
alias gca='gc --amend'
alias gco='g co'
alias gcob='gco -b'
alias gst='g st -s'
alias gaa='g add --all'
alias ga='g add'
alias gup='g up'
alias glg='g lg'
alias gdfc='g diff --cached --color-words --patience'
alias gdf='g diff --color-words --patience'
alias gp='g push origin (current_branch)'
alias gpf='gp --force'
alias current_branch='git rev-parse --abbrev-ref HEAD'
alias clean_local_branches='git branch --merged develop | grep -v master | grep -v develop | xargs git branch -d'
alias hpr='gp; and hub pull-request -b'
alias bbpr='gp; and bitbucket pull_request (current_branch)'
alias current_branch='git rev-parse --abbrev-ref HEAD'
alias last_commit_message_long='git --no-pager log -1 --pretty=%B'
alias last_commit_message_short='git --no-pager log -1 --pretty=%s'
alias previous_commit_hash='git rev-parse HEAD~1'

alias last_commit='git rev-parse HEAD'
function gph
  git push $argv (current_branch):master
end

function branch_creation_commit
  git merge-base master (current_branch)
end

# heroku
alias hk='/usr/local/bin/heroku'
alias hlog='hk logs -t -a'
alias hlg='hk logs -t'
alias hconf='hk config -a'
alias hp='g push heroku (current_branch):master'

function fx-prod
  eval $argv --app fx-production
end
function fx-prod-deploy
  gco master; and gup; fx-prod hk pg:backups capture; and g push production master; and fx-prod run rake db:migrate
end

function fx-test
  eval $argv --app fx-test
end
function fx-test-deploy
  gco develop; and gup; and g push test develop:master; and fx-test run rake db:migrate
end

function mot-stg
  eval $argv --app motivii-maslow-staging
end

function mot-prod
  eval $argv --app motivii-maslow-production
end

function staging_sidekiq
  staging hk config | grep SIDE
end

function prod_sidekiq
  production hk config | grep SIDE
end

function railsgirls
  eval $argv --app desolate-coast-9056
end

alias mysql='mysql -uroot'
alias bb='cd ~/dotfiles; brew update; and brew upgrade; and brew bundle; cd -'
alias rails-development-box='ssh ubuntu@54.194.162.16'
alias redis='redis-server --daemonize yes; and redis-cli flushall'
alias prc='production hk run rails c'

function pipeset --no-scope-shadowing
    set -l _options
    set -l _variables
    for _item in $argv
        switch $_item
            case '-*'
                set _options $_options $_item
            case '*'
                set _variables $_variables  $_item
        end
    end
    for _variable in $_variables
        set $_variable ""
    end
    while read _line
        for _variable in $_variables
            set $_options $_variable $$_variable$_line\n
        end
    end
    return 0
end
