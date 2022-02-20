#!/usr/bin/env bash
set -e

__gnome_shell_version=$(gnome-shell --version | awk '{ print $3 }')
__temp_directory="$HOME/.tmp"
__download_dir="$__temp_directory/icons"
mkdir -p "$__download_dir"

mkdir -p "$HOME/.themes"

if [ ! -d "$HOME/.themes/Nordic" ] ; then
    git clone --depth=1 https://github.com/EliverLara/Nordic.git "$HOME/.themes/Nordic"
fi

rm -rf "$__temp_directory/icons/Tela-icon-theme"
git clone --depth=1 https://github.com/vinceliuice/Tela-icon-theme.git "$__temp_directory/icons/Tela-icon-theme"
"$__temp_directory/icons/Tela-icon-theme/install.sh" -a
