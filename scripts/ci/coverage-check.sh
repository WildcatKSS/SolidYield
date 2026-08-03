#!/usr/bin/env bash
# Controleert de testdekking tegen COVERAGE_MIN (standaard 70).
# Aanname: 70% als startdrempel met groeipad naar 80%. Verhoog de drempel bewust,
# nooit verlagen zonder besluit van het team (leg dat vast in de retrospective).
set -Eeuo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

COVERAGE_MIN="${COVERAGE_MIN:-70}"
cd "${REPO_ROOT}"

report=""
for candidate in coverage/lcov.info coverage.xml coverage/coverage.xml coverage.out; do
  [ -f "${candidate}" ] && report="${candidate}" && break
done

if [ -z "${report}" ]; then
  warn "Geen coveragerapport gevonden (verwacht: coverage/lcov.info, coverage.xml of coverage.out)."
  [ "${TEMPLATE_STRICT}" = "true" ] && fail "TEMPLATE_STRICT=true: coveragerapport is verplicht."
  exit 0
fi

log "Coveragerapport: ${report} (drempel: ${COVERAGE_MIN}%)"
percentage=""

case "${report}" in
  *lcov.info)
    percentage="$(awk -F: '/^LF:/ {lines+=$2} /^LH:/ {hit+=$2} END {if (lines>0) printf "%.1f", (hit/lines)*100; else print "0"}' "${report}")"
    ;;
  *.xml)
    # Cobertura: line-rate als fractie in het root-element.
    percentage="$(grep -o 'line-rate="[0-9.]*"' "${report}" | head -1 | grep -o '[0-9.]*' | awk '{printf "%.1f", $1*100}')"
    ;;
  *coverage.out)
    percentage="$(go tool cover -func=coverage.out | awk '/^total:/ {gsub("%","",$3); print $3}')"
    ;;
esac

[ -n "${percentage}" ] || fail "Kon het dekkingspercentage niet bepalen uit ${report}."
log "Dekking: ${percentage}%"

awk -v cov="${percentage}" -v min="${COVERAGE_MIN}" 'BEGIN { exit (cov+0 >= min+0) ? 0 : 1 }' \
  || fail "Dekking ${percentage}% ligt onder de drempel van ${COVERAGE_MIN}%."

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  printf '### Test coverage\n\n- Dekking: **%s%%**\n- Drempel: %s%%\n' "${percentage}" "${COVERAGE_MIN}" >> "${GITHUB_STEP_SUMMARY}"
fi
ok "Dekking ${percentage}% voldoet aan de drempel van ${COVERAGE_MIN}%."
