# ADR-0006: Dataresidency en opslaglocatie

* **Status:** Geaccepteerd
* **Datum:** 2026-08-03
* **Beslissers:** Product Owner, Compliance
* **Geraadpleegd:** Tech lead, Privacy

## Context

SolidYield wordt in de eerste fase uitsluitend op de Nederlandse markt aangeboden
(besluit 3 in [`../../../README.md`](../../../README.md#10-openstaande-beslissingen-en-placeholders)).
Het product verwerkt persoonsgegevens, walletadministratie, contractgegevens en
transactielogs — categorieën waarvoor de opslaglocatie zowel een privacyvraag als een
toezichtvraag is.

De cloudprovider is nog niet gekozen (ADR-0003 staat nog open). Dit besluit gaat daaraan
vooraf: het legt de *randvoorwaarde* vast waarbinnen die keuze moet passen, zodat de
providerkeuze niet stilzwijgend de dataresidency bepaalt.

## Probleem

Waar mogen productiegegevens van SolidYield worden opgeslagen en verwerkt, en onder welke
voorwaarden mag er vanuit een derde land toegang toe zijn?

## Besliscriteria

| # | Criterium | Gewicht | Toelichting |
|---|---|---|---|
| C1 | Privacy en aantoonbaarheid | hoog | elke verwerking buiten de EER — inclusief toegang op afstand — vraagt een geldig doorgiftemechanisme en onderbouwing |
| C2 | Toezicht en vergunningtraject | hoog | RD-01 loopt; een binnenlandse verwerkingslocatie beperkt het aantal open variabelen |
| C3 | Beschikbaarheid en herstelbaarheid | hoog | disaster recovery vraagt geografische scheiding van de primaire locatie |
| C4 | Keuzeruimte in providers | midden | een strikte eis beperkt het aantal bruikbare providers en regio's |
| C5 | Kosten | midden | regio's binnen de EER zijn doorgaans duurder dan buiten |

## Onderzochte opties

### Optie A — Alles binnen Nederland, inclusief back-ups
* Beschrijving: primaire omgeving én alle kopieën in één land.
* Voordelen: eenvoudigste verhaal richting toezichthouder en betrokkenen.
* Nadelen: disaster recovery binnen één land is zwak bij een regionale storing; sterk
  beperkte providerkeuze.

### Optie B — Primair Nederland, back-ups en DR in één secundaire EER-regio
* Beschrijving: productie fysiek in Nederland; herstelkopieën elders binnen de EER.
* Voordelen: geografische scheiding voor herstel zonder de EER te verlaten; in de reguliere
  bedrijfsvoering is geen doorgiftemechanisme nodig.
* Nadelen: providerkeuze blijft beperkt; twee regio's betekent extra beheerlast.

### Optie C — Vrij binnen de EER, geen voorkeurland
* Beschrijving: elke EER-regio is toegestaan.
* Voordelen: maximale keuzeruimte en laagste kosten.
* Nadelen: geen expliciete binnenlandse verankering terwijl de dienst uitsluitend op de
  Nederlandse markt wordt aangeboden en RD-01 nog openstaat.

## Gekozen optie

**Optie B — primaire productieomgeving in Nederland, back-ups en disaster recovery in
één secundaire EER-regio.**

Uitgangspunten:

1. Opslag en reguliere verwerking van productiegegevens vinden **uitsluitend binnen de
   EER** plaats.
2. De primaire productieomgeving bevindt zich **fysiek in Nederland**.
3. Back-ups en disaster recovery mogen in **één** secundaire EER-regio staan.
4. Persoonsgegevens, walletadministratie, contractgegevens, transactielogs en back-ups
   blijven binnen de EER.
5. Er vindt **geen structurele doorgifte naar derde landen** plaats. Eventuele
   uitzonderingen vereisen afzonderlijke beoordeling, passende juridische waarborgen en
   registratie als internationale doorgifte.
6. Leveranciers en subverwerkers moeten opslag en verwerking binnen de EER ondersteunen.
7. **Toegang vanuit een derde land is standaard uitgesloten** — voor leveranciers en voor
   eigen medewerkers. Een uitzondering vereist voorafgaande goedkeuring door Privacy en
   Compliance én een juridisch geldig doorgiftemechanisme. Een toegestane uitzondering
   **geldt als internationale doorgifte** en wordt als zodanig geregistreerd.
8. Uitbreiding naar andere Europese landen verandert dit besluit niet; Nederland blijft de
   primaire regio tenzij hierover expliciet een nieuw bestuursbesluit wordt genomen.

> **Waarom uitgangspunt 7 zo strikt is geformuleerd.** Toegang op afstand vanuit een derde
> land is niet neutraal: het beschikbaar stellen van gegevens aan iemand buiten de EER kan
> zelf een internationale doorgifte of een verwerking buiten de EER zijn. "Wij slaan niets
> buiten de EER op" en "een beheerder buiten de EER mag meekijken" kunnen dus niet naast
> elkaar bestaan zonder dat het tweede als doorgifte wordt behandeld. Dit ADR kiest daarom
> voor uitsluiting als norm, met een expliciet en geregistreerd uitzonderingspad.
>
> Of een concrete uitzondering juridisch toelaatbaar is, en welk mechanisme dan passend is,
> is **geen conclusie die dit team neemt** — die beoordeling ligt bij Privacy en Compliance.

## Motivatie

Optie B haalt het herstelvoordeel van geografische spreiding binnen zonder de EER te
verlaten. In de reguliere bedrijfsvoering is daardoor geen doorgiftemechanisme nodig; dat
is de eenvoudigste positie zolang RD-01 openstaat, want hoe minder open variabelen richting
de specialist, hoe scherper die vraag te beantwoorden is.

Het besluit maakt tegelijk expliciet dat "EER-only" een **beleidsnorm** is en geen
technische onmogelijkheid. Toegang vanuit een derde land blijft denkbaar — bijvoorbeeld bij
leveranciersondersteuning — en wordt daarom niet weggeschreven maar begrensd: standaard
uitgesloten, en bij uitzondering alleen met goedkeuring, waarborgen en registratie.

Het nadeel dat wij bewust accepteren is **C4**: een harde eis van een primaire omgeving
in Nederland sluit providers en regio's uit. Dat is een reële beperking voor ADR-0003 en
geen theoretische — zie *Negatieve gevolgen*.

## Positieve gevolgen

* In de reguliere bedrijfsvoering is geen doorgiftemechanisme nodig; alleen bij een
  goedgekeurde uitzondering.
* Eén heldere norm om leveranciers en subverwerkers aan te toetsen (uitgangspunt 6), en één
  heldere norm voor toegang op afstand (uitgangspunt 7).
* Doordat een uitzondering expliciet als internationale doorgifte wordt geregistreerd,
  blijft aantoonbaar wanneer en waarom de EER-grens is gepasseerd.
* Beperkt het aantal open variabelen in RD-01.

## Negatieve gevolgen

* **De providerkeuze wordt materieel ingeperkt.** Niet elke grote cloudprovider heeft een
  volwaardige regio in Nederland; sommige bedienen de Nederlandse markt vanuit een regio
  in een ander EER-land. Welke providers aan uitgangspunt 2 voldoen is **te verifiëren
  bij het opstellen van ADR-0003** — dit besluit stelt de eis, het inventariseert de
  markt niet.
  *Beperking:* de eis is expliciet vastgelegd vóór de providerkeuze, zodat die keuze de
  residency niet stilzwijgend bepaalt.
* Twee regio's betekent extra beheerlast en hogere kosten dan één regio.
* Uitgangspunt 7 vraagt een werkend goedkeurings- en registratieproces voor toegang vanuit
  derde landen; dat proces bestaat nog niet.
* Een strikt uitzonderingspad kan operationeel knellen bij leveranciers die
  ondersteuning standaard vanuit een derde land leveren. Dat is een bewuste keuze: liever
  een expliciete afweging vooraf dan een stilzwijgende doorgifte achteraf.

## Security-impact

* Geen nieuw aanvalsoppervlak. De eis beperkt waar gegevens staan en wie er vanwaar bij
  kan, niet hoe ze zijn beveiligd.
* Relevant voor **sleutelbeheer**: sleutelbeheer moet voldoen aan de vastgestelde
  EER-residency. De precieze locatie, regionale scheiding, beschikbaarheid en
  herstelstrategie worden vastgesteld in **ADR-0005**; dit besluit loopt daar niet op
  vooruit.
* Uitgangspunt 7 raakt toegangsbeheer: herkomst van toegang wordt een controleerbaar
  criterium, wat logging en autorisatie-eisen met zich meebrengt.
* Beoordeeld door: `[NAAM]` op `[DATUM]` — **nog niet uitgevoerd**

## Privacy-impact

* Raakt alle persoonsgegevens die het product verwerkt.
* Verandert de opslaglocatie van onbepaald naar begrensd; dat is een verbetering.
* Doorgifte buiten de EER: **niet structureel**. Een goedgekeurde uitzondering op
  uitgangspunt 7 geldt als internationale doorgifte en vraagt een geldig
  doorgiftemechanisme, vastlegging in het verwerkingsregister en beoordeling in de
  (P)DPIA.
* Aanvullende DPIA nodig: ⬜ ja ⬜ nee — te beoordelen bij de DPIA (RD-09). Elke
  uitzondering op uitgangspunt 7 is op zichzelf aanleiding voor herbeoordeling.
* Beoordeeld door: `[NAAM]` op `[DATUM]` — **nog niet uitgevoerd**

## Compliance-impact

* Beantwoordt de **beleidskant** van **RD-07** (mogen gegevens buiten de regio worden
  verwerkt): EER-only is de norm, toegang vanuit derde landen is standaard uitgesloten.
  De **juridische** beoordeling — of doorgifte in een concreet geval is toegestaan en
  welk mechanisme daarbij hoort — blijft een taak voor Privacy en Compliance en is
  **geen conclusie van dit team**.
* Raakt uitgangspunt 6 aan **RD-10** (eisen aan uitbesteding en leveranciersbeheersing).
* Vast te leggen bewijs: regio-instellingen van de gekozen provider, per leverancier de
  bevestigde verwerkingslocatie, en per goedgekeurde uitzondering op uitgangspunt 7 de
  onderbouwing, het toegepaste doorgiftemechanisme en de registratie als internationale
  doorgifte.

## Vervolgacties

| # | Actie | Eigenaar | Issue | Deadline |
|---|---|---|---|---|
| 1 | Bij ADR-0003 verifiëren welke providers een volwaardige primaire regio in Nederland bieden | Tech lead | # | vóór providerkeuze |
| 2 | Goedkeurings- en registratieproces inrichten voor toegang vanuit derde landen (uitgangspunt 7), inclusief vastlegging als internationale doorgifte | Privacy + Compliance | # | vóór eerste leverancier |
| 3 | Secundaire EER-regio voor back-ups en DR kiezen en vastleggen | Tech lead | # | bij ADR-0003 |
| 4 | Toetsen of het verwerkingsregister en de PIA een veld hebben voor goedgekeurde uitzonderingen op uitgangspunt 7 | Privacy | # | vóór eerste uitzondering |

## Gerelateerde besluiten

* Randvoorwaarde voor: `ADR-0003` (cloudprovider en regio), `ADR-0005` (sleutelbeheer)
* Gerelateerde registervragen: `RD-07`, `RD-09`, `RD-10`

## Herzieningsmoment

Bij uitbreiding naar een ander EER-land, bij wisseling van cloudprovider, wanneer een
leverancier verwerking binnen de EER niet kan garanderen, of bij de eerste goedgekeurde
uitzondering op uitgangspunt 7.
