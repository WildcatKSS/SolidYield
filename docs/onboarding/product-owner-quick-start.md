# Product Owner — quick start

> **Doel:** als Product Owner binnen een dag kunnen starten.
> **Wanneer gebruiken:** bij aanvang, en als naslag vóór de eerste Sprint Planning.
> **Wie:** Product Owner (en wie die rol tijdelijk waarneemt).
> **Adoptieniveau:** Core.
> **Gerelateerd:** [`../../START-HERE.md`](../../START-HERE.md) · [`../scrum/scrum-guide.md`](../scrum/scrum-guide.md) · [`../scrum/anti-patterns.md`](../scrum/anti-patterns.md)

---

## 1. Lees eerst deze vijf

In deze volgorde, samen ± 45 minuten:

1. [`../product/product-vision.md`](../product/product-vision.md) — waar je visie in komt.
2. [`../product/mvp-scope.md`](../product/mvp-scope.md) — hoe je scope begrenst.
3. [`../scrum/definition-of-done.md`](../scrum/definition-of-done.md) — wat "af" betekent
   (en dat jij dat niet in je eentje bepaalt).
4. [`../research/feedback-log.md`](../research/feedback-log.md) — hoe je feedback weegt.
5. [`../scrum/sprint-planning.md`](../scrum/sprint-planning.md) — hoe de sprint start.

De rest lees je wanneer je het nodig hebt.

## 2. Productvisie en productdoel formuleren

**Visie** = waarom dit product bestaat. Vul de zin in
[`../product/product-vision.md`](../product/product-vision.md) in:

> Voor **[DOELGROEP]** die **[PROBLEEM]** ervaart, is **[PRODUCTNAAM]** een
> **[TYPE DIENST]** die **[VOORDEEL]**. Anders dan **[ALTERNATIEF]** biedt ons product
> **[ONDERSCHEID]**.

**Productdoel** = de verandering waar je nu naartoe werkt. Eén doel tegelijk, meetbaar in
gebruikersgedrag, niet in opgeleverde functies.

| Slecht | Beter |
|---|---|
| "Dashboard, meldingen en export bouwen" | "Gebruikers zien binnen 5 minuten na registratie waar hun geld heen ging" |
| "Betere UX" | "80% voltooit de kernreis zonder hulp" |

Vuistregel: kun je het doel halen zonder één regel code te schrijven? Dan is het een goed
geformuleerd doel.

## 3. MVP begrenzen

De vraag is niet "wat kan eruit?" maar **"wat is de kleinste veilige versie waarmee we
onze grootste aanname toetsen?"**

Drie kolommen invullen in [`../product/mvp-scope.md`](../product/mvp-scope.md):

* **Must have** — zonder dit werkt de kernreis niet.
* **Won't have (nu)** — expliciet opschrijven; dit voorkomt de meeste discussies.
* **Aannames** — waar je het meest onzeker over bent, met hoe je dat toetst.

> **Bij een financiële dienst:** "minimum" gaat over de omvang van de functionaliteit,
> nooit over zorgvuldigheid. MFA, autorisatie, encryptie, audit logging en het verbod op
> echte data zijn geen must-have-kandidaten maar randvoorwaarden.

## 4. Feedback prioriteren

Niet elke wens bouwen. Weeg elk feedbackitem op zeven criteria — visie, frequentie,
impact, risico, haalbaarheid, strategische waarde en bewijssterkte
([`../research/feedback-log.md`](../research/feedback-log.md)).

Twee vuistregels die het meeste werk doen:

* **één deelnemer + zwak bewijs (mening, geen gedrag)** → nog niet bouwen, wel vastleggen
  en wachten of het terugkomt;
* **kritiek probleem** (taak lukt niet, of geld/gegevens lopen risico) → altijd naar de
  backlog, ongeacht score.

Elke gesloten feedback krijgt een korte motivatie én terugkoppeling aan de deelnemer. "We
doen dit niet, omdat…" is een goed antwoord.

## 5. Sprint Goal opstellen

Eén zin, één resultaat, te demonstreren aan het einde van de sprint.

> *"Aan het einde van deze sprint kan een testgebruiker een account aanmaken en inloggen
> met MFA, en hebben we in een sessie met zes deelnemers gemeten of dat zonder hulp lukt."*

Een goed Sprint Goal is géén opsomming van tickets: het geeft het team ruimte om onderweg
te kiezen wat wel en niet nodig is om het doel te halen.

## 6. Wat beslis je wel en niet?

| Jij beslist | Jij beslist **niet** |
|---|---|
| volgorde en prioriteit van de backlog | of het increment technisch af is |
| wat het productdoel is | hoe iets technisch wordt gebouwd |
| of en wanneer een Done increment wordt vrijgegeven | of een securityrisico acceptabel is (governance) |
| wat buiten scope valt | of iets juridisch mag (bevoegde specialist) |
| wanneer een experiment tot een pivot leidt | de schatting van het werk |

## 7. Done, acceptatiecriteria en releasebesluit

Drie verschillende dingen — dit is de meest voorkomende verwarring:

| Begrip | Wat het is | Wie |
|---|---|---|
| **Acceptatiecriteria** | wanneer déze story het gewenste gedrag vertoont; vooraf samen opgesteld | PO + Developers |
| **Definition of Done** | de kwaliteitsondergrens voor élk increment: tests, review, security, documentatie | Developers stellen vast |
| **Releasebesluit** | of dit Done increment nú naar gebruikers gaat, en naar welk kanaal | PO; een openstaande blokkerende security-, privacy- of compliancebevinding houdt de release tegen |

Je kunt dus **niet** iets Done verklaren dat technisch onvolledig is, en je hoeft **geen**
aparte handtekening te zetten als de DoD aantoonbaar gehaald is. Ben je ontevreden over de
waarde van een Done increment? Dat is nieuw backlogwerk, geen DoD-discussie.

## 8. Sprint 1 voorbereiden

- [ ] Visie, productdoel en MVP-scope ingevuld (mag als concept)
- [ ] 5–8 items in de backlog, waarvan 3–5 Ready
- [ ] Board aangemaakt, labels gesynchroniseerd
- [ ] Refinement gehouden; het team snapt de items en heeft ze geschat
- [ ] Concept-Sprint Goal geformuleerd (definitief in de planning, sámen met het team)
- [ ] Een eerste leeractiviteit met gebruikers ingepland
- [ ] Security-, privacy- en compliancevelden ingevuld op de sprintitems (mag "Geen" zijn)

## 9. Wat hoef je niet zelf te doen

Threat modelling · teststrategie · architectuurbesluiten · CI-configuratie · control
matrix · DPIA · platform-readiness · SLO's. Je bent wel verantwoordelijk voor het
**zichtbaar maken** van dat werk in de backlog: security- en privacywerk is geen
achtergrondruis maar prioriteerbaar werk.

---

## Voorbeeld (fictief)

**Product Goal (PD-1)**
> Binnen zes maanden ziet een gebruiker uit `[DOELGROEP]` binnen vijf minuten na
> registratie waar het geld in de afgelopen maand heen ging, en blijft die dat inzicht
> maandelijks gebruiken.

**Sprint Goal (sprint 1)**
> Aan het einde van sprint 1 kan een testgebruiker op de testomgeving een account
> aanmaken en verifiëren, en hebben we uit acht interviews bewijs of het probleem echt
> speelt bij `[DOELGROEP]`.

**Epic E1 — Veilige toegang tot mijn account**
Doel: een gebruiker kan een account aanmaken en veilig inloggen, met bescherming die past
bij financiële gegevens. Succes: 5 van 6 deelnemers voltooit registratie + MFA zonder hulp.

**Feature F1.1 — Registratie**
Account aanmaken met e-mailverificatie, bestand tegen geautomatiseerd misbruik.

**User stories**

| ID | Story | Acceptatiecriterium (kort) |
|---|---|---|
| US-101 | Als nieuwe bezoeker wil ik een account aanmaken met mijn e-mailadres, zodat ik mijn eigen overzicht kan opbouwen. | Given een geldig e-mailadres en een wachtwoord van ≥ 12 tekens, When de bezoeker registreert, Then ontstaat een niet-geverifieerd account en volgt een verificatiemail |
| US-102 | Als nieuwe gebruiker wil ik mijn e-mailadres bevestigen, zodat herstelberichten mij bereiken. | Given een geldige, eenmalige link (24 uur), When die wordt geopend, Then is het account geverifieerd |
| US-103 | Als gebruiker wil ik inloggen met een tweede factor, zodat iemand met alleen mijn wachtwoord niet bij mijn gegevens kan. | Given een account met MFA, When correcte gegevens en een geldige tweede factor worden ingevoerd, Then krijgt de gebruiker toegang en wordt `login.success` gelogd |

Volledig uitgewerkt voorbeeld, inclusief taken:
[`../product/example-backlog.md`](../product/example-backlog.md).
