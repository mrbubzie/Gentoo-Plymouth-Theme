#!/usr/bin/env bash
set -Eeuo pipefail
THEME=gentoo-plymouth
SOURCE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
THEME_DIR="$SOURCE_DIR/$THEME"
DEST="/usr/share/plymouth/themes/$THEME"
REBUILD=ask
for arg in "$@"; do
  case "$arg" in
    --rebuild) REBUILD=yes ;;
    --no-rebuild) REBUILD=no ;;
    --help|-h) echo "Usage: sudo ./install.sh [--rebuild|--no-rebuild]"; exit 0 ;;
    *) echo "Unknown argument: $arg" >&2; exit 2 ;;
  esac
done
[[ $EUID -eq 0 ]] || { echo "Run as root: sudo ./install.sh" >&2; exit 1; }
[[ -f "$THEME_DIR/$THEME.plymouth" && -f "$THEME_DIR/$THEME.script" ]] || { echo "Theme files missing in $THEME_DIR" >&2; exit 1; }
command -v plymouth-set-default-theme >/dev/null || { echo "Plymouth is not installed. Install sys-boot/plymouth first." >&2; exit 1; }
install -d -m 755 "$DEST"
cp -a "$THEME_DIR/." "$DEST/"
chmod -R a+rX "$DEST"
plymouth-set-default-theme "$THEME"
echo "Installed and selected $THEME."
if [[ "$REBUILD" == ask ]]; then
  if [[ -t 0 ]]; then
    read -r -p "Rebuild initramfs now (needed to show theme at boot)? [y/N] " answer
    [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]] && REBUILD=yes || REBUILD=no
  else REBUILD=no; fi
fi
if [[ "$REBUILD" == yes ]]; then
  if command -v dracut >/dev/null 2>&1; then
    echo "Rebuilding initramfs using dracut..."
    dracut --force
  else
    echo "No supported automatic initramfs builder detected." >&2
    echo "Rebuild your initramfs with your configured tool (e.g. genkernel or custom kernel install workflow)." >&2
    exit 1
  fi
else
  echo "IMPORTANT: Rebuild your initramfs with your existing tool before rebooting."
  echo "For dracut-based systems: sudo dracut --force"
fi
