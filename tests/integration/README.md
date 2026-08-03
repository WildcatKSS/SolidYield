# tests/integration/

Tests die de samenwerking tussen onderdelen controleren: database, wachtrijen, cache en
externe koppelingen.

## Regels

* Externe financiële koppelingen draaien in **mock of sandbox** (`PROVIDER_MODE=mock`).
  Een test tegen een live-koppeling is verboden — `test-integration.sh` breekt af bij
  `PROVIDER_MODE=live`.
* Elke test maakt zijn eigen data aan en ruimt op; geen afhankelijkheid tussen tests.
* Database via een wegwerpinstantie (bijvoorbeeld een container in CI).

## Wat hier minimaal hoort

| Test | Doel |
|---|---|
| Migraties draaien schoon op een lege database | deploybaarheid |
| Migraties zijn terugdraaibaar | rollback werkt |
| Repository-laag leest en schrijft correct | datamodel klopt |
| Autorisatie werkt via de echte laag heen | geen omweg om de controle |
| Time-out en retry bij een trage koppeling | degradatie werkt |
| Foutscenario van `[PROVIDER]` (500, 429, netwerkfout) | nette afhandeling |
| Transactionele integriteit (alles of niets) | geen halve financiële mutaties |
| Audit logging wordt daadwerkelijk geschreven | aantoonbaarheid |
