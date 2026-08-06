# Releaseproces

Releasen is een **beslissing**, geen automatisme. De pipeline maakt het mogelijk; mensen
bepalen of het gebeurt.

## 1. Versienummering (Semantic Versioning)

`MAJOR.MINOR.PATCH`

| Onderdeel | Wanneer | Voorbeeld |
|---|---|---|
| MAJOR | onverenigbare wijziging (API, datamodel, gedrag) | 1.0.0 → 2.0.0 |
| MINOR | nieuwe functionaliteit, achterwaarts compatibel | 1.2.0 → 1.3.0 |
| PATCH | bugfix of securityfix, achterwaarts compatibel | 1.2.3 → 1.2.4 |

Prereleases: `1.3.0-rc.1`, `1.3.0-beta.1`. Tags: `v1.3.0`.
Versies vóór `1.0.0` zijn niet stabiel; dat mag, mits duidelijk gecommuniceerd.

> **Vóór het eerste productiegebruik met echt geld, echte financiële gegevens of
> gereguleerde activiteiten** zijn de readinesscriteria van
> [`../adoption-levels.md`](../adoption-levels.md#regulated--enterprise) afgerond. Die
> criteria horen **vóór** de eerste productie-uitrol thuis, niet erna: een vergunningsvraag
> of een ontbrekend mandaat is achteraf niet te repareren zonder de dienst stil te leggen.

## 2. Releasekanalen

| Kanaal | Voor wie | Data | Voorwaarden |
|---|---|---|---|
| **Intern prototype** | team | synthetisch | CI groen |
| **Testgroepversie** | deelnemers aan **onderzoekssessies** (`[8–12]`) | synthetisch | DoD gehaald, geen kritieke/hoge kwetsbaarheden, toestemming geregeld |
| **Bèta** | `[grotere groep]` | synthetisch of beperkt echt — **te valideren** | DPIA afgerond, securitycheck, support geregeld. Draait op een **niet-productieomgeving**; wil je bèta wél in productie, richt daar dan een eigen environment voor in en neem het kanaal expliciet op in de productie-allowlist |
| **Beperkte productie-uitrol** | **besloten testgroep**: maximaal 10 uitgenodigde deelnemers (besluit 7), daarna `[X]%` van de gebruikers | **echt** — echte persoonsgegevens, volledige KYC, echte geldstromen | volledige releasechecklist, pentest, goedkeuringen, de afgeronde Regulated-readinesscriteria **én de volledige Go/No-Go uit [`../product/closed-test-group.md`](../product/closed-test-group.md) §10** (C-34), waaronder bevestiging van de wettelijke grondslag |
| **Algemene beschikbaarheid** | iedereen | echt | beperkte uitrol stabiel gedurende `[2]` weken |

Overgang naar een volgend kanaal is een expliciet besluit van PO + Security + Compliance.

## 3. Stappen

### 1. Releasekandidaat
Tag `vX.Y.Z-rc.N` op `main`, of start de workflow handmatig als droogrun. De pipeline
bouwt, test en scant. Resultaat: artifact + SBOM. Een `-rc`-versie kan naar staging, maar
**nooit** naar productie.

### 2. Regressietests
Volledige unit-, integratie- en end-to-endsuite plus handmatige verificatie van de
kernreis op staging.

### 3. Securitycheck
Geen openstaande kritieke of hoge bevindingen. Nieuwe afhankelijkheden beoordeeld. Bij
wijzigingen aan authenticatie, autorisatie of geldstromen: expliciete beoordeling door de
security officer (governance). Een openstaande kritieke of hoge bevinding **blokkeert de
release**.

### 4. Privacy- en compliancecheck
Nieuwe of gewijzigde verwerkingen beoordeeld, bewaartermijnen geregeld, DPIA bijgewerkt
(**vóór** de implementatie, niet hier voor het eerst), controls en bewijs bijgewerkt. Een
openstaande blokkerende regulatoire vraag of een ernstig privacyrisico **houdt de release
tegen** tot de bevoegde mandaathouder een gedocumenteerd besluit heeft genomen.

### 5. Releasebesluit van de Product Owner
Dit gaat over **vrijgave**, niet over de vraag of het werk af is: dat volgt al uit de
Definition of Done. De Product Owner beoordeelt of dit Done increment nú naar dit kanaal
moet: is de waarde er, is de testgroepfeedback verwerkt, kloppen de releasenotes, is de
communicatie geregeld?

#### Volgorde: de pipeline maakt het concept, de mens publiceert

Dit is de volgorde, en ze is niet uitwisselbaar:

1. **Push de tag** `vX.Y.Z` — let op de kleine `v`; een tag als `V1.0.0` matcht het
   patroon `v*.*.*` niet en start de workflow **stilzwijgend niet**.
2. **De workflow maakt zelf een concept-release aan** met de gegenereerde releasenotes
   als body (`draft: true`).
3. **Controleer en vul aan**: releasekanaal, security-, privacy- en compliance-impact,
   migraties, rollbackplan, goedkeuringen — de generator laat daar lege plekken voor.
4. **Publiceer het concept** zodra de release-workflow groen is.

> **Maak de release niet zelf aan vóór of tijdens het taggen.** De workflow verwacht een
> concept te kunnen maken. Vindt hij in plaats daarvan een reeds gepubliceerde release,
> dan kan hij die niet meer bijwerken — bij immutable releases weigert GitHub elke
> wijziging na publicatie — en faalt de job.

> **Publiceer ook niet vóórdat de workflow groen is.** Een gepubliceerde release is een
> uitspraak dat de controles zijn doorlopen. Faalt de workflow daarna alsnog, dan staat er
> een claim die niet klopt, en bij een immutable release krijg je die niet meer weg.

### 6. Gecontroleerde uitrol
Tag `vX.Y.Z` → goedkeuring op de `production`-environment → gefaseerde uitrol
(5% → 25% → 100%) met observatie tussen de stappen.

> **Let op — de pipeline rolt pas uit als je dat expliciet aanzet, en alleen vanaf een tag.**
>
> * Een **handmatige** uitvoering (`workflow_dispatch`) is altijd een **droogrun**: die
>   valideert de kandidaat maar rolt niets uit, ook niet met de variabelen aan.
> * **Staging** vereist een tag-push `v*.*.*` op de hoofdbranch én
>   `STAGING_DEPLOY_ENABLED=true`.
> * **Productie** vereist daarnaast een **stabiele** SemVer-versie (geen `-rc`, `-alpha`,
>   `-beta`), een kanaal uit de allowlist (`RELEASE_CHANNEL` = `limited-production` of
>   `general-availability`), `PRODUCTION_DEPLOY_ENABLED=true` én goedkeuring door de
>   required reviewers op de environment `production`.
> * De kanalen `internal-prototype`, `test-group` en `beta` bereiken **nooit** productie.
> * Gebeurt er niets, dan wordt er **geen** deploymentbewijs geschreven en meldt de job
>   `deployment-status` waarom.
>
> Zie [`../operations/deployment.md`](../operations/deployment.md) §6.

### 7. Monitoring
Minimaal `[30]` minuten actief meekijken: foutratio, latency, inlogpogingen, mislukte
transacties, auditlogvolume. Iemand kijkt daadwerkelijk, niet alleen "het dashboard staat open".

### 8. Rollback beschikbaar
Feature flag, vorige tag of migratieterugval — het plan staat in de pull request en is
getest.

### 9. Evaluatie na release
Binnen `[3]` werkdagen: werkte de uitrol, wat merkten gebruikers, wat leren we voor de
volgende keer? Bevindingen naar de retrospective; bewijs naar `audit-evidence.md`.

## 4. Releasenotes

Gegenereerd met `scripts/release/prepare-release-notes.sh` op basis van Conventional
Commits, daarna aangevuld door het team met: releasekanaal, security-, privacy- en
compliance-impact, migraties, rollbackplan, goedkeuringen en bekende beperkingen.

Publieke releasenotes bevatten **geen** exploitdetails. Een securityfix wordt neutraal
beschreven ("verbeterde controle op X"), met details pas na een redelijke updateperiode.

## 5. Hotfix

1. Branch `fix/…` vanaf de tag van de laatste release.
2. Minimale wijziging + test die het probleem afdekt.
3. Versnelde maar **volledige** securitycheck; de DoD blijft gelden.
4. Tag `vX.Y.Z+1`, uitrollen, monitoren.
5. Terugmergen naar `main`; post-mortem als het een incident betrof.

## 6. Wanneer releasen we niet?

* Bij een openstaande kritieke of hoge kwetsbaarheid.
* Bij een blokkerende privacy- of compliancevraag.
* Zonder rollbackplan.
* Zonder iemand die na de uitrol daadwerkelijk meekijkt.
* Vlak vóór een periode waarin niemand beschikbaar is (bijvoorbeeld vrijdagmiddag), tenzij
  het een securityfix is.
