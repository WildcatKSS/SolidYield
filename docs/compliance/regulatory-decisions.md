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
| RD-01 | Is voor SolidYield in Nederland een vergunning, registratie of vrijstelling vereist? Concreet (productbeschrijving 2026-08-03): de gebruiker brengt geld voor een vaste looptijd onder, ontvangt maandelijks een vooraf overeengekomen rendement, en krijgt na afloop de **volledige inleg terug**; SolidYield belegt het bedrag intussen voor eigen rekening en risico. Dat is een onvoorwaardelijke terugbetalingsverplichting. Raakt dit het verbod op het aantrekken van opvorderbare gelden van het publiek (Wft art. 3:5)? Zo ja, is een vrijstelling van toepassing (bijvoorbeeld inleg per tegenpartij boven de drempel, uitsluitend professionele partijen, of uitgifte onder goedgekeurd prospectus)? | bepaalt of we mogen lanceren, en in welke vorm | bèta, productie, en elke externe propositie | **Open** — vraag aangescherpt 2026-08-03 op basis van de vastgestelde productvorm, nog niet voorgelegd | wij nemen géén standpunt in | | | |
| RD-02 | Zijn wij verwerkingsverantwoordelijke, verwerker of beide? | bepaalt verplichtingen en contracten | DPA's | Open | waarschijnlijk verantwoordelijk voor eigen verwerkingen; vaststelling door een bevoegde specialist, de DPO adviseert | | | |
| RD-03 | Welke grondslag geldt per verwerking? | bepaalt of toestemming nodig is | ontwerp toestemmingsflow | In onderzoek | zie `../architecture/data-flow.md` (voorlopig) | | | |
| RD-04 | Welke wettelijke bewaartermijnen gelden voor financiële gegevens? | bepaalt verwijderroutines | verwijderfunctionaliteit | Open | `[7 jaar]` als werkhypothese | | | |
| RD-05 | Gelden er identificatie- of verificatieverplichtingen bij onboarding? | bepaalt de registratieflow | onboarding | Open | in de MVP niet ingebouwd | | | |
| RD-06 | Welke informatieverplichtingen gelden richting consumenten? | bepaalt teksten en schermen | UI-teksten | Open | transparantie als uitgangspunt | | | |
| RD-07 | Mogen gegevens buiten de EER worden verwerkt? | bepaalt cloudkeuze en leverancierseisen | ADR-0003 | **Beleidsmatig gesloten 2026-08-03** (ADR-0006): wij verwerken uitsluitend binnen de EER, primair Nederland. De *juridische* vraag of doorgifte toegestaan zou zijn blijft open — wij kiezen een strengere norm dan mogelijk vereist is, en dat mag het team zelf beslissen | doorgifte buiten de EER is uitgesloten; toegang van buiten de EER alleen na afzonderlijke privacy- en compliancebeoordeling | | | |
| RD-08 | Welke meldplichten en termijnen gelden bij een incident of datalek? | bepaalt het incidentproces | incidentprocedure | Open | zie `../security/incident-response.md` | | | |
| RD-09 | Is een DPIA verplicht voor de kernverwerking? | bepaalt of we mogen starten | bèta | Open | wij voeren er sowieso één uit | | | |
| RD-10 | Gelden er eisen aan uitbesteding en leveranciersbeheersing? | bepaalt contracten en toezicht | leveranciers | Open | DPA en risicobeoordeling als minimum | | | |
| RD-11 | Welke toegankelijkheidseisen zijn verplicht? | bepaalt het minimumniveau | UI | Open | wij hanteren WCAG 2.2 AA | | | |
| RD-12 | Zijn er eisen aan het bewaren en beschikbaar stellen van audit trails? | bepaalt logbewaartermijn | auditlog | Open | `[1–7 jaar]` als werkhypothese | | | |
| RD-13 | Gelden er regels voor communicatie over rendement, risico of kosten? | bepaalt teksten en weergave | UI-teksten | Open | geen beloften, geen advies | | | |
| RD-14 | Mag de testgroep met een niet-vergunde dienst werken? | bepaalt de testopzet | testgroepsessies | **Voorgelegd** | wij testen met synthetische data en zonder echte geldstromen | | | |
| RD-15 | Mag SolidYield worden gepresenteerd als product **zonder beleggingsrisico**, en mag "vast rendement" als belofte worden gebruikt? Een toegezegd vast rendement op een beleggingsproduct is een claim met eigen informatie- en zorgplichteisen. Hangt af van de constructie waarmee het rendement wordt gerealiseerd. | bepaalt propositie, doelgroepbenadering en zorgplicht | marketing, UI-teksten, onboarding | **Open** — geregistreerd 2026-08-03 | wij nemen géén standpunt in; zie risico V-1 en V-2 in [`../product/product-vision.md`](../product/product-vision.md) | | | |
| RD-16 | Welke constructie ligt onder het rendement, en welke rol nemen wij in die keten? | bepaalt RD-01, RD-15 en het volledige risicoprofiel | RD-01, RD-15, architectuur | **Deels beantwoord 2026-08-03** — de rol is bepaald (SolidYield belegt voor eigen rekening en risico, de gebruiker heeft een vordering op ons). Nog open: waarín wordt belegd, en welke kapitaalpositie draagt de terugbetalingsverplichting | het beleggingsbeleid en de kapitaalbuffer zijn nog niet vastgesteld | | | |
| RD-17 | Is de walletfunctie een **betaaldienst** in de zin van PSD2/Wft, of een hulpmiddel binnen het eigen product? Relevant zijn onder meer: kan de gebruiker geld ontvangen van of overmaken naar derden, worden gelden van derden aangehouden, en hoe lang staat geld stil in de wallet? | bepaalt of een vergunning of ontheffing voor betaaldiensten nodig is | onboarding, walletontwerp, RD-01 | **Open** — geregistreerd 2026-08-03 | **Voorlopige aanname van de Product Owner, geen besluit:** de wallet is slechts een hulpmiddel en daarmee geen zelfstandige betaaldienst. Het team is niet bevoegd dit vast te stellen | | | |
| RD-18 | Kwalificeert de gebruiker als **belegger**, en is het product een effect, een beleggingsobject of een deelneming in een beleggingsinstelling? | bepaalt informatie-, prospectus- en zorgplichtverplichtingen, en het toezichtregime | propositie, UI-teksten, RD-01 | **Open** — geregistreerd 2026-08-03 | **Voorlopige aanname van de Product Owner, geen besluit:** de gebruiker is geen belegger, omdat hij geen beleggingskeuzes maakt, geen eigendomsrecht krijgt, geen variabel rendement ontvangt en geen investeringsrisico draagt. **Kanttekening van het team:** de vierde grond betreft *markt*risico; de gebruiker draagt wél debiteurenrisico op SolidYield. Het ontbreken van keuzevrijheid en variabel rendement sluit een kwalificatie als effect of beleggingsobject niet zonder meer uit. Vaststelling uitsluitend door een bevoegde specialist | | | |
| RD-19 | Welke kapitaal- of buffervereisten gelden, of zijn bedrijfsmatig nodig, om de terugbetalingsverplichting waar te maken bij tegenvallend beleggingsresultaat? | bepaalt of het product houdbaar is en of gebruikers hun inleg terugkrijgen | financieringsmodel, RD-01, elke geldstroom van echte gebruikers | **Open** — geregistreerd 2026-08-03 | nog niet doorgerekend; zie risico V-5 in [`../product/product-vision.md`](../product/product-vision.md) | | | |

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
