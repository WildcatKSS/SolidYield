#!/usr/bin/env bash
# Bouwt de applicatie. Stack-agnostisch; vult zichzelf in zodra er een manifest is.
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

stack="$(detect_stack)"
log "Gedetecteerde stack: ${stack}"
cd "${REPO_ROOT}"

case "${stack}" in
  node)
    if [ -f package-lock.json ]; then npm ci; elif [ -f pnpm-lock.yaml ] && has pnpm; then pnpm install --frozen-lockfile; elif [ -f yarn.lock ] && has yarn; then yarn install --frozen-lockfile; else npm install; fi
    if has_npm_script build; then pkg_run build; else warn "Geen npm-script 'build'; overgeslagen."; fi
    ;;
  python)
    python -m pip install --upgrade pip
    if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
    if [ -f pyproject.toml ]; then pip install -e ".[dev]" || pip install -e . || warn "Editable install mislukt; controleer pyproject.toml."; fi
    ;;
  go)          go build ./... ;;
  java-maven)  mvn -B -ntp package -DskipTests ;;
  java-gradle) ./gradlew build -x test ;;
  dotnet)      dotnet build --configuration Release ;;
  rust)        cargo build --release ;;
  none)        not_configured "build" ;;
esac
ok "Build afgerond."
