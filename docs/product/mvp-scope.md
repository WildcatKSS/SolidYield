# MVP-scope

> **Uitgangspunt:** de eerste versie is de **kleinste veilige en bruikbare oplossing**
> waarmee de belangrijkste aannames getoetst kunnen worden.
>
> **Harde grens:** een financiële MVP slaat **geen** essentiële beveiligings-, privacy- of
> controlemaatregelen over om sneller te kunnen lanceren. "Minimum" slaat op de omvang van
> de functionaliteit, nooit op de zorgvuldigheid.

## 1. Doelgroep van de MVP

* Primair: Nederlandse particuliere spaarders zonder financiële expertise
* Beperking voor de MVP: `[BIJV. alleen [LAND], alleen web, alleen één rekeningtype]`
* Aantal beoogde gebruikers in de eerste ronde: `[AANTAL]` (testgroep, zie
  [`../research/test-group-plan.md`](../research/test-group-plan.md))

## 2. Kernprobleem

De doelgroep moet kiezen tussen laagrentend sparen en complex, volatiel beleggen, met onvoldoende transparantie over kosten, voorwaarden, risico's en hoe het rendement tot stand komt. Voor de MVP wordt hiervan **één** deelprobleem gekozen, niet alle drie. Alles wat niet aan dit probleem bijdraagt, valt
buiten de MVP.

## 3. Waardepropositie

> Met SolidYield kan een Nederlandse particuliere spaarder binnen `[TIJD]` `[RESULTAAT]`, zonder
> `[HUIDIGE MOEITE]`.

## 4. Belangrijkste gebruikersreis

De MVP ondersteunt **één** reis van begin tot eind:

```
Registreren → veilig inloggen (MVA/MFA) → gegevens beschikbaar maken →
eerste inzicht zien → terugkomen en actie ondernemen
```

Uitwerking per stap: [`customer-journey.md`](customer-journey.md).

## 5. Noodzakelijke functionaliteiten (Must have)

| # | Functionaliteit | Waarom noodzakelijk | Epic |
|---|---|---|---|
| M1 | Registratie met e-mailverificatie | zonder account geen persoonlijk inzicht | E1 |
| M2 | Inloggen met sterke authenticatie en MFA | beschermt financiële gegevens | E1 |
| M3 | Sessiebeheer met korte time-out en uitloggen | voorkomt misbruik op gedeelde apparaten | E1 |
| M4 | Toestemmingsflow voor gegevensgebruik, intrekbaar | doelbinding en gebruikerscontrole | E3 |
| M5 | Gegevens beschikbaar maken (`[koppeling of handmatige invoer]`) | grondstof voor het inzicht | E2 |
| M6 | Kerninzicht: `[HET INZICHT]` | het aha-moment; de reden van bestaan | E2 |
| M7 | Overzicht van onderliggende gegevens (transacties/posten) | vertrouwen en controleerbaarheid | E2 |
| M8 | Foutafhandeling en lege staten in begrijpelijke taal | voorkomt verwarring over geld | E2 |
| M9 | Audit logging van beveiligings- en gegevensgebeurtenissen | aantoonbaarheid en incidentonderzoek | E3 |
| M10 | Accountverwijdering en gegevensexport | rechten van betrokkenen | E3 |
| M11 | Feedbackknop in de applicatie | voedt de feedbackcyclus | E3 |
| M12 | Monitoring, alarmering en back-up/herstel | beschikbaarheid en herstelbaarheid | E1–E3 |

**Niet-functionele must-haves** (nooit "later"): encryptie in transport en opslag, secrets
management, invoervalidatie, autorisatie op objectniveau, rate limiting, gescheiden
omgevingen, kwetsbaarhedenscans in de pipeline, WCAG 2.2 AA op de kernreis, en uitsluitend
synthetische data in niet-productieomgevingen.

## 6. Uitgesloten functionaliteiten (Won't have — deze release)

| Functionaliteit | Waarom uitgesloten | Heroverwegen wanneer |
|---|---|---|
| `[BIJV. betalingen initiëren]` | zwaarder regulatoir regime en hoger risico | na juridisch advies en bewezen kernwaarde |
| `[BIJV. meerdere rekeningen koppelen]` | complexiteit zonder extra leerwaarde | na validatie van M6 |
| Mobiele apps (native) | web volstaat om te leren | bij bewezen retentie |
| Meertaligheid | testgroep is `[TAAL]`-talig | bij uitbreiding naar `[REGIO]` |
| Geavanceerde analyses of AI-advies | risico op misleidend financieel advies | na juridische toets |
| Sociale of deelfuncties | leidt af van het kernprobleem | mogelijk nooit |
| Integratie met `[PARTNER]` | afhankelijkheid van derden | na contract en DPIA |

## 7. Aannames

| # | Aanname | Type | Consequentie als deze onjuist is | Toetsen via |
|---|---|---|---|---|
| A1 | Nederlandse particuliere spaarders ervaren de keuze tussen laagrentend sparen en complex beleggen als urgent genoeg | probleem | product heeft geen bestaansrecht | interviews (sprint 1–2) |
| A2 | Gebruikers vertrouwen ons met financiële gegevens | vertrouwen | registratie loopt leeg | usabilitytest + interviews |
| A3 | Het kerninzicht M6 is begrijpelijk zonder uitleg | oplossing | inzicht wordt niet gebruikt | usabilitytest sprint 3 |
| A4 | Gegevens zijn technisch betrouwbaar beschikbaar te maken | techniek | fundament ontbreekt | spike sprint 1 |
| A5 | Wij mogen SolidYield aanbieden in Nederland (RD-01) | regulatoir | lancering onmogelijk | **juridisch advies** |
| A6 | MFA is acceptabel voor de doelgroep | adoptie | drempel te hoog | usabilitytest |
| A7 | Sprintduur van 2 weken past bij het team | proces | ritme klopt niet | retrospective |

## 8. Grootste risico's

| # | Risico | Type | Kans | Impact | Beheersing |
|---|---|---|---|---|---|
| R1 | Onbevoegde toegang tot financiële gegevens | security | laag | zeer hoog | MFA, autorisatie op objectniveau, audit logging, pentest vóór productie |
| R2 | Datalek of te ruime gegevensverzameling | privacy | midden | zeer hoog | minimalisatie, DPIA, classificatie, encryptie |
| R3 | Regulatoire mismatch (verkeerd regime aangenomen) | compliance | midden | zeer hoog | **advies bevoegde specialist vóór lancering** |
| R4 | Onjuiste bedragen of misleidend inzicht | product | midden | hoog | berekeningen unit-getest, dubbelcontrole, duidelijke bronvermelding |
| R5 | Gebruikers vertrouwen het product niet | adoptie | midden | hoog | transparantie, testgroep, vroege validatie |
| R6 | Afhankelijkheid van `[LEVERANCIER]` | leverancier | midden | hoog | exit-strategie, DPA, alternatief in beeld |
| R7 | Te veel bouwen vóór validatie | proces | hoog | midden | strikte MoSCoW, testgroep elke sprint |

## 9. Validatie-experimenten

| # | Hypothese | Methode | Meting | Succescriterium | Sprint |
|---|---|---|---|---|---|
| E1 | De doelgroep herkent het probleem spontaan | 8 interviews | % dat het probleem spontaan noemt | ≥ 6 van 8 | 1–2 |
| E2 | Gebruikers voltooien registratie met MFA zonder hulp | usabilitytest, 6 deelnemers | taaksucces | ≥ 5 van 6 | 3 |
| E3 | Het kerninzicht is binnen 60 seconden begrijpelijk | usabilitytest | tijd + hardop-denken | ≥ 80% correct uitgelegd | 4 |
| E4 | Gebruikers komen binnen een week terug | meting in testomgeving | terugkeer binnen 7 dagen | ≥ 50% | 5–6 |

Sjabloon: [`../research/experiment-template.md`](../research/experiment-template.md).

## 10. Succescriteria van de MVP

De MVP is geslaagd als **alle** onderstaande punten waar zijn:

* ≥ `[80]%` van de testgroep voltooit de kernreis zonder hulp;
* ≥ `[70]%` noemt het kerninzicht bruikbaar (schaal 1–10, score ≥ 7);
* ≥ `[50]%` keert binnen een week uit zichzelf terug;
* geen kritieke of hoge openstaande kwetsbaarheden;
* geen privacy- of compliance-blokkade die niet is opgelost of aantoonbaar geaccepteerd;
* het team kan minimaal elke twee weken een werkend increment opleveren.

## 11. Stop-, wijzigings- en doorgaancriteria

| Uitkomst | Criterium | Actie |
|---|---|---|
| **Doorgaan** | Kernaannames A1–A3 bevestigd, succescriteria gehaald, geen blokkerende risico's | uitbreiden naar de volgende epic; roadmap bijwerken |
| **Wijzigen (pivot)** | Probleem herkend maar oplossing werkt niet (A3 onjuist), of adoptie blijft achter | oplossing herontwerpen, doelgroep of reikwijdte aanpassen; visie bijwerken |
| **Stoppen** | Probleem niet urgent (A1 onjuist), of regulatoir niet toegestaan (A5), of risico's niet beheersbaar binnen `[BUDGET/TIJD]` | stoppen of parkeren; besluit met onderbouwing vastleggen; opgedane kennis borgen |

**Wie beslist:** de Product Owner, op basis van het bewijs uit de testgroep, met advies van
security, privacy en compliance. Een openstaand security-, privacy- of compliancerisico
houdt doorgaan tegen tot de bevoegde mandaathouder daarover heeft besloten; zie
[`../../GOVERNANCE.md`](../../GOVERNANCE.md).

**Evaluatiemoment:** aan het einde van sprint `[4]` en daarna elke twee sprints.

## 12. Prioriteringsmethode

Primair **MoSCoW** voor scope-afbakening. Bij twijfel binnen een categorie een gewogen
score:

```
Score = (Gebruikerswaarde × 3) + (Risicoreductie × 2) + (Urgentie × 2) − (Inspanning × 2)
```

Elke factor 1–5. Security-, privacy- en compliance-items die een **verplichte** maatregel
zijn, doen niet mee aan deze weging: die zijn per definitie Must have.
