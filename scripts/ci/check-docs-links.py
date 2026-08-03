#!/usr/bin/env python3
"""Twee controles op de Markdowndocumentatie.

A. **Gebroken relatieve links** — elk relatief linkdoel moet bestaan. Externe links,
   `mailto:` en anchors binnen hetzelfde document worden overgeslagen.

B. **Verweesde documenten** — een document telt alleen als bereikbaar wanneer het via
   échte relatieve links vanaf een ingang te bereiken is. Een losse naamovereenkomst
   ergens in een tekst is nadrukkelijk niet genoeg: die zou een document bereikbaar laten
   lijken terwijl niemand er ooit heen navigeert.

Gebruik:
  check-docs-links.py [WORTEL]        controleer (standaard: huidige map)
  check-docs-links.py --self-test     voer de zelftest uit
"""
from __future__ import annotations

import re
import sys
import tempfile
from pathlib import Path
from urllib.parse import unquote, urlparse

# Ingangen van waaruit de documentatie doorzoekbaar moet zijn.
ENTRY_POINTS = ("README.md", "START-HERE.md", "docs/README.md")

# Documenten die bewust alleen door GitHub zelf worden gebruikt en dus geen inkomende
# link hoeven te hebben.
ORPHAN_ALLOWLIST = {
    ".github/PULL_REQUEST_TEMPLATE.md",
}

SKIP_DIRS = {".git", "node_modules", ".venv", "dist", "build"}

# Inline links en afbeeldingen: [tekst](doel) en ![alt](doel)
LINK = re.compile(r"!?\[[^\]]*\]\(\s*<?([^)\s>]+)>?(?:\s+\"[^\"]*\")?\s*\)")
# Referentiestijl: [label]: doel
REFDEF = re.compile(r"^\s{0,3}\[[^\]]+\]:\s*<?([^\s>]+)>?", re.MULTILINE)
FENCE = re.compile(r"```.*?```", re.DOTALL)


def markdown_files(root: Path) -> list[Path]:
    out = []
    for path in root.rglob("*.md"):
        if any(part in SKIP_DIRS for part in path.parts):
            continue
        out.append(path)
    return sorted(out)


# Routes van de GitHub-webinterface: die verwijzen niet naar een bestand in de checkout
# maar naar een pagina (nieuw issue, blob-weergave, discussies, security advisories).
# Ze worden gerenderd vanuit een issue-, PR- of templatecontext en zijn dus geen
# repositorypad dat wij kunnen valideren.
UI_ROUTES = ("/issues/", "/blob/", "/tree/", "/discussions", "/security/advisories", "/pull/")


def _is_external(target: str) -> bool:
    if target.startswith(("#", "mailto:", "tel:")):
        return True
    if any(route in target for route in UI_ROUTES):
        return True
    scheme = urlparse(target).scheme
    return scheme in {"http", "https", "ftp", "mailto"}


def _resolve(source: Path, root: Path, target: str) -> Path | None:
    """Zet een linkdoel om naar een pad; None als het geen bestandslink is."""
    clean = unquote(target.split("#", 1)[0].split("?", 1)[0]).strip()
    if not clean:
        return None  # puur een anchor
    base = root if clean.startswith("/") else source.parent
    candidate = (base / clean.lstrip("/")).resolve()
    if candidate.is_dir():
        # Een directorylink verwijst impliciet naar de README erin.
        readme = candidate / "README.md"
        return readme if readme.exists() else candidate
    return candidate


def links_in(path: Path) -> list[tuple[int, str]]:
    """Geeft (regelnummer, doel) voor elke link, buiten codeblokken."""
    text = path.read_text(encoding="utf-8")
    # Codeblokken vervangen door lege regels: zo blijven regelnummers kloppen.
    text = FENCE.sub(lambda m: "\n" * m.group(0).count("\n"), text)
    out: list[tuple[int, str]] = []
    for number, line in enumerate(text.splitlines(), start=1):
        for match in LINK.finditer(line):
            out.append((number, match.group(1)))
        for match in REFDEF.finditer(line):
            out.append((number, match.group(1)))
    return out


def check_broken(root: Path) -> list[str]:
    problems: list[str] = []
    for path in markdown_files(root):
        for number, target in links_in(path):
            if _is_external(target):
                continue
            resolved = _resolve(path, root, target)
            if resolved is None:
                continue
            if not resolved.is_relative_to(root):
                continue  # wijst buiten de repository — geen documentlink
            if not resolved.exists():
                rel = path.relative_to(root)
                try:
                    shown = resolved.relative_to(root)
                except ValueError:
                    shown = resolved
                problems.append(f"{rel}:{number}: '{target}' → {shown} bestaat niet")
    return problems


def check_orphans(root: Path) -> list[str]:
    """Bouwt een linkgraph vanaf de ingangen en meldt onbereikbare documenten."""
    all_docs = {p.resolve() for p in markdown_files(root)}
    entries = [(root / e).resolve() for e in ENTRY_POINTS if (root / e).exists()]

    reachable: set[Path] = set()
    queue = list(entries)
    while queue:
        current = queue.pop()
        if current in reachable or not current.exists():
            continue
        reachable.add(current)
        if current.suffix.lower() != ".md":
            continue
        for _, target in links_in(current):
            if _is_external(target):
                continue
            resolved = _resolve(current, root, target)
            if resolved and resolved.suffix.lower() == ".md" and resolved not in reachable:
                queue.append(resolved)

    allowed = {(root / a).resolve() for a in ORPHAN_ALLOWLIST}
    orphans = sorted(all_docs - reachable - allowed)
    return [
        f"{p.relative_to(root)}: geen enkele relatieve link vanaf "
        f"{', '.join(ENTRY_POINTS)} leidt hierheen"
        for p in orphans
    ]


def run(root: Path) -> int:
    broken = check_broken(root)
    orphans = check_orphans(root)
    for line in broken:
        print(f"[gebroken link] {line}", file=sys.stderr)
    for line in orphans:
        print(f"[verweesd] {line}", file=sys.stderr)
    if broken or orphans:
        print(
            f"\n{len(broken)} gebroken link(s), {len(orphans)} verweesd document(en).",
            file=sys.stderr,
        )
        return 1
    total = len(markdown_files(root))
    print(f"{total} documenten: alle relatieve links kloppen, geen verweesde documenten.")
    return 0


# ---------------------------------------------------------------------------
# Zelftest
# ---------------------------------------------------------------------------
def self_test() -> int:
    failures = 0

    def case(naam: str, bestanden: dict[str, str], verwacht_broken: int, verwacht_orphans: int) -> None:
        nonlocal failures
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            for naam_bestand, inhoud in bestanden.items():
                pad = root / naam_bestand
                pad.parent.mkdir(parents=True, exist_ok=True)
                pad.write_text(inhoud, encoding="utf-8")
            broken = check_broken(root)
            orphans = check_orphans(root)
            ok = len(broken) == verwacht_broken and len(orphans) == verwacht_orphans
            status = "ok  " if ok else "FOUT"
            print(
                f"  [{status}] {naam:52} "
                f"gebroken={len(broken)}/{verwacht_broken} verweesd={len(orphans)}/{verwacht_orphans}"
            )
            if not ok:
                failures += 1
                for regel in broken + orphans:
                    print(f"          {regel}")

    case(
        "correct gelinkt document",
        {"README.md": "[docs](docs/gids.md)\n", "docs/gids.md": "# Gids\n"},
        0, 0,
    )
    case(
        "indirect bereikbaar via een ander document",
        {
            "README.md": "[gids](docs/gids.md)\n",
            "docs/gids.md": "[diep](diep.md)\n",
            "docs/diep.md": "# Diep\n",
        },
        0, 0,
    )
    case(
        "gebroken link",
        {"README.md": "[weg](docs/bestaat-niet.md)\n"},
        1, 0,
    )
    case(
        "kapotte link met de juiste basename",
        {
            "README.md": "[gids](docs/verkeerd/gids.md)\n",
            "docs/gids.md": "# Gids\n",
        },
        1, 1,
    )
    case(
        "bestandsnaam alleen als gewone tekst",
        {"README.md": "Zie het bestand gids.md verderop.\n", "docs/gids.md": "# Gids\n"},
        0, 1,
    )
    case(
        "twee bestanden met dezelfde basename, één gelinkt",
        {
            "README.md": "[a](docs/a/gids.md)\n",
            "docs/a/gids.md": "# A\n",
            "docs/b/gids.md": "# B\n",
        },
        0, 1,
    )
    case(
        "directorylink naar README.md in die map",
        {"README.md": "[map](docs/)\n", "docs/README.md": "# Index\n"},
        0, 0,
    )
    case(
        "link met anchor",
        {"README.md": "[gids](docs/gids.md#kop)\n", "docs/gids.md": "# Kop\n"},
        0, 0,
    )
    case(
        "anchor binnen hetzelfde document",
        {"README.md": "[kop](#kop)\n\n# Kop\n"},
        0, 0,
    )
    case(
        "externe links worden overgeslagen",
        {"README.md": "[x](https://example.invalid) [m](mailto:a@example.invalid)\n"},
        0, 0,
    )
    case(
        "link binnen een codeblok telt niet",
        {"README.md": "```\n[nep](nergens.md)\n```\n"},
        0, 0,
    )
    case(
        "URL-encoded pad",
        {"README.md": "[g](docs/mijn%20gids.md)\n", "docs/mijn gids.md": "# G\n"},
        0, 0,
    )
    case(
        "PR-template hoeft geen inkomende link",
        {"README.md": "# Root\n", ".github/PULL_REQUEST_TEMPLATE.md": "# PR\n"},
        0, 0,
    )
    case(
        "GitHub-UI-route wordt overgeslagen",
        {"README.md": "[nieuw](../../issues/new?template=bug-report.yml)\n"},
        0, 0,
    )
    case(
        "link buiten de repositorywortel wordt overgeslagen",
        {"README.md": "[weg](../../../ergens.md)\n"},
        0, 0,
    )

    if failures:
        print(f"\nZelftest mislukt: {failures} geval(len).", file=sys.stderr)
        return 1
    print("\nZelftest geslaagd: 15 gevallen.")
    return 0


def main() -> int:
    args = sys.argv[1:]
    if args and args[0] == "--self-test":
        return self_test()
    return run(Path(args[0] if args else ".").resolve())


if __name__ == "__main__":
    raise SystemExit(main())
