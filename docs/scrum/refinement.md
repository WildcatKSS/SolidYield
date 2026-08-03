# Backlog Refinement

**Doel:** items uit de backlog begrijpelijk, klein en Ready maken — vóórdat er een sprint
mee wordt gepland.
**Ritme:** richtlijn `[60–90]` minuten per week (samen ±5% van de sprinttijd).
**Deelnemers:** wie het betreffende werk raakt.

> **Refinement is een doorlopende activiteit, geen formeel Scrum-event.** Er is geen
> verplichte vergadering en geen verplichte aanwezigheid. Wél geldt: de expertise die het
> item raakt — bijvoorbeeld security bij een autorisatie-item of privacy bij nieuwe
> gegevens — is tijdig betrokken. Niet iedere Developer hoeft bij ieder refinementmoment
> te zijn; iedereen die het item straks bouwt, moet het wel begrijpen.
>
> Refinement mag **geen bureaucratische toegangspoort** worden. Ontbreekt er iets, spreek
> dan één concrete actie met een eigenaar af in plaats van het item af te wijzen
> ([antipatroon 15](anti-patterns.md#15-definition-of-ready-als-bureaucratische-toegangspoort)).

Een vast moment in de week voorkomt alleen dat het erbij inschiet.

## Werkwijze per item (10–20 minuten)

1. **De PO leest het probleem voor** — niet de oplossing.
2. **Vragen stellen** tot iedereen het snapt.
3. **Acceptatiecriteria aanscherpen** (Given/When/Then), inclusief fout- en randgevallen.
4. **Risicoscan (3 minuten, verplicht bij financiële functionaliteit):**
   * *Security:* wat kan een kwaadwillende hiermee? Wie mag dit precies zien of doen?
   * *Privacy:* welke gegevens raken we, hebben we ze allemaal nodig, hoe lang bewaren we ze?
   * *Compliance:* raakt dit een control of een mogelijke verplichting?
   * *Geld:* kunnen er onjuiste bedragen ontstaan? Wat is de schade als het misgaat?
5. **Testaanpak bepalen:** welke tests, welk niveau, welke synthetische data?
6. **Risicotype benoemen bij onzekerheid.** Weet je niet of dit werkt, bepaal dan wélk
   risico je eerst wegneemt: *desirability* (willen ze dit?), *usability* (snappen ze het?),
   *feasibility* (kunnen we het bouwen?) of *viability* (is het houdbaar en verantwoord?).
   Dat bepaalt of je een interview, een usabilitytest, een spike of een analyse plant —
   zie [`../research/experiment-template.md`](../research/experiment-template.md).
7. **Splitsen** als het niet binnen één sprint past (zie §3).
8. **Schatten** (zie §2).
9. **Boardvelden invullen:** itemtype, epic, prioriteit, businesswaarde, risico,
   complexiteit, story points, security-/privacy-/compliance-impact, target release.
10. **Status bijwerken:** Ready for sprint, of terug met een concrete actie.

## 2. Schatten

* **Planning poker** met de reeks 1, 2, 3, 5, 8, 13.
* Story points zijn **relatief**: omvang, complexiteit en onzekerheid samen — geen uren.
* Alleen waarde-items (stories, bugs, features) worden geschat; taken niet.
* Bij een verschil van meer dan twee stappen: de hoogste en laagste schatter lichten toe,
  daarna opnieuw schatten.
* Een schatting van 13 betekent: **splitsen**, of eerst een spike.
* Een schatting is een **inschatting van het team**, geen belofte en geen prestatiemaat.

## 3. Splitsen van user stories

| Techniek | Voorbeeld |
|---|---|
| Per stap in de gebruikersreis | eerst registreren, dan MFA instellen, dan herstelcodes |
| Gelukkig pad eerst | eerst de geslaagde koppeling, daarna alle foutscenario's |
| Per regel of variant | eerst één rekeningtype, daarna de rest |
| Per gegevensbron | eerst handmatige invoer, daarna de automatische koppeling |
| Handmatig vóór geautomatiseerd | eerst support voert uit, daarna de gebruiker zelf |
| Per interface | eerst web, daarna mobiel |
| CRUD splitsen | eerst tonen, daarna wijzigen, daarna verwijderen |

Niet splitsen op techniek ("eerst back-end, dan front-end"): dan levert een sprint geen
bruikbaar increment op. Wél mag een **securitymaatregel** een eigen item zijn — maar dan
wel in dezelfde sprint als de story die hem nodig heeft.

## 4. Wat komt er in refinement?

| Bron | Voorbeeld |
|---|---|
| Backlog (Ready for refinement) | de eerstvolgende items in volgorde |
| Testgroepfeedback | items met label `feedback:test-group` na PO-triage |
| Securitybevindingen | scanresultaten, pentestopvolging, threat-modelacties |
| Privacy/compliance | acties uit het complianceregister of een DPIA |
| Technische schuld | items met label `tech-debt`, ingebracht door developers |
| Bugs | na triage door de PO |

## 5. Uitkomst van elke sessie

* Minimaal `[2]` sprints aan Ready-items in de backlog (niet meer: dat is voorraad die
  veroudert).
* Elk besproken item heeft een duidelijke status en, indien niet Ready, een eigenaar en
  een actie.
* Nieuwe risico's zijn als item vastgelegd.
* Nieuwe onduidelijkheden zijn als spike vastgelegd, met timebox.

## 6. Valkuilen

| Valkuil | Aanpak |
|---|---|
| Refinement wordt ontwerpsessie | timebox per item; ontwerp apart plannen met de betrokkenen |
| Alleen de PO praat | laat het team de acceptatiecriteria formuleren |
| Security/privacy schuift door | maak de risicoscan een vast, verplicht onderdeel |
| Te ver vooruit verfijnen | maximaal 2 sprints vooruit |
| Items blijven hangen in "bijna Ready" | benoem één eigenaar en één concrete actie met datum |
