# 🚀 Fullstack Developer Environment (Ubuntu)

A modern, fast, keyboard-driven fullstack development environment for Ubuntu.

This setup uses:

- Zsh
- Starship
- Alacritty
- Tmux
- Neovim with LazyVim / Triforce Nvim
- Lazygit
- Git bare repository dotfiles management

---

## 📦 Stack

| Category    | Tool                     | Notes                                    |
| ----------- | ------------------------ | ---------------------------------------- |
| Shell       | Zsh                      | Autosuggestions + syntax highlighting    |
| Prompt      | Starship                 | Tokyo Night preset                       |
| Terminal    | Alacritty                | GPU-accelerated terminal                 |
| Multiplexer | Tmux                     | Catppuccin-style status, session restore |
| Editor      | Neovim                   | Triforce Nvim based on LazyVim           |
| Git UI      | Lazygit                  | Fast terminal Git interface              |
| Font        | JetBrains Mono Nerd Font | Required for icons                       |
| Dotfiles    | Git bare repository      | No symlinks, no extra tools              |

---

## 💻 Installation on a New Machine

### 1. Install base dependencies

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
  build-essential \
  curl \
  git \
  ripgrep \
  fd-find \
  fzf \
  imagemagick \
  luarocks \
  wl-clipboard \
  xclip \
  xsel \
  software-properties-common \
  apt-transport-https \
  bat \
  unzip \
  zsh \
  tmux \
  xdg-utils
```

Create local bin symlinks for Ubuntu package names:

```bash
mkdir -p ~/.local/bin
ln -s "$(which fdfind)" ~/.local/bin/fd
ln -s "$(which batcat)" ~/.local/bin/bat
```

Install Nerd Font:

```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
rm JetBrainsMono.zip
```

Install latest Neovim:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

Install Node.js:

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g neovim
```

Install Lazygit:

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\Kv*[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
```

Install Zsh plugins and Starship:

```bash
sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting
curl -sS https://starship.rs/install.sh | sh
```

Install Alacritty:

```bash
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt update
sudo apt install -y alacritty
```

Install Tmux Plugin Manager:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

---

## 📥 Deploy Dotfiles

Clone the bare dotfiles repository:

```bash
git clone --bare git@github.com:YOUR_USERNAME/dotfiles.git $HOME/.cfg
```

Create a temporary config function:

```bash
function config {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}
```

Backup existing files if needed and checkout:

```bash
mkdir -p .config-backup
config checkout

if [ $? = 0 ]; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files."
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi

config checkout
config config --local status.showUntrackedFiles no
```

Add the config alias to your shell:

```bash
echo "alias config='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> ~/.zshrc
```

Set Zsh as default shell:

```bash
chsh -s "$(command -v zsh)"
```

Log out and log back in.

---

## 🧰 Post-Installation Setup

### Tmux plugins

Start Tmux:

```bash
tmux
```

Install plugins:

```text
Ctrl-a then Shift+i
```

### Neovim plugins and LSP

Open Neovim:

```bash
nvim
```

LazyVim will install plugins.

After installation, restart Neovim and install language tools if needed:

```vim
:Mason
```

or:

```vim
:MasonInstallAll
```

---

## ⌨️ How to Use

### Zsh aliases

| Command | Action                             |
| ------- | ---------------------------------- |
| `v`     | Open Neovim                        |
| `g`     | Open Lazygit                       |
| `ta`    | Attach to Tmux or create a session |
| `ll`    | List files                         |
| `c`     | Clear screen                       |

---

## 🧵 Tmux

Default prefix:

```text
Ctrl-a
```

### Core Tmux shortcuts

| Shortcut     | Action                            |
| ------------ | --------------------------------- |
| `Ctrl-a r`   | Reload Tmux config                |
| `Ctrl-a \|`  | Split vertically                  |
| `Ctrl-a -`   | Split horizontally                |
| `Ctrl-a h`   | Move to left pane                 |
| `Ctrl-a j`   | Move to bottom pane               |
| `Ctrl-a k`   | Move to top pane                  |
| `Ctrl-a l`   | Move to right pane                |
| `Ctrl-a H`   | Resize pane left                  |
| `Ctrl-a J`   | Resize pane down                  |
| `Ctrl-a K`   | Resize pane up                    |
| `Ctrl-a L`   | Resize pane right                 |
| `Ctrl-a c`   | New window                        |
| `Ctrl-a ,`   | Rename window and make it sticky  |
| `Ctrl-a N`   | Rename window and make it sticky  |
| `Ctrl-a A`   | Return window to automatic naming |
| `Ctrl-a (`   | Move window left                  |
| `Ctrl-a )`   | Move window right                 |
| `Ctrl-a Tab` | Go to last window                 |
| `Ctrl-a s`   | Session picker                    |
| `Ctrl-a S`   | Create or attach named session    |
| `Ctrl-a q`   | Kill pane                         |
| `Ctrl-a Q`   | Kill window                       |
| `Ctrl-a X`   | Kill session                      |

### Clearing the terminal

Normal clear:

```text
Ctrl+l
```

Clear Tmux scrollback/history:

```text
Ctrl-a Ctrl+l
```

### Window names

Window names are automatic:

- When inside Zsh, the window name shows the current directory.
- When running an app like Neovim, Node, npm, or Git, the window name shows the app name.

Example:

```text
1:backend
2:nvim
3:node
```

Manual rename:

```text
Ctrl-a ,
```

or:

```text
Ctrl-a N
```

Return to automatic naming:

```text
Ctrl-a A
```

The active window is highlighted with a blue background.

---

## 📋 Tmux copy mode

Enter copy mode:

```text
Ctrl-a Escape
```

Vi-style keys:

| Key      | Action          |
| -------- | --------------- |
| `v`      | Start selection |
| `Ctrl-v` | Block selection |
| `y`      | Copy selection  |
| `/`      | Search          |
| `q`      | Quit copy mode  |

Copy goes to system clipboard using:

- `wl-copy` on Wayland
- `xclip` on X11

---

## 📝 Neovim

Leader key:

```text
Space
```

Common shortcuts:

| Shortcut    | Action               |
| ----------- | -------------------- |
| `Space e`   | Toggle file explorer |
| `Space f f` | Find files           |
| `Space f g` | Live grep            |
| `Space c r` | Rename symbol        |
| `Space c a` | Code action          |
| `g d`       | Go to definition     |
| `Space c m` | Mason installer      |
| `:qa`       | Quit Neovim          |

---

## 🐙 Lazygit

Open with:

```bash
g
```

Common keys:

| Key       | Action        |
| --------- | ------------- |
| `Space`   | Stage/unstage |
| `c`       | Commit        |
| `p`       | Pull          |
| `P`       | Push          |
| `[` / `]` | Switch panels |
| `?`       | Help          |

---

## 📁 Dotfiles Management

This repository uses a Git bare repository.

The alias is:

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

### Add changed files

```bash
config add ~/.zshrc
config add ~/.tmux.conf
config add ~/.tmux/local.conf
config add ~/.tmux/scripts/is-vim.sh
config add ~/.config/starship.toml
config add ~/.config/alacritty
config add ~/.config/nvim
config add ~/README.md
```

Do **not** commit:

```bash
~/.tmux/plugins
```

### Commit and push

```bash
config commit -m "Update dotfiles"
config push
```

### Pull on another machine

```bash
config pull
```

---

## 🧠 Notes

- Tmux uses Zsh by default.
- Direct `Ctrl+l` clears the shell screen.
- `Ctrl-a Ctrl+l` clears Tmux scrollback.
- Active Tmux window is highlighted.
- Window names update automatically.
- Manual window renames stay fixed until automatic mode is re-enabled.
