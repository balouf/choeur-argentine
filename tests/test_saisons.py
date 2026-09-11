"""Le manifeste de saison doit rester en phase avec lilypond/.

Le seul vrai risque de dérive : une pièce citée dans saisons.toml dont le .ly a
été renommé ou supprimé. Le build ne s'en apercevrait qu'en CI, après coup.
"""

import tomllib
from pathlib import Path

import pytest

from deploy import lire_manifeste, pieces_de_saison

RACINE = Path(__file__).resolve().parent.parent
MANIFESTE = RACINE / "saisons.toml"
SOURCES = RACINE / "lilypond"


def saisons():
    with open(MANIFESTE, "rb") as f:
        return tomllib.load(f)["saisons"]


@pytest.mark.parametrize("saison", sorted(saisons()))
def test_pieces_declarees_existent(saison):
    """Toutes les saisons, pas seulement l'active : une saison passée doit rester
    reconstructible. Une saison vide est licite (programme en préparation) ;
    pieces_de_saison lève si un nom cité n'a pas de .ly."""
    pieces_de_saison(MANIFESTE, saison, SOURCES)


def test_saison_active_non_vide():
    """La saison que la CI publie doit avoir de quoi construire un site."""
    actif, _ = lire_manifeste(MANIFESTE)
    assert pieces_de_saison(MANIFESTE, actif, SOURCES)


def test_saison_inconnue_rejetee():
    with pytest.raises(ValueError, match="saison inconnue"):
        pieces_de_saison(MANIFESTE, "1789-1790", SOURCES)


def test_piece_absente_signalee(tmp_path):
    manifeste = tmp_path / "saisons.toml"
    manifeste.write_text(
        'actif = "test"\n[saisons."test"]\npieces = ["nexiste-pas"]\n',
        encoding="utf8",
    )
    with pytest.raises(FileNotFoundError, match="nexiste-pas"):
        pieces_de_saison(manifeste, sources=SOURCES)
