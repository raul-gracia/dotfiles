#!/usr/bin/env sh

echo 'Installing a new machine? Nice!'
if [ "$(uname -s)" = "Darwin" ]; then
    xcode-select --install
fi

if ! command -v brew > /dev/null 2>&1; then
  echo 'Okay, lets do this. First things first, we need to install homebrew in order to get all the stuff you need'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo 'Homebrew was already available... skipping the installation'
  echo "Let's update it instead! (you know you haven't updated in a while)"
  brew update
fi

if ! command -v fish > /dev/null 2>&1 ; then
  echo "Now that we can brew, let's install fish (your friendly shell)"
  brew install fish
  echo "Now that we have fish let's make it our default shell"
  sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"
  chpass -s /usr/local/bin/fish `whoami`
else
  echo 'Fish already installed! Nice one!'
  echo 'Upgrading (just in case)'
  brew upgrade fish
fi
curl -L https://get.oh-my.fish | fish
omf theme install bira

# HERE WE WILL START WITH THE ACTUALL INSTALLATION
if [ -d ~/dotfiles ]; then
  cd ~/dotfiles
  git pull
else
  git clone https://github.com/raul-gracia/dotfiles.git ~/dotfiles
  cd ~/dotfiles
fi
fish setup.fish
