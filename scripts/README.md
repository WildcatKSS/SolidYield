# scripts/

Alle scripts die de workflows aanroepen staan hier. Ze zijn **stack-agnostisch**: ze
detecteren de technologie aan de hand van manifestbestanden. Zolang `[TECH STACK]` niet is
gekozen, waarschuwen ze en slagen ze — zodat een verse template groene CI heeft.

Zet de repository-variabele `TEMPLATE_STRICT=true` zodra de stack er is: ontbrekende
controles worden dan blokkerende fouten.

## Overzicht

| Script | Doel | Aangeroepen door |
|---|---|---|
| `bootstrap.sh` | lokale omgeving opzetten | mens |
| `verify-template.sh` | controleert bestanden, YAML, scriptverwijzingen, actiepins, links en gevoelige patronen | `code-quality.yml` |
| `ci/check-action-pins.py` | toetst dat elke externe GitHub Action op een volledige commit-SHA staat; meldt bestand **en** regelnummer | `verify-template.sh` |
| `ci/check-docs-links.py` | controleert relatieve markdownlinks en bereikbaarheid via de echte linkgrafiek | `verify-template.sh` |
| `ci/common.sh` | gedeelde functies (`detect_stack`, logging, `not_configured`) | alle ci-scripts |
| `ci/build.sh` | afhankelijkheden installeren en bouwen | `ci.yml`, `release.yml` |
| `ci/lint.sh` | lint en formatteercontrole (incl. shellcheck) | `ci.yml`, `code-quality.yml` |
| `ci/test-unit.sh` | unittests met coverage | `ci.yml`, `release.yml` |
| `ci/test-integration.sh` | integratietests (mock/sandbox) | `ci.yml`, `release.yml` |
| `ci/coverage-check.sh` | dekkingsdrempel `COVERAGE_MIN` | `ci.yml`, `release.yml` |
| `ci/test-e2e.sh` | end-to-endtests | `ci.yml`, `release.yml` |
| `ci/test-security.sh` | securitytests | `release.yml`, lokaal |
| `ci/test-accessibility.sh` | WCAG-controles | `ci.yml`, `release.yml` |
| `ci/sbom.sh` | SBOM lokaal genereren | mens (in CI doet `anchore/sbom-action` dit) |
| `ci/license-check.sh` | licentiebeleid op afhankelijkheden | `dependency-review.yml`, `release.yml` |
| `ci/all.sh` | volledige lokale keten | mens |
| `release/prepare-release-notes.sh` | releasenotes uit Conventional Commits | `release.yml`, en als rooktest in `ci/all.sh` |

## Conventies

* `set -Eeuo pipefail` in elk script.
* Alle uitvoer via `log`, `ok`, `warn`, `fail` uit `ci/common.sh`; in CI worden
  `::warning::` en `::error::` gebruikt zodat meldingen zichtbaar zijn in de samenvatting.
* Ontbreekt een implementatie, gebruik dan `not_configured "<stap>"` — dat respecteert
  `TEMPLATE_STRICT`.
* Nieuwe scripts: uitvoerbaar maken (`git update-index --chmod=+x`) en opnemen in
  `verify-template.sh`.
* Scripts worden gecontroleerd met `shellcheck` in `code-quality.yml`.
* **Controlescripts toetsen zichzelf.** `check-action-pins.py` en `check-docs-links.py`
  hebben een `--self-test` met vaste voorbeelden van goede en foute invoer. Die zelftest
  draait in `verify-template.sh` **voordat** de repository wordt beoordeeld: een controle
  die zijn eigen testgevallen niet haalt, is geen controle. Bouw je een nieuwe controle,
  geef die dan dezelfde zelftest.
