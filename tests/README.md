# tests/

> Strategie, testniveaus en kwaliteitsrisico's: [`../docs/testing/test-strategy.md`](../docs/testing/test-strategy.md).
> Dit bestand beschrijft alleen wáár wat staat en hoe je het draait.

| Map | Wat er in hoort | Draait via |
|---|---|---|
| `unit/` | losse functies en domeinlogica, zonder I/O | `scripts/ci/test-unit.sh` |
| `integration/` | samenwerking met database, wachtrij en externe koppelingen (in mock/sandbox) | `scripts/ci/test-integration.sh` |
| `security/` | misbruikscenario's uit het threat model | `scripts/ci/test-security.sh` |
| `accessibility/` | WCAG 2.2 AA-controles | `scripts/ci/test-accessibility.sh` |
| `end-to-end/` | de volledige gebruikersreis | `scripts/ci/test-e2e.sh` |

Alles in één keer: `./scripts/ci/all.sh`.

## Regels

1. **Uitsluitend synthetische testdata.** Nooit productiedata, ook niet "geanonimiseerd".
2. **Tests zijn deterministisch:** vaste seeds, geen afhankelijkheid van echte tijd of van
   het internet (mock externe koppelingen).
3. **Testnamen beschrijven gedrag**, niet implementatie:
   `weigert toegang tot transacties van een andere gebruiker`.
4. **Elke bugfix krijgt een test** die eerst faalt.
5. **Elke opgeloste kwetsbaarheid krijgt een regressietest** in `security/`.
6. Testdekking wordt bewaakt door `scripts/ci/coverage-check.sh` (`COVERAGE_MIN`).

## Voorbeelden van synthetische gegevens

| Soort | Gebruik | Nooit |
|---|---|---|
| E-mail | `test.user+p1@example.invalid` | een echt of plausibel adres |
| Naam | `Testgebruiker A` | een echte naam |
| Bedrag | `12,34`, `1000,00` | een echt saldo |
| Rekeningnummer | een door de gekozen **provider-sandbox gepubliceerde** testwaarde; anders een bewust **ongeldige** waarde (onjuist controlegetal) | een structureel geldig nummer dat je zelf verzint — dat kan van een echt persoon zijn |
| Kaartnummer | alleen de door de provider gepubliceerde testkaarten | een zelfbedacht nummer dat de Luhn-controle doorstaat |
| Identificatienummer (BSN-achtig) | niet gebruiken; werk met een interne test-ID | een geldig gevormd nummer |
| Telefoonnummer | gereserveerde fictieve reeks van je land, of duidelijk ongeldig | een bestaand nummer |
| Wachtwoord/token | `local-dev-not-a-real-secret` | een echt wachtwoord of token |

> **Geen universele testreeks.** Welke testwaarden veilig zijn, bepaalt de gekozen provider
> of sandbox — die publiceert ze. Neem ze op in de implementatierepository of de
> providerconfiguratie, niet als standaard in deze template. Zonder sandbox: bewust
> ongeldige waarden die een live systeem sowieso zou weigeren.
>
> `PROVIDER_MODE=live` is in tests technisch geblokkeerd, zodat testdata nooit bij een
> echte provider terechtkomt.
