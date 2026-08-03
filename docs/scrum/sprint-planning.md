# Sprint Planning

**Doel:** het **hele Scrum Team** bepaalt samen waarom deze sprint waardevol is, wat erin
kan, en hoe dat wordt gedaan.
**Duur:** maximaal 4 uur bij een sprint van 2 weken (2 uur bij 1 week).
**Deelnemers:** het Scrum Team; specialisten sluiten aan wanneer hun input nodig is.

| Wie | Brengt in |
|---|---|
| Product Owner | productdoel, context, backlogvolgorde en de waarde die op het spel staat |
| Developers | wat haalbaar is, hoe het wordt gebouwd, en welke risico's er zijn |
| Scrum Master | ondersteunt de effectieve toepassing van Scrum en bewaakt de timebox |

Het **Sprint Goal ontstaat gezamenlijk** — het is geen opdracht die wordt uitgedeeld.

## Voorbereiding (vóór het event)

* PO: backlog is geordend; de bovenste items zijn Ready ([DoR](definition-of-ready.md)).
* Scrum Master: capaciteit bekend (verlof, feestdagen, ondersteuningstaken).
* Team: vorige sprint is afgerond; niets sleept ongemerkt mee.
* UX: bevindingen uit de laatste testgroepsessie zijn verwerkt in de backlog.
* Security: openstaande kritieke/hoge kwetsbaarheden staan als items in de backlog.

## Agenda

### Onderwerp 1 — Waarom is deze sprint waardevol? (30 min)

De Product Owner brengt in hoe deze sprint kan bijdragen aan het productdoel en welke
context daarbij hoort. Het hele Scrum Team formuleert vervolgens samen één **Sprint Goal**
in één zin.

> Voorbeeld: *"Aan het einde van deze sprint kan een testgebruiker veilig een account
> aanmaken en inloggen met MFA, en is dat door drie deelnemers uit de testgroep getest."*

Een goed sprintdoel: beschrijft een resultaat (geen lijst tickets), is haalbaar,
is te demonstreren, en geeft ruimte om onderweg keuzes te maken.

### Onderwerp 2 — Wat kan er af? (90 min)

1. Bepaal de capaciteit: `beschikbare dagen × focusfactor` (start met `[70]%`), minus de
   vaste reservering van `[10]%` voor ongepland werk en `[10]%` voor kwaliteit/technische
   schuld.
2. De Developers selecteren items uit de door de PO geordende backlog. Zij bepalen wat
   haalbaar is; de PO licht waarde en volgorde toe en beantwoordt vragen.
3. Controleer per item de DoR — nog steeds voldaan?
4. Controleer de **balans** van de sprint:
   * bevat de sprint de bijbehorende security-, privacy- en testtaken?
   * zit er iets in dat we met de testgroep kunnen valideren?
   * is er ruimte voor het oplossen van gemelde kwetsbaarheden?
5. Stel vast: past dit bij het sprintdoel? Zo niet: eruit.

### Onderwerp 3 — Hoe gaan we het doen? (60 min)

De Developers maken het plan; de rest van het Scrum Team denkt mee waar dat helpt.

* Splits items in taken (technisch, test, security, privacy) waar dat helpt.
* Benoem risico's en onbekenden; plan een spike als de onzekerheid te groot is.
* Spreek af wie waaraan begint en waar we samen aan werken (pairing bij risicovol werk).
* Plan de testgroepsessie van deze sprint in — datum, deelnemers, wat we willen leren.
* Controleer de afhankelijkheden: wat hebben we van buiten nodig, en wanneer?

### Afsluiting (15 min)

* Sprintdoel voorlezen; iedereen bevestigt vertrouwen (bijv. duimen 1–5; bij veel lage
  scores: scope aanpassen).
* Sprint aanmaken op het board: veld **Sprint** invullen, items naar *Sprint backlog*.
* Vastleggen: sprintdoel, geselecteerde items, capaciteit, geplande testgroepsessie.

## Checklist voor de Scrum Master

- [ ] Sprintdoel in één zin, opgeschreven en zichtbaar
- [ ] Alle geselecteerde items voldoen aan de DoR
- [ ] Security-, privacy- en compliance-impactvelden zijn ingevuld
- [ ] Openstaande kritieke/hoge kwetsbaarheden zijn belegd
- [ ] Er zit valideerbaar werk voor de testgroep in de sprint
- [ ] Capaciteit realistisch, met buffer voor ongepland werk
- [ ] Afhankelijkheden en blokkades benoemd, met eigenaar
- [ ] Board bijgewerkt (veld Sprint, status *Sprint backlog*)

## Veelvoorkomende valkuilen

| Valkuil | Gevolg | Aanpak |
|---|---|---|
| Sprint volplannen tot 100% | alles blijft half af | plan op `[70]%`; hou buffer |
| Sprintdoel als opsomming van tickets | geen focus, geen keuzeruimte | herformuleer naar één resultaat |
| Security- en privacytaken "later" | opeenstapelend risico, herwerk | neem ze op in dezelfde sprint als de story |
| Items zonder testaanpak | einde sprint pas testen, herwerk | DoR handhaven |
| Testgroep vergeten | geen validatie, bouwen op aannames | plan de sessie in de planning zelf |
