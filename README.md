# Personal vim/neovim configs

## Installation

The following instructions are for `neovim`. Using `vim` (or `gvim` on Windows)
will work as well. However, you will need to change the paths referenced in the
below instructions if `vim` is being used as follows:

|         | neovim                  | vim           |
| ----    | ----                    | ----          |
| Linux   | `~/.config/nvim/`       | `~/.vim/`     |
| Windows | `~\AppData\Local\nvim\` | `~\vimfiles\` |


### Linux

Install using package manager: `fzf`, `cmake`, `curl`, `git`,
`neovim`, `python-pynvim` (possibly `python3-dev` depending on distro)

Clone repo:

````bash
cd ~/.config/
git clone git@github.com:Slashbunny/vim-config.git nvim
````

Start neovim to install plugins.

Compile YCM:

```bash
cd ~/.config/nvim/plugged/youcompleteme/
./install.py --clangd-completer
```

### Windows

Run all commands in PowerShell. Install scoop from https://scoop.sh/

Install dependencies using scoop:

```
scoop install neovim fzf curl git python cmake
```

Install python's `neovim` module using `pip`:

```powershell
pip install neovim
```

You will also need to manually install
[Visual Studio Build Tools](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15) for YCM. During setup, select "Visual C++
 build tools" in the "Workloads" tab.

Clone repo:

```powershell
cd ~\AppData\Local\
git clone git@github.com:Slashbunny/vim-config.git nvim
```

Start neovim to install plugins.

Compile YCM:

```powershell
cd ~\AppData\Local\nvim\plugged\youcompleteme\
python install.py --clangd-completer --msvc 15
```

## Maintenance

### Updating Plugins

Run `:PlugUpdate`.

### Installing New Plugins

Run `:PlugInstall`. The installation process only runs when `vim-plug` is
downloaded and installed the first time. If more plugins are added to the
configuration, you must run `:PlugInstall` to install them.

### Windows-Specific

Run `scoop update` regularly to pull the latest versions
of packages previously installed.

