#!/bin/bash

# exit if has error
set -e

check_available() {
  if command -v "$1" &>/dev/null; then
    return 0 # success
  else
    echo "$1 not found!"
    return 1 # failure
  fi
}

OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
  echo "Terminal Setup for MacOS"

  # -- Homebrew --
  if check_available brew; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew install zsh
  brew install git
  brew install fzf
  # better cd command
  brew install zoxide
  brew install ripgrep
  brew install lua-language-server cmake-language-server

  # -- font --
  {
    brew install font-jetbrains-mono-nerd-font
  }
    
elif [[ "$OS" == "Linux" ]]; then 
  echo "Terminal Setup for Linux"

  # TODO: backup all the existing files

  apt update

  if check_available zsh; then
    echo "Set the current shell into zsh"
    chsh -s $(which zsh)
    exec zsh
  else
    echo "Installing zsh"
    apt install -y zsh
  fi

  # symlink farm manager
  if check_available stow; then
    echo "Creating symbolink for the dotfiles"
    stow ./zsh/.zshrc
    stow ./tmux/.tmux.conf
    stow .config/nvim/
  else 
    echo "Installing stow"
    apt install stow
  fi

  apt install tmux git fzf ripgrep font-jetbrains-mono

else
  echo "doesn't support current system"
  exit 1
fi


