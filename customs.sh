#!/bin/bash

set -e

if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
  echo "Homebrew already installed, now updated if needed."
fi

# Install CLI tools
brew install nushell
brew install htop
brew install git
brew install oh-my-posh
brew install zsh-syntax-highlighting
brew install ollama

# Install apps
brew install --cask mos
brew install --cask ghostty
brew install --cask powershell
brew install --cask alfred
brew install --cask raycast
brew install --cask google-chrome
brew install --cask sublime-text
brew install --cask visual-studio-code

# 5. Configure brew commands to be available within PowerShell
POWERSHELL_PATH="$(brew --prefix)/bin/pwsh"
if [ -f "$POWERSHELL_PATH" ]; then
  echo "Configuring PowerShell profile..."
  "$POWERSHELL_PATH" -Command '
    $profileDir = Split-Path -Parent -Path $PROFILE.CurrentUserAllHosts
    New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
    Add-Content -Path $PROFILE.CurrentUserAllHosts -Value "$($(brew --prefix)/bin/brew shellenv) | Invoke-Expression"
