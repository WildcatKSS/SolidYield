#!/usr/bin/env bash
# Zet een lokale ontwikkelomgeving op.
#   ./scripts/bootstrap.sh
set -Eeuo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ci/common.sh"

cd "${REPO_ROOT}"

if [ ! -f .env ]; then
  cp .env.example .env
  ok ".env aangemaakt op basis van .env.example — vul lokale waarden in."
  warn "Zet nooit echte secrets, productiesleutels of persoonsgegevens in .env."
else
  log ".env bestaat al; niet overschreven."
fi

if [ -d .git ] && [ -d .githooks ]; then
  git config core.hooksPath .githooks
  ok "Git hooks geactiveerd (.githooks)."
fi

stack="$(detect_stack)"
log "Gedetecteerde stack: ${stack}"

case "${stack}" in
  node)
    if   [ -f package-lock.json ]; then npm ci
    elif [ -f pnpm-lock.yaml ] && has pnpm; then pnpm install
    elif [ -f yarn.lock ] && has yarn; then yarn install
    else npm install; fi
    ;;
  python)
    [ -d .venv ] || python -m venv .venv
    # shellcheck disable=SC1091
    source .venv/bin/activate
    pip install --upgrade pip
    [ -f requirements.txt ] && pip install -r requirements.txt
    [ -f pyproject.toml ] && { pip install -e ".[dev]" || pip install -e .; }
    ;;
  go)          go mod download ;;
  java-maven)  mvn -B -ntp dependency:go-offline ;;
  java-gradle) ./gradlew dependencies ;;
  dotnet)      dotnet restore ;;
  rust)        cargo fetch ;;
  none)
    warn "Nog geen technologiestack in de repository ([TECH STACK] is niet gekozen)."
    echo
    echo "Volgende stappen:"
    echo "  1. Kies de stack en leg dit vast als ADR in docs/architecture/adr/."
    echo "  2. Voeg het manifest toe (package.json, pyproject.toml, go.mod, pom.xml, …)."
    echo "  3. Vul scripts/ci/*.sh aan waar 'not_configured' wordt gemeld."
    echo "  4. Zet de repository-variabele TEMPLATE_STRICT=true zodat CI blokkeert bij ontbrekende controles."
    ;;
esac

echo
ok "Klaar. Draai './scripts/ci/all.sh' om de kwaliteitsketen te controleren."
