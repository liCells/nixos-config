#!/usr/bin/env bash
set -euo pipefail

# Toggle floating for the active window. When it becomes floating, resize it
# to ~1000x660 and center it on the monitor.

win="$(hyprctl activewindow -j 2>/dev/null || true)"
[ -n "$win" ] || exit 0

addr="$(printf '%s' "$win" | jq -r '.address // empty')"
[ -n "$addr" ] && [ "$addr" != "null" ] || exit 0

floating="$(printf '%s' "$win" | jq -r '.floating')"

if [ "$floating" = "true" ]; then
    hyprctl dispatch togglefloating "address:${addr}"
else
    hyprctl dispatch togglefloating "address:${addr}"
    hyprctl dispatch resizeactive exact 1000 660
    hyprctl dispatch centerwindow
fi
