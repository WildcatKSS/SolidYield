# ADR-0003: Cloudprovider en hostingarchitectuur

* **Status:** **Geaccepteerd** (besluit 5, 2026-08-05)
* **Datum:** 2026-08-05
* **Beslissers:** Tech lead
* **Geraadpleegd:** Product Owner, Security, Privacy, Compliance

> [!IMPORTANT]
> **TransIP is de gekozen startprovider voor de MVP.** Alle omgevingen draaien daar: het
> is geen multi-providerarchitectuur. Dit besluit **verbiedt niet** dat later een
> onafhankelijke back-up- of uitwijklocatie bij een andere partij wordt toegevoegd; die
> mogelijkheid blijft architectonisch open en is een herzieningstrigger (zie
> *Concentratierisico*).
>
> De technologiestack staat in [ADR-0002](0002-technologiestack.md); de
> dataresidency-randvoorwaarde in [ADR-0006](0006-dataresidency-en-opslaglocatie.md).

## Probleem

Waar draait SolidYield, en hoe zijn productie en test van elkaar gescheiden?

## Gekozen optie

**TransIP** als hostingprovider, met **twee afzonderlijke VPS'en**.

| | Productie | Test |
|---|---|---|
| Machine | afzonderlijke TransIP VPS | afzonderlijke TransIP VPS |
| Besturingssysteem | **Ubuntu Server LTS** | **Ubuntu Server LTS** |
| Webserver | Nginx | Nginx |
| Frontend | React/Vite (statische bestanden) | React/Vite (statische bestanden) |
| API | Spring Boot (systemd) | Spring Boot (systemd) |
| Worker | Spring Boot (systemd) | Spring Boot (systemd) |
| Database | PostgreSQL | PostgreSQL |
| Beheertoegang | **WireGuard** | **WireGuard** |
| Bereikbaarheid | publiek (frontend en API) | **uitsluitend via WireGuard** |

Deze keuze sluit aan op [ADR-0006](0006-dataresidency-en-opslaglocatie.md): de primaire
productieomgeving staat fysiek in Nederland.

## Volledige scheiding tussen productie en test

Productie en test zijn **volledig gescheiden**. De volgende zaken worden **nooit** gedeeld:

* databases
* databasegebruikers
* Unix-accounts
* secrets
* signing keys
* object-storagebuckets
* provideraccounts
* monitoring
* logging
* back-ups

> Deze lijst is een **harde eis**, geen richtlijn. Elk gedeeld item hierboven is een pad
> waarlangs testdata in productie kan komen of productiedata in test — precies wat T-17 in
> het [threat model](../threat-model.md) beschrijft, en wat DoD-criterium U5 verbiedt.
> Testomgevingen draaien uitsluitend met **synthetische data**.

## Object storage

**TransIP Object Store**, met **unieke bucketnamen per omgeving**. Generieke namen zijn
niet toegestaan: bij een verkeerd geconfigureerde omgeving raakt een generieke naam
stilzwijgend de verkeerde bucket.

| Omgeving | Buckets |
|---|---|
| Productie | `solidyield-production-documents` · `solidyield-production-exports` · `solidyield-production-backups` |
| Test | `solidyield-test-documents` · `solidyield-test-exports` · `solidyield-test-backups` |

Toegepast op elke bucket: **versioning** · **encryptie** · **lifecycle policies** ·
**korte presigned URL's**.

### Gescheiden toegang per omgeving

Productie en test gebruiken **afzonderlijke**:

* Object Store-**credentials**
* **access keys**
* **endpoints/accounts of IAM-principals**
* **encryptiesleutels**
* **lifecycle- en retentieconfiguraties**

> **Harde eis:** een verkeerde *productie*credential mag technisch **geen** toegang geven
> tot test, en omgekeerd. De scheiding mag niet berusten op een correct ingevulde
> bucketnaam alleen; zij moet op autorisatieniveau afdwingbaar zijn. Toetsbaar gemaakt in
> control **C-24** en dreiging **T-27**.

**De frontend krijgt nooit object-storagecredentials.** Toegang loopt uitsluitend via de
backend, die kortlevende presigned URL's uitgeeft.

## Provisioning

**Ansible** · **Git** · **systemd**. Geen handmatige productieconfiguratie; Infrastructure
as Code is leidend. Uitwerking in [ADR-0002](0002-technologiestack.md) en
[`../../operations/deployment.md`](../../operations/deployment.md).

## Motivatie

Eén provider, twee machines, één besturingssysteem: dat is het kleinste beheeroppervlak
waarop een gescheiden test- en productieomgeving mogelijk is. TransIP levert hosting in
Nederland, wat rechtstreeks aansluit op de residency-eis uit ADR-0006 — die eis was
vastgelegd vóór deze keuze, en de keuze past daarbinnen.

Test achter WireGuard houden betekent dat een testomgeving nooit per ongeluk publiek
bereikbaar is. Dat is bij een financieel product geen luxe: een bereikbare testomgeving met
realistisch ogende data is een reëel lekpad.

## Positieve gevolgen

* De residency-eis uit ADR-0006 wordt gehaald zonder aanvullende constructie.
* Klein en overzichtelijk beheeroppervlak; geen orkestratielaag.
* Test is niet publiek bereikbaar.
* Volledige scheiding van omgevingen is expliciet en toetsbaar gemaakt.

## Negatieve gevolgen

* **Concentratierisico bij één provider — drie verschillende risico's die niet door
  dezelfde maatregel worden afgedekt:**

  | Risicosoort | Wat het is | Wordt afgedekt door |
  |---|---|---|
  | **Locatiegebonden uitval** | uitval van één fysiek datacenter: stroom, koeling, brand, netwerk | geografisch gescheiden secundaire locatie (ADR-0006) |
  | **Concentratierisico** | productie, test, object storage én back-ups staan alle bij TransIP | **niet afgedekt** — bewust geaccepteerd voor de MVP |
  | **Account-, control-plane-, contract- en providerbrede uitval** | compromittering of blokkade van het provideraccount, uitval van het beheerportaal of de API, contractbeëindiging, faillissement van de provider | **niet afgedekt** — bewust geaccepteerd voor de MVP |

  > Een geografisch gescheiden secundaire locatie bij dezelfde provider beperkt
  > locatiegebonden uitval, maar neemt providerbrede, accountgebonden en
  > control-plane-risico's niet weg. SolidYield accepteert dit concentratierisico voor de
  > MVP. Het risico wordt periodiek herbeoordeeld en vormt een herzieningstrigger voor
  > ADR-0003.

  *Beperking voor zover mogelijk:* back-ups en disaster recovery op een geografisch
  gescheiden secundaire locatie (ADR-0006), herstelbaarheid periodiek testen, en een
  exportmogelijkheid van back-ups die niet van het provideraccount afhankelijk is.
* **Zelf beheerde VPS'en betekent zelf patchen, harden, monitoren en herstellen.** Er is
  geen beheerde database, geen beheerde back-updienst en geen automatische failover. Dat is
  terugkerend werk, geen eenmalige inrichting.
* **Twee machines betekenen geen hoge beschikbaarheid.** Valt de productie-VPS uit, dan is
  de dienst uit de lucht tot herstel. De SLO's in
  [`../../operations/service-level-objectives.md`](../../operations/service-level-objectives.md)
  moeten daarop worden herijkt; 99,5% beschikbaarheid is met één machine geen vanzelfsprekendheid.
* **Geen containers betekent dat omgevingsgelijkheid van Ansible moet komen.** Zie
  ADR-0002.
* De GitHub Actions-workflows bevatten nog generieke deploy-placeholders; die moeten worden
  ingevuld voor deze architectuur.

## Vervolgacties

| # | Actie | Eigenaar |
|---|---|---|
| 1 | Ansible-playbooks voor beide VPS'en, inclusief WireGuard, Nginx, PostgreSQL en systemd-units | Tech lead |
| 2 | Scheiding van de tien niet-gedeelde items aantoonbaar maken (accounts, buckets, secrets, back-ups) | Tech lead + Security |
| 3 | Deploystappen in `release.yml` invullen voor deze architectuur; `PRODUCTION_DEPLOY_ENABLED` blijft uit tot dat klaar is | Tech lead |
| 4 | Secundaire locatie voor back-up en disaster recovery kiezen en de scheiding onderbouwen (ADR-0006) | Tech lead + Ops |
| 4a | Concentratierisico periodiek herbeoordelen; beoordelen of een back-upkopie buiten het TransIP-account of bij een andere partij nodig is vóór echte klantgelden | Tech lead + Ops |
| 4b | Object Store-scheiding aantoonbaar maken: unieke bucketnamen, aparte credentials, access keys, endpoints/IAM-principals, encryptiesleutels en lifecycle-/retentieconfiguraties per omgeving | Tech lead + Security |
| 5 | Hersteltest uitvoeren en vastleggen (C-12) | Ops |
| 6 | SLO's herijken op een architectuur met één productiemachine | Ops + Product Owner |

## Gerelateerde besluiten

* Technologiestack: [ADR-0002](0002-technologiestack.md)
* Dataresidency: [ADR-0006](0006-dataresidency-en-opslaglocatie.md)
* Sleutelbeheer: `ADR-0005` (nog te schrijven)

## Herzieningsmoment

Bij een beschikbaarheidseis die met één productiemachine niet haalbaar is, bij groei van de
belasting, wanneer de provider de benodigde diensten niet meer levert, en bij de
**periodieke herbeoordeling van het concentratierisico** — dat laatste is een expliciete
herzieningstrigger voor dit besluit.
