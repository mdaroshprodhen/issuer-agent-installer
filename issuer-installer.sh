#!/bin/bash
set -e

# =========================
# 1️⃣ Get GitHub Token
# =========================
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Enter your GitHub Personal Access Token (with repo access):"
    read -r -s GITHUB_TOKEN
fi

# =========================
# 2️⃣ Clone Private Repo Using Token
# =========================
PRIVATE_REPO="mdaroshprodhen/issuer-agent"
CLONE_DIR="$HOME/issuer-agent"

echo "Cloning private repository..."
rm -rf "$CLONE_DIR"
git clone https://$GITHUB_TOKEN@github.com/$PRIVATE_REPO.git "$CLONE_DIR"

# =========================
# 3️⃣ Run issuer-start.sh
# =========================
cd "$CLONE_DIR"
chmod +x issuer-start.sh
./issuer-start.sh

