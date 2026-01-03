#!/bin/bash

#===============================================================================
# Script:    Install and Configure gf
# Author:    INTELEON404
#===============================================================================

#---------------------------#
#       ASCII Banner        #
#---------------------------#
echo -e "\n\033[1;36m" 
echo "┳┳┓┏┳┓┏┓┓ ┏┓┏┓┳┓┏┓┏┓┏┓"
echo "┃┃┃ ┃ ┣ ┃ ┣ ┃┃┃┃┃┃┃┫┃┃"
echo "┻┛┗ ┻ ┗┛┗┛┗┛┗┛┛┗┗╋┗┛┗╋"
echo -e "\033[0m" 

#---------------------------#
#        Colors             #
#---------------------------#
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m"

#---------------------------#
#        Variables          #
#---------------------------#
GF_DIR="$HOME/.gf"
GF_ZIP_URL="https://github.com/INTELEON404/AppStore/raw/refs/heads/main/gf.zip"
GF_ZIP_FILE="gf.zip"
GF_COMPLETION="$HOME/go/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/gf-completion.zsh"

#---------------------------#
#        Functions          #
#---------------------------#
info()    { echo -e "${BLUE}[*] $1${NC}"; }
success() { echo -e "${GREEN}[+] $1${NC}"; }
warn()    { echo -e "${YELLOW}[!] $1${NC}"; }
error()   { echo -e "${RED}[-] $1${NC}"; exit 1; }

#---------------------------#
#      Script Execution     #
#---------------------------#

info "Installing gf via Go..."
if go install github.com/tomnomnom/gf@latest; then
    success "gf installed successfully."
else
    error "Failed to install gf. Please check your Go installation."
fi

info "Downloading gf templates..."
if wget -q --show-progress -O "$GF_ZIP_FILE" "$GF_ZIP_URL"; then
    success "gf.zip downloaded successfully."
else
    error "Failed to download gf.zip from $GF_ZIP_URL."
fi

info "Extracting gf.zip to $GF_DIR..."
mkdir -p "$GF_DIR"
if unzip -o "$GF_ZIP_FILE" -d "$GF_DIR" >/dev/null; then
    success "gf.zip extracted to $GF_DIR successfully."
else
    error "Failed to unzip $GF_ZIP_FILE."
fi

info "Setting up gf Zsh completion..."
if [ -f "$GF_COMPLETION" ]; then
    if ! grep -Fxq "source $GF_COMPLETION" ~/.zshrc; then
        echo "source $GF_COMPLETION" >> ~/.zshrc
        success "gf completion added to ~/.zshrc."
    else
        warn "gf completion already exists in ~/.zshrc."
    fi
else
    warn "gf-completion.zsh not found at $GF_COMPLETION."
fi

success "Setup complete! Please restart your terminal or run 'source ~/.zshrc' to activate gf."
