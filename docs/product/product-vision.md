# Productvisie

> **Status:** vastgesteld door de Product Owner op 2026-08-03 voor productnaam, doelgroep,
> probleem, productdoel (besluit 1) en het type financiële dienst (besluit 2), zie
> [`../../README.md`](../../README.md#10-openstaande-beslissingen-en-placeholders).
> Het **bedrijfs- en ketenmodel** is vastgesteld (besluit 4, 2026-08-05,
> [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md)). De
> **wettelijke grondslag** om dat model uit te voeren is dat **niet**: de gekozen
> productinrichting kan vergunningplichtig zijn, en de toepasselijke wettelijke grondslag
> wordt vastgesteld door Compliance (RD-23 t/m RD-27). Waarden die nog tussen `[ ]` staan
> zijn nog niet besloten.

## 1. Visiestatement

> Voor **Nederlandse particuliere spaarders die meer rendement zoeken dan traditioneel
> sparen, zonder de volatiliteit en complexiteit van beleggen**
> die **de keuze tussen laagrentend sparen en complex, risicovol beleggen** ervaart,
> is **SolidYield** een **digitaal contractueel rendementproduct**
> die **geld voor een vooraf gekozen looptijd laat renderen tegen een vooraf vastgesteld
> rendement, met continu digitaal inzicht**.
> Anders dan **een spaarrekening of een beleggingsrekening**
> biedt ons product **een vaste looptijd, een vooraf bekend rendement en heldere voorwaarden,
> zonder dat de gebruiker zelf keuzes over samenstelling of timing hoeft te maken**.

**Kernbelofte:** vast rendement. Heldere voorwaarden. Volledige controle.

> ⚠️ De kernbelofte bevat het woord *vast*. Of die belofte gedaan mag worden — en onder
> welke voorwaarden en risicowaarschuwingen — hangt af van de constructie achter het
> product en van het regulatoire regime. **Te valideren door een bevoegde specialist**
> vóór extern gebruik in marketing of productteksten. Zie §6 en risico V-2 in §9.

## 2. Probleem

| Vraag | Antwoord | Status |
|---|---|---|
| Welk probleem lossen we op? | Gebruikers moeten kiezen tussen twee onaantrekkelijke alternatieven: sparen met lage rente, of beleggen met volatiliteit, complexiteit en hoger risico. Een eenvoudige middenweg ontbreekt. | **besloten** |
| Voor wie is dit het meest urgent? | Particuliere spaarders in Nederland zonder financiële expertise, die wél rendement willen maar geen actieve beleggingsrol | **besloten** |
| Hoe lossen mensen het nu op? | `[HUIDIGE OPLOSSING]` — vermoeden: spaarrekening, deposito of niets doen; te toetsen in onderzoek | te bepalen |
| Waarom voldoet dat niet? | Lage rente; en bij alternatieven onvoldoende transparantie over kosten, voorwaarden, risico's en hoe het rendement tot stand komt | **besloten** |
| Welk bewijs hebben we? | `[ONDERZOEK / DATA / INTERVIEWS]` | **nog te verzamelen** |

> ⚠️ Zolang de laatste regel leeg is, is de visie een **aanname**. Plan onderzoek in
> ([`docs/research/test-group-plan.md`](../research/test-group-plan.md)) voordat er
> substantieel wordt gebouwd.

## 3. Belangrijkste productdoel

Een gebruiker uit de doelgroep kan binnen vijftien minuten zelfstandig een inleg afronden,
en kan daarna in eigen woorden correct benoemen welk bedrag er wanneer wordt uitgekeerd en
welk risico eraan verbonden is.

Uitwerking en meetwaarden: [`product-goals.md`](product-goals.md).

> Het doel is bewust in twee helften geknipt. De eerste helft meet of het product
> **werkt**; de tweede of het **eerlijk** is. Een gebruiker die vlot een inleg afrondt maar
> achteraf niet kan benoemen welk risico daaraan vastzit, telt niet als succes — dat is
> principe 5 ("nooit misleidend") in meetbare vorm.

## 4. Doelgroep

* **Primair:** particuliere spaarders in Nederland die ontevreden zijn over lage
  spaarrentes, meer rendement zoeken maar geen beleggingsrisico willen, weinig tijd,
  kennis of interesse hebben om zelf te beleggen, en waarde hechten aan vaste looptijden,
  duidelijke voorwaarden en digitaal inzicht.
* **Secundair:** ondernemers en zzp'ers met tijdelijk overtollige liquiditeit die hun
  financiële buffer voor een vaste periode willen laten renderen.
* Expliciet **niet** onze doelgroep (nu): `[BUITEN DOELGROEP]` — te bepalen bij de
  MVP-afbakening; kandidaten zijn actieve beleggers, gebruikers buiten Nederland en
  professionele partijen.
* Kwetsbare gebruikers waar we extra rekening mee houden: mensen zonder financiële
  expertise — per definitie de kern van onze doelgroep — laaggeletterden, mensen met een
  beperking, en mensen die geld inleggen dat zij op korte termijn nodig hebben.

> ⚠️ **Spanning in de doelgroepdefinitie.** De primaire doelgroep is gedefinieerd als
> mensen die *geen beleggingsrisico willen*. Met de constructie van 2026-08-03 (§6) klopt
> dat voor **marktrisico**: de gebruiker maakt geen beleggingskeuzes en het rendement
> beweegt niet mee met de markt. Maar het risico is niet verdwenen, het is **verplaatst**:
> de gebruiker heeft een vordering op SolidYield en draagt daarmee **debiteurenrisico**.
> Kan SolidYield niet terugbetalen, dan raakt de gebruiker zijn inleg alsnog kwijt.
>
> Wij werven dus een doelgroep die "geen risico" zoekt, op een product dat een ander soort
> risico kent. Dat is geen marketingdetail maar een zorgplichtvraag, en het raakt principe
> 5. Communiceren wij alleen "geen beleggingsrisico", dan is de voorstelling onvolledig.
> Zie risico V-1 en V-5 in §9.

**Doelgroep van de MVP** (vastgesteld 2026-08-05): Nederlandse **consumenten**, **zzp'ers**
en **rechtspersonen**. De start is uitsluitend een **besloten testgroep**, met
sandboxbetalingen en synthetische data; er wordt niet breder gelanceerd zolang de
wettelijke grondslag niet is bevestigd (RD-23 t/m RD-27).

> Let op: rechtspersonen zijn hiermee toegevoegd aan de MVP-doelgroep, terwijl besluit 1
> alleen particulieren (primair) en ondernemers en zzp'ers (secundair) noemde. Dat is een
> verbreding. Zij brengt een andere onboarding, andere verificatie (RD-05) en mogelijk
> andere informatieverplichtingen mee dan bij consumenten.

Persona's: [`personas.md`](personas.md).

## 5. Waardepropositie

| Voor de gebruiker | Voor de organisatie |
|---|---|
| Vooraf bekend rendement en einddatum — geen dagelijkse keuzes, geen markt volgen | Voorspelbare inleg met bekende looptijden |
| Eén beslissing: bedrag en looptijd | Eenvoudig productaanbod, beperkte variantenlast |
| Continu digitaal inzicht in rendement, einddatum en verwachte uitkering | Minder supportvragen doordat verwachtingen vooraf helder zijn |
| Heldere voorwaarden zonder verborgen kosten | Vertrouwen als onderscheidend vermogen in een markt met lage transparantie |

## 6. Marktafbakening en regio

| Onderwerp | Waarde | Consequentie |
|---|---|---|
| Landen/regio's | **Nederland** — enige markt in de eerste fase (besluit 3) | bepaalt toezichthouder, taal en dataresidency |
| Talen | Nederlands | bepaalt contentwerk en toegankelijkheid |
| Valuta | EUR | bepaalt afronding, weergave en boekhoudlogica |
| Distributiekanaal | `[WEB / IOS / ANDROID / API]` | bepaalt tech en teststrategie |
| Dataresidency | opslag en reguliere verwerking binnen de **EER**, primaire productieomgeving fysiek in **Nederland** ([ADR-0006](../architecture/adr/0006-dataresidency-en-opslaglocatie.md)) | beperkt de providerkeuze in ADR-0003; toegang vanuit derde landen standaard uitgesloten |
| Type financiële dienst | **digitaal contractueel rendementproduct** (vastgesteld 2026-08-03) | het bedrijfsmodel is besloten (besluit 4); de **wettelijke grondslag** voor uitvoering wordt afzonderlijk vastgesteld |

### Hoe het product werkt

Vastgesteld door de Product Owner op 2026-08-03, als **feitelijke beschrijving**:

1. De gebruiker brengt een bedrag vanuit de digitale wallet onder in het product, voor een
   vooraf gekozen looptijd.
2. Gedurende de looptijd ontvangt de gebruiker een vooraf overeengekomen **maandelijks
   rendement**.
3. Na afloop van de looptijd wordt de **oorspronkelijke inleg volledig terugbetaald**.
4. Gedurende de looptijd beheert en investeert SolidYield het bedrag **voor eigen rekening
   en risico**.
5. De wallet is een hulpmiddel binnen het product, geen zelfstandige dienst.

**Productparameters** (vastgesteld 2026-08-05, zie
[ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) en
[ADR-0008](../architecture/adr/0008-geld-en-contractstroom.md)):

| Onderwerp | Waarde |
|---|---|
| Looptijden | 3, 6, 12, 24, 36 en 60 maanden |
| Minimum inleg | € 50 |
| Maximum inleg | geen vastgesteld maximum |
| Rendement | **vast rendement**, maandelijks uitgekeerd |
| Terugbetaling | volledige inleg aan het einde van de looptijd |
| Wallet | storten, opnemen naar de eigen tegenrekening, vastzetten — **geen** P2P-betalingen, **geen** betalingen aan derden |
| Wat de gebruiker krijgt | uitsluitend een **contractuele vordering op SolidYield** — geen aandelen, obligaties, participaties of eigendom van onderliggende beleggingen |
| Zeggenschap over investeringen | geen; SolidYield bepaalt zelfstandig waarin wordt geïnvesteerd, categorieën blijven functioneel breed |
| Vermogensscheiding | **administratief** |
| Positie bij faillissement | **beoogd:** concurrent schuldeiser |
| Betaalpartners | **vergunninghoudende betaalpartners:** Mollie (iDEAL/SEPA) en bunq (IBAN, uitbetalingen, reconciliatie) — betaalpartner, **geen productuitgever** |
| KYC/AML | fase 1 bij SolidYield zelf; fase 2 via een gespecialiseerde externe partner — **roadmap, geen huidige implementatie** |

> ⚠️ **Administratieve vermogensscheiding is boekhoudkundig.** Of zij bescherming biedt bij
> faillissement is een juridische vraag (RD-20), en de beoogde positie "concurrent
> schuldeiser" gaat er juist van uit dat die bescherming er niet is. Beide staan hier als
> beoogde inrichting, niet als vastgesteld rechtsgevolg. De term mag niet richting
> gebruikers worden gebruikt als geruststelling — zie risico A-2 in ADR-0007.

> **Te valideren door een bevoegde specialist.** De beschrijving hierboven is wat het
> product *doet*; zij zegt niets over hoe het product juridisch *kwalificeert*. Punt 3 en 4
> samen betekenen een onvoorwaardelijke terugbetalingsverplichting: SolidYield moet de
> inleg terugbetalen ongeacht het resultaat van de eigen investeringen. Dat raakt in
> Nederland rechtstreeks aan het verbod op het aantrekken van opvorderbare gelden van het
> publiek (Wft art. 3:5), en mogelijk aan prospectus- en informatieverplichtingen. Of een
> vergunning, registratie of vrijstelling van toepassing is, is **geen conclusie die dit
> team neemt**. Registratie van vraag en antwoord:
> [`../compliance/regulatory-decisions.md`](../compliance/regulatory-decisions.md)
> (RD-01, RD-17, RD-18).
>
> Dit blokkeert onderzoek en ontwerp niet, maar wel elke externe propositie, elke
> geldstroom van echte gebruikers en elke uitspraak over rendement.

## 7. Principes

1. **Begrijpelijk boven volledig.** Financiële informatie die niet begrepen wordt, is
   geen waarde maar een risico.
2. **Veilig boven snel.** Geen enkele lancering slaat essentiële beveiligings-, privacy-
   of controlemaatregelen over.
3. **Minimaal boven maximaal.** We verzamelen zo min mogelijk gegevens.
4. **Bewijs boven mening.** Elke belangrijke aanname wordt getoetst bij echte gebruikers.
5. **Nooit misleidend.** Geen dark patterns, verborgen kosten of misleidende weergave van
   bedragen, rendementen of risico's.
6. **Toegankelijk voor iedereen.** WCAG 2.2 AA als ondergrens, taalniveau B1 als streven.

## 8. Wat we bewust (nog) niet doen

* Geen variabele of marktafhankelijke rendementen — één productvorm, één vast rendement,
  één vaste looptijd.
* Geen keuzes over samenstelling, spreiding of timing bij de gebruiker leggen.
* Geen uitbreiding buiten Nederland vóór het regulatoire regime in de eerste markt
  vaststaat. Internationale uitbreiding valt buiten de MVP; per nieuw land volgt vooraf
  een afzonderlijke beoordeling op wet- en regelgeving, fiscaliteit,
  consumentenbescherming, operationele inrichting en productgeschiktheid.
* `[NIET-DOEL 4]` — aan te vullen bij de MVP-afbakening ([`mvp-scope.md`](mvp-scope.md)).

## 9. Aannames en risico's op visieniveau

| # | Aanname | Hoe toetsen we dit? | Sprint |
|---|---|---|---|
| A1 | De doelgroep ervaart de keuze tussen laagrentend sparen en complex beleggen als urgent probleem | interviews met 8–12 deelnemers | 1–2 |
| A2 | Gebruikers willen geld voor een vaste periode vastzetten en die inleg niet tussentijds opnemen | prototype-usabilitytest | 2–3 |
| A3 | Gebruikers vertrouwen ons met financiële gegevens én met hun inleg | vertrouwensvragen in interviews | 1–3 |
| A4 | Wij mogen dit product in Nederland aanbieden | **juridisch advies inwinnen** — RD-01 | z.s.m. |
| A5 | Gebruikers begrijpen na het lezen van onze voorwaarden de werkelijke risicopositie | begripstoets in usabilitytest | 2–3 |

| # | Risico op visieniveau | Impact |
|---|---|---|
| V-1 | De doelgroep is geworven op "geen beleggingsrisico". Met de constructie van 2026-08-03 klopt dat voor *markt*risico, maar de gebruiker draagt wél **debiteurenrisico op SolidYield**: de terugbetaling van de inleg hangt af van onze solvabiliteit, niet van de markt. Communiceren wij alleen het eerste, dan is de voorstelling onvolledig | zorgplicht- en toezichtrisico; raakt principe 5. Beslispunt vóór elke externe propositie |
| V-2 | De kernbelofte "vast rendement" kan een garantiesuggestie wekken die niet waargemaakt kan worden; een toegezegd vast rendement kent bovendien eigen informatieverplichtingen | herformulering van de belofte kan nodig zijn na juridisch advies |
| V-3 | ~~Het productdoel is outputgericht geformuleerd en stuurt op opleveren in plaats van op gebruikersuitkomst~~ | **vervallen 2026-08-03** — PD-1 is uitkomstgericht geherformuleerd |
| V-4 | De begripstoets in PD-1 eist dat de gebruiker het risico kan benoemen. Sinds 2026-08-03 is bekend welk risico dat is — debiteurenrisico op SolidYield — maar niet hoe groot het is; dat hangt aan onze kapitaalpositie (RD-16) | PD-1 is meetbaar zodra de risicotekst vaststaat; de omvang van het risico blijft open |
| V-5 | Het businessmodel draagt het volledige markt- en kredietrisico op de eigen balans: wij beloven een vast maandelijks rendement plus volledige terugbetaling, terwijl het beleggingsresultaat variabel is. Bij tegenvallend resultaat moet het verschil uit eigen vermogen komen | solvabiliteitsrisico; bepaalt kapitaalbehoefte, en daarmee of het product überhaupt houdbaar is. Vóór elke geldstroom van echte gebruikers door te rekenen |

## 10. Herziening

Deze visie wordt herzien: bij elke Sprint Review met nieuwe inzichten, minimaal elk
kwartaal, en direct wanneer onderzoek een kernaanname weerlegt.

| Datum | Wijziging | Door |
|---|---|---|
| 2026-08-03 | eerste versie — productnaam, doelgroep, probleem en productdoel vastgesteld; type dienst en regulatoir regime expliciet opengelaten | Product Owner |
| 2026-08-03 | §3 productdoel uitkomstgericht geherformuleerd; risico V-3 vervallen, V-4 toegevoegd | Product Owner |
| 2026-08-03 | type dienst vastgesteld als digitaal contractueel rendementproduct; werking beschreven in §6; V-1 aangescherpt en V-5 toegevoegd. Juridische kwalificaties uit het besluit zijn als voorlopige aanname in het register gezet, niet als vastgesteld feit | Product Owner |
| 2026-08-03 | besluit 3: markt en dataresidency vastgelegd (EER, primair Nederland) in ADR-0006; §6 en §8 aangevuld | Product Owner + Compliance |
| 2026-08-05 | productparameters, walletrol, contractstroom en MVP-doelgroep vastgelegd in ADR-0007 en ADR-0008 | Product Owner |
| 2026-08-05 | **besluit 4 genomen**: bedrijfs- en ketenmodel vastgesteld. De wettelijke grondslag om dat model uit te voeren staat nog open (RD-23 t/m RD-27) en is bewust gescheiden van het model zelf | Product Owner |
