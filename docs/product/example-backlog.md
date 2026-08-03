# Voorbeeldbacklog (fictief)

Deze backlog is een **realistisch voorbeeld** voor een generieke online financiële dienst.
Alle gegevens, namen en cijfers zijn **fictief**. Gebruik dit als vertrekpunt en vervang
het door je eigen inhoud.

Hiërarchie: `Productdoel → Epic → Feature → User story → taken`.
Labels: zie [`../scrum/labels.md`](../scrum/labels.md).

---

## Productdoel

> **PD-1:** *Binnen zes maanden kan een gebruiker uit `[DOELGROEP]` binnen vijf minuten na
> registratie zien waar het geld in de afgelopen maand naartoe ging, en dat inzicht
> maandelijks blijven gebruiken.*

**Meetwaarden**

| Meetwaarde | Nulmeting | Streefwaarde |
|---|---|---|
| Tijd van registratie tot eerste inzicht | — | ≤ 5 minuten |
| Taaksucces in usabilitytests | — | ≥ 80% |
| Terugkeer binnen 7 dagen | — | ≥ 50% |
| Rapportcijfer "ik begrijp wat ik zie" | — | ≥ 8/10 |

---

## Epic 1 — Veilige toegang tot mijn account

**Doel:** een gebruiker kan een account aanmaken en veilig inloggen, met bescherming die
past bij financiële gegevens.
**Bijdrage aan PD-1:** zonder vertrouwde toegang komt niemand bij het inzicht.
**Risico:** hoog (T-01, T-05, T-08 uit het threat model).
**Labels:** `type:epic`, `priority:critical`, `risk:high`

### Feature 1.1 — Registratie

#### US-101 — Account aanmaken met e-mailverificatie
> Als nieuwe bezoeker wil ik een account aanmaken met mijn e-mailadres, zodat ik mijn
> eigen financiële overzicht kan opbouwen.

**Acceptatiecriteria**
- [ ] Given een bezoeker op het registratiescherm, When deze een geldig e-mailadres en een wachtwoord van minimaal 12 tekens invoert, Then wordt een account aangemaakt in de status "niet geverifieerd" en volgt een verificatiemail.
- [ ] Given een reeds geregistreerd e-mailadres, When de bezoeker registreert, Then toont het systeem dezelfde neutrale bevestigingstekst als bij een nieuw adres (geen prijsgave dat het account bestaat) en ontvangt de bestaande gebruiker een mail dat er een registratiepoging was.
- [ ] Given een wachtwoord dat voorkomt in een lijst met bekende gelekte wachtwoorden, When de bezoeker registreert, Then wordt het geweigerd met een begrijpelijke uitleg.
- [ ] Given een niet-geverifieerd account, When de gebruiker probeert in te loggen, Then krijgt die de melding dat verificatie nodig is en de mogelijkheid de mail opnieuw te ontvangen (maximaal `3` keer per uur).
- [ ] Given meer dan `5` registratiepogingen per IP per minuut, When er opnieuw wordt geprobeerd, Then geldt snelheidsbeperking.
- [ ] Given een aangemaakt account, Then bevat het auditlog een gebeurtenis `account.created` met tijdstip, resultaat en correlatie-ID, en géén wachtwoord.

**Story points:** 5 · **Security-impact:** hoog · **Privacy-impact:** nieuwe verwerking ·
**Compliance-impact:** raakt control DP-04 · **Labels:** `type:user-story`, `priority:critical`, `risk:high`

Bijbehorende taken:
* `TT-101a` Technische taak — wachtwoordhashing met Argon2id, parameters vastgelegd in een ADR
* `TT-101b` Technische taak — transactionele e-maildienst koppelen (sandbox in test)
* `ST-101c` Securitytaak — snelheidsbeperking op registratie en verificatiemail
* `PT-101d` Privacytaak — vastleggen doel, grondslag en bewaartermijn van accountgegevens
* `TS-101e` Testtaak — securitytest S-4 (snelheidsbeperking) en e2e-registratie

#### US-102 — E-mailadres bevestigen
> Als nieuwe gebruiker wil ik mijn e-mailadres bevestigen, zodat ik zeker weet dat
> herstelberichten mij bereiken.

**Acceptatiecriteria**
- [ ] Given een geldige verificatielink (eenmalig, geldig `24` uur), When de gebruiker deze opent, Then wordt het account geverifieerd en volgt een bevestiging.
- [ ] Given een verlopen of al gebruikte link, When deze wordt geopend, Then verschijnt een begrijpelijke melding met de mogelijkheid een nieuwe link aan te vragen.
- [ ] Given een geopende link, Then bevat de URL geen persoonsgegevens en is het token niet raadbaar (minimaal 128 bits entropie).
- [ ] Given verificatie, Then wordt `account.verified` in het auditlog vastgelegd.

**Story points:** 3 · **Security-impact:** hoog · **Labels:** `type:user-story`, `priority:critical`, `risk:high`

### Feature 1.2 — Inloggen en sessiebeheer

#### US-103 — Inloggen met multifactor-authenticatie
> Als gebruiker wil ik inloggen met een tweede factor, zodat iemand met alleen mijn
> wachtwoord niet bij mijn financiële gegevens kan.

**Acceptatiecriteria**
- [ ] Given een geverifieerd account met MFA ingesteld, When de gebruiker correcte inloggegevens en een geldige tweede factor invoert, Then krijgt die toegang en wordt `login.success` gelogd.
- [ ] Given een correcte gebruikersnaam met fout wachtwoord, When wordt ingelogd, Then verschijnt een neutrale melding die niet verraadt welk onderdeel fout was.
- [ ] Given `5` mislukte pogingen binnen `15` minuten, When opnieuw wordt geprobeerd, Then treedt progressieve vertraging op en wordt de gebruiker per e-mail geïnformeerd.
- [ ] Given een inlog vanaf een onbekend apparaat, When deze slaagt, Then ontvangt de gebruiker een melding.
- [ ] Given een account zonder MFA, When de gebruiker inlogt, Then wordt MFA-instellen afgedwongen vóór toegang tot financiële gegevens.
- [ ] Given een gebruiker zonder smartphone, Then is er minimaal één alternatieve tweede factor beschikbaar.

**Story points:** 8 · **Security-impact:** hoog · **Labels:** `type:user-story`, `priority:critical`, `risk:high`

Bijbehorende taken:
* `TT-103a` Technische taak — koppeling met `[IDP]` (OIDC, authorization code + PKCE)
* `ST-103b` Securitytaak — herstelcodes: eenmalig gebruik, veilige opslag
* `ST-103c` Securitytaak — meldingen bij nieuwe login en MFA-wijziging
* `TS-103d` Testtaak — securitytests S-2, S-4, S-6

#### US-104 — Sessie verloopt en uitloggen werkt overal
> Als gebruiker wil ik dat mijn sessie automatisch verloopt en dat ik overal kan
> uitloggen, zodat mijn gegevens veilig blijven op een gedeeld apparaat.

**Acceptatiecriteria**
- [ ] Given een sessie zonder activiteit gedurende `15` minuten, When de gebruiker iets doet, Then is de sessie verlopen en volgt een nette herauthenticatie zonder verlies van context.
- [ ] Given een actieve sessie, When de gebruiker "log overal uit" kiest, Then zijn alle sessies op alle apparaten binnen `60` seconden ongeldig.
- [ ] Given uitloggen, Then wordt het sessietoken serverseitig ingetrokken (niet alleen client-side verwijderd).
- [ ] Given een sessiecookie, Then heeft die de vlaggen `Secure`, `HttpOnly` en `SameSite`.
- [ ] Given een absolute sessieduur van `8` uur, When die is bereikt, Then is herauthenticatie verplicht.

**Story points:** 5 · **Security-impact:** hoog · **Labels:** `type:user-story`, `priority:high`, `risk:high`

---

## Epic 2 — Inzicht in mijn geld

**Doel:** de gebruiker ziet begrijpelijk waar het geld naartoe ging.
**Bijdrage aan PD-1:** dit is het aha-moment.
**Risico:** hoog (onjuiste of misleidende informatie).
**Labels:** `type:epic`, `priority:critical`, `risk:high`

### Feature 2.1 — Financiële gegevens beschikbaar maken

#### US-201 — Gegevens koppelen met expliciete toestemming
> Als gebruiker wil ik mijn financiële gegevens koppelen na een duidelijke uitleg, zodat
> ik weet waar ik ja tegen zeg.

**Acceptatiecriteria**
- [ ] Given het toestemmingsscherm, When de gebruiker dit ziet, Then staat in begrijpelijke taal (streefniveau B1) welke gegevens worden opgehaald, waarvoor, hoe lang ze worden bewaard en hoe de toestemming is in te trekken.
- [ ] Given het toestemmingsscherm, Then staat er geen vooraf aangevinkt vakje en is weigeren even eenvoudig als toestemmen.
- [ ] Given verleende toestemming, When de koppeling slaagt, Then worden alleen de gegevens opgehaald die binnen de afgesproken scope vallen.
- [ ] Given verleende toestemming, Then wordt vastgelegd: tijdstip, versie van de tekst, scope en kanaal.
- [ ] Given een mislukte koppeling, When dit gebeurt, Then ziet de gebruiker een begrijpelijke melding met een vervolgstap en geen technische foutcode.
- [ ] Given de koppeling, Then worden tokens versleuteld opgeslagen in de secrets manager en nooit gelogd.

**Story points:** 8 · **Security-impact:** hoog · **Privacy-impact:** nieuwe verwerking, DPIA-toets ·
**Compliance-impact:** mogelijk nieuwe verplichting — te valideren · **Labels:** `type:user-story`, `priority:critical`, `risk:high`

#### US-202 — Toestemming intrekken
> Als gebruiker wil ik mijn toestemming kunnen intrekken, zodat ik de controle houd over
> mijn gegevens.

**Acceptatiecriteria**
- [ ] Given een actieve koppeling, When de gebruiker toestemming intrekt, Then stopt het ophalen van nieuwe gegevens direct en wordt het token bij de bron ingetrokken.
- [ ] Given ingetrokken toestemming, When de gebruiker de keuze bevestigt, Then wordt duidelijk uitgelegd wat er met de reeds opgehaalde gegevens gebeurt en binnen welke termijn.
- [ ] Given intrekking, Then wordt `consent.revoked` in het auditlog vastgelegd.
- [ ] Given intrekking, When de bewaartermijn verstrijkt, Then zijn de betrokken gegevens verwijderd of geanonimiseerd (aantoonbaar via de verwijderroutine).
- [ ] Given intrekking, Then is opnieuw toestemming geven mogelijk zonder een nieuw account.

**Story points:** 5 · **Privacy-impact:** hoog · **Labels:** `type:user-story`, `priority:high`, `risk:high`

### Feature 2.2 — Maandoverzicht

#### US-203 — Uitgaven per categorie in de huidige maand zien
> Als gebruiker wil ik mijn uitgaven per categorie zien, zodat ik begrijp waar mijn geld
> naartoe gaat.

**Acceptatiecriteria**
- [ ] Given een gebruiker met minimaal één transactie in de huidige maand, When het dashboard wordt geopend, Then verschijnt het totaal per categorie, aflopend gesorteerd, met datum van de laatste bijwerking.
- [ ] Given een gebruiker zonder transacties, When het dashboard wordt geopend, Then verschijnt een lege staat met uitleg en een vervolgstap — geen foutmelding.
- [ ] Given getoonde bedragen, Then zijn ze correct afgerond op twee decimalen, in `[VALUTA]`, en komt de som van de categorieën exact overeen met het totaal.
- [ ] Given een niet-ingelogde bezoeker, When de pagina direct wordt opgevraagd, Then volgt een redirect naar inloggen en worden geen gegevens getoond of gelogd.
- [ ] Given gebruiker A, When deze het overzicht van gebruiker B probeert op te vragen, Then volgt een `403`/`404` zonder informatie over het bestaan van die gegevens.
- [ ] Given een gebruiker met een schermlezer, Then zijn categorieën en bedragen als tekst beschikbaar en niet uitsluitend via kleur onderscheiden.
- [ ] Given gegevens ouder dan `60` minuten, Then toont het scherm de versheid ("bijgewerkt om …").

**Story points:** 8 · **Security-impact:** hoog (T-05) · **Labels:** `type:user-story`, `priority:critical`, `risk:high`

Bijbehorende taken:
* `TT-203a` Technische taak — berekeningslogica met expliciete afronding, volledig unit-getest
* `ST-203b` Securitytaak — autorisatie op objectniveau + test S-1
* `TT-203c` Technische taak — versheid en tijdstempel van gegevens
* `TS-203d` Testtaak — toegankelijkheidstest van het dashboard

#### US-204 — Onderliggende transacties bekijken
> Als gebruiker wil ik de transacties achter een categorie zien, zodat ik het getal kan
> controleren en vertrouwen.

**Acceptatiecriteria**
- [ ] Given een categorie op het dashboard, When de gebruiker deze opent, Then verschijnt de lijst met transacties (datum, omschrijving, bedrag), gepagineerd met maximaal `50` per pagina.
- [ ] Given de lijst, Then telt de som van de getoonde transacties op tot het categoriebedrag.
- [ ] Given een transactie met een afwijkende of onbekende categorie, Then is die zichtbaar als "niet gecategoriseerd" en kan de gebruiker dit melden.
- [ ] Given de lijst, Then bevat geen enkel scherm of logregel gegevens van een andere gebruiker.
- [ ] Given een grote hoeveelheid transacties, Then laadt de eerste pagina binnen `[500]` ms (p95).

**Story points:** 5 · **Labels:** `type:user-story`, `priority:high`, `risk:medium`

---

## Epic 3 — Vertrouwen, controle en transparantie

**Doel:** de gebruiker kan zien wat er met de gegevens gebeurt, houdt controle en krijgt
tijdig relevante meldingen.
**Bijdrage aan PD-1:** zonder vertrouwen komt de gebruiker niet terug.
**Labels:** `type:epic`, `priority:high`, `risk:high`

### Feature 3.1 — Controle over mijn gegevens

#### US-301 — Mijn gegevens exporteren
> Als gebruiker wil ik mijn gegevens kunnen downloaden, zodat ik ze zelf kan bewaren of
> meenemen.

**Acceptatiecriteria**
- [ ] Given een ingelogde gebruiker, When deze een export aanvraagt, Then wordt herauthenticatie gevraagd en volgt binnen `[24]` uur een machineleesbaar bestand (JSON of CSV).
- [ ] Given een export, Then bevat het alleen gegevens van de aanvrager en geen interne technische velden.
- [ ] Given een exportbestand, Then is het beschikbaar via een eenmalige, verlopende link (`[24]` uur) en niet publiek toegankelijk.
- [ ] Given een export, Then wordt `data.exported` in het auditlog vastgelegd.
- [ ] Given meer dan `3` exportverzoeken per dag, Then treedt snelheidsbeperking op (misbruikpreventie).

**Story points:** 5 · **Privacy-impact:** hoog · **Compliance-impact:** raakt control DP-07 ·
**Labels:** `type:user-story`, `priority:high`, `risk:high`

#### US-302 — Mijn account en gegevens verwijderen
> Als gebruiker wil ik mijn account kunnen verwijderen, zodat mijn gegevens niet langer
> worden bewaard dan ik wil.

**Acceptatiecriteria**
- [ ] Given een ingelogde gebruiker, When deze verwijdering aanvraagt, Then volgt herauthenticatie en een duidelijke uitleg over wat wordt verwijderd, wat (wegens een bewaarplicht) blijft en hoe lang dat duurt.
- [ ] Given een bevestigde aanvraag, When de termijn `[30]` dagen verstrijkt, Then zijn de persoonsgegevens verwijderd of geanonimiseerd, aantoonbaar via de verwijderroutine.
- [ ] Given een verwijderde account, When de gebruiker probeert in te loggen, Then is dat niet meer mogelijk en worden geen gegevens getoond.
- [ ] Given verwijdering, Then blijven uitsluitend de gegevens bestaan waarvoor een vastgelegde bewaarplicht geldt, met beperkte toegang.
- [ ] Given verwijdering, Then wordt `account.deletion_requested` en later `account.deleted` gelogd.
- [ ] Given herstel uit een back-up, Then wordt het verwijderverzoek opnieuw toegepast.

**Story points:** 8 · **Privacy-impact:** hoog · **Compliance-impact:** te valideren ·
**Labels:** `type:user-story`, `priority:high`, `risk:high`

### Feature 3.2 — Meldingen en activiteitenoverzicht

#### US-303 — Beveiligingsmeldingen ontvangen
> Als gebruiker wil ik bericht krijgen bij belangrijke gebeurtenissen op mijn account,
> zodat ik misbruik snel opmerk.

**Acceptatiecriteria**
- [ ] Given een inlog vanaf een onbekend apparaat, een wachtwoordwijziging, een MFA-wijziging of een export, When dit gebeurt, Then ontvangt de gebruiker binnen `5` minuten een melding.
- [ ] Given een melding, Then bevat die geen bedragen, rekeninggegevens of andere financiële details.
- [ ] Given een melding, Then staat erin wat de gebruiker moet doen als die het niet zelf was, met een directe route naar hulp.
- [ ] Given beveiligingsmeldingen, Then kunnen die **niet** worden uitgezet (in tegenstelling tot productmeldingen).
- [ ] Given een storing bij de berichtendienst, When verzending faalt, Then volgt een retry en een alarm; de gebeurtenis blijft in het activiteitenoverzicht zichtbaar.

**Story points:** 5 · **Security-impact:** hoog · **Labels:** `type:user-story`, `priority:high`, `risk:medium`

#### US-304 — Activiteitenoverzicht van mijn account inzien
> Als gebruiker wil ik zien wat er op mijn account is gebeurd, zodat ik zelf kan
> controleren of alles klopt.

**Acceptatiecriteria**
- [ ] Given een ingelogde gebruiker, When deze het activiteitenoverzicht opent, Then ziet die de laatste `[90]` dagen aan gebeurtenissen: inloggen, MFA-wijzigingen, toestemming geven/intrekken, exports en verwijderverzoeken.
- [ ] Given een gebeurtenis, Then bevat de regel tijdstip, type en globale locatie/apparaat — en geen technische details of interne ID's.
- [ ] Given inzage door een supportmedewerker, When die de gegevens van deze gebruiker bekijkt, Then is dat zichtbaar in het overzicht met de reden van inzage.
- [ ] Given het overzicht, Then is het niet bewerkbaar door de gebruiker en niet door support.

**Story points:** 5 · **Security-impact:** middel · **Compliance-impact:** raakt control OP-02 ·
**Labels:** `type:user-story`, `priority:medium`, `risk:medium`

---

## Overige backlogitems

### Technische taken
| ID | Titel | Waarom | Punten |
|---|---|---|---|
| TT-001 | Keuze technologiestack vastleggen in ADR-0002 | fundament voor al het werk | 3 |
| TT-002 | Cloudprovider en regio vastleggen in ADR-0003 | bepaalt dataresidency | 3 |
| TT-003 | CI/CD werkend maken voor de gekozen stack (`TEMPLATE_STRICT=true`) | kwaliteitspoort actief | 5 |
| TT-004 | Basisinfrastructuur als code (test + staging) | reproduceerbaarheid | 8 |
| TT-005 | Gestructureerde logging met correlatie-ID | onderzoekbaarheid | 3 |
| TT-006 | Foutafhandelingskader zonder informatielek | veiligheid en UX | 3 |
| TT-007 | Synthetische testdatagenerator | geen productiedata nodig | 5 |
| TT-008 | Feature-flagmechanisme | veilig uitrollen en terugvallen | 3 |

### Securitytaken
| ID | Titel | Dreiging | Punten |
|---|---|---|---|
| ST-001 | Threat modelling voor epic 1 en 2 | alle | 3 |
| ST-002 | Secrets manager inrichten en rotatiebeleid | T-11 | 5 |
| ST-003 | Snelheidsbeperking op inloggen, registreren en exporteren | T-01, T-07 | 3 |
| ST-004 | Beveiligingsheaders en CSP | T-06 | 2 |
| ST-005 | Auditlog implementeren (append-only) | T-04 | 5 |
| ST-006 | Autorisatietests per endpoint (S-1, S-2) | T-05, T-08 | 5 |
| ST-007 | Pentest inplannen en opvolgen | alle | 3 |

### Privacy- en compliancetaken
| ID | Titel | Punten |
|---|---|---|
| PT-001 | Gegevensclassificatie invullen voor alle velden | 3 |
| PT-002 | DPIA uitvoeren voor de kernverwerking | 5 |
| PT-003 | Bewaartermijnen bevestigen en verwijderroutines bouwen | 5 |
| PT-004 | Toestemmingsregistratie en intrekking aantoonbaar maken | 3 |
| CT-001 | Complianceregister vullen en eigenaren toewijzen | 3 |
| CT-002 | Regulatoire vragen RD-01 en RD-14 voorleggen aan een specialist | 2 |
| CT-003 | Verwerkersovereenkomsten met `[LEVERANCIER]` regelen | 3 |

### Onderzoekstaken
| ID | Titel | Timebox | Punten |
|---|---|---|---|
| RS-001 | 8 interviews met `[DOELGROEP]` over `[PROBLEEM]` | 5 dagen | 8 |
| RS-002 | Spike: haalbaarheid en betrouwbaarheid van gegevensbron `[PROVIDER]` | 2 dagen | 3 |
| RS-003 | Spike: MFA-methoden en toegankelijkheid | 1 dag | 2 |
| RS-004 | Usabilitytest registratie + MFA (6 deelnemers) | 3 dagen | 5 |
| RS-005 | Usabilitytest maandoverzicht (6 deelnemers) | 3 dagen | 5 |
| RS-006 | Werving en toestemming testgroep inrichten | 3 dagen | 3 |

### Bugs (voorbeeld)
| ID | Titel | Ernst |
|---|---|---|
| BUG-001 | *(voorbeeld)* Bedragen worden in het overzicht afgerond op hele euro's | hoog |
| BUG-002 | *(voorbeeld)* Foutmelding toont technische stacktrace bij mislukte koppeling | hoog |

---

## Prioritering (MoSCoW voor de MVP)

| Must have | Should have | Could have | Won't have (nu) |
|---|---|---|---|
| US-101, US-102, US-103, US-104 | US-204, US-303 | US-304 | betalingen initiëren |
| US-201, US-202, US-203 | | | meerdere koppelingen |
| US-301, US-302 | | | mobiele app |
| ST-001 t/m ST-006, PT-001 t/m PT-004 | ST-007, CT-003 | | AI-advies |
| TT-001 t/m TT-003, TT-005, TT-006 | TT-004, TT-007, TT-008 | | meertaligheid |
| RS-001, RS-002, RS-006 | RS-003, RS-004, RS-005 | | |

Sprintvoorstel: [`../scrum/sprint-plan-example.md`](../scrum/sprint-plan-example.md).
