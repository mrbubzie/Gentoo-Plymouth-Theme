# Gentoo Plymouth — Vector Logo Fix

The logo is now rendered from a clean SVG path, not generated raster artwork. All seven PNGs have smooth antialiased edges, a transparent background and a visible transparent center.

Install: `sudo ./install.sh --rebuild` (requires Dracut). For manual initramfs workflows, use `sudo ./install.sh --no-rebuild` and rebuild the correct boot image yourself.

If the old logo still appears, confirm which initramfs your bootloader loads and rebuild that image.
