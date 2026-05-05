#!/usr/bin/env bash
set -euo pipefail

FORMULA="${1:-vdi-babysitter}"
TAP_DIR="$(cd "$(dirname "$0")" && pwd)"

brew uninstall "$FORMULA" 2>/dev/null || true
brew untap punitlad/tap 2>/dev/null || true
brew tap punitlad/tap "$TAP_DIR"
brew install "punitlad/tap/$FORMULA"

echo ""
echo "==> Smoke test ($FORMULA)"
$HOMEBREW_PREFIX/bin/vdi-babysitter --help
