dotfiles for unix/linux configuration
===========================

Installation
------------------

```bash
curl https://raw.githubusercontent.com/czheo/dotfiles/master/install.sh | bash
. ~/.bash_profile
```

Quick Notes
-----------

### Bash

- `work` to attack to tmux session

### Neovim

Mostly Use [LazyVim Default key bindings](https://www.lazyvim.org/keymaps)

- `<leader>sk` to search keymap

### Pi

Stable Pi configuration lives in [`pi/`](pi/) and is linked into
`~/.pi/agent` by `install-local.sh`.

Credentials (`auth.json`), sessions, generated model data, installed packages,
and machine-local skills remain untracked under `~/.pi/agent`.
