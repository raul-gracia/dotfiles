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
alias rapps='cd ~/Documents/rails-apps'
alias dev='cd ~/Documents/development'
alias mag='cd ~/Documents/development/magnetic'
alias dotfiles='cd ~/dotfiles; and vim .; and cd -'
alias godev='cd $GOPATH/src/github.com/maliciousmind'
alias serve_dir='ruby -run -e httpd . -p 5000'
alias tat='tmux attach -t'
alias tls='tmux ls'

alias docs='cd ~/Documents'
alias upgradeall='brew update; and brew upgrade; and omf update; and omf self-update'

# Rails
alias rdb='rake db:migrate'
alias rdbt='rake db:migrate db:test:prepare'
alias be='bundle exec'
alias beg='bundle exec guard -c'
alias rs='bundle exec rails server --binding 127.0.0.1'
#alias rc='bundle exec rails console'

alias dc='docker-compose'
function codeclimate
  docker run \
    --interactive --tty --rm \
    --env CODE_PATH="$PWD" \
    --volume "$PWD":/code \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /tmp/cc:/tmp/cc \
    codeclimate/codeclimate $argv
end

# Git
alias g='git'
alias gb='g branch'
alias gpt='bundle exec rake test; and bundle exec rake jshint; and gp'
alias gc='g c'
alias gca='gc --amend'
alias gco='g co'
alias gst='g st -s'
alias gaa='g add --all'
alias ga='g add'
alias gup='g up'
alias glg='g lg'
alias gdfc='g diff --cached --color-words --patience'
alias gdf='g diff --color-words --patience'
alias current_branch='git rev-parse --abbrev-ref HEAD'
alias magnetic_repo_name="git remote show origin -n | grep 'Fetch' | ruby -e 'puts \$stdin.read.match(/Magnetic\/(.*)\.git/)[1]'"
alias clean_local_branches='git branch --merged develop | grep -v master | grep -v develop | xargs git branch -d'

alias last_commit='git rev-parse HEAD'
function gph
  git push $argv (current_branch):master
end

function branch_creation_commit
  git merge-base master (current_branch)
end

# heroku
alias hpr='hub pull-request -b'
alias hlog='heroku logs -t -a'
alias hlg='heroku logs -t'
alias hconf='heroku config -a'
alias hp='g push heroku (current_branch):master'


alias mysql='mysql -uroot'
alias bb='cd ~/dotfiles; and brew bundle; and cd -'


# Code review tool
alias gp='g push origin (current_branch)'
alias gpf='gp --force'
alias current_branch='git rev-parse --abbrev-ref HEAD'
alias last_commit_message_long='git --no-pager log -1 --pretty=%B'
alias last_commit_message_short='git --no-pager log -1 --pretty=%s'
alias previous_commit_hash='git rev-parse HEAD~1'

function code_review_message
  last_commit_message_long | pipeset commit_description
  echo "Repo: "(magnetic_repo_name)"
Branch: "(current_branch)"

"$commit_description
end

function review
  if test (count $argv) -eq 1
    set revision_hash $argv[1]
  else
    set revision_hash (branch_creation_commit)
  end
  gp
  code_review_message | pipeset message_arg
  codereview --rev $revision_hash\
    --title=(last_commit_message_short) \
    --message=$message_arg \
    --reviewers=CJ,stephen,rob,dcrosta --send_mail
end

function ammend_review
  if test (count $argv) -eq 2
    set revision_hash $argv[2]
  else
    set revision_hash (branch_creation_commit)
  end
  if test (count $argv) -ge 1
    gp
    code_review_message | pipeset message_arg
    codereview --rev $revision_hash \
      --issue=$argv[1] \
      --title=(last_commit_message_short) \
      --message=$message_arg \
      --reviewers=CJ,stephen,rob,dcrosta --send_mail
  else
    echo "Usage: $_ 4590002 optional_hash"
  end
end



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
