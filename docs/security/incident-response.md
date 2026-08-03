# Incidentrespons

Een securityincident is elke gebeurtenis die de vertrouwelijkheid, integriteit of
beschikbaarheid van gegevens of diensten (mogelijk) aantast.

> **Meld een vermoeden van een beveiligingsincident of datalek onmiddellijk via het
> incidentproces. Wacht niet op bevestiging, volledigheid of eigen onderzoek.**

**Bij twijfel: melden.** Een onterechte melding is geen fout; te laat melden wél. Melden
mag op basis van een vermoeden — je hoeft niet te weten wat er precies is gebeurd, hoeveel
gegevens het betreft of wie het veroorzaakte.

> Beoordeel **nooit zelf** of een incident meldingsplichtig is bij een toezichthouder, en
> ga niet zelf onderzoeken of het "echt" een incident is. De beoordeling doet de
> privacy-/complianceverantwoordelijke, waar nodig met juridisch advies. **Externe
> meldtermijnen zijn kort en worden bepaald door bevoegde specialisten** — ze zijn geen
> uitsteltermijn voor de melder.

## 1. Rollen

| Rol | Wie | Taak |
|---|---|---|
| Melder | iedereen | meldt **onmiddellijk** bij een vermoeden; onderzoekt niet zelf en verzamelt geen bewijs op eigen houtje |
| Incident lead | `[NAAM/ROL]` | leidt de afhandeling, neemt besluiten, bewaakt tijdlijn |
| Technisch onderzoeker | `[ROL]` | analyse en herstel |
| Communicatie | `[ROL]` | interne en externe communicatie |
| Privacy/Compliance | `[ROL]` | beoordeelt meldplicht en betrokkenen |
| Bestuur/opdrachtgever | `[ROL]` | besluiten met grote impact |

Buiten kantoortijden: `[BEREIKBAARHEIDSREGELING]`.

## 2. Ernstniveaus

| Niveau | Voorbeeld | Reactietijd | Escalatie |
|---|---|---|---|
| **P1 — kritiek** | vermoedelijke toegang tot klantgegevens; geldstroom onjuist; volledige uitval | direct, 24/7 | incident lead + bestuur binnen 1 uur |
| **P2 — hoog** | actief misbruikte kwetsbaarheid; gedeeltelijke uitval; gelekt secret | binnen 1 uur (kantoortijd) | incident lead |
| **P3 — middel** | kwetsbaarheid zonder aanwijzing van misbruik; kortdurende verstoring | binnen 1 werkdag | securityverantwoordelijke |
| **P4 — laag** | zwakke plek zonder directe impact | eerstvolgende sprint | backlog |

## 3. Stappen

### 1. Melden (minuut 0)
Melden via `[SECURITY-CONTACT-EMAIL]` of `[INCIDENTKANAAL]`, bij (mogelijke)
persoonsgegevens ook `[PRIVACY-CONTACT-EMAIL]`. **Niet** via een publiek GitHub Issue.

Vermeld wat je op dat moment weet: wat, wanneer, wie merkte het op, welke systemen, wat is
al gedaan. **Onvolledig melden is beter dan later melden** — ontbrekende informatie vul je
aan tijdens de triage.

### 2. Triage (< 30 min bij P1/P2)
Incident lead stelt vast: is het echt een incident, welk niveau, wie is nodig, en start
een tijdlijnverslag. Vanaf hier wordt **alles met tijdstempel vastgelegd**.

### 3. Indammen
* Toegang blokkeren, sessies intrekken, sleutels/secrets roteren.
* Feature flag uitzetten of terugrollen naar de vorige versie.
* Systemen isoleren in plaats van uitzetten (bewijs behouden).
* Verwijder geen logs; ze zijn bewijs.

### 4. Onderzoeken
* Wat is er precies gebeurd, sinds wanneer, welke gegevens zijn geraakt, hoeveel personen?
* Bewijs veiligstellen (logs, images) op een aparte, beperkt toegankelijke locatie.
* Privacyverantwoordelijke beoordeelt of persoonsgegevens zijn geraakt.

### 5. Herstellen
* Oorzaak wegnemen, niet alleen het symptoom.
* Herstel valideren; controleren of de aanvaller geen toegang heeft behouden.
* Gecontroleerd terug in dienst, met extra monitoring.

### 6. Communiceren
| Doelgroep | Wanneer | Wie |
|---|---|---|
| Intern team | direct | incident lead |
| Bestuur | P1 binnen 1 uur | incident lead |
| Getroffen gebruikers | zodra er feitelijke informatie is | communicatie + privacy |
| Toezichthouder | **beoordeling door privacy/compliance** — termijnen zijn strikt | privacy/compliance |
| Melder (bij extern gemelde kwetsbaarheid) | volgens `SECURITY.md` | security |

Communicatie is feitelijk, tijdig en zonder speculatie. Geen technische details die
misbruik mogelijk maken.

### 7. Evalueren (binnen 5 werkdagen)
Blameless post-mortem met tijdlijn, oorzaak, wat goed ging, wat beter kan, en concrete
verbeteracties als backlogitems met eigenaar en datum.

## 4. Datalek: extra stappen

Zijn (mogelijk) persoonsgegevens geraakt, dan geldt aanvullend:

1. Privacyverantwoordelijke **onmiddellijk** betrekken, bij het vermoeden — niet pas
   wanneer vaststaat dat er persoonsgegevens zijn geraakt.
2. Vastleggen: welke categorieën gegevens, hoeveel betrokkenen, welke gevolgen, welke
   maatregelen. Dit loopt parallel aan de melding, niet ervoor.
3. Registratie in het interne incidentregister, **ongeacht** of er extern gemeld wordt.
4. De privacyverantwoordelijke beoordeelt de meldplicht aan de toezichthouder en aan
   betrokkenen. **Welke externe termijnen gelden en vanaf welk moment ze lopen, wordt
   bepaald door bevoegde specialisten** — voor de melder verandert dat niets: onmiddellijk
   melden.

## 5. Tijdlijnverslag (sjabloon)

| Tijd (UTC) | Wat gebeurde er / wat deden wij | Door |
|---|---|---|
| | | |

## 6. Post-mortem (sjabloon)

* **Incident-ID / datum / niveau:**
* **Samenvatting (5 zinnen):**
* **Impact:** gebruikers, gegevens, geld, duur
* **Tijdlijn:** detectie → indamming → herstel
* **Grondoorzaak:**
* **Waarom hebben we het niet eerder gezien?**
* **Wat ging goed:**
* **Verbeteracties:** actie · eigenaar · issue · deadline
* **Bewijs vastgelegd in:** `../compliance/audit-evidence.md`

## 7. Voorbereiding

| Activiteit | Frequentie |
|---|---|
| Contactlijst en bereikbaarheid actueel | per kwartaal |
| Oefening (tabletop) | halfjaarlijks |
| Hersteltest van back-ups | per kwartaal |
| Toetsen van detectie en alarmering | per kwartaal |
