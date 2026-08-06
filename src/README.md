# src/

Applicatiecode. De stack is vastgesteld in ADR-0002: Kotlin/Spring Boot voor de backend en React/TypeScript voor de frontend. De oorspronkelijke instructie luidde: leg die keuze vast als
ADR (zie [`../docs/architecture/adr/`](../docs/architecture/adr/)) voordat je hier begint.

## Voorgestelde indeling (aan te passen aan de stack)

```
src/
├── auth/           # authenticatie, sessies, MFA          → CODEOWNER: security
├── accounts/       # gebruikers en profielen
├── transactions/   # financiële gegevens en berekeningen  → CODEOWNER: security
├── consent/        # toestemming geven, intrekken, vastleggen
├── insights/       # het kerninzicht (aggregaties)
├── notifications/  # meldingen
├── audit/          # audit logging                        → append-only
├── integrations/   # koppelingen met [PROVIDER]
├── platform/       # configuratie, logging, foutafhandeling, observability
└── web/            # UI (indien in dezelfde repository)
```

De paden `auth/`, `transactions/`, `payments/` en `crypto/` staan in
[`../.github/CODEOWNERS`](../.github/CODEOWNERS) en vragen daarom om een securityreview.

## Afspraken

1. **Domeinlogica staat los van infrastructuur.** Berekeningen zijn testbaar zonder
   database of netwerk.
2. **Autorisatie hoort in de API-laag én wordt per object gecontroleerd** — nooit alleen
   in de UI.
3. **Geld nooit in floating point.** Gebruik integers in de kleinste eenheid (centen) of
   een decimaaltype; leg afronding expliciet vast en test die.
4. **Geen secrets in code.** Configuratie komt uit omgevingsvariabelen; zie
   [`../.env.example`](../.env.example).
5. **Logging via de platformlaag**, met filters die persoonsgegevens tegenhouden.
6. **Elke module heeft tests** in `../tests/`; nieuwe functionaliteit zonder tests wordt
   niet gemerged.
7. **Foutafhandeling lekt niets**: generieke melding naar buiten, volledige context intern.

## Zodra de stack is gekozen

- [ ] ADR geschreven en geaccepteerd
- [ ] Manifest toegevoegd (`package.json`, `pyproject.toml`, `go.mod`, …)
- [ ] `scripts/ci/*.sh` aangevuld waar nu `not_configured` wordt gemeld
- [ ] Repository-variabele `TEMPLATE_STRICT=true` gezet, zodat CI blokkeert bij ontbrekende controles
- [ ] `.github/dependabot.yml`: het juiste ecosysteem uit commentaar gehaald
- [ ] `CODEOWNERS`-paden aangepast aan de werkelijke mapstructuur
