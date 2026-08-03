# Regulatoire besluiten

> **Doel:** juridische en regulatoire vragen zichtbaar houden tot een bevoegde specialist
> ze heeft beantwoord.
> **Wanneer gebruiken:** zodra iemand denkt "mag dit eigenlijk wel?".
> **Wie:** compliance officer beheert; iedereen mag een vraag toevoegen. Bij
> privacyvragen adviseert de DPO onafhankelijk; het besluit ligt bij de bevoegde
> mandaathouder.
> **Adoptieniveau:** Core voor de blokkerende vragen (RD-01, RD-14), Regulated voor het volledige register.
> **Gerelateerd:** [`compliance-register.md`](compliance-register.md) · [`../privacy/privacy-by-design.md`](../privacy/privacy-by-design.md) §0

Register van vragen over wet- en regelgeving, met de status van de beoordeling. Het
principe is simpel: **het team beantwoordt deze vragen niet zelf.**

Dit register gaat over **wat geldt** (soorten `GB` en `FR` uit
[`../privacy/privacy-by-design.md`](../privacy/privacy-by-design.md) §0). Hoe we een
eenmaal vastgestelde verplichting borgen, staat in
[`control-mapping.md`](control-mapping.md); het bewijs daarvan in
[`audit-evidence.md`](audit-evidence.md).

> ⚖️ Elke conclusie in dit register is **te valideren door een bevoegde specialist**
> (jurist, compliance officer of externe adviseur) totdat de kolom *Gevalideerd door*
> is ingevuld met een naam, een datum en een verwijzing naar het schriftelijke advies.

## 1. Statussen

| Status | Betekenis |
|---|---|
| **Open** | vraag geformuleerd, nog geen onderzoek |
| **In onderzoek** | team verzamelt feiten (geen conclusies) |
| **Voorgelegd** | vraag ligt bij een bevoegde specialist |
| **Gevalideerd** | schriftelijk antwoord ontvangen en vastgelegd |
| **Herbeoordeling nodig** | omstandigheden zijn gewijzigd |

## 2. Register

| # | Vraag | Waarom relevant | Blokkeert | Status | Voorlopige aanname (**geen besluit**) | Gevalideerd door | Datum | Herbeoordeling |
|---|---|---|---|---|---|---|---|---|
| RD-01 | Is voor SolidYield in Nederland een vergunning, registratie of ontheffing vereist? Concreet: gebruikers zetten geld voor een vooraf gekozen looptijd vast tegen een vooraf vastgesteld rendement, gestort in een walletomgeving en na afloop uitgekeerd. Raakt dit het verbod op het aantrekken van opvorderbare gelden van het publiek (Wft art. 3:5), en/of prospectus- of informatieverplichtingen? | bepaalt of we mogen lanceren, en in welke vorm | bèta, productie, en elke externe propositie | **Open** — vraag aangescherpt 2026-08-03, nog niet voorgelegd | wij nemen géén standpunt in | | | |
| RD-02 | Zijn wij verwerkingsverantwoordelijke, verwerker of beide? | bepaalt verplichtingen en contracten | DPA's | Open | waarschijnlijk verantwoordelijk voor eigen verwerkingen; vaststelling door een bevoegde specialist, de DPO adviseert | | | |
| RD-03 | Welke grondslag geldt per verwerking? | bepaalt of toestemming nodig is | ontwerp toestemmingsflow | In onderzoek | zie `../architecture/data-flow.md` (voorlopig) | | | |
| RD-04 | Welke wettelijke bewaartermijnen gelden voor financiële gegevens? | bepaalt verwijderroutines | verwijderfunctionaliteit | Open | `[7 jaar]` als werkhypothese | | | |
| RD-05 | Gelden er identificatie- of verificatieverplichtingen bij onboarding? | bepaalt de registratieflow | onboarding | Open | in de MVP niet ingebouwd | | | |
| RD-06 | Welke informatieverplichtingen gelden richting consumenten? | bepaalt teksten en schermen | UI-teksten | Open | transparantie als uitgangspunt | | | |
| RD-07 | Mogen gegevens buiten `[REGIO]` worden verwerkt? | bepaalt cloudkeuze | ADR cloud | Open | uitgangspunt: alles binnen `[REGIO]` | | | |
| RD-08 | Welke meldplichten en termijnen gelden bij een incident of datalek? | bepaalt het incidentproces | incidentprocedure | Open | zie `../security/incident-response.md` | | | |
| RD-09 | Is een DPIA verplicht voor de kernverwerking? | bepaalt of we mogen starten | bèta | Open | wij voeren er sowieso één uit | | | |
| RD-10 | Gelden er eisen aan uitbesteding en leveranciersbeheersing? | bepaalt contracten en toezicht | leveranciers | Open | DPA en risicobeoordeling als minimum | | | |
| RD-11 | Welke toegankelijkheidseisen zijn verplicht? | bepaalt het minimumniveau | UI | Open | wij hanteren WCAG 2.2 AA | | | |
| RD-12 | Zijn er eisen aan het bewaren en beschikbaar stellen van audit trails? | bepaalt logbewaartermijn | auditlog | Open | `[1–7 jaar]` als werkhypothese | | | |
| RD-13 | Gelden er regels voor communicatie over rendement, risico of kosten? | bepaalt teksten en weergave | UI-teksten | Open | geen beloften, geen advies | | | |
| RD-14 | Mag de testgroep met een niet-vergunde dienst werken? | bepaalt de testopzet | testgroepsessies | **Voorgelegd** | wij testen met synthetische data en zonder echte geldstromen | | | |
| RD-15 | Mag SolidYield worden gepresenteerd als product **zonder beleggingsrisico**, en mag "vast rendement" als belofte worden gebruikt? Een toegezegd vast rendement op een beleggingsproduct is een claim met eigen informatie- en zorgplichteisen. Hangt af van de constructie waarmee het rendement wordt gerealiseerd. | bepaalt propositie, doelgroepbenadering en zorgplicht | marketing, UI-teksten, onboarding | **Open** — geregistreerd 2026-08-03 | wij nemen géén standpunt in; zie risico V-1 en V-2 in [`../product/product-vision.md`](../product/product-vision.md) | | | |
| RD-16 | Welke constructie ligt onder het rendement (eigen balans, doorplaatsing in leningen, externe partij), en welke rol nemen wij in die keten? | bepaalt RD-01, RD-15 en het volledige risicoprofiel | RD-01, RD-15, architectuur | **Open** — geregistreerd 2026-08-03 | nog niet gekozen; dit is een productbesluit, geen technische keuze | | | |

## 3. Werkwijze

1. **Vraag formuleren** — concreet, met context, via `compliance-task.yml`.
2. **Feiten verzamelen** — het team beschrijft wat het product doet, niet wat mag.
3. **Voorleggen** — aan `[JURIST/COMPLIANCE OFFICER/EXTERNE ADVISEUR]`.
4. **Antwoord vastleggen** — schriftelijk, met datum en reikwijdte, in
   `[AFGESCHERMDE LOCATIE]`; hier alleen de verwijzing.
5. **Vertalen naar werk** — backlogitems, controls en acceptatiecriteria.
6. **Herbeoordelen** — bij nieuwe functionaliteit, nieuwe regio, nieuwe leverancier of
   wijziging van het type dienst; verder minimaal jaarlijks.

## 4. Wat het team wél mag doen

* Feitelijk beschrijven wat het product doet en welke gegevens het verwerkt.
* Risico's signaleren en vragen formuleren.
* Voorzorgsmaatregelen nemen die sowieso verstandig zijn (minimalisatie, encryptie,
  audit trail, transparantie).
* Werken met een **voorlopige aanname**, mits die expliciet als aanname is gemarkeerd en
  niet als vaststaand feit wordt gecommuniceerd.

## 5. Wat het team **niet** mag doen

* Concluderen dat een vergunning niet nodig is.
* Aannemen dat een bewaartermijn juist is zonder bevestiging.
* In marketing of documentatie stellen dat het product "voldoet aan" een wet of norm.
* Een lancering doorzetten terwijl een blokkerende vraag openstaat.
