# Customer journey

Beschrijft de reis van de gebruiker door SolidYield. Per fase leggen we vast wat de
gebruiker doet, denkt en voelt, waar het misgaat, en welke security-, privacy- en
compliancemomenten er spelen.

> Vul deze journey aan met echte observaties uit de testgroep. Zolang de kolom "Bewijs"
> leeg is, is de regel een aanname.

## Overzicht

| # | Fase | Doel van de gebruiker |
|---|---|---|
| 1 | Ontdekken | begrijpen of dit voor mij is |
| 2 | Registreren | veilig een account krijgen |
| 3 | Verifiëren | aantonen wie ik ben (indien vereist) |
| 4 | Wallet en storten | geld klaarzetten om iets mee te doen |
| 5 | Vastzetten | een bedrag laten renderen tegen een vast rendement |
| 6 | Terugkerend gebruik | grip houden, gewoonte opbouwen |
| 7 | Hulp nodig | een probleem opgelost krijgen |
| 8 | Vertrekken | stoppen, gegevens verwijderen, exporteren |

## Uitwerking per fase

### 1. Ontdekken
| Aspect | Invulling |
|---|---|
| Gebruiker doet | leest uitleg, weegt vertrouwen af |
| Denkt/voelt | "Is dit veilig? Wat kost het? Wie zijn dit?" |
| Pijnpunten | onduidelijkheid over kosten en gegevensgebruik |
| Kans | transparantie vóór registratie tonen |
| Privacy | geen tracking zonder grondslag; cookie-/trackingkeuze vooraf |
| Compliance | informatieverplichtingen — **te valideren door bevoegde specialist** |
| Meetpunt | % bezoekers dat aan registratie begint |
| Bewijs | `[nog te verzamelen]` |

### 2. Registreren
| Aspect | Invulling |
|---|---|
| Gebruiker doet | account aanmaken, wachtwoord kiezen, MFA instellen |
| Pijnpunten | te veel gevraagde gegevens, onduidelijke wachtwoordeisen, MFA-drempel |
| Security | sterke authenticatie, MFA, bescherming tegen geautomatiseerde registratie, rate limiting |
| Privacy | gegevensminimalisatie: alleen wat nodig is; expliciete doelbinding |
| Toegankelijkheid | foutmeldingen begrijpelijk, MFA ook zonder smartphone bruikbaar |
| Meetpunt | voltooiingspercentage registratie; % dat MFA voltooit |
| Bewijs | `[nog te verzamelen]` |

### 3. Verifiëren (KYC/AML)
| Aspect | Invulling |
|---|---|
| Gebruiker doet | identiteit aantonen; bij zzp'ers en rechtspersonen verloopt dat anders dan bij consumenten |
| Kernfeit | de wallet wordt **pas** geopend na een positieve uitkomst — faalstand is dicht |
| Fasering | fase 1: SolidYield voert KYC/AML zelf uit. Fase 2: integratie via een gespecialiseerde externe partner — **roadmap, geen huidige implementatie** |
| Pijnpunten | uitval bij documentcontrole, lange wachttijd, gevoel van wantrouwen |
| Security/compliance | identiteitscontrole en eventuele verplichtingen — **te valideren door bevoegde specialist** |
| Privacy | identiteitsgegevens strikt gescheiden opslaan, korte bewaartermijn |
| Bewijs | `[nog te verzamelen]` |

### 4. Wallet en storten
| Aspect | Invulling |
|---|---|
| Gebruiker doet | wallet geopend krijgen na positieve KYC-uitkomst; geld storten via iDEAL of SEPA |
| Denkt/voelt | "Kan ik dit geld er ook weer uit halen? Waar staat het nu?" |
| Kernfeit | de wallet bevat **uitsluitend vrij beschikbaar saldo** en dat is **altijd opneembaar** — naar de eigen tegenrekening, niet naar derden |
| Security | dekkingscontrole, eigenaarschapscontrole, idempotente verwerking, herauthenticatie bij opnemen |
| Privacy | betaalgegevens minimaal en doelgebonden verwerken |
| Compliance | of de wallet een betaaldienst is — **open, RD-17** |
| Meetpunt | % dat na accountaanmaak daadwerkelijk stort; doorlooptijd van een opname |
| Bewijs | `[nog te verzamelen]` |

### 5. Vastzetten ("het echte besluit")
| Aspect | Invulling |
|---|---|
| Gebruiker doet | bedrag (≥ € 50) en looptijd (3, 6, 12, 24, 36 of 60 maanden) kiezen en bevestigen |
| Denkt/voelt | "Wat krijg ik precies terug, wanneer, en wat kan er misgaan?" |
| Kernfeit | vastzetten is **onomkeerbaar tot de einddatum**; het bedrag verdwijnt uit de wallet en wordt een contractuele vordering op SolidYield |
| Succescriterium | de gebruiker kan ná bevestiging in eigen woorden benoemen welk bedrag wanneer wordt uitgekeerd **en welk risico eraan vastzit** (PD-1) |
| Pijnpunten | onomkeerbaarheid te laat duidelijk; risico onbenoemd; rendement gelezen als garantie |
| Risicocommunicatie | debiteurenrisico op SolidYield; beoogde positie bij faillissement is **concurrent schuldeiser** — formulering afhankelijk van **RD-20** en **RD-21** |
| Toegankelijkheid | bedragen niet alleen via kleur duiden; taalniveau B1 |
| Meetpunt | taaksucces; begripsscore op uitkering én risico; % afbreuk op het bevestigingsscherm |
| Bewijs | `[nog te verzamelen]` |

### 5a. Lopend contract en uitkeringen
| Aspect | Invulling |
|---|---|
| Gebruiker doet | volgt maandelijkse uitkeringen, einddatum en verwachte terugbetaling |
| Pijnpunten | onduidelijkheid bij een mislukte of vertraagde uitkering |
| Security | uitkeringen idempotent; elke mutatie in de audittrail |
| Meetpunt | supportvragen per lopend contract |
| Bewijs | `[nog te verzamelen]` |

### 6. Terugkerend gebruik
| Aspect | Invulling |
|---|---|
| Pijnpunten | irrelevante meldingen, geen nieuwe inzichten |
| Security | veilige sessies, opnieuw authenticeren bij gevoelige handelingen |
| Ethiek | geen verslavende of drangmechanismen |
| Meetpunt | wekelijks actieve gebruikers, retentie na 4 weken |

### 7. Hulp nodig
| Aspect | Invulling |
|---|---|
| Pijnpunten | geen menselijke hulp bij geldproblemen |
| Security | supportmedewerker heeft minimale rechten; alle inzage wordt geaudit |
| Meetpunt | opgeloste vragen bij eerste contact |

### 8. Vertrekken
| Aspect | Invulling |
|---|---|
| Gebruiker doet | account sluiten, gegevens exporteren of laten verwijderen |
| Privacy | recht op verwijdering en dataportabiliteit; bewaartermijnen |
| Compliance | wettelijke bewaarplicht kan verwijdering beperken — **te valideren** |
| Meetpunt | doorlooptijd van een verwijderverzoek |
| Ethiek | opzeggen moet even makkelijk zijn als aanmelden |

## Aansluiting op de geld- en contractstroom

De twaalf stappen uit [ADR-0008](../architecture/adr/0008-geld-en-contractstroom.md) vallen
als volgt binnen deze journey:

| Stap (ADR-0008) | Fase in deze journey |
|---|---|
| 1. Account aanmaken | 2. Registreren |
| 2. KYC | 3. Verifiëren |
| 3. Wallet openen | 4. Wallet en storten |
| 4. Geld storten | 4. Wallet en storten |
| 5. Vrij saldo | 4. Wallet en storten |
| 6. Vastzetten | 5. Vastzetten |
| 7. Contract genereren | 5. Vastzetten |
| 8. Investering door SolidYield | buiten het zicht van de gebruiker |
| 9. Maandelijkse rendementuitkering | 5a. Lopend contract |
| 10. Einde looptijd | 5a. Lopend contract |
| 11. Terugbetaling inleg | 5a. Lopend contract |
| 12. Audittrail | alle fasen |

## Momenten van de waarheid

1. Het **bevestigingsscherm bij vastzetten** — het besluit is onomkeerbaar tot de einddatum,
   en dit is het moment waarop PD-1 wordt gehaald of gemist.
2. De **eerste maandelijkse uitkering** — komt binnen wat is beloofd, op het beloofde moment?
3. Het eerste moment dat iets misgaat (mislukte storting, vertraagde uitkering, afwijkend
   bedrag).
4. De **terugbetaling aan het einde van de looptijd**.
5. Het moment dat de gebruiker wil stoppen.

Deze vijf momenten worden **altijd** met de testgroep gevalideerd.
