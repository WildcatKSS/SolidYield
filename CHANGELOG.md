# Changelog

Alle noemenswaardige wijzigingen aan dit project worden in dit bestand vastgelegd.

Het formaat volgt [Keep a Changelog](https://keepachangelog.com/nl/1.1.0/) en dit project
volgt [Semantic Versioning](https://semver.org/lang/nl/).

Rubrieken: `Toegevoegd`, `Gewijzigd`, `Verouderd`, `Verwijderd`, `Opgelost`, `Security`.
Vermeld bij elke regel het issue- of PR-nummer. Regels met privacy-, compliance- of
security-impact worden expliciet gemarkeerd.

> **Deze changelog begint leeg, en dat is de bedoeling.** Hij hoort bij *jouw* product.
> De ontwikkelgeschiedenis van de template zelf staat in de
> [Releases](../../releases) van de templaterepository, niet hier — anders zou elke
> nieuwe repository beginnen met releases die nooit hebben plaatsgevonden.
>
> Vul hieronder je eigen wijzigingen in en vervang `[ORGANISATIE]/[REPOSITORY]` in de
> linkregels onderaan door je eigen repository.

## [Unreleased]

### Toegevoegd
- **ADR-0007** (Vergunningplicht en rol in de keten) en **ADR-0008** (Geld- en
  contractstroom, met sequencediagrammen) toegevoegd. Beide status **Voorgesteld**:
  zij beschrijven de inrichting, niet de juridische kwalificatie. Besluit 4 blijft
  open en wacht op validatie door Compliance en een gespecialiseerde
  financieel-regulatoire jurist (#1)
- Productparameters vastgelegd: looptijden 3, 6, 12, 24, 36 en 60 maanden; minimum
  inleg € 50; geen vastgesteld maximum; vast rendement, maandelijks uitgekeerd;
  volledige inleg terug aan het einde van de looptijd (#1)
- Walletrol vastgelegd: storten, opnemen naar de eigen tegenrekening en vastzetten;
  geen P2P-betalingen en geen betalingen aan derden (#1)
- MVP-doelgroep vastgelegd: Nederlandse consumenten, zzp'ers en rechtspersonen, met
  start uitsluitend in een besloten testgroep (#1)
- **Compliance:** RD-20 (werking van administratieve vermogensscheiding bij
  faillissement), RD-21 (houdbaarheid en communicatie van de positie als concurrent
  schuldeiser) en RD-22 (definitieve rolverdeling met betaalpartners) toegevoegd;
  controls C-16 t/m C-18 toegevoegd aan het complianceregister (#1)
- Productvisie ingevuld voor SolidYield: doelgroep, probleem, productdoel en
  marktafbakening (Nederland, NL, EUR) (#1)
- Productdoel PD-1 vastgelegd, met meetwaarden en PD-0 (validatie) als voorliggend
  doel (#1)
- **Compliance:** RD-15 en RD-16 toegevoegd aan het register van regulatoire
  besluiten — presentatie als product zonder beleggingsrisico, en de constructie
  onder het rendement (#1)

### Gewijzigd
- Besluit 3 verwerkt: markt Nederland, taal Nederlands, valuta EUR. Opslag en reguliere
  verwerking binnen de EER, primaire productieomgeving in Nederland, één secundaire
  EER-regio voor back-up en disaster recovery. Vastgelegd als **ADR-0006**; `[REGIO]`
  is daarmee overal ingevuld (#1)
- **Privacy:** toegang vanuit derde landen is standaard uitgesloten; een vooraf
  goedgekeurde uitzondering geldt als internationale doorgifte en wordt als zodanig
  geregistreerd (ADR-0006) (#1)
- **Compliance:** RD-07 op de beleidskant gesloten — opslag en reguliere verwerking
  uitsluitend binnen de EER. De juridische beoordeling van een concrete uitzondering
  blijft een taak voor Privacy en Compliance (#1)
- Type financiële dienst vastgesteld: digitaal contractueel rendementproduct. De
  werking is beschreven in de productvisie §6; het regulatoire regime is
  uitdrukkelijk niet vastgesteld (#1)
- **Compliance:** RD-17 t/m RD-19 toegevoegd (betaaldienst-kwalificatie,
  beleggerskwalificatie, kapitaalvereisten); RD-16 deels beantwoord; RD-01
  aangescherpt op de vastgestelde productvorm. Het regulatoire regime blijft open
  en blokkeert elke externe propositie (#1)
- Productdoel PD-1 uitkomstgericht geherformuleerd: een inleg die binnen vijftien
  minuten zelfstandig af te ronden is, en die de gebruiker daarna aantoonbaar
  begrijpt (uitkering én risico). Meetwaarde voor doorlooptijd toegevoegd (#1)

<!--
Voorbeeld van een ingevulde release. Verwijder dit commentaar zodra je eigen releases
hier staan.

## [1.1.0] - 2026-03-12

### Toegevoegd
- Maandoverzicht per uitgavencategorie op het dashboard (#123)

### Security
- Sessie-timeout teruggebracht van 60 naar 15 minuten (#131) — security-impact: hoog

### Opgelost
- Bedragen werden afgerond weergegeven in het transactieoverzicht (#128)
-->

[Unreleased]: https://github.com/[ORGANISATIE]/[REPOSITORY]/commits/main
