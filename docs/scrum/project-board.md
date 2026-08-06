# GitHub Projects-board

Voorstel voor het Scrum-board. GitHub Issues zijn de backlogitems; GitHub Projects is de
werkvloer. Alles wat we maken heeft een issue — dat is tegelijk onze traceerbaarheid.

## 1. Board aanmaken

1. Ga naar de organisatie of repository → **Projects** → **New project** → **Board**.
2. Naam: `SolidYield — Product Backlog`.
3. Koppel de repository (*Settings → Manage access / linked repositories*).
4. Maak de statussen aan (§2) en de velden (§3).
5. Zet workflows aan (§5).
6. Maak de weergaven aan (§4).

## 2. Statussen (kolommen)

| # | Status | Betekenis | Wanneer eruit? | Eigenaar |
|---|---|---|---|---|
| 1 | **Inbox** | alles wat binnenkomt: ideeën, meldingen, feedback | PO heeft het bekeken en gesorteerd | PO |
| 2 | **Discovery** | probleem nog onduidelijk; onderzoek of spike loopt | de vraag is beantwoord | UX / Dev |
| 3 | **Ready for refinement** | duidelijk genoeg om te bespreken met het team | het item is verfijnd en geschat | PO |
| 4 | **Ready for sprint** | voldoet aan de [Definition of Ready](definition-of-ready.md) | opgenomen in een sprint | team |
| 5 | **Sprint backlog** | zit in de huidige sprint, nog niet gestart | iemand begint eraan | team |
| 6 | **In progress** | actief in uitvoering (WIP-limiet!) | pull request staat open | developer |
| 7 | **In review** | code review en geautomatiseerde controles lopen | goedgekeurd en gemerged | reviewers |
| 8 | **Ready for testing** | gemerged, staat op de testomgeving | functioneel getest en akkoord | team |
| 9 | **Test group validation** | wordt voorgelegd aan de testgroep | feedback vastgelegd en beoordeeld | UX |
| 10 | **Blocked** | kan niet verder; blokkade en eigenaar staan in het issue | blokkade opgeheven | Scrum Master |
| 11 | **Done** | voldoet aantoonbaar aan de [Definition of Done](definition-of-done.md) | — | Developers |
| 12 | **Cancelled / Rejected / Duplicate / Won't do** | het item wordt niet (verder) gemaakt; zie §2b | — | PO |

### Regels

* **WIP-limieten:** *In progress* max. `[2 × aantal developers]`, *In review* max. `[4]`,
  *Blocked* is geen parkeerplaats — elk item daar heeft een eigenaar en een datum.
* **Blocked** is een status, geen kolom om in te wonen: bespreek elk item dagelijks.
* Niet elk item doorloopt *Discovery* of *Test group validation*; die stappen zijn
  verplicht voor alles wat de gebruiker merkt.
* Een item gaat naar **Done** wanneer **aantoonbaar** aan de Definition of Done is
  voldaan — niet wanneer iemand dat vindt. De Developers stellen dat vast; zie
  [`definition-of-done.md`](definition-of-done.md). De Product Owner inspecteert het
  resultaat en past waar nodig de Product Backlog aan, maar geeft geen aparte
  persoonlijke goedkeuring als kwaliteitspoort.
* Ontbreekt er een verplicht DoD-criterium, dan is het item **niet Done**. Het resterende
  werk blijft in het item of gaat terug naar de Product Backlog.

## 2b. Eindstatussen die géén voltooid werk zijn

Werk dat stopt zonder opgeleverd increment krijgt een eigen eindstatus, zodat het niet
als voltooid productwerk wordt geteld:

| Status | Wanneer | Telt mee als voltooid werk? |
|---|---|---|
| **Done** | increment voldoet aantoonbaar aan de DoD | ✅ ja |
| **Cancelled** | het werk is gestopt; de behoefte bestaat nog wel | ❌ nee |
| **Rejected** | het item valt buiten de productvisie of scope | ❌ nee |
| **Duplicate** | al gedekt door een ander item (verwijs ernaar) | ❌ nee |
| **Won't do** | bewust besluit dit niet te maken, met onderbouwing | ❌ nee |

Richt dit in als extra waarden van het statusveld of als apart veld *Eindreden*. Meet
doorlooptijd en voltooid werk **alleen** over items met status Done; anders lijkt een
opgeruimde backlog op productiviteit.

## 3. Velden

Aan te maken onder *Project → Settings → Fields*.

| Veld | Type | Waarden | Verplicht vanaf |
|---|---|---|---|
| **Itemtype** | Single select | Epic · Feature · User story · Bug · Technische taak · Testtaak · Securitytaak · Compliance-/privacytaak · Research | Inbox |
| **Epic** | Text (of Issue-link) | verwijzing naar het epic-issue, bijv. `#12` | Ready for refinement |
| **Sprint** | Iteration | duur **2 weken** (veertien kalenderdagen, besluit 6 — [`scrum-guide.md`](scrum-guide.md) §2); vaste start- en einddag, eerste sprintstart `[JJJJ-MM-DD]` | Sprint backlog |
| **Prioriteit** | Single select | Critical · High · Medium · Low | Inbox |
| **Businesswaarde** | Number (1–10) | inschatting door de PO | Ready for refinement |
| **Risico** | Single select | High · Medium · Low | Ready for refinement |
| **Complexiteit** | Single select | Simple · Complicated · Complex · Chaotic | Ready for refinement |
| **Story points** | Number | 1 · 2 · 3 · 5 · 8 · 13 (alleen waarde-items) | Ready for sprint |
| **Verantwoordelijke** | Assignees | één naam; "iedereen" betekent niemand | In progress |
| **Security-impact** | Single select | Geen · Laag · Middel · Hoog · Te beoordelen | Ready for sprint |
| **Privacy-impact** | Single select | Geen · Bestaande verwerking · Nieuwe verwerking · DPIA nodig · Te beoordelen | Ready for sprint |
| **Compliance-impact** | Single select | Geen · Raakt control · Mogelijk nieuwe verplichting · Te beoordelen | Ready for sprint |
| **Testgroepstatus** | Single select | N.v.t. · Gepland · In sessie · Feedback ontvangen · Verwerkt | Ready for testing |
| **Target release** | Single select | Intern prototype · Testgroepversie · Bèta · Beperkte productie · Algemeen beschikbaar · n.t.b. | Ready for sprint |

### Aanbevolen extra velden

| Veld | Type | Waarom |
|---|---|---|
| Definition of Ready | Single select (Ja/Nee) | maakt filteren op sprintgereedheid makkelijk |
| Blokkade sinds | Date | maakt zichtbaar hoelang iets stilstaat |
| Bewijssterkte | Single select (Sterk/Middel/Zwak) | voorkomt bouwen op één losse mening |
| Toegankelijkheid | Single select (N.v.t./Te doen/Gecontroleerd) | houdt WCAG zichtbaar |

## 4. Weergaven (views)

| Weergave | Type | Filter | Waarvoor |
|---|---|---|---|
| **Sprintboard** | Board op Status | `sprint:@current` | dagelijks werk |
| **Productbacklog** | Table, gesorteerd op Prioriteit en Businesswaarde | `status:Inbox,Discovery,Ready for refinement,Ready for sprint` | refinement en planning |
| **Refinement** | Table | `status:"Ready for refinement"` | voorbereiding refinement |
| **Risico & security** | Table | `security-impact:Hoog OR risico:High OR label:type:security` | wekelijkse securitycheck |
| **Privacy & compliance** | Table | `privacy-impact != Geen OR label:type:compliance` | maandelijkse controle |
| **Testgroep** | Board op Testgroepstatus | `label:feedback:test-group OR testgroepstatus != N.v.t.` | validatiecyclus |
| **Geblokkeerd** | Table | `status:Blocked` | daily |
| **Epics** | Roadmap (Iteration) | `itemtype:Epic` | voortgang op lange lijn |
| **Release** | Table gegroepeerd op Target release | alle | releaseplanning |

## 5. Automatisering

Ingebouwde workflows (*Project → Settings → Workflows*):

| Trigger | Actie |
|---|---|
| Issue geopend | zet Status op **Inbox** |
| Pull request geopend en gekoppeld | zet Status op **In review** |
| Pull request gemerged | zet Status op **Ready for testing** — **nooit** op Done |
| Item toegevoegd aan het project | zet Sprint leeg en Prioriteit op *Medium* |
| Auto-add | voeg elk nieuw issue in de repository automatisch toe |

> ⚠️ **Zet de standaardautomatisering "Issue gesloten → Done" uit.** GitHub sluit een
> gekoppeld issue automatisch bij het mergen van een pull request met `Closes #123`.
> Met die automatisering erbij springt het item naar **Done** op het moment van de merge —
> vóór verificatie op de testomgeving, vóór testgroepvalidatie en vóór de rest van de
> Definition of Done. Dan meet je merges, geen afgerond werk.
>
> **Done wordt handmatig gezet** door de Developers, nadat aantoonbaar aan de DoD is
> voldaan. Wil je dat automatiseren, doe dat dan op basis van bewijs (bijvoorbeeld een
> workflow die pas Done zet als alle DoD-checkboxes zijn afgevinkt én de deploy naar de
> testomgeving is geslaagd) — niet op basis van "de PR is gemerged".

### Gebruik van sluitwoorden in pull requests

* Gebruik **niet** standaard `Closes #123` / `Fixes #123` voor werk dat na de merge nog
  verificatie of validatie nodig heeft: dat sluit het issue te vroeg.
* Gebruik `Relates to #123` of `Part of #123` zolang de DoD nog niet volledig is behaald.
* Sluit het issue pas ná validatie — handmatig, of met `Closes #123` in de PR wanneer de
  merge het werk aantoonbaar volledig afrondt (bijvoorbeeld een documentatiewijziging).
* Sluit je een item om een andere reden, gebruik dan de bijbehorende eindstatus uit §2b
  en zet `state_reason` op *not planned*.

Aanvullend (optioneel, via een workflow met `actions/add-to-project`): items met het label
`type:security` of `risk:high` automatisch in de weergave *Risico & security* laten
verschijnen door het veld **Risico** op *High* te zetten.

## 6. Van feedback naar backlogitem

```
Testgroepsessie
 → issue via test-group-feedback.yml (status: Inbox, label feedback:test-group)
 → PO toetst aan visie, frequentie, impact, risico, haalbaarheid, waarde, bewijssterkte
 → Discovery (meer onderzoek nodig) of Ready for refinement of gesloten met uitleg
 → user story met acceptatiecriteria
 → Ready for sprint
```

Elke gesloten feedback krijgt een korte motivatie in het issue **en** een terugkoppeling
aan de deelnemer. Zie [`../research/feedback-log.md`](../research/feedback-log.md).

> **Eén board, één backlog.** Architectuur-, security-, privacy-, compliance-, operations-
> en documentatiewerk staat op ditzelfde board en in dezelfde geprioriteerde backlog als
> functionele ontwikkeling — niet in een parallel traject ernaast (besluit 6,
> [`scrum-guide.md`](scrum-guide.md) §2.1). Het veld *Itemtype* maakt het onderscheid
> zichtbaar zonder het werk te scheiden.

## 7. Definition of Ready op het board

Een item mag pas naar **Ready for sprint** als:

* het itemtype, de prioriteit, de businesswaarde, het risico en de complexiteit gevuld zijn;
* security-, privacy- en compliance-impact zijn ingevuld (mag "Geen", niet leeg);
* story points zijn toegekend (voor waarde-items);
* de acceptatiecriteria in het issue staan;
* er geen open blokkade is.

Volledige lijst: [`definition-of-ready.md`](definition-of-ready.md).

## 8. Definition of Done op het board

Een item mag pas naar **Done** als de universele DoD-criteria zijn afgevinkt én de
conditionele criteria die op dit item van toepassing zijn — met onderbouwing bij elk
"niet van toepassing". Zie [`definition-of-done.md`](definition-of-done.md).

Het veld *Testgroepstatus* staat op *Verwerkt* of *N.v.t.* (met reden) voordat een
gebruikersgericht item Done wordt.
