# ADR-0007: Vergunningplicht en rol in de keten

* **Status:** **Voorgesteld** — wacht op validatie door Compliance en een gespecialiseerde
  financieel-regulatoire jurist
* **Datum:** 2026-08-05
* **Beslissers:** Product Owner (productinrichting), Compliance (regulatoire kwalificatie —
  **nog niet gegeven**)
* **Geraadpleegd:** Tech lead, Privacy, Security

> [!IMPORTANT]
> Deze ADR legt vast **hoe het product is ingericht** en **welke rol elke partij beoogt te
> spelen**. Zij stelt **niet** vast of SolidYield vergunningplichtig is, onder welk
> regulatoir regime de dienst valt, of hoe het product juridisch kwalificeert. Die vragen
> staan open in [`../../compliance/regulatory-decisions.md`](../../compliance/regulatory-decisions.md)
> en worden beantwoord door Compliance samen met een gespecialiseerde jurist.
>
> **Besluit 4 in [`../../../README.md`](../../../README.md#10-openstaande-beslissingen-en-placeholders)
> blijft daarmee open.** Wat hier is vastgesteld, is de feitelijke basis waarop die
> beoordeling kan plaatsvinden — niet de uitkomst ervan.

## Doel

Eén samenhangende, feitelijke beschrijving geven van de geldstroom, de contractstroom en de
rolverdeling tussen SolidYield en de beoogde betaalpartners, zodat Compliance en de jurist
de vergunningvraag kunnen beoordelen op basis van wat het product werkelijk doet — in
plaats van op losse aannames.

Zonder zo'n beschrijving wordt de regulatoire vraag telkens opnieuw gesteld met andere
uitgangspunten, en is elk antwoord onbruikbaar.

## Context

Uit eerdere besluiten ligt vast:

* Het product is een **digitaal contractueel rendementproduct** (besluit 2).
* Markt Nederland, taal Nederlands, valuta EUR; opslag en reguliere verwerking binnen de
  EER, primaire productieomgeving in Nederland (besluit 3, [ADR-0006](0006-dataresidency-en-opslaglocatie.md)).
* De onvoorwaardelijke terugbetalingsverplichting raakt aan het verbod op het aantrekken
  van opvorderbare gelden van het publiek (RD-01) — **open**.

Nieuw vastgesteld door de Product Owner (2026-08-05) is de inrichting hieronder. De
geldstroom loopt via externe betaalpartners; dat maakt de rolverdeling in de keten zelf een
regulatoire vraag, náást de vraag over het product.

## Geldstroom

De gebruiker heeft **twee** geldposities die scherp gescheiden zijn:

| Positie | Kenmerk | Beschikbaarheid |
|---|---|---|
| **Vrij saldo in de wallet** | staat op naam van de gebruiker in de walletadministratie | altijd opneembaar |
| **Vastgezet bedrag** | is uit de wallet verdwenen en omgezet in een contractuele vordering | niet opneembaar vóór einde looptijd |

Stappen:

1. Gebruiker stort geld via iDEAL of SEPA. Het bedrag verschijnt als **vrij saldo** in de
   wallet.
2. Vrij saldo kan de gebruiker op elk moment weer opnemen naar de eigen tegenrekening.
3. Bij **vastzetten** verdwijnt het bedrag uit de wallet en ontstaat een digitaal contract.
4. SolidYield investeert het vastgezette bedrag **voor eigen rekening en risico**.
5. Gedurende de looptijd keert SolidYield maandelijks een **vast rendement** uit.
6. Aan het einde van de looptijd wordt de **volledige inleg** contractueel terugbetaald.

Uitgewerkt met sequencediagrammen in [ADR-0008](0008-geld-en-contractstroom.md).

## Contractstroom

* De gebruiker sluit een contract met **SolidYield**, niet met een derde partij.
* De gebruiker verkrijgt **uitsluitend een contractuele vordering op SolidYield**.
* De gebruiker ontvangt **geen** aandelen, obligaties, participaties of eigendom van
  onderliggende beleggingen.
* De gebruiker heeft **geen zeggenschap** over de investeringen.
* SolidYield bepaalt **zelfstandig** waarin wordt geïnvesteerd; de
  investeringscategorieën blijven functioneel breed.
* Er wordt **administratieve vermogensscheiding** toegepast.
* **Beoogde positie van de gebruiker bij faillissement: concurrent schuldeiser.**

> ⚠️ De laatste twee punten horen bij elkaar en verdienen aandacht in de beoordeling.
> Administratieve vermogensscheiding is een **boekhoudkundige** maatregel; of zij ook
> goederenrechtelijke bescherming biedt bij faillissement is een juridische vraag, geen
> administratieve. De beoogde positie "concurrent schuldeiser" gaat er juist van uit dat die
> bescherming er **niet** is. Beide staan hier als beoogde inrichting, **niet** als
> vastgesteld rechtsgevolg. Zie RD-20 en RD-21.

## Walletrol

| Wel | Niet |
|---|---|
| storten (iDEAL, SEPA) | P2P-betalingen tussen gebruikers |
| opnemen naar eigen tegenrekening | betalingen aan derden |
| vastzetten (omzetten in een contract) | betaalrekeningfunctionaliteit voor algemeen betalingsverkeer |

De wallet bevat **uitsluitend vrij beschikbaar saldo**. Zij is een hulpmiddel binnen het
eigen product en geen zelfstandig aangeboden dienst.

> Dat is de **inrichting**. Of die inrichting betekent dat de wallet buiten het bereik van
> betaaldienstregelgeving valt, is een juridische vraag die openstaat in **RD-17**. Het
> ontbreken van P2P- en derdenbetalingen is een relevant feit voor die beoordeling, geen
> conclusie erover.

## Rol van SolidYield

| Rol | Toelichting |
|---|---|
| Contractspartij | de gebruiker sluit het contract met SolidYield |
| Schuldenaar | SolidYield is de partij die rendement uitkeert en de inleg terugbetaalt |
| Investeerder voor eigen rekening en risico | SolidYield draagt het beleggingsresultaat |
| Beheerder van de walletadministratie | vrij saldo per gebruiker, met administratieve vermogensscheiding |
| Verantwoordelijke voor KYC/AML in fase 1 | zie *Afhankelijkheden* |

## Rol van Mollie *(beoogd)*

| Beoogde taak | Toelichting |
|---|---|
| iDEAL-betalingen | initiëren en afhandelen van stortingen |
| SEPA-betalingen | incasso en overboeking waar van toepassing |
| Reconciliatie-informatie | koppelen van binnenkomende betalingen aan gebruikers |

## Rol van bunq *(beoogd)*

| Beoogde taak | Toelichting |
|---|---|
| IBAN-functionaliteit | rekeningstructuur waarop gelden binnenkomen en vanaf worden uitbetaald |
| Uitbetalingen | rendementuitkeringen en terugbetaling van de inleg |
| Reconciliatie | aansluiting tussen bankmutaties en de eigen administratie |

> ⚠️ **De rolverdeling met de betaalpartners is nog niet definitief** en is hier
> beschreven als voorkeursarchitectuur, niet als gesloten afspraak. Wie in de keten welke
> regulatoire rol vervult — en wat dat betekent voor de vergunningpositie van SolidYield
> zelf — is een open vraag (RD-22). Deze ADR doet geen uitspraak over de vergunningen,
> registraties of diensten van Mollie of bunq; dat is per partij contractueel en
> regulatoir vast te stellen.

## Open compliancevragen

Deze ADR **beantwoordt geen** van onderstaande vragen. Zij staan in
[`../../compliance/regulatory-decisions.md`](../../compliance/regulatory-decisions.md):

| Vraag | Register |
|---|---|
| Juridische kwalificatie van het product | RD-18 |
| Vergunningplicht en mogelijke vrijstellingen | RD-01 |
| Toepasselijk regulatoir regime | RD-01, RD-18 |
| Is de walletfunctie een betaaldienst? | RD-17 |
| Definitieve rolverdeling met betaalpartners | RD-22 |
| Werking van administratieve vermogensscheiding bij faillissement | RD-20 |
| Houdbaarheid van de beoogde positie "concurrent schuldeiser" en de informatieplicht daarover | RD-21 |
| Identificatie- en verificatieverplichtingen (KYC/AML) | RD-05 |
| Kapitaal- of buffervereisten voor de terugbetalingsverplichting | RD-19 |

## Risico's

| # | Risico | Gevolg |
|---|---|---|
| A-1 | De vergunningvraag wordt beantwoord ná het bouwen van wallet en contractmodule | herbouw of stopzetting; RD-01 blokkeert elke geldstroom van echte gebruikers |
| A-2 | "Administratieve vermogensscheiding" wordt intern of extern gelezen als bescherming van gebruikersgeld bij faillissement | onterecht vertrouwen bij gebruikers; raakt principe 5 en de zorgplicht |
| A-3 | De beoogde positie "concurrent schuldeiser" wordt niet begrijpelijk gecommuniceerd | de gebruiker kan het werkelijke risico niet benoemen — PD-1 wordt niet gehaald |
| A-4 | De rolverdeling met betaalpartners verschuift bij contractonderhandeling | de regulatoire beoordeling moet opnieuw; architectuur kan wijzigen |
| A-5 | Geen vastgesteld maximum op de inleg, terwijl drempelbedragen relevant kunnen zijn voor een eventuele vrijstelling | een inleg kan onbedoeld in een ander regime vallen; te betrekken bij RD-01 |
| A-6 | KYC/AML in fase 1 bij SolidYield zelf, zonder gespecialiseerde partner | uitvoeringsrisico en aantoonbaarheidsrisico; zie RD-05 |

## Afhankelijkheden

| # | Afhankelijkheid | Status |
|---|---|---|
| D-1 | Validatie van RD-01, RD-17, RD-18 en RD-22 door Compliance en een gespecialiseerde jurist | **open — blokkerend voor lancering** |
| D-2 | Contractuele afspraken met Mollie en bunq, inclusief regulatoire rolverdeling | nog niet gesloten |
| D-3 | KYC/AML — **fase 1:** SolidYield is verantwoordelijk. **Fase 2 (roadmap, geen huidige implementatie):** integratie via een gespecialiseerde externe partner binnen het onboardingproces | fase 2 is een roadmapbesluit |
| D-4 | Kapitaalpositie die de terugbetalingsverplichting draagt (RD-19) | niet doorgerekend |
| D-5 | Keuze van cloudprovider binnen de residency-eis ([ADR-0006](0006-dataresidency-en-opslaglocatie.md)) | ADR-0003 open |
| D-6 | Besloten testgroep; er wordt niet breder gelanceerd zolang D-1 openstaat | zie [`../../research/test-group-plan.md`](../../research/test-group-plan.md) en RD-14 |

## Definition of Done voor deze ADR

Deze ADR gaat pas van *Voorgesteld* naar *Geaccepteerd* wanneer **alle** onderstaande
punten zijn afgevinkt:

- [ ] Compliance heeft de feitelijke beschrijving in deze ADR bevestigd als volledig en
      juist.
- [ ] Een gespecialiseerde financieel-regulatoire jurist heeft schriftelijk geantwoord op
      RD-01, RD-17 en RD-18; het antwoord is vastgelegd met naam, datum en reikwijdte.
- [ ] De definitieve rolverdeling met Mollie en bunq is contractueel vastgelegd en
      regulatoir beoordeeld (RD-22).
- [ ] De werking van de administratieve vermogensscheiding bij faillissement is beoordeeld
      (RD-20), en de uitkomst is verwerkt in de gebruikerscommunicatie.
- [ ] De informatie over de positie als concurrent schuldeiser is getoetst bij de
      testgroep: gebruikers kunnen die positie in eigen woorden benoemen (PD-1, RD-21).
- [ ] RD-19 is doorgerekend: er is een onderbouwde kapitaalpositie voor de
      terugbetalingsverplichting.
- [ ] Het threat model en de DPIA zijn bijgewerkt op de vastgestelde geld- en
      contractstroom.

Zolang één punt openstaat: **geen externe propositie, geen geldstroom van echte
gebruikers, geen lancering buiten de besloten testgroep.**

## Gerelateerde besluiten

* Bouwt voort op: [ADR-0006](0006-dataresidency-en-opslaglocatie.md)
* Werkt uit in: [ADR-0008](0008-geld-en-contractstroom.md)
* Randvoorwaarde voor: `ADR-0003` (cloudprovider), `ADR-0004` (identiteitsprovider)
* Registervragen: `RD-01`, `RD-05`, `RD-14`, `RD-17` t/m `RD-22`

## Herzieningsmoment

Bij elk antwoord op RD-01, RD-17, RD-18 of RD-22; bij wijziging van betaalpartner of
rolverdeling; en bij uitbreiding van de doelgroep buiten de besloten testgroep.
