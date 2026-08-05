# ADR-0006: Dataresidency en opslaglocatie

* **Status:** Geaccepteerd
* **Datum:** 2026-08-03
* **Beslissers:** Product Owner, Compliance
* **Geraadpleegd:** Tech lead, Privacy

## Context

SolidYield wordt in de eerste fase uitsluitend op de Nederlandse markt aangeboden
(besluit 3 in [`../../../README.md`](../../README.md#10-openstaande-beslissingen-en-placeholders)).
Het product verwerkt persoonsgegevens, walletadministratie, contractgegevens en
transactielogs — categorieën waarvoor de opslaglocatie zowel een privacyvraag als een
toezichtvraag is.

De cloudprovider is nog niet gekozen (ADR-0003 staat nog open). Dit besluit gaat daaraan
vooraf: het legt de *randvoorwaarde* vast waarbinnen die keuze moet passen, zodat de
providerkeuze niet stilzwijgend de dataresidency bepaalt.

## Probleem

Waar mogen productiegegevens van SolidYield worden opgeslagen en verwerkt?

## Besliscriteria

| # | Criterium | Gewicht | Toelichting |
|---|---|---|---|
| C1 | Privacy en aantoonbaarheid | hoog | doorgifte buiten de EER vraagt aanvullende waarborgen en onderbouwing |
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
* Voordelen: geografische scheiding voor herstel zonder de EER te verlaten; doorgifte
  buiten de EER blijft afwezig, dus geen aanvullend doorgiftemechanisme nodig.
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

1. Alle productiegegevens worden opgeslagen en verwerkt **binnen de EER**.
2. De primaire productieomgeving bevindt zich **fysiek in Nederland**.
3. Back-ups en disaster recovery mogen in **één** secundaire EER-regio staan.
4. Persoonsgegevens, walletadministratie, contractgegevens, transactielogs en back-ups
   blijven binnen de EER.
5. Productiegegevens worden **niet** opgeslagen of structureel verwerkt buiten de EER.
6. Leveranciers en subverwerkers moeten opslag en verwerking binnen de EER ondersteunen.
7. Toegang vanuit buiten de EER — door leveranciers of medewerkers — is uitsluitend
   toegestaan na een afzonderlijke privacy- en compliancebeoordeling en met passende
   juridische waarborgen.
8. Uitbreiding naar andere Europese landen verandert dit besluit niet; Nederland blijft de
   primaire regio tenzij hierover expliciet een nieuw bestuursbesluit wordt genomen.

## Motivatie

Optie B haalt het herstelvoordeel van geografische spreiding binnen zonder de EER te
verlaten, waardoor er geen doorgiftemechanisme naar een derde land nodig is. Dat is de
eenvoudigste positie zolang RD-01 openstaat: hoe minder open variabelen richting de
specialist, hoe scherper die vraag te beantwoorden is.

Het nadeel dat wij bewust accepteren is **C4**: een harde eis van een primaire omgeving
in Nederland sluit providers en regio's uit. Dat is een reële beperking voor ADR-0003 en
geen theoretische — zie *Negatieve gevolgen*.

## Positieve gevolgen

* Geen doorgifte naar derde landen, dus geen aanvullend doorgiftemechanisme en geen
  bijbehorende onderbouwing.
* Eén heldere norm om leveranciers en subverwerkers aan te toetsen (uitgangspunt 6).
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
* Uitgangspunt 7 vraagt een werkend beoordelingsproces voor toegang van buiten de EER;
  dat proces bestaat nog niet.

## Security-impact

* Geen nieuw aanvalsoppervlak. De eis beperkt waar gegevens staan, niet hoe ze zijn
  beveiligd.
* Wel relevant voor sleutelbeheer: sleutels horen in dezelfde regio als de gegevens die
  zij beschermen. Uit te werken in ADR-0005.
* Beoordeeld door: `[NAAM]` op `[DATUM]` — **nog niet uitgevoerd**

## Privacy-impact

* Raakt alle persoonsgegevens die het product verwerkt.
* Verandert de opslaglocatie van onbepaald naar begrensd; dat is een verbetering.
* Doorgifte buiten de EER: **nee**, dat is precies wat dit besluit uitsluit.
* Aanvullende DPIA nodig: ⬜ ja ⬜ nee — te beoordelen bij de DPIA (RD-09)
* Beoordeeld door: `[NAAM]` op `[DATUM]` — **nog niet uitgevoerd**

## Compliance-impact

* Beantwoordt de beleidskant van **RD-07** (mogen gegevens buiten de regio worden
  verwerkt). De juridische vraag of doorgifte *toegestaan* zou zijn, blijft open; wij
  kiezen hier een strengere norm dan mogelijk vereist is, en dat mag het team zelf
  beslissen.
* Raakt uitgangspunt 6 aan **RD-10** (eisen aan uitbesteding en leveranciersbeheersing).
* Vast te leggen bewijs: regio-instellingen van de gekozen provider, en per leverancier
  de bevestigde verwerkingslocatie.

## Vervolgacties

| # | Actie | Eigenaar | Issue | Deadline |
|---|---|---|---|---|
| 1 | Bij ADR-0003 verifiëren welke providers een volwaardige primaire regio in Nederland bieden | Tech lead | # | vóór providerkeuze |
| 2 | Beoordelingsproces inrichten voor toegang van buiten de EER (uitgangspunt 7) | Privacy + Compliance | # | vóór eerste leverancier |
| 3 | Secundaire EER-regio voor back-ups en DR kiezen en vastleggen | Tech lead | # | bij ADR-0003 |

## Gerelateerde besluiten

* Randvoorwaarde voor: `ADR-0003` (cloudprovider en regio), `ADR-0005` (sleutelbeheer)
* Gerelateerde registervragen: `RD-07`, `RD-09`, `RD-10`

## Herzieningsmoment

Bij uitbreiding naar een ander EER-land, bij wisseling van cloudprovider, of wanneer een
leverancier verwerking binnen de EER niet kan garanderen.
