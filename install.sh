#!/bin/bash

# Cursor AI Installer Script - Enhanced UX + Icon Fix
# https://cursor.so

# =========================
#      Style Settings
# =========================
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
RESET='\033[0m'
CHECK="${GREEN}✔${RESET}"
CROSS="${RED}✖${RESET}"

# =========================
#     Spinner Function
# =========================
spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local i=0
  tput civis  # Hide cursor
  while kill -0 "$pid" 2>/dev/null; do
    i=$(( (i+1) % 10 ))
    printf "\r  ${BLUE}↻ ${spinstr:$i:1} $SPINNER_MSG...${RESET}"
    sleep "$delay"
  done
  tput cnorm  # Show cursor
  printf "\r  ${GREEN}✔ $SPINNER_MSG completed.${RESET}\n"
}

# =========================
#     Function Helpers
# =========================
step()          { echo -e "\n${BLUE}${BOLD}📦 $*${RESET}"; }
echo_info()     { echo -e "${BLUE}${BOLD}➤ $*${RESET}"; }
echo_success()  { echo -e "$CHECK $*"; }
echo_error()    { echo -e "$CROSS $*" >&2; }

# =========================
#     Setup Variables
# =========================
INSTALL_DIR="$HOME/.local/share/cursor"
APPIMAGE_NAME="cursor.AppImage"
APPIMAGE_URL="https://downloads.cursor.com/production/8ea935e79a50a02da912a034bbeda84a6d3d355d/linux/x64/Cursor-0.50.4-x86_64.AppImage"
DESKTOP_FILE="$HOME/.local/share/applications/cursor-ai.desktop"
APP_RUN_PATH="$INSTALL_DIR/squashfs-root/AppRun"
ICON_PATH="$INSTALL_DIR/squashfs-root/co.anysphere.cursor.png"

# =========================
#   Check Dependencies
# =========================
REQUIRED_CMDS=("curl" "update-desktop-database")
for cmd in "${REQUIRED_CMDS[@]}"; do
  if ! command -v "$cmd" &>/dev/null; then
    echo_error "Required command '$cmd' not found. Please install it before continuing."
    exit 1
  fi
done

# =========================
#   Already Installed?
# =========================
if [[ -f "$APP_RUN_PATH" ]]; then
  echo_info "Cursor AI is already installed at:"
  echo -e "  ${BOLD}$APP_RUN_PATH${RESET}"
  echo_info "Do you want to re-install or update it? [y/N]"
  read -r REINSTALL
  [[ ! "$REINSTALL" =~ ^[Yy]$ ]] && echo_info "Aborted by user." && exit 0
  rm -rf "$INSTALL_DIR"
fi

# =========================
#     Begin Installation
# =========================
step "Installing Cursor AI IDE"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || { echo_error "Cannot access $INSTALL_DIR"; exit 1; }

# Download Cursor AppImage
step "Downloading Cursor AppImage"
SPINNER_MSG="Downloading Cursor"
curl -sSL "$APPIMAGE_URL" -o "$APPIMAGE_NAME" & spinner $!
wait $!

# Make executable and extract silently
chmod +x "$APPIMAGE_NAME"

step "Extracting AppImage"
SPINNER_MSG="Extracting AppImage"
./"$APPIMAGE_NAME" --appimage-extract > /dev/null 2>&1 & spinner $!
wait $!
rm -f "$APPIMAGE_NAME"
echo_success "Removed temporary AppImage."

# =========================
#     Desktop Entry
# =========================
step "Creating desktop launcher"
mkdir -p "$(dirname "$DESKTOP_FILE")"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=Cursor AI IDE
Comment=AI IDE for developers
Exec=$APP_RUN_PATH
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Development;IDE;
EOF

chmod +x "$DESKTOP_FILE"
update-desktop-database "$HOME/.local/share/applications" &>/dev/null

# =========================
#     Add Alias (Optional)
# =========================
echo_info "Would you like to add 'cursor' as a terminal command (like 'code')? [y/N]"
read -r ADD_ALIAS
if [[ "$ADD_ALIAS" =~ ^[Yy]$ ]]; then
  SHELL_RC="$HOME/.bashrc"
  [[ $SHELL =~ "zsh" ]] && SHELL_RC="$HOME/.zshrc"
  echo "alias cursor=\"$APP_RUN_PATH\"" >> "$SHELL_RC"
  echo_success "Alias added to $SHELL_RC"
  echo_info "Restart terminal or run: source $SHELL_RC"
fi

# =========================
#     Final Message
# =========================
echo -e "\n${GREEN}${BOLD}🎉 Cursor AI IDE installed successfully!${RESET}"
echo -e "  • Launch from Applications menu"
echo -e "  • Or run: ${BOLD}$APP_RUN_PATH${RESET}"
[[ "$ADD_ALIAS" =~ ^[Yy]$ ]] && echo -e "  • Or just type: ${BOLD}cursor${RESET}"

exit 0
