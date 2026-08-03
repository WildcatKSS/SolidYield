#!/usr/bin/env bash
# Integratietests (tests/integration/): samenwerking met database, queues en externe
# koppelingen. Externe financiële koppelingen draaien in mock- of sandboxmodus
# (PROVIDER_MODE=mock), nooit tegen productie.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

export APP_ENV="${APP_ENV:-test}"
export PROVIDER_MODE="${PROVIDER_MODE:-mock}"
[ "${PROVIDER_MODE}" = "live" ] && fail "PROVIDER_MODE=live is niet toegestaan in tests."

stack="$(detect_stack)"
cd "${REPO_ROOT}"

if ! tests_present "tests/integration"; then
  warn "Nog geen integratietests in tests/integration/."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: integratietests zijn verplicht."
  exit 0
fi

case "${stack}" in
  node)
    if has_npm_script "test:integration"; then pkg_run "test:integration"; else not_configured "integratietests"; fi ;;
  python)      python -m pytest tests/integration ;;
  go)          go test ./... -tags=integration ;;
  java-maven)  mvn -B -ntp verify -Pintegration ;;
  java-gradle) ./gradlew integrationTest ;;
  dotnet)      dotnet test --filter Category=Integration ;;
  rust)        cargo test --test '*' ;;
  none)        not_configured "integratietests" ;;
esac
ok "Integratietests geslaagd."
