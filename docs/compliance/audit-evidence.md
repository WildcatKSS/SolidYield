# Auditbewijs

Bewijs is wat een buitenstaander kan controleren zonder ons op ons woord te geloven. Dit
document verzamelt **verwijzingen** naar bewijs — nooit de gevoelige inhoud zelf.

> **Belangrijk:** leg hier geen persoonsgegevens, exploitdetails, sleutels of
> leveranciersvertrouwelijke informatie vast. Verwijs naar de afgeschermde locatie.

## 1. Soorten bewijs

| Soort | Voorbeeld | Waar het vandaan komt |
|---|---|---|
| Geautomatiseerd | workflowruns, testresultaten, scanrapporten, SBOM's | GitHub Actions |
| Configuratie | branch protection, environments, CODEOWNERS, rollen | repository- en cloudinstellingen |
| Procesbewijs | reviews, goedkeuringen, releasechecklists | pull requests en releases |
| Documentatie | ADR's, DPIA's, threat model, registers | deze repository |
| Menselijke controle | kwartaalreviews, oefeningen, hersteltests | verslagen |

## 2. Bewijsregister

| # | Control | Bewijs | Locatie | Datum | Vastgelegd door | Volgende keer |
|---|---|---|---|---|---|---|
| E-001 | CM-01, CM-02 | Branch protection actief op `main`, inclusief CODEOWNERS-review | screenshot/export in `[AFGESCHERMDE LOCATIE]` | `[datum]` | `[naam]` | kwartaal |
| E-002 | CM-03, CM-04 | Groene CI- en securityruns voor release `[versie]` | GitHub Actions run `[URL]` | `[datum]` | pipeline | per release |
| E-003 | CM-06 | SBOM van release `[versie]` | artifact `sbom-[versie]` | `[datum]` | pipeline | per release |
| E-004 | AC-04 | Kwartaalreview toegangsrechten | `[SYSTEEM/LOCATIE]` | `[datum]` | `[naam]` | kwartaal |
| E-005 | OP-03, OP-04 | Hersteltest van back-up geslaagd | testverslag `[LOCATIE]` | `[datum]` | `[naam]` | kwartaal |
| E-006 | DP-05 | Controle op werking van verwijderroutines | monitoringrapport | `[datum]` | `[naam]` | kwartaal |
| E-007 | OP-05 | Incidentoefening uitgevoerd | oefenverslag `[LOCATIE]` | `[datum]` | `[naam]` | halfjaar |
| E-008 | PR-01 | Toegankelijkheidscontrole kernreis | a11y-rapport + handmatig verslag | `[datum]` | `[naam]` | per release |
| E-009 | DP-04, C-08 | DPIA `[DPIA-ID]` vastgesteld | `[LOCATIE]` | `[datum]` | Privacy | jaarlijks |
| E-010 | OP-06 | Kwetsbaarhedenrapportage sprint `[n]` | Sprint Review-notulen | `[datum]` | Security | per sprint |
| E-011 | CM-08 | Releasegoedkeuring PO/Security/Compliance voor `[versie]` | environment-goedkeuring + checklist | `[datum]` | `[namen]` | per release |
| E-012 | C-06 | Verwerkersovereenkomst met `[LEVERANCIER]` | contractdossier | `[datum]` | Inkoop | jaarlijks |

## 3. Risicoacceptaties

Bewuste afwijkingen worden hier vastgelegd. Zonder registratie bestaat een acceptatie niet.

| # | Onderwerp | Risico | Impact | Compenserende maatregel | Houdbaar tot | Geaccepteerd door | Issue |
|---|---|---|---|---|---|---|---|
| RA-001 | `[ONDERWERP]` | `[RISICO]` | `[IMPACT]` | `[MAATREGEL]` | `[DATUM]` | `[MANDAATHOUDER]` | #`[nr]` |

Regels: kritieke en hoge securityrisico's kan het team niet zelf accepteren; elke
acceptatie heeft een einddatum en wordt bij het verlopen opnieuw beoordeeld
([`../../GOVERNANCE.md`](../../GOVERNANCE.md)).

## 4. Uitzonderingen op scanbevindingen

| # | Bevinding | Waarom onderdrukt | Beoordeeld door | Vervalt op | Waar geconfigureerd |
|---|---|---|---|---|---|
| EX-001 | `[CVE/regel]` | `[ONDERBOUWING]` | `[NAAM]` | `[DATUM]` | `[BESTAND]` |

## 5. Ritme

| Bewijs | Frequentie | Verantwoordelijk |
|---|---|---|
| Releasebewijs (CI, scans, SBOM, goedkeuringen) | per release | pipeline + PO |
| Sprintbewijs (kwetsbaarheden, testgroep, DoD) | per sprint | Scrum Master |
| Kwartaalbewijs (toegang, termijnen, hersteltest, threat model) | per kwartaal | Security + Privacy |
| Jaarbewijs (pentest, DPIA-herziening, trainingen) | jaarlijks | Security + Compliance |

### Bewaartermijn van pipelinebewijs — een harde grens

Bewijs dat als **GitHub Actions-artifact** wordt bewaard (SBOM, scanrapporten,
testrapporten) valt onder de artifactretentie van de repository, en die kent een maximum:

| Repository | Maximum bewaartermijn |
|---|---|
| Publiek | **90 dagen** |
| Privé / organisatie | tot 400 dagen, afhankelijk van de instelling |

> **`retention-days` wordt stil naar beneden bijgesteld.** Vraag je in een workflow een
> langere termijn dan het repositorymaximum, dan krijg je zonder waarschuwing of
> foutmelding het maximum. De workflow lijkt te doen wat je vroeg; het artifact verdwijnt
> eerder dan je denkt.

Daarom staat `retention-days` in `release.yml` op 90 en niet hoger: wat de workflow belooft
is wat je krijgt. Controleer de werkelijke termijn na een release aan het veld `expires_at`
van het artifact, niet aan de workflowdefinitie.

**Vraagt jouw bewaarplicht een langere termijn — bij een gereguleerde dienst is dat
doorgaans zo — dan is een Actions-artifact niet de juiste opslag.** Kies dan bewust een
route en leg die hier vast:

| Route | Geschikt voor | Aandachtspunt |
|---|---|---|
| Publiceren als **release-asset** | SBOM's, releasebewijs | blijft bij de release zolang die bestaat; vraagt `contents: write` op een aparte, daarvoor bedoelde job |
| Wegschrijven naar **objectopslag** met bewaarbeleid (WORM/immutability) | alles wat lang moet blijven | vraagt inrichting en toegangsbeheer; zie [`../operations/deployment.md`](../operations/deployment.md) |
| Vastleggen in een **GRC- of bewijssysteem** | formele verantwoording | vaak al aanwezig binnen de organisatie |

**Openstaand besluit:** welke route `[ORGANISATIE]` kiest voor bewijs dat langer dan 90
dagen bewaard moet blijven, en welke termijn er wettelijk of contractueel geldt. Dat laatste
is **te bepalen door een bevoegde specialist** — noteer het in
[`regulatory-decisions.md`](regulatory-decisions.md).

## 6. Houdbaarheid

Bewijs is niet eeuwig geldig. Een controle van vorig jaar zegt niets over vandaag. Geef bij
elk bewijs aan wanneer het opnieuw moet worden verzameld, en bewaak dat in de backlog.
