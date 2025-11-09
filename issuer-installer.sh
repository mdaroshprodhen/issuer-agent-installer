#!/bin/bash
set -e

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Enter your GitHub Personal Access Token (with repo access):"
    read -r -s GITHUB_TOKEN
fi

PRIVATE_REPO="mdaroshprodhen/issuer-agent"
CLONE_DIR="$HOME/issuer-agent"

echo "Cloning private repository..."
rm -rf "$CLONE_DIR"
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/${PRIVATE_REPO}.git "$CLONE_DIR"

cd "$CLONE_DIR"
chmod +x issuer-start.sh
./issuer-start.sh

