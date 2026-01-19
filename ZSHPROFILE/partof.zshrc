# --- CUSTOM IDENTITY ---
CUSTOM_USER="USERNAME"
CUSTOM_HOST="HOSTNAME"

# --- ENVIRONMENT & PATHS ---
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.local/bin
export TERM="xterm-256color"

# --- AUTO-UPDATE & HEADER ---
if [[ $- == *i* ]]; then
    UPDATE_FILE="$HOME/.kali_sync"
    TODAY=$(date +%F)
    
    # Modern Palette (Deep Sea & Neon)
    CLR_PRP='\033[38;5;135m' # Purple
    CLR_CYN='\033[38;5;81m'  # Cyan
    CLR_GRN='\033[38;5;84m'  # Green
    CLR_DIM='\033[38;5;244m' # Grey
    CLR_RST='\033[0m'

    center() {
        local width=$(tput cols)
        while IFS= read -r line; do
            printf "%*s\n" $(( (${#line} + width) / 2 )) "$line"
        done
    }

    if [[ ! -f "$UPDATE_FILE" || "$(cat "$UPDATE_FILE")" != "$TODAY" ]]; then
        echo -e "${CLR_CYN}󰚰 Checking Kali Repositories...${CLR_RST}"
        sudo apt update -y >/dev/null 2>&1 && echo "$TODAY" > "$UPDATE_FILE"
    fi

    clear

    echo -e "${CLR_PRP}"
    cat << "EOF" | center
░▀█▀░█▀█░▀█▀░█▀▀░█░░░█▀▀░█▀█░█▀█░█░█░▄▀▄░█░█
░░█░░█░█░░█░░█▀▀░█░░░█▀▀░█░█░█░█░░▀█░█/█░░▀█
░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░▀░░▀░░░░▀
EOF
    echo -e "${CLR_RST}"
    echo -e "${CLR_DIM}ID:${CLR_RST} ${CLR_CYN}${CUSTOM_USER}@${CUSTOM_HOST}${CLR_RST} ${CLR_DIM}│ $(date +'%H:%M:%S')${CLR_RST}"
    echo
fi

# --- THE PROMPT ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{242}on %F{214} %b%f '

PROMPT='%F{242}┌──(%F{135}'${CUSTOM_USER}'%F{242}@%F{81}'${CUSTOM_HOST}'%F{242})─[%F{255}%~%F{242}] ${vcs_info_msg_0_}
%F{242}└─%F{84}❯%f '

# --- PLUGINS ---
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# GF completion
GF_PATH=$(find $GOPATH/pkg/mod/github.com/tomnomnom/gf* -name "gf-completion.zsh" | head -n 1)
[[ -n "$GF_PATH" ]] && source "$GF_PATH"

# --- MODERN ALIASES ---
alias sys-update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
alias rs-net='sudo systemctl restart NetworkManager'

# Enhanced File Listing 
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --git --draw-tree --level=1'
    alias la='eza -a --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -lh'
fi

# Better standard tools
alias cat='batcat --paging=never'
alias grep='rg --color=auto'
alias myip='curl -s https://ifconfig.me'
alias cls='clear'
alias reload='source ~/.zshrc && clear'

# --- HISTORY ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
