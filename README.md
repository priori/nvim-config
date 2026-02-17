# Priori Config

## Keymaps

### Global / core

From [init.lua](init.lua) and [lua/custom/keymaps.lua](lua/custom/keymaps.lua):

Normal mode:

- `<C-c>`: clear search highlights
- `<leader>q` / `ZZ`: safe quit (warns on unsaved or terminal buffers)
- `<leader>bd`: delete buffer (warns on unsaved or terminal buffers)
- `<leader>ww`: write (save)
- `<leader>wd`: write + delete buffer
- `<leader>wq`: write + quit
- `<C-u>`, `<C-d>`, `<C-b>`, `<C-f>`: scroll and keep cursor centered
- `<C-S-j>` / `<C-S-k>`: move current line down/up
- `<leader>ww`: write buffer
- `<c-s>` (normal + visual): write buffer

Insert mode:

- `<Esc>`: disabled
- `jj` or `<C-c>`: escape to normal mode
- `<C-h>/<C-j>/<C-k>/<C-l>`: move cursor left/down/up/right
- `<C-S-h>/<C-S-l>`: move by word left/right
- `<C-g>`: backspace
- `<C-;>`: delete

Visual mode:

- `<leader>p`: paste without overwriting register
- `<leader>d`: delete without overwriting register
- `J` / `K`: move selected lines down/up
- `<C-S-j>` / `<C-S-k>`: move selected lines down/up
- `<c-s>`: write buffer

Command-line mode:

- `<C-h>/<C-j>/<C-k>/<C-l>`: move cursor left/down/up/right
- `<C-S-h>/<C-S-l>`: move by word left/right
- `<C-g>`: backspace
- `<C-;>`: delete
- `<c-j>`: move cursor left (from blink.cmp config)
- `<c-k>`: move cursor right (from blink.cmp config)

Terminal mode:

- `<Esc><Esc>` or `<C-c><C-c>`: exit to normal mode
- `<C-h>/<C-j>/<C-k>/<C-l>`: move cursor left/down/up/right
- `<C-g>`: backspace
- `<C-;>`: delete

### Window management

From [lua/custom/winskeymaps.lua](lua/custom/winskeymaps.lua):

- `<leader>wl/wh/wk/wj`: split and focus right/left/up/down
- `<leader>wL/wH/wK/wJ`: copy current window into a split right/left/up/down

### Diagnostics

From [init.lua](init.lua):

- `[d` / `]d`: previous/next diagnostic
- `<leader>ee`, `<leader>de`, `<leader>ce`: open diagnostics float
- `<leader>ef`, `<leader>cf`, `<leader>df`: diagnostics to loclist

### Telescope

From [init.lua](init.lua):

Normal mode:

- `<leader>sh`: help tags
- `<leader>sk`: keymaps
- `<leader>sf`: find files
- `<leader>ss`: picker select
- `<leader>sw`: grep word under cursor (normal/visual)
- `<leader>sg`: live grep
- `<leader>sd`: diagnostics
- `<leader>sr`: resume
- `<leader>s.`: recent files
- `<leader>sc`: commands
- `<leader>sn`: search Neovim config files
- `<leader>/`: fuzzy find in current buffer (dropdown)
- `<leader>s/`: live grep in open files
- `<c-p>`: find files
- `<Tab>`: buffer picker (with modified indicator)

Telescope insert mode mappings:

- `<C-c>`: close
- `<C-j>` / `<C-k>`: next/prev selection
- `<C-h>` / `<C-l>`: move cursor left/right
- `<C-g>`: backspace
- `<C-;>`: delete

Telescope normal mode mappings:

- `d`: delete buffer
- `q` or `<c-C>`: close

### LSP (on attach)

From [init.lua](init.lua) and [lua/custom/lsp.lua](lua/custom/lsp.lua):

- `grr`: references (Telescope)
- `gri`: implementation (Telescope)
- `grd`: definition (Telescope)
- `grt`: type definition (Telescope)
- `gO`: document symbols
- `gW`: workspace symbols
- `gD` or `grD`: declaration
- `K`: hover documentation
- `grn`, `<leader>rn`, `<leader>mv`, `<F2>`: rename
- `gra`: code action (normal/visual)
- `<leader>ca`, `<F3>`: code action (normal/visual)
- `<leader>D`: type definition
- `<leader>ds`: document symbols
- `<leader>ws`: workspace symbols
- `<leader>th`: toggle inlay hints (if supported)

Custom LSP overrides (buffer local):

- `<Enter>`: LSP definitions via Telescope
- `<C-t>`: Jump to prev entry in the tag stack
- `<leader><Enter>`: LSP references via Telescope

### Git / Gitsigns

From [lua/kickstart/plugins/gitsigns.lua](lua/kickstart/plugins/gitsigns.lua):

- `]c` / `[c`: next/prev hunk
- `<leader>hs` / `<leader>hr`: stage/reset hunk (normal and visual)
- `<leader>hS`: stage buffer
- `<leader>hu`: undo stage hunk
- `<leader>hR`: reset buffer
- `<leader>hp`: preview hunk
- `<leader>hb`: blame line
- `<leader>hd` / `<leader>hD`: diff against index / last commit
- `<leader>tb`: toggle current line blame
- `<leader>tD`: toggle inline deleted preview

### Neo-tree

From [lua/kickstart/plugins/neo-tree.lua](lua/kickstart/plugins/neo-tree.lua):

- `<leader>n`: open Neo-tree (float, reveal current file)

Inside Neo-tree filesystem window:

- `<C-c>`: close window
- `<leader>n`: close window

### Harpoon

From [lua/custom/plugins/harpoon.lua](lua/custom/plugins/harpoon.lua):

- `<leader>a`: add current file to Harpoon list (shows list via Noice)
- `<C-g>`: toggle Harpoon quick menu
- `<leader>1..6`: jump to Harpoon slots
- `<leader><Tab>` / `<leader><S-Tab>`: next/prev Harpoon item

Harpoon UI buffer:

- `<Esc>`: no-op
- `<C-c>`: close quick menu

### Flash

From [lua/custom/plugins/flash.lua](lua/custom/plugins/flash.lua):

- `s`: Flash jump (normal/visual/operator)
- `S`: Flash Treesitter (normal/visual/operator)
- `r`: remote flash (operator)
- `R`: Treesitter search (operator/visual)
- `<C-s>` (cmdline): toggle Flash search

### Noice

From [lua/custom/plugins/noice.lua](lua/custom/plugins/noice.lua):

- `<C-c>` (normal): dismiss Noice messages + clear search

In `noice` buffer:

- `<Esc>`: no-op (insert + normal)
- `<C-k>` / `<C-j>`: move up/down (insert)

## Notes and behaviors

- `onedark` is the active colorscheme; `tokyonight` is installed but not loaded.
- `nvim-autopairs` removes automatic pairing for quotes and brackets.
- `nvim-treesitter` starts per filetype via a `FileType` autocmd.
- `blink.cmp` uses the `default` preset, with `<c-j>/<c-k>` for selection and `<cr>` to accept.
- `which-key` groups: `<leader>s` (search), `<leader>t` (toggle), `<leader>h` (git hunk).

## File map

- Main config: [init.lua](init.lua)
- Custom entry: [lua/custom/init.lua](lua/custom/init.lua)
- Keymaps: [lua/custom/keymaps.lua](lua/custom/keymaps.lua)
- Window keymaps: [lua/custom/winskeymaps.lua](lua/custom/winskeymaps.lua)
- LSP custom mappings: [lua/custom/lsp.lua](lua/custom/lsp.lua)
- Plugins: [lua/custom/plugins](lua/custom/plugins)
- GUI font: [ginit.vim](ginit.vim)

## Basics

- Leader key: `<Space>` (global) and `<Space>` (local)
- Nerd Font enabled: `vim.g.have_nerd_font = true`
- UI font (GUI only): `MesloLGS NF:h12` (from [ginit.vim](ginit.vim))
- Language: `en_US`

## Editor options

From [init.lua](init.lua) and [lua/custom/init.lua](lua/custom/init.lua):

- Line numbers: absolute + relative
- No swap files
- Mouse: enabled (`a`)
- Do not show mode (statusline already handles it)
- Clipboard sync: yank operations copy to system clipboard via a `TextYankPost` autocmd
- Break indent: enabled
- Undo file: enabled
- Search: `ignorecase` + `smartcase`
- Signcolumn: always on
- Update time: 250 ms
- Mapped sequence timeout: 300 ms
- Splits: open to the right and below
- Listchars: show trailing spaces (`trail = '·'`) and non-breaking space (`nbsp = '␣'`)
- Live substitution preview: `inccommand = 'split'`
- Cursorline: enabled
- Scrolloff: 10 lines
- Terminal scrollback: 10 lines
- Folding: `indent`, open by default (`foldlevel = 999`)
- Indentation: expand tabs, 2 spaces, smarttab, autoindent

## Autocommands

- Yank highlight: highlights on `TextYankPost`
- Clipboard sync on yank: copies the unnamed register to `+`
- LSP attach: sets LSP-specific keymaps and behaviors
- Modified indicator: custom floating badge per window (see [lua/custom/modifiedindicador.lua](lua/custom/modifiedindicador.lua))
  - Shows a floating `Modified!` badge when the buffer is dirty
  - Shows a temporary `Saved` badge after writes
  - Updates on buffer/window events and resize

## Plugin manager

- `lazy.nvim` is installed automatically if missing and prepended to runtime path
- Plugins are configured in [init.lua](init.lua) and in [lua/custom/plugins](lua/custom/plugins)

## Plugins (loaded)

Core:

- `guess-indent.nvim` (automatic indent detection)
- `gitsigns.nvim` (git signs + actions)
- `which-key.nvim` (keymap helper)
- `telescope.nvim` (+ `telescope-fzf-native.nvim`, `telescope-ui-select.nvim`)
- `nvim-lspconfig` + `mason.nvim` + `mason-tool-installer.nvim`
- `fidget.nvim` (LSP status)
- `blink.cmp` + `LuaSnip`
- `tokyonight.nvim` (installed)
- `onedark.nvim` (active colorscheme)
- `todo-comments.nvim`
- `mini.nvim` (ai + statusline)
- `nvim-treesitter` (manual start on selected filetypes)
- `nvim-autopairs` (pairs removed: quotes, braces, brackets, parens)
- `neo-tree.nvim`

Custom:

- `typescript-tools.nvim`
- `noice.nvim` (+ `nui.nvim`, `nvim-notify`)
- `github/copilot.vim`
- `flash.nvim`
- `nvim-ts-autotag`
- `nvim-treesitter-context`
- `harpoon` (v2)

# kickstart.nvim

## Introduction

A starting point for Neovim that is:

- Small
- Single-file
- Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets _only_ the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have at least the latest
stable version. Most likely, you want to install neovim via a [package
manager](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package).
To check your neovim version, run `nvim --version` and make sure it is not
below the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) version. If
your chosen install method only gives you an outdated version of neovim, find
alternative [installation methods below](#alternative-neovim-installation-methods).

### Install External Dependencies

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> [!NOTE] > [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux, MacOS         | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%localappdata%\nvim\`                    |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`                 |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim (@priori fork)

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/priori/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/priori/nvim-config.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/priori/nvim-config.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

- What should I do if I already have a pre-existing Neovim configuration?
  - You should back it up and then delete all associated files.
  - This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
- Can I keep my existing configuration in parallel to kickstart?
  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
- What if I want to "uninstall" this configuration:
  - See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
- Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  - The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    - [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  - Discussions on this topic can be found here:
    - [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    - [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#install-kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
   either follow the instructions on the page or use winget,
   run in cmd as **admin**:

```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
   open a new one so that choco path is set, and run in cmd as **admin**:

```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```

</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```

</details>

#### Linux Install

<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```

</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```

</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```

</details>

### Alternative neovim installation methods

For some systems it is not unexpected that the [package manager installation
method](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)
recommended by neovim is significantly behind. If that is the case for you,
pick one of the following methods that are known to deliver fresh neovim versions very quickly.
They have been picked for their popularity and because they make installing and updating
neovim to the latest versions easy. You can also find more detail about the
available methods being discussed
[here](https://github.com/nvim-lua/kickstart.nvim/issues/1583).

<details><summary>Bob</summary>

[Bob](https://github.com/MordechaiHadad/bob) is a Neovim version manager for
all plattforms. Simply install
[rustup](https://rust-lang.github.io/rustup/installation/other.html),
and run the following commands:

```bash
rustup default stable
rustup update stable
cargo install bob-nvim
bob use stable
```

</details>

<details><summary>Homebrew</summary>

[Homebrew](https://brew.sh) is a package manager popular on Mac and Linux.
Simply install using [`brew install`](https://formulae.brew.sh/formula/neovim).

</details>

<details><summary>Flatpak</summary>

Flatpak is a package manager for applications that allows developers to package their applications
just once to make it available on all Linux systems. Simply [install flatpak](https://flatpak.org/setup/)
and setup [flathub](https://flathub.org/setup) to [install neovim](https://flathub.org/apps/io.neovim.nvim).

</details>

<details><summary>asdf and mise-en-place</summary>

[asdf](https://asdf-vm.com/) and [mise](https://mise.jdx.dev/) are tool version managers,
mostly aimed towards project-specific tool versioning. However both support managing tools
globally in the user-space as well:

<details><summary>mise</summary>

[Install mise](https://mise.jdx.dev/getting-started.html), then run:

```bash
mise plugins install neovim
mise use neovim@stable
```

</details>

<details><summary>asdf</summary>

[Install asdf](https://asdf-vm.com/guide/getting-started.html), then run:

```bash
asdf plugin add neovim
asdf install neovim stable
asdf set neovim stable --home
asdf reshim neovim
```

</details>

</details>
