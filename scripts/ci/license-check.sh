#!/usr/bin/env bash
# Licentiecontrole op afhankelijkheden.
#
# Beleid (AANNAME — te bevestigen door [LEGAL/COMPLIANCE]):
#   Toegestaan : MIT, ISC, BSD-2-Clause, BSD-3-Clause, Apache-2.0, 0BSD, Unlicense, CC0-1.0, Python-2.0
#   Verboden   : AGPL-3.0, SSPL-1.0 en andere sterke copyleftlicenties zonder juridisch akkoord
#   Beoordelen : GPL-*, LGPL-*, MPL-2.0, onbekend of ontbrekend
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

ALLOWED="${LICENSE_ALLOWLIST:-MIT;ISC;BSD-2-Clause;BSD-3-Clause;Apache-2.0;0BSD;Unlicense;CC0-1.0;Python-2.0}"
DENIED="${LICENSE_DENYLIST:-AGPL-3.0;AGPL-3.0-only;AGPL-3.0-or-later;SSPL-1.0}"
cd "${REPO_ROOT}"

case "$(detect_stack)" in
  node)
    if has npx; then
      log "Licentiecontrole via license-checker"
      npx --yes license-checker --production --summary || true
      npx --yes license-checker --production --failOn "${DENIED}" \
        || fail "Verboden licentie aangetroffen. Zie het beleid boven in dit script."
    else
      not_configured "licentiecontrole"
    fi
    ;;
  python)
    if has pip-licenses; then
      pip-licenses --format=markdown --with-license-file --no-license-path
      pip-licenses --format=json | grep -Ei 'AGPL|SSPL' && fail "Verboden licentie aangetroffen." || true
    else
      not_configured "licentiecontrole"
    fi
    ;;
  *)
    warn "Licentiecontrole nog niet ingevuld voor deze stack. In CI dekt dependency-review.yml de belangrijkste gevallen af."
    [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: licentiecontrole is verplicht."
    exit 0
    ;;
esac
ok "Licentiecontrole afgerond. Toegestaan: ${ALLOWED}"
