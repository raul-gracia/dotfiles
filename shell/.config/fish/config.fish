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
set -xg default_path /usr/bin /usr/sbin /bin /sbin /usr/local/bin
set -xg homebrew /opt/homebrew/bin /opt/homebrew/sbin
set -xg composer $HOME/.composer/vendor/bin
set -xg ANDROID_HOME $HOME/Library/Android/sdk
set -xg ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -xg JAVA_HOME (java -XshowSettings:properties -version 2>&1 >/dev/null | grep 'java.home' | sed -E 's/^\ +java\.home = //')
set -xg BUN_INSTALL "$HOME/.bun"

set -xg KERL_BUILD_DOCS yes
set -xg HOMEBREW_NO_ANALYTICS 1
set -xg FISH_CLIPBOARD_CMD pbcopy
set -xg EDITOR nvim
set -xg GPG_TTY (tty)

fish_add_path $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator $ANDROID_HOME/tools/bin $homebrew $default_path $composer
fish_add_path $HOME/.local/bin $JAVA_HOME $BUN_INSTALL/bin
fish_add_path $HOME/.codeium/windsurf/bin
fish_add_path $HOME/.lmstudio/bin

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

mise activate fish | source
alias claude="/Users/raulgracia/.claude/local/claude"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/raulgracia/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
