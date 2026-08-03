# Zo werken wij: Scrum bij `[PRODUCTNAAM]`

> **Doel:** vastleggen hoe dit team Scrum toepast.
> **Wanneer gebruiken:** bij onboarding en bij twijfel over de werkwijze.
> **Wie:** het hele Scrum Team.
> **Adoptieniveau:** Core.
> **Gerelateerd:** [`roles.md`](roles.md) · [`anti-patterns.md`](anti-patterns.md) · [`project-board.md`](project-board.md)

Dit document beschrijft hoe dit team Scrum toepast. Het volgt de Scrum Guide en vult die
aan met wat een **financiële dienst** extra vraagt: security, privacy en compliance zijn
onderdeel van het werk, niet een fase erna.

Herken je de vorm van Scrum zonder de werking? Loop dan
[`anti-patterns.md`](anti-patterns.md) langs — vijftien patronen met symptoom, waarom het
schadelijk is en de correctie.

## 1. Kern in één alinea

Wij werken in sprints van `[SPRINTDUUR — aanname: 2 weken]`. Elke sprint levert een
**bruikbaar, getest en potentieel releasbaar increment** op. "Potentieel releasbaar"
betekent: het voldoet aan de [Definition of Done](definition-of-done.md), inclusief
security-, privacy- en toegankelijkheidscontroles. Of we het ook daadwerkelijk uitrollen,
is een aparte beslissing van de Product Owner.

## 2. Sprintduur

| Optie | Wanneer passend | Nadeel |
|---|---|---|
| **1 week** | ervaren team, volledig geautomatiseerde pipeline, veel onzekerheid | weinig ruimte voor grotere brokken; hoge eventdruk |
| **2 weken (advies)** | standaard; genoeg ruimte voor bouwen én valideren met de testgroep | trager leren dan 1 week |

> **Aanname:** 2 weken. Bevestig dit in de eerste retrospective en leg de keuze hier vast.

## 3. Rollen

Het **Scrum Team** kent drie accountabilities. Meer niet — expertise is iets anders dan een
rol. Volledige uitwerking: [`roles.md`](roles.md).

| Accountability | Verantwoordelijk voor |
|---|---|
| **Product Owner** | waarde, productdoel, backlogvolgorde; inspecteert het resultaat en beslist over vrijgave |
| **Scrum Master** | effectieve toepassing van Scrum, belemmeringen wegnemen |
| **Developers** | het increment bouwen, plannen hoe dat gebeurt, en aantoonbaar aan de DoD laten voldoen |

De **Developers zijn multidisciplinair**: softwareontwikkeling, UX en gebruikersonderzoek,
testen, security engineering, privacy engineering, compliance-uitvoering en operations
zitten binnen deze groep. Wie structureel aan het increment bijdraagt, is een Developer —
ongeacht functietitel. Zo wordt kwaliteit niet "van iemand anders".

Daarnaast bestaan er **onafhankelijke governancerollen** buiten het Scrum Team (security
officer, privacy officer/DPO, compliance officer) en **stakeholders**, waaronder de
deelnemers aan de testgroep. Zij adviseren, toetsen en kunnen een release tegenhouden,
maar zij zijn geen Scrum-accountability en bepalen niet of werk Done is.

## 4. Artefacten

| Artefact | Waar | Verbintenis |
|---|---|---|
| Product Backlog | GitHub Issues + Projects-board | Productdoel |
| Sprint Backlog | kolommen *Sprint backlog* → *In progress* | Sprintdoel |
| Increment | main-branch + testomgeving | Definition of Done |

Board en velden: [`project-board.md`](project-board.md).
Labels: [`labels.md`](labels.md).

## 5. Backloghiërarchie

```
Productdoel
└── Epic
    └── Feature
        └── User story
            ├── Technische taak
            ├── Testtaak
            ├── Securitytaak
            └── Compliance- of privacytaak
```

Regels:

* Alleen **user stories** en items met directe waarde krijgen story points; taken worden
  in uren of niet geschat.
* Een user story die niet binnen één sprint past, wordt gesplitst (per stap van de reis,
  per regel/variant, of gelukkig-pad eerst).
* Een story is nooit "af" zonder de bijbehorende security-, privacy- en testtaken.

## 6. Events

| Event | Duur bij 2 weken | Wie | Doel |
|---|---|---|---|
| [Sprint Planning](sprint-planning.md) | max. 4 uur | Scrum Team | sprintdoel en plan bepalen |
| Daily Scrum | 15 minuten | developers (rest optioneel) | voortgang naar het sprintdoel bijsturen |
| [Backlog Refinement](refinement.md) — *doorlopende activiteit, geen formeel event* | ~5% van de sprint | wie het werk raakt | items Ready maken |
| [Sprint Review](sprint-review.md) | max. 2 uur | Scrum Team + stakeholders (waaronder deelnemers uit de testgroep) | increment inspecteren, feedback ophalen |
| [Sprint Retrospective](retrospective.md) | max. 1,5 uur | Scrum Team | werkwijze verbeteren |

### Daily Scrum

Elke werkdag, 15 minuten, zelfde tijd en plaats. Het is **geen statusrapportage aan de
Scrum Master**, maar bijsturing door de developers zelf.

Wij lopen het **board van rechts naar links** door en bespreken per item:

1. Wat brengt ons dichter bij het sprintdoel?
2. Wat blokkeert ons? (label `status:blocked`, kolom *Blocked*, met eigenaar en datum)
3. Is er iets veranderd aan risico, security, privacy of compliance?

Vaste extra check bij een financiële dienst:
* staat er iets in *In review* of *Ready for testing* dat wacht op een security- of
  privacybeoordeling?
* zijn er nieuwe kritieke of hoge kwetsbaarheden gemeld door de pipeline?
* staat er iets op *Done* dat de Definition of Done nog niet aantoonbaar haalt?

Alles wat langer duurt dan een minuut, gaat naar een vervolgafspraak direct na de daily.

## 7. Werkafspraken

1. **Definition of Ready** vóór de sprint, **Definition of Done** vóór "Done" — geen
   uitzonderingen zonder expliciet vastgelegd besluit.
2. **Werk in uitvoering beperken:** maximaal `[2]` items per developer in *In progress*.
   Liever samen afmaken dan apart beginnen.
3. **Sprintdoel is heilig, scope is dat niet.** Nieuw werk komt alleen de sprint in als het
   sprintdoel niet in gevaar komt en de PO akkoord is.
4. **Geen werk zonder issue.** Traceerbaarheid is bij een financiële dienst een eis.
5. **Security en privacy zijn taken, geen meningen.** Elk signaal wordt een backlogitem
   met eigenaar.
6. **Doorlopend gebruikerscontact, risicogestuurd ingevuld.** Elke sprint met
   gebruikersimpact of een openstaande gebruikersaanname bevat een expliciete
   leeractiviteit; de zwaarte daarvan hangt af van het risico
   ([`../research/test-group-plan.md`](../research/test-group-plan.md)).
7. **Nooit echte persoonsgegevens of productiedata** buiten productie.
8. **Slechte kwaliteit is nooit een oplossing voor tijdsdruk.** Bij tijdgebrek gaat scope
   eruit, niet de Definition of Done.

## 8. Omgaan met onderbrekingen

| Situatie | Aanpak |
|---|---|
| Kritieke productieverstoring | volg [`../operations/runbook.md`](../operations/runbook.md); sprintdoel kan worden losgelaten in overleg met de PO |
| Kritieke kwetsbaarheid (CVSS ≥ 9) | direct oppakken binnen de SLA uit [`../security/vulnerability-management.md`](../security/vulnerability-management.md) |
| Ad-hocverzoek van een belanghebbende | naar *Inbox* op het board; PO prioriteert |
| Ongepland maar klein werk | reserveer een vaste buffer van `[10]%` capaciteit |

## 9. Meten van het proces

Wij meten om te leren, niet om te beoordelen. Individuele productiviteit wordt niet
gemeten.

| Meetwaarde | Waarvoor |
|---|---|
| Sprintdoel gehaald (ja/nee) | voorspelbaarheid |
| Doorlooptijd van item (Ready for sprint → Done) | stroom |
| Aantal geblokkeerde dagen | belemmeringen |
| Ontsnapte defecten (gevonden na Done) | kwaliteit |
| Openstaande kritieke/hoge kwetsbaarheden | veiligheid |
| Sprints met een expliciete leeractiviteit | leersnelheid |
| Aantal feedbackitems omgezet in backlogitems | feedbackcyclus |

Velocity is een hulpmiddel voor het team zelf en **geen doel of prestatiemaat**.

## 10. Wanneer wijken we af?

Afwijken van een **werkafspraak** in dit document mag: het Scrum Team neemt het besluit en
legt reden en vervaldatum vast in de retrospective.

Afwijken van de **Definition of Done** kan niet. Ontbreekt een verplicht criterium, dan is
het item niet Done en blijft het werk staan
([`definition-of-done.md`](definition-of-done.md) §4). De DoD kan wel **prospectief**
worden aangepast voor toekomstig werk — nooit met terugwerkende kracht om lopend werk af
te ronden.

Risicoacceptatie ([`../../GOVERNANCE.md`](../../GOVERNANCE.md) §4) is een apart
governanceproces voor het restrisico van **uitgevoerd** werk, en verandert nooit of iets
Done is.
