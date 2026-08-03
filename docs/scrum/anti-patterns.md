# Scrum-antipatronen

> **Doel:** herkennen wanneer de vorm van Scrum overblijft maar de werking verdwijnt.
> **Wanneer gebruiken:** bij onboarding, en als agenda voor een retrospective wanneer het
> team het gevoel heeft "Scrum te doen" zonder er iets aan te hebben.
> **Wie:** Scrum Master in het bijzonder; iedereen mag ze benoemen.
> **Adoptieniveau:** Core.
> **Gerelateerd:** [`scrum-guide.md`](scrum-guide.md) · [`retrospective.md`](retrospective.md)

Elk patroon: **symptoom** (wat je ziet) · **waarom schadelijk** · **correctie**.

---

## 1. Daily Scrum als statusrapportage

**Symptoom:** iedereen praat om de beurt tegen de Scrum Master of de PO; "gisteren,
vandaag, blokkades" wordt afgedraaid; niemand reageert op elkaar.
**Waarom schadelijk:** de daily is bedoeld om het plan naar het Sprint Goal bij te sturen.
Als rapportage levert het niets op en voelt het als controle.
**Correctie:** loop het bord van rechts naar links langs, praat over het werk in plaats van
over personen, en vraag steeds: *brengt dit ons dichter bij het Sprint Goal?* De Scrum
Master hoeft er niet bij te zijn.

## 2. Scrum Master als projectmanager

**Symptoom:** de Scrum Master verdeelt taken, bewaakt deadlines, rapporteert voortgang naar
boven en beslist wat er in de sprint komt.
**Waarom schadelijk:** de Developers verliezen eigenaarschap over hoe ze werken, en de
Scrum Master komt in een dubbelrol die verbeteren onmogelijk maakt.
**Correctie:** de Scrum Master faciliteert, coacht en verwijdert belemmeringen. Werk wordt
door de Developers zelf gepakt. Voortgang leest de organisatie op het board.

## 3. Product Owner als enige schrijver van stories

**Symptoom:** de PO levert kant-en-klare stories aan; het team hoort ze voor het eerst in
de planning.
**Waarom schadelijk:** je verliest de kennis van de mensen die het bouwen, de
acceptatiecriteria missen technische randgevallen, en refinement wordt een voorleessessie.
**Correctie:** de PO brengt het probleem en de waarde in; het team formuleert samen de
acceptatiecriteria. Wie het bouwt, denkt mee over wat het moet doen.

## 4. Sprint zonder Sprint Goal

**Symptoom:** de sprint is een lijst losse tickets; op de vraag "waar werken we deze sprint
naartoe?" volgt een opsomming.
**Waarom schadelijk:** zonder doel is er niets om op bij te sturen. Als er iets tegenzit,
kan het team niet kiezen wat wél moet — alles lijkt even belangrijk.
**Correctie:** één zin, één resultaat, demonstreerbaar. Alles wat niet aan het doel
bijdraagt, is kandidaat om te laten vallen als het krap wordt.

## 5. Story points als individuele KPI

**Symptoom:** punten per persoon worden bijgehouden of besproken in
functioneringsgesprekken.
**Waarom schadelijk:** schattingen worden opgeblazen, samenwerking wordt afgestraft en de
cijfers verliezen elke voorspellende waarde.
**Correctie:** punten zijn een hulpmiddel van het team voor het team. Meet stroom
(doorlooptijd), niet output per persoon.

## 6. Velocity vergelijken tussen teams

**Symptoom:** "team A doet 40 punten, team B maar 25."
**Waarom schadelijk:** punten zijn per definitie relatief aan één team. Vergelijken
beloont inflatie en zegt niets over waarde.
**Correctie:** vergelijk teams op uitkomsten (gehaalde doelen, ontsnapte defecten,
gebruikerswaarde), niet op punten.

## 7. Onbeperkt werk toevoegen tijdens de sprint

**Symptoom:** de sprintinhoud groeit dagelijks; het Sprint Goal komt structureel niet uit.
**Waarom schadelijk:** het team kan niets meer afmaken, kwaliteit wordt het eerste
slachtoffer, en plannen wordt zinloos.
**Correctie:** nieuw werk komt er alleen in als het Sprint Goal niet in gevaar komt en de
PO akkoord is; er gaat dan meestal iets anders uit. Reserveer een vaste buffer voor
ongepland werk in plaats van te doen alsof dat niet bestaat.

## 8. Sprint Review als alleen een demo

**Symptoom:** het team laat iets zien, iedereen knikt, de vergadering eindigt.
**Waarom schadelijk:** de review is bedoeld om de **backlog aan te passen** op basis van
wat je leert. Zonder gesprek en zonder besluiten is het een presentatie.
**Correctie:** laat gebruikers of stakeholders het zelf proberen, stel concrete vragen,
noteer feedback, en pas de backlog nog in dezelfde sessie aan.

## 9. Retrospective overslaan

**Symptoom:** "we hebben het te druk", of de retro wordt als eerste geschrapt bij tijdnood.
**Waarom schadelijk:** het enige moment waarop het team het systeem verbetert verdwijnt —
precies wanneer die druk laat zien dat er iets te verbeteren valt.
**Correctie:** houd de retro kort maar houd hem. Maximaal twee acties, met eigenaar, en
evalueer de vorige acties aan het begin.

## 10. Onvolledig werk toch Done noemen

**Symptoom:** "Done op de tests na", "Done, security kijkt er volgende sprint naar."
**Waarom schadelijk:** je bouwt onzichtbare schuld op; de voortgang die het board toont is
niet echt. Bij een financiële dienst betekent het bovendien onbeheerst risico.
**Correctie:** ontbreekt een verplicht criterium, dan is het niet Done — splitsen of terug
naar de backlog ([`definition-of-done.md`](definition-of-done.md) §4). De DoD kent geen
uitzonderingsprocedure.

## 11. Technische schuld structureel doorschuiven

**Symptoom:** refactorwerk staat al maanden onderaan de backlog; "eerst deze feature nog".
**Waarom schadelijk:** het tempo daalt sluipend, en op enig moment is elke wijziging
riskant geworden.
**Correctie:** reserveer een vast percentage capaciteit per sprint (richtlijn `[10]%`) en
maak schuld zichtbaar als backlogitem met label `tech-debt`, inclusief het risico dat het
oplevert.

## 12. Aparte security- of testfase na de sprint

**Symptoom:** een "hardening sprint", of security die pas vóór de release meekijkt.
**Waarom schadelijk:** bevindingen komen te laat en zijn dan duur; het team leert niets van
de fouten; de DoD wordt uitgehold.
**Correctie:** security- en testwerk hoort in dezelfde sprint als de story die het nodig
heeft, met expertise binnen de Developers
([`../security/secure-development-lifecycle.md`](../security/secure-development-lifecycle.md)).

## 13. Testgroepfeedback automatisch als featureverzoek behandelen

**Symptoom:** elke suggestie uit een sessie wordt een backlogitem, en dat wordt gebouwd.
**Waarom schadelijk:** het product wordt een verzameling losse wensen; de visie verdwijnt;
de mensen die het hardst roepen bepalen de koers.
**Correctie:** weeg elk item op visie, frequentie, impact, risico, haalbaarheid,
strategische waarde en bewijssterkte
([`../research/feedback-log.md`](../research/feedback-log.md)). Een waargenomen probleem
weegt zwaarder dan een uitgesproken wens.

## 14. Iedere specialist als aparte Scrum-rol presenteren

**Symptoom:** "de security-rol", "de UX-rol", "de testrol" naast PO, SM en Developers.
**Waarom schadelijk:** kwaliteit wordt iets van iemand anders; de Developers voelen zich
niet meer gezamenlijk verantwoordelijk voor de DoD, en overdrachten stapelen zich op.
**Correctie:** drie accountabilities; expertise zit binnen de Developers. Onafhankelijk
toezicht (security officer, DPO, compliance officer) staat er juist bewust buiten
([`roles.md`](roles.md)).

## 15. Definition of Ready als bureaucratische toegangspoort

**Symptoom:** items blijven hangen omdat een veld niet is ingevuld; refinement gaat over
formulieren in plaats van over het probleem.
**Waarom schadelijk:** de DoR is bedoeld om te voorkomen dat het team halverwege vastloopt,
niet om werk tegen te houden. Als checklist wordt het een ritueel.
**Correctie:** gebruik de DoR als gespreksleidraad. Ontbreekt er iets, spreek dan één
concrete actie met een eigenaar af in plaats van het item af te wijzen. Bij een
productieverstoring of kritieke kwetsbaarheid geldt de DoR niet.

---

## Hoe gebruik je deze lijst?

Neem hem één keer per kwartaal door in een retrospective: welke twee herkennen we het
meest? Kies daar één verbeteractie bij. Meer dan twee tegelijk aanpakken werkt niet.
