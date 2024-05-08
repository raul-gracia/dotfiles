
# Fish
alias fr='source ~/.config/fish/config.fish > /dev/null 2>&1'
alias fe='nvim ~/.config/fish/config.fish'
alias fexports='nvim ~/.config/fish/exports.fish'
alias faliases='nvim ~/.config/fish/aliases.fish'

function who-port
    lsof -n -i4TCP:(string trim $argv[1]) | grep LISTEN
end

alias ls='eza -l --git --icons'
alias cat='bat'

# Goa shorcuts
alias goa_rails_console='docker-compose exec web rails c'
alias goa_sh='docker-compose exec web fish'
alias goa='cd ~/Code/goa'

# Typos
alias cl='clear'
alias clar='clear'
alias dofiles='dotfiles'
alias gs='gst'

# Shortcuts
alias dev='cd ~/Code'
alias ws='cd ~/workspace'
alias wk='cd ~/Code/work'
alias docs='cd ~/Documents'
alias dotfiles='nvim ~/dotfiles'
alias chr='cd ~/Code/digital-chronos'
alias interview="cd ~/Code/interview-exercises"
alias salsa="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Salsa\ Music/"

alias vim='nvim'
alias pihole='ssh pi@192.168.1.37'
alias z='zellij'
alias zkada='z ka -y; z da -fy'
alias ve='nvim ~/.config/nvim/'


alias livebook="/Users/raulgracia/.mix/escripts/livebook"

alias tall-crop="mogrify -crop +16+41 -crop -12-124 *.jpg"


alias serve_dir='ruby -run -e httpd . -p 5055'

alias tat='tmux attach -t'
alias tls='tmux ls'
alias tmuxgen_list='ll ~/.tmuxgen/'

alias add-ssh-keys='ssh-add -K ~/.ssh/github; and ssh-add -K ~/.ssh/raulgracialario'

function time_in_london
    cd ~/Code/time_in_london/
    ruby time_in_london.rb $argv
    cd -
end
function time_in_salsa
    cd ~/Code/time_in_london/
    ruby time_in_salsa.rb $argv
    cd -
end
function time_until
    cd ~/Code/time_in_london/
    ruby time_until.rb $argv
    cd -
end

function time_till_end
    time_until '(date +"%Y-%m-%d") 17:00:00' --sort
end
alias tte='time_till_end'

function time_since
    cd ~/Code/time_in_london/
    ruby time_since.rb $argv
    and cd -
end

alias uptime-me='ruby ~/dotfiles/uptime.rb'

function upgradeall
    brew update
    brew upgrade
    brew uninstall --ignore-dependencies nodejs
    omf update
    nvim --headless +':Lazy update' +':Lazy sync' +':qall'
    asdf plugin update --all
    install_latest_ruby
    install_latest_python
    install_latest_rust
    install_latest_golang
    install_latest_erlang
    install_latest_elixir
    install_latest_nodejs
    install_latest_bundler
    pip3 install neovim --upgrade
    pip3 install --upgrade pip
end

# Rails
# alias docked='docker run --rm -it -v (pwd):/rails -v ruby-bundle-cache:/bundle -p 3000:3000 ghcr.io/rails/cli'
# alias rails='docked rails'
# alias rails-dev='docked bin/dev'
# alias bundle='docked bundle'
# alias yarn='docked yarn'
# alias rake='docked rake'
# alias gem='docked gem'




alias be='bundle exec'
alias ber='bin/rails'
alias rdb='bin/rails db:migrate'
alias rdbt='bin/rails db:migrate db:test:prepare'
alias beg='bundle exec guard -c'
alias rs='./bin/rails s --binding 127.0.0.1 $argv 2>/dev/null; or be rails s --binding 127.0.0.1 $argv'
alias berc='bin/rails console'
alias bec='bundle exec cucumber'
alias berr='bin/rails routes'
alias berrg='bin/rails routes | grep '
alias berrp='bin/rails runner "puts Rails.application.routes.recognize_path(\"$argv\")"'
alias berrpp='bin/rails runner "puts Rails.application.routes.recognize_path(\"$argv[1]\", method: :$argv[2])"'
alias berg='bin/rails g'
alias bergg='bin/rails g | grep'
alias bersp='bundle exec rspec'
alias rubo='bundle exec rubocop --display-style-guide --display-cop-names --extra-details'
alias rubo_fix='rubo --auto-correct'
alias rubo_fix_all='rubo --auto-correct-all'
alias rubo_todo='rubo --regenerate-todo'
function latest_ruby
    brew upgrade
    clear
    asdf list all ruby | grep "^"$argv[1]".\d.\d\$" | tail -n 1
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
alias dc='docker compose'
alias dcd='docker compose down'
alias dcuw='docker compose up web'
alias dce='dc exec'
alias dcew='dce web'
alias kt='dc run -e MIX_ENV=test web mix test'

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
alias gdf='g diff'
alias gp='g branch --set-upstream-to=origin/(current_branch) (current_branch); g push'
alias gpf='gp --force-with-lease'
alias gpt='gp --tags'
alias gtags='g ctags'
alias gsl='g stash list'
alias gstsu='g stash save -u'
alias gstl='g stash list'
alias gstp='g stash pop'
alias current_branch='g rev-parse --abbrev-ref HEAD'
alias hbb='hub browse (git_remote_owner)/(git_remote_repo_name)'
alias tldr='tldr --theme base16'
alias set-upstream='git branch --set-upstream-to=origin/(current_branch) (current_branch)'


alias ghce='gh copilot explain'
alias ghcs='gh copilot suggest'

function hb
    hub browse (git_remote_owner)/(git_remote_repo_name)
end

function clean_merged_branches
    if string length -q $argv[1]
        set branch $argv[1]
    else
        set branch develop
    end
    g branch --merged $branch | grep -v main | grep -v master | grep -v develop | grep -v staging | grep -v qa | grep -v production | tr -cd "[:print:]" | sed "s/\[m//g" | xargs git branch -d
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
alias hpr='gp; and gh pr create --base'
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

function delete_squashed_branches
    ~/dotfiles/scripts/delete_squashed_branches.rb $argv
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
        open "https://.atlassian.net/browse/"$issue_number
    end
end

function releasing_tickets
    glg master..develop | grep -o 'MD-\d\+' | sort | uniq | sed -E 's/(.*)/https:\/\/\.atlassian\.net\/browse\/\1/'
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
alias hk="/opt/homebrew/bin/heroku"
alias hlog='hk logs -t -a'
alias hlg='hk logs -t'
alias hconf='hk config -a'
alias hp='g push heroku (current_branch):master'

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
alias yd="/usr/local/bin/youtube-dl"
alias yd-playlist="yd -x -k --embed-thumbnail --audio-format flac --add-metadata --yes-playlist -i"
alias yd-audio="yd -x --audio-format flac --audio-quality 0"
alias yd-mp3="yd -x --audio-format mp3 --audio-quality 0"

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
    gh gist view 4c6216ef0cd3a8c80d8e74decc36a6b3 > /tmp/exports
    gpg --decrypt /tmp/exports >~/.config/fish/exports.fish
    rm -rf /tmp/exports
    cd -
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
    mix local.hex --force
    mix local.phx --force
    mix archive.install hex phx_new --force
end

function install_latest_rust
    asdf_install_latest_version_of rust
end

function install_latest_golang
    asdf_install_latest_version_of golang
end

function install_latest_bundler
    asdf_install_latest_version_of bundler
end


function generate_xassets
    set input $argv[1]
    set file_name (string split -r -m1 "." (basename $input))[1]
    set file_ext (string split -r -m1 "." (basename $input))[2]
    convert -resize 512x512 $input $file_name"-512x512."$file_ext
    convert -resize 1024x1024 $input $file_name"-1024x1024."$file_ext
    convert -resize 256x256 $input $file_name"-256x256."$file_ext
    convert -resize 128x128 $input $file_name"-128x128."$file_ext
    convert -resize 64x64 $input $file_name"-64x64."$file_ext
    convert -resize 32x32 $input $file_name"-32x32."$file_ext
    convert -resize 16x16 $input $file_name"-16x16."$file_ext
end


function create_windows_instance
    set instance_name windows-vlc
    echo "Creating key pair..."
    # Generate new keypair
    aws lightsail create-key-pair --key-pair-name $instance_name-key-pair --output json >keypair.json
    jq -r '.publicKeyBase64' keypair.json >~/.ssh/$instance_name-publickey.pem
    jq -r '.privateKeyBase64' keypair.json >~/.ssh/$instance_name-privatekey.pem
    chmod 600 ~/.ssh/$instance_name-privatekey.pem
    rm keypair.json

    echo "Creating instance..."
    # Create a new Instance
    aws lightsail create-instances --instance-names $instance_name --availability-zone eu-west-2b --blueprint-id windows_server_2022 --bundle-id medium_win_3_0 --key-pair-name $instance_name-key-pair >/dev/null

    echo "Waiting..."
    # Wait for instance state until it's running
    while true
        set instance_state (aws lightsail get-instance-state --instance-name $instance_name --query 'state.name' --output text)
        if test $instance_state = running
            break
        end
        sleep 1
    end
    # Wait for RDP to be ready
    while true
        set access_details (aws lightsail get-instance-access-details --instance-name $instance_name --query 'accessDetails.passwordData.ciphertext' --output text)
        if test -n "$access_details"
            break
        end
        sleep 1
    end

    fetch_instance_password
    echo "Done. Password has been copied to clipboard"
end

function destroy_windows_instance
    set instance_name windows-vlc
    aws lightsail delete-instance --instance-name $instance_name
    aws lightsail delete-key-pair --key-pair-name $instance_name-key-pair
end

function fetch_instance_password
    set instance_name windows-vlc
    # Fetch RDP Password and Details
    set access_json (aws lightsail get-instance-access-details --instance-name $instance_name --output json)

    # Decrypt the ciphertext using the PEM key
    set encrypted_password (echo $access_json | jq -r '.accessDetails.passwordData.ciphertext')
    set pem_key_path ~/.ssh/$instance_name-privatekey.pem
    set decrypted_password (echo $encrypted_password | base64 --decode | openssl pkeyutl -decrypt -inkey $pem_key_path)

    echo $decrypted_password | pbcopy
end


function fetch_github_trello_info
    set git_remote (git config --get remote.origin.url)

    if test -z "$git_remote"
        echo "This directory is not a Git repository."
        return 1
    end
    # Use regex to match owner and repo
    set matches (string match -r 'https:\/\/github.com\/(.*)\/(.*).git' $git_remote)

    # Extract owner and repo from regex captures
    set owner $matches[2]
    set repo $matches[3]

    ruby ~/fetch-monthly-work.rb $owner $repo
end
