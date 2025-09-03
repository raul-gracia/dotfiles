# Fish
alias fr='source ~/.config/fish/config.fish > /dev/null 2>&1'
alias fe='nvim ~/.config/fish/config.fish'
alias fexports='nvim ~/.config/fish/exports.fish'
alias faliases='nvim ~/.config/fish/aliases.fish'

function who-port
    lsof -n -i4TCP:(string trim $argv[1]) | grep LISTEN
end
function kill-port
    who-port $argv[1] | awk '{print $2}' | xargs kill -9 2>/dev/null
end

alias ls='eza -al --git --icons'
alias cat='bat'

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
alias vault="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Personal\ \(iCloud\)"

alias vim='nvim'
alias pihole='ssh pi@192.168.1.37'
alias z='zellij'
alias zkada='z ka -y; z da -fy'
alias ve='cd ~/.config/nvim/ && nvim ~/.config/nvim/ && cd -'

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
    cd ~
    clear
    gum style \
        --foreground 150 --border-foreground 150 --border double \
        --align center --width 25 'Upgrade all the things!'
    gum spin --show-error --title "Updating homebrew..." -- brew update
    gum spin --show-error --show-output --title "Upgrading homebrew..." -- brew upgrade
    gum spin --show-error --title "Updating neovim plugins..." -- nvim --headless +':Lazy update' +':Lazy sync' +':qall'
    gum spin --show-error --title "Updating mise plugins..." -- mise plugin update
    gum spin --show-error --title "Updating mise..." -- mise up --yes --quiet --bump
    gum spin --show-error --title "Installing latest npm..." -- npm install -g npm@latest
    gum spin --show-error --title "Upadate pipx plugins" -- pipx upgrade-all
    gum spin --show-error --title "Update fabric cli" -- go install github.com/danielmiessler/fabric@latest
    gum spin --show-error --title "Update phoenix" -- mix local.phx --force
    gum spin --show-error --title "Update igniter" -- mix local.igniter --force
    gum spin --show-error --title "Update rails gem" -- gem update --system && gem install rails
    clear
    gum style \
        --foreground 150 --border-foreground 150 --border double \
        --align center --width 25 'Done!'
    cd -
end

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
    mise ls-remote ruby | grep "^"$argv[1]".\d.\d\$" | tail -n 1
end
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
alias dcu='docker compose up'
alias dce='dc exec'
alias dcew='dce web'
alias kt='dc run -e MIX_ENV=test web mix test'

######################
# Kubernetes ( k8s ) #
######################
function kubectl --wraps kubectl
    command kubecolor $argv
end
function k --wraps kubectl
    command kubecolor $argv
end
alias kg='k get'
alias kd='k describe'
alias mk='minikube'
alias mkk='mk kubectl'
alias pods='kg pods'
alias deploys='kg deployments'
alias dpods='kd pods'
alias ddeploys='kd deployments'

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
alias gdfc='g diff --cached'
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
    # Get the main branch name (default to 'main' if not provided)
    set main_branch (if test (count $argv) -gt 0; echo $argv[1]; else; echo "main"; end)

    # Checkout and update main branch
    gum style --foreground blue "Checking out $main_branch..."
    git checkout $main_branch >/dev/null 2>&1
    gum style --foreground blue "Updating..."
    git pull >/dev/null

    # Get all local branches except main/master
    set local_branches (git branch --no-color | string trim | grep -v -E "^\*|^$main_branch\$|^master\$")

    # Check each branch
    for branch in $local_branches
        gum style --foreground blue "Checking local branch $branch..."

        # Use gh to check if the branch has a PR and its status
        set pr_info (gh pr list --state all --head $branch --json state,merged --limit 1 2>/dev/null)

        if test -n "$pr_info"
            # Parse the JSON response
            set pr_state (echo $pr_info | jq -r '.[0].state' 2>/dev/null)
            set pr_merged (echo $pr_info | jq -r '.[0].merged' 2>/dev/null)

            # Delete branch if PR is closed or merged
            if test "$pr_state" = CLOSED -o "$pr_merged" = true
                gum style --foreground red "Deleting branch $branch..."
                git branch -D $branch
            end
        end
    end

    # Return to previous branch
    git checkout - >/dev/null
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

function yd-transcript
    fabric -y $argv[1] --transcript | fabric --stream --pattern extract_wisdom --output /Users/raulgracia/Transcripts/(string replace -a ' ' '_' $argv[2]).md
end

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
    gh gist view 4c6216ef0cd3a8c80d8e74decc36a6b3 >/tmp/exports
    gpg --decrypt /tmp/exports >~/.config/fish/exports.fish
    rm -rf /tmp/exports
    cd -
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

function show_pattern
    cat ~/.config/fabric/patterns/$argv[1]/system.md
end

alias copy-patterns="cp -a ~/.config/custom-fabric-patterns/* ~/.config/fabric/patterns/"

function decrease_brightness
    osascript -e "tell application \"System Events\" to key code 145"
end

function increase_brightness
    osascript -e "tell application \"System Events\" to key code 144"
end

function set_max_brightness
    # Assuming 16 steps for maximum brightness
    for i in (seq 1 16)
        increase_brightness
    end
end

function _reduce_brightness
    set total_steps $argv[1]
    set interval $argv[2]

    # Set brightness to maximum before starting
    set_max_brightness

    # Wait a moment for the brightness change to take effect
    sleep 1

    for i in (seq 1 $total_steps)
        decrease_brightness
        sleep $interval
    end
end

function schedule_brightness_reduction
    if test (count $argv) -eq 0
        echo "Usage: schedule_brightness_reduction <time>"
        echo "Time can be in the format 'Xh' (e.g., '2h') or 'HH:MM' (e.g., '01:30')"
        return 1
    end

    set input_time $argv[1]

    # Get current brightness steps (16 is assumed for macs, adjust if needed)
    set total_steps 16

    # Parse time format (either "Xh" or a specific "HH:MM")
    if string match -q -r '^\d+h$' $input_time
        # If input is like "2h", convert to seconds
        set hours (string replace 'h' '' $input_time)
        if not string match -q -r '^\d+$' $hours
            echo "Invalid hour format. Please use a number followed by 'h', e.g., '2h'"
            return 1
        end
        set duration (math "$hours * 3600")
    else if string match -q -r '^\d\d:\d\d$' $input_time
        # If input is like "03:00", calculate time difference to the future point
        set current_hour (date +"%H")
        set current_min (date +"%M")

        set target_hour (string sub -l 2 $input_time)
        set target_min (string sub -s 4 -l 2 $input_time)

        # Convert both current and target time to minutes since midnight
        set current_total_min (math "$current_hour * 60 + $current_min")
        set target_total_min (math "$target_hour * 60 + $target_min")

        # If target is earlier than current, assume it's for the next day
        if test $target_total_min -le $current_total_min
            set target_total_min (math "$target_total_min + 24 * 60")
        end

        # Duration is the difference in minutes, then converted to seconds
        set duration (math "($target_total_min - $current_total_min) * 60")
    else
        echo "Invalid input. Use format like '2h' or '03:00'."
        return 1
    end

    # Calculate interval (time between each brightness reduction)
    set interval (math "$duration / $total_steps")

    # Launch the background process
    fish -c "_reduce_brightness $total_steps $interval" &
    echo "Brightness set to maximum and will reduce to zero in $input_time (every "(printf "%.2f" $interval)" seconds)."

end

# Extract audio from video file
function extract_audio
    if test (count $argv) -ne 1
        gum style --foreground red --bold "❌ Usage: extract_audio <file_path>"
        return 1
    end

    set input_file $argv[1]
    set base_name (basename $input_file | cut -d. -f1)
    set output_file (dirname $input_file)/$base_name.wav

    # Debugging information
    gum style --foreground yellow --bold "📂 Debug: Parameters received"
    gum style --foreground cyan "   Input file: $input_file"
    gum style --foreground cyan "   Base name: $base_name"
    gum style --foreground cyan "   Output file: $output_file"

    # Extracting audio
    gum spin --spinner line --title "Extracting audio from $input_file" -- ffmpeg -i $input_file -vn -acodec pcm_s16le $output_file

    if test $status -eq 0
        gum style --foreground green --bold "✅ WAV created: $output_file"
    else
        gum style --foreground red --bold "❌ Failed to extract audio"
        return 1
    end
end

# Transcribe audio and diarise speakers
function transcribe_audio
    if test (count $argv) -ne 1
        gum style --foreground red --bold "❌ Usage: transcribe_audio <video_file_path>"
        return 1
    end

    set input_file $argv[1]
    set base_name (basename $input_file | cut -d. -f1)
    set output_dir (dirname $input_file)
    set original_wav $output_dir/$base_name.wav
    set converted_wav $output_dir/$base_name-converted.wav
    set json_output $output_dir/$base_name.json
    set diarisation_output $output_dir/$base_name_diarisation.json

    # Step 1: Extract audio from video file
    gum style --foreground cyan --bold "🔊 Extracting audio from video..."
    extract_audio $input_file
    if test $status -ne 0
        gum style --foreground red --bold "❌ Failed to extract audio."
        return 1
    end

    # Step 2: Convert audio to required format
    gum style --foreground cyan --bold "🎛️ Converting audio to 16 kHz mono..."
    gum spin --spinner line --title "Converting $original_wav to $converted_wav" -- \
        ffmpeg -i $original_wav -ar 16000 -ac 1 $converted_wav

    if test $status -ne 0
        gum style --foreground red --bold "❌ Failed to convert audio."
        return 1
    end

    # Step 3: Transcribe audio using Whisper CLI
    gum style --foreground cyan --bold "📝 Transcribing audio using Whisper..."
    gum spin --spinner line --title "Transcribing $converted_wav" -- \
        whisper $converted_wav --model medium --output_format json --output_dir $output_dir

    if test $status -eq 0
        gum style --foreground green --bold "✅ Transcription saved: $json_output"
    else
        gum style --foreground red --bold "❌ Transcription failed."
        return 1
    end

    # Step 4: Speaker diarisation using pyannote.audio
    gum style --foreground cyan --bold "🗣️ Performing speaker diarisation..."
    gum spin --spinner line --title "Diarising speakers in $converted_wav" -- \
        pyannote-audio dia --input $converted_wav >$diarisation_output

    if test $status -eq 0
        gum style --foreground green --bold "✅ Speaker diarisation saved: $diarisation_output"
    else
        gum style --foreground red --bold "❌ Speaker diarisation failed."
        return 1
    end
end

function inspiration_quote
    # If the file exists, read its content into a variable. Otherwise, set it to empty.
    if test -f ~/quotes.txt
        set existing_quotes (cat ~/quotes.txt)
    else
        set existing_quotes ""
    end

    # Generate a new quote, making sure to include the existing quotes in the prompt 
    # so we don’t repeat the same output.
    set new_quote (claude -p "
      You are a quote generator.
      You have already generated these quotes:
      \"$existing_quotes\"

      Please generate an original inspirational quote for daily motivation. 
      The quote should embody perseverance, hard work, and determination, 
      and it should be similar in style to:
        \"I never dreamed about success. I work for it.\" by Estée Lauder.
      Ensure the quote is crafted in British English and includes its author.
      Do not repeat any quote that appears in the list above.
    ")

    # Append the new quote to the file
    echo $new_quote >>~/quotes.txt

    # Display the new quote in green and bold
    gum style --foreground green --bold $new_quote
end

alias setup-cursor-rules 'mkdir -p .cursor/rules && cp ~/.cursor/rules/* .cursor/rules/'
alias setup-claude-rules 'mkdir -p .claude/ && cp ~/.claude/settings.local.json .claude/'

function review_apps_console
    if test (count $argv) -eq 0
        echo "Error: Please provide a PR number as an argument"
        echo "Usage: review_apps_console <PR_NUMBER>"
        return 1
    end
    set pr_number $argv[1]
    az login --tenant 9c7d9dd3-840c-4b3f-818e-552865082e16 && make test get-cluster-credentials && kubectl -n srtl-development exec -it deployment/claim-additional-payments-for-teaching-review-$pr_number-worker -- rails console
end
