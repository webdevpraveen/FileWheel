#!/bin/sh
set -eu

source_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
install_dir="$HOME/Applications/FileWheel.app"
bin_dir="$HOME/.local/bin"
if [ -e "$install_dir" ] || [ -L "$install_dir" ]; then
    printf '%s\n' "An installation already exists at $install_dir. Run uninstall.sh first."
    exit 1
fi
if [ -e "$bin_dir/filewheel" ] || [ -L "$bin_dir/filewheel" ]; then
    printf '%s\n' "$bin_dir/filewheel already exists. Remove or rename it before installing FileWheel."
    exit 1
fi
test -x "$source_dir/FileWheel.app/Contents/MacOS/FileWheel"
mkdir -p "$HOME/Applications" "$bin_dir"
/usr/bin/ditto "$source_dir/FileWheel.app" "$install_dir"
ln -s "$install_dir/Contents/MacOS/filewheel-cli" "$bin_dir/filewheel"
printf '%s\n' "Installed $install_dir" "CLI: $bin_dir/filewheel (add $bin_dir to PATH if needed)."
printf '%s\n' 'Open FileWheel from Applications. Grant Accessibility and Finder Automation access when requested.'
