# SRE-principes (licht)

> **Doel:** betrouwbaarheid meetbaar maken vanuit gebruikersperspectief, zonder een zwaar
> SRE-programma op te tuigen.
> **Wanneer gebruiken:** bij het inrichten van monitoring, na een incident, en bij de
> afweging "nieuwe functionaliteit of eerst stabiliseren?".
> **Wie:** Developers met operationsexpertise; Product Owner bij de afweging.
> **Adoptieniveau:** Core (§2 minimaal), Advanced (§3–6), Regulated (§7).
> **Gerelateerd:** [`service-level-objectives.md`](service-level-objectives.md) ·
> [`monitoring.md`](monitoring.md) · [`runbook.md`](runbook.md)

---

## 1. De kern in vijf zinnen

1. **Meet wat de gebruiker merkt**, niet wat de server doet.
2. **100% betrouwbaarheid is geen doel** — het is te duur en het remt alles af.
3. Een **error budget** maakt de afweging tussen tempo en stabiliteit expliciet.
4. **Incidenten zijn systeemfalen**, geen persoonlijk falen.
5. **Terugkerend handwerk (toil) is werk voor de backlog**, geen vast onderdeel van de baan.

## 2. Wat je minimaal doet *(Core)*

Ook een klein team met één omgeving:

- [ ] een **health check** die iets zinnigs controleert (database bereikbaar, niet alleen "proces draait");
- [ ] **gestructureerde logging** met correlatie-ID, zonder persoonsgegevens;
- [ ] zicht op de **foutratio** (5xx) en of die stijgt;
- [ ] één **beschikbaarheidsdoel** in gewone taal, bijvoorbeeld: "de kernreis werkt tijdens
      kantooruren";
- [ ] **incidentnotities**: wat gebeurde er, wat deden we, wat leren we — een halve pagina volstaat.

Dat is genoeg om te merken dát er iets stuk is en om ervan te leren. De rest komt later.

## 3. SLI's en SLO's *(Advanced)*

Een **SLI** is een meting van gebruikerservaring; een **SLO** is het doel daarvoor.

| Begrip | Voorbeeld |
|---|---|
| SLI | percentage geslaagde verzoeken op de kernreis |
| SLO | ≥ 99,5% over 30 dagen |
| Error budget | de resterende 0,5% ≈ 3,6 uur per 30 dagen |

Kies SLI's die de gebruiker zou herkennen: *kan ik inloggen, klopt mijn overzicht, is het
actueel?* Niet: CPU-gebruik. Concrete waarden:
[`service-level-objectives.md`](service-level-objectives.md).

**Regel:** één SLO waar niemand naar kijkt is erger dan geen SLO. Begin met twee.

## 4. Error budget als gespreksinstrument *(Advanced)*

| Verbruik | Wat dat betekent |
|---|---|
| < 50% | ruimte om te bouwen en uit te rollen |
| 50–80% | extra voorzichtig bij risicovolle wijzigingen |
| 80–100% | prioriteit naar stabiliteit; nieuwe functionaliteit pauzeert |
| > 100% | stabiliteit is het sprintdoel; post-mortem verplicht |

Dit is een **teamafspraak**, geen straf: het maakt de afweging tussen tempo en
betrouwbaarheid expliciet in plaats van impliciet.

> **Uitzondering:** correctheid van financiële berekeningen kent geen budget. Een verkeerd
> bedrag tonen is geen "acceptabel percentage" maar een incident.

## 5. Incidentclassificatie *(Advanced)*

Één schaal, overal dezelfde — ook in [`../security/incident-response.md`](../security/incident-response.md):

| Niveau | Betekenis voor de gebruiker | Reactie |
|---|---|---|
| **P1** | kan niet bij zijn geld of gegevens; verkeerde bedragen; datalekverdenking | direct, 24/7 |
| **P2** | kernfunctie onbruikbaar, geen workaround | ≤ 1 uur (kantoortijd) |
| **P3** | hinder met workaround | ≤ 1 werkdag |
| **P4** | cosmetisch of trend | backlog |

Classificeer op **impact voor de gebruiker**, niet op technische ernst.

## 6. Blameless post-mortems *(Advanced)*

Na elke P1 en P2, binnen vijf werkdagen. Vaste opbouw: tijdlijn · impact · grondoorzaak ·
waarom we het niet eerder zagen · wat goed ging · verbeteracties met eigenaar
([`../security/incident-response.md`](../security/incident-response.md) §6).

**Blameless betekent niet vrijblijvend.** Het betekent: zoek naar het systeem dat de fout
mogelijk maakte, niet naar de persoon die hem maakte. Iemand die een incident veroorzaakte,
weet doorgaans het meeste over de oorzaak — die wil je aan tafel, niet in de verdediging.

## 7. Operationele gereedheid en toil *(Advanced → Regulated)*

**Operationele gereedheid** — vóórdat iets naar productie gaat:
monitoring en alerting ingericht · runbook bijgewerkt · rollback getest · back-up en
herstel aantoonbaar · capaciteit voldoende · iemand kijkt na de uitrol daadwerkelijk mee.
Volledige lijst: [`platform-readiness-checklist.md`](platform-readiness-checklist.md).

**Verifiëren ín productie mag — begrensd.** Sommige eigenschappen kun je alleen in
productie vaststellen. De grens ligt bij impact op echte gebruikers en echte gegevens:
vooraf ontworpen, begrensde en veilige checks (healthchecks, synthetische monitoring,
canaryverificatie, gecontroleerde post-deploymentchecks) zijn onderdeel van goed
operationeel werk. Ongecontroleerde functionele tests, wijzigingen aan echte klantdata,
echte transacties en destructieve of onbegrensde experimenten zijn dat niet. Zie
[`../testing/test-strategy.md`](../testing/test-strategy.md) §4a en
[`monitoring.md`](monitoring.md) §7a.

**Toil verminderen:** handmatig, repetitief, automatiseerbaar werk dat meegroeit met het
gebruik. Houd bij hoeveel tijd eraan opgaat; boven `[20]%` van de teamtijd wordt
automatiseren prioriteit. Toil is backlogwerk met een eigenaar, geen achtergrondruis.

**Aanvullend op Regulated/Enterprise:** error-budgetbeleid vastgelegd en bestuurlijk
gedragen · formele incidentclassificatie met meldroutes · auditbewijs van incidenten,
hersteltests en oefeningen · periodieke resilience-tests · monitoring van leveranciers en
ketenafhankelijkheden.

## 8. Wat we bewust níét doen

* Geen alert waar geen actie bij hoort — alarmmoeheid is zelf een risico.
* Geen dashboard dat niemand bekijkt.
* Geen SLO die is gekozen omdat hij makkelijk haalbaar is.
* Geen apart SRE-team dat "de betrouwbaarheid doet"; het hoort bij de Developers.
* Geen resilience-experiment in productie zonder begrensde impact, rollback en vooraf
  afgesproken afbreekcriteria.
