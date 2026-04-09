#!/usr/bin/env bash
set -euo pipefail

echo "[preflight] Checking GitHub auth status..."
gh auth status

echo "[preflight] Verifying API user identity..."
LOGIN=$(gh api user --jq .login)
echo "[preflight] Authenticated as: $LOGIN"

echo "[preflight] Verifying GraphQL session..."
gh api graphql -f query='{ viewer { login } }'

echo "[preflight] Configuring git credential helper..."
gh auth setup-git

echo "[preflight] All checks passed. Authenticated as: $LOGIN"
