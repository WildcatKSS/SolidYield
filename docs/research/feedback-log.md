# Feedbacklog

Centrale registratie van alle feedback uit de testgroep, met de weging en het besluit.
Dit bestand maakt zichtbaar dat feedback **serieus wordt genomen** én dat niet elke
suggestie automatisch wordt gebouwd.

## 1. Waarom niet alles bouwen?

Elke losse gebruikerswens direct bouwen leidt tot een onsamenhangend product, een
oplopende onderhoudslast en — bij een financiële dienst — tot onnodig risico. Daarom
weegt de Product Owner elk feedbackitem langs **zeven criteria** voordat er iets gebeurt.

| # | Criterium | Vraag | Score |
|---|---|---|---|
| 1 | **Productvisie** | past dit bij de visie en het huidige productdoel? | 0–3 |
| 2 | **Frequentie** | bij hoeveel deelnemers/gebruikers zien we dit? | 0–3 |
| 3 | **Impact** | hoe erg is het als we niets doen? (blokkerend → klein) | 0–3 |
| 4 | **Risico** | verkleint of vergroot dit het security-, privacy- of compliancerisico? | −3–3 |
| 5 | **Haalbaarheid** | wat kost het, en wat gaat er dan niet door? | 0–3 |
| 6 | **Strategische waarde** | helpt dit ons op langere termijn? | 0–3 |
| 7 | **Bewijssterkte** | waargenomen gedrag (sterk) of één mening (zwak)? | 0–3 |

**Vuistregels**

* Bewijssterkte *zwak* + frequentie *1 deelnemer* → niet bouwen; wel vastleggen en
  wachten of het terugkomt.
* Iets dat het risico verhoogt, wordt nooit gebouwd zonder oordeel van de security-,
  privacy- of complianceverantwoordelijke.
* Een **kritiek probleem** (deelnemer kan de taak niet afronden, of geld/gegevens lopen
  risico) gaat altijd naar de backlog, ongeacht de score.
* Een compliment is ook data: het vertelt wat we níét moeten veranderen.

## 2. Classificatie

| Klasse | Betekenis | Standaardactie |
|---|---|---|
| **Kritiek probleem** | taak onmogelijk, of risico voor geld/gegevens | direct backlogitem, `priority:critical` of `high` |
| **Gebruiksprobleem** | taak lukt met moeite | wegen; meestal backlogitem |
| **Ontbrekende behoefte** | functionaliteit ontbreekt | wegen tegen visie en MVP-scope |
| **Verbetering** | werkt, kan beter | verzamelen; oppakken bij voldoende frequentie |
| **Compliment** | bevestigt dat iets werkt | vastleggen, niet wijzigen |
| **Nieuwe hypothese** | roept een onderzoeksvraag op | spike of experiment |
| **Buiten scope** | past niet bij visie of MVP | sluiten met uitleg en terugkoppeling |

## 3. Log

| ID | Datum | Bron | Deelnemer(s) | Observatie (feitelijk) | Classificatie | Freq. | Impact | Bewijs | Score | Besluit | Issue | Teruggekoppeld |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| FB-001 | `[JJJJ-MM-DD]` | UT-1-01 | P1, P3, P4 | *(voorbeeld, fictief)* Deelnemers zochten het maandoverzicht onder "Instellingen" | Gebruiksprobleem | 3/6 | groot | sterk | 14 | Backlogitem: navigatie herzien | #`[nr]` | ⬜ |
| FB-002 | `[JJJJ-MM-DD]` | INT-1-02 | P2 | *(voorbeeld, fictief)* Vroeg om een exportfunctie naar spreadsheet | Ontbrekende behoefte | 1/6 | klein | zwak | 6 | Niet nu; verzamelen tot ≥ 3 deelnemers | — | ⬜ |
| FB-003 | `[JJJJ-MM-DD]` | UT-1-03 | P5 | *(voorbeeld, fictief)* Begreep niet of het getoonde saldo actueel was | Kritiek probleem | 1/6 | blokkerend | middel | — | Direct oppakken: tijdstempel en bron tonen | #`[nr]` | ⬜ |
| FB-004 | | | | | | | | | | | | ⬜ |

> De rijen FB-001 t/m FB-003 zijn **fictieve voorbeelden** om het formaat te tonen.
> Verwijder ze zodra er echte bevindingen zijn.

## 4. Werkwijze

1. **Vastleggen** — na elke sessie een issue via `test-group-feedback.yml`; regel in dit
   log met dezelfde ID.
2. **Wegen** — de PO scoort de zeven criteria in de eerstvolgende refinement, samen met
   UX en (bij risico) security/privacy.
3. **Besluiten** — één van: backlogitem · verzamelen · onderzoek (spike) · niet doen.
   Elk besluit krijgt een korte motivatie.
4. **Terugkoppelen** — binnen `[2]` weken hoort de deelnemer wat er met de input is
   gebeurd. Ook "we doen dit niet, omdat…" is een goed antwoord.
5. **Evalueren** — elke `[4]` sprints kijken we terug: welke besluiten bleken achteraf
   juist, en welke niet?

## 5. Patronen en inzichten

Individuele bevindingen zijn ruis; patronen zijn signaal. Noteer hier wat over meerdere
sessies terugkomt.

| Patroon | Onderbouwing (FB-ID's) | Gevolg |
|---|---|---|
| `[PATROON]` | FB-…, FB-… | `[AANPASSING IN VISIE / BACKLOG / ONTWERP]` |

## 6. Signalen die de gewone weging overslaan

Deze gaan direct naar de betreffende verantwoordelijke, ongeacht score:

| Signaal | Naar wie | Termijn |
|---|---|---|
| Mogelijk securityrisico | securityverantwoordelijke, via `SECURITY.md` | direct |
| Mogelijk privacyrisico of gegevens bij de verkeerde persoon | privacyverantwoordelijke, via het incidentproces | **onmiddellijk**, zonder eigen onderzoek |
| Misleidende of onjuiste financiële informatie | PO + compliance | direct |
| Toegankelijkheidsblokkade | UX + PO | eerstvolgende refinement |
| Deelnemer in financiële nood | UX; verwijzen naar `[HULPINSTANTIE]`, geen advies geven | tijdens de sessie |
