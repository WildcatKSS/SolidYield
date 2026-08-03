#!/usr/bin/env bash
# Unit tests (tests/unit/). Draait met coveragerapportage waar de stack dat ondersteunt.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

stack="$(detect_stack)"
cd "${REPO_ROOT}"

if ! tests_present "tests/unit"; then
  warn "Nog geen unittests in tests/unit/."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: unittests zijn verplicht."
  exit 0
fi

case "${stack}" in
  node)
    if has_npm_script "test:unit"; then pkg_run "test:unit"
    elif has_npm_script test;      then pkg_run test
    else not_configured "unit tests"; fi
    ;;
  python)      python -m pytest tests/unit --cov --cov-report=xml --cov-report=term ;;
  go)          go test ./... -race -coverprofile=coverage.out ;;
  java-maven)  mvn -B -ntp test ;;
  java-gradle) ./gradlew test ;;
  dotnet)      dotnet test --collect:"XPlat Code Coverage" ;;
  rust)        cargo test ;;
  none)        not_configured "unit tests" ;;
esac
ok "Unit tests geslaagd."
