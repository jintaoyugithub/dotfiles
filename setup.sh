#!/bin/bash

# exit if has error
set -e

OS="$(uname -s)"

# -- Functions --

check_available() {
  if command -v "$1" &>/dev/null; then
    return 0 # success
  else
    echo "$1 not found!"
    return 1 # failure
  fi
}

install_nerd_font() {
  installed_path="$1"
  name="$2"
  url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${name}.zip"

  echo "Installing ${name} nerd font"

   # Check if the font is already installed
  if [ -d "${installed_path}/${name}" ] || [ -n "$(ls -A "${installed_path}" 2>/dev/null)" ]; then
    echo "${name} nerd font already installed, skipping."
    return 0
  fi

  mkdir -p "${installed_path}"

  curl -L -o /tmp/${name}.zip "$url"

  # unzip into fonts folder
  unzip -o /tmp/${name}.zip -d "$installed_path"

  # rebuild font cache (linux only)
  if check_available fc-cache; then
    fc-cache -fv ~/.fonts
  fi

  echo "${name} installed!"
  echo "if you're using WSL, install the font in windows and change the setting instead"
}


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
  brew install font-jetbrains-mono-nerd-font
    
elif [[ "$OS" == "Linux" ]]; then 
  echo "Terminal Setup for Linux"

  # TODO: backup all the existing files

  sudo apt update && sudo apt upgrade
  sudo apt install -y unzip curl fontconfig build-essential
  sudo apt install tmux git fzf ripgrep

  # neovim
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim-linux-x86_64
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
  sudo rm nvim-linux-x86_64.tar.gz

  # zoxide
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

  # symlink farm manager
  if ! check_available stow; then
    echo "Installing stow"
    sudo apt install stow
  fi

  echo "Creating symbolink for the dotfiles"
  stow zsh
  stow tmux
  stow dotconfig

  # install nerd fonts
  install_nerd_font ${HOME}/.fonts JetBrainsMono

  if ! check_available zsh; then
    echo "Installing zsh"
    sudo apt install -y zsh
  fi

  echo "Set the current shell into zsh"
  # chsh doesn't work in wsl
  # use wsl ~ -e zsh instead
  chsh -s $(which zsh)
  # This command shouldn't be run in sudo mode
  exec zsh

else
  echo "doesn't support current system"
  exit 1
fi


