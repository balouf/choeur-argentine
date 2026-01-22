# History

## TODO

- A-B loop: allow selecting custom loop region on progress bar
- Offline mode: display message when network fails
- Test on Safari mobile
- Minify JS/CSS for production

## 0.2.0 (2025-01-22): Frontend refactoring

- Complete frontend rewrite with modern ES modules architecture
- New MIDI player with deferred AudioContext initialization (fixes browser autoplay restrictions)
- New MP3 player with Tone.js time-stretch (tempo change without pitch shift)
- Mixer component with per-track volume control, mute, solo, and instrument selection
- Loop functionality for both MIDI and MP3 players
- Responsive design with CSS variables and mobile support
- Keyboard shortcuts (Space, arrows, L, M)
- Preset system for saving/loading mixer settings
- Default volumes: 15% for voice tracks (brass), 10% for others
- Local favicon
- Updated tips section with MIDI vs MP3 guidance
- Fixed Python 3.10+ compatibility in deploy.py (os.walk instead of Path.walk)
- Fixed Windows encoding issues in subprocess calls
- Updated CI/CD to Python 3.10+

## 0.1.0 (2024-09-30): First release

- First release on PyPI.
