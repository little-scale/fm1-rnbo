#!/usr/bin/env python3
"""Generate this player's black-and-white Arial fonts without changing other apps."""
import importlib.util
import os
from pathlib import Path
import sys
BASE = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location("player_font_generator", BASE / "tools/gen_font.py")
gen = importlib.util.module_from_spec(spec)
spec.loader.exec_module(gen)
family = os.environ.get("RNBO_PLAYER_FONT", "arial")
if family not in ("arial", "barlow"):
    raise SystemExit("RNBO_PLAYER_FONT must be arial or barlow")
gen.FONTSET = family
gen.FONTDIRS += [Path("/System/Library/Fonts/Supplemental")]
# Custom font search paths remain supported via X0X_FONT_DIRS.
# Binary glyph coverage keeps small labels at full contrast instead of grey.
gen.SIZES = [(role, face, px, 1, True, 32, last) for role, face, px, last in [
    ("GRAPH", "Arial.ttf", 7, 126),
    ("T", "Arial.ttf", 10, 95),
    ("XS", "Arial.ttf", 12, 126),
    ("S", "Arial.ttf", 15, 126),
    ("B", "Arial Bold.ttf", 15, 126),
    ("M", "Arial.ttf", 23, 95),
    ("L", "Arial Bold.ttf", 31, 95),
]]
if family == "barlow":
    # Vendored OFL fonts for redistributable builds; retain binary coverage.
    gen.SIZES = [(role, "BarlowSemiCondensed-Bold.ttf" if role in ("B", "L") else
                  "BarlowSemiCondensed-Medium.ttf", px, scale, pixel, first, last)
                 for role, _, px, scale, pixel, first, last in gen.SIZES]
gen.main(sys.argv[1])
