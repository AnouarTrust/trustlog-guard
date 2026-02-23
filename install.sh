#!/bin/bash
# TrustLog Guard — Install Script
# Financial governance for OpenClaw agents
# https://github.com/AnouarTrust/trustlog-guard

set -e

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

echo ""
echo -e "${YELLOW}🛡️  TrustLog Guard — Installer${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Detect OpenClaw workspace
SKILL_DIR=""
if [ -d "$HOME/.openclaw/workspace/skills" ]; then
    SKILL_DIR="$HOME/.openclaw/workspace/skills/trustlog-guard"
elif [ -d "$HOME/.config/openclaw/workspace/skills" ]; then
    SKILL_DIR="$HOME/.config/openclaw/workspace/skills/trustlog-guard"
else
    # Default path
    SKILL_DIR="$HOME/.openclaw/workspace/skills/trustlog-guard"
fi

echo -e "  📁 Installing to: ${BOLD}$SKILL_DIR${NC}"
echo ""

# Create directory
mkdir -p "$SKILL_DIR"

# Download SKILL.md
echo -e "  ⬇️  Downloading SKILL.md..."
if command -v curl &> /dev/null; then
    curl -sL "https://raw.githubusercontent.com/AnouarTrust/trustlog-guard/main/SKILL.md" -o "$SKILL_DIR/SKILL.md"
elif command -v wget &> /dev/null; then
    wget -q "https://raw.githubusercontent.com/AnouarTrust/trustlog-guard/main/SKILL.md" -O "$SKILL_DIR/SKILL.md"
else
    echo -e "  ${RED}✗ Error: curl or wget required${NC}"
    exit 1
fi

# Verify
if [ -f "$SKILL_DIR/SKILL.md" ]; then
    echo -e "  ${GREEN}✓ Installed successfully!${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${BOLD}You're all set. Open OpenClaw and try:${NC}"
    echo ""
    echo -e "  ${YELLOW}/spend${NC}          → See where your money goes"
    echo -e "  ${YELLOW}/budget set daily \$5${NC} → Set a spending limit"
    echo -e "  ${YELLOW}/trustlog${NC}        → Full financial report"
    echo ""
    echo -e "  ${BLUE}GitHub:${NC}  github.com/AnouarTrust/trustlog-guard"
    echo -e "  ${BLUE}Star ⭐ if it saves you money!${NC}"
    echo ""
else
    echo -e "  ${RED}✗ Installation failed. Try manual install:${NC}"
    echo ""
    echo "  mkdir -p $SKILL_DIR"
    echo "  curl -o $SKILL_DIR/SKILL.md \\"
    echo "    https://raw.githubusercontent.com/AnouarTrust/trustlog-guard/main/SKILL.md"
    echo ""
    exit 1
fi
