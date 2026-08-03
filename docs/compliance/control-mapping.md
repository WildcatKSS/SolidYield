# Control matrix

> **Doel:** één plek waar control, maatregel, test, bewijs en eigenaar bij elkaar staan.
> **Wanneer gebruiken:** bij een nieuwe control, bij een release, en bij een audit.
> **Wie:** compliance officer beheert; security, privacy en tech lead vullen aan.
> **Adoptieniveau:** Regulated/Enterprise. Core- en Advanced-teams gebruiken alleen de
> rijen die hun werk raakt — een lege matrix invullen "omdat het kan" heeft geen waarde.
> **Gerelateerd:** [`compliance-register.md`](compliance-register.md) (welke verplichting
> geldt mogelijk) · [`regulatory-decisions.md`](regulatory-decisions.md) (mag dit
> juridisch) · [`audit-evidence.md`](audit-evidence.md) (het bewijs zelf)

Deze matrix maakt aantoonbaar dat een maatregel niet alleen op papier bestaat.

## Vijf begrippen die vaak door elkaar lopen

| Begrip | Wat het is | Voorbeeld |
|---|---|---|
| **Control** | het beheersdoel: wat moet er waar zijn | "alleen de eigenaar kan bij zijn eigen transacties" |
| **Implementatiemaatregel** | hoe we dat bereiken | autorisatiecontrole op objectniveau in de API-laag |
| **Test** | hoe we vaststellen dat de maatregel werkt | securitytest S-1 in `tests/security/` |
| **Bewijs** | wat een buitenstaander kan controleren | de groene workflowrun, met datum en commit |
| **Regulatoir besluit** | of en waarom deze verplichting geldt | vastgelegd in `regulatory-decisions.md`, door een bevoegde specialist |

Een control zonder maatregel is een wens. Een maatregel zonder test is een aanname. Een
test zonder bewijs is niet aantoonbaar. En geen van drieën vervangt het regulatoire
besluit over wat er eigenlijk moet.

## Kolommen

| Kolom | Betekenis |
|---|---|
| ID | uniek nummer, gebruikt in issues en ADR's |
| Onderwerp | korte aanduiding |
| Doel | wat de maatregel moet bereiken |
| Bron | waarom deze control bestaat: `GB` gegevensbescherming · `IB` intern beleid · `IS` informatiebeveiliging · `FR` financiële regelgeving · `CT` contractueel (zie [`../privacy/privacy-by-design.md`](../privacy/privacy-by-design.md) §0) |
| Van toepassing | 🟢 Core · 🔵 Advanced · 🟣 Regulated |
| Eigenaar | wie bewaakt dat dit werkt |
| Implementatie | waar het in ons systeem zit |
| Document | waar het is uitgewerkt |
| Technische controle | welke workflow of test het afdwingt |
| Bewijs | wat je overlegt |
| Bewijslocatie | waar dat bewijs staat |
| Frequentie | hoe vaak geverifieerd |
| Laatst beoordeeld | datum |
| Status | ontwerp · actief · niet actief · n.v.t. |
| Openstaand issue | `#nr` |

Onderstaande tabellen bevatten de kernkolommen; de volledige set kolommen (inclusief
bewijslocatie, laatste beoordeling en openstaand issue) staat in de
[voorbeeldregels](#volledig-ingevulde-voorbeeldregels-fictief) onderaan. Vul die
uitgebreide vorm alleen in voor de controls die je daadwerkelijk moet aantonen.

## Toegang en identiteit

| ID | Control | Implementatie | Geautomatiseerd bewijs | Handmatig bewijs | Eigenaar | Frequentie |
|---|---|---|---|---|---|---|
| AC-01 | Sterke authenticatie voor gebruikers | OIDC + wachtwoordbeleid | e2e-test inloggen | — | Security | elke PR |
| AC-02 | MFA voor gevoelige handelingen | herauthenticatie | securitytest S-6 | — | Security | elke PR |
| AC-03 | Autorisatie op objectniveau | controle per verzoek | securitytest S-1 | — | Security | elke PR |
| AC-04 | Least privilege voor medewerkers | rollen + JIT-toegang | — | kwartaalreview toegang | Security | kwartaal |
| AC-05 | Functiescheiding bij productiewijzigingen | required reviewers op environment | workflowconfiguratie | goedkeuringslog | Tech lead | per release |
| AC-06 | Intrekken van toegang bij vertrek | `[HR/IT-PROCES]` | — | intrekkingsbewijs | Security | per geval |

## Gegevensbescherming

| ID | Control | Implementatie | Geautomatiseerd bewijs | Handmatig bewijs | Eigenaar | Frequentie |
|---|---|---|---|---|---|---|
| DP-01 | Encryptie in transport | TLS 1.2+, HSTS | securitytest S-12 | scanrapport | Security | elke PR |
| DP-02 | Encryptie in rust | platform + veldniveau | infrastructuurconfiguratie | configuratiebewijs | Tech lead | per wijziging |
| DP-03 | Sleutelbeheer en rotatie | KMS | — | rotatielog | Security | kwartaal |
| DP-04 | Gegevensminimalisatie | ontwerpkeuzes | — | refinementnotitie, DPIA | Privacy | per story |
| DP-05 | Bewaartermijnen afgedwongen | verwijderroutines | monitoring van de routine | kwartaalcontrole | Privacy | kwartaal |
| DP-06 | Geen persoonsgegevens in logs | logfilters | securitytest S-9 | logsteekproef | Security | elke PR + kwartaal |
| DP-07 | Rechten van betrokkenen uitvoerbaar | export/verwijderfunctie | e2e-test | afhandelingsregistratie | Privacy | per release |
| DP-08 | Geen productiedata buiten productie | omgevingsscheiding | pipelinecontrole | verklaring in releasechecklist | Tech lead | per release |

## Ontwikkeling en wijzigingsbeheer

| ID | Control | Implementatie | Geautomatiseerd bewijs | Handmatig bewijs | Eigenaar | Frequentie |
|---|---|---|---|---|---|---|
| CM-01 | Elke wijziging via pull request | branch protection | vereiste checks | instellingenexport | Tech lead | doorlopend |
| CM-02 | Vier-ogenprincipe op gevoelige paden | CODEOWNERS | reviewstatus | — | Tech lead | elke PR |
| CM-03 | Geautomatiseerd testen vóór merge | `ci.yml` | workflowrun | — | Team | elke PR |
| CM-04 | Statische analyse en secret scanning | `security-scan.yml`; SAST en secret scan zijn **blokkerend** (falen ⇒ `security-gate` rood ⇒ merge geblokkeerd) | workflowrun | onderdrukte bevindingen met onderbouwing (§4 auditbewijs) | Security | elke PR |
| CM-05 | Afhankelijkheden en licenties beoordeeld | `dependency-review.yml` (vereist een ingeschakelde Dependency graph; anders draait alleen `license-check.sh` + Trivy en meldt de workflow dat deze control **niet actief** is) | workflowrun | uitzonderingenlijst | Security | elke PR |
| CM-06 | SBOM per release | `release.yml` | artifact | archief | Security | per release |
| CM-07 | Architectuurbesluiten vastgelegd | ADR | bestandsaanwezigheid | ADR-review | Tech lead | per besluit |
| CM-08 | Releasegoedkeuring door PO, Security, Compliance | environment reviewers | goedkeuringslog | releasechecklist | PO | per release |
| CM-09 | Deploymentbewijs komt uitsluitend voort uit een echte uitrol | `release.yml`: deployjobs draaien alleen bij een tag-push op de hoofdbranch én met de deploymentvariabelen aan; productie vereist bovendien een stabiele SemVer-versie en een kanaal uit de allowlist. Bewijs wordt pas na geslaagde uitrol én verificatie geschreven | joboverzicht + `deployment-status` | releasechecklist | Tech lead | per release |
| CM-10 | Externe GitHub Actions vastgezet op commit-SHA | alle workflows en `.github/actions/` | workflowbestanden | Dependabot-updates | Security | per wijziging |
| CM-11 | Securitypoort is fail-closed | `security-scan.yml`, job `security-gate`: elke verplichte securityjob moet exact `success` zijn; `failure`, `cancelled`, `skipped` en ontbrekende resultaten blokkeren | workflowrun | — | Security | elke PR |
| CM-12 | Done is objectief en niet omzeilbaar | Definition of Done (universeel + conditioneel), geen uitzonderingsprocedure; board zet Done niet automatisch | PR-checklist | boardconfiguratie | Scrum Master | doorlopend |

## Operatie en continuïteit

| ID | Control | Implementatie | Geautomatiseerd bewijs | Handmatig bewijs | Eigenaar | Frequentie |
|---|---|---|---|---|---|---|
| OP-01 | Monitoring en alarmering | dashboards + alerts | alertconfiguratie | testalarm | Ops | maand |
| OP-02 | Audit logging van kritieke gebeurtenissen | auditlog | securitytest S-10 | steekproef | Security | elke PR + kwartaal |
| OP-03 | Back-ups versleuteld en gescheiden | back-upbeleid | configuratie | herstelrapport | Ops | kwartaal |
| OP-04 | Hersteltest uitgevoerd | procedure | — | testverslag | Ops | kwartaal |
| OP-05 | Incidentproces beproefd | procedure | — | oefenverslag | Security | halfjaar |
| OP-06 | Kwetsbaarheden binnen SLA opgelost | scans + issues | scanresultaten | SLA-rapportage | Security | sprint |

## Product en gebruiker

| ID | Control | Implementatie | Geautomatiseerd bewijs | Handmatig bewijs | Eigenaar | Frequentie |
|---|---|---|---|---|---|---|
| PR-01 | Toegankelijkheid WCAG 2.2 AA op de kernreis | ontwerp + tests | a11y-workflow | handmatige controle | UX | elke PR |
| PR-02 | Begrijpelijke financiële informatie | taalniveau B1, uitleg bij bedragen | — | usabilitytestverslag | UX | per sprint |
| PR-03 | Geen misleidende patronen | ontwerpprincipes | — | reviewnotitie | PO + UX | per story |
| PR-04 | Toestemming vastgelegd en intrekbaar | toestemmingsflow | e2e-test S-13 | registratie | Privacy | per release |
| PR-05 | Gebruikersfeedback gestructureerd verwerkt | feedbacklog | — | feedbacklog | PO | per sprint |

## Volledig ingevulde voorbeeldregels (fictief)

Zo ziet een rij eruit wanneer je hem daadwerkelijk moet kunnen aantonen. Alle gegevens
hieronder zijn verzonnen.

### AC-03 — Autorisatie op objectniveau

| Kolom | Waarde |
|---|---|
| Doel | een gebruiker kan uitsluitend zijn eigen gegevens benaderen |
| Bron | `IS` + `GB` |
| Van toepassing | 🟢 Core |
| Eigenaar | security officer |
| Implementatie | eigenaarcontrole in de API-laag, bij elk verzoek opnieuw |
| Document | [`../security/access-control.md`](../security/access-control.md) §2 |
| Technische controle | securitytest S-1, verplicht in CI (`ci.yml`) |
| Bewijs | groene workflowrun met testresultaat |
| Bewijslocatie | Actions-run `[URL]` bij release `v1.4.0` |
| Frequentie | elke pull request |
| Laatst beoordeeld | `2026-03-12` |
| Status | actief |
| Openstaand issue | — |

### DP-05 — Bewaartermijnen worden afgedwongen

| Kolom | Waarde |
|---|---|
| Doel | gegevens verdwijnen aantoonbaar na de vastgestelde termijn |
| Bron | `GB` (termijn zelf: **te valideren door bevoegde specialist**) |
| Van toepassing | 🔵 Advanced zodra er echte gegevens zijn |
| Eigenaar | privacy officer |
| Implementatie | dagelijkse verwijderroutine per gegevenscategorie |
| Document | [`../privacy/data-retention.md`](../privacy/data-retention.md) |
| Technische controle | monitoring op "routine gedraaid"; alarm bij uitblijven |
| Bewijs | kwartaalcontrole met steekproef |
| Bewijslocatie | `audit-evidence.md` regel E-006 |
| Frequentie | per kwartaal |
| Laatst beoordeeld | `2026-04-02` |
| Status | ontwerp — routine bestaat, kwartaalcontrole nog niet uitgevoerd |
| Openstaand issue | `#87` |

### CM-09 — Deploymentbewijs komt uit een echte uitrol

| Kolom | Waarde |
|---|---|
| Doel | geen releasebewijs zonder daadwerkelijke deployment |
| Bron | `IB` + `IS` |
| Van toepassing | 🔵 Advanced |
| Eigenaar | tech lead |
| Implementatie | guards in `release.yml`: tag-push, hoofdbranch, stabiele versie, kanaal-allowlist |
| Document | [`../operations/deployment.md`](../operations/deployment.md) §6 |
| Technische controle | jobs `deploy-staging` / `deploy-production` + `deployment-status` |
| Bewijs | joboverzicht van de release |
| Bewijslocatie | Actions-run `[URL]` |
| Frequentie | per release |
| Laatst beoordeeld | `2026-04-15` |
| Status | actief |
| Openstaand issue | — |

## Gebruik

* Elke **nieuwe control** krijgt een ID, een implementatie, een test én een bewijsvorm.
  Ontbreekt de bewijsvorm, dan is het geen control maar een voornemen.
* Neem alleen op wat je daadwerkelijk moet kunnen aantonen. Een matrix vol rijen zonder
  bewijs is schadelijker dan een korte matrix: hij wekt de indruk van beheersing.
* Verwijs vanuit issues, ADR's en pull requests naar het control-ID.
* Bewijs verzamelen en bewaren: [`audit-evidence.md`](audit-evidence.md).
* Twijfel je of een verplichting geldt? Dat hoort niet hier maar in
  [`regulatory-decisions.md`](regulatory-decisions.md) — en wordt beantwoord door een
  bevoegde specialist.
