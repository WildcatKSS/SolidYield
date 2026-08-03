#!/usr/bin/env bash
# Draait de volledige lokale kwaliteitsketen, in dezelfde volgorde als CI.
# Gebruik dit vóór het openen van een pull request.
set -Eeuo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/common.sh"

steps=(build.sh lint.sh test-unit.sh test-integration.sh coverage-check.sh test-security.sh test-accessibility.sh license-check.sh)
failed=()

for step in "${steps[@]}"; do
  log "── ${step} ─────────────────────────────"
  if ! "${HERE}/${step}"; then failed+=("${step}"); fi
done

# Rooktest op de releasenotesgenerator. Dat script draait normaal alleen in de
# release-workflow, dus een fout erin blijft onopgemerkt tot het moment waarop je
# hem het minst kunt gebruiken: midden in een release. Draai hem hier tegen de meest
# recente tag, of tegen de volledige historie wanneer er nog geen tag is.
log "── release/prepare-release-notes.sh (rooktest) ─────────────────────────────"
smoke_version="$(git describe --tags --abbrev=0 2>/dev/null || echo 'v0.0.0')"
if "${HERE}/../release/prepare-release-notes.sh" "${smoke_version}" >/dev/null; then
  ok "releasenotes worden gegenereerd (${smoke_version})"
else
  failed+=("release/prepare-release-notes.sh")
fi

if [ ${#failed[@]} -gt 0 ]; then
  fail "Mislukte stappen: ${failed[*]}"
fi
ok "Alle lokale controles zijn geslaagd."
echo
echo "Niet lokaal gedekt (draait in CI): secret scanning, SAST, dependency review, containerscan."
