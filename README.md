# Linux Kernel Check

**kernelcheck** is a simple command-line tool for Arch Linux (and other Linux distributions) that shows your current Linux kernel version. It also provides an optional "full" mode to display detailed kernel information.

---

## Features

- Display your current Linux kernel version.
- Optional full info mode: `kernelcheck full`.
- Easy installation with a ready-to-use installer.
- Update your installation by re-running the installer.

---

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/lfisbeck650-cloud/Linux-Kernel-check.git ~/kernelcheck
cd ~/kernelcheck
chmod +x install_kernelcheck.sh
./install_kernelcheck.sh
=======
# kernelcheck

`kernelcheck` is a small, polished command-line utility for Linux systems. It shows the currently running kernel version in a clean, predictable format and provides a `full` mode for a more detailed `uname` output.

## Features

- Simple current-kernel output
- Optional detailed mode with `kernelcheck full`
- No runtime dependencies beyond a POSIX-compatible shell and `uname`
- Debian package available for straightforward installation on Debian, Ubuntu, and derivatives

## Installation

### Debian / Ubuntu / Debian-based systems

Install the package directly:

```bash
sudo apt install ./kernelcheck_1.0.0-1_all.deb
```

Or use `dpkg`:

```bash
sudo dpkg -i ./kernelcheck_1.0.0-1_all.deb
sudo apt-get -f install -y
```
