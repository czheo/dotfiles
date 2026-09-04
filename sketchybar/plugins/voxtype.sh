#!/usr/bin/env bash

# Voxtype writes its current state atomically whenever dictation changes phase.
# Keeping this item hidden while idle avoids permanently consuming bar space.
STATE_FILE="/tmp/voxtype/state"
PID_FILE="/tmp/voxtype/pid"

if [[ -n "${VOXTYPE_STATE:-}" ]]; then
  state="$VOXTYPE_STATE"
elif [[ -r "$STATE_FILE" && -r "$PID_FILE" ]]; then
  IFS= read -r pid < "$PID_FILE"
  IFS= read -r state < "$STATE_FILE"
  if [[ ! "$pid" =~ ^[0-9]+$ ]] || ! kill -0 "$pid" 2>/dev/null; then
    state="stopped"
  fi
else
  state="stopped"
fi

case "$state" in
  recording)
    sketchybar --set "$NAME" \
      drawing=on \
      icon="" \
      icon.color=0xffff6b6b \
      label.drawing=off \
      background.drawing=on
    ;;
  transcribing)
    sketchybar --set "$NAME" \
      drawing=on \
      icon="" \
      icon.color=0xff32d74b \
      label.drawing=off \
      background.drawing=on
    ;;
  idle)
    sketchybar --set "$NAME" \
      drawing=on \
      icon="" \
      icon.color=0xffffffff \
      label.drawing=off \
      background.drawing=on
    ;;
  *)
    sketchybar --set "$NAME" drawing=off
    ;;
esac
