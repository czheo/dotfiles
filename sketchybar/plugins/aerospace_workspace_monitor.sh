#!/usr/bin/env bash

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
AEROSPACE="$(command -v aerospace)"
SKETCHYBAR="$(command -v sketchybar)"
WORKSPACES="1 2 3 B G O Q"

[ -n "$AEROSPACE" ] && [ -n "$SKETCHYBAR" ] || exit 0

source "${CONFIG_DIR:-$HOME/.config/sketchybar}/plugins/icon_map.sh"

workspace_rows="$($AEROSPACE list-workspaces --all \
  --format '%{workspace}|%{monitor-appkit-nsscreen-screens-id}' 2>/dev/null)" || exit 0
visible_workspaces="$($AEROSPACE list-workspaces --monitor all --visible \
  --format '%{workspace}' 2>/dev/null)" || exit 0
focused_workspace="$($AEROSPACE list-workspaces --focused \
  --format '%{workspace}' 2>/dev/null)"
window_rows="$($AEROSPACE list-windows --all \
  --format '%{workspace}|%{window-id}|%{app-name}' 2>/dev/null)"
focused_row="$($AEROSPACE list-windows --focused \
  --format '%{workspace}|%{window-id}|%{app-name}' 2>/dev/null)"

[ -n "$workspace_rows" ] || exit 0

IFS='|' read -r focused_window_workspace focused_window_id focused_app_name <<< "$focused_row"

args=()
for sid in $WORKSPACES; do
  display_id="$(printf '%s\n' "$workspace_rows" | awk -F '|' -v sid="$sid" '$1 == sid { print $2; exit }')"
  [ -n "$display_id" ] || continue

  background_drawing=off
  background_color=0x40ffffff
  if printf '%s\n' "$visible_workspaces" | grep -Fxq "$sid"; then
    background_drawing=on
  fi
  if [ "$sid" = "$focused_workspace" ]; then
    background_color=0x80ff5a36
  fi

  icon_strip=""
  focused_icon=""
  focused_name=""
  while IFS='|' read -r window_workspace window_id app_name; do
    [ "$window_workspace" = "$sid" ] || continue
    __icon_map "$app_name"

    if [ -n "$focused_window_id" ] && [ "$window_id" = "$focused_window_id" ]; then
      focused_icon="$icon_result"
      focused_name="$app_name"
    else
      icon_strip+="${icon_result} "
    fi
  done <<< "$window_rows"
  icon_strip="${icon_strip% }"

  label_drawing=off
  [ -n "$icon_strip" ] && label_drawing=on

  focused_drawing=off
  [ -n "$focused_icon" ] && focused_drawing=on

  args+=(
    --set "space.$sid"
    "display=$display_id"
    "label=$icon_strip"
    "label.drawing=$label_drawing"
    --set "space_focus.$sid"
    "display=$display_id"
    "drawing=$focused_drawing"
    "icon=$focused_icon"
    "label=$focused_name"
    --set "space_bracket.$sid"
    "background.drawing=$background_drawing"
    "background.color=$background_color"
  )
done

if [ "${#args[@]}" -gt 0 ]; then
  "$SKETCHYBAR" "${args[@]}"
fi
