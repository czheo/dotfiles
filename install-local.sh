#!/bin/sh
# Install these dotfiles locally. Safe to run more than once.

DOTFILES_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

link_path() {
    source_path=$1
    target_path=$2

    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        return
    fi

    rm -rf "$target_path"
    ln -s "$source_path" "$target_path"
}

install_macos_packages() {
    if command -v brew >/dev/null 2>&1; then
        brew_bin=$(command -v brew)
    elif [ -x /opt/homebrew/bin/brew ]; then
        brew_bin=/opt/homebrew/bin/brew
    elif [ -x /usr/local/bin/brew ]; then
        brew_bin=/usr/local/bin/brew
    else
        echo "Installing Homebrew ..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || return 1

        if [ -x /opt/homebrew/bin/brew ]; then
            brew_bin=/opt/homebrew/bin/brew
        elif [ -x /usr/local/bin/brew ]; then
            brew_bin=/usr/local/bin/brew
        else
            echo "Homebrew installation failed" >&2
            return 1
        fi
    fi

    eval "$("$brew_bin" shellenv)"
    echo "Installing macOS packages ..."
    "$brew_bin" bundle install --no-upgrade --file="$DOTFILES_DIR/Brewfile"
}

if [ "$(uname -s)" = "Darwin" ]; then
    install_macos_packages || exit 1
fi

# Shell
link_path "$DOTFILES_DIR/bash_profile" "$HOME/.bash_profile"
link_path "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

# Screen and tmux
link_path "$DOTFILES_DIR/screenrc" "$HOME/.screenrc"
link_path "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

# Git
link_path "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
link_path "$DOTFILES_DIR/gitignore" "$HOME/.gitignore"

# Vim
mkdir -p "$HOME/.vim/autoload"
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
link_path "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
echo "Installing Vim plugins ..."
if vim +PlugInstall +qa >/dev/null 2>&1; then
    echo "Vim plugins installation succeeded"
else
    echo "Vim plugins installation failed" >&2
fi

# Neovim
mkdir -p "$HOME/.config"
link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Pi: keep credentials, sessions, caches, and installed packages local.
mkdir -p "$HOME/.pi/agent/extensions/pi-rtk-optimizer"
link_path "$DOTFILES_DIR/pi/settings.json" "$HOME/.pi/agent/settings.json"
link_path "$DOTFILES_DIR/pi/models.json" "$HOME/.pi/agent/models.json"
link_path "$DOTFILES_DIR/pi/extensions/pi-rtk-optimizer/config.json" \
    "$HOME/.pi/agent/extensions/pi-rtk-optimizer/config.json"

if [ "$(uname -s)" = "Darwin" ]; then
    link_path "$DOTFILES_DIR/aerospace.toml" "$HOME/.aerospace.toml"
    link_path "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"

    # Homebrew reports success when the user service is already running.
    brew services start FelixKratz/formulae/sketchybar
fi
