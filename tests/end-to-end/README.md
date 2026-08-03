# tests/end-to-end/

Tests die de volledige gebruikersreis doorlopen in een echte browser tegen een
testomgeving met synthetische data.

## Regels

* Draait **nooit** tegen productie (`test-e2e.sh` breekt af bij `APP_ENV=production`).
* Uitsluitend synthetische accounts en gegevens.
* Houd de set klein en stabiel: end-to-endtests zijn traag en breken makkelijk. Test details
  op unit- of integratieniveau.
* Vermijd wachten op vaste tijden; wacht op condities.

## Minimale set

| Scenario | Dekt |
|---|---|
| Registreren → e-mail verifiëren → MFA instellen → inloggen | epic 1 |
| Toestemming geven → gegevens koppelen → eerste inzicht zien | epic 2 |
| Toestemming intrekken → gegevens niet meer bijgewerkt | epic 2/3 |
| Transacties achter een categorie bekijken | epic 2 |
| Gegevens exporteren | epic 3 |
| Account verwijderen | epic 3 |
| Uitloggen → beschermde pagina direct opvragen → redirect naar inloggen | security |
| Sessie verlopen → herauthenticatie zonder verlies van context | security |
| Foutpad: koppeling niet beschikbaar → begrijpelijke melding met versheid van gegevens | UX |

## Meten tijdens de test

Leg vast hoe lang de reis "registratie → eerste inzicht" duurt. Dat is de kernmeting van
productdoel PD-1 (zie [`../../docs/product/product-goals.md`](../../docs/product/product-goals.md)).
