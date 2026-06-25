#!/usr/bin/env python3

import evdev
import time
import subprocess
from pathlib import Path
import os

# Define the state storage file path
RUNTIME_DIR = Path(os.getenv("XDG_RUNTIME_DIR", "/run/user/1000"))
STATUS_FILE = RUNTIME_DIR / "keyboard_status"
DEVICE_NAME = "at-translated-set-2-keyboard"

def get_file_status() -> bool:
    """Read state strictly from the runtime file. Defaults to True if missing."""
    if STATUS_FILE.exists():
        try:
            content = STATUS_FILE.read_text().strip().lower()
            return content == "true"
        except Exception:
            return True
    return True

def set_file_status(enabled: bool):
    """Write state cleanly to the runtime file."""
    try:
        STATUS_FILE.write_text("true" if enabled else "false")
    except Exception as e:
        print(f"Error writing to state file: {e}")

def wait_for_key_release(kb_device):
    """
    Blocks execution until Ctrl, Esc, and Delete are physically released.
    This prevents ghost/stuck keys when disabling the input device.
    """
    print("[WAIT] Waiting for key release to prevent ghosting...")
    ctrl = esc = delete = True

    # Read the active state of keys directly from the hardware state
    while ctrl or esc or delete:
        # Fetch snapshot of currently pressed keys on the device
        active_keys = kb_device.active_keys()

        ctrl = (evdev.ecodes.KEY_LEFTCTRL in active_keys or
                evdev.ecodes.KEY_RIGHTCTRL in active_keys)
        esc = evdev.ecodes.KEY_ESC in active_keys
        delete = evdev.ecodes.KEY_DELETE in active_keys

        if ctrl or esc or delete:
            time.sleep(0.02) # Small polling nap to save CPU

def toggle_keyboard(kb_device):
    # Read state strictly from file
    current_state = get_file_status()
    new_state = not current_state

    # If disabling, wait until the user let go of the keys before cutting the feed
    if not new_state:
        wait_for_key_release(kb_device)

    # Save the inverted state back to the file
    set_file_status(new_state)

    # Format the explicit Hyprland device command string
    hypr_cmd = f"device[{DEVICE_NAME}]:enabled"
    state_str = "true" if new_state else "false"

    # Visual Terminal Feedback
    print(f"[TOGGLE] State changed! Keyboard is now: {'[ ENABLED ]' if new_state else '[ DISABLED ]'}")

    # Push change to Hyprland and notify desktop
    try:
        subprocess.run(["hyprctl", "keyword", hypr_cmd, state_str], check=True)
        subprocess.run(["notify-send", "Keyboard",
                       f"Internal keyboard {'ENABLED' if new_state else 'DISABLED'}"], check=False)
    except Exception as e:
        print(f"Error pushing command to Hyprland: {e}")

def main():
    target_name = "AT Translated Set 2 keyboard"
    kb_device = None

    for path in evdev.list_devices():
        try:
            dev = evdev.InputDevice(path)
            if dev.name == target_name:
                kb_device = dev
                print(f"Connected to input stream: {dev.name}")
                break
        except Exception:
            continue

    if not kb_device:
        print("Fatal: Keyboard not found under /dev/input/")
        return

    # Check state on initial daemon boot
    initial_state = get_file_status()
    print(f"Daemon running — Ctrl + Esc + Delete to toggle.")
    print(f"Current tracked state: {'[ ENABLED ]' if initial_state else '[ DISABLED ]'}")

    ctrl = esc = delete = False
    last_toggle = 0

    for event in kb_device.read_loop():
        if event.type != evdev.ecodes.EV_KEY:
            continue

        key = event.code
        pressed = event.value != 0

        if key in (evdev.ecodes.KEY_LEFTCTRL, evdev.ecodes.KEY_RIGHTCTRL):
            ctrl = pressed
        elif key == evdev.ecodes.KEY_ESC:
            esc = pressed
        elif key == evdev.ecodes.KEY_DELETE:
            delete = pressed

        if ctrl and esc and delete:
            if time.time() - last_toggle > 1.2:  # Marginally increased timeout window
                toggle_keyboard(kb_device)
                last_toggle = time.time()

                # Force reset internal tracking tracking flags
                ctrl = esc = delete = False

        # Release all tracked registers if any key pops up to prevent lockups
        if not pressed and (key in (evdev.ecodes.KEY_LEFTCTRL, evdev.ecodes.KEY_RIGHTCTRL,
                                  evdev.ecodes.KEY_ESC, evdev.ecodes.KEY_DELETE)):
            ctrl = esc = delete = False

if __name__ == "__main__":
    main()

