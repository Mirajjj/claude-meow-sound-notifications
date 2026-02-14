# Claude Code Meow Sound Notifications

A Claude Code plugin that plays cat meow `.wav` sounds on Claude Code events (session start, permission prompts, idle prompts, auth success, elicitation dialogs).

## Project Structure

```
.
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest (name, version, metadata)
│   └── marketplace.json     # Marketplace definition for plugin discovery/install
├── hooks/
│   └── hooks.json           # Hook definitions mapping Claude Code events to sounds
├── scripts/
│   └── play.sh              # Cross-platform sound playback script (macOS/Linux/WSL/Windows)
├── sounds/                  # WAV files (PCM 16-bit LE, 44.1kHz)
│   ├── m-e-o-w.wav          # Slow drawn-out meow (session start, auth success)
│   ├── meow_1_normal.wav    # Standard meow (random pool)
│   ├── meow_2_long.wav      # Longer meow (random pool)
│   ├── meow_3_extra_long.wav # Extra long meow (elicitation dialog)
│   ├── meow_4_sad.wav       # Sad meow (unused, available for customization)
│   ├── meow_5_quick.wav     # Quick meow (random pool)
│   └── meow_6_quick_2.wav   # Quick meow variant (random pool)
├── .gitattributes           # Marks .wav files as binary
├── LICENSE                  # MIT
└── README.md
```

## How It Works

1. **Plugin registration**: `.claude-plugin/plugin.json` declares the plugin identity.
2. **Event hooks**: `hooks/hooks.json` maps Claude Code events (`SessionStart`, `Notification` with matchers) to shell commands that invoke `scripts/play.sh` with a sound name or `random`.
3. **Playback**: `scripts/play.sh` resolves the sound file, detects the OS, and plays via the appropriate system audio command (`afplay`, `paplay`, `pw-play`, `aplay`, `ffplay`, or PowerShell). It always exits 0 to never block Claude Code.

## Key Details

- `play.sh` uses `${CLAUDE_PLUGIN_ROOT}` (set by Claude Code) to locate sounds relative to the plugin directory.
- The "random" mode picks from a hardcoded pool of 4 sounds in `play.sh`.
- All playback is backgrounded (`&`) so hooks return immediately.
- No dependencies beyond a system audio player.
