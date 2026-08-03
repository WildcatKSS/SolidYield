#!/usr/bin/env bash
# Gedeelde hulpfuncties voor alle CI-scripts.
#
# Ontwerpkeuze: de technologiestack is nog niet gekozen ([TECH STACK]). De scripts
# detecteren daarom de stack aan de hand van manifestbestanden. Is er nog geen stack,
# dan waarschuwen ze en stoppen ze met exitcode 0 — zodat een verse template groene CI
# heeft. Zet de repository-variabele TEMPLATE_STRICT=true zodra de stack er is; dan
# worden ontbrekende controles blokkerende fouten.
set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export REPO_ROOT

TEMPLATE_STRICT="${TEMPLATE_STRICT:-false}"

log()   { printf '\033[0;36m[ci]\033[0m %s\n' "$*"; }
ok()    { printf '\033[0;32m[ok]\033[0m %s\n' "$*"; }
warn()  { printf '\033[0;33m[warn]\033[0m %s\n' "$*"; [ -n "${GITHUB_ACTIONS:-}" ] && echo "::warning::$*" || true; }
fail()  { printf '\033[0;31m[fail]\033[0m %s\n' "$*" >&2; [ -n "${GITHUB_ACTIONS:-}" ] && echo "::error::$*" || true; exit 1; }

has() { command -v "$1" >/dev/null 2>&1; }

# not_configured "<stap>" — meldt dat de stap nog niet is ingevuld.
# Niet-strikt: waarschuwing + exit 0. Strikt: fout + exit 1.
not_configured() {
  local step="$1"
  if [ "${TEMPLATE_STRICT}" = "true" ]; then
    fail "${step}: geen implementatie gevonden en TEMPLATE_STRICT=true. Vul deze stap in voor [TECH STACK]."
  fi
  warn "${step}: nog niet ingevuld voor [TECH STACK]. Overgeslagen (TEMPLATE_STRICT=false)."
  exit 0
}

# detect_stack — echoot: node | python | go | java-maven | java-gradle | dotnet | rust | none
detect_stack() {
  cd "${REPO_ROOT}"
  if   [ -f package.json ];                     then echo "node"
  elif [ -f pyproject.toml ] || [ -f requirements.txt ]; then echo "python"
  elif [ -f go.mod ];                           then echo "go"
  elif [ -f pom.xml ];                          then echo "java-maven"
  elif [ -f build.gradle ] || [ -f build.gradle.kts ]; then echo "java-gradle"
  elif compgen -G "*.sln" >/dev/null || compgen -G "**/*.csproj" >/dev/null; then echo "dotnet"
  elif [ -f Cargo.toml ];                       then echo "rust"
  else echo "none"
  fi
}

# has_npm_script <naam>
has_npm_script() {
  [ -f "${REPO_ROOT}/package.json" ] || return 1
  if has node; then
    node -e "process.exit(Boolean((require('${REPO_ROOT}/package.json').scripts||{})['$1'])?0:1)" 2>/dev/null
  else
    grep -q "\"$1\"[[:space:]]*:" "${REPO_ROOT}/package.json"
  fi
}

# pkg_run <npm-script> — voert een npm-script uit met de aanwezige packagemanager.
pkg_run() {
  cd "${REPO_ROOT}"
  if   [ -f pnpm-lock.yaml ] && has pnpm; then pnpm run "$@"
  elif [ -f yarn.lock ] && has yarn;      then yarn "$@"
  else npm run "$@"
  fi
}

# Zijn er testbestanden in een map? (map bestaat en bevat meer dan alleen README/.gitkeep)
tests_present() {
  local dir="${REPO_ROOT}/$1"
  [ -d "${dir}" ] || return 1
  find "${dir}" -type f ! -name 'README.md' ! -name '.gitkeep' | read -r _ 2>/dev/null
}
