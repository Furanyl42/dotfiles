[github_readme(1).md](https://github.com/user-attachments/files/33270270/github_readme.1.md)
# 🛠️ Dotfiles

Personal development environment configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/) (or native symlinks).

Includes custom configurations for:
- ⚡ **Neovim** (LazyVim, Neovim ≥ 0.12)
- 🖥️ **tmux**
- 🐱 **Kitty Terminal**

---

## 📋 Directory Structure

```text
dotfiles/
├── nvim/
│   └── .config/nvim/          # Neovim / LazyVim configurations
├── kitty/
│   └── .config/kitty/         # Kitty terminal configurations
└── tmux/
    └── .tmux.conf             # tmux configuration file
```

---

🚀 Quick Start (Automated Setup)

If you want to set up everything automatically—including fetching Neovim (no-sudo AppImage fallback), installing JetBrainsMono Nerd Font, and symlinking all dotfiles—simply run the automated setup script:
Bash

# 1. Clone your dotfiles repository
git clone https://github.com/Furanyl42/dotfiles.git ~/dotfiles

# 2. Make the script executable and run it
cd ~/dotfiles
chmod +x install.sh
./install.sh

    Note for restricted / school computers:

    The script automatically detects if you lack sudo privileges or GNU Stow, falling back to local user installations (~/.local/bin, ~/.local/share/fonts) and manual symlinks (ln -snf).

🛠️ Manual Installation Steps

(If you prefer to set up your environment manually step-by-step, follow the detailed instructions below...)

---

## 🚀 Installation Guide

Choose the option that fits your environment:

- **Option A:** Standard Setup (Root/Sudo Access)
- **Option B:** Restricted Setup (No Sudo / School Computer)

---

### Option A: Standard Setup (With Sudo Access)

#### 1. Install Prerequisites
Ensure `git` and `stow` are installed on the machine:

* **Ubuntu/Debian:**
  ```bash
  sudo apt update && sudo apt install -y git stow build-essential
  ```
* **Arch Linux:**
  ```bash
  sudo pacman -S --needed git stow base-devel
  ```
* **macOS (Homebrew):**
  ```bash
  brew install git stow
  ```

#### 2. Clone Repository
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

#### 3. Apply Configurations with Stow
Remove default/conflicting config files and run Stow:
```bash
# Back up or remove existing configs if necessary
rm -rf ~/.config/nvim ~/.config/kitty ~/.tmux.conf

# Apply symlinks
cd ~/dotfiles
stow nvim kitty tmux
```

---

### Option B: Restricted Setup (No Sudo / School Computers)

If you do not have administrator permissions or `stow` is not installed, you can set up everything using user-level binaries and standard `ln -snf` symlinks.

#### 1. Download Neovim Locally (No Sudo Required)
System package managers often provide outdated versions of Neovim. Download the standalone executable directly to your home folder:

```bash
mkdir -p ~/.local/bin

# Download Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage ~/.local/bin/nvim

# Add ~/.local/bin to your PATH (add to ~/.bashrc or ~/.zshrc)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### 2. Clone Repository
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
```

#### 3. Create Symlinks Manually (`ln -snf`)
You do not need GNU Stow to link your configurations. Use the standard `ln -snf` command:

```bash
mkdir -p ~/.config

# Symlink configurations directly to your dotfiles repo
ln -snf ~/dotfiles/nvim/.config/nvim ~/.config/nvim
ln -snf ~/dotfiles/kitty/.config/kitty ~/.config/kitty
ln -snf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

---

## 🔍 Verification

After setting up (via Stow or `ln`), verify that your symlinks are properly pointing to `~/dotfiles`:

```bash
ls -la ~/.config/nvim
ls -la ~/.config/kitty
ls -la ~/.tmux.conf
```

1. Launch **Neovim** by typing `nvim`. LazyVim will automatically detect your configuration and install all plugins on first startup.
2. Reload **tmux** settings inside an active session:
   ```bash
   tmux source-file ~/.tmux.conf
   ```

---

## 🔄 Daily Workflow & Maintenance

### Saving Changes to GitHub
Since all configurations in `~/.config/` are symlinked to `~/dotfiles`, editing your settings inside Neovim, Kitty, or tmux edits the actual Git repository directly.

To commit and push updates:
```bash
cd ~/dotfiles
git status
git add .
git commit -m "Update keymaps and configuration settings"
git push
```

### Pulling Updates on Another Computer
To sync changes on another machine:
```bash
cd ~/dotfiles
git pull
```

---

## 🛠️ Useful Stow Commands Cheat Sheet

| Command | Description |
| :--- | :--- |
| `stow <package>` | Link configuration package to system |
| `stow -D <package>` | **Unstow / Delete** symlinks for package |
| `stow -R <package>` | **Restow / Refresh** symlinks after structural changes |
| `stow -n -v <package>` | **Dry run** (preview changes without modifying files) |
