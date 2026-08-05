# ADR-0007: Vergunningplicht en rol in de keten

* **Status:** **Geaccepteerd voor de bedrijfs- en keteninrichting — wettelijke grondslag
  en juridische uitvoerbaarheid nog te valideren** (besluit 4, 2026-08-05).
* **Datum:** 2026-08-05
* **Beslissers:** Product Owner
* **Geraadpleegd:** Compliance, Tech lead, Privacy, Security

> [!IMPORTANT]
> **Wat "Geaccepteerd" hier wél en niet betekent.**
>
> * Het **bedrijfs- en ketenmodel** is door de Product Owner vastgesteld. SolidYield blijft
>   contractspartij, beheert de walletadministratie en investeert voor eigen rekening en
>   risico.
> * Deze ADR stelt **niet** vast welke vergunning, uitzondering, vrijstelling, ontheffing of
>   andere wettelijke grondslag nodig is.
> * **"Geaccepteerd" betekent niet dat productiegebruik of echte geldstromen juridisch zijn
>   toegestaan.** De acceptatie geldt uitsluitend de product- en keteninrichting.
> * **RD-23 t/m RD-27 blijven blokkerend** voor echte klantgelden, bindende contracten,
>   werkelijke uitkeringen en productiegebruik.
>
> | | Status |
> |---|---|
> | **Bedrijfs- en ketenmodel** — wie is contractspartij, hoe loopt de geldstroom, welke rol heeft de wallet | ✅ **Besloten** |
> | **Wettelijke grondslag** — via welke route (vergunning, wettelijke uitzondering, vrijstelling, ontheffing of een andere juridisch bevestigde grondslag) dit model mag worden uitgevoerd | ⛔ **Nog vast te stellen** door Compliance en een gespecialiseerde financieel-regulatoire jurist |
> | **Juridische uitvoerbaarheid** van het model | ⛔ **Niet vastgesteld** |
> | **Leveranciersselectie en -contracten** | ⛔ **Niet gesloten** — zie hieronder |
>
> De gekozen productinrichting **kan** vergunningplichtig zijn. De toepasselijke wettelijke
> grondslag wordt vastgesteld door Compliance. Deze ADR concludeert **niet** dat SolidYield
> vergunningplichtig is, en evenmin dat dat niet zo is.
>
> Het juridisch onderzoek **verandert het gekozen bedrijfsmodel niet**. Het bepaalt
> uitsluitend welke wettelijke grondslag nodig is om dit model uit te voeren.

> **Status van de betaalpartners.** De MVP is ontworpen voor integratie met
> **vergunninghoudende betaalpartners**. De eerste implementatierichting richt zich op
> **Mollie** voor iDEAL/SEPA en **bunq** voor IBAN-functionaliteit, uitbetalingen en
> reconciliatie. De **definitieve selectie en rolverdeling worden contractueel en
> regulatoir vastgesteld** (RD-22). Er is nog geen leveranciersovereenkomst gesloten en
> hun diensten zijn nog niet technisch of juridisch beschikbaar voor dit product.

## Doel

Het bedrijfs- en ketenmodel vastleggen, en scherp scheiden van de vraag welke wettelijke
grondslag nodig is om dat model uit te voeren. Zonder die scheiding blijft elk gesprek over
vergunningen ook een gesprek over het product, en komt geen van beide tot een conclusie.

## Context

Uit eerdere besluiten ligt vast:

* Het product is een **digitaal contractueel rendementproduct** (besluit 2).
* Markt Nederland, taal Nederlands, valuta EUR; opslag en reguliere verwerking binnen de
  EER, primaire productieomgeving in Nederland (besluit 3,
  [ADR-0006](0006-dataresidency-en-opslaglocatie.md)).

Besluit 4 (2026-08-05) voegt daar het bedrijfs- en ketenmodel aan toe, en stelt vast hoe
met de regulatoire onzekerheid wordt omgegaan zolang de wettelijke grondslag niet
bevestigd is.

## Het besloten bedrijfs- en ketenmodel

1. **SolidYield is de contractspartij van de gebruiker.**
2. Gebruikers beschikken over een **wallet met vrij beschikbaar saldo**.
3. Betalingen verlopen via **vergunninghoudende betaalpartners**. Welke partij(en) dat
   worden, is een implementatiekeuze en geen onderdeel van het model.
4. Bij **vastzetten** verdwijnt het bedrag uit de wallet.
5. De gebruiker verkrijgt een **contractuele vordering op SolidYield**.
6. SolidYield **investeert het vastgezette vermogen voor eigen rekening en risico**.
7. SolidYield betaalt gedurende de looptijd een **vooraf overeengekomen vast rendement**.
8. SolidYield betaalt de **volledige nominale inleg** terug aan het einde van de looptijd.
9. De gebruiker verkrijgt **geen** aandelen, obligaties, participaties of eigendom van
   onderliggende beleggingen.
10. De gebruiker heeft **geen invloed** op de investeringsbeslissingen.

Dit model staat vast. Het wordt niet gewijzigd op grond van de uitkomst van het juridisch
onderzoek; dat onderzoek bepaalt uitsluitend de route waarlangs het mag worden uitgevoerd.

## Geldstroom

De gebruiker heeft **twee** geldposities die scherp gescheiden zijn:

| Positie | Kenmerk | Beschikbaarheid |
|---|---|---|
| **Vrij saldo in de wallet** | staat op naam van de gebruiker in de walletadministratie | altijd opneembaar |
| **Vastgezet bedrag** | is uit de wallet verdwenen en omgezet in een contractuele vordering | niet opneembaar vóór einde looptijd |

1. Gebruiker stort geld via iDEAL of SEPA, afgehandeld door een vergunninghoudende
   betaalpartner. Het bedrag verschijnt als **vrij saldo** in de wallet.
2. Vrij saldo kan de gebruiker op elk moment opnemen naar de eigen tegenrekening.
3. Bij **vastzetten** verdwijnt het bedrag uit de wallet en ontstaat een digitaal contract.
4. SolidYield investeert het vastgezette vermogen **voor eigen rekening en risico**.
5. Gedurende de looptijd keert SolidYield maandelijks een **vast rendement** uit.
6. Aan het einde van de looptijd wordt de **volledige nominale inleg** terugbetaald.

Uitgewerkt met sequencediagrammen in [ADR-0008](0008-geld-en-contractstroom.md).

## Contractstroom

* De gebruiker sluit een contract met **SolidYield**, niet met een derde partij.
* De gebruiker verkrijgt **uitsluitend een contractuele vordering op SolidYield**.
* De gebruiker ontvangt **geen** aandelen, obligaties, participaties of eigendom van
  onderliggende beleggingen.
* De gebruiker heeft **geen invloed** op de investeringsbeslissingen.
* SolidYield bepaalt zelfstandig waarin wordt geïnvesteerd; de investeringscategorieën
  blijven functioneel breed.
* Er wordt **administratieve vermogensscheiding** toegepast.
* **Beoogde positie van de gebruiker bij faillissement: concurrent schuldeiser.**

> ⚠️ Administratieve vermogensscheiding is een **boekhoudkundige** maatregel. Of zij ook
> goederenrechtelijke bescherming biedt bij faillissement is een juridische vraag, geen
> administratieve; de beoogde positie "concurrent schuldeiser" gaat er juist van uit dat
> die bescherming er niet is. Beide staan hier als beoogde inrichting, **niet** als
> vastgesteld rechtsgevolg. Zie RD-20 en RD-21.

## Walletrol

De **wallet blijft onderdeel van SolidYield**.

| Wel | Niet |
|---|---|
| storten (iDEAL, SEPA, via een vergunninghoudende betaalpartner) | P2P-betalingen tussen gebruikers |
| opnemen naar de eigen tegenrekening | betalingen aan derden |
| vastzetten (omzetten in een contract) | betaalrekeningfunctionaliteit voor algemeen betalingsverkeer |

De wallet bevat **uitsluitend vrij beschikbaar saldo**.

> De beoordeling of de wallet kwalificeert als **betaaldienst** of als **elektronisch geld**
> blijft onderdeel van de compliance-analyse (RD-17). De inzet van een vergunninghoudende
> betaalpartner verandert niets aan de verantwoordelijkheid om de vergunningplicht van
> SolidYield zelf vast te stellen.

## Rol van SolidYield

| Rol | Toelichting |
|---|---|
| Contractspartij | de gebruiker sluit het contract met SolidYield |
| Schuldenaar | SolidYield keert het vaste rendement uit en betaalt de nominale inleg terug |
| Investeerder voor eigen rekening en risico | SolidYield draagt het beleggingsresultaat |
| Houder van de wallet | de wallet blijft onderdeel van SolidYield; vrij saldo per gebruiker, met administratieve vermogensscheiding |
| Verantwoordelijke voor de eigen vergunningpositie | die verantwoordelijkheid verschuift niet naar een betaalpartner |
| Verantwoordelijke voor KYC/AML in fase 1 | zie *Afhankelijkheden* |

## Rol van de betaalpartners

De MVP is ontworpen voor integratie met **vergunninghoudende betaalpartners**. De eerste
implementatierichting richt zich op **Mollie** voor iDEAL/SEPA en **bunq** voor
IBAN-functionaliteit, uitbetalingen en reconciliatie. De **definitieve selectie en
rolverdeling worden contractueel en regulatoir vastgesteld** (RD-22).

### Beoogde taakverdeling in de eerste implementatierichting

| Partij | Beoogde taak |
|---|---|
| Mollie *(implementatierichting)* | iDEAL-betalingen; SEPA-incasso en -overboeking waar van toepassing; reconciliatie-informatie om binnenkomende betalingen aan gebruikers te koppelen |
| bunq *(implementatierichting)* | IBAN-functionaliteit als rekeningstructuur; uitbetalingen van rendement en terugbetaling van de nominale inleg; aansluiting tussen bankmutaties en de eigen administratie |

> **Drie dingen die uit elkaar moeten blijven:**
>
> | | Status |
> |---|---|
> | Gekozen **leveranciersrichting** — Mollie en bunq | ✅ gekozen als eerste richting |
> | **Overeenkomst** met die partijen | ⛔ **niet gesloten** |
> | **Regulatoire rolverdeling** in de keten | ⛔ **niet definitief vastgesteld** (RD-22) |
>
> Een betaalpartner is **geen productuitgever**. Wie de rol ook krijgt: die partij verzorgt
> het betalingsverkeer, is **geen contractspartij van de gebruiker**, geeft het product
> **niet uit** en draagt het beleggings- of terugbetalingsrisico **niet**. Dat blijft bij
> SolidYield.

## Regulatorische conclusie

Op basis van deze productinrichting moet SolidYield **ervan uitgaan dat sprake kan zijn van
het aantrekken van opvorderbare gelden**.

Voordat het product met echte gebruikers wordt aangeboden, moet daarom worden vastgesteld
**via welke wettelijke route dit is toegestaan**. Mogelijke routes zijn onder andere:

* vergunning;
* wettelijke uitzondering;
* vrijstelling;
* ontheffing;
* of een andere juridisch bevestigde grondslag.

Welke route uiteindelijk geldt, wordt bepaald door **Compliance en een gespecialiseerde
financieel-regulatoire jurist** (RD-23). Dat onderzoek verandert het gekozen bedrijfsmodel
niet; het bepaalt uitsluitend welke wettelijke grondslag nodig is om dit model uit te
voeren.

## Beperkingen tot de wettelijke grondslag is bevestigd

| Toegestaan | Niet toegestaan |
|---|---|
| UX-ontwerp en -onderzoek | echte klantgelden |
| werkende MVP | bindende rendementcontracten |
| sandboxbetalingen | werkelijke rendementuitkeringen |
| synthetische data | productiegebruik |
| besloten demonstraties | |
| technische integraties | |

Deze beperkingen gelden **totdat de juridische grondslag is bevestigd**. Zij zijn niet
onderhandelbaar en kennen geen uitzonderingsprocedure.

## Open compliancevragen

Het bedrijfsmodel is besloten. Wat openstaat, betreft uitsluitend de **wettelijke
grondslag** en de daarmee samenhangende kwalificaties:

| Vraag | Register |
|---|---|
| Via welke wettelijke route mag dit model worden uitgevoerd? | **RD-23** |
| Is een vergunning vereist, en zo ja welke? | RD-24 |
| Is een wettelijke uitzondering van toepassing? | RD-25 |
| Is een vrijstelling van toepassing? | RD-26 |
| Is een ontheffing nodig of mogelijk? | RD-27 |
| Kwalificeert de wallet als betaaldienst of als elektronisch geld? | RD-17 |
| Hoe kwalificeert het product, en is de gebruiker belegger? | RD-18 |
| Werking van administratieve vermogensscheiding bij faillissement | RD-20 |
| Houdbaarheid en communicatie van de positie als concurrent schuldeiser | RD-21 |
| Definitieve contractuele en regulatoire rolverdeling met de betaalpartners | RD-22 |
| Identificatie- en verificatieverplichtingen (KYC/AML) | RD-05 |
| Kapitaal- of buffervereisten voor de terugbetalingsverplichting | RD-19 |

## Risico's

| # | Risico | Gevolg |
|---|---|---|
| A-1 | De wettelijke route wordt pas bepaald nadat wallet en contractmodule zijn gebouwd | de MVP blijft bruikbaar, maar er kan geen echte gebruiker op; doorlooptijd naar productie loopt op |
| A-2 | "Administratieve vermogensscheiding" wordt intern of extern gelezen als bescherming van gebruikersgeld bij faillissement | onterecht vertrouwen bij gebruikers; raakt principe 5 en de zorgplicht |
| A-3 | De beoogde positie "concurrent schuldeiser" wordt niet begrijpelijk gecommuniceerd | de gebruiker kan het werkelijke risico niet benoemen — PD-1 wordt niet gehaald |
| A-4 | Een andere betaalpartner wordt geselecteerd, of de rolverdeling verschuift bij onderhandeling | technische integratie moet worden aangepast; het bedrijfsmodel verandert niet |
| A-5 | Geen vastgesteld maximum op de inleg, terwijl drempelbedragen relevant kunnen zijn voor een uitzondering of vrijstelling | een inleg kan onbedoeld in een ander regime vallen; te betrekken bij RD-23 |
| A-6 | KYC/AML in fase 1 bij SolidYield zelf, zonder gespecialiseerde partner | uitvoeringsrisico en aantoonbaarheidsrisico; zie RD-05 |
| A-7 | De MVP-beperkingen worden opgerekt onder tijdsdruk ("één echte gebruiker kan geen kwaad") | het product wordt aangeboden zonder bevestigde wettelijke grondslag |
| A-8 | De eerste implementatierichting wordt intern of extern gelezen als een gesloten leverancierskeuze, of "Geaccepteerd" als juridische goedkeuring | verkeerde verwachtingen over planning en toelaatbaarheid; regulatoire beoordeling wordt overgeslagen |

## Afhankelijkheden

| # | Afhankelijkheid | Status |
|---|---|---|
| D-1 | Vaststelling van de wettelijke route door Compliance en een gespecialiseerde jurist (RD-23 t/m RD-27) | **open — blokkerend voor gebruik met echte gebruikers** |
| D-2 | Leveranciersselectie en contractuele afspraken met de betaalpartners, inclusief regulatoire rolverdeling (RD-22). Eerste implementatierichting: Mollie en bunq | **niet gesloten**; geen van beide is definitief geselecteerd |
| D-3 | KYC/AML — **fase 1:** SolidYield is verantwoordelijk. **Fase 2 (roadmap, geen huidige implementatie):** integratie via een gespecialiseerde externe partner binnen het onboardingproces | fase 2 is een roadmapbesluit |
| D-4 | Kapitaalpositie die de terugbetalingsverplichting draagt (RD-19) | niet doorgerekend |
| D-5 | Keuze van cloudprovider binnen de residency-eis ([ADR-0006](0006-dataresidency-en-opslaglocatie.md)) | ADR-0003 open |
| D-6 | Beleggingsbeleid: waarín wordt geïnvesteerd (RD-16) | niet vastgesteld; relevante input voor RD-23 |

## Definition of Done vóór gebruik met echte gebruikers

Het bedrijfsmodel is besloten; deze lijst gaat over wat er moet gebeuren voordat de
beperkingen hierboven mogen vervallen:

- [ ] Compliance heeft de feitelijke beschrijving in deze ADR bevestigd als volledig en
      juist.
- [ ] De **wettelijke route** is vastgesteld en schriftelijk onderbouwd door een
      gespecialiseerde financieel-regulatoire jurist, vastgelegd met naam, datum en
      reikwijdte (RD-23 t/m RD-27).
- [ ] De kwalificatie van de wallet (betaaldienst of elektronisch geld) is vastgesteld
      (RD-17).
- [ ] De betaalpartners zijn definitief geselecteerd en de contractuele en regulatoire
      rolverdeling is vastgelegd en beoordeeld (RD-22).
- [ ] De werking van de administratieve vermogensscheiding bij faillissement is beoordeeld
      (RD-20), en de uitkomst is verwerkt in de gebruikerscommunicatie.
- [ ] De informatie over de positie als concurrent schuldeiser is getoetst bij de
      testgroep: gebruikers kunnen die positie in eigen woorden benoemen (PD-1, RD-21).
- [ ] RD-19 is doorgerekend: er is een onderbouwde kapitaalpositie voor de
      terugbetalingsverplichting.
- [ ] Het threat model en de DPIA zijn bijgewerkt op de vastgestelde geld- en
      contractstroom.

Zolang één punt openstaat: **geen echte klantgelden, geen bindende rendementcontracten,
geen werkelijke rendementuitkeringen, geen productiegebruik.**

## Gerelateerde besluiten

* Bouwt voort op: [ADR-0006](0006-dataresidency-en-opslaglocatie.md)
* Werkt uit in: [ADR-0008](0008-geld-en-contractstroom.md)
* Randvoorwaarde voor: `ADR-0003` (cloudprovider), `ADR-0004` (identiteitsprovider)
* Registervragen: `RD-05`, `RD-14`, `RD-16` t/m `RD-27`

## Herzieningsmoment

Bij vaststelling van de wettelijke route (RD-23), bij het antwoord op RD-17, bij wijziging
van betaalpartner of contractuele rolverdeling, en vóór het vervallen van de
MVP-beperkingen.
