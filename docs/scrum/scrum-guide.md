# Zo werken wij: Scrum bij SolidYield

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

Wij werken in sprints van **twee weken**. Elke sprint levert een **bruikbaar, getest en
potentieel releasbaar increment** op. "Potentieel releasbaar" betekent: het voldoet aan de
[Definition of Done](definition-of-done.md), inclusief security-, privacy- en
toegankelijkheidscontroles. Of we het ook daadwerkelijk uitrollen, is een aparte beslissing
van de Product Owner.

> ⚠️ **Een sprintcadans is geen toestemming om te lanceren.** Zolang de wettelijke
> grondslag niet is bevestigd (RD-23 t/m RD-27), zijn echte klantgelden, bindende
> rendementcontracten, werkelijke rendementuitkeringen en productiegebruik **niet
> toegestaan** — ongeacht wat er in een sprint is opgeleverd. Zie
> [`../product/mvp-scope.md`](../product/mvp-scope.md).

## 2. Sprintduur — besloten

* **Status:** ✅ **besloten 2026-08-05** (besluit 6) · **Eigenaar:** Scrum Master

**SolidYield werkt met sprints van twee weken.** Een sprint duurt **veertien
kalenderdagen** en start en eindigt op **vaste werkdagen**; de concrete startdag wordt op
het board vastgelegd ([`project-board.md`](project-board.md), veld *Sprint*).

Iedere sprint bevat minimaal:

| Ceremonie | Zie |
|---|---|
| **Sprint planning** | [`sprint-planning.md`](sprint-planning.md) |
| **Dagelijkse afstemming** (Daily Scrum) | §6 hieronder |
| **Backlog refinement** | [`refinement.md`](refinement.md) |
| **Sprint review** | [`sprint-review.md`](sprint-review.md) |
| **Retrospective** | [`retrospective.md`](retrospective.md) |

### 2.1 Eén gezamenlijke backlog

**Architectuur-, security-, privacy-, compliance-, operations- en documentatiewerk staat in
dezelfde productbacklog als functionele ontwikkeling.** Dit werk wordt **niet** buiten het
sprintproces in een afzonderlijk parallel traject uitgevoerd.

Dat is geen administratieve voorkeur: werk dat naast de sprint loopt, wordt niet
geprioriteerd, niet geschat en niet zichtbaar geblokkeerd — precies de drie manieren waarop
een control stilvalt zonder dat iemand het merkt.

### 2.2 Uitgangspunten van de cadans

| # | Uitgangspunt |
|---|---|
| 1 | **Eén gezamenlijke, geprioriteerde productbacklog** — functioneel én niet-functioneel werk |
| 2 | Een sprint duurt **veertien kalenderdagen** |
| 3 | De sprint **start en eindigt op vaste werkdagen** |
| 4 | De **Scrum Master** bewaakt de cadans en faciliteert de ceremonies |
| 5 | De **Product Owner** bepaalt de prioriteit en het sprintdoel |
| 6 | Het **ontwikkelteam** bepaalt hoeveel werk realistisch kan worden opgenomen |
| 7 | **Onvoltooid werk gaat niet automatisch door** naar de volgende sprint, maar wordt opnieuw beoordeeld en geprioriteerd |
| 8 | **Urgente productie- of security-incidenten mogen de sprint onderbreken**, volgens een expliciet incidentproces (§8) |
| 9 | **Compliance- of juridische blokkades worden zichtbaar** als backlogitem, afhankelijkheid of releasevoorwaarde — nooit als stilzwijgend uitstel |
| 10 | Een sprint is **geen toestemming** om echte klantgelden, bindende rendementcontracten of productiegebruik toe te staan zolang verlening van de vereiste vergunning of een andere rechtsgeldige toestemming van de bevoegde toezichthouder ontbreekt |

**Buiten dit besluit vallen:** samenstelling of omvang van de testgroep (besluit 7),
Identity & Access Management (besluit 8), functionele requirements, sprintinhoud en concrete
ontwikkelplanning, en een releasedatum. Dat blijven afzonderlijke besluiten of backlogwerk.

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

| Event | Duur bij twee weken | Wie | Doel |
|---|---|---|---|
| [Sprint Planning](sprint-planning.md) | max. 4 uur | Scrum Team | sprintdoel en plan bepalen |
| Daily Scrum | 15 minuten | developers (rest optioneel) | voortgang naar het sprintdoel bijsturen |
| [Backlog Refinement](refinement.md) — *doorlopende activiteit, geen formeel event* | ~5% van de sprint, **minimaal één keer per sprint** | wie het werk raakt | items Ready maken |
| [Sprint Review](sprint-review.md) | max. 2 uur | Scrum Team + stakeholders (waaronder deelnemers uit de testgroep) | increment inspecteren, feedback ophalen |
| [Sprint Retrospective](retrospective.md) | max. 1,5 uur | Scrum Team | werkwijze verbeteren |

### Richtlijnen per ceremonie

**Sprint planning** — sprintdoel vaststellen · geselecteerde backlogitems bespreken ·
afhankelijkheden en risico's zichtbaar maken · acceptatiecriteria bevestigen · capaciteit
bepalen.

**Dagelijkse afstemming** — maximaal vijftien minuten · gericht op voortgang naar het
sprintdoel · blokkades worden benoemd · **inhoudelijke probleemoplossing vindt buiten de
dagelijkse afstemming plaats**.

**Backlog refinement** — minimaal één keer per sprint · toekomstige items verduidelijken ·
acceptatiecriteria toevoegen · **architectuur-, security-, privacy- en compliance-impact
beoordelen** · grote items splitsen.

**Sprint review** — werkende en aantoonbare resultaten demonstreren · **alleen werk dat aan
de [Definition of Done](definition-of-done.md) voldoet, geldt als afgerond** · feedback
wordt verwerkt in de backlog · **documentatiebesluiten mogen als resultaat worden getoond**
wanneer ze aantoonbaar zijn afgerond.

**Retrospective** — proces, samenwerking en technische werkwijze evalueren · maximaal een
klein aantal concrete verbeteracties kiezen · **verbeteracties krijgen een eigenaar** en
worden zichtbaar in de volgende sprint opgenomen.

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
   * De [DoR](definition-of-ready.md) is een **hulpmiddel, geen bureaucratische
     toegangspoort**: de Product Owner en het team mogen bewust een onderzoeks- of
     spike-item opnemen wanneer het doel en de verwachte uitkomst duidelijk zijn.
   * De [DoD](definition-of-done.md) blijft **repositorybreed ongewijzigd**: een item is pas
     afgerond wanneer de **voor dat item relevante** onderdelen zijn voltooid — implementatie,
     tests, review door iemand anders dan de maker, documentatie, securitycontrole, privacy-
     en compliancecontrole, migraties, logging en monitoring, acceptatiecriteria,
     traceerbaarheid en succesvolle CI, voor zover van toepassing. Wat niet van toepassing
     is, wordt met één regel onderbouwd; dat is de controle, niet het vinkje.
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
| **Compliance- of juridische blokkade** | zichtbaar maken als backlogitem, afhankelijkheid of releasevoorwaarde; nooit als stilzwijgend uitstel. Verwijzing naar [`../compliance/compliance-register.md`](../compliance/compliance-register.md) of [`../compliance/regulatory-decisions.md`](../compliance/regulatory-decisions.md) |

**Onderbreken mag, ongemerkt doorschuiven niet.** Urgente productie- of security-incidenten
mogen de sprint onderbreken volgens het incidentproces hierboven. Werk dat aan het einde van
de sprint **niet af is, gaat niet automatisch mee** naar de volgende sprint: het gaat terug
naar de backlog en wordt door de Product Owner opnieuw beoordeeld en geprioriteerd.

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
