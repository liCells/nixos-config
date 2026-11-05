#!/usr/bin/env bash
set -euo pipefail

# Show cliphist history in fuzzel and copy the selected entry back to the
# clipboard (text or image).

entry="$(cliphist list | fuzzel --dmenu --prompt='Clipboard: ')"
[ -n "$entry" ] || exit 0

# cliphist lists entries as "<id>\t<preview>"; decode only wants the id.
id="${entry%%$'\t'*}"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
cliphist decode "$id" > "$tmp"

case "$(file --mime-type -b "$tmp")" in
    image/png)  wl-copy --type image/png  < "$tmp" ;;
    image/jpeg) wl-copy --type image/jpeg < "$tmp" ;;
    image/gif)  wl-copy --type image/gif  < "$tmp" ;;
    image/webp) wl-copy --type image/webp < "$tmp" ;;
    *)          wl-copy < "$tmp" ;;
esac
