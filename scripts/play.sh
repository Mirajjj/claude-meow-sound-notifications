#!/usr/bin/env bash
# Cross-platform sound playback for claude-meow-sound-notifications
# Always exits 0 to never block Claude Code

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOUNDS_DIR="$(cd "$SCRIPT_DIR/../sounds" && pwd)"

SOUND_NAME="${1:-m-e-o-w}"

# Random mode: pick from a pool of 4 meows
if [ "$SOUND_NAME" = "random" ]; then
    POOL=("meow_1_normal" "meow_2_long" "meow_5_quick" "meow_6_quick_2")
    SOUND_NAME="${POOL[$((RANDOM % ${#POOL[@]}))]}"
fi

SOUND_FILE="$SOUNDS_DIR/${SOUND_NAME}.wav"

if [ ! -f "$SOUND_FILE" ]; then
    exit 0
fi

# Detect platform and play sound in background
play_sound() {
    local file="$1"
    local os
    os="$(uname -s)"

    case "$os" in
        Darwin)
            afplay "$file" &
            ;;
        Linux)
            # Check for WSL first
            if grep -qi microsoft /proc/version 2>/dev/null; then
                # WSL: convert to Windows path and use PowerShell SoundPlayer
                local win_path
                win_path="$(wslpath -w "$file")"
                powershell.exe -NoProfile -Command "(New-Object System.Media.SoundPlayer '$win_path').PlaySync()" &
            elif command -v paplay >/dev/null 2>&1; then
                paplay "$file" &
            elif command -v pw-play >/dev/null 2>&1; then
                pw-play "$file" &
            elif command -v aplay >/dev/null 2>&1; then
                aplay -q "$file" &
            elif command -v ffplay >/dev/null 2>&1; then
                ffplay -nodisp -autoexit -loglevel quiet "$file" &
            fi
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Git Bash / MSYS2 / Cygwin on Windows
            powershell.exe -NoProfile -Command "(New-Object System.Media.SoundPlayer '$(cygpath -w "$file")').PlaySync()" &
            ;;
    esac
}

play_sound "$SOUND_FILE" 2>/dev/null || true
exit 0
