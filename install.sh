#!/bin/bash
#
# Quick Agent — One-line installer
# Usage: curl -fsSL https://raw.githubusercontent.com/uburuntu/quick-agent/main/install.sh | bash
#

set -e

REPO="uburuntu/quick-agent"
BINARY_NAME="quick-agent"
INSTALL_DIR=""

echo ""
echo "  Installing Quick Agent..."
echo ""

# Determine install location (prefer writable dir, no sudo needed)
if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
elif mkdir -p "$HOME/.local/bin" 2>/dev/null && [ -w "$HOME/.local/bin" ]; then
    INSTALL_DIR="$HOME/.local/bin"
else
    echo "  Error: Cannot write to /usr/local/bin or ~/.local/bin"
    echo ""
    echo "  Try running with sudo:"
    echo "    curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh | sudo bash"
    echo ""
    exit 1
fi

# Download the quick-agent binary
curl -fsSL "https://raw.githubusercontent.com/${REPO}/main/${BINARY_NAME}" \
    -o "${INSTALL_DIR}/${BINARY_NAME}"
chmod +x "${INSTALL_DIR}/${BINARY_NAME}"

# Ensure install dir is in PATH
case ":$PATH:" in
    *":${INSTALL_DIR}:"*) ;;
    *)
        echo "  Note: ${INSTALL_DIR} is not in your PATH."
        echo "  Add this to your shell profile (~/.zshrc or ~/.bashrc):"
        echo ""
        echo "    export PATH=\"${INSTALL_DIR}:\$PATH\""
        echo ""
        export PATH="${INSTALL_DIR}:$PATH"
        ;;
esac

# Run the interactive install
exec "${INSTALL_DIR}/${BINARY_NAME}" install
