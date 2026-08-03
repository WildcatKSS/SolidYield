# Productdoelen

Een productdoel beschrijft een **verandering in gebruikersgedrag of -uitkomst**, niet een
lijst functionaliteit. Per moment werkt het team aan **één** productdoel; de sprintdoelen
zijn stappen daarnaartoe.

## Structuur

```
Productdoel  → waar werken we de komende maanden naartoe
└── Epic     → grote brok waarde die aan het doel bijdraagt
    └── Feature
        └── User story
```

## Huidig productdoel

| Veld | Waarde |
|---|---|
| ID | PD-1 |
| Doel | Een betrouwbare digitale omgeving realiseren waarin een Nederlandse particuliere of zakelijke gebruiker zelfstandig een account kan openen, identificatie kan doorlopen, geld kan storten, een bedrag en looptijd kan kiezen, en continu inzicht heeft in de afgesproken rente, de einddatum en de verwachte uitkering. |
| Waarom nu | De doelgroep staat voor een keuze tussen laagrentend sparen en complex, volatiel beleggen. SolidYield mikt op de middenweg. Vóór er gebouwd wordt, moet blijken dat dat probleem urgent genoeg is (A1) en dat wij dit product mogen aanbieden (A4/RD-01). |
| Doelgroep | Particuliere spaarders in Nederland zonder financiële expertise; secundair ondernemers en zzp'ers met tijdelijk overtollige liquiditeit |
| Streefdatum | `[JJJJ-MM-DD]` — richtinggevend, geen deadline. Niet vast te stellen zolang RD-01 open is |
| Eigenaar | Product Owner |
| Status | **concept** — wordt pas *actief* als PD-0 is afgerond |

> ⚠️ **Dit doel is outputgericht geformuleerd** ("een omgeving realiseren") en beschrijft
> daarmee opleveren in plaats van een verandering in gebruikersgedrag of -uitkomst. Het is
> in deze vorm overgenomen omdat het de richting van de Product Owner vastlegt, maar het
> stuurt niet op validatie.
>
> **Voorstel voor herformulering**, te bespreken bij de eerste Sprint Review:
>
> > *Een gebruiker uit de doelgroep kan binnen vijftien minuten zelfstandig een inleg
> > afronden, en kan daarna in eigen woorden correct benoemen welk bedrag hij wanneer
> > terugkrijgt en welk risico hij loopt.*
>
> Die formulering is meetbaar, gaat over de gebruiker in plaats van over ons, en dekt
> zowel de kernbelofte ("volledige controle") als principe 5 ("nooit misleidend").

### Meetwaarden

| Meetwaarde | Nulmeting | Streefwaarde | Bron | Privacyaandachtspunt |
|---|---|---|---|---|
| Taaksucces: gebruiker rondt zelfstandig een inleg af | `[?]` | `≥ 80%` | usabilitytest | geanonimiseerd |
| Begrip: gebruiker benoemt correct einddatum, uitkering én risico | `[?]` | `≥ 80%` | usabilitytest | geanonimiseerd |
| Vertrouwen: rapportcijfer duidelijkheid van de voorwaarden | `[?]` | `≥ 8` | testgroep | vrijwillig |

> Meten mag nooit een doel op zich worden. Meetwaarden die aanzetten tot dark patterns
> (bijvoorbeeld schermtijd, ingelegd bedrag of aantal transacties om het aantal) zijn niet
> toegestaan. De begripsmaat is hier bewust een **rem**: scoort die laag, dan is de
> oplossing helderder communiceren, niet meer inleg werven.

### Bijdragende epics

| Epic | Titel | Bijdrage aan PD-1 | Status |
|---|---|---|---|
| E1 | `[TITEL]` | `[BIJDRAGE]` | te doen |
| E2 | `[TITEL]` | `[BIJDRAGE]` | te doen |
| E3 | `[TITEL]` | `[BIJDRAGE]` | te doen |

> Nog niet ingevuld. Epics worden pas gesneden na PD-0, zodat ze op bevestigde aannames
> rusten in plaats van op de productbeschrijving alleen.

Zie de uitgewerkte, fictieve voorbeeldversie in [`example-backlog.md`](example-backlog.md).

## Eerdere en toekomstige doelen

| ID | Doel | Periode | Status | Geleerd |
|---|---|---|---|---|
| PD-0 | **Validatie:** aantonen dat het probleem urgent is bij de doelgroep (A1), en vaststellen onder welk regulatoir regime SolidYield mag worden aangeboden (A4 / RD-01) | vanaf 2026-08-03 | **actief** | — |

> PD-0 gaat vooraf aan PD-1. Zolang RD-01 openstaat is niet vastgesteld dat dit product in
> deze vorm mag worden aangeboden; substantieel bouwen aan PD-1 zou dan investeren zijn in
> een propositie die nog kan wijzigen of vervallen. Onderzoek, ontwerp en het opzetten van
> de repository lopen ondertussen gewoon door.

## Herzieningsregels

* Een productdoel wordt niet stilzwijgend gewijzigd; wijziging is een expliciet besluit
  van de Product Owner, vastgelegd in dit bestand met datum en onderbouwing.
* Weerlegt onderzoek de aanname onder een doel, dan wordt het doel aangepast of stopgezet
  (zie de stop-/wijzig-/doorgaancriteria in [`mvp-scope.md`](mvp-scope.md)).

| Datum | Wijziging | Door |
|---|---|---|
| 2026-08-03 | PD-1 vastgelegd op basis van het productdoel van de Product Owner; PD-0 (validatie) toegevoegd als voorliggend doel | Product Owner |
