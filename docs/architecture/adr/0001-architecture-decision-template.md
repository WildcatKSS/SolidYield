# ADR-0001: Sjabloon voor architectuurbesluiten

* **Status:** Geaccepteerd
* **Datum:** `[JJJJ-MM-DD]`
* **Beslissers:** Tech lead, `[NAMEN]`
* **Geraadpleegd:** Security, Privacy/Compliance, Product Owner

---

> **Hoe gebruik je dit sjabloon?**
> Kopieer dit bestand naar `docs/architecture/adr/000X-korte-titel.md`, met een oplopend
> nummer. Eén ADR = één beslissing. Een ADR wordt nooit herschreven nadat hij is
> geaccepteerd: is de beslissing achterhaald, dan zet je de status op *Vervangen door
> ADR-000Y* en schrijf je een nieuwe.
>
> **Wanneer schrijf je een ADR?** Bij elke beslissing die moeilijk terug te draaien is,
> die meerdere teams of componenten raakt, of die security-, privacy- of compliance-impact
> heeft. Vuistregel: als je over zes maanden zou willen weten *waarom* iets zo is, schrijf
> dan een ADR.

---

## Titel

`ADR-000X: [KORTE, BESCHRIJVENDE TITEL]`

## Status

`Voorgesteld` · `Geaccepteerd` · `Afgewezen` · `Verouderd` · `Vervangen door ADR-000Y`

## Datum

`[JJJJ-MM-DD]` — datum waarop de status voor het laatst wijzigde.

## Context

Wat is de situatie? Welke krachten spelen er (technisch, organisatorisch, regulatoir,
tijd, budget, kennis in het team)? Wat is er al besloten en wat ligt vast?

## Probleem

Eén concrete vraag die deze ADR beantwoordt.

> Voorbeeld: *"Welke identiteitsprovider gebruiken wij voor authenticatie en MFA?"*

## Besliscriteria

Waarop wegen we de opties? Geef gewichten als niet alles even zwaar telt.

| # | Criterium | Gewicht | Toelichting |
|---|---|---|---|
| C1 | Security (MFA, sessiebeheer, hardening) | hoog | niet onderhandelbaar |
| C2 | Privacy en dataresidency | hoog | gegevens binnen `[REGIO]` |
| C3 | Kennis in het team | midden | leercurve en onderhoud |
| C4 | Kosten (bouw en beheer) | midden | |
| C5 | Leveranciersafhankelijkheid en exitmogelijkheid | midden | |
| C6 | Toegankelijkheid en gebruikerservaring | hoog | |
| C7 | Aantoonbaarheid voor audits | midden | |

## Onderzochte opties

### Optie A — `[NAAM]`
* Beschrijving:
* Voordelen:
* Nadelen:
* Score per criterium:

### Optie B — `[NAAM]`
* Beschrijving:
* Voordelen:
* Nadelen:
* Score per criterium:

### Optie C — `[NAAM]` *(bijvoorbeeld: niets doen / uitstellen)*
* Beschrijving:
* Voordelen:
* Nadelen:

## Gekozen optie

**`[OPTIE X]`**

## Motivatie

Waarom deze optie, in het licht van de besliscriteria? Benoem expliciet welke nadelen we
bewust accepteren en waarom die aanvaardbaar zijn.

## Positieve gevolgen

* …

## Negatieve gevolgen

* …
* *(en wat we doen om die te beperken)*

## Security-impact

* Welke dreigingen worden kleiner of groter? Verwijs naar T-nummers in
  [`../threat-model.md`](../threat-model.md).
* Nieuwe aanvalsoppervlakken?
* Gevolgen voor authenticatie, autorisatie, sleutelbeheer, logging?
* Beoordeeld door: `[NAAM]` op `[DATUM]`

## Privacy-impact

* Welke persoonsgegevens raakt dit besluit?
* Verandert het doel, de bewaartermijn, de opslaglocatie of de toegang?
* Is er sprake van doorgifte buiten `[REGIO]`?
* Is een (aanvullende) DPIA nodig? ⬜ ja ⬜ nee
* Beoordeeld door: `[NAAM]` op `[DATUM]`

## Compliance-impact

* Welke controls uit [`../../compliance/control-mapping.md`](../../compliance/control-mapping.md) raakt dit?
* Ontstaat er een mogelijke nieuwe verplichting? → **te valideren door een bevoegde
  specialist**; registreren in
  [`../../compliance/regulatory-decisions.md`](../../compliance/regulatory-decisions.md).
* Welk bewijs moeten we vastleggen?

## Vervolgacties

| # | Actie | Eigenaar | Issue | Deadline |
|---|---|---|---|---|
| 1 | | | # | |
| 2 | | | # | |

## Gerelateerde besluiten

* Bouwt voort op: `ADR-000X`
* Wordt geraakt door: `ADR-000Y`
* Gerelateerde issues: `#…`

## Herzieningsmoment

Wanneer beoordelen we of dit besluit nog klopt? `[DATUM of GEBEURTENIS]`
