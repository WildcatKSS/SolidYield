#!/usr/bin/env python3
"""Controleert dat elke externe GitHub Action op een volledige commit-SHA staat.

Een tag kan naar andere code worden verplaatst, een commit-SHA niet. Deze controle
rapporteert per bevinding het exacte bestand, het regelnummer en de aangetroffen
`uses:`-waarde, zodat de melding direct bruikbaar is.

Overgeslagen:
  * lokale composite actions en herbruikbare workflows (`uses: ./…`);
  * Docker-actions (`uses: docker://…`) — die kennen geen commit-SHA.

Gebruik:
  check-action-pins.py [PAD ...]      controleer (standaard: .github)
  check-action-pins.py --self-test    voer de zelftest uit
"""
from __future__ import annotations

import re
import sys
import tempfile
from pathlib import Path

# `uses:` mag tussen aanhalingstekens staan, een commentaar achter zich hebben en een
# ${{ … }}-expressie bevatten (die laatste is juist een bevinding, geen reden om de regel
# over te slaan).
USES = re.compile(r"""^\s*-?\s*uses\s*:\s*(?P<rest>.+?)\s*$""")
COMMENT = re.compile(r"""\s+#.*$""")
FULL_SHA = re.compile(r"^[0-9a-f]{40}$")


def _clean(rest: str) -> str:
    """Haal een eventueel commentaar en omringende aanhalingstekens weg."""
    ref = COMMENT.sub("", rest).strip()
    if len(ref) >= 2 and ref[0] == ref[-1] and ref[0] in "\"'":
        ref = ref[1:-1].strip()
    return ref


def findings(root: Path) -> list[tuple[Path, int, str, str]]:
    """Geeft (bestand, regelnummer, uses-waarde, reden) voor elke ongepinde action."""
    out: list[tuple[Path, int, str, str]] = []
    for path in sorted(root.rglob("*.y*ml")):
        try:
            lines = path.read_text(encoding="utf-8").splitlines()
        except (OSError, UnicodeDecodeError):
            continue
        for number, line in enumerate(lines, start=1):
            match = USES.match(line)
            if not match:
                continue
            ref = _clean(match.group("rest"))
            if not ref:
                continue

            if ref.startswith((".", "/")):
                continue  # lokale action of herbruikbare workflow
            if ref.startswith("docker://"):
                continue  # Docker-image, geen commit-SHA mogelijk

            if "${{" in ref:
                out.append((path, number, ref, "expressie in plaats van een vaste SHA"))
                continue
            if "@" not in ref:
                out.append((path, number, ref, "geen versie of SHA opgegeven"))
                continue

            version = ref.rsplit("@", 1)[1]
            if not FULL_SHA.fullmatch(version):
                reden = (
                    "verkorte SHA"
                    if re.fullmatch(r"[0-9a-f]{7,39}", version)
                    else "tag of branch in plaats van een commit-SHA"
                )
                out.append((path, number, ref, reden))
    return out


def check(paths: list[str]) -> int:
    problems: list[tuple[Path, int, str, str]] = []
    for raw in paths:
        problems.extend(findings(Path(raw)))
    for path, number, ref, reden in problems:
        print(f"{path}:{number}: {ref} — {reden}", file=sys.stderr)
    if problems:
        print(
            f"\n{len(problems)} action(s) niet op een volledige commit-SHA vastgezet. "
            "Zoek de SHA op met: git ls-remote https://github.com/<owner>/<repo> "
            "refs/tags/<tag>^{}",
            file=sys.stderr,
        )
        return 1
    return 0


# ---------------------------------------------------------------------------
# Zelftest
# ---------------------------------------------------------------------------
SHA = "3d3c42e5aac5ba805825da76410c181273ba90b1"

CASES: list[tuple[str, str, bool]] = [
    # (naam, yaml-fragment, moet_falen)
    ("tag @v4", "      - uses: actions/checkout@v4\n", True),
    ("tag met commentaar", "      - uses: actions/checkout@v4 # pinned\n", True),
    ("verkorte SHA", "      - uses: actions/checkout@3d3c42e\n", True),
    ("geen versie", "      - uses: actions/checkout\n", True),
    ("expressie", "      - uses: actions/checkout@${{ env.REF }}\n", True),
    ("volledige SHA", f"      - uses: actions/checkout@{SHA}\n", False),
    ("volledige SHA + commentaar", f"      - uses: actions/checkout@{SHA} # v7.0.1\n", False),
    ("volledige SHA tussen quotes", f'      - uses: "actions/checkout@{SHA}"\n', False),
    ("lokale action", "      - uses: ./.github/actions/setup-stack\n", False),
    ("lokale workflow", "    uses: ./.github/workflows/ci.yml\n", False),
    ("docker-action", "      - uses: docker://alpine:3.20\n", False),
]


def self_test() -> int:
    failures = 0
    with tempfile.TemporaryDirectory() as tmp:
        for index, (naam, fragment, moet_falen) in enumerate(CASES):
            directory = Path(tmp) / f"case{index}"
            directory.mkdir()
            (directory / "wf.yml").write_text(
                "on: push\njobs:\n  a:\n    runs-on: ubuntu-latest\n    steps:\n" + fragment,
                encoding="utf-8",
            )
            gevonden = bool(findings(directory))
            geslaagd = gevonden == moet_falen
            status = "ok  " if geslaagd else "FOUT"
            verwacht = "moet falen" if moet_falen else "moet slagen"
            print(f"  [{status}] {naam:32} ({verwacht})")
            if not geslaagd:
                failures += 1
    if failures:
        print(f"\nZelftest mislukt: {failures} geval(len).", file=sys.stderr)
        return 1
    print(f"\nZelftest geslaagd: {len(CASES)} gevallen.")
    return 0


def main() -> int:
    args = sys.argv[1:]
    if args and args[0] == "--self-test":
        return self_test()
    return check(args or [".github"])


if __name__ == "__main__":
    raise SystemExit(main())
