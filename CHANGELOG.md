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
- Productvisie ingevuld voor SolidYield: doelgroep, probleem, productdoel en
  marktafbakening (Nederland, NL, EUR) (#1)
- Productdoel PD-1 vastgelegd, met meetwaarden en PD-0 (validatie) als voorliggend
  doel (#1)
- **Compliance:** RD-15 en RD-16 toegevoegd aan het register van regulatoire
  besluiten — presentatie als product zonder beleggingsrisico, en de constructie
  onder het rendement (#1)

### Gewijzigd
- Besluit 3 verwerkt: markt Nederland, taal Nederlands, valuta EUR, en dataresidency
  binnen de EER met de primaire productieomgeving in Nederland. Vastgelegd als
  **ADR-0006**; `[REGIO]` is daarmee overal ingevuld (#1)
- **Compliance:** RD-07 beleidsmatig gesloten — verwerking uitsluitend binnen de EER;
  de juridische doorgiftevraag blijft open (#1)
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
