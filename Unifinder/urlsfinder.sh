#!/usr/bin/env bash
#
# UNIFINDER-X v4.1
# Unified JS • API • JSON • Endpoint Recon Framework
#

set -euo pipefail

# ===================== CONFIG =====================
CONCURRENCY=50
GO_BIN="$HOME/go/bin"
export PATH="$PATH:$GO_BIN"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SESSION_DIR="unifinder_${TIMESTAMP}"

# ===================== UI =====================
C_OK=$'\e[32m'
C_ACT=$'\e[34m'
C_ERR=$'\e[31m'
C_DIM=$'\e[2m'
C_RST=$'\e[0m'

header() {
    echo -e "\n${C_ACT}UNIFINDER-X${C_RST} ${C_DIM}v4.1 | Unified Recon Engine${C_RST}"
    echo -e "${C_DIM}------------------------------------------------${C_RST}"
}

log() { echo -e "${C_ACT}[*]${C_RST} $1"; }
ok()  { echo -e "${C_OK}[+]${C_RST} $1"; }
err() { echo -e "${C_ERR}[!]${C_RST} $1"; exit 1; }

# ===================== SETUP =====================
setup() {
    log "Initializing environment & dependencies..."

    declare -A TOOLS=(
        [waybackurls]="github.com/tomnomnom/waybackurls@latest"
        [gau]="github.com/lc/gau/v2/cmd/gau@latest"
        [httpx]="github.com/projectdiscovery/httpx/cmd/httpx@latest"
        [katana]="github.com/projectdiscovery/katana/cmd/katana@latest"
        [subjs]="github.com/lc/subjs@latest"
        [getJS]="github.com/003random/getJS@latest"
        [cariddi]="github.com/edoardottt/cariddi/cmd/cariddi@latest"
        [anew]="github.com/tomnomnom/anew@latest"
        [mantra]="github.com/Brosck/mantra@latest"
    )

    for tool in "${!TOOLS[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            echo -ne "  > Installing $tool... "
            go install "${TOOLS[$tool]}" &>/dev/null
            echo "Done"
        fi
    done

    ok "All tools installed."
}

# ===================== SINGLE TARGET RECON =====================
scan_target() {
    local TARGET="$1"
    local SAFE_NAME
    SAFE_NAME=$(echo "$TARGET" | sed 's|https\?://||;s|/||g')

    local BASE="$SESSION_DIR/$SAFE_NAME"
    mkdir -p "$BASE"/{raw,live,api,json,secrets}

    RAW_JS="$BASE/raw/all_js.txt"
    LIVE_JS="$BASE/live/live_js.txt"
    API_OUT="$BASE/api/api_endpoints.txt"
    JSON_OUT="$BASE/json/json_endpoints.txt"
    SECRET_OUT="$BASE/secrets/secrets.txt"

    log "Scanning: $TARGET"

    {
        echo "$TARGET" | waybackurls | grep -Ei "\.js$"
        echo "$TARGET" | gau --subs | grep -Ei "\.js$"
        echo "$TARGET" | subjs
        echo "$TARGET" | getJS --complete
        echo "$TARGET" | cariddi -ext 7 | grep -Ei "\.js$"
        katana -u "$TARGET" -jc -silent | grep -Ei "\.js$"
    } | sort -u > "$RAW_JS"

    ok "Raw JS: $(wc -l < "$RAW_JS")"

    httpx -silent -mc 200 -t "$CONCURRENCY" -l "$RAW_JS" -o "$LIVE_JS"
    ok "Live JS: $(wc -l < "$LIVE_JS")"

    grep -Ei "api/|/v[0-9]+/|graphql|swagger|openapi|rest" \
        "$LIVE_JS" | sort -u > "$API_OUT" || true

    grep -Ei "\.json$|schema|openapi" \
        "$LIVE_JS" | sort -u > "$JSON_OUT" || true

    if command -v mantra &>/dev/null; then
        mantra -u "$LIVE_JS" > "$SECRET_OUT" 2>/dev/null || true
    fi

    ok "Completed: $TARGET"
}

# ===================== ARG HANDLING =====================
usage() {
    echo "Usage:"
    echo "  $0 --setup"
    echo "  $0 -u <url>"
    echo "  $0 -l <file>"
    exit 0
}

[[ $# -eq 0 ]] && usage

mkdir -p "$SESSION_DIR"
header

case "$1" in
    --setup)
        setup
        ;;
    -u)
        [[ -z "${2:-}" ]] && err "URL required"
        scan_target "$2"
        ;;
    -l)
        [[ ! -f "${2:-}" ]] && err "File not found"
        while read -r target; do
            [[ -z "$target" ]] && continue
            scan_target "$target"
        done < "$2"
        ;;
    *)
        usage
        ;;
esac

ok "All recon tasks completed. Output: $SESSION_DIR"
