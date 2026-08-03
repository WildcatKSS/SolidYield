# Definition of Done

De Definition of Done (DoD) beschrijft wanneer werk **echt af** is. Het is de
kwaliteitsondergrens van het increment en een gedeelde afspraak van het hele Scrum Team.
Bij een financiële dienst is die ondergrens niet onderhandelbaar: bij tijdgebrek gaat er
scope uit, nooit kwaliteit.

> **De DoD kent geen uitzonderingsprocedure.** Ontbreekt een verplicht criterium, dan is
> het item **niet Done** — ongeacht de deadline en ongeacht of iemand het restrisico wil
> accepteren. Zie [§4](#4-wat-als-een-criterium-niet-haalbaar-is).

De DoD is in twee lagen opgebouwd:

* **A. Universele criteria** — gelden voor elk backlogitem dat Done wordt.
* **B. Conditionele criteria** — gelden wanneer het item het betreffende gebied raakt.

Zo blijft de lijst kloppend voor een documentatiewijziging én voor een betaalfunctie,
zonder tientallen verplichte "n.v.t."-vinkjes.

---

## A. Universele criteria

Deze gelden **altijd**:

| # | Criterium | Bewijs |
|---|---|---|
| U1 | De acceptatiecriteria uit het item zijn aantoonbaar behaald | afgevinkt in issue en pull request, met verwijzing naar test of demonstratie |
| U2 | Review is uitgevoerd door iemand anders dan de maker | goedgekeurde review (2 reviews bij gevoelige paden, zie C10) |
| U3 | De verplichte CI-controles zijn geslaagd | groene run op de pull request |
| U4 | Er staan geen blokkerende bevindingen open | security-gate groen; geen openstaande kritieke of hoge kwetsbaarheid |
| U5 | Er zijn geen secrets, echte persoonsgegevens of productiedata toegevoegd | secret scan groen + review |
| U6 | Documentatie is bijgewerkt waar de wijziging dat vraagt | gewijzigde bestanden, of expliciet "niet nodig, omdat …" |
| U7 | Het werk is traceerbaar: issue ↔ pull request ↔ commit | koppeling aanwezig |
| U8 | Het increment is samengevoegd in de hoofdbranch en breekt niets | groene CI op `main` |

---

## B. Conditionele criteria

Van toepassing wanneer het item het genoemde gebied raakt. Is een criterium niet van
toepassing, noteer dan in één regel **waarom** — die onderbouwing is de controle, niet het
vinkje.

| # | Van toepassing wanneer het item raakt… | Criterium |
|---|---|---|
| C1 | applicatiecode | passende unit-, integratie- of end-to-endtests toegevoegd of bijgewerkt; dekking blijft boven `COVERAGE_MIN` — welk niveau waarvoor: [`../testing/test-strategy.md`](../testing/test-strategy.md) |
| C2 | een gebruikersinterface | toegankelijkheid gecontroleerd (geautomatiseerd + handmatige toetsenbordcontrole), WCAG 2.2 AA op de kernreis; teksten begrijpelijk (streven B1) |
| C3 | authenticatie of autorisatie | negatieve tests: een onbevoegde gebruiker kan het níét (`tests/security/`, S-1 t/m S-3) |
| C4 | geldstromen, bedragen of limieten | tests op afronding, valuta, negatieve bedragen, randgevallen en idempotentie; limieten serverseitig afgedwongen |
| C5 | het datamodel of een migratie | migratie getest op representatieve omvang, terugdraaibaar of vooruit-herstelbaar, rollbackplan in de PR |
| C6 | persoonsgegevens | doel, grondslag, minimalisatie en bewaartermijn geregeld; DPIA-toets uitgevoerd of aantoonbaar niet nodig |
| C7 | een control uit de compliance-mapping | control bijgewerkt en bewijs vastgelegd in [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md) |
| C8 | gebruikersgedrag of een gebruikersaanname | validatie met de testgroep uitgevoerd of expliciet ingepland, en de uitkomst vastgelegd in [`../research/feedback-log.md`](../research/feedback-log.md) |
| C9 | het gedrag in productie (operationeel) | logging, metrics of alerts toegevoegd; runbook bijgewerkt waar nodig |
| C10 | een securitygevoelig pad (`CODEOWNERS`) | review door de betreffende code owners |
| C11 | het increment in een omgeving | werkend geverifieerd in een representatieve testomgeving met synthetische data |
| C12 | release-impact (zichtbaar voor gebruikers of API-wijziging) | regel toegevoegd onder `Unreleased` in [`../../CHANGELOG.md`](../../CHANGELOG.md) |

### Profielen per itemtype

Startpunt; het team past ze aan in de retrospective.

| Itemtype | Universeel | Conditioneel meestal van toepassing |
|---|---|---|
| Productfeature / user story | U1–U8 | C1, C2, C8, C11, C12 (+ C3–C7 naar gelang het onderwerp) |
| Bugfix | U1–U8 | C1 (regressietest verplicht), C11, C12 bij zichtbare impact |
| Technische taak | U1–U8 | C1, C9, C11 |
| Infrastructuurwijziging | U1–U8 | C5, C9, C10, C11 |
| Documentatiewijziging | U1–U8 | meestal geen |
| Onderzoeksitem / spike | U1, U2, U6, U7 (U3–U5 en U8 alleen als er code is) | resultaat vastgelegd; vervolgacties als backlogitems |
| Compliance- of privacytaak | U1–U8 | C6, C7 |
| Securitytaak | U1–U8 | C3, C7, C10 + een test die de maatregel bewaakt |

---

## 2. Wie stelt vast dat iets Done is?

| Rol | Verantwoordelijkheid |
|---|---|
| **Developers** | maken een increment dat aan de DoD voldoet en stellen vast dát het eraan voldoet |
| **Product Owner** | maakt de acceptatiecriteria vooraf duidelijk, inspecteert het resultaat, past de Product Backlog aan, en beslist of en wanneer een Done increment wordt vrijgegeven |
| **Scrum Master** | bewaakt dat de DoD daadwerkelijk wordt toegepast en niet stilzwijgend wordt opgerekt |

**Done is een objectieve vaststelling, geen persoonlijke goedkeuring.** De Product Owner
kan een technisch onvolledig increment niet Done verklaren, en hoeft geen aparte
handtekening te zetten wanneer aantoonbaar aan de DoD is voldaan. Blijkt bij inspectie dat
het resultaat niet de gewenste waarde levert, dan is dat **nieuw backlogwerk** — geen
reden om de DoD-status te wijzigen.

De beslissing om een Done increment daadwerkelijk uit te brengen is een
**releasebeslissing** en ligt bij de bevoegde product- en governancerollen
([`../releases/release-process.md`](../releases/release-process.md),
[`../../GOVERNANCE.md`](../../GOVERNANCE.md)).

---

## 3. Wat "Done" **niet** is

* Niet: "werkt op mijn machine".
* Niet: "tests komen in een volgende sprint".
* Niet: "security kijkt er later naar".
* Niet: "de pull request is gemerged" — merge is een tussenstap, geen eindstatus.
* Niet: "de Product Owner vindt het goed genoeg" terwijl een criterium ontbreekt.
* Niet: "we hebben het risico geaccepteerd, dus het telt als gedaan".
* Ook code achter een uitgeschakelde feature flag moet aan de DoD voldoen.

---

## 4. Wat als een criterium niet haalbaar is?

Er is **geen uitzonderingsprocedure** waarmee een item alsnog Done wordt. Wel drie
legitieme routes:

1. **Splitsen.** Lever het deel dat wél volledig af is als Done increment; het resterende
   werk wordt een eigen backlogitem met eigen acceptatiecriteria.
2. **Terug naar de Product Backlog.** Het item blijft niet-Done en de Product Owner
   herprioriteert het.
3. **De DoD prospectief aanpassen.** Blijkt een criterium structureel onwerkbaar, dan past
   het team de DoD aan **voor toekomstig werk**, met onderbouwing in de retrospective. De
   DoD wordt **nooit met terugwerkende kracht verlaagd** om lopend werk af te ronden.

### Risicoacceptatie is iets anders

Risicoacceptatie is een **governanceproces**
([`../../GOVERNANCE.md`](../../GOVERNANCE.md)), geen DoD-uitzondering. Het gaat over een
bewust geaccepteerd **restrisico van uitgevoerd werk** — bijvoorbeeld een bekende
middelzware kwetsbaarheid in een afhankelijkheid waarvoor nog geen patch bestaat, of een
functionele beperking die je bewust in productie neemt.

Risicoacceptatie kan **nooit** betekenen dat:

* niet-uitgevoerde tests als uitgevoerd gelden;
* ontbrekende deploymentvalidatie als geslaagd geldt;
* ontbrekend kwaliteits-, privacy- of compliancebewijs als aanwezig geldt.

Een risicoacceptatie bevat minimaal: beschrijving · impact · waarschijnlijkheid ·
compenserende maatregelen · eigenaar · bevoegde goedkeurder · vervaldatum · opvolgissue.
Kritieke en hoge securityrisico's kunnen **niet** door de Developers zelf worden
geaccepteerd. Registratie:
[`../compliance/audit-evidence.md`](../compliance/audit-evidence.md) §3.

---

## 5. Groeipad

De DoD groeit mee met het team. Wat nu nog niet haalbaar is, staat hier met een datum —
en geldt tot die tijd expliciet níét als verplicht criterium, in plaats van als
stilzwijgend overgeslagen criterium:

| Criterium | Status | Doel |
|---|---|---|
| Dekkingsdrempel 70% (C1) | actief | verhogen naar 80% per `[JJJJ-MM-DD]` |
| End-to-endtests op de kernreis (C1) | groeit | volledig per `[JJJJ-MM-DD]` |
| Handmatige schermlezercontrole (C2) | steekproef | elke UI-story per `[JJJJ-MM-DD]` |
| Externe pentest | gepland | vóór productie-uitrol |

Wijzigingen aan de DoD lopen via een pull request met review door het Scrum Team.
