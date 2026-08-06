# SolidYield — een online financiële dienst

> ### 👉 Nieuw hier? Begin bij **[START-HERE.md](START-HERE.md)** — 8 minuten lezen, dan weet je waar te beginnen.

> **Status:** in opzet. Productnaam, doelgroep, probleem en productdoel zijn vastgesteld
> (besluit 1 in §10); de [productvisie](docs/product/product-vision.md) is daarop
> ingevuld. Ook het type financiële dienst (besluit 2), markt, taal, valuta en
> dataresidency (besluit 3), het **bedrijfs- en ketenmodel** (besluit 4) en de
> **technologiestack en hosting** (besluit 5) zijn vastgesteld; zie
> [ADR-0002](docs/architecture/adr/0002-technologiestack.md),
> [ADR-0003](docs/architecture/adr/0003-cloudprovider.md),
> [ADR-0007](docs/architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) en
> [ADR-0008](docs/architecture/adr/0008-geld-en-contractstroom.md). De overige waarden
> tussen vierkante haken (`[IDP]`, `[ORG]`, …) zijn nog **niet** ingevuld — zie
> [`docs/placeholders.md`](docs/placeholders.md).
>
> **Blokkerend: de wettelijke grondslag, niet het bedrijfsmodel.** Het bedrijfs- en
> ketenmodel staat vast. Wat nog niet vaststaat, is via welke wettelijke route dat model mag
> worden uitgevoerd — vergunning, wettelijke uitzondering, vrijstelling, ontheffing of een
> andere juridisch bevestigde grondslag (RD-23 t/m RD-27). De gekozen productinrichting kan
> vergunningplichtig zijn; de toepasselijke wettelijke grondslag wordt vastgesteld door
> Compliance.
>
> Tot die bevestiging geldt: **toegestaan** zijn UX, een werkende MVP, sandboxbetalingen,
> synthetische data, besloten demonstraties en technische integraties. **Niet toegestaan**
> zijn echte klantgelden, bindende rendementcontracten, werkelijke rendementuitkeringen en
> productiegebruik.

> [!IMPORTANT]
> Deze template levert **proces, structuur en controlemomenten**. Zij levert géén
> juridische, compliance- of securitygoedkeuring. Niets in deze repository bewijst dat een
> product aan wet- of regelgeving voldoet. Alle regulatoire conclusies zijn gemarkeerd als
> **"te valideren door een bevoegde specialist"**.

---

## 1. Wat is deze template?

Het startpunt voor een multidisciplinair team dat volgens **Scrum** een veilige,
schaalbare en gebruiksvriendelijke online financiële dienst bouwt.

**Wel:** werkende CI/CD met securitycontroles · Issue Forms en PR-template · een
Scrum-werkwijze die niet omzeilbaar is · documentatie voor security, privacy, compliance
en operations · een fictieve voorbeeldbacklog om mee te starten.

**Niet:** nog geen applicatiecode, geen juridisch advies, en geen verplichting om alles
tegelijk in te voeren. De technologiestack en hosting zijn inmiddels wél gekozen
(besluit 5).

| Doel | Waar geregeld |
|---|---|
| Scrum organiseren | [`docs/scrum/`](docs/scrum/) + GitHub Issues en Projects |
| Iteratief waarde opleveren | [Scrum-werkwijze](docs/scrum/scrum-guide.md) · [Definition of Done](docs/scrum/definition-of-done.md) |
| Een MVP valideren met gebruikers | [MVP-scope](docs/product/mvp-scope.md) · [`docs/research/`](docs/research/) |
| Feedback omzetten in backlogitems | [feedbacklog](docs/research/feedback-log.md) |
| Kwaliteit, privacy en security vanaf sprint 1 | [`.github/workflows/`](.github/workflows/) · [`docs/security/`](docs/security/) |
| Beslissingen traceerbaar vastleggen | [ADR's](docs/architecture/adr/) · [regulatoire besluiten](docs/compliance/regulatory-decisions.md) |
| Gecontroleerd releasen | [`docs/releases/`](docs/releases/) · [`release.yml`](.github/workflows/release.yml) |

## 2. Start hier

| Ik ben… | Begin bij |
|---|---|
| **nieuw met deze template** | [START-HERE.md](START-HERE.md) |
| **Product Owner** | [Quick start](docs/onboarding/product-owner-quick-start.md) |
| **Developer** | [Developer onboarding](docs/onboarding/developer-onboarding.md) |
| **Scrum Master** | [Scrum-werkwijze](docs/scrum/scrum-guide.md) · [antipatronen](docs/scrum/anti-patterns.md) |
| **UX / onderzoek** | [Testgroepplan](docs/research/test-group-plan.md) · [besloten testgroep](docs/product/closed-test-group.md) |
| **Security Champion** | [Security Champions](docs/security/security-champions.md) |
| **Platform / operations** | [Platform-readiness](docs/operations/platform-readiness-checklist.md) · [SRE-principes](docs/operations/sre-principles.md) |
| **Privacy / compliance** | [Privacy by design](docs/privacy/privacy-by-design.md) · [control matrix](docs/compliance/control-mapping.md) |

Volledige index per rol: [`docs/README.md`](docs/README.md).

## 3. Adoptieniveaus

Je hebt op dag één maar een klein deel van deze repository nodig.

| Niveau | Voor wie | Wat je invult |
|---|---|---|
| 🟢 **Core** | klein team, eerste product of prototype | visie, MVP, backlog, DoD, CI, secret scanning |
| 🔵 **Advanced** | groeiend product, echte gebruikers | + ADR's, threat modelling, scans, SLO's, releasekanalen |
| 🟣 **Regulated/Enterprise** | gereguleerde productie | + governance, control matrix, auditbewijs, approvals |

Details en het groeipad: [`docs/adoption-levels.md`](docs/adoption-levels.md). Een lager
niveau is gefaseerde invoering, **geen vrijstelling** van fundamentele security- en
privacyprincipes.

## 4. Repository gebruiken

### Productcontext

| Onderwerp | Waarde | Consequentie |
|---|---|---|
| Productnaam · doelgroep · probleem · productdoel | **SolidYield** · Nederlandse particuliere spaarders · de keuze tussen laagrentend sparen en complex beleggen · een inleg die binnen vijftien minuten zelfstandig af te ronden is, en die de gebruiker daarna aantoonbaar begrijpt — uitkering én risico | zie [productvisie](docs/product/product-vision.md) |
| Type financiële dienst | **digitaal contractueel rendementproduct** | bedrijfsmodel besloten (besluit 4); de **wettelijke grondslag** voor uitvoering wordt afzonderlijk vastgesteld (RD-23 t/m RD-27) |
| Product | looptijden 3/6/12/24/36/60 maanden · minimum inleg € 50 · geen vastgesteld maximum · **vast rendement**, maandelijks · volledige inleg terug aan het einde | zie [ADR-0008](docs/architecture/adr/0008-geld-en-contractstroom.md) |
| Wallet | onderdeel van SolidYield: storten, opnemen naar de eigen tegenrekening, vastzetten — geen P2P, geen betalingen aan derden | kwalificatie als betaaldienst of elektronisch geld: **open**, RD-17 |
| Doelgroep MVP | Nederlandse consumenten, zzp'ers en rechtspersonen — start in een **besloten testgroep** | zie [MVP-scope](docs/product/mvp-scope.md) |
| Betaalpartners | ontworpen voor **vergunninghoudende betaalpartners**; eerste implementatierichting: Mollie (iDEAL/SEPA) en bunq (IBAN, uitbetalingen, reconciliatie) — betaalpartner, **geen productuitgever** | **nog niet definitief geselecteerd en niet gecontracteerd**; selectie en regulatoire rolverdeling worden contractueel vastgesteld (RD-22) |
| Landen/regio's · dataresidency | **Nederland** · opslag en reguliere verwerking binnen de **EER**, primaire productieomgeving in Nederland | zie [ADR-0006](docs/architecture/adr/0006-dataresidency-en-opslaglocatie.md) |
| Technologiestack | **Kotlin/Spring Boot** · **React/TypeScript/Vite** · **PostgreSQL** · modulaire monoliet met Spring Modulith | zie [ADR-0002](docs/architecture/adr/0002-technologiestack.md) |
| Hosting | **TransIP**, twee VPS'en met **Ubuntu Server LTS**; productie en test **volledig gescheiden**, test uitsluitend via **WireGuard** | zie [ADR-0003](docs/architecture/adr/0003-cloudprovider.md) |
| Sprintduur | **twee weken** (veertien kalenderdagen) | zie [Scrum](docs/scrum/scrum-guide.md) |
| Besloten testgroep | **maximaal 10 deelnemers**, uitsluitend op uitnodiging — eerste gecontroleerde **productie**-uitrol, start **pas na bevestiging van de wettelijke grondslag** (besluit 4) | zie [besloten testgroep](docs/product/closed-test-group.md); onderzoekssessies met synthetische data staan in het [testgroepplan](docs/research/test-group-plan.md) |

### Installatie

```bash
git clone https://github.com/[ORGANISATIE]/[REPOSITORY].git
cd [REPOSITORY]
cp .env.example .env          # lokale, niet-productie waarden
./scripts/bootstrap.sh        # detecteert de stack en installeert
./scripts/verify-template.sh  # controleert de repository zelf
```

`bootstrap.sh` is stack-agnostisch: het herkent Node.js, Python, Go, Java en .NET. De
gekozen stack is Kotlin/Gradle en Node ([ADR-0002](docs/architecture/adr/0002-technologiestack.md));
zolang de manifesten nog niet in de repository staan, meldt het script dat er niets te
installeren is.

### Configuratie

Alle configuratie loopt via omgevingsvariabelen; het contract staat in
[`.env.example`](.env.example). Secrets horen in GitHub Actions Secrets of een secrets
manager — nooit in de repository. Omgevingen zijn strikt gescheiden:
`development` → `test` → `staging` → `production`.

De repository-variabelen die het gedrag van de pipeline sturen (`TEMPLATE_STRICT`,
`STAGING_DEPLOY_ENABLED`, `PRODUCTION_DEPLOY_ENABLED`, `RELEASE_CHANNEL`,
`CODEQL_LANGUAGES`, `COVERAGE_MIN`) staan met uitleg in
[`docs/operations/deployment.md`](docs/operations/deployment.md#6-configuratie-en-secrets).

### Repositorystructuur

```
.github/        Issue Forms, PR-template, CODEOWNERS, labels, Dependabot, workflows
docs/           procesdocumentatie — begin bij docs/README.md
src/            applicatiecode — Kotlin/Spring Boot (backend), React/TypeScript (frontend)
tests/          unit · integration · security · accessibility · end-to-end
scripts/        bootstrap + de CI-scripts die de workflows aanroepen
```

## 5. Scrum en productontwikkeling

* **Scrum Team:** Product Owner, Scrum Master en Developers. De Developers zijn
  multidisciplinair (UX, onderzoek, test, security, privacy, compliance, operations).
  Governancerollen en de deelnemers aan de testgroep staan bewust **buiten** het Scrum
  Team — [`docs/scrum/roles.md`](docs/scrum/roles.md).
* **Sprintduur:** **twee weken** — veertien kalenderdagen, vaste start- en einddag
  (besluit 6). Elke sprint levert een bruikbaar, getest en potentieel releasbaar increment,
  en bevat minimaal sprint planning, dagelijkse afstemming, backlog refinement, sprint
  review en retrospective.
* **Eén backlog:** architectuur-, security-, privacy-, compliance-, operations- en
  documentatiewerk staat in dezelfde geprioriteerde productbacklog als functionele
  ontwikkeling — niet in een parallel traject.
* **Board:** 12 statussen en 14 velden — [`docs/scrum/project-board.md`](docs/scrum/project-board.md).
* **Backlog:** Productdoel → Epic → Feature → User story → taken. Labels in
  [`.github/labels.yml`](.github/labels.yml); fictief voorbeeld in
  [`docs/product/example-backlog.md`](docs/product/example-backlog.md).
* **Definition of Ready:** [`docs/scrum/definition-of-ready.md`](docs/scrum/definition-of-ready.md).
* **Definition of Done:** universeel (U1–U8) + conditioneel (C1–C12), **zonder
  uitzonderingsprocedure** — [`docs/scrum/definition-of-done.md`](docs/scrum/definition-of-done.md).
* **Valkuilen:** [`docs/scrum/anti-patterns.md`](docs/scrum/anti-patterns.md).
* **Gebruikersvalidatie:** risicogestuurd; onderscheid tussen desirability, usability,
  feasibility en viability — [`docs/research/test-group-plan.md`](docs/research/test-group-plan.md).

## 6. Development en kwaliteit

Werkwijze: item uit *Sprint backlog* → branch (`feat/12-…`) → code + tests → PR met
template, gekoppeld met `Relates to #12` → CI groen → review (2 bij gevoelige paden) →
merge → validatie → Done. Uitgebreid:
[`CONTRIBUTING.md`](CONTRIBUTING.md) en [developer onboarding](docs/onboarding/developer-onboarding.md).

| Doel | Commando |
|---|---|
| Volledige keten (zoals CI) | `./scripts/ci/all.sh` |
| Losse stappen | `./scripts/ci/{build,lint,test-unit,test-integration,coverage-check,test-e2e,test-security,test-accessibility}.sh` |
| Template zelfcontrole | `./scripts/verify-template.sh` |

Welke test op welk niveau hoort: [`docs/testing/test-strategy.md`](docs/testing/test-strategy.md).
Architectuurkaders: [`docs/architecture/architecture-principles.md`](docs/architecture/architecture-principles.md).

## 7. Security, privacy en compliance

> **Meld kwetsbaarheden nooit via een publiek issue** → [`SECURITY.md`](SECURITY.md)
> (private vulnerability reporting of `[SECURITY-CONTACT-EMAIL]`).

* **Securityprincipes en -eisen:** [`docs/security/security-principles.md`](docs/security/security-principles.md)
* **Threat modelling:** systeembreed in [`threat-model.md`](docs/architecture/threat-model.md),
  per epic met de [epic-checklist](docs/architecture/epic-threat-checklist.md)
* **In de pipeline:** secret scanning, SAST, dependency- en containerscan, SBOM,
  licentiecontrole. De `security-gate` is **fail-closed**: elke verplichte controle moet
  exact `success` zijn.
* **Privacy:** [`docs/privacy/privacy-by-design.md`](docs/privacy/privacy-by-design.md) —
  inclusief het onderscheid tussen gegevensbescherming, intern beleid,
  informatiebeveiliging, sectorspecifieke regelgeving en contractuele eisen.
* **Compliance:** [control matrix](docs/compliance/control-mapping.md) ·
  [auditbewijs](docs/compliance/audit-evidence.md) ·
  [regulatoire besluiten](docs/compliance/regulatory-decisions.md).
* **Nooit** echte persoonsgegevens, betaalgegevens of productiedata buiten productie —
  op elk adoptieniveau.

## 8. Releases en operations

Semantic Versioning + [`CHANGELOG.md`](CHANGELOG.md). Kanalen: intern prototype →
testgroepversie → bèta → beperkte productie → algemene beschikbaarheid.

De **besloten testgroep** (besluit 7) valt onder *beperkte productie*: maximaal tien
uitgenodigde deelnemers, met echte gegevens en echte geldstromen, en pas ná bevestiging van
de wettelijke grondslag. De Go/No-Go-voorwaarden staan in
[`docs/product/closed-test-group.md`](docs/product/closed-test-group.md) §10.

De releaseworkflow is fail-closed: een handmatige run is altijd een **droogrun**;
deployment vereist een tag-push op de hoofdbranch met de juiste variabelen, en productie
bovendien een stabiele SemVer-versie, een kanaal uit de allowlist en environment approval.
Details: [`docs/releases/release-process.md`](docs/releases/release-process.md) en
[`docs/operations/deployment.md`](docs/operations/deployment.md).

Operations: [monitoring](docs/operations/monitoring.md) ·
[SLO's](docs/operations/service-level-objectives.md) ·
[SRE-principes](docs/operations/sre-principles.md) ·
[runbook](docs/operations/runbook.md) ·
[back-up en herstel](docs/operations/backup-and-recovery.md) ·
[platform-readiness](docs/operations/platform-readiness-checklist.md).

## 9. Documentatie-index

**[`docs/README.md`](docs/README.md)** — per rol, per situatie en per adoptieniveau.
Overige ingangen: [`CONTRIBUTING.md`](CONTRIBUTING.md) ·
[`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) · [`GOVERNANCE.md`](GOVERNANCE.md) ·
[`SUPPORT.md`](SUPPORT.md) · [`LICENSE`](LICENSE) (standaard MIT — voor een commerciële
dienst is een propriëtaire licentie vaak passender).

## 10. Openstaande beslissingen en placeholders

Niet besloten — behandel deze niet als feit:

| # | Onderwerp | Type | Eigenaar |
|---|---|---|---|
| 1 | Productnaam, doelgroep, probleem, productdoel | ✅ **besloten 2026-08-03** — [productvisie](docs/product/product-vision.md) | Product Owner |
| 2 | Type financiële dienst | ✅ **besloten 2026-08-03** — digitaal contractueel rendementproduct; het **regulatoire regime** is daarmee níét bepaald, zie 4 | PO + Compliance |
| 3 | Landen/regio's, dataresidency, taal | ✅ **besloten 2026-08-03** — markt Nederland, taal Nederlands, valuta EUR; opslag en reguliere verwerking binnen de EER met de primaire productieomgeving in Nederland, één geografisch gescheiden secundaire locatie binnen de EER voor back-up en DR, toegang vanuit derde landen standaard uitgesloten ([ADR-0006](docs/architecture/adr/0006-dataresidency-en-opslaglocatie.md)) | PO + Compliance |
| 4 | Vergunningplicht en rol in de keten | ✅ **besloten 2026-08-05** — bedrijfs- en ketenmodel vastgesteld in [ADR-0007](docs/architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) en [ADR-0008](docs/architecture/adr/0008-geld-en-contractstroom.md) | Product Owner |
| 4a | **Wettelijke grondslag** om dat model uit te voeren: vergunning, wettelijke uitzondering, vrijstelling, ontheffing of een andere juridisch bevestigde grondslag (RD-23 t/m RD-27) | **te valideren door bevoegde specialist** — blokkeert echte klantgelden, bindende rendementcontracten, werkelijke rendementuitkeringen en productiegebruik | Compliance |
| 5 | Technologiestack en cloudprovider | ✅ **besloten 2026-08-05** — Kotlin/Spring Boot, React/Vite, PostgreSQL, modulaire monoliet ([ADR-0002](docs/architecture/adr/0002-technologiestack.md)); TransIP met twee VPS'en ([ADR-0003](docs/architecture/adr/0003-cloudprovider.md)) | Tech lead |
| 6 | Sprintduur | ✅ **besloten** — sprints van twee weken | Scrum Master |
| 7 | Besloten testgroep (MVP-deelnemers) | ✅ **besloten** — maximaal 10 uitgenodigde deelnemers; eerste gecontroleerde productie-uitrol na bevestiging wettelijke grondslag | Product Owner |
| 8 | Identiteitsprovider en MFA-methode | open besluit | Security + Tech lead |
| 9 | Bewaartermijnen per gegevenscategorie | **te valideren door bevoegde specialist** | Privacy |
| 10 | Licentiemodel (aanname: MIT) | aanname | Eigenaar repo |
| 11 | Coveragedrempel (aanname: 70%, groeipad naar 80%) | aanname | Developers |
| 12 | Leveranciers en verwerkersovereenkomsten | open besluit | Privacy + Inkoop |

Volledige lijst met volgorde van invullen: [`docs/placeholders.md`](docs/placeholders.md).
Bewust nog niet ingebouwd: [`docs/optional-extensions.md`](docs/optional-extensions.md).

## 11. Handmatige repository-instellingen

Na het aanmaken van de repository, in deze volgorde:

- [ ] `main` als default branch; branch protection volgens [`CONTRIBUTING.md`](CONTRIBUTING.md#branch-protection)
- [ ] `[ORG]` in [`.github/CODEOWNERS`](.github/CODEOWNERS) vervangen door bestaande teams — anders doet CODEOWNERS niets
- [ ] Secret scanning, push protection en private vulnerability reporting aanzetten
- [ ] Dependency graph aanzetten (anders meldt `dependency-review` dat control CM-05 niet actief is)
- [ ] Workflow **Labels sync** handmatig draaien
- [ ] Projects-board aanmaken; automatisering *issue gesloten → Done* **uitzetten**
- [ ] Repository-variabelen instellen (zie §4)
- [ ] Environments `staging` en `production` met required reviewers (Advanced/Regulated)

## Contact en eigenaarschap

| Rol | Naam | Contact | GitHub-team |
|---|---|---|---|
| Product Owner | `[NAAM]` | `[EMAIL]` | `@[ORG]/product-owners` |
| Scrum Master | `[NAAM]` | `[EMAIL]` | `@[ORG]/scrum-masters` |
| Tech lead / architect | `[NAAM]` | `[EMAIL]` | `@[ORG]/tech-leads` |
| Security officer | `[NAAM]` | `[SECURITY-CONTACT-EMAIL]` | `@[ORG]/security` |
| Privacy officer / DPO | `[NAAM]` | `[EMAIL]` | `@[ORG]/privacy` |
| Compliance officer | `[NAAM]` | `[EMAIL]` | `@[ORG]/compliance` |
| UX- en onderzoeksexpertise | `[NAAM]` | `[EMAIL]` | `@[ORG]/ux` |
| Security Champion | `[NAAM]` | `[EMAIL]` | `@[ORG]/security` |
