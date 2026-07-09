# 🚀 Fedora System Setup & Dotfiles

A fully automated, modular provisioning repository for setting up a complete Linux development environment and window manager configuration.

> [!WARNING]  
> **Fedora Linux Only!** > These scripts rely heavily on the `dnf` package manager and Fedora-specific system configurations. Running this on Debian/Ubuntu, Arch, or macOS will fail and could potentially damage your system environment.

---

## 📂 Repository Structure

This repository separates the **Installer** from the **Payload**, keeping things perfectly clean:

* **`dotfiles/`**: The pure configuration payload. Folders inside here (like `.config/` or `wallpaper/`) are symlinked directly to your home directory using GNU Stow.
* **`scripts/`**: Modular Bash scripts for installing dependencies, setting up SSH, and configuring tools (Rust, Conda, FPGA toolchains, etc.).
* **`Makefile`**: The control panel used to trigger installations and manage dotfiles.

---

## 🛠️ Getting Started

To get started on a fresh Fedora installation, you only need to install `git` and clone this repository.

### 1. Install Git
Open your terminal and install Git using `dnf`:
```bash
sudo dnf update -y
sudo dnf install git -y
```


### 2. Clone the Repository
Clone this repository to your home directory:
```bash
git clone
cd ~/system_setup
```

### 3. Run the Installer
Run the installer script to set up your system:
```bash
make install
```

### 4. Testing the installation scripts
You quickly fire up a podman container to test the installation scripts without affecting your host system. This is especially useful for testing new scripts or configurations. Just run the following command:
```bash
make test
```
