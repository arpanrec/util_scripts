#!/bin/bash
set -e

__gnome_shell_version=$(gnome-shell --version | awk '{ print $3 }')
__temp_directory="$HOME/.tmp"
__extension_download_dir="$__temp_directory/gnome_extensions"

mkdir -p "$__extension_download_dir"

__download_extension() {
    __extension_name=$1
    __extension_id=$2
    echo ---------------------------------------------------------------------------
    echo ---------"Downloading $__extension_name with id : $__extension_id"---------
    echo ---------------------------------------------------------------------------
    __extension_info_json=$(curl -sSL "https://extensions.gnome.org/extension-info/?pk=$__extension_id&shell_version=$__gnome_shell_version")
    __extension_uuid=$( echo "$__extension_info_json" | jq .uuid -r )
    __extension_download_url=$( echo "$__extension_info_json" | jq .download_url -r )
    __extension_version_tag=$( echo "$__extension_info_json" | jq .version_tag -r )


    if [ -n "$__extension_uuid" ] && [ -n "$__extension_download_url" ] ; then
        mkdir -p "$HOME/.local/share/gnome-shell/extensions/$__extension_uuid"

        if [ "$(ls -A "$HOME/.local/share/gnome-shell/extensions/$__extension_uuid")" ]; then
            echo "Directory is not empty :: $HOME/.local/share/gnome-shell/extensions/$__extension_uuid"
            echo ""
            echo ""
            echo ""
            sleep 2
        else
            if [ ! -f "$__extension_download_dir/${__extension_uuid}-${__extension_version_tag}.zip" ] ; then
                wget "https://extensions.gnome.org$__extension_download_url" -O "$__extension_download_dir/${__extension_uuid}-${__extension_version_tag}.zip"
            fi
            unzip "$__extension_download_dir/${__extension_uuid}-${__extension_version_tag}.zip" -d "$HOME/.local/share/gnome-shell/extensions/$__extension_uuid"
        fi
    fi
}

__download_extension 'user-themes' '19'

__download_extension 'AppIndicator and KStatusNotifierItem Support' '615'

__download_extension 'workspace-indicator' '21'

__download_extension 'applications-menu' '6'

__download_extension 'vitals' '1460'
