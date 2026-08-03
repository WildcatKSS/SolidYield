#!/usr/bin/env bash
# Securitytests (tests/security/): geautomatiseerde controles op misbruikscenario's,
# bijvoorbeeld autorisatie op objectniveau, sessieverloop, rate limiting, invoervalidatie
# en het niet lekken van gevoelige gegevens in fouten en logs.
#
# Dit vervangt geen pentest of dreigingsanalyse; zie docs/security/security-testing.md.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

export APP_ENV="${APP_ENV:-test}"
export PROVIDER_MODE="${PROVIDER_MODE:-mock}"
cd "${REPO_ROOT}"

if ! tests_present "tests/security"; then
  warn "Nog geen securitytests in tests/security/. Zie tests/security/README.md voor de minimale set."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: securitytests zijn verplicht."
  exit 0
fi

case "$(detect_stack)" in
  node)
    if has_npm_script "test:security"; then pkg_run "test:security"; else not_configured "securitytests"; fi ;;
  python) python -m pytest tests/security ;;
  go)     go test ./tests/security/... ;;
  *)      not_configured "securitytests" ;;
esac
ok "Securitytests geslaagd."
