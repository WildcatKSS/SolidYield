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
| Doel | `[PRODUCTDOEL]` |
| Waarom nu | `[ONDERBOUWING]` |
| Doelgroep | `[DOELGROEP]` |
| Streefdatum | `[JJJJ-MM-DD]` — richtinggevend, geen deadline |
| Eigenaar | Product Owner |
| Status | concept / actief / behaald / vervallen |

### Meetwaarden

| Meetwaarde | Nulmeting | Streefwaarde | Bron | Privacyaandachtspunt |
|---|---|---|---|---|
| `[GEDRAGSMAAT, bijv. % gebruikers dat wekelijks terugkeert]` | `[?]` | `[?]` | analytics | geaggregeerd, geen individuele profielen |
| `[UITKOMSTMAAT, bijv. taaksucces in usabilitytests]` | `[?]` | `≥ 80%` | onderzoek | geanonimiseerd |
| `[VERTROUWENSMAAT, bijv. rapportcijfer duidelijkheid]` | `[?]` | `≥ 8` | testgroep | vrijwillig |

> Meten mag nooit een doel op zich worden. Meetwaarden die aanzetten tot dark patterns
> (bijvoorbeeld schermtijd of aantal transacties om het aantal) zijn niet toegestaan.

### Bijdragende epics

| Epic | Titel | Bijdrage aan PD-1 | Status |
|---|---|---|---|
| E1 | `[TITEL]` | `[BIJDRAGE]` | te doen |
| E2 | `[TITEL]` | `[BIJDRAGE]` | te doen |
| E3 | `[TITEL]` | `[BIJDRAGE]` | te doen |

Zie de uitgewerkte, fictieve voorbeeldversie in [`example-backlog.md`](example-backlog.md).

## Eerdere en toekomstige doelen

| ID | Doel | Periode | Status | Geleerd |
|---|---|---|---|---|
| PD-0 | `[VOORBEREIDING / VALIDATIE]` | `[PERIODE]` | `[STATUS]` | `[LES]` |

## Herzieningsregels

* Een productdoel wordt niet stilzwijgend gewijzigd; wijziging is een expliciet besluit
  van de Product Owner, vastgelegd in dit bestand met datum en onderbouwing.
* Weerlegt onderzoek de aanname onder een doel, dan wordt het doel aangepast of stopgezet
  (zie de stop-/wijzig-/doorgaancriteria in [`mvp-scope.md`](mvp-scope.md)).
