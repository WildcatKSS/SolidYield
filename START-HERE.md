# Start hier

**Doel:** binnen tien minuten weten waar je begint.
**Voor wie:** iedereen die deze template voor het eerst gebruikt.
**Leestijd:** ± 8 minuten. Je hoeft de rest van de documentatie nu niet te lezen.

---

## 1. Wat dit is — en wat niet

**Wel:** een startpunt voor een multidisciplinair team dat volgens Scrum een online
financiële dienst bouwt. Je krijgt werkende CI/CD met securitycontroles, issue- en
PR-sjablonen, een Scrum-werkwijze, en documentatie voor security, privacy, compliance en
operations.

**Niet:**

* geen applicatiecode of gekozen technologiestack — dat kies je zelf;
* geen bewijs dat je product aan wet- of regelgeving voldoet;
* geen juridisch advies. Regulatoire conclusies zijn gemarkeerd als **"te valideren door
  een bevoegde specialist"**;
* geen verplichting om alles in te vullen. Zie [adoptieniveaus](docs/adoption-levels.md).

> **Belangrijkste misverstand om te voorkomen:** deze repository bevat véél documentatie,
> maar je hebt op dag één maar een klein deel nodig. De rest activeer je wanneer je product
> daaraan toe is.

## 2. Kies je adoptieniveau

| Niveau | Voor wie | Wat je nu invult |
|---|---|---|
| **Core** | klein team, eerste product of prototype | visie, MVP, backlog, DoD, CI, secret scanning |
| **Advanced** | groeiend product, meerdere developers, echte gebruikers | + ADR's, threat modelling, scans, SLO's, releasekanalen |
| **Regulated/Enterprise** | productie in een gereguleerde of grote organisatie | + governance, control matrix, auditbewijs, approvals |

Begin bij **Core**, ook als je weet dat je later Enterprise wordt. Details en de volledige
lijst per niveau: [`docs/adoption-levels.md`](docs/adoption-levels.md).

> **Twee momenten waarop je vooruit moet stappen**, want deze maatregelen werken alleen
> vooraf:
>
> * **vóór** het ontwerp of de implementatie van functionaliteit die persoonsgegevens
>   verwerkt → de Advanced-privacymaatregelen (doelbinding, minimalisatie, grondslag,
>   bewaartermijn, DPIA-screening);
> * **vóór** productiegebruik met echt geld, echte financiële gegevens of gereguleerde
>   activiteiten → Regulated/Enterprise, met de readinesscriteria afgerond.

## 3. De route

### Eerste uur — repository klaarzetten

1. Maak een repository aan vanuit deze template met ***Use this template*** — niet met
   *Fork* en niet met `git clone`.

   > **Waarom dat uitmaakt.** *Use this template* geeft je repository één schone
   > `Initial commit`: geen commits, tags of releases van de template, en geen
   > fork-relatie. Fork en clone nemen die historie wél mee, en dan begint jouw product
   > met de ontwikkelgeschiedenis van iemand anders.
   >
   > Al geforkt of gekloond? Herstel met
   > `rm -rf .git && git init && git add -A && git commit -m "Initial commit"`.
   >
   > Om dezelfde reden begint [`CHANGELOG.md`](CHANGELOG.md) leeg: die hoort bij jouw
   > product. De ontwikkelgeschiedenis van de template zelf staat in de Releases van de
   > templaterepository.

2. Lees deze pagina (dat doe je nu).
3. Vul de eerste vier placeholders in — in `README.md` §2 en
   [`docs/product/product-vision.md`](docs/product/product-vision.md):
   `[PRODUCTNAAM]`, `[DOELGROEP]`, `[PROBLEEM]`, `[PRODUCTDOEL]`.
4. Bepaal wie Product Owner en Scrum Master zijn en wie de Developers zijn
   ([`docs/scrum/roles.md`](docs/scrum/roles.md)). Vul de contacttabel onderaan `README.md`.
5. Draai:
   ```bash
   cp .env.example .env
   ./scripts/bootstrap.sh
   ./scripts/verify-template.sh
   ```
   `verify-template.sh` hoort groen te zijn — zo niet, dan mist er iets in je kopie.

### Eerste dag — kunnen werken

6. Vul [`docs/product/mvp-scope.md`](docs/product/mvp-scope.md) in: kernprobleem,
   must-haves, wat je bewust níét bouwt, en je grootste aannames.
7. Maak het Projects-board volgens [`docs/scrum/project-board.md`](docs/scrum/project-board.md).
   **Zet de standaardautomatisering "issue gesloten → Done" uit.**
8. Draai de workflow **Labels sync** handmatig (*Actions → Labels sync → Run workflow*).
9. Maak je eerste backlogitems aan via *Issues → New issue*. Begin met één epic en drie
   user stories; kopieer gerust uit
   [`docs/product/example-backlog.md`](docs/product/example-backlog.md).
10. Zet branch protection aan volgens
    [`CONTRIBUTING.md`](CONTRIBUTING.md#branch-protection) en schakel secret scanning +
    push protection in (*Settings → Code security and analysis*).

### Eerste week — eerste sprint

11. Houd een refinement ([`docs/scrum/refinement.md`](docs/scrum/refinement.md)) en maak
    3–5 items Ready ([`docs/scrum/definition-of-ready.md`](docs/scrum/definition-of-ready.md)).
12. Formuleer één Sprint Goal in één zin
    ([`docs/scrum/sprint-planning.md`](docs/scrum/sprint-planning.md)).
13. Bouw het eerste increment. Elke pull request gebruikt het PR-template en moet groen
    door CI.
14. Plan de eerste leeractiviteit met gebruikers — dat hoeft geen formele usabilitytest te
    zijn ([`docs/research/test-group-plan.md`](docs/research/test-group-plan.md) §2).

### Eerste maand — verstevigen

15. Leg de technologiestack en cloudkeuze vast als ADR
    ([`docs/architecture/adr/`](docs/architecture/adr/)) en volg de
    [architectuurprincipes](docs/architecture/architecture-principles.md).
16. Zet de repository-variabele `TEMPLATE_STRICT=true` zodra er code is: CI wordt dan
    blokkerend in plaats van waarschuwend.
17. Doe threat modelling voor je eerste epic met de
    [epic-checklist](docs/architecture/epic-threat-checklist.md).
18. Activeer wat bij je niveau hoort: SLO's, monitoring, control matrix, approvals
    ([`docs/adoption-levels.md`](docs/adoption-levels.md)).

## 4. Wat lees ik als …?

| Rol | Begin met |
|---|---|
| **Product Owner** | [Product Owner Quick Start](docs/onboarding/product-owner-quick-start.md) |
| **Developer** | [Developer onboarding](docs/onboarding/developer-onboarding.md) |
| **Scrum Master** | [Scrum-werkwijze](docs/scrum/scrum-guide.md) + [antipatronen](docs/scrum/anti-patterns.md) |
| **UX / onderzoek** | [Testgroepplan](docs/research/test-group-plan.md) + [experimentsjabloon](docs/research/experiment-template.md) |
| **Security Champion** | [Security Champions](docs/security/security-champions.md) |
| **Platform / operations** | [Platform-readiness](docs/operations/platform-readiness-checklist.md) + [SRE-principes](docs/operations/sre-principles.md) |
| **Privacy / compliance** | [Privacy by design](docs/privacy/privacy-by-design.md) + [control matrix](docs/compliance/control-mapping.md) |

Volledige index per rol en adoptieniveau: [`docs/README.md`](docs/README.md).

## 5. Je eerste issue en pull request

```bash
git checkout -b feat/12-registratie
# … code en tests …
./scripts/ci/all.sh          # zelfde controles als CI, lokaal
git commit -m "feat(auth): registratie met e-mailverificatie

Relates to #12"
git push -u origin feat/12-registratie
```

Open de pull request, vul het template in en koppel het issue met **`Relates to #12`** —
niet `Closes`, zolang er na de merge nog validatie volgt
([waarom](docs/scrum/project-board.md#gebruik-van-sluitwoorden-in-pull-requests)).

## 6. Waar gaan vragen heen?

| Onderwerp | Route |
|---|---|
| **Beveiligingskwetsbaarheid** | **nooit** via een issue → [`SECURITY.md`](SECURITY.md) |
| Vermoeden van een beveiligingsincident of datalek | **onmiddellijk** melden via het incidentproces ([`docs/security/incident-response.md`](docs/security/incident-response.md)); wacht niet op bevestiging, volledigheid of eigen onderzoek |
| Securitywerk (niet-gevoelig) | issue via *Securitytaak* |
| Privacy- of compliancevraag | issue via *Compliance- of privacytaak* |
| "Mag dit juridisch?" | [`docs/compliance/regulatory-decisions.md`](docs/compliance/regulatory-decisions.md) — het team beantwoordt dit niet zelf |
| Werkwijze, board, DoR/DoD | Scrum Master |
| Scope en prioriteit | Product Owner |

## 7. Wat je nu **niet** hoeft te doen

* Niet alle placeholders invullen — [`docs/placeholders.md`](docs/placeholders.md) geeft de
  volgorde.
* Geen control matrix, auditbewijs of DPIA op dag één (tenzij je direct met echte
  persoonsgegevens start).
* Geen environments, approvals of releasekanalen vóór je eerste increment.
* Geen volledige teststrategie uitschrijven; begin met unittests en groei mee met
  [`docs/testing/test-strategy.md`](docs/testing/test-strategy.md).

> **Eén ding is niet uitstelbaar:** gebruik nooit echte persoonsgegevens, betaalgegevens of
> productiedata in development, tests, demo's of gebruikerssessies. Dat geldt vanaf commit
> één, op elk adoptieniveau.
