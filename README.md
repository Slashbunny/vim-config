# Personal neovim configs

## Installation

The following instructions are for `neovim` only (`vim` support has been dropped).

### Linux

Install using package manager: `cmake`, `curl`, `fzf`, `git`, `neovim`,
`nodejs`, `npm`, `python`, `python-pip` `python-pynvim`.

Clone repo:

````bash
cd ~/.config/
git clone git@github.com:Slashbunny/vim-config.git nvim
````

Install `neovim` modules:

```bash
npm install -g neovim
```

Start neovim to install plugins.

### Windows

Run all commands in PowerShell. Install scoop from https://scoop.sh/

Install dependencies using scoop:

```
scoop install neovim fzf curl git python pyenv nodejs cmake
```

Install `neovim` modules for each supported language:

```powershell
pip3 install --upgrade pynvim
npm install -g neovim
```

Clone repo:

```powershell
cd ~\AppData\Local\
git clone git@github.com:Slashbunny/vim-config.git nvim
```

Start neovim to install plugins.

## Maintenance

### Check Setup

Run `:checkhealth`.

### Updating Plugins

Run `:PlugUpdate`.

### Installing New Plugins

Run `:PlugInstall`. The installation process only runs when `vim-plug` is
downloaded and installed the first time. If more plugins are added to the
configuration, you must run `:PlugInstall` to install them.

### Windows-Specific

Run `scoop update *` regularly to pull the latest versions
of packages previously installed. Run the `pip3` and `npm` commands to update
the language modules.

