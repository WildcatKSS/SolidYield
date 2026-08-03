# Voorstel sprint 1 en sprint 2 (fictief voorbeeld)

Gebaseerd op de [voorbeeldbacklog](../product/example-backlog.md). Alle gegevens zijn
fictief. Uitgangspunten: sprintduur `2 weken`, 4 developers + UX + parttime security en
privacy, focusfactor `70%`, buffer `10%` voor ongepland werk en `10%` voor kwaliteit.

**Capaciteit per sprint (aanname): ± 26 story points.**

---

## Sprint 1 — Fundament en eerste bewijs

> **Sprintdoel:** *Aan het einde van sprint 1 kan een testgebruiker op de testomgeving een
> account aanmaken en zijn e-mailadres bevestigen via een werkende pipeline, en hebben we
> uit acht interviews bewijs of `[PROBLEEM]` daadwerkelijk speelt bij `[DOELGROEP]`.*

Waarom dit doel: het neemt twee onzekerheden tegelijk weg — technisch (kunnen we veilig
en geautomatiseerd opleveren?) en inhoudelijk (bouwen we het juiste?).

### Sprintbacklog

| ID | Item | Type | Punten | Verantwoordelijke |
|---|---|---|---|---|
| TT-001 | ADR-0002: keuze technologiestack | technisch | 3 | Tech lead |
| TT-002 | ADR-0003: cloudprovider en regio | technisch | 3 | Tech lead + Compliance |
| TT-003 | CI/CD werkend voor de gekozen stack, `TEMPLATE_STRICT=true` | technisch | 5 | Dev |
| US-101 | Account aanmaken met e-mailverificatie | user story | 5 | Dev |
| US-102 | E-mailadres bevestigen | user story | 3 | Dev |
| ST-001 | Threat modelling epic 1 | security | 3 | Security |
| ST-002 | Secrets manager inrichten | security | 5 | Security + Dev |
| PT-001 | Gegevensclassificatie voor accountgegevens | privacy | 3 | Privacy |
| RS-006 | Werving en toestemming testgroep inrichten | onderzoek | 3 | UX |
| RS-001 | 8 interviews met `[DOELGROEP]` | onderzoek | 8 | UX |
| CT-002 | RD-01 en RD-14 voorleggen aan een specialist | compliance | 2 | Compliance |

**Totaal: 43 punten.** Dat is méér dan de capaciteit van 26 — daarom:

| Prioriteit binnen de sprint | Items |
|---|---|
| Verplicht voor het sprintdoel | TT-001, TT-003, US-101, US-102, ST-001, RS-006, RS-001 (30 pt) |
| Meenemen als het lukt | TT-002, ST-002, PT-001 (11 pt) |
| Verschuift naar sprint 2 | CT-002 blijft staan (kost weinig tijd, lange doorlooptijd — vroeg starten) |

> **Realistische versie:** neem 26 punten mee (TT-001, TT-003, US-101, US-102, ST-001,
> RS-006 en de helft van RS-001) en verschuif de rest. Dit voorbeeld laat bewust zien hoe
> je een te volle sprint terugbrengt — vollopen is de meest gemaakte planningsfout.

### Definition of Ready-controle
Alle geselecteerde items hebben acceptatiecriteria, een testaanpak en ingevulde velden
voor security-, privacy- en compliance-impact. RS-001 valt onder de lichtere DoR voor
onderzoek (vraag, timebox, resultaat).

### Testgroepactiviteit
* **Wat:** 8 interviews (`interview-template.md`), doel: aanname A1 en A2 toetsen.
* **Wanneer:** dag 3–8 van de sprint.
* **Succescriterium:** ≥ 6 van 8 deelnemers noemt `[PROBLEEM]` spontaan.
* **Verwerking:** bevindingen als issues, weging in `feedback-log.md`.

### Risico's in deze sprint
| Risico | Beheersing |
|---|---|
| Stackkeuze loopt uit en blokkeert alles | timebox 2 dagen; anders beslist de tech lead met de beschikbare informatie |
| Werving testgroep kost meer tijd dan gedacht | vroeg starten, ruimer werven dan nodig |
| Juridische vraag RD-01 blijft lang open | vroeg indienen; blokkeert pas bij bèta |

### Wat aan het einde van sprint 1 Done is
Een werkend increment op de testomgeving waarin registratie en e-mailverificatie werken,
met CI die build, lint, tests, secret scan en dependency scan afdwingt, plus een
onderzoeksrapport met acht interviews.

---

## Sprint 2 — Veilig inloggen en eerste validatie

> **Sprintdoel:** *Aan het einde van sprint 2 kan een deelnemer uit de testgroep
> zelfstandig een account aanmaken, MFA instellen en inloggen op de testomgeving — en
> hebben we in een usabilitytest met zes deelnemers gemeten of dat zonder hulp lukt.*

### Sprintbacklog

| ID | Item | Type | Punten | Verantwoordelijke |
|---|---|---|---|---|
| US-103 | Inloggen met multifactor-authenticatie | user story | 8 | Dev |
| US-104 | Sessie verloopt en uitloggen werkt overal | user story | 5 | Dev |
| ST-003 | Snelheidsbeperking op inloggen en registreren | security | 3 | Dev + Security |
| ST-004 | Beveiligingsheaders en CSP | security | 2 | Dev |
| TT-005 | Gestructureerde logging met correlatie-ID | technisch | 3 | Dev |
| RS-003 | Spike: MFA-methoden en toegankelijkheid | onderzoek | 2 | UX + Security |
| RS-004 | Usabilitytest registratie + MFA (6 deelnemers) | onderzoek | 5 | UX |
| — | Verwerking van bevindingen uit sprint 1 | divers | (buffer) | team |

**Totaal: 28 punten** (inclusief 10% kwaliteitsbuffer, exclusief 10% ongepland werk).

### Afhankelijkheden
* US-103 vereist de keuze van `[IDP]` — die volgt uit RS-003; plan de spike aan het begin.
* RS-004 vereist een werkende MFA-flow op de testomgeving vóór dag 8.
* Openstaand: RD-14 (mag de testgroep hiermee werken?) — bij een negatief antwoord
  vervalt RS-004 en testen we met interne deelnemers.

### Testgroepactiviteit
* **Wat:** usabilitytest met 6 deelnemers (`usability-test-template.md`).
* **Hypothese:** ≥ 5 van 6 deelnemers voltooit registratie en MFA-instellen zonder hulp.
* **Meting:** taaksucces, tijd, moeite (1–7), kritieke fouten.
* **Wanneer:** dag 8–9, zodat bevindingen nog vóór de Sprint Review verwerkt zijn.

### Risico's in deze sprint
| Risico | Beheersing |
|---|---|
| MFA blijkt een te hoge drempel voor de doelgroep | spike vooraf; alternatieve factor beschikbaar; meten in RS-004 |
| Koppeling met `[IDP]` loopt vast | mock-implementatie achter de hand om de flow te kunnen testen |
| Sprint 1 loopt uit | eerst afmaken; scope van sprint 2 aanpassen, niet stapelen |

### Wat aan het einde van sprint 2 Done is
Een testgroepversie waarin de volledige toegangsreis werkt (registreren → verifiëren →
MFA instellen → inloggen → uitloggen), met securitytests S-2, S-4, S-5 en S-6 groen, en
een meetrapport uit de usabilitytest.

---

## Sprint 3 en verder (indicatie, geen toezegging)

| Sprint | Focus |
|---|---|
| 3 | Epic 2: gegevens koppelen met toestemming (US-201, US-202), DPIA (PT-002) |
| 4 | Epic 2: maandoverzicht (US-203, US-204), usabilitytest kerninzicht (RS-005) |
| 5 | Epic 3: export en verwijdering (US-301, US-302), bewaartermijnen (PT-003) |
| 6 | Meldingen en activiteitenoverzicht, pentest voorbereiden, evaluatie MVP-succescriteria |

Na sprint 4 volgt de eerste formele toets aan de stop-/wijzig-/doorgaancriteria uit
[`../product/mvp-scope.md`](../product/mvp-scope.md) §11.

---

## Hoe je dit voorbeeld gebruikt

1. Vervang de fictieve inhoud door je eigen backlog.
2. Houd de opbouw aan: sprintdoel eerst, dan items, dan testgroepactiviteit en risico's.
3. Plan **nooit** op 100% capaciteit.
4. Zorg dat in elke sprint zit: waarde-items, de bijbehorende security-/privacytaken, en
   minimaal één moment van contact met echte gebruikers.
