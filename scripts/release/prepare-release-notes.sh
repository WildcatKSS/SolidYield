#!/usr/bin/env bash
# Stelt releasenotes samen uit Conventional Commits sinds de vorige tag.
#   ./scripts/release/prepare-release-notes.sh v1.2.0 > RELEASE_NOTES.md
#
# De gegenereerde notes zijn een concept. De Product Owner controleert ze en vult de
# secties over security-, privacy- en compliance-impact aan vóór publicatie.
set -Eeuo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/ci/common.sh"

VERSION="${1:-${GITHUB_REF_NAME:-}}"
[ -n "${VERSION}" ] || fail "Geef een versie op, bijvoorbeeld: $0 v1.2.0"

cd "${REPO_ROOT}"
PREVIOUS_TAG="$(git describe --tags --abbrev=0 "${VERSION}^" 2>/dev/null || git rev-list --max-parents=0 HEAD | head -1)"
RANGE="${PREVIOUS_TAG}..${VERSION}"
git rev-parse "${VERSION}" >/dev/null 2>&1 || RANGE="${PREVIOUS_TAG}..HEAD"

# LET OP: gebruik hier `if`, geen `[ … ] && printf`. Bij een lege rubriek is dat
# laatste commando de returnwaarde van de functie; onder `set -e` breekt het script
# dan af. Vrijwel elke release mist minstens één rubriek, dus dat is de regel, niet
# de uitzondering.
section() {
  local title="$1" pattern="$2" body
  body="$(git log "${RANGE}" --no-merges --pretty=format:'- %s (%h)' | grep -E "^- ${pattern}" || true)"
  if [ -n "${body}" ]; then
    printf '### %s\n\n%s\n\n' "${title}" "${body}"
  fi
}

cat <<HEADER
# Release ${VERSION}

Wijzigingen sinds \`${PREVIOUS_TAG}\`.

HEADER

section "Toegevoegd"  'feat(\(.*\))?!?:'
section "Opgelost"    'fix(\(.*\))?!?:'
section "Security"    '(sec|security)(\(.*\))?!?:'
section "Prestatie"   'perf(\(.*\))?!?:'
section "Documentatie" 'docs(\(.*\))?!?:'
section "Onderhoud"   '(chore|build|ci|refactor|test|style)(\(.*\))?!?:'

breaking="$(git log "${RANGE}" --no-merges --pretty=format:'- %s (%h)' | grep -E '!:' || true)"
if [ -n "${breaking}" ]; then
  printf '### ⚠️ Breaking changes\n\n%s\n\n' "${breaking}"
fi

cat <<'FOOTER'
---

### Vóór publicatie in te vullen door het team

- **Releasekanaal:** intern prototype / testgroepversie / bèta / beperkte productie-uitrol / algemene beschikbaarheid
- **Security-impact:** _(openstaande bevindingen? scanresultaten bijgevoegd?)_
- **Privacy-impact:** _(nieuwe verwerkingen? DPIA bijgewerkt?)_
- **Compliance-impact:** _(geraakte controls, bewijs vastgelegd?)_
- **Datamigraties:** _(uitgevoerd, terugdraaibaar?)_
- **Rollbackplan:** _(methode en verwachte hersteltijd)_
- **Goedkeuringen:** Product Owner / Security / Compliance
- **Bekende beperkingen:**

Volledige checklist: `docs/releases/release-checklist.md`.
FOOTER
