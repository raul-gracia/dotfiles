#!/usr/bin/env bash

# Enable the script to exit on any error
set -e

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Print messages in color
log_info() {
  echo -e "${GREEN}$1${NC}"
}

log_error() {
  echo -e "${RED}$1${NC}"
}

# Check command success
check_command() {
  if ! eval "$1"; then
    log_error "Failed to execute: $1"
    exit 1
  fi
}

log_info 'Installing a new machine? Nice!'

if [ "$(uname -s)" = "Darwin" ]; then
    check_command "xcode-select --install"
fi

if ! command -v brew > /dev/null 2>&1; then
  log_info 'Okay, let’s do this. First things first, we need to install Homebrew to get all the stuff you need.'
  check_command "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  log_info 'Homebrew was already available... skipping the installation.'
  log_info "Let's update it instead! (you know you haven't updated in a while)"
  check_command "brew update"
fi

if ! command -v fish > /dev/null 2>&1; then
  log_info "Now that we can brew, let's install fish (your friendly shell)."
  check_command "brew install fish"
  log_info "Now that we have fish, let's make it our default shell."
  check_command "sudo bash -c \"echo '/opt/homebrew/bin/fish' >> /etc/shells\""
  check_command "chpass -s /opt/homebrew/bin/fish $(whoami)"
else
  log_info 'Fish already installed! Nice one!'
  log_info 'Upgrading (just in case).'
  check_command "brew upgrade fish"
fi

check_command "curl -L https://get.oh-my.fish | fish"
check_command "fish omf theme install bira"

# ACTUAL INSTALLATION
if [ -d ~/dotfiles ]; then
  cd ~/dotfiles
  check_command "git pull"
else
  check_command "git clone https://github.com/raul-gracia/dotfiles.git ~/dotfiles"
  cd ~/dotfiles
fi
check_command "fish setup.fish"
