#!/usr/bin/env bash
# Genereert een Software Bill of Materials (CycloneDX/SPDX) in sbom/.
# Een SBOM maakt zichtbaar welke componenten meegaan naar productie en is nodig om snel
# te kunnen antwoorden op de vraag "gebruiken wij component X?" bij een nieuwe CVE.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

cd "${REPO_ROOT}"
mkdir -p sbom
stack="$(detect_stack)"
out="sbom/sbom.cyclonedx.json"

if has syft; then
  log "SBOM via syft"
  syft dir:. -o "cyclonedx-json=${out}"
elif [ "${stack}" = "node" ] && has npx; then
  log "SBOM via @cyclonedx/cyclonedx-npm"
  npx --yes @cyclonedx/cyclonedx-npm --output-file "${out}"
elif [ "${stack}" = "python" ] && has cyclonedx-py; then
  log "SBOM via cyclonedx-py"
  cyclonedx-py environment --output-format json --outfile "${out}"
else
  warn "Geen SBOM-tool beschikbaar (syft, cyclonedx-npm of cyclonedx-py). In CI genereert anchore/sbom-action de SBOM."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: SBOM is verplicht."
  exit 0
fi
ok "SBOM geschreven naar ${out}"
