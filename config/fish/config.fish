if test -f $HOME/.config/fish/aliases.fish
    source $HOME/.config/fish/aliases.fish
end

if test -f $HOME/.config/fish/exports.fish
    source $HOME/.config/fish/exports.fish
end

function fish_title
end
function fish_greeting
end

# Exports for PATHs
set -xg default_path ./node_modules/.bin /usr/bin /usr/sbin /bin /sbin /usr/local/mysql/bin/ /usr/local/bin
set -xg homebrew /opt/homebrew/bin opt/homebrew/sbin
set -xg rust $HOME/.cargo/bin
set -xg composer $HOME/.composer/vendor/bin
set -xg ANDROID_HOME /Users/(whoami)/Library/Android/sdk
set -xg JAVA_HOME (java -XshowSettings:properties -version 2>&1 >/dev/null | grep 'java.home' | sed -E 's/^\ +java\.home = //')
set -xg rover_path /Users/(whoami)/.rover/bin
set -gx PATH $homebrew $default_path $rust $composer $rover_path $ANDROID_HOME/platform-tools $ANDROID_HOME/tools/bin
set -g fish_user_paths $JAVA_HOME $fish_user_paths


set -gx KERL_BUILD_DOCS yes
set -xg RUBYOPT -W0
set -xg RUBY_CFLAGS -w
set -xg HOMEBREW_NO_ANALYTICS 1
set -xg FISH_CLIPBOARD_CMD pbcopy
set -xg EDITOR code --wait
set -xg MYSQL_USERNAME root
set -xg COVERAGE true
set -xg GPG_TTY (tty)
set -xg OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -xg STARSHIP_CONFIG ~/.config/starship.toml


test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

source (brew --prefix asdf)/libexec/asdf.fish
starship init fish | source

set uptime_days (string trim (uptime | ruby -e 'puts readlines.first.strip.match(/\d+:\d+  up (.*), \d users?,/)&.captures&.first&.strip'))
if test -n uptime_days
    echo "Days without restart: "$uptime_days
end
fish_add_path /opt/homebrew/sbin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
thefuck --alias | source
