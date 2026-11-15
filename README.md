# Gentoo Plymouth theme

<img width="478" height="358" alt="Gentoo Boot Progress Animation" src="https://github.com/user-attachments/assets/25651f38-0dbc-4089-a317-c4543a7447d5" />


Gentoo-branded adaptation of the Apple Mac Plymouth theme. Includes the boot logo, shutdown frames, black background, progress bar and password dialog.

## Install on Gentoo

Ensure Plymouth is installed and enabled in your boot setup. Extract this archive, open a terminal in the extracted directory, and run:

```bash
unzip gentoo-plymouth.zip

from the same directory run

sudo ./install.sh
```

The installer copies the theme to `/usr/share/plymouth/themes/gentoo-plymouth`, selects it using `plymouth-set-default-theme`, and offers to rebuild the initramfs using Dracut when available.

For noninteractive installation with Dracut rebuild:

```bash
sudo ./install.sh --rebuild
```

For systems using genkernel or another initramfs workflow:

```bash
sudo ./install.sh --no-rebuild
```

Then rebuild your initramfs using your normal Gentoo kernel workflow. The installer does not modify your kernel command line; Plymouth must already be configured to start during boot. To inspect selection: `plymouth-set-default-theme`.


Artwork revision: replaced noisy raster logo with a cleaned, anti-aliased white logo and transparent inner cutout. All boot and shutdown frames updated. Rebuild your initramfs after installing.
