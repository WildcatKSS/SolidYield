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
| RD-01 | Is voor SolidYield in Nederland een vergunning, registratie of vrijstelling vereist? Concreet (productbeschrijving 2026-08-03): de gebruiker brengt geld voor een vaste looptijd onder, ontvangt maandelijks een vooraf overeengekomen rendement, en krijgt na afloop de **volledige inleg terug**; SolidYield belegt het bedrag intussen voor eigen rekening en risico. Dat is een onvoorwaardelijke terugbetalingsverplichting. Raakt dit het verbod op het aantrekken van opvorderbare gelden van het publiek (Wft art. 3:5)? Zo ja, is een vrijstelling van toepassing (bijvoorbeeld inleg per tegenpartij boven de drempel, uitsluitend professionele partijen, of uitgifte onder goedgekeurd prospectus)? | bepaalt of we mogen lanceren, en in welke vorm | bèta, productie, en elke externe propositie | **Open** — feiten aangevuld 2026-08-05 ([ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md)) | wij nemen géén standpunt in. **Relevante feiten:** minimum inleg € 50; **geen vastgesteld maximum**; looptijden 3, 6, 12, 24, 36 en 60 maanden; doelgroep MVP zijn Nederlandse consumenten, zzp'ers en rechtspersonen, met start uitsluitend in een besloten testgroep. Het ontbreken van een maximum is relevant voor eventuele drempelgebonden vrijstellingen | | | |
| RD-02 | Zijn wij verwerkingsverantwoordelijke, verwerker of beide? | bepaalt verplichtingen en contracten | DPA's | Open | waarschijnlijk verantwoordelijk voor eigen verwerkingen; vaststelling door een bevoegde specialist, de DPO adviseert | | | |
| RD-03 | Welke grondslag geldt per verwerking? | bepaalt of toestemming nodig is | ontwerp toestemmingsflow | In onderzoek | zie `../architecture/data-flow.md` (voorlopig) | | | |
| RD-04 | Welke wettelijke bewaartermijnen gelden voor financiële gegevens? | bepaalt verwijderroutines | verwijderfunctionaliteit | Open | `[7 jaar]` als werkhypothese | | | |
| RD-05 | Gelden er identificatie- of verificatieverplichtingen (KYC/AML) bij onboarding, en verschillen die voor consumenten, zzp'ers en rechtspersonen? | bepaalt de registratieflow en het onboardingontwerp | onboarding, wallet openen | Open | **Inrichting (geen juridische conclusie):** fase 1 — SolidYield is zelf verantwoordelijk voor KYC/AML; fase 2 — integratie via een gespecialiseerde externe partner binnen het onboardingproces, een **roadmapbesluit en geen huidige implementatie**. De wallet wordt pas geopend na een positieve uitkomst | | | |
| RD-06 | Welke informatieverplichtingen gelden richting consumenten? | bepaalt teksten en schermen | UI-teksten | Open | transparantie als uitgangspunt | | | |
| RD-07 | Mogen gegevens buiten de EER worden verwerkt, en onder welke voorwaarden mag er vanuit een derde land toegang toe zijn? | bepaalt cloudkeuze, leverancierseisen en toegangsbeheer | ADR-0003 | **Beleidskant gesloten 2026-08-03** (ADR-0006): opslag en reguliere verwerking uitsluitend binnen de EER, primair Nederland; toegang vanuit derde landen standaard uitgesloten. De **juridische** beoordeling van een concrete uitzondering — is doorgifte toegestaan en welk mechanisme past — blijft een taak voor Privacy en Compliance en is geen conclusie van dit team | geen structurele doorgifte naar derde landen; een goedgekeurde uitzondering geldt als internationale doorgifte en wordt als zodanig geregistreerd | | | |
| RD-08 | Welke meldplichten en termijnen gelden bij een incident of datalek? | bepaalt het incidentproces | incidentprocedure | Open | zie `../security/incident-response.md` | | | |
| RD-09 | Is een DPIA verplicht voor de kernverwerking? | bepaalt of we mogen starten | bèta | Open | wij voeren er sowieso één uit | | | |
| RD-10 | Gelden er eisen aan uitbesteding en leveranciersbeheersing? | bepaalt contracten en toezicht | leveranciers | Open | DPA en risicobeoordeling als minimum | | | |
| RD-11 | Welke toegankelijkheidseisen zijn verplicht? | bepaalt het minimumniveau | UI | Open | wij hanteren WCAG 2.2 AA | | | |
| RD-12 | Zijn er eisen aan het bewaren en beschikbaar stellen van audit trails? | bepaalt logbewaartermijn | auditlog | Open | `[1–7 jaar]` als werkhypothese | | | |
| RD-13 | Gelden er regels voor communicatie over rendement, risico of kosten? | bepaalt teksten en weergave | UI-teksten | Open | geen beloften, geen advies | | | |
| RD-14 | Mag de testgroep met een niet-vergunde dienst werken? | bepaalt de testopzet | testgroepsessies | **Voorgelegd** | wij testen met synthetische data en zonder echte geldstromen | | | |
| RD-15 | Mag SolidYield worden gepresenteerd als product **zonder beleggingsrisico**, en mag "vast rendement" als belofte worden gebruikt? Een toegezegd vast rendement op een beleggingsproduct is een claim met eigen informatie- en zorgplichteisen. Hangt af van de constructie waarmee het rendement wordt gerealiseerd. | bepaalt propositie, doelgroepbenadering en zorgplicht | marketing, UI-teksten, onboarding | **Open** — geregistreerd 2026-08-03 | wij nemen géén standpunt in; zie risico V-1 en V-2 in [`../product/product-vision.md`](../product/product-vision.md) | | | |
| RD-16 | Welke constructie ligt onder het rendement, en welke rol nemen wij in die keten? | bepaalt RD-01, RD-15 en het volledige risicoprofiel | RD-01, RD-15, architectuur | **Deels beantwoord 2026-08-03** — de rol is bepaald (SolidYield belegt voor eigen rekening en risico, de gebruiker heeft een vordering op ons). Nog open: waarín wordt belegd, en welke kapitaalpositie draagt de terugbetalingsverplichting | het beleggingsbeleid en de kapitaalbuffer zijn nog niet vastgesteld | | | |
| RD-17 | Is de walletfunctie een **betaaldienst** in de zin van PSD2/Wft, of een hulpmiddel binnen het eigen product? | bepaalt of een vergunning of ontheffing voor betaaldiensten nodig is | onboarding, walletontwerp, RD-01 | **Open** — feiten aangevuld 2026-08-05 ([ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md)) | **Feiten:** de wallet ondersteunt uitsluitend storten, opnemen naar de eigen tegenrekening en vastzetten; **geen** P2P-betalingen en **geen** betalingen aan derden; zij bevat uitsluitend vrij beschikbaar saldo. **Voorlopige aanname van de Product Owner, geen besluit:** de wallet is een hulpmiddel binnen het eigen product en geen zelfstandige betaaldienst. Het team is niet bevoegd dit vast te stellen. Nog te bepalen ontwerpkeuze die hierop van invloed is: of terugbetaling van de inleg in de wallet landt of direct naar de tegenrekening gaat | | | |
| RD-18 | Kwalificeert de gebruiker als **belegger**, en is het product een effect, een beleggingsobject of een deelneming in een beleggingsinstelling? | bepaalt informatie-, prospectus- en zorgplichtverplichtingen, en het toezichtregime | propositie, UI-teksten, RD-01 | **Open** — geregistreerd 2026-08-03 | **Voorlopige aanname van de Product Owner, geen besluit:** de gebruiker is geen belegger, omdat hij geen beleggingskeuzes maakt, geen eigendomsrecht krijgt, geen variabel rendement ontvangt en geen investeringsrisico draagt. **Kanttekening van het team:** de vierde grond betreft *markt*risico; de gebruiker draagt wél debiteurenrisico op SolidYield. Het ontbreken van keuzevrijheid en variabel rendement sluit een kwalificatie als effect of beleggingsobject niet zonder meer uit. Vaststelling uitsluitend door een bevoegde specialist | | | |
| RD-19 | Welke kapitaal- of buffervereisten gelden, of zijn bedrijfsmatig nodig, om de terugbetalingsverplichting waar te maken bij tegenvallend beleggingsresultaat? | bepaalt of het product houdbaar is en of gebruikers hun inleg terugkrijgen | financieringsmodel, RD-01, elke geldstroom van echte gebruikers | **Open** — geregistreerd 2026-08-03 | nog niet doorgerekend; zie risico V-5 in [`../product/product-vision.md`](../product/product-vision.md) | | | |
| RD-20 | Biedt de toegepaste **administratieve vermogensscheiding** enige bescherming aan gebruikers bij faillissement van SolidYield, of is zij uitsluitend boekhoudkundig? | bepaalt wat wij gebruikers mogen voorspiegelen over de veiligheid van hun inleg | propositie, UI-teksten, contractvoorwaarden | **Open** — geregistreerd 2026-08-05 | wij nemen géén standpunt in. Administratieve scheiding is een boekhoudkundige maatregel; of daar goederenrechtelijke werking uit volgt is een juridische vraag. Zie risico A-2 in [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) | | | |
| RD-21 | Is de beoogde positie van de gebruiker als **concurrent schuldeiser** houdbaar, en welke informatieplicht geldt daarover richting consumenten, zzp'ers en rechtspersonen? | bepaalt de risicocommunicatie en raakt de zorgplicht | UI-teksten, contractvoorwaarden, onboarding | **Open** — geregistreerd 2026-08-05 | beoogde positie is concurrent schuldeiser; of dat juridisch zo uitpakt en hoe het moet worden gecommuniceerd is niet door dit team vast te stellen. Raakt PD-1: de gebruiker moet het risico kunnen benoemen | | | |
| RD-22 | Wat is de **definitieve regulatoire rolverdeling** tussen SolidYield en de betaalpartners (beoogd: Mollie voor iDEAL/SEPA, bunq voor IBAN, uitbetalingen en reconciliatie), en wat betekent die voor de vergunningpositie van SolidYield zelf? | bepaalt de ketenverantwoordelijkheid en mogelijk de vergunningplicht | contracten met betaalpartners, RD-01, RD-17, architectuur | **Open** — geregistreerd 2026-08-05 | de rolverdeling is een **voorkeursarchitectuur**, niet contractueel vastgelegd. Dit register doet geen uitspraak over de vergunningen of diensten van Mollie of bunq | | | |

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
