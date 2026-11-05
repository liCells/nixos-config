#!/usr/bin/env bash
set -euo pipefail

# Cycle / pick wallpapers from a directory and apply them with awww.
#
# Usage: wallpaper.sh [next|random]
#   (no arg)  re-apply the remembered wallpaper
#   next      advance to the next wallpaper (slide in from the right)
#   random    pick a random wallpaper

dir="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
state="${XDG_CACHE_HOME:-$HOME/.cache}/desktop/wallpaper-index"

[ -d "$dir" ] || exit 0

mapfile -t walls < <(
    # -L follows the symlinks home-manager deploys for wallpapers
    find -L "$dir" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
           -o -iname '*.webp' -o -iname '*.gif' \) | sort
)

[ "${#walls[@]}" -gt 0 ] || exit 0

idx=0
if [ -f "$state" ]; then
    idx="$(cat "$state" 2>/dev/null || echo 0)"
fi
idx=$(( idx % ${#walls[@]} ))

case "${1:-}" in
    next)   idx=$(( (idx + 1) % ${#walls[@]} )) ;;
    random) idx=$(( RANDOM % ${#walls[@]} )) ;;
esac

awww img "${walls[$idx]}" \
    --transition-type right \
    --transition-duration 2 \
    --transition-fps 60 \
    --transition-step 20

mkdir -p "$(dirname "$state")"
printf '%s' "$idx" > "$state"
