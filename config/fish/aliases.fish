alias vim='nvim'

# Fish
alias fr='source ~/.config/fish/config.fish > /dev/null 2>&1'
alias fe='code --wait ~/.config/fish/config.fish'
alias fexports='code --wait ~/.config/fish/exports.fish'
alias faliases='code --wait ~/.config/fish/aliases.fish'

alias ls='exa'
alias cat='bat'

# Typos
alias cl='clear'
alias clar='clear'
alias dofiles='dotfiles'
alias gs='gst'

# Shortcuts
alias drop='cd ~/Dropbox'
alias dev='cd ~/Dropbox/development'
alias ws='cd ~/workspace'
alias docs='cd ~/Documents'
alias dotfiles='code ~/dotfiles'
alias chr='cd ~/Dropbox/development/digital-chronos'
alias interview="cd ~/Dropbox/development/interview-exercises"


alias serve_dir='ruby -run -e httpd . -p 5055'
alias tat='tmux attach -t'
alias tls='tmux ls'
alias tmuxgen_list='ll ~/.tmuxgen/'
alias dc='docker-compose'
alias dce='dc exec'
alias dcew='dce web'
alias kt='dc run -e MIX_ENV=test web mix test'
alias add-ssh-keys='ssh-add -K ~/.ssh/github; and ssh-add -K ~/.ssh/raulgracialario'

function time_in_london
    cd ~/Dropbox/time_in_london/
    ruby time_in_london.rb $argv
    cd -
end
function time_in_salsa
    cd ~/Dropbox/time_in_london/
    ruby time_in_salsa.rb $argv
    cd -
end
function time_until
    cd ~/Dropbox/time_in_london/
    ruby time_until.rb $argv
    cd -
end

function time_till_end
    time_until '(date +"%Y-%m-%d") 18:00:00' --sort
end
alias tte='time_till_end'

function time_since
    cd ~/Dropbox/time_in_london/
    ruby time_since.rb $argv
    and cd -
end

function upgradeall
    brew update
    brew upgrade
    omf update
    nvim --headless +':PlugUpdate' +':PlugUpgrade' +':qall'
    asdf plugin update --all
    asdf_install_latest_version_of ruby
    asdf_install_latest_version_of python
    asdf_install_latest_version_of rust
    asdf_install_latest_version_of golang
    asdf_install_latest_version_of erlang
    asdf_install_latest_version_of elixir
    asdf_install_latest_version_of nodejs
    pip3 install neovim --upgrade
    pip3 install --upgrade pip
end

# Rails
alias be='bundle exec'
alias ber='bundle exec rails'
alias rdb='bundle exec rake db:migrate'
alias rdbt='bundle exec rake db:migrate db:test:prepare'
alias beg='bundle exec guard -c'
alias rs='./bin/rails s --binding 127.0.0.1 $argv; or be rails s --binding 127.0.0.1 $argv'
alias berc='bundle exec rails console'
alias bec='bundle exec cucumber'
alias berr='bundle exec rake routes'
alias berrg='bundle exec rake routes | grep '
alias berrp='bundle exec rails runner "puts Rails.application.routes.recognize_path(\"$argv\")"'
alias berg='bundle exec rails g'
alias bergg='bundle exec rails g | grep'
alias bersp='bundle exec rspec'
alias rubo='bundle exec rubocop --display-style-guide --display-cop-names --extra-details'
alias rubo_fix='rubo --auto-correct'
alias rubo_fix_all='rubo --auto-correct-all'
alias rubo_todo='rubo --regenerate-todo'
function latest_ruby
    brew upgrade
    clear
    ruby-build --definitions | grep "^"$argv[1]".\d.\d\$" | tail -n 1
end
alias latest_ruby2="latest_ruby 2"
alias latest_ruby3="latest_ruby 3"

# Javascript
alias yarn='yarn --prefer-offline'

# Elixir/Phoenix
alias iex='iex --erl "-kernel shell_history enabled"'
alias mps='iex -S mix phx.server'
alias mpr='mix phx.routes'
alias mem='mix ecto.migrate'
alias mdp='mix deps.get'
alias ism='iex -S mix'
alias mt='mix test'
alias gg='gigalixir'

# Docker
alias dc='docker-compose'
alias dce='dc exec'
alias dcew='dce web'

# Kubernetes ( k8s )
alias kbl='kubectl'
alias kblg='kbl get'
alias kbld='kbl describe'
alias mk='minikube'
alias mkkbl='mk kubectl'
alias pods='kblg pods'
alias deploys='kblg deployments'
alias dpods='kbld pods'
alias ddeploy='kbld deployments'

# Git
alias g='git'
alias gb='g branch'
alias gbd='g branch -d'
alias gc='g c -S'
alias gcm='g c -S -m'
alias gca='gc --amend'
alias gcam='gc --ammend -m'
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
alias gdfc='g dsf --cached'
alias gdf='g dsf'
alias gdfcp='gdfc --patience'
alias gdfp='gdf --patience'
alias gp='g push -u origin (current_branch)'
alias gpf='gp --force-with-lease'
alias gpt='gp --tags'
alias gtags='g ctags'
alias gsl='g stash list'
alias gstsu='g stash save -u'
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
    g branch --merged $branch | grep -v master | grep -v develop | grep -v staging | grep -v qa | grep -v production | tr -cd "[:print:]" | sed "s/\[m//g" | xargs git branch -d
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
    git_remote | sed -nE 's/git@.*\..*:(.*)\/.*/\1/p'
end

function git_remote_repo_name
    git_remote | sed -nE 's/git@.*\..*:.*\/(.*)/\1/p'
end

function circleci
    if test (count $argv) = 0
        open "https://circleci.com/gh/"(git_remote_owner)"/"(git_remote_repo_name)"/tree/"(current_branch)
    else
        open "https://circleci.com/gh/"(git_remote_owner)"/"(git_remote_repo_name)"/tree/$argv"
    end
end

function semaphore
    if test (count $argv) = 0
        set branch_name (current_branch | sed 's/\//-/g' | tr '[:upper:]' '[:lower:]')
        open "https://semaphoreci.com/"(git_remote_owner)"/"(git_remote_repo_name)"/branches/"$branch_name
    else
        open "https://semaphoreci.com/"(git_remote_owner)"/"(git_remote_repo_name)"/branches/$argv"
    end
end

function pulls
    hub browse -- pulls
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

function master-to-qa
    gco master
    gup
    hpr qa
end

function master-to-staging
    gco master
    gup
    hpr staging
end

function qa-to-staging
    gco qa
    gup
    hpr staging
end

function staging-to-prod
    gco staging
    gup
    hpr production
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

alias bbp='brew bundle --file Brewfile.personal --no-lock'
alias redis='redis-server --daemonize yes; and redis-cli flushall'

function dark_theme
    echo -e "\033]50;SetProfile=Dark\a"
    vim -c '%s/\(set background=\)\w*/\1dark/g' +wq ~/.vimrc
    clear
end

function light_theme
    echo -e "\033]50;SetProfile=Light\a"
    vim -c '%s/\(set background=\)\w*/\1light' +wq ~/.vimrc
    clear
end

alias localip="ifconfig | grep 'inet ' | grep -Fv 127.0.0.1 | awk '{print \$2}'"

###### TRELLO #############
function trello-title
    ruby -rtrello -e "Trello.configure do |config|;config.developer_public_key = ENV['TRELLO_KEY'];config.member_token = ENV['TRELLO_TOKEN'];end;t=Trello::Card.find(ARGV[0]);puts t.name.gsub(/[^\w ]/, ' ').gsub(/ +/, '-').downcase[0..35];" $argv
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
    gco develop
    gup
    gcob feature/$id/$title
    trello-move-to-list $argv 'In Progress'
    trello-add-member $argv raulgracialario
    cl
end
###### TRELLO #############

function is_number
    test (math 0 + $argv[1]) -eq 0
end

alias ctags="echo ctags"

function find_pod_name
    set pod_name_argv $argv[1]
    kubectl get pods | grep Running | awk '{print $1}' | grep -E "^$pod_name_argv-\w{8,10}-\w{5}\$" | head -n1
end

function ssh-pod
    set pod_name (find_pod_name $argv[1])
    kubectl exec -it $pod_name bash
end

alias weather="curl http://wttr.in/London"
alias yd="youtube-dl"

function fix_gpg
    brew link --overwrite gnupg
    gpgconf --kill gpg-agent
end

function dotpush --description 'pushes dotfiles and encrypt exports and update dotfiles'
    cd ~/dotfiles
    gp
    gpg -aseo /tmp/exports -r '<raulgracialario@gmail.com>' ~/.config/fish/exports.fish
    gist /tmp/exports --private -u 4c6216ef0cd3a8c80d8e74decc36a6b3 >/dev/null
    rm -rf /tmp/exports
    cd -
end

function dotpull --description 'pulls dotfiles and decrypt exports'
    cd ~/dotfiles
    gup
    gist -r 4c6216ef0cd3a8c80d8e74decc36a6b3 >/tmp/exports
    gpg --decrypt /tmp/exports >~/.config/fish/exports.fish
    rm -rf /tmp/exports
    cd -
end

# Deliveroo

function get_access_role
    saiyan-cli new-role --role-name $argv[1] --duration "2 hours" --reason "SSM access to staging" --save-profile saml
end

function saiyan-rails-console
    ssm-saiyan $argv[1] internal-web hopper-runner bundle exec rails c
end

function staging-access
    gsts --idp-id C01jnk96c --sp-id 461132902683 --aws-profile saml
    saiyan-rails-console $argv[1]
    if test $status != 0
        get_access_role apps-testing-admin-production-engineer
        saiyan-rails-console $argv[1]
    end
end

function rider-api-staging
    staging-access rider-api
end

function rider-orders-staging
    staging-access rider-orders
end

function rider-domain-staging
    staging-access rider-domain
end

function order-status-staging
    staging-access order-status
end

function self-help-service
    staging-access self-help-service
end

##### Asdf install latest versions globally ########
function asdf_install_latest_version_of
    asdf install $argv[1] latest
    asdf global $argv[1] (asdf list $argv[1] | sort -nr | head -n 1 | string trim)
end

function install_latest_nodejs
    asdf_install_latest_version_of nodejs
    npm install -g npm@latest
end

function install_latest_ruby
    asdf_install_latest_version_of ruby
end

function install_latest_python
    asdf_install_latest_version_of python
end

function install_latest_erlang
    asdf_install_latest_version_of erlang
end

function install_latest_elixir
    asdf_install_latest_version_of elixir
end

function install_latest_rust
    asdf_install_latest_version_of rust
end

function install_latest_golang
    asdf_install_latest_version_of golang
end
