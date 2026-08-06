# Threat model

Threat modelling beantwoordt vier vragen: *wat bouwen we?* · *wat kan er misgaan?* ·
*wat doen we eraan?* · *hebben we het goed gedaan?*

**Ritme:** per epic vóór de bouw, bij elke wijziging aan een vertrouwensgrens, en
minimaal elk kwartaal opnieuw. Werkblad voor een epic:
[`epic-threat-checklist.md`](epic-threat-checklist.md). **Deelnemers:** securityverantwoordelijke, tech lead,
minimaal één developer, en bij gegevens de privacyverantwoordelijke.

> Dit document bevat **geen** exploitdetails. Concrete kwetsbaarheden horen niet in een
> publieke repository — zie [`../../SECURITY.md`](../../SECURITY.md).

## 1. Scope

| Onderwerp | Invulling |
|---|---|
| Systeem | SolidYield, zie [`system-context.md`](system-context.md) |
| Vertrouwensgrenzen | TB-1 t/m TB-5 uit de systeemcontext |
| Belangrijkste bezittingen | gebruikersgegevens, financiële gegevens, geld(stromen), authenticatiemiddelen, auditlog, sleutels, broncode en pipeline |
| Buiten scope | fysieke beveiliging van de TransIP-datacenters, interne systemen van de betaalpartners |
| Bedrijfsmodel | vastgesteld (besluit 4, [`adr/0007-vergunningplicht-en-rol-in-de-keten.md`](adr/0007-vergunningplicht-en-rol-in-de-keten.md)): SolidYield is contractspartij en houdt de wallet; betalingen lopen via vergunninghoudende betaalpartners |
| Fase | tot de wettelijke grondslag is bevestigd draait de MVP met sandboxbetalingen en synthetische data — geen echte klantgelden |
| Technische architectuur | twee zelf beheerde TransIP VPS'en (productie en test), Ubuntu Server LTS, Nginx, Kotlin/Spring Boot, PostgreSQL, WireGuard voor beheer ([ADR-0002](adr/0002-technologiestack.md), [ADR-0003](adr/0003-cloudprovider.md)) |

## 2. Aanvallers

| Aanvaller | Motief | Middelen |
|---|---|---|
| Opportunistische crimineel | geld | geautomatiseerde scans, gelekte wachtwoorden |
| Gerichte fraudeur | geld van een specifieke gebruiker | social engineering, phishing, accountovername |
| Misbruikende gebruiker | eigen voordeel, toegang tot andermans gegevens | legitieme toegang, manipulatie van verzoeken |
| Kwaadwillende insider | geld, gegevens | legitieme rechten |
| Toeleveringsketen-aanvaller | breed bereik | kwaadaardige afhankelijkheid, gekaapte build |
| Naaste met dwang | controle over de gebruiker | fysieke toegang tot apparaat |

Die laatste is bij financiële diensten reëel: ontwerp zo dat een gebruiker onder dwang
niet extra kwetsbaar wordt (geen onnodige historie op het startscherm, mogelijkheid om
snel uit te loggen).

## 3. Dreigingen volgens STRIDE

| ID | STRIDE | Dreiging | Grens | Risico | Maatregelen | Verificatie |
|---|---|---|---|---|---|---|
| T-01 | Spoofing | Accountovername via gelekt wachtwoord | TB-1 | **Hoog** | MFA verplicht, controle tegen bekende gelekte wachtwoorden, snelheidsbeperking, melding bij nieuwe login | securitytest inlogbeperking |
| T-02 | Spoofing | Phishing gericht op gebruikers | TB-1 | Hoog | duidelijke communicatie, nooit om wachtwoord vragen, domeinbescherming (SPF/DKIM/DMARC) | reviewcheck bij elke e-mail |
| T-03 | Tampering | Manipulatie van bedragen of parameters in verzoeken | TB-1 | **Hoog** | serverseitige validatie en herberekening; nooit vertrouwen op clientwaarden | unit- en securitytests |
| T-04 | Repudiation | Gebruiker of medewerker ontkent een handeling | TB-4 | Middel | append-only auditlog met tijd, actor en context | auditlogtest |
| T-05 | Information disclosure | Gegevens van gebruiker A zichtbaar voor B (IDOR) | TB-1 | **Hoog** | autorisatie op objectniveau bij elk verzoek | verplichte test per endpoint |
| T-06 | Information disclosure | Persoonsgegevens in logs, foutmeldingen of URL's | TB-2 | Hoog | logfilters, generieke foutmeldingen, codereviewcheck | logreview + SAST-regel |
| T-07 | DoS | Overbelasting van inlog of API | TB-1 | Middel | rate limiting per IP en per account, quota, autoscaling | belastingstest |
| T-08 | Elevation of privilege | Gebruiker verkrijgt beheerrechten | TB-1 | **Hoog** | rolcontrole serverseitig, geen rol uit clientgegevens, minimale rechten | securitytest |
| T-09 | Supply chain | Kwaadaardige of gekaapte afhankelijkheid | TB-3 | Hoog | lockfiles, dependency review, SBOM, scans, geen automatische major-updates | pipeline |
| T-10 | Supply chain | Gecompromitteerde CI/CD-pipeline | TB-4 | **Hoog** | minimale workflowrechten, beveiligde omgevingen, vier-ogen op pipelinewijzigingen, OIDC in plaats van langlevende sleutels | CODEOWNERS + review |
| T-11 | Information disclosure | Secret in de repository | TB-4 | **Hoog** | secret scanning + push protection, secrets manager, rotatiebeleid | `security-scan.yml` |
| T-12 | Tampering | Onbevoegde wijziging van productie | TB-4 | Hoog | required reviewers op de productie-environment, geen directe toegang, alles geaudit | environmentconfiguratie |
| T-13 | Fraude | Misbruik van transactie- of limietlogica | TB-1 | **Hoog** | serverseitige limieten, snelheidscontroles, afwijkingsdetectie, handmatige controle boven `[BEDRAG]` | domeintests + monitoring |
| T-14 | Fraude | Geautomatiseerde massaregistratie | TB-1 | Middel | e-mailverificatie, snelheidsbeperking, botdetectie | monitoring |
| T-15 | Information disclosure | Sessie blijft actief op een gedeeld apparaat | TB-1 | Middel | korte time-out, expliciet uitloggen, herauthenticatie bij gevoelige acties | e2e-test |
| T-16 | Tampering | Onbevoegde toegang tot back-ups | TB-2 | Hoog | aparte sleutels, strikte rechten, MFA, hersteltests | kwartaaltest |
| T-17 | Information disclosure | Productiedata in een testomgeving | TB-5 | **Hoog** | technisch en organisatorisch verbod, uitsluitend synthetische data, controle in de pipeline | reviewcheck |
| T-18 | Denial | Uitval van een betaalpartner | TB-3 | Middel | circuit breaker, degradatie met tijdstempel, uitwijkleverancier onderzoeken; **geen** saldomutatie zonder bevestigde ontvangst | chaos-/faaltest |
| T-19 | Tampering | Vastgezet bedrag of contractvoorwaarden worden na het sluiten gewijzigd | TB-1 | **Hoog** | contract onveranderlijk na bevestiging; elke mutatie append-only in de audittrail; serverseitige herberekening | domein- en auditlogtests |
| T-20 | Tampering | Dubbele of gemiste rendementuitkering door een herhaalde verwerkingsronde | TB-4 | **Hoog** | idempotente verwerking per contract en periode; reconciliatie tegen bankmutaties | domeintests + reconciliatiecontrole |
| T-21 | Fraude | Storting wordt bijgeschreven zonder bevestigde ontvangst | TB-3 | **Hoog** | vrij saldo pas bijschrijven na bevestigde reconciliatie, niet op een statusmelding | integratietests met sandbox |
| T-22 | Repudiation | Onduidelijkheid over wat de gebruiker vóór het vastzetten te zien kreeg | TB-4 | Hoog | bevestigingsscherm en getoonde voorwaarden vastleggen in de audittrail | auditlogtest |
| T-23 | Compliance | Echte klantgelden of bindende contracten vóór bevestiging van de wettelijke grondslag | TB-5 | **Hoog** | technische en organisatorische blokkade: sandboxbetalingen en synthetische data afgedwongen; productiedeployment uit (`PRODUCTION_DEPLOY_ENABLED`) | reviewcheck + pipelinecontrole |
| T-24 | Elevation of privilege | Onbevoegde toegang tot een VPS via SSH of beheerinterface | TB-4 | **Hoog** | beheer uitsluitend via **WireGuard**; geen wachtwoordauthenticatie; firewall standaard dicht; aparte serviceaccounts per systemd-proces | configuratietest + toegangsreview |
| T-25 | Tampering | Schemawijziging of datacorrectie buiten de applicatie om, rechtstreeks op de database | TB-4 | **Hoog** | vier gescheiden databasegebruikers; runtime mag geen schema wijzigen; **directe databasecorrecties zijn verboden**, correcties lopen via de beheerinterface met maker-checker en audittrail | rechtencontrole + auditlogtest |
| T-26 | Information disclosure | Object-storagecredentials of langlevende URL's bereiken de client | TB-1 | Hoog | de frontend krijgt **nooit** credentials; uitsluitend korte presigned URL's vanuit de backend | securitytest |
| T-27 | Information disclosure | Testomgeving of testback-up bevat of lekt productiegegevens; een credential van de ene omgeving geeft toegang tot de bucket van de andere | TB-5 | **Hoog** | productie en test delen niets (databases, gebruikers, accounts, secrets, buckets, monitoring, logging, back-ups); **unieke bucketnamen** (`solidyield-production-*` / `solidyield-test-*`) en **afzonderlijke** Object Store-credentials, access keys, endpoints/IAM-principals, encryptiesleutels en lifecycle-/retentieconfiguraties, zodat een productiecredential technisch geen toegang tot test geeft en omgekeerd; test uitsluitend via WireGuard en met synthetische data | configuratiecontrole + **negatieve toegangstest per omgeving** + reviewcheck |
| T-28 | Denial | Uitval van de enige productie-VPS | TB-3 | Hoog | back-up en disaster recovery op een geografisch gescheiden secundaire locatie binnen de EER; herstelproef periodiek uitvoeren. **Er is geen automatische failover** | hersteltest |
| T-29 | Denial | Verlies van of blokkade op het provideraccount, uitval van het control plane, of contractbeëindiging bij TransIP — alle omgevingen én de back-ups staan daar | TB-3 | **Hoog** | **niet afgedekt; bewust geaccepteerd voor de MVP.** Een geografisch gescheiden secundaire locatie bij dezelfde provider dekt dit niet. Periodieke herbeoordeling; vóór echte klantgelden beoordelen of een back-upkopie buiten het provideraccount nodig is ([ADR-0003](adr/0003-cloudprovider.md), vervolgactie 4a) | periodieke risicoherbeoordeling |
| T-30 | Spoofing | **Recovery als omweg om passkeys en MFA heen** — accountovername via wachtwoord-, passkey- of MFA-herstel in plaats van via authenticatie | TB-1 | **Hoog** | recovery heeft **nooit** een lager beveiligingsniveau dan reguliere authenticatie; bij gevoelige recovery identiteitscontrole, volledige audit en wachttijd of handmatige beoordeling ([ADR-0004](adr/0004-identity-and-access-management.md)) | negatieve tests op elk herstelpad + auditlogtest |
| T-31 | Elevation of privilege | **Beheerder kent zichzelf of een ander rechten toe**, of reset MFA om toegang te krijgen | TB-4 | **Hoog** | geen algemene super administrator; `Administrator` en `Security Administrator` gescheiden; **maker-checker verplicht** voor rolwijzigingen en MFA-resets; elke rolwijziging geaudit (C-26, ADR-0004) | rechtencontrole + auditlogtest |
| T-32 | Denial | **Uitval of blokkade van de Identity Provider** — niemand kan inloggen, ook beheerders niet | TB-3 | Hoog | beschikbaarheid, back-up en herstelscenario van de IdP zijn onderdeel van de leveranciersselectie (ADR-0004 vervolgactie 5); de adaptergrens houdt vervanging mogelijk zonder wijziging aan de domeinlogica | leveranciersbeoordeling + hersteltest |
| T-33 | Tampering | **Leveranciersspecifieke IAM-code lekt de domeinmodules in**, waardoor de provider feitelijk onvervangbaar wordt | TB-4 | Middel | koppeling uitsluitend via de IdP-adapter; **architectuurtest** die imports buiten de adapter laat falen (C-36); Spring Modulith-modulegrenzen | architectuurtest in CI |

## 4. Risicomatrix

| Impact ↓ / Kans → | Laag | Middel | Hoog |
|---|---|---|---|
| **Zeer hoog** | T-16 | T-05, T-10, T-13, T-17 | T-01 |
| **Hoog** | T-12 | T-03, T-06, T-08, T-09, T-11 | T-02 |
| **Middel** | T-18 | T-04, T-15 | T-07, T-14 |

Alles in de rechterbovenhoek is **blokkerend voor productie**.

## 5. Van dreiging naar backlog

Elke dreiging met risico *Hoog* of hoger krijgt:

1. een issue via `security-issue.yml` met verwijzing naar het T-nummer;
2. een geautomatiseerde test in `tests/security/` die de maatregel bewaakt;
3. een regel in [`../compliance/control-mapping.md`](../compliance/control-mapping.md);
4. bewijs in [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md).

## 6. Restrisico's

| # | Restrisico | Waarom aanvaard | Compenserende maatregel | Houdbaar tot | Geaccepteerd door |
|---|---|---|---|---|---|
| RR-1 | `[RESTRISICO]` | `[REDEN]` | `[MAATREGEL]` | `[DATUM]` | `[MANDAATHOUDER]` |
| RR-2 | **Concentratierisico bij één provider** (T-29): productie, test, objectopslag en back-ups staan alle bij TransIP; account-, control-plane-, contract- en providerbrede uitval is niet afgedekt | bewust geaccepteerd voor de MVP; een tweede provider is voor de MVP niet ingericht | geografisch gescheiden secundaire locatie (dekt alleen locatiegebonden uitval), periodieke hersteltest, en **periodieke herbeoordeling** van dit risico — herzieningstrigger voor [ADR-0003](adr/0003-cloudprovider.md) | **vóór echte klantgelden** opnieuw te beoordelen | `[MANDAATHOUDER]` |

Risicoacceptatie volgt de procedure uit [`../../GOVERNANCE.md`](../../GOVERNANCE.md).
Kritieke en hoge risico's kan het team niet zelf accepteren.

## 7. Herzieningslog

| Datum | Aanleiding | Wijzigingen | Deelnemers |
|---|---|---|---|
| `[JJJJ-MM-DD]` | eerste opzet | T-01 t/m T-18 vastgesteld | `[NAMEN]` |
