#!/usr/bin/env bash
# Lint en formatteercontrole.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

stack="$(detect_stack)"
cd "${REPO_ROOT}"
status=0

# Altijd: shellscripts in deze repository controleren wanneer shellcheck beschikbaar is.
if has shellcheck; then
  log "shellcheck op scripts/"
  shellcheck -S warning scripts/*.sh scripts/**/*.sh || status=1
else
  warn "shellcheck niet geïnstalleerd; shellscripts niet gecontroleerd."
fi

case "${stack}" in
  node)
    if has_npm_script lint; then pkg_run lint || status=1; else warn "Geen npm-script 'lint'. Voeg ESLint + Prettier toe."; fi
    ;;
  python)
    if has ruff; then ruff check . || status=1; ruff format --check . || status=1
    else warn "ruff niet geïnstalleerd; voeg ruff (of flake8 + black) toe aan de dev-dependencies."; fi
    ;;
  go)          gofmt -l . | tee /dev/stderr | (! read -r); go vet ./... || status=1 ;;
  java-maven)  mvn -B -ntp verify -DskipTests || status=1 ;;
  java-gradle) ./gradlew check -x test || status=1 ;;
  dotnet)      dotnet format --verify-no-changes || status=1 ;;
  rust)        cargo fmt --check || status=1; cargo clippy -- -D warnings || status=1 ;;
  none)        not_configured "lint" ;;
esac

[ "${status}" -eq 0 ] || fail "Lint gaf fouten."
ok "Lint geslaagd."
