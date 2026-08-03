#!/usr/bin/env bash
# Toegankelijkheidscontrole (tests/accessibility/), streefniveau WCAG 2.2 AA.
#
# Geautomatiseerde tests vinden ongeveer een derde van de toegankelijkheidsproblemen.
# Handmatige controle (toetsenbord, schermlezer, begrijpelijke taal) blijft verplicht —
# zie docs/scrum/definition-of-done.md.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

export BASE_URL="${BASE_URL:-http://localhost:3000}"
cd "${REPO_ROOT}"

if ! tests_present "tests/accessibility"; then
  warn "Nog geen toegankelijkheidstests in tests/accessibility/."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: toegankelijkheidstests zijn verplicht."
  exit 0
fi

case "$(detect_stack)" in
  node)
    if   has_npm_script "test:a11y"; then pkg_run "test:a11y"
    elif [ -f .pa11yci ] || [ -f .pa11yci.json ]; then npx pa11y-ci
    else not_configured "toegankelijkheidstests"; fi
    ;;
  python) python -m pytest tests/accessibility ;;
  *)      not_configured "toegankelijkheidstests" ;;
esac
ok "Toegankelijkheidstests geslaagd."
