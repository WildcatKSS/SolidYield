# Testgroepplan

> **Doel:** structureel leren van echte gebruikers, met een werkbaar ritme.
> **Wanneer gebruiken:** bij het opzetten van de testgroep en bij het plannen van elke
> leeractiviteit.
> **Wie:** UX- en onderzoeksexpertise binnen de Developers, samen met de Product Owner.
> **Adoptieniveau:** Core.
> **Gerelateerd:** [`experiment-template.md`](experiment-template.md) · [`feedback-log.md`](feedback-log.md) · [`consent-and-privacy-check.md`](consent-and-privacy-check.md)

De testgroep is geen eenmalige toets aan het einde, maar een **vast onderdeel van de
sprintcyclus**. Zonder contact met echte gebruikers bouwen we op aannames — bij een
financiële dienst is dat een risico voor de gebruiker, niet alleen voor het project.

> [!IMPORTANT]
> **Dit document gaat over onderzoekssessies, niet over de besloten testgroep uit
> besluit 7.** Twee verschillende activiteiten dragen dezelfde naam:
>
> | | **Onderzoekssessies** (dit document) | **Besloten testgroep** ([`../product/closed-test-group.md`](../product/closed-test-group.md)) |
> |---|---|---|
> | Wat | interviews, prototypetests, usabilitytests | eerste gecontroleerde **productie**-uitrol |
> | Omgeving | testomgeving | productieomgeving |
> | Data | **uitsluitend synthetisch** | **echte persoonsgegevens**, echte KYC |
> | Geldstromen | geen | echt, ná bevestiging van de wettelijke grondslag |
> | Deelnemers | representatieve spreiding, zie §1 | maximaal tien uitgenodigde bekenden |
> | Start | doorlopend vanaf sprint 1 | pas na de Go/No-Go uit besluit 7 |
>
> De randvoorwaarden in §5 — waaronder **"geen echte gegevens"** — gelden onverkort voor de
> onderzoekssessies in dit document. Besluit 7 verandert daar niets aan.

## 0. Vier soorten risico — en dus vier soorten onderzoek

De testgroep beantwoordt niet elke vraag. Bepaal eerst **welk risico** je toetst:

| Risicotype | De vraag | Wie of wat levert het antwoord |
|---|---|---|
| **Desirability** | willen gebruikers dit? | probleeminterview of concepttest met de doelgroep |
| **Usability** | kunnen ze het begrijpen en gebruiken? | taakgerichte usabilitytest met de testgroep |
| **Feasibility** | kunnen wij dit betrouwbaar bouwen en draaien? | technische spike of prototype — géén gebruikerssessie |
| **Viability** | is dit duurzaam, verantwoord en passend bij onze doelen? | kosten-, risico-, compliance- of businessanalyse |

De testgroep is het instrument voor **desirability en usability**. Feasibility en viability
worden binnen het team en met governance beantwoord. Het grootste verspilde onderzoek is
een usabilitytest op iets wat niemand wil, of een gebruikerssessie over een vraag die
juridisch of technisch beantwoord had moeten worden.

Sjabloon per experiment: [`experiment-template.md`](experiment-template.md).

## 1. Samenstelling

| Onderwerp | Invulling | Status |
|---|---|---|
| Omschrijving | deelnemers uit de doelgroep voor **onderzoekssessies met synthetische data** — niet dezelfde groep als de besloten testgroep uit besluit 7 | vastgesteld |
| Omvang | `[8–12]` deelnemers (aanname) | te bevestigen |
| Per usabilityronde | richtlijn: ± 5 deelnemers **per relevant gebruikerssegment**, in meerdere iteraties | richtlijn |
| Spreiding | leeftijd, digitale vaardigheid, financiële situatie, taalniveau, toegankelijkheidsbehoeften | te bepalen |
| Verplicht vertegenwoordigd | minimaal 2 deelnemers met een toegankelijkheidsbehoefte; minimaal 2 met lage digitale vaardigheid | vast |
| Vaste deelnemers vs. wisselend | roterend: een deel kent het product, een deel kijkt fris (voorkomt participant fatigue) | aanname |
| Vergoeding | `[VERGOEDING]` — gelijk voor iedereen, niet afhankelijk van de uitkomst | te bepalen |
| Werving | `[KANAAL]` | te bepalen |

> **Let op bij werving:** vermijd uitsluitend enthousiaste early adopters. Juist de
> twijfelaars en de mensen die snel afhaken, leveren de bruikbaarste inzichten op.

### Hoeveel deelnemers zijn genoeg?

Er bestaat geen universeel detectiepercentage. De veelgeciteerde vuistregel dat vijf
deelnemers "het grootste deel" van de gebruiksproblemen vinden, komt uit onderzoek naar
één homogene gebruikersgroep met vergelijkbare taken; zij is bruikbaar als **startpunt**,
niet als bewijs van dekking. Hoeveel je er nodig hebt, hangt af van doelgroep en
segmentatie, productcomplexiteit, de onderzoeksvraag, de taakvariatie, de kwaliteit van de
opzet en het aantal iteraties.

Werkwijze die wél houdbaar is:

* begin met ± **5 deelnemers per relevant segment**;
* doe **meerdere kleinere rondes** in plaats van één grote;
* **verhoog het aantal** bij een heterogene doelgroep, uiteenlopende
  toegankelijkheidsbehoeften, complexe of risicovolle financiële taken, of wanneer nieuwe
  sessies nog steeds nieuwe problemen opleveren;
* **stop met werven** wanneer je verzadiging bereikt: twee tot drie opeenvolgende sessies
  zonder nieuwe bevindingen;
* bepaal het uiteindelijke aantal op grond van onderzoeksdoel, risico en verzadiging — en
  leg die afweging vast bij het onderzoek.

## 2. Ritme — risicogestuurd, niet ritueel

Het principe is **doorlopend leren van echte gebruikers**. De zwaarte van de activiteit
volgt het risico en de openstaande onzekerheid, niet de kalender. Een klein team dat elke
sprint een formele usabilitytest moet organiseren, houdt dat niet vol — en put bovendien
de deelnemers uit.

**Vaste regel:** elke sprint waarin gebruikersimpact bestaat of een gebruikersaanname
openstaat, bevat een **expliciete leeractiviteit**. Welke, bepaalt het team.

| Soort leeractiviteit | Inspanning | Wanneer passend |
|---|---|---|
| Probleeminterview | midden | de behoefte of het probleem is nog onzeker |
| Prototypevalidatie | laag–midden | een oplossingsrichting toetsen vóór je bouwt |
| Formele usabilitytest | hoog | een werkend increment op een belangrijke gebruikersreis |
| Analyse van gebruiksdata | laag | er is genoeg gebruik om gedrag te meten |
| Support- en feedbackanalyse | laag | er komt al feedback binnen uit de praktijk |
| Deelname aan de Sprint Review | laag | het increment is toonbaar en er is een concrete vraag |
| Validatie van een werkend increment | midden | vóór uitbreiding naar een grotere groep |

**Ritmerichtlijn**

| Onderwerp | Richtlijn |
|---|---|
| Formele validatieronde | minimaal elke 1–2 sprints voor gebruikersgerichte ontwikkeling |
| Hoog-risico financiële reizen (geld, toestemming, identiteit, foutafhandeling) | intensiever en met meer segmenten testen |
| Laag-risico of niet-gebruikersgericht werk (interne techniek, documentatie) | geen sessie nodig; leg vast waarom niet |
| Sprint Review | deelnemers uit de testgroep zijn welkom wanneer er een concrete vraag ligt; niet iedere review vereist dezelfde of überhaupt dezelfde mensen |
| Observatie door een developer | waar het waarde toevoegt (zeker bij usabilitytests); niet verplicht bij elk interview |
| Belasting per deelnemer | roteer; houd het aantal sessies per deelnemer beperkt en zichtbaar |
| Brede feedbackronde (vragenlijst) | elk kwartaal |

Lukt een geplande leeractiviteit structureel niet, dan is dat een **belemmering** voor de
Scrum Master — geen vanzelfsprekendheid.

**Leg per leeractiviteit vast** (ongeacht de vorm):

| Veld | Waarom |
|---|---|
| Hypothese | zonder verwachting is er niets te weerleggen |
| Methode | maakt de uitkomst interpreteerbaar |
| Doelgroep/segment | zegt iets over de reikwijdte van de conclusie |
| Succescriterium (vooraf) | voorkomt achteraf rechtpraten |
| Beslissing die eruit volgt | voorkomt onderzoek zonder gevolg |

Sjabloon: [`experiment-template.md`](experiment-template.md).

## 3. De feedbackcyclus

```
Hypothese
  → Prototype of increment
    → Test met gebruikers
      → Observaties en meetgegevens
        → Inzichten
          → Beslissing (doorgaan / aanpassen / stoppen / meer onderzoek)
            → Nieuwe of aangepaste backlogitems
              → (opnieuw) Hypothese
```

Per stap:

| Stap | Waar vastgelegd | Verantwoordelijk |
|---|---|---|
| Hypothese | [`experiment-template.md`](experiment-template.md) | UX + PO |
| Prototype/increment | testomgeving met synthetische data | Developers |
| Test | [`usability-test-template.md`](usability-test-template.md) / [`interview-template.md`](interview-template.md) | UX |
| Observaties | issues via `test-group-feedback.yml` | UX |
| Inzichten | [`feedback-log.md`](feedback-log.md) | UX |
| Beslissing | feedback-log + boardveld *Testgroepstatus* | PO |
| Backlogitems | GitHub Issues | PO |

## 4. Wat testen we per fase?

| Fase | Wat | Risicotype | Methode |
|---|---|---|---|
| Probleem nog onduidelijk | bestaat het probleem, en voor wie? | desirability | interview |
| Oplossingsrichting | begrijpt men het concept? | desirability + usability | prototype + hardop denken |
| Technische onzekerheid | kunnen we dit betrouwbaar bouwen? | feasibility | spike, geen gebruikerssessie |
| Werkend increment | lukt de taak zonder hulp? | usability | usabilitytest |
| Vóór opschalen | is dit houdbaar qua kosten, risico en regelgeving? | viability | analyse + governance |
| Meerdere sprints later | komt men terug, en waarom (niet)? | desirability | meting + interview |
| Vóór bredere uitrol | vertrouwen, duidelijkheid, foutafhandeling | usability | usabilitytest + vragenlijst |

## 5. Randvoorwaarden (niet onderhandelbaar)

1. **Geen echte gegevens.** Deelnemers krijgen een testaccount met synthetische data.
   Nooit echte bankgegevens, betaalgegevens, BSN-achtige identificatoren of echte
   inloggegevens. *Dit geldt voor de onderzoekssessies in dit document. De besloten
   testgroep uit besluit 7 draait in **productie** met echte gegevens en valt onder een
   eigen regime — zie [`../product/closed-test-group.md`](../product/closed-test-group.md).
   De twee mogen nooit door elkaar lopen: er komen geen echte gegevens in de testomgeving.*
2. **Toestemming vooraf**, schriftelijk, per sessie —
   [`consent-and-privacy-check.md`](consent-and-privacy-check.md).
3. **Geanonimiseerde vastlegging.** Deelnemers heten P1, P2, …; namen en contactgegevens
   staan alleen in het (afgeschermde) deelnemersregister, nooit in de repository.
4. **Vrijwillig en stopbaar.** Deelnemers mogen op elk moment stoppen, zonder reden en met
   behoud van de vergoeding.
5. **Testomgeving duidelijk herkenbaar** (banner: "Dit is een testomgeving; gebruik geen
   echte gegevens").
6. **Geen misleiding.** Deelnemers weten dat ze met een product in ontwikkeling werken.
7. **Zorg voor de deelnemer.** Komt er in een sessie een echt financieel probleem ter
   sprake, dan verwijzen we naar hulp; wij geven geen financieel advies.

## 6. Rollen tijdens een sessie

| Rol | Taak |
|---|---|
| Facilitator (UX) | leidt de sessie, stelt vragen, grijpt niet in |
| Observator (developer of PO) | noteert gedrag, stelt geen vragen |
| Technische ondersteuning | staat klaar bij problemen met de omgeving |

Zelf zien werkt beter dan een rapport lezen: bij **usabilitytests en validatiesessies**
observeert minimaal één developer. Bij lichtere activiteiten (een kort interview,
data-analyse) is dat wenselijk maar niet verplicht — beter een sessie mét alleen de
onderzoeker dan geen sessie.

## 7. Van sessie naar backlog

1. Direct na de sessie: 15 minuten debrief, top 3 bevindingen opschrijven.
2. Binnen 1 werkdag: issues aanmaken met `test-group-feedback.yml`.
3. Bij de eerstvolgende refinement: PO toetst elk item aan de weegcriteria uit
   [`feedback-log.md`](feedback-log.md).
4. Terugkoppeling aan deelnemers binnen `[2]` weken: wat is er met hun input gebeurd?

## 8. Meetwaarden van het proces zelf

| Meetwaarde | Streefwaarde |
|---|---|
| Sprints met gebruikersimpact die een leeractiviteit bevatten | 100% |
| Formele validatierondes | ≥ 1 per 2 sprints bij gebruikersgerichte ontwikkeling |
| Verzadiging bereikt vóór afronding van een ronde | ja/nee, per onderzoek vastgelegd |
| Doorlooptijd sessie → issue | ≤ 1 werkdag |
| Feedbackitems met beslissing binnen 2 sprints | ≥ 90% |
| Deelnemers die terugkoppeling ontvingen | 100% |
| Sessies per deelnemer per kwartaal | ≤ `[3]` (voorkomt participant fatigue) |
| Uitval van deelnemers per kwartaal | ≤ `[20]%` |

## 9. Deelnemersregister (buiten deze repository)

Namen, contactgegevens en toestemmingsformulieren worden **niet** in Git bewaard. Zij
staan in `[AFGESCHERMDE LOCATIE]`, met toegang voor `[ROLLEN]`, en worden verwijderd
uiterlijk `[TERMIJN]` na afloop van het onderzoek. Zie
[`../privacy/data-retention.md`](../privacy/data-retention.md).

| Veld in het register | Bewaartermijn |
|---|---|
| Naam en contactgegevens | tot einde deelname + `[3 maanden]` |
| Toestemmingsformulier | `[wettelijke of interne termijn]` — **te valideren** |
| Opnames | `[maximaal 30 dagen]`, daarna verwijderd |
| Geanonimiseerde bevindingen | onbeperkt (bevatten geen persoonsgegevens) |
