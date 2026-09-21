#!/bin/sh

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
install_prefix=${PREFIX:-"$HOME/.local"}
bin_dir="$install_prefix/bin"
applications_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}/applications
desktop_file="$applications_dir/spf13-gvim-tab.desktop"

install -d "$bin_dir" "$applications_dir"
install -m 755 "$script_dir/gvim-tab" "$bin_dir/gvim-tab"
install -m 755 "$script_dir/gvim-x11-focus" "$bin_dir/gvim-x11-focus"

cat >"$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=gVim (reuse window as tabs)
GenericName=Text Editor
Comment=Edit files in tabs of one gVim window
Exec="$bin_dir/gvim-tab" %F
Icon=gvim
Terminal=false
StartupNotify=true
Categories=Utility;TextEditor;
MimeType=text/plain;text/x-log;
EOF

if command -v desktop-file-validate >/dev/null 2>&1; then
    desktop-file-validate "$desktop_file"
fi

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$applications_dir"
fi

if command -v xdg-mime >/dev/null 2>&1; then
    xdg-mime default spf13-gvim-tab.desktop text/plain
    xdg-mime default spf13-gvim-tab.desktop text/x-log
fi

printf 'Installed %s\n' "$desktop_file"
printf 'Text files will reuse the gVim server named %s.\n' "${GVIM_SERVERNAME:-SPF13_GVIM}"