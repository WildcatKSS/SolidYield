# Placeholders

Alle waarden tussen vierkante haken in deze repository moeten worden ingevuld voordat het
product naar de testgroep of naar productie gaat. Ze staan hier op één plek.

Zoeken: `grep -rIn '\[[A-Z]' --include='*.md' --include='*.yml' .`
De workflow `code-quality.yml` telt bij elke run hoeveel er nog openstaan.

## 1. Product en organisatie

| Placeholder | Betekenis | Eigenaar | Nodig vóór |
|---|---|---|---|
| `[PRODUCTNAAM]` | naam van de dienst | PO | ✅ **ingevuld 2026-08-03** — SolidYield |
| `[DOELGROEP]` | primaire doelgroep | PO | ✅ **ingevuld 2026-08-03** |
| `[PROBLEEM]` | kernprobleem | PO | ✅ **ingevuld 2026-08-03** |
| `[PRODUCTDOEL]` | belangrijkste productdoel | PO | ✅ **ingevuld 2026-08-03** |
| `[TYPE DIENST]` | type financiële dienst | PO + Compliance | ✅ **ingevuld 2026-08-03** — digitaal contractueel rendementproduct. Het regulatoire regime blijft open (RD-01) |
| `[LANDEN/REGIO]`, `[REGIO]` | markt en dataresidency | PO + Compliance | ✅ **ingevuld 2026-08-03** — markt Nederland; opslag en reguliere verwerking binnen de EER, primaire productieomgeving in Nederland ([ADR-0006](architecture/adr/0006-dataresidency-en-opslaglocatie.md)) |
| `[TALEN]`, `[VALUTA]` | taal- en valutaondersteuning | PO | ✅ Nederlands, EUR |
| `[ORGANISATIE]`, `[ORG]` | organisatie- en GitHub-organisatienaam | eigenaar repo | direct |
| `[REPOSITORY]` | repositorynaam | eigenaar repo | direct |
| `[JAAR]` | copyrightjaar in LICENSE | eigenaar repo | direct |

## 2. Team en contact

| Placeholder | Betekenis |
|---|---|
| `[NAAM]`, `[NAMEN]` | namen van rolhouders |
| `[EMAIL]`, `[TEAM-CONTACT-EMAIL]` | algemeen contact |
| `[SECURITY-CONTACT-EMAIL]` | securitymeldingen |
| `[PRIVACY-CONTACT-EMAIL]` | privacyvragen en incidenten |
| `[CODE-OF-CONDUCT-CONTACT]` | meldpunt gedragscode |
| `[PO-CONTACT]`, `[SCRUM-MASTER-CONTACT]` | rolcontacten |
| `[PGP-FINGERPRINT]`, `[SECURITY-PGP-URL]` | versleutelde meldingen |
| `[FTE]` | bezetting per rol |

## 3. Techniek

| Placeholder | Betekenis | Vastleggen als |
|---|---|---|
| `[TECH STACK]` | technologiekeuze | ADR-0002 |
| `[CLOUD]` | AWS, Azure, GCP of anders | ADR-0003 |
| `[IDP]` | identiteitsprovider | ADR-0004 |
| `[KMS]` | sleutelbeheer | ADR-0005 |
| `[PROVIDER]` | externe financiële gegevensbron | ADR — betaalpartners zijn **beoogd** Mollie en bunq ([ADR-0007](architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md)); rolverdeling nog niet definitief (RD-22) |
| `[TOOL]` | secrets manager, monitoring | ADR |
| `[FRAMEWORK]` | front-endframework | ADR |
| `[STAGING-URL]`, `[PRODUCTIE-URL]` | omgevings-URL's | deployment |
| `[TERRAFORM/BICEP/…]` | infrastructure as code | ADR |

## 4. Proces

| Placeholder | Betekenis | Aanname in deze template |
|---|---|---|
| `[SPRINTDUUR]` | lengte van de sprint | 2 weken |
| `[TESTGROEP]` | samenstelling testgroep | 8–12 deelnemers |
| `[VERGOEDING]`, `[KANAAL]` | vergoeding en wervingskanaal | — |
| `[HULPINSTANTIE]` | verwijzing bij financiële nood | — |
| `[AFGESCHERMDE LOCATIE]` | opslag buiten de repository | — |

## 5. Waarden en drempels

| Placeholder | Betekenis | Voorstel |
|---|---|---|
| `COVERAGE_MIN` | dekkingsdrempel | 70%, groeipad naar 80% |
| `STAGING_DEPLOY_ENABLED` | staging-deployment aan/uit | uit tot de deploystappen echt zijn ingevuld |
| `PRODUCTION_DEPLOY_ENABLED` | productiedeployment aan/uit | uit tot de deploystappen echt zijn ingevuld |
| `RELEASE_CHANNEL` | kanaal bij een tag-push | `test-group` (sluit productie uit) |
| `[15]` minuten | sessie-time-out | 15 |
| `[8]` uur | absolute sessieduur | 8 |
| `[BEDRAG]` | drempel voor handmatige controle | te bepalen |
| `[30]` dagen | bewaartermijn opnames en logs | 30 |
| `[35]` dagen | back-uprotatie | 35 |
| RPO / RTO | gegevensverlies en hersteltijd | 15 min / 4 uur |
| SLO-waarden | beschikbaarheid, latency, fouten | 99,5% / 500 ms / 0,5% |

## 6. Juridisch — **niet zelf invullen**

Deze punten worden **gevalideerd door een bevoegde specialist** en geregistreerd in
[`compliance/regulatory-decisions.md`](compliance/regulatory-decisions.md):
vergunningplicht · grondslagen · wettelijke bewaartermijnen · identificatieverplichtingen ·
informatieverplichtingen · meldplichten bij incidenten · eisen aan uitbesteding ·
internationale doorgifte · toegankelijkheidsverplichtingen.

## 6a. Waar staan de placeholders?

De meeste staan in `README.md` §4, [`product/product-vision.md`](product/product-vision.md)
en [`product/mvp-scope.md`](product/mvp-scope.md). De onboardingdocumenten
([`onboarding/`](onboarding/)) bevatten bewust weinig placeholders: die zijn direct
bruikbaar zonder invulwerk.

## 7. Volgorde van invullen

1. **Direct:** organisatie, repository, contactadressen, licentiejaar.
2. **Sprint 1:** product, doelgroep, probleem, doel, type dienst, regio, stack, cloud.
3. **Sprint 2:** IDP, provider, testgroep, sprintduur bevestigen.
4. **Vóór bèta:** alle juridische punten, bewaartermijnen, SLO's, URL's.
5. **Vóór productie:** alle overige waarden; de teller in `code-quality.yml` hoort dan
   richting nul te gaan.
