# ADR-0002: Technologiestack

* **Status:** **Geaccepteerd** (besluit 5, 2026-08-05)
* **Datum:** 2026-08-05
* **Beslissers:** Tech lead
* **Geraadpleegd:** Product Owner, Security, Privacy, Compliance

> [!IMPORTANT]
> Dit besluit **vervangt alle eerdere open aannames** over de technologiestack. Er worden
> geen alternatieve stacks gehanteerd. De hostingkeuze staat in
> [ADR-0003](0003-cloudprovider.md); de dataresidency-randvoorwaarde in
> [ADR-0006](0006-dataresidency-en-opslaglocatie.md).
>
> Deze ADR gaat over **techniek**. Zij verandert niets aan het bedrijfsmodel (besluit 4,
> [ADR-0007](0007-vergunningplicht-en-rol-in-de-keten.md)) en zegt niets over de wettelijke
> grondslag: de MVP draait tot bevestiging daarvan met **sandboxbetalingen en synthetische
> data**.

## Probleem

Welke technologiestack gebruiken wij voor de MVP van SolidYield?

## Context

De MVP moet een geldstroom en een contractadministratie ondersteunen met een audittrail die
reconstrueerbaar is. Het team is klein, de doorlooptijd naar een besloten testgroep telt, en
de operationele last moet beheersbaar blijven op twee VPS'en ([ADR-0003](0003-cloudprovider.md)).

## Frontend

| Onderdeel | Keuze |
|---|---|
| Framework | **React** met **TypeScript** |
| Build | **Vite** |
| Serverstate | **TanStack Query** |
| Formulieren | **React Hook Form** |
| Validatie | **Zod** |
| Componentdocumentatie | **Storybook** |
| End-to-end tests | **Playwright** |

React wordt gebouwd naar **statische bestanden**; **Nginx** serveert de frontend. Voor de
ingelogde applicatie wordt **geen Next.js** gebruikt.

## Backend

| Onderdeel | Keuze |
|---|---|
| Taal | **Kotlin** |
| Framework | **Spring Boot** |
| Beveiliging | **Spring Security** |
| Modulariteit | **Spring Modulith** |
| Databasetoegang | **jOOQ** |
| Migraties | **Flyway** |
| Validatie | **Bean Validation** |
| API-contract | **OpenAPI** |
| Metrics | **Micrometer** |
| Tracing | **OpenTelemetry** |
| Tests | **JUnit**, **Testcontainers** |

Er wordt **één executable JAR** gebouwd. **Dezelfde build** draait op test en productie.
**API en Worker draaien als afzonderlijke systemd-processen** uit datzelfde artifact.

## Architectuur: modulaire monoliet

Geen microservices. Modulegrenzen worden afgedwongen met **Spring Modulith**.

Modules:

`identity` · `customer` · `compliance` · `product` · `contract` · `ledger` · `payment` ·
`servicing` · `reconciliation` · `reporting` · `notification` · `document` ·
`administration` · `audit`

Elke module heeft:

* een duidelijke **publieke API**;
* eigen **packagegrenzen**;
* eigen **tests**;
* eigen **migraties** — in een eigen Flyway-locatie, met **globaal unieke versienummers**
  (zie *Migratieconventie* onder **Database**);
* expliciete **domeinevents**.

## Database

* **PostgreSQL**.
* **Gescheiden databases** voor productie en test.
* **Gescheiden databasegebruikers** voor **migraties**, **runtime**, **readonly** en
  **backup**.
* **Flyway** voert migraties uit; de **runtime-gebruiker mag geen schemawijzigingen
  uitvoeren**.

### Migratieconventie: geen versieconflicten tussen modules

Elke module heeft **eigen migraties**, maar er is **één gedeelde Flyway-schemahistorie** per
database. Zonder afspraak leveren twee modules dan vroeg of laat dezelfde versie aan en
faalt de migratie. De conventie:

| Afspraak | Uitwerking |
|---|---|
| **Eigen locatie per module** | `classpath:db/migration/<module>` — elke module beheert alleen zijn eigen map; de locaties worden samen aan Flyway meegegeven |
| **Eén globale versienummering** | het versienummer is **repositorybreed uniek**, niet uniek per module — dus geen `V1__` in twee modules |
| **Tijdgebonden versienummer** | `V<jjjjMMddHHmm>__<module>_<beschrijving>.sql`, bijvoorbeeld `V202608051430__ledger_add_correlation_id.sql`; een botsing vergt dan dezelfde minuut én dezelfde module |
| **Modulenaam in de bestandsnaam** | herkomst blijft zichtbaar in de schemahistorie, ook nadat de bestanden zijn samengevoegd |
| **Controle in CI** | een check faalt bij dubbele versienummers over alle modulelocaties heen, vóór de migratie draait |
| **Onveranderlijk na merge** | een gemigreerd bestand wordt nooit gewijzigd; een correctie is een nieuwe migratie |

> Alternatief overwogen: een **apart Flyway-schema per module**, elk met een eigen historie
> en eigen versiereeks. Dat maakt versienummers vanzelf conflictvrij, maar maakt migraties
> die meerdere modules raken en het herstellen van back-ups aanzienlijk ingewikkelder. Voor
> de MVP is één historie met globale versienummering de eenvoudigere keuze.

## Financiële administratie

Een **immutable double-entry ledger**:

| Regel | Toelichting |
|---|---|
| append-only | boekingen worden nooit gewijzigd |
| geen updates, geen deletes | ook niet door beheerders |
| correcties uitsluitend via **tegenboekingen** | het spoor blijft volledig |
| **idempotency keys** | herhaalde verwerking boekt nooit dubbel |
| **correlation IDs** | een geldstroom is end-to-end te volgen |
| **geen floating point** | integer minor units of een gecontroleerd decimaltype |

Boekingen gaan via **jOOQ of expliciete SQL**. **Geen generieke CRUD** voor
ledgerboekingen.

> Dit sluit aan op DoD-criterium C4 (geldstromen) en op T-19 en T-20 in het
> [threat model](../threat-model.md): onveranderlijkheid van gesloten contracten en
> idempotentie van uitkeringen zijn hier technisch verankerd in plaats van alleen
> procedureel.

## Achtergrondverwerking

| Wel | Niet |
|---|---|
| **PostgreSQL job queue** | Kafka |
| **Transactional Outbox** | Redis |
| **Workerproces** (eigen systemd-unit) | Temporal |
| **`FOR UPDATE SKIP LOCKED`** | OpenSearch |
| **Retries** met backoff | |
| **Dead-letter** | |
| **Idempotente handlers** | |

**Wat de outbox wél en niet garandeert.** De Transactional Outbox waarborgt dat de
domeinwijziging en het bijbehorende event **in dezelfde transactie** worden opgeslagen. Dat
sluit uit dat één van beide ontbreekt. Het sluit **niet** uit dat een event **meer dan één
keer wordt afgeleverd**: bij retries, een crash tussen aflevering en het markeren als
verwerkt, of een herstart van de worker kan hetzelfde event opnieuw langskomen. De
aflevergarantie is daarom **at-least-once**, niet exactly-once.

> **Consumers en jobhandlers moeten daarom idempotent zijn.** Elke handler verwerkt een
> herhaald event zonder aanvullend effect — afgedwongen met **idempotency keys** en unieke
> constraints op de doeltabel, niet met de aanname dat een event maar één keer aankomt.
> Voor geldstromen is dit een harde eis (T-20, DoD-criterium C4).

## Authenticatie

| Doelgroep | Middelen |
|---|---|
| **Klanten** | **Passkeys** en **WebAuthn** · **TOTP** · **veilige sessiecookies** · **sterke MFA** · wachtwoordopslag volgens de eis hieronder |
| **Medewerkers** | **verplichte MFA** · **hardware security keys** waar mogelijk · **aparte rollen** · **auditlogging** |

Dit besluit legt **uitsluitend de beveiligingseisen** vast. De identity provider en de
implementatie ervan zijn bepaald in **besluit 8** — [ADR-0004](0004-identity-and-access-management.md); de definitieve leverancierskeuze blijft daar uitdrukkelijk buiten.

> Passkeys/WebAuthn, TOTP, veilige sessiecookies en sterke MFA zijn verplichte
> authenticatiemogelijkheden. Wanneer SolidYield zelf wachtwoorden beheert, is Argon2id
> verplicht. Wanneer wachtwoordbeheer wordt uitbesteed aan een identity-provider, moet die
> provider een aantoonbaar gelijkwaardig of sterker wachtwoordopslag- en
> beveiligingsmechanisme gebruiken.

Argon2id is dus **geen onvoorwaardelijke implementatiekeuze**: welke van de twee gevallen
geldt, volgt uit de leverancierskeuze onder [ADR-0004](0004-identity-and-access-management.md).
Zolang die keuze openstaat, is de eis geformuleerd op beveiligingsniveau, niet op
implementatieniveau.

## Beheerinterface

Een **aparte beheerinterface**, uitsluitend bereikbaar via **WireGuard**. Ondersteunt
minimaal: klantbeheer · KYC · betalingen · reconciliation · audit · **maker-checker** ·
rapportages.

**Directe databasecorrecties zijn verboden.** Elke correctie loopt via de beheerinterface,
met maker-checker en audittrail — anders is de audittrail geen betrouwbare bron meer.

## Provisioning en deployment

| Onderdeel | Keuze |
|---|---|
| Configuratiebeheer | **Ansible** |
| Versiebeheer | **Git** |
| Procesbeheer | **systemd** |
| Artifacts | **CI-built**; productie **bouwt nooit opnieuw** |
| Uitrol | **release directories** met **atomische symlinks** |
| Migraties | **backward compatible** Flyway-migraties |

**Geen handmatige productieconfiguratie. Infrastructure as Code is leidend.** Hetzelfde
artifact gaat van test naar productie.

## Monitoring

* **Spring Boot Actuator** · **Micrometer** · **OpenTelemetry**.
* Strikt gescheiden: **technische logging**, **security logging** en **business audit**.

## Niet gebruiken in de MVP

**Docker** · **Kubernetes** · **Kafka** · **Redis** · **Temporal** · **OpenSearch** ·
**microservices**.

### Reikwijdte van deze uitsluiting

> Deze uitsluiting geldt **uitsluitend** voor:
>
> * **productie**;
> * **test** (de gedeelde testomgeving uit [ADR-0003](0003-cloudprovider.md));
> * de **deploymentarchitectuur**.
>
> Zij zegt niets over **lokale ontwikkelhulpmiddelen**. Gereedschap dat alleen op de machine
> van een ontwikkelaar of in een CI-job draait — bijvoorbeeld **Testcontainers** voor een
> wegwerp-PostgreSQL in een integratietest — is hierdoor **niet automatisch uitgesloten**.
>
> Dit is een **verduidelijking van de reikwijdte, geen nieuw technisch besluit**: er wordt
> hier niets toegestaan of gekozen. Wil het team zo'n hulpmiddel daadwerkelijk gebruiken,
> dan is dat een gewone teamafspraak, mits het **geen** onderdeel wordt van het
> productieartifact, de deployment of de draaiende test- of productieomgeving.

De uitsluiting gaat dus over **wat er draait waar de dienst draait**, niet over wat een
ontwikkelaar op zijn laptop start. Zonder dat onderscheid leest "geen Docker" al snel als
een verbod op containergebaseerd testgereedschap, en dat is niet wat hier is besloten.

## Motivatie

De stack is bewust smal: één taal aan de serverkant, één database, één artifact, en
achtergrondverwerking in diezelfde database. Dat houdt het aantal bewegende delen laag op
twee VPS'en die het team zelf beheert.

De zwaarste keuzes zitten niet in de frameworks maar in de **ledgerregels** en de
**scheiding van databasegebruikers**: die twee bepalen of een geldstroom achteraf
reconstrueerbaar is, en of een fout in de applicatie schema of historie kan aantasten.

## Positieve gevolgen

* Eén build, één artifact, identiek op test en productie — een klasse van
  "werkt-op-test"-fouten verdwijnt.
* Geen container- of orkestratielaag om te beheren of te beveiligen.
* Geen extra datastores: de job queue en de outbox zitten in dezelfde transactie als de
  domeinwijziging. Daarmee is **atomische opslag** van domeinwijziging en event
  gewaarborgd: er ontstaat geen event zonder domeinwijziging en geen domeinwijziging zonder
  event. **Aflevering is daarmee niet exactly-once:** een event kan **minstens eenmaal**
  worden afgeleverd, dus consumers moeten **idempotent** zijn (zie *Achtergrondverwerking*).
* Runtime kan het schema niet wijzigen.

## Negatieve gevolgen

* **Alles draait op twee VPS'en die het team zelf beheert.** Patchen, hardening, back-ups
  en herstel zijn eigen werk; er is geen beheerde dienst die dat overneemt. Zie
  [ADR-0003](0003-cloudprovider.md).
* **Geen containers betekent dat omgevingsgelijkheid van Ansible moet komen.** Wijkt een
  VPS handmatig af, dan is dat niet zichtbaar tenzij Ansible daadwerkelijk leidend blijft.
  *Beperking:* geen handmatige productieconfiguratie, en drift zichtbaar maken.
* **Een PostgreSQL job queue schaalt minder ver dan een dedicated broker.** Voor de MVP
  ruim voldoende; bij groei is dit het eerste onderdeel dat opnieuw beoordeeld moet worden.
* **Een modulaire monoliet houdt alleen stand als de grenzen worden afgedwongen.** Spring
  Modulith doet dat in tests; zonder die tests in CI verwatert de indeling.
* **Kotlin, Spring Modulith, jOOQ en WireGuard vragen kennis** die niet vanzelfsprekend
  aanwezig is. Leercurve en bus-factor zijn reëel.

## Vervolgacties

| # | Actie | Eigenaar |
|---|---|---|
| 1 | `[TECH STACK]`-afhankelijke CI-stappen (`ci.yml`, `setup-stack`, `dependabot.yml`, CodeQL-talen) invullen voor Kotlin/Gradle en Node | Tech lead |
| 2 | Spring Modulith-grenstests opnemen in de verplichte CI-controles | Tech lead |
| 3 | Vier databasegebruikers en hun rechten vastleggen in Ansible | Tech lead + Security |
| 4 | Ledgerregels vertalen naar domeintests (C4) | Developers |
| 5 | Maker-checker in de beheerinterface uitwerken | Tech lead + Compliance |

## Gerelateerde besluiten

* Hosting: [ADR-0003](0003-cloudprovider.md)
* Dataresidency: [ADR-0006](0006-dataresidency-en-opslaglocatie.md)
* Bedrijfsmodel: [ADR-0007](0007-vergunningplicht-en-rol-in-de-keten.md) ·
  [ADR-0008](0008-geld-en-contractstroom.md)
* Identity & Access Management: besluit 8 — [ADR-0004](0004-identity-and-access-management.md). De **definitieve leverancierskeuze** valt daarbuiten en is nog open

## Herzieningsmoment

Bij een aangetoond schaalknelpunt in de job queue, bij uitbreiding van het team, of wanneer
de modulegrenzen structureel niet houdbaar blijken.
