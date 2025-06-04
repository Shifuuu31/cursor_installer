## 📘Super Easy Guide to Installing Cursor AI on Linux

**For Beginners, Casual Users, and Non-Developers**
No tech jargon. No headaches. Just follow along!

---

### 🚀 What Is This?

This is a **simple one-file script** that installs [**Cursor AI**](https://cursor.so) — an AI-powered code editor based on Visual Studio Code — on your Linux system.
It’s made for **anyone**, even if you’ve never used the terminal much before.

---

### 🧠 What Is Cursor?

**Cursor** is like VS Code, but smarter. It has built-in AI features to:

* Suggest code
* Fix bugs
* Speed up your workflow

Think of it as **VS Code with AI superpowers**. And yes — it’s free.

---

### 💡 What This Script Does

✔️ Downloads the latest **Cursor AppImage**
✔️ Extracts and installs it to your local user folder
✔️ Adds a menu shortcut (like Chrome or LibreOffice)
✔️ Lets you launch it from the terminal using `cursor`
✔️ Shows nice progress steps and uses emojis for clarity

🧘 No need to memorize commands. The script will walk you through everything.

---

### 🛠️ Prerequisites

Before running the script, make sure these tools are installed:

* `curl` – for downloading files
* `update-desktop-database` – to register the app in your menu

Run this based on your Linux distro:

```bash
# Ubuntu, Debian, Linux Mint
sudo apt install curl desktop-file-utils

# Arch, Manjaro
sudo pacman -S curl desktop-file-utils

# Fedora
sudo dnf install curl desktop-file-utils
```

---

### 📦 How to Install Cursor AI

1. **Download the install script** or copy it into a new file called `install.sh`
2. Open your **Terminal**
3. Run the following:

```bash
chmod +x install.sh    # Makes the script executable
./install.sh           # Runs the installer
```

---

### 💬 What Happens During Install

* If Cursor is already installed, you’ll be asked if you want to **update it**
* You’ll be asked if you want to create a `cursor` shortcut in the terminal
* Everything is explained step-by-step, with emojis and clear progress messages ✅

---

### ✅ After Installation

You can now open Cursor in **three ways**:

1. Search for **"Cursor AI IDE"** in your Applications menu
2. Run it directly:

```bash
~/.local/share/cursor/squashfs-root/AppRun
```

3. Or just type:

```bash
cursor
```

*(This only works if you chose the alias option during install)*

---

### 📁 Where Cursor Gets Installed

* App directory: `~/.local/share/cursor`
* Desktop shortcut: `~/.local/share/applications/cursor-ai.desktop`
* App icon: `~/.local/share/cursor/squashfs-root/co.anysphere.cursor.png`

✅ No system-wide changes
❌ No root access needed
🧼 Keeps your system clean

---

### 🧹 How to Uninstall

Want to remove Cursor? No problem.

Run this in your terminal:

```bash
chmod +x uninstall.sh    # Makes the script executable
./uninstall.sh 
```

---

### 👀 What You’ll See During Install

Here’s an example:

```bash
📦 Installing Cursor AI IDE

📦 Downloading Cursor AppImage
✔ Download completed.

📦 Extracting AppImage
✔ Extraction complete.
✔ Removed temporary AppImage.

📦 Creating desktop launcher
✔ Alias added to ~/.zshrc
➤ Restart terminal or run: source ~/.zshrc

🎉 Cursor AI IDE installed successfully!
• Launch from Applications menu
• Or run: ~/.local/share/cursor/squashfs-root/AppRun
• Or just type: cursor
```

---

### 👤 Author

* Made with ❤️ by **Shifuuu**
* Feel free to fork, reuse, or contribute ideas!
* Check it out for the latest updates and how you can help improve the project! [link](https://github.com/Shifuuu31/cursor_installer)!

---



### 📄 License

MIT License — free to use, share, and modify.
