#!/usr/bin/env bash
#
# UNIFINDER-X
#

set -uo pipefail

# ===================== CONFIG =====================
CONCURRENCY=50
GO_BIN="$HOME/go/bin"
export PATH="$PATH:$GO_BIN"
MODE="all"
SESSION_DIR=""
TARGET=""
LIST=""

# ===================== UI =====================
C_OK=$'\e[32m'
C_ACT=$'\e[34m'
C_ERR=$'\e[31m'
C_DIM=$'\e[2m'
C_RST=$'\e[0m'

log() { echo -e "${C_ACT}[*]${C_RST} $1"; }
ok()  { echo -e "${C_OK}[+]${C_RST} $1"; }
err() { echo -e "${C_ERR}[!]${C_RST} $1"; exit 1; }

header() {
    echo -e "${C_ACT}UNIFINDER-X${C_RST} ${C_DIM}v1.1 ${C_RST}"
    echo -e "${C_DIM}------------------------------------------------------${C_RST}"
}

# ===================== HELP =====================
usage() {
    header
    echo "Usage:"
    echo "  $0 --setup                 Install all required Go tools"
    echo "  $0 -u <url>                Scan a single target"
    echo "  $0 -l <file>               Scan a list of targets"
    echo "  $0 -o <dir>                Specify output directory (bypasses prompt)"
    echo ""
    echo "Modes (Optional):"
    echo "  --urls-only, --js-only, --api-only, --json-only, --params-only, --secrets-only"
    echo ""
    echo "Example:"
    echo "  $0 -u https://example.com -o my_recon --js-only"
    exit 0
}

# ===================== SETUP =====================
setup() {
    header
    log "Checking/Installing dependencies..."
    mkdir -p "$GO_BIN"
    declare -A TOOLS=(
        [waybackurls]="github.com/tomnomnom/waybackurls@latest"
        [gau]="github.com/lc/gau/v2/cmd/gau@latest"
        [httpx]="github.com/projectdiscovery/httpx/cmd/httpx@latest"
        [katana]="github.com/projectdiscovery/katana/cmd/katana@latest"
        [subjs]="github.com/lc/subjs@latest"
        [anew]="github.com/tomnomnom/anew@latest"
        [mantra]="github.com/Brosck/mantra@latest"
    )

    for tool in "${!TOOLS[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            log "Installing $tool..."
            go install "${TOOLS[$tool]}" &>/dev/null
        fi
    done
    ok "All tools are ready."
    exit 0
}

# ===================== SCAN CORE =====================
safe_grep() {
    local pattern=$1
    local input=$2
    local output=$3
    if [[ -s "$input" ]]; then
        grep -Ei "$pattern" "$input" | anew "$output" &>/dev/null || true
    fi
}

scan() {
    local TARGET=$1
    local SAFE=$(echo "$TARGET" | sed 's#https\?://##;s#[/:]#_#g')
    local OUT="$SESSION_DIR/$SAFE"
    mkdir -p "$OUT"

    log "Starting Recon: $TARGET"
    
    URLS="$OUT/urls.txt"
    JS="$OUT/js.txt"

    # URL Discovery
    if [[ "$MODE" =~ all|urls ]]; then
        {
            echo "$TARGET" | waybackurls
            echo "$TARGET" | gau --subs --threads "$CONCURRENCY"
            katana -u "$TARGET" -silent -nc
        } | anew "$URLS" &>/dev/null
        
        if [[ -s "$URLS" ]]; then
            httpx -l "$URLS" -silent -mc 200,301,302 -o "$URLS.tmp" &>/dev/null
            [[ -f "$URLS.tmp" ]] && mv "$URLS.tmp" "$URLS"
        fi
    fi

    # Asset Extraction
    safe_grep "\.js($|\?)" "$URLS" "$JS"
    safe_grep "api/|/v[0-9]+/|graphql" "$URLS" "$OUT/api.txt"
    safe_grep "\.json($|\?)|swagger|schema" "$URLS" "$OUT/json.txt"
    safe_grep "\?.*\=" "$URLS" "$OUT/params.txt"

    # Secrets
    if [[ ("$MODE" =~ all|secrets) && -s "$JS" ]]; then
        log "Scanning JS for secrets..."
        mantra -u "$JS" > "$OUT/secrets.txt" 2>/dev/null || true
    fi

    ok "Target $TARGET complete."
}

# ===================== LOGIC START =====================

# 1. Parse Arguments First
[[ $# -eq 0 ]] && usage

while [[ $# -gt 0 ]]; do
    case "$1" in
        --setup) setup ;;
        -h|--help) usage ;;
        -u) TARGET="$2"; shift 2 ;;
        -l|--list) LIST="$2"; shift 2 ;;
        -o|--output) SESSION_DIR="$2"; shift 2 ;;
        --urls-only) MODE="urls"; shift ;;
        --js-only) MODE="js"; shift ;;
        --api-only) MODE="api"; shift ;;
        --json-only) MODE="json"; shift ;;
        --params-only) MODE="params"; shift ;;
        --secrets-only) MODE="secrets"; shift ;;
        *) shift ;;
    esac
done

# 2. Output Directory Prompt (Only if not provided via -o)
if [[ -z "$SESSION_DIR" ]]; then
    header
    read -rp "Enter output folder name: " SESSION_DIR
    [[ -z "$SESSION_DIR" ]] && err "Output directory name is required."
fi
mkdir -p "$SESSION_DIR"

# 3. Final Execution
if [[ -n "$TARGET" ]]; then
    scan "$TARGET"
elif [[ -n "$LIST" ]]; then
    [[ ! -f "$LIST" ]] && err "File $LIST not found."
    while read -r line; do
        [[ -z "$line" ]] && continue
        scan "$line"
    done < "$LIST"
else
    err "No target specified. Use -h for help."
fi

ok "Workflow finished. Results saved in: $SESSION_DIR"
