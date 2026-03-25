#!/bin/bash

# Colors for better UI
SUCCESS="\e[32m"
INFO="\e[34m"
WARNING="\e[33m"
ERROR="\e[31m"
RESET="\e[0m"

# Variables
DOWNLOAD_URL="https://telegram.org/dl/desktop/linux"
INSTALL_DIR="/opt/telegram"
BIN_LINK="/usr/local/bin/telegram"
DESKTOP_FILE="/usr/share/applications/telegram.desktop"

echo -e "${INFO}🚀 Starting Telegram Desktop installation...${RESET}"

# 1. Clean up previous installation if it exists
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${WARNING}Removing old version at $INSTALL_DIR...${RESET}"
    sudo rm -rf "$INSTALL_DIR"
fi

# 2. Download with progress bar
echo -e "${INFO}📥 Downloading latest Telegram...${RESET}"
wget -q --show-progress -O /tmp/telegram.tar.xz "$DOWNLOAD_URL"

if [ $? -ne 0 ]; then
    echo -e "${ERROR}❌ Download failed! Check your internet connection.${RESET}"
    exit 1
fi

# 3. Extract and Move
echo -e "${INFO}📦 Extracting files...${RESET}"
tar -xf /tmp/telegram.tar.xz -C /tmp
sudo mv /tmp/Telegram "$INSTALL_DIR"

# 4. Create Symlink (using /usr/local/bin is cleaner for manual installs)
echo -e "${INFO}🔗 Creating symbolic link...${RESET}"
sudo ln -sf "$INSTALL_DIR/Telegram" "$BIN_LINK"

# 5. Create Desktop Entry (The "Update" it really needed)
echo -e "${INFO}🖥️ Adding to application menu...${RESET}"
cat <<EOF | sudo tee "$DESKTOP_FILE" > /dev/null
[Desktop Entry]
Name=Telegram Desktop
Comment=Official desktop version of Telegram messaging app
Exec=$INSTALL_DIR/Telegram -- %u
Icon=telegram
Terminal=false
Type=Application
Categories=Network;InstantMessaging;Qt;
MimeType=x-scheme-handler/tg;
Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
EOF

# 6. Cleanup & Launch
rm /tmp/telegram.tar.xz
echo -e "${SUCCESS}✅ Installation complete!${RESET}"
echo -e "${INFO}You can now find Telegram in your app menu or type 'telegram' in the terminal.${RESET}"

# Launch as current user (not root)
nohup telegram >/dev/null 2>&1 &
