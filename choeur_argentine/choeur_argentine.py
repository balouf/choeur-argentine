# !/usr/bin/env python
# coding: utf-8

from pathlib import Path
import os
from datetime import datetime

sources = Path("lilypond")
for f in sources.glob("*"):
    if not (f.is_file() and f.suffix == ".ly"):
        continue
    dest = Path('html') / Path(f"{f.stem}")
    pdf = dest / f"{f.stem}.pdf"
    has_pdf = pdf.exists()
    update = not has_pdf
    if has_pdf:
        pdf_date = datetime.fromtimestamp(pdf.stat().st_mtime)
        ly_date = datetime.fromtimestamp(f.stat().st_mtime)
        if pdf_date < ly_date:
            update = True
    if update:
        print(f"{f} to be compiled!")
        os.system(f'./lilypond-2.24.2/bin/lilypond -dno-point-and-click {f}')
        for midi in Path(".").glob('*.midi'):
            print(midi)
            wav = midi.with_suffix(".wav")
            mp3 = midi.with_suffix(".mp3")
            os.system(f"timidity {midi} -Ow -o {wav}")
            os.system(f'ffmpeg-normalize {wav} -nt peak -t -1 -c:a mp3 -o {mp3}')
            wav.unlink()
        for o in Path(".").glob('*'):
            if o.is_file():
                suf = o.suffix
                if suf not in ['.pdf', '.midi', '.mp3']:
                    continue
                print(o)
                stem = o.stem.replace('--', '-')
                dest.mkdir(exist_ok=True)
                o.replace(dest / f"{stem}{suf}")
