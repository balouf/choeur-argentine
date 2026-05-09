# History

## TODO

- A-B loop: allow selecting custom loop region on progress bar
- Offline mode: display message when network fails
- Test on Safari mobile
- Minify JS/CSS for production

## 0.3.0 (2026-04-29) : Nettoyage de la coquille PH3

- Suppression des artefacts hérités du template Package Helper 3 :
  configuration Poetry, documentation Sphinx zombie, tests scaffold,
  configurations PyCharm, `CONTRIBUTING.md` et `AUTHORS.md` obsolètes,
  workflow `build.yml` sans tests à exécuter.
- Renommage du workflow `docs.yml` → `site.yml` : il construit le site
  public, pas une documentation Sphinx. Badge README mis à jour.
- `pyproject.toml` allégé : suppression de la config pytest/coverage,
  du dependency-group `dev`, des classifiers Python par mineure, et
  alignement de l'email auteur sur `fabien.mathieu@normalesup.org`.
- Bump CI : Python 3.13, dépin de `uv` (suit la dernière stable).
- `choeur_argentine/__init__.py` réduit à un docstring (la métadonnée
  vit désormais uniquement dans `pyproject.toml`).

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
