#!/usr/bin/env bash

cpu_usage="$(/usr/sbin/iostat -n 0 -c 2 -w 1 | /usr/bin/awk 'END { print 100 - $3 }')"

total_memory="$(/usr/sbin/sysctl -n hw.memsize)"
memory_usage="$(/usr/bin/vm_stat | /usr/bin/awk -v total_memory="$total_memory" '
  NR == 1 { page_size = $8 }
  /Pages free:/ { free_pages = $3 }
  /Pages speculative:/ { speculative_pages = $3 }
  END {
    gsub(/\./, "", free_pages)
    gsub(/\./, "", speculative_pages)
    available_memory = (free_pages + speculative_pages) * page_size
    printf "%.0f", 100 * (total_memory - available_memory) / total_memory
  }
')"

disk_usage="$(/bin/df -k /System/Volumes/Data | /usr/bin/awk 'NR == 2 { gsub(/%/, "", $5); print $5 }')"

if [ -n "$cpu_usage" ] && [ -n "$memory_usage" ] && [ -n "$disk_usage" ]; then
  /opt/homebrew/bin/sketchybar --set "$NAME" \
    label=" ${cpu_usage}%   ${memory_usage}%  󰋊 ${disk_usage}%"
fi
