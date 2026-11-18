#!/usr/bin/env bash
set -euo pipefail
here=$(cd -- "$(dirname -- "$0")" && pwd)
if [[ $# != 3 || ! -x "$1/TwitchDownloaderCLI" || ! "$3" =~ ^[0-9][0-9A-Za-z.+~]*$ ]]; then
    echo "Usage: $0 CLI_DIRECTORY OUTPUT_DIRECTORY DEBIAN_VERSION" >&2
    exit 2
fi

cli=$(realpath -- "$1")
output=$(realpath -m -- "$2")
version=$3
stage=$(mktemp -d)
trap 'rm -rf -- "$stage"' EXIT
app="$stage/usr/lib/twitch-downloader"
docs="$stage/usr/share/doc/twitch-downloader"
install -d "$output" "$stage/DEBIAN" "$app" "$docs" \
    "$stage/usr/bin" "$stage/usr/share/applications"
install -m 755 "$here/twitch-downloader" "$cli/TwitchDownloaderCLI" "$app/"
install -m 644 "$here/../LICENSE.txt" "$docs/copyright"
for notice in COPYRIGHT.txt THIRD-PARTY-LICENSES.txt; do
    if [[ -f "$cli/$notice" ]]; then
        install -m 644 "$cli/$notice" "$docs/"
    fi
done
ln -s ../lib/twitch-downloader/twitch-downloader "$stage/usr/bin/twitch-downloader"
cat > "$stage/usr/share/applications/io.github.petrk94.TwitchDownloader.desktop" <<'DESKTOP'
[Desktop Entry]
Type=Application
Name=Twitch Downloader
Comment=Download Twitch videos and export or render chat
Comment[de]=Twitch-Videos laden und Chats exportieren oder rendern
Exec=twitch-downloader
Icon=video-x-generic
Terminal=false
Categories=AudioVideo;Video;
DESKTOP
cat > "$stage/DEBIAN/control" <<CONTROL
Package: twitch-downloader
Version: $version
Architecture: amd64
Maintainer: TwitchDownloader contributors
Section: video
Priority: optional
Depends: python3 (>= 3.8), python3-gi, gir1.2-gtk-3.0, ffmpeg, ca-certificates, libssl3t64 | libssl3, libicu77 | libicu76 | libicu74 | libicu72 | libicu70
Description: Linux desktop frontend for TwitchDownloaderCLI
 Download Twitch VODs and clips, export chat logs, and render chat into video.
CONTROL
dpkg-deb --root-owner-group --build "$stage" "$output/twitch-downloader_${version}_amd64.deb"
