# ADR-0003: Cloudprovider en hostingarchitectuur

* **Status:** **Geaccepteerd** (besluit 5, 2026-08-05)
* **Datum:** 2026-08-05
* **Beslissers:** Tech lead
* **Geraadpleegd:** Product Owner, Security, Privacy, Compliance

> [!IMPORTANT]
> Er wordt **één** hostingprovider gebruikt. Er worden geen extra cloudproviders
> geïntroduceerd. De technologiestack staat in [ADR-0002](0002-technologiestack.md); de
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

**TransIP Object Store**, met **afzonderlijke buckets per omgeving**:

| Omgeving | Buckets |
|---|---|
| Productie | `documents` · `exports` · `backups` |
| Test | `documents` · `exports` · `backups` |

Toegepast op elke bucket:

* **versioning**
* **encryptie**
* **lifecycle policies**
* **korte presigned URL's**

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

* **Concentratierisico bij één provider.** Uitval, prijswijziging of beëindiging van de
  dienst raakt productie en test tegelijk. Er is geen tweede provider als uitwijk.
  *Beperking:* back-ups en disaster recovery op een geografisch gescheiden secundaire
  locatie (ADR-0006); herstelbaarheid periodiek testen.
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
| 5 | Hersteltest uitvoeren en vastleggen (C-12) | Ops |
| 6 | SLO's herijken op een architectuur met één productiemachine | Ops + Product Owner |

## Gerelateerde besluiten

* Technologiestack: [ADR-0002](0002-technologiestack.md)
* Dataresidency: [ADR-0006](0006-dataresidency-en-opslaglocatie.md)
* Sleutelbeheer: `ADR-0005` (nog te schrijven)

## Herzieningsmoment

Bij een beschikbaarheidseis die met één productiemachine niet haalbaar is, bij groei van de
belasting, of wanneer de provider de benodigde diensten niet meer levert.
