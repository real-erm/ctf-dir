#!/usr/bin/env bash
set -euo pipefail

REPO_OWNER="real-erm"
REPO_NAME="ctf-dir"
RAW_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/main/ctf-dir"
DEFAULT_INSTALL_DIR="${HOME}/.local/bin"
TARGET_BIN="${DEFAULT_INSTALL_DIR}/ctf-dir"

print_banner() {
    echo "=================================================="
    echo "            ctf-dir Installer                    "
    echo "=================================================="
}

uninstall_tool() {
    print_banner
    echo "[*] Uninstalling ctf-dir..."
    if [[ -f "$TARGET_BIN" || -L "$TARGET_BIN" ]]; then
        rm -f "$TARGET_BIN"
        echo "[+] Successfully removed ${TARGET_BIN}"
    else
        echo "[-] ctf-dir is not installed at ${TARGET_BIN}"
    fi
    exit 0
}

# Handle uninstall flag
if [[ "${1:-}" == "--uninstall" || "${1:-}" == "-u" ]]; then
    uninstall_tool
fi

print_banner
echo "[*] Target installation path: ${TARGET_BIN}"

# Ensure ~/.local/bin exists
mkdir -p "${DEFAULT_INSTALL_DIR}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || true)"

if [[ -n "${SCRIPT_DIR}" && -f "${SCRIPT_DIR}/ctf-dir" ]]; then
    echo "[*] Installing from local repository..."
    cp "${SCRIPT_DIR}/ctf-dir" "${TARGET_BIN}"
else
    echo "[*] Downloading ctf-dir from GitHub (${RAW_URL})..."
    if command -v curl &>/dev/null; then
        curl -fsSL "${RAW_URL}" -o "${TARGET_BIN}"
    elif command -v wget &>/dev/null; then
        wget -qO "${TARGET_BIN}" "${RAW_URL}"
    else
        echo "[!] Error: Neither curl nor wget was found. Cannot download ctf-dir." >&2
        exit 1
    fi
fi

chmod +x "${TARGET_BIN}"
echo "[+] Successfully installed ctf-dir to ${TARGET_BIN}!"

# Check PATH
case ":${PATH}:" in
    *:"${DEFAULT_INSTALL_DIR}":*)
        echo "[+] ${DEFAULT_INSTALL_DIR} is already in your PATH."
        ;;
    *)
        echo ""
        echo "[!] Warning: ${DEFAULT_INSTALL_DIR} is NOT in your PATH."
        echo "    Add it to your shell configuration file (~/.bashrc, ~/.zshrc, or ~/.config/fish/config.fish):"
        echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo ""
        ;;
esac

# Check recommended optional tools
echo ""
echo "[*] Checking recommended tools for archive extraction & editor integration:"
for cmd in unzip 7z tar codium; do
    if command -v "$cmd" &>/dev/null; then
        echo "  [✓] $cmd is installed"
    else
        echo "  [i] $cmd is optional (install for full format / -vs support)"
    fi
done

echo ""
echo "Done! Run 'ctf-dir -h' or 'ctf-dir' to get started."
