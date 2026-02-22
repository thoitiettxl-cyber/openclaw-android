#!/usr/bin/env bash
# update.sh - Thin wrapper that downloads and runs update-core.sh
# Usage: curl -sL https://raw.githubusercontent.com/AidanPark/openclaw-android/main/update.sh | bash
#   or:  oaupdate  (after initial install)
set -euo pipefail

RED='\033[0;31m'
NC='\033[0m'

REPO_BASE="https://raw.githubusercontent.com/AidanPark/openclaw-android/main"

# Ensure curl is available
if ! command -v curl &>/dev/null; then
    echo -e "${RED}[FAIL]${NC} curl not found. Install it with: pkg install curl"
    exit 1
fi

# Download and execute update-core.sh
TMPFILE=$(mktemp "${PREFIX:-/tmp}/tmp/update-core.XXXXXX.sh" 2>/dev/null) || TMPFILE=$(mktemp /tmp/update-core.XXXXXX.sh)
if curl -sfL "$REPO_BASE/update-core.sh" -o "$TMPFILE"; then
    bash "$TMPFILE"
    rm -f "$TMPFILE"
else
    echo -e "${RED}[FAIL]${NC} Failed to download update-core.sh"
    rm -f "$TMPFILE"
    exit 1
fi
