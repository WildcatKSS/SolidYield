#!/usr/bin/env bash
# End-to-endtests (tests/end-to-end/): de belangrijkste gebruikersreis van begin tot eind.
# Draait tegen een testomgeving met uitsluitend synthetische data.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

export APP_ENV="${APP_ENV:-test}"
export BASE_URL="${BASE_URL:-http://localhost:3000}"
export PROVIDER_MODE="${PROVIDER_MODE:-mock}"
[ "${APP_ENV}" = "production" ] && fail "End-to-endtests draaien nooit tegen productie."

cd "${REPO_ROOT}"
if ! tests_present "tests/end-to-end"; then
  warn "Nog geen end-to-endtests in tests/end-to-end/."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: end-to-endtests zijn verplicht."
  exit 0
fi

log "End-to-endtests tegen ${BASE_URL}"
case "$(detect_stack)" in
  node)
    if   has_npm_script "test:e2e"; then pkg_run "test:e2e"
    elif [ -f playwright.config.ts ] || [ -f playwright.config.js ]; then npx playwright test
    else not_configured "end-to-endtests"; fi
    ;;
  python) python -m pytest tests/end-to-end ;;
  *)      not_configured "end-to-endtests" ;;
esac
ok "End-to-endtests geslaagd."
