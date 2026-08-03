# Productvisie

> **Status:** concept. Alle waarden tussen `[ ]` zijn **nog niet besloten**. Vul ze in
> tijdens de eerste productworkshop en laat de uitkomst bevestigen door de Product Owner.

## 1. Visiestatement

> Voor **[DOELGROEP]**
> die **[PROBLEEM]** ervaart,
> is **[PRODUCTNAAM]** een **[TYPE FINANCIËLE DIENST: budgetteren / betalen / lenen / investeren / financieel inzicht]**
> die **[BELANGRIJKSTE VOORDEEL]**.
> Anders dan **[BESTAAND ALTERNATIEF]**
> biedt ons product **[ONDERSCHEIDEND VERMOGEN]**.

## 2. Probleem

| Vraag | Antwoord | Status |
|---|---|---|
| Welk probleem lossen we op? | `[PROBLEEM]` | te bepalen |
| Voor wie is dit het meest urgent? | `[DOELGROEP]` | te bepalen |
| Hoe lossen mensen het nu op? | `[HUIDIGE OPLOSSING]` | te bepalen |
| Waarom voldoet dat niet? | `[TEKORTKOMING]` | te bepalen |
| Welk bewijs hebben we? | `[ONDERZOEK / DATA / INTERVIEWS]` | **nog te verzamelen** |

> ⚠️ Zolang de laatste regel leeg is, is de visie een **aanname**. Plan onderzoek in
> ([`docs/research/test-group-plan.md`](../research/test-group-plan.md)) voordat er
> substantieel wordt gebouwd.

## 3. Belangrijkste productdoel

`[PRODUCTDOEL]` — één zin, meetbaar, gericht op gebruikersgedrag of -uitkomst, niet op
output. Uitwerking en meetwaarden: [`product-goals.md`](product-goals.md).

## 4. Doelgroep

* Primair: `[DOELGROEP]`
* Secundair: `[SECUNDAIRE DOELGROEP]`
* Expliciet **niet** onze doelgroep (nu): `[BUITEN DOELGROEP]`
* Kwetsbare gebruikers waar we extra rekening mee houden: `[BIJV. MENSEN MET
  BETALINGSACHTERSTANDEN, LAAGGELETTERDEN, MENSEN MET EEN BEPERKING]`

Persona's: [`personas.md`](personas.md).

## 5. Waardepropositie

| Voor de gebruiker | Voor de organisatie |
|---|---|
| `[WAARDE 1]` | `[WAARDE 1]` |
| `[WAARDE 2]` | `[WAARDE 2]` |
| `[WAARDE 3]` | `[WAARDE 3]` |

## 6. Marktafbakening en regio

| Onderwerp | Waarde | Consequentie |
|---|---|---|
| Landen/regio's | `[LANDEN/REGIO]` | bepaalt toezichthouder, taal en dataresidency |
| Talen | `[TALEN]` | bepaalt contentwerk en toegankelijkheid |
| Valuta | `[VALUTA]` | bepaalt afronding, weergave en boekhoudlogica |
| Distributiekanaal | `[WEB / IOS / ANDROID / API]` | bepaalt tech en teststrategie |

> **Te valideren door een bevoegde specialist:** welk regulatoir regime van toepassing is
> op `[TYPE FINANCIËLE DIENST]` in `[LANDEN/REGIO]`, en of een vergunning of ontheffing
> nodig is. Registratie: [`../compliance/regulatory-decisions.md`](../compliance/regulatory-decisions.md).

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

* `[NIET-DOEL 1]`
* `[NIET-DOEL 2]`
* `[NIET-DOEL 3]`

## 9. Aannames en risico's op visieniveau

| # | Aanname | Hoe toetsen we dit? | Sprint |
|---|---|---|---|
| A1 | `[DOELGROEP]` ervaart `[PROBLEEM]` als urgent | interviews met 8–12 deelnemers | 1–2 |
| A2 | Gebruikers willen hiervoor `[ACTIE]` doen | prototype-usabilitytest | 2–3 |
| A3 | Gebruikers vertrouwen ons met financiële gegevens | vertrouwensvragen in interviews | 1–3 |
| A4 | `[TYPE DIENST]` mag door ons worden aangeboden | **juridisch advies inwinnen** | z.s.m. |

## 10. Herziening

Deze visie wordt herzien: bij elke Sprint Review met nieuwe inzichten, minimaal elk
kwartaal, en direct wanneer onderzoek een kernaanname weerlegt.

| Datum | Wijziging | Door |
|---|---|---|
| `[JJJJ-MM-DD]` | eerste versie | `[NAAM]` |
