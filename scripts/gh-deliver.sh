#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:?Usage: gh-deliver.sh <repo-name>}"

# Prevent shell injection via repo name
if [[ ! "$REPO_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "[deliver] ERROR: Invalid repo name: $REPO_NAME"
  exit 1
fi

WORKSPACE="/home/clawvis/.openclaw/workspace/$REPO_NAME"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPTS_DIR/../templates"

if [ ! -d "$WORKSPACE" ]; then
  echo "[deliver] ERROR: Workspace not found: $WORKSPACE"
  exit 1
fi

cd "$WORKSPACE"

# Copy SFTP deploy workflow into the clone repo before committing
mkdir -p .github/workflows
cp "$TEMPLATES_DIR/sftp-deploy.yml" .github/workflows/sftp-deploy.yml
echo "[deliver] Copied sftp-deploy.yml into .github/workflows/"

echo "[deliver] Initializing git repository..."
git init -b main
git add .
git commit -m "Initial clone output"

echo "[deliver] Creating private GitHub repo and pushing..."
gh repo create "clawvisx/$REPO_NAME" --private --source=. --remote=origin --push

echo "[deliver] Adding collaborators..."
gh api -X PUT "repos/clawvisx/$REPO_NAME/collaborators/mikeascendx" -f permission=push
gh api -X PUT "repos/clawvisx/$REPO_NAME/collaborators/KIshiharaHCI" -f permission=push

echo "[deliver] Setting IONOS FTP secrets..."
gh secret set FTP_SERVER   --repo "clawvisx/$REPO_NAME" --body "${FTP_SERVER:-}"
gh secret set FTP_USERNAME --repo "clawvisx/$REPO_NAME" --body "${FTP_USERNAME:-}"
gh secret set FTP_PASSWORD --repo "clawvisx/$REPO_NAME" --body "${FTP_PASSWORD:-}"

echo "[deliver] Delivery complete."
echo "REPO_URL=https://github.com/clawvisx/$REPO_NAME"
