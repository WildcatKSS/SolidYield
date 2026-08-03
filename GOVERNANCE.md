# Governance

Dit document beschrijft mandaten en besluitvorming. Het bouwt voort op
[`docs/scrum/roles.md`](docs/scrum/roles.md), waarin het onderscheid staat tussen
Scrum-accountabilities (Product Owner, Scrum Master, Developers), vakexpertise binnen de
Developers, onafhankelijke governancerollen en stakeholders.

## 1. Mandaten

| Wie | Positie | Beslist over | Beslist niet over | Escalatie naar |
|---|---|---|---|---|
| **Product Owner** | Scrum Team | backlogprioriteit, scope, productdoel, en of/wanneer een Done increment wordt vrijgegeven | technische uitvoering, of iets Done is, securityafwijkingen, juridische conclusies | `[STUURGROEP/OPDRACHTGEVER]` |
| **Scrum Master** | Scrum Team | proces, events, wegnemen van belemmeringen | inhoud en volgorde van de backlog | `[MANAGEMENT]` |
| **Developers** | Scrum Team | technische uitvoering, ontwerp binnen kaders, schattingen, en de vaststelling dát het increment aan de DoD voldoet | prioriteit en productrichting | Tech lead |
| **Tech lead / architect** | Developers | architectuurkaders, ADR-besluiten | productprioriteit | CTO / `[ROL]` |
| **Security officer** | governance (onafhankelijk) | securityeisen; een openstaande kritieke/hoge kwetsbaarheid **blokkeert de release** | productprioriteit; of iets Done is | CISO / `[ROL]` |
| **DPO** | governance (wettelijk onafhankelijk) | **advies en toezicht**: monitort naleving, adviseert over DPIA's, rapporteert onafhankelijk, escaleert ernstige risico's | operationele product- en verwerkingsbesluiten; risicoacceptatie namens de organisatie | `[BESTUUR]` |
| **Privacy officer / operationele privacyfunctie** | governance of Developers | registers, transparantie, bewaartermijnen, privacyvereisten; operationele beoordelingen binnen mandaat | wettelijke toepasselijkheid vaststellen | DPO / `[BESTUUR]` |
| **Compliance officer** | governance | complianceregister, controls, bewijsvoering; een blokkerende compliancevraag **blokkeert de release** | productprioriteit | `[BESTUUR]` |
| **Verwerkingsverantwoordelijke / mandaathouder** | formeel mandaat | het uiteindelijke besluit; accepteert of weigert organisatorische risico's; beslist over doorgang na ontvangen DPO-advies | technische uitvoering | `[BESTUUR]` |
| **Deelnemers testgroep** | onderzoeksdeelnemers | niets — zij leveren gedrag, ervaringen en feedback | scope of prioriteit | coördinator testgroep |

> **Done staat niet in deze tabel als beslissing van één persoon.** Of een item Done is,
> volgt uit de [Definition of Done](docs/scrum/definition-of-done.md): objectief,
> aantoonbaar en vastgesteld door de Developers. Een blokkerend punt houdt de **release**
> tegen, maar verandert nooit of werk af is.

**Blokkerend** betekent: de release gaat niet door totdat het punt is opgelost óf
aantoonbaar en gedocumenteerd is geaccepteerd door de daartoe bevoegde mandaathouder
(zie §4). Het is geen persoonlijk vetorecht: het is een openstaand risico dat een besluit
vraagt van wie dat besluit mag nemen.

## 2. Besluitvorming

| Type besluit | Wie beslist | Vastlegging |
|---|---|---|
| Backlogprioriteit | Product Owner (na advies van Developers en stakeholders) | GitHub Projects, veld *Prioriteit* |
| Sprintdoel | Scrum Team in Sprint Planning | sprintissue / board |
| Is dit increment Done? | Developers, op basis van de DoD — geen persoonlijke goedkeuring | issue + PR-checklist |
| Architectuur | Tech lead, met de Developers, consent-based | ADR in `docs/architecture/adr/` |
| Risicoacceptatie (restrisico van uitgevoerd werk) | mandaathouder uit §4 | `docs/compliance/audit-evidence.md` §3 |
| Privacy-/gegevensverwerking | **mandaathouder**, met onafhankelijk advies van de DPO | DPIA + `docs/privacy/`; afwijking van het advies gemotiveerd vastgelegd |
| Regulatoire toepasselijkheid | **bevoegde specialist (jurist/compliance)** | `docs/compliance/regulatory-decisions.md` |
| Release naar productie | PO + Security + Compliance gezamenlijk | `docs/releases/release-checklist.md` |
| Wijziging van deze governance | `[BESTUUR]` | PR + CHANGELOG |

Standaardwerkwijze is **consent**: een besluit gaat door als niemand een zwaarwegend,
onderbouwd bezwaar heeft. Bij een patstelling beslist de mandaathouder uit de tabel.

## 3. Vier-ogenprincipe

Verplicht bij: wijzigingen in authenticatie/autorisatie, transactie- of geldstroomlogica,
cryptografie en sleutelbeheer, datamigraties, productie-toegang en -deployments,
en wijzigingen aan de CI/CD-pipeline zelf. Uitvoerbaar via CODEOWNERS + required reviews +
required reviewers op de `production`-environment.

## 4. Risicoacceptatie

Risicoacceptatie gaat over een **restrisico van uitgevoerd werk** — bijvoorbeeld een
bekende kwetsbaarheid waarvoor nog geen patch bestaat, of een functionele beperking die we
bewust in productie nemen.

> **Risicoacceptatie is géén uitzondering op de Definition of Done.** Zij kan nooit
> betekenen dat niet-uitgevoerde tests, ontbrekende deploymentvalidatie of ontbrekend
> kwaliteits-, privacy- of compliancebewijs als uitgevoerd gelden. Ontbreekt een verplicht
> DoD-criterium, dan is het item niet Done en blijft het werk op de backlog staan
> ([`docs/scrum/definition-of-done.md`](docs/scrum/definition-of-done.md) §4).

Een risicoacceptatie is alleen geldig als **alle** onderstaande gegevens zijn vastgelegd:

| Veld | Toelichting |
|---|---|
| Beschrijving | wat is het risico, concreet |
| Impact | wat gebeurt er als het zich voordoet (gebruikers, geld, gegevens) |
| Waarschijnlijkheid | onderbouwde inschatting |
| Compenserende maatregelen | wat beperkt het risico intussen |
| Eigenaar | wie bewaakt het |
| Bevoegde goedkeurder | mandaathouder uit §1 |
| Vervaldatum | wanneer opnieuw beoordelen; nooit onbeperkt |
| Opvolgissue | waar het werk staat om het risico weg te nemen |

> **De DPO accepteert geen risico's.** Bij een privacyrisico adviseert de DPO
> onafhankelijk; de bevoegde mandaathouder neemt het besluit en legt vast waarom, zeker
> wanneer dat besluit afwijkt van het advies. Een ernstig privacyrisico blokkeert de
> release tot dat gedocumenteerde besluit er is.

Waarvoor risicoacceptatie **wel** passend kan zijn: een openstaande kwetsbaarheid van
niveau middel of lager, een leveranciersafhankelijkheid, een tijdelijke handmatige
compenserende maatregel, of een bewust uitgestelde verbetering.

Waarvoor **niet**: ontbrekende tests, niet-uitgevoerde reviews, overgeslagen
securityscans, niet-geverifieerde deployments, of ontbrekende toestemming voor een
gegevensverwerking.

Kritieke en hoge securityrisico's kunnen **niet** door de Developers zelf worden
geaccepteerd. Registratie: `docs/compliance/audit-evidence.md` §3.

## 5. Ritme

| Moment | Frequentie | Deelnemers |
|---|---|---|
| Scrum-events | per sprint | Scrum Team ([`docs/scrum/`](docs/scrum/)) |
| Security-/privacybeoordeling bij refinement | elke refinement | Developers met security-/privacyexpertise, governance op afroep |
| Complianceregister bijwerken | maandelijks | Compliance |
| Threat model herzien | per epic en per kwartaal | Developers (security-expertise) + tech lead |
| Governance-evaluatie | elk kwartaal | alle mandaathouders |

## 6. Grenzen van dit document

Dit document verdeelt verantwoordelijkheden binnen het team. Het vervangt geen wettelijke
verantwoordelijkheid, bestuursbesluit of vergunningsvereiste. Alle regulatoire
conclusies zijn **te valideren door een bevoegde specialist**.
