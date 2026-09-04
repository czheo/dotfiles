#!/usr/bin/env python3

"""Bridge Voxtype's state file to a reactive SketchyBar event."""

from __future__ import annotations

import fcntl
import os
from pathlib import Path
import shutil
import subprocess
import time


STATE_DIR = Path("/tmp/voxtype")
STATE_FILE = STATE_DIR / "state"
PID_FILE = STATE_DIR / "pid"
APP_BUNDLE = Path("/Applications/Voxtype.app")
EVENT = "voxtype_state_change"

# Fast enough to feel instant while Voxtype is up; lazier while it is merely
# installed, so a machine that never dictates is not polled ten times a second.
ACTIVE_POLL_SECONDS = 0.1
IDLE_POLL_SECONDS = 2.0

# Homebrew sits in a different prefix on Apple Silicon than on Intel, and a
# launchd-started SketchyBar does not inherit a login shell's PATH.
FALLBACK_PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"


def find(binary: str) -> str | None:
    return shutil.which(binary) or shutil.which(binary, path=FALLBACK_PATH)


def voxtype_present() -> bool:
    """Whether Voxtype could ever write a state file on this machine."""
    return (
        find("voxtype") is not None
        or APP_BUNDLE.exists()
        # Already running, even if installed somewhere this does not look.
        or STATE_DIR.exists()
    )


def read_state() -> str:
    try:
        pid = int(PID_FILE.read_text(encoding="utf-8").strip())
        os.kill(pid, 0)
        return STATE_FILE.read_text(encoding="utf-8").strip() or "idle"
    except (OSError, ValueError):
        return "stopped"


def main() -> None:
    sketchybar = find("sketchybar")
    if sketchybar is None:
        return

    # Nothing to bridge without Voxtype, so exit rather than sit on a state file
    # that will never appear. A later install is picked up on the next reload.
    if not voxtype_present():
        return

    # SketchyBar reloads its config in a new shell. Holding a non-blocking lock
    # keeps those reloads from accumulating duplicate watcher processes.
    lock_path = f"/tmp/sketchybar-voxtype-{os.getuid()}.lock"
    with open(lock_path, "w", encoding="utf-8") as lock_file:
        try:
            fcntl.flock(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            return

        previous_state: str | None = None
        while True:
            state = read_state()
            if state != previous_state:
                try:
                    subprocess.run(
                        [sketchybar, "--trigger", EVENT, f"VOXTYPE_STATE={state}"],
                        check=False,
                        stdout=subprocess.DEVNULL,
                        stderr=subprocess.DEVNULL,
                    )
                except OSError:
                    # SketchyBar went away mid-run; nothing left to notify.
                    return
                previous_state = state
            time.sleep(IDLE_POLL_SECONDS if state == "stopped" else ACTIVE_POLL_SECONDS)


if __name__ == "__main__":
    main()
