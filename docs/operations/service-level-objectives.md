# Service Level Objectives (SLO's)

SLO's maken expliciet welke betrouwbaarheid wij nastreven. Ze zijn er om **keuzes** mee te
maken: is er ruimte voor nieuwe functionaliteit, of moeten we eerst stabiliseren?

> De waarden hieronder zijn voorstellen voor een MVP. Laat ze bevestigen door de Product
> Owner en de opdrachtgever; bij een financiële dienst kunnen contractuele of regulatoire
> eisen strenger zijn — **te valideren door een bevoegde specialist**.

> **Gerelateerd:** [`sre-principles.md`](sre-principles.md) · [`monitoring.md`](monitoring.md)

## 1. SLO's

| # | Service level indicator | Doel | Meetvenster | Waarom deze waarde |
|---|---|---|---|---|
| SLO-1 | Beschikbaarheid van de kernreis | `[99,5]%` | 30 dagen | ±3,6 uur uitval per maand toegestaan in de MVP-fase |
| SLO-2 | Latency p95 van de belangrijkste weergave | `< [500]` ms | 30 dagen | het inzicht moet direct voelen |
| SLO-3 | Foutratio (5xx) | `< [0,5]%` | 30 dagen | fouten rond geld zijn extra schadelijk |
| SLO-4 | Geslaagde inlogpogingen (van legitieme pogingen) | `> [99]%` | 30 dagen | inloggen mag nooit de blokkade zijn |
| SLO-5 | Versheid van financiële gegevens | `< [60]` min achterstand | 7 dagen | verouderd inzicht is misleidend |
| SLO-6 | Correctheid van berekeningen | `[100]%` | doorlopend | geen tolerantie; elk verschil is een incident |
| SLO-7 | Afhandeling verwijder-/exportverzoek | binnen `[1 maand]` | per verzoek | recht van de gebruiker |
| SLO-8 | Herstel na uitval (RTO) | `< [4]` uur | per incident | zie backup-and-recovery |

SLO-6 kent bewust geen foutbudget: onjuiste bedragen tonen is geen "acceptabel percentage".

## 2. Foutbudget

Bij SLO-1 (`99,5%`) is het foutbudget ±3,6 uur per 30 dagen.

| Verbruik | Gevolg |
|---|---|
| < 50% | normale ontwikkeling, gerust uitrollen |
| 50–80% | extra aandacht bij risicovolle wijzigingen |
| 80–100% | alleen bugfixes en stabiliteit; nieuwe functionaliteit pauzeert |
| > 100% | stabiliteit is de sprintprioriteit; post-mortem verplicht |

Dit is een **teamafspraak**, geen straf: het maakt de afweging tussen tempo en
betrouwbaarheid expliciet.

## 3. Meten

| SLO | Bron | Dashboard |
|---|---|---|
| SLO-1, 2, 3 | applicatiemonitoring | operationeel |
| SLO-4 | authenticatiemetrieken | security |
| SLO-5 | achterstand in wachtrij/synchronisatie | operationeel |
| SLO-6 | reconciliatiecontroles + tests | kwaliteit |
| SLO-7 | verzoekenregistratie | compliance |
| SLO-8 | incidentregistratie | operationeel |

## 4. Rapportage

* **Per sprint:** stand van de SLO's in de Sprint Review.
* **Per maand:** foutbudgetverbruik en trend.
* **Bij overschrijding:** post-mortem, verbeteracties als backlogitems.

## 5. Wat een SLO niet is

* Geen belofte aan klanten (dat zou een SLA zijn, met andere gevolgen).
* Geen prestatiemaat voor personen.
* Geen reden om incidenten te verbergen: een eerlijk gemeten SLO is meer waard dan een
  mooi cijfer.

## 6. Nog te bepalen

| Onderwerp | Eigenaar |
|---|---|
| Definitieve waarden na de eerste maand meten | team + PO |
| Contractuele of regulatoire eisen aan beschikbaarheid | Compliance |
| Oproepregeling en dekking buiten kantoortijd | Ops |
