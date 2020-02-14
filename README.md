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

Install using package manager: `fzf`, `curl`, `neovim`, `python-pynvim`

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

Install scoop from https://scoop.sh/

Install dependencies using scoop:

```
scoop install neovim fzf curl
```

Clone repo:

```powershell
cd ~\AppData\Local\
git clone git@github.com:Slashbunny/vim-config.git nvim
```

Start neovim to install plugins.

Compile YCM:

```powershell
cd ~\AppData\Local\nvim\plugged\youcompleteme\
./install.py --clangd-completer
```

## Maintenance

### Updating Plugins

Run `:PlugUpdate`.

### Installing New Plugins

Run `:PlugInstall`. The installation process only runs when `vim-plug` is
downloaded and installed the first time. If more plugins are added to the
configuration, you must run `:PlugInstall` to install them.

