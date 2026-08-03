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
| 4 | Koppelen / invoeren | mijn financiële gegevens beschikbaar maken |
| 5 | Eerste waarde | het inzicht of resultaat krijgen waarvoor ik kwam |
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

### 3. Verifiëren *(alleen indien vereist)*
| Aspect | Invulling |
|---|---|
| Gebruiker doet | identiteit aantonen |
| Pijnpunten | uitval bij documentcontrole, lange wachttijd, gevoel van wantrouwen |
| Security/compliance | identiteitscontrole en eventuele verplichtingen — **te valideren door bevoegde specialist** |
| Privacy | identiteitsgegevens strikt gescheiden opslaan, korte bewaartermijn |
| Bewijs | `[nog te verzamelen]` |

### 4. Koppelen of invoeren van financiële gegevens
| Aspect | Invulling |
|---|---|
| Gebruiker doet | rekening koppelen of gegevens invoeren |
| Denkt/voelt | "Wat mogen jullie precies zien? Kan ik dit terugdraaien?" |
| Security | toestemmingsflow, scopebeperking, tokens veilig opslaan, intrekken mogelijk |
| Privacy | doelbinding, minimalisatie, toestemming intrekbaar |
| Meetpunt | % succesvolle koppelingen; % dat afbreekt bij het toestemmingsscherm |
| Bewijs | `[nog te verzamelen]` |

### 5. Eerste waarde ("aha-moment")
| Aspect | Invulling |
|---|---|
| Gebruiker doet | ziet voor het eerst het resultaat |
| Succescriterium | binnen `[X]` minuten na registratie zichtbaar |
| Pijnpunten | lege staat, onbegrijpelijke cijfers, verkeerde categorisatie |
| Toegankelijkheid | bedragen niet alleen via kleur duiden |
| Meetpunt | tijd tot eerste waarde; taaksucces in usabilitytests |
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

## Momenten van de waarheid

1. Het toestemmingsscherm bij het koppelen van financiële gegevens.
2. Het eerste inzicht (aha-moment).
3. Het eerste moment dat iets misgaat (fout, afwijkend bedrag, mislukte betaling).
4. Het moment dat de gebruiker wil stoppen.

Deze vier momenten worden **altijd** met de testgroep gevalideerd.
