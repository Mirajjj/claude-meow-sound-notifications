# claude-meow-sound-notifications

A Claude Code plugin that plays cat meow sounds on various events, so you never miss when Claude needs your attention.

## Sound Events

| Event | Sound | When it triggers |
|---|---|---|
| Session start | `m-e-o-w` (slow) | Claude Code session begins |
| Permission prompt | Random meow | Claude needs tool approval |
| Idle prompt | Random meow | Claude is waiting for input |
| Auth success | `m-e-o-w` (slow) | Authentication completes |
| Elicitation dialog | `meow_3_extra_long` | Claude asks a question |

The **random** pool picks from: `meow_1_normal`, `meow_2_long`, `meow_5_quick`, `meow_6_quick_2`.

## Installation

### As a Claude Code plugin

```bash
claude plugin add /path/to/claude-meow-sound-notifications
```

Or clone and add:

```bash
git clone https://github.com/hermanleus/claude-meow-sound-notifications.git
claude plugin add ./claude-meow-sound-notifications
```

### Manual (copy hooks to settings)

If you prefer not to use the plugin system, you can add the hooks directly to `~/.claude/settings.json`. See `hooks/hooks.json` for the hook definitions and adapt the paths.

## Platform Support

| Platform | Audio Player | Status |
|---|---|---|
| macOS | `afplay` (built-in) | Works out of the box |
| Linux (PulseAudio) | `paplay` | Works out of the box |
| Linux (PipeWire) | `pw-play` | Works out of the box |
| Linux (ALSA) | `aplay` | Works out of the box |
| Linux (ffmpeg) | `ffplay` | Fallback option |
| WSL | PowerShell `SoundPlayer` | Works out of the box |
| Windows (Git Bash) | PowerShell `SoundPlayer` | Works out of the box |

### Linux: Install an audio player

Most Linux desktops already have one of these. If not:

```bash
# PulseAudio (Ubuntu/Debian)
sudo apt install pulseaudio-utils

# PipeWire (Fedora 34+)
sudo dnf install pipewire-utils

# ALSA (minimal setups)
sudo apt install alsa-utils

# ffmpeg (universal fallback)
sudo apt install ffmpeg
```

## Customization

### Add your own sounds

1. Place `.wav` files (PCM 16-bit, 44.1kHz) in the `sounds/` directory
2. Reference them by name (without extension) in `hooks/hooks.json`

### Change the random pool

Edit `scripts/play.sh` and modify the `POOL` array:

```bash
POOL=("meow_1_normal" "meow_2_long" "meow_5_quick" "meow_6_quick_2")
```

### Change which events trigger sounds

Edit `hooks/hooks.json` to add, remove, or modify event handlers. See the [Claude Code hooks documentation](https://docs.anthropic.com/en/docs/claude-code/hooks) for available events.

## Sounds

All sounds are WAV files (PCM 16-bit LE, 44.1kHz) for maximum cross-platform compatibility. Total size: ~2.1MB.

| File | Duration | Description |
|---|---|---|
| `m-e-o-w.wav` | 1.9s | Slow, drawn-out meow |
| `meow_1_normal.wav` | 0.9s | Standard meow |
| `meow_2_long.wav` | 1.8s | Longer meow |
| `meow_3_extra_long.wav` | 3.0s | Extra long meow |
| `meow_4_sad.wav` | 2.8s | Sad meow |
| `meow_5_quick.wav` | 1.0s | Quick meow |
| `meow_6_quick_2.wav` | 1.1s | Quick meow variant |

## License

MIT
