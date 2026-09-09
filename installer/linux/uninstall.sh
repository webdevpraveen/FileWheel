#!/bin/sh
set -eu

data_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}
install_dir="$data_dir/filewheel/application"
desktop_file="$data_dir/applications/com.filewheel.app.desktop"
python3 - "$data_dir" "$install_dir" <<'PY'
import pathlib
import sys

root, target = map(pathlib.Path, sys.argv[1:])
expected = root.resolve() / 'filewheel' / 'application'
if target.is_symlink() or target.resolve() != expected:
    raise SystemExit('Refusing to remove an installation outside its expected directory.')
if (target / '.filewheel-package').read_text(encoding='utf-8').strip() != 'com.filewheel.app':
    raise SystemExit('The directory is not an installation created by FileWheel.')
PY
"$install_dir/FileWheel" --uninstall-cleanup
if [ -L "$HOME/.local/bin/filewheel" ] && [ "$(readlink "$HOME/.local/bin/filewheel")" = "$install_dir/filewheel-cli" ]; then
    rm -- "$HOME/.local/bin/filewheel"
fi
if [ -f "$desktop_file" ] && grep -q '^X-FileWheel-Managed=true$' "$desktop_file"; then
    rm -- "$desktop_file"
fi
rm -rf -- "$install_dir"
printf '%s\n' 'FileWheel was removed. Your settings and conversion results were kept.'
