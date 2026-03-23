#!/usr/bin/env zsh

# ============================================================
# Advanced Setup Script (v2026.2)
# OS: Ubuntu / Debian / Kali (ZSH)
# Goal: Ultra-modern Dev + Bug Bounty + Security Research
# ============================================================

set -euo pipefail

# -----------------------------
# Colors & UI
# -----------------------------
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${BLUE}[INF]${NC} $1"; }
warn() { echo -e "${YELLOW}[WRN]${NC} $1"; }
error() { echo -e "${RED}[ERR]${NC} $1"; }
success() { echo -e "${GREEN}[OKV]${NC} $1"; }

# -----------------------------
# Error Handling
# -----------------------------
handle_error() {
    error "Installation failed at line $1. Exit code: $?"
    exit 1
}
trap 'handle_error $LINENO' ERR

# -----------------------------
# Pre-flight Checks
# -----------------------------
if [[ $EUID -eq 0 ]]; then
   error "Do not run as root. The script will prompt for sudo when needed."
   exit 1
fi

log "Initializing environment update..."
sudo apt-get update && sudo apt-get upgrade -y

# -----------------------------
# Core & Productivity Tools
# -----------------------------
log "Installing foundational & productivity tools..."
sudo apt-get install -y \
    curl wget git unzip gpg sudo \
    apt-transport-https ca-certificates \
    build-essential cmake pkg-config \
    zsh fzf ripgrep fd-find bat libssl-dev \
    jq tmux neovim tree htop tldr

# -----------------------------
# Modern Keyring Directory
# -----------------------------
sudo mkdir -m 0755 -p /etc/apt/keyrings

# ============================================================
# 1. BRAVE BROWSER
# ============================================================
log "Installing Brave Browser..."
curl -fsSL https://brave.com/linux-signing-key.pub | \
    sudo gpg --dearmor --yes -o /etc/apt/keyrings/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
    sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
sudo apt-get update && sudo apt-get install -y brave-browser

# ============================================================
# 2. VS CODE & SUBLIME TEXT
# ============================================================
log "Installing VS Code..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
    sudo gpg --dearmor --yes -o /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
    sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

log "Installing Sublime Text..."
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | \
    sudo gpg --dearmor --yes -o /etc/apt/keyrings/sublimehq-archive.gpg
echo "deb [signed-by=/etc/apt/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" | \
    sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null

sudo apt-get update && sudo apt-get install -y code sublime-text

# ============================================================
# 3. DOCKER ENGINE
# ============================================================
log "Installing Docker & Compose..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER || warn "Could not add user to docker group automatically."

# ============================================================
# 4. TRADITIONAL PENTEST TOOLS (APT)
# ============================================================
log "Installing traditional security tools..."
sudo apt-get install -y \
    nmap masscan hydra john hashcat \
    wireshark tcpdump netcat-openbsd \
    nikto gobuster dnsutils whois

# ============================================================
# 5. PYTHON & PIPX (Tool Isolation)
# ============================================================
log "Configuring Python Environment..."
sudo apt-get install -y python3-full python3-pip pipx
pipx ensurepath

log "Installing Python-based tools via pipx..."
pipx install git+https://github.com/maurosoria/dirsearch.git --force
pipx install sqlmap --force
pipx install bpython --force
pipx install shodan --force
pipx install git+https://github.com/initstring/cloud_enum.git --force

# ============================================================
# 6. GO & RUST TOOLCHAINS
# ============================================================
log "Installing Golang & Rust..."
sudo apt-get install -y golang-go

if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# ============================================================
# 7. RECON & BUG BOUNTY (The Go Stack)
# ============================================================
log "Installing Go-based Recon Tools..."
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

go_tools=(
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    "github.com/projectdiscovery/httpx/cmd/httpx@latest"
    "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
    "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
    "github.com/projectdiscovery/katana/cmd/katana@latest"
    "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
    "github.com/projectdiscovery/notify/cmd/notify@latest"
    "github.com/OWASP/Amass/v4/...@latest"
    "github.com/tomnomnom/waybackurls@latest"
    "github.com/lc/gau/v2/cmd/gau@latest"
    "github.com/ffuf/ffuf/v2@latest"
    "github.com/trufflesecurity/trufflehog/v3@latest"
)

for tool in "${go_tools[@]}"; do
    log "Downloading $tool..."
    go install -v "$tool"
done

# ============================================================
# 8. ZSH & SHELL PRODUCTIVITY
# ============================================================
log "Enhancing ZSH experience..."

# Modern 'ls' replacement: eza
sudo apt-get install -y eza || cargo install eza

ZSHRC="$HOME/.zshrc"

{
    echo -e "\n# --- 2026 Environment Updates ---"
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin:$HOME/.cargo/bin'
    echo "alias ls='eza --icons --group-directories-first'"
    echo "alias ll='eza -lah --icons --group-directories-first'"
    echo "alias cat='batcat --paging=never'" # Note: Use 'bat' if on Kali directly
    echo "alias grep='rg'"
    echo "alias find='fd'"
    echo "alias vi='nvim'"
    echo "alias vim='nvim'"
} >> "$ZSHRC"

# ============================================================
# 9. CLEANUP & VERIFICATION
# ============================================================
log "Cleaning up..."
sudo apt-get autoremove -y && sudo apt-get clean

log "Verifying installations..."
declare -A ver_tools=(
    ["Nmap"]="nmap"
    ["Docker"]="docker"
    ["Go"]="go"
    ["Nuclei"]="nuclei"
    ["Amass"]="amass"
    ["Trufflehog"]="trufflehog"
    ["Sqlmap"]="sqlmap"
)

for key in "${(k)ver_tools[@]}"; do
    if command -v "${ver_tools[$key]}" &> /dev/null; then
        success "$key is installed."
    else
        warn "$key installation check failed (check PATH)."
    fi
done

echo -e "\n${GREEN}============================================================${NC}"
echo -e "${GREEN} SETUP COMPLETE (v2026.2) ${NC}"
echo -e "${BLUE} New Tools Added: ${NC} Nmap, Amass, Trufflehog, Shodan, Cloud-Enum, JQ, Tmux, Neovim."
echo -e "${BLUE} Action Required: ${NC} Run 'source ~/.zshrc' and log out/in for Docker."
echo -e "${GREEN}============================================================${NC}"
