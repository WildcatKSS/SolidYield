<!--
Vul alle secties in. "n.v.t." mag, maar altijd met één regel onderbouwing.
Meld beveiligingskwetsbaarheden NIET via een pull request of issue — zie SECURITY.md.
-->

## Samenvatting

<!-- Wat verandert er en waarom? 3–5 zinnen, begrijpelijk voor een reviewer buiten je subteam. -->

## Gekoppeld issue

Relates to #

<!--
Gebruik `Relates to #123` zolang het werk na de merge nog verificatie of validatie nodig
heeft. `Closes #123` sluit het issue automatisch bij de merge — dan springt het item naar
een eindstatus vóórdat de Definition of Done is gehaald. Gebruik `Closes #123` alleen
wanneer de merge het werk aantoonbaar volledig afrondt (bijvoorbeeld een
documentatiewijziging). Zie docs/scrum/project-board.md §5.
-->

## Type wijziging

- [ ] `feat` — nieuwe functionaliteit
- [ ] `fix` — bugfix
- [ ] `refactor` — herstructurering zonder gedragswijziging
- [ ] `perf` — prestatieverbetering
- [ ] `test` — alleen tests
- [ ] `docs` — alleen documentatie
- [ ] `build` / `ci` — pipeline of afhankelijkheden
- [ ] `chore` — onderhoud
- [ ] **Breaking change** (major-release; licht hieronder toe wat migratie vraagt)

## Screenshots of demo

<!-- UI-wijziging: voor/na. Backend: voorbeeldrequest/response (zonder echte gegevens). -->

## Acceptatiecriteria

<!-- Neem de Given/When/Then-criteria uit het issue over en vink af wat is aangetoond. -->

- [ ] Given … When … Then …
- [ ] Given … When … Then …

## Testresultaten

| Testsoort | Uitgevoerd | Toelichting |
|---|---|---|
| Unit | ⬜ | |
| Integratie | ⬜ | |
| End-to-end | ⬜ | |
| Security (`tests/security/`) | ⬜ | |
| Toegankelijkheid (`tests/accessibility/`) | ⬜ | |
| Handmatig | ⬜ | |

* Coverage: `[VOOR]% → [NA]%` (drempel: `COVERAGE_MIN`)
* Getest in omgeving: `[lokaal / test / staging]`
* Testdata: uitsluitend synthetisch — [ ] bevestigd

## Security-impact

- [ ] Geen — toelichting:
- [ ] Wel — vink aan wat van toepassing is:
  - [ ] authenticatie of sessiebeheer
  - [ ] autorisatie, rollen of rechten
  - [ ] cryptografie, sleutels of secrets
  - [ ] invoervalidatie / uitvoercodering
  - [ ] transactie-, betaal- of limietlogica
  - [ ] logging van gevoelige gegevens
  - [ ] nieuwe externe afhankelijkheid of API
  - [ ] wijziging aan de CI/CD-pipeline
- Threat model bijgewerkt: ⬜ ja ⬜ niet nodig, omdat …
- Openstaande kritieke/hoge bevindingen: ⬜ geen ⬜ toelichting:
- Reviewer security (`@[ORG]/security`) vereist: ⬜ ja ⬜ nee

## Privacy-impact

- [ ] Geen persoonsgegevens geraakt — toelichting:
- [ ] Wel:
  - Welke gegevenscategorieën: …
  - Doel en grondslag (voorlopig): …
  - Gegevensminimalisatie toegepast: ⬜ ja ⬜ nee, omdat …
  - Bewaartermijn geregeld: ⬜ ja ⬜ n.v.t.
  - Nieuwe verwerking of nieuwe ontvanger/leverancier: ⬜ ja ⬜ nee
  - DPIA nodig of bijgewerkt: ⬜ ja ⬜ nee ⬜ te beoordelen door `@[ORG]/privacy`

## Compliance-impact

- [ ] Geen
- [ ] Wel:
  - Betrokken control(s) uit `docs/compliance/control-mapping.md`: …
  - Bewijs vastgelegd in `docs/compliance/audit-evidence.md`: ⬜ ja ⬜ nee
  - Audit trail beïnvloed: ⬜ ja ⬜ nee
  - **Te valideren door bevoegde specialist**: ⬜ ja ⬜ nee

## Database- of datamigraties

- [ ] Geen
- [ ] Wel:
  - Migratie is achterwaarts compatibel (expand/contract): ⬜ ja ⬜ nee
  - Terugdraaibaar: ⬜ ja ⬜ nee — plan:
  - Geschatte duur en impact op beschikbaarheid:
  - Getest op een representatieve datasetgrootte: ⬜ ja ⬜ nee
  - Raakt persoonsgegevens: ⬜ ja (dan ook privacy-impact invullen) ⬜ nee

## Monitoring en observability

- [ ] Logging toegevoegd/aangepast (zonder gevoelige gegevens)
- [ ] Metrics toegevoegd
- [ ] Alert of dashboard bijgewerkt — waar:
- [ ] Audit logging geraakt — toelichting:
- [ ] Niet nodig, omdat …

## Rollbackplan

<!-- Hoe draaien we dit binnen [RTO] terug? Feature flag, revert, herdeploy vorige tag, migratie terug? -->

- Methode:
- Geschatte hersteltijd:
- Feature flag: ⬜ ja, naam: … ⬜ nee

## Documentatiewijzigingen

- [ ] README
- [ ] `docs/architecture/` (incl. ADR bij een belangrijke keuze)
- [ ] `docs/security/` / `docs/privacy/` / `docs/compliance/`
- [ ] `docs/operations/` (runbook, monitoring, deployment)
- [ ] `.env.example`
- [ ] CHANGELOG
- [ ] Niet nodig, omdat …

## Release-impact

- Doelkanaal: ⬜ intern prototype ⬜ testgroepversie ⬜ bèta ⬜ beperkte productie ⬜ algemeen beschikbaar
- Versiebump: ⬜ patch ⬜ minor ⬜ major
- Vereist coördinatie (communicatie, support, leverancier): ⬜ ja, namelijk … ⬜ nee

## Definition of Done

Volledige lijst: [`docs/scrum/definition-of-done.md`](../blob/main/docs/scrum/definition-of-done.md).
Ontbreekt een verplicht criterium, dan is het item **niet Done**; er is geen
uitzonderingsprocedure. Splits het werk of zet het terug op de backlog.

### Universeel — geldt altijd

- [ ] **U1** acceptatiecriteria aantoonbaar behaald
- [ ] **U2** review uitgevoerd door iemand anders dan de maker (2 reviews bij gevoelige paden)
- [ ] **U3** verplichte CI-controles geslaagd
- [ ] **U4** geen blokkerende bevindingen open (security-gate groen, geen kritieke/hoge kwetsbaarheden)
- [ ] **U5** geen secrets, echte persoonsgegevens of productiedata toegevoegd
- [ ] **U6** documentatie bijgewerkt waar nodig
- [ ] **U7** traceerbaar: issue ↔ pull request ↔ commit
- [ ] **U8** samengevoegd in de hoofdbranch zonder de build te breken

### Conditioneel — vink aan wat deze wijziging raakt

Wat je overslaat terwijl het gebied wél wordt geraakt, licht je in één regel toe.

- [ ] **C1** applicatiecode → passende tests toegevoegd; dekking boven de drempel
- [ ] **C2** UI → toegankelijkheid gecontroleerd (WCAG 2.2 AA op de kernreis)
- [ ] **C3** authenticatie/autorisatie → negatieve tests aanwezig
- [ ] **C4** geldstromen → tests op afronding, randgevallen en idempotentie
- [ ] **C5** datamodel/migratie → getest, terugdraaibaar, rollbackplan hierboven
- [ ] **C6** persoonsgegevens → doel, grondslag, minimalisatie en bewaartermijn geregeld
- [ ] **C7** control geraakt → bewijs in `docs/compliance/audit-evidence.md`
- [ ] **C8** gebruikersaanname → validatie uitgevoerd of ingepland; uitkomst in `docs/research/feedback-log.md`
- [ ] **C9** operationeel → logging, metrics of alerts; runbook bijgewerkt
- [ ] **C10** securitygevoelig pad → review door de code owners
- [ ] **C11** geverifieerd in een representatieve testomgeving met synthetische data
- [ ] **C12** release-impact → regel onder `Unreleased` in `CHANGELOG.md`

**Niet van toepassing, omdat:**
<!-- Per overgeslagen conditioneel criterium één regel. "n.v.t." zonder reden telt niet. -->

> De Product Owner inspecteert het resultaat en past waar nodig de Product Backlog aan.
> Een aparte persoonlijke goedkeuring is geen voorwaarde voor Done: dat volgt uit de
> criteria hierboven. De beslissing om dit increment daadwerkelijk uit te brengen is een
> releasebeslissing, zie `docs/releases/release-process.md`.
