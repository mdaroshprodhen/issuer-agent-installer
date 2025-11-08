#!/usr/bin/env bash
set -euo pipefail

REPO="mdaroshprodhen/issuer-agent"
CLONE_DIR="${HOME}/issuer-agent"

echo "=============================================="
echo "    12ID Issuer Agent Auto Installer"
echo "=============================================="
echo

read -s -p "Enter GitHub Personal Access Token: " GHTOKEN
echo
if [ -z "$GHTOKEN" ]; then
  echo "Token is empty. Exiting."
  exit 1
fi

CLONE_URL="https://${GHTOKEN}@github.com/${REPO}.git"

if [ -d "$CLONE_DIR" ]; then
    echo "Removing old installation directory..."
    rm -rf "$CLONE_DIR"
fi

echo "Cloning repository..."
git clone "$CLONE_URL" "$CLONE_DIR"

cd "$CLONE_DIR"
git remote set-url origin "https://github.com/${REPO}.git"
echo "Token removed from git config."

echo "Installing Docker (if needed)..."
if ! command -v docker >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
    sudo gpg --dearmour -o /usr/share/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

sudo usermod -aG docker "$USER" || true

chmod +x issuer-start.sh

echo "Starting services..."
sudo ./issuer-start.sh

echo
echo "✅ Setup complete!"
echo "URL: http://localhost:7000"
echo "If you were added to docker group: Logout & login again"
