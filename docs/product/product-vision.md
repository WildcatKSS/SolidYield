# Productvisie

> **Status:** vastgesteld door de Product Owner op 2026-08-03 voor productnaam, doelgroep,
> probleem en productdoel (besluit 1 in
> [`../../README.md`](../../README.md#10-openstaande-beslissingen-en-placeholders)).
> Waarden die nog tussen `[ ]` staan zijn **nog niet besloten** — met name het type
> financiële dienst en het regulatoire regime.

## 1. Visiestatement

> Voor **Nederlandse particuliere spaarders die meer rendement zoeken dan traditioneel
> sparen, zonder de volatiliteit en complexiteit van beleggen**
> die **de keuze tussen laagrentend sparen en complex, risicovol beleggen** ervaart,
> is **SolidYield** een **[TYPE FINANCIËLE DIENST — nog niet vastgesteld, zie §6]**
> die **geld voor een vooraf gekozen looptijd laat renderen tegen een vooraf vastgestelde
> rente, met continu digitaal inzicht**.
> Anders dan **een spaarrekening of een beleggingsrekening**
> biedt ons product **een vaste looptijd, een vooraf bekende rente en heldere voorwaarden,
> zonder dat de gebruiker zelf keuzes over samenstelling of timing hoeft te maken**.

**Kernbelofte:** vaste rente. Heldere voorwaarden. Volledige controle.

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

Een betrouwbare digitale omgeving realiseren waarin een Nederlandse particuliere of
zakelijke gebruiker zelfstandig een account kan openen, identificatie kan doorlopen, geld
kan storten, een bedrag en looptijd kan kiezen, en continu inzicht heeft in de afgesproken
rente, de einddatum en de verwachte uitkering.

Uitwerking en meetwaarden: [`product-goals.md`](product-goals.md).

> Dit doel is in deze vorm deels **outputgericht** (een omgeving realiseren) in plaats van
> gericht op gebruikersgedrag of -uitkomst. Het is als PD-1 overgenomen om de richting vast
> te leggen; de meetbare herformulering staat in
> [`product-goals.md`](product-goals.md) en wordt bij de eerste Sprint Review
> aangescherpt. Zie risico V-3 in §9.

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
> mensen die *geen beleggingsrisico willen*. Of SolidYield een product zonder
> kapitaalrisico kán zijn, hangt volledig af van de nog te kiezen constructie (§6). Kent
> die constructie wél kapitaalrisico, dan werven wij een doelgroep op een eigenschap die
> het product niet heeft. Dat is geen marketingdetail maar een zorgplichtvraag, en het
> raakt principe 5. Zie risico V-1 in §9.

Persona's: [`personas.md`](personas.md).

## 5. Waardepropositie

| Voor de gebruiker | Voor de organisatie |
|---|---|
| Vooraf bekende rente en einddatum — geen dagelijkse keuzes, geen markt volgen | Voorspelbare inleg met bekende looptijden |
| Eén beslissing: bedrag en looptijd | Eenvoudig productaanbod, beperkte variantenlast |
| Continu digitaal inzicht in rente, einddatum en verwachte uitkering | Minder supportvragen doordat verwachtingen vooraf helder zijn |
| Heldere voorwaarden zonder verborgen kosten | Vertrouwen als onderscheidend vermogen in een markt met lage transparantie |

## 6. Marktafbakening en regio

| Onderwerp | Waarde | Consequentie |
|---|---|---|
| Landen/regio's | **Nederland** (eerste markt) | bepaalt toezichthouder, taal en dataresidency |
| Talen | Nederlands | bepaalt contentwerk en toegankelijkheid |
| Valuta | EUR | bepaalt afronding, weergave en boekhoudlogica |
| Distributiekanaal | `[WEB / IOS / ANDROID / API]` | bepaalt tech en teststrategie |
| Type financiële dienst | **`[TYPE DIENST]` — nog niet vastgesteld** | **bepaalt het regulatoire regime** |

> **Te valideren door een bevoegde specialist.** Het aantrekken van gelden van het publiek
> die op een afgesproken moment moeten worden terugbetaald, tegen een vooraf vastgestelde
> vergoeding, raakt in Nederland aan het verbod op het aantrekken van opvorderbare gelden
> (Wft art. 3:5) en mogelijk aan prospectus- en informatieverplichtingen. Welk regime van
> toepassing is, en of een vergunning, registratie of ontheffing nodig is, is **geen
> conclusie die dit team neemt**. Registratie van vraag en antwoord:
> [`../compliance/regulatory-decisions.md`](../compliance/regulatory-decisions.md) (RD-01).
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

* Geen variabele of marktafhankelijke rendementen — één productvorm, vaste rente, vaste
  looptijd.
* Geen keuzes over samenstelling, spreiding of timing bij de gebruiker leggen.
* Geen uitbreiding buiten Nederland vóór het regulatoire regime in de eerste markt
  vaststaat.
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
| V-1 | De doelgroep is geworven op "geen beleggingsrisico", terwijl de constructie mogelijk wél kapitaalrisico kent | zorgplicht- en toezichtrisico; raakt principe 5. Beslispunt vóór elke externe propositie |
| V-2 | De kernbelofte "vaste rente" kan een garantiesuggestie wekken die niet waargemaakt kan worden | herformulering van de belofte kan nodig zijn na juridisch advies |
| V-3 | Het productdoel is outputgericht geformuleerd en stuurt op opleveren in plaats van op gebruikersuitkomst | risico op bouwen zonder validatie; herformulering bij eerste Sprint Review |

## 10. Herziening

Deze visie wordt herzien: bij elke Sprint Review met nieuwe inzichten, minimaal elk
kwartaal, en direct wanneer onderzoek een kernaanname weerlegt.

| Datum | Wijziging | Door |
|---|---|---|
| 2026-08-03 | eerste versie — productnaam, doelgroep, probleem en productdoel vastgesteld; type dienst en regulatoir regime expliciet opengelaten | Product Owner |
