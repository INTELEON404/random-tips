# ===============================
# 1. IDENTITY & THEME
# ===============================
CUSTOM_USER="LEVEL"
CUSTOM_HOST="LINUX"
KALI_SYM="㉿"

# Colors
CLR_PRP='\033[38;5;135m' 
CLR_CYN='\033[38;5;81m'  
CLR_GRN='\033[38;5;84m'  
CLR_DIM='\033[38;5;244m' 
CLR_RST='\033[0m'

# ===============================
# 2. ENVIRONMENT & PATHS
# ===============================
export GOPATH=$HOME/go
export PATH="$PATH:$HOME/go/bin:$HOME/.local/bin:/usr/local/go/bin"
export TERM="xterm-256color"
export PDCP_API_KEY="8a59c1f4-cb48-4cb7-a72c-40c38ab9ac46"

# ===============================
# 3. THE DASHBOARD FUNCTION
# ===============================
show_header() {
    # Metrics Calculation
    local L_IP=$(hostname -I | awk '{print $1}')
    local UPT=$(uptime -p | sed 's/up //; s/ hours\?/h/; s/ minutes\?/m/')
    local RAM=$(free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }')
    local DSK=$(df -h / | awk 'NR==2 {print $5}')
    local BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")
    [[ "$BAT" != "N/A" ]] && BAT="${BAT}%"

    center() {
        local width=$(tput cols)
        while IFS= read -r line; do
            # Strip ANSI escape codes to calculate true visible length
            local clean_line=$(echo "$line" | sed 's/\x1b\[[0-9;]*m//g')
            printf "%*s\n" $(( (${#clean_line} + width) / 2 )) "$line"
        done
    }

    # ASCII Banner
    echo -e "${CLR_PRP}"
    cat << "EOF" | center
░▀█▀░█▀█░▀█▀░█▀▀░█░░░█▀▀░█▀█░█▀█░█░█░▄▀▄░█░█
░░█░░█░█░░█░░█▀▀░█░░░█▀▀░█░█░█░█░░▀█░█O█░░▀█
░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░▀░░▀░░░░▀
EOF
    echo -e "${CLR_RST}"

    # Row 1 (Identity, IP, Uptime, Time)
    printf "${CLR_DIM}ID:${CLR_RST} %-12s ${CLR_DIM}│ IP:${CLR_RST} %-20s ${CLR_DIM}│ UP:${CLR_RST} %-18s ${CLR_DIM}│${CLR_RST} %s\n" \
        "$CUSTOM_USER" "${L_IP:-127.0.0.1}" "$UPT" "$(date +'%H:%M:%S')"
        
    # Row 2 (Status, RAM, Disk, Battery)
    printf "${CLR_DIM}STATUS:${CLR_RST} %-8s ${CLR_DIM}│ RAM:${CLR_RST} %-19s ${CLR_DIM}│ DISK:${CLR_RST} %-16s ${CLR_DIM}│ BAT:${CLR_RST} %s\n" \
        "READY" "$RAM" "$DSK" "$BAT"
    echo
}

# ===============================
# 4. STARTUP EXECUTION
# ===============================
if [[ $- == *i* ]]; then
    # Removed the background sudo apt update to prevent hidden password prompts
    command clear
    show_header
fi

# ===============================
# 5. THE PROMPT (ZSH)
# ===============================
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{242}on %F{214} %b%f '

PROMPT='%F{242}┌──(%F{135}'${CUSTOM_USER}'%F{242}'${KALI_SYM}'%F{81}'${CUSTOM_HOST}'%F{242})─[%F{255}%~%F{242}] ${vcs_info_msg_0_}
%F{242}└─%(?.%F{84}.%F{196})❯%f '

# ===============================
# 6. COMPLETIONS & PLUGINS
# ===============================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Source Plugins if they exist
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# GF Completion (Tomnomnom)
[[ -f /home/nkq-404/go/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/gf-completion.zsh ]] && source /home/nkq-404/go/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/gf-completion.zsh

# ===============================
# 7. ALIASES
# ===============================
alias clear='command clear && show_header'
alias cls='command clear && show_header'
alias reload='source ~/.zshrc'
alias sys-update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
alias root='sudo su'
alias myip='curl ifconfig.me'
alias pingo='ping -c 3'


if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first'
    alias ll='eza -lh'
else
    alias ls='ls --color=auto'
fi

# ===============================
# 8. HISTORY SETTINGS
# ===============================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
