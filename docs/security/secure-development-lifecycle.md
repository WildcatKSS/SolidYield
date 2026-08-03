# Secure Development Lifecycle

Security is geen fase, maar een eigenschap van elke stap. Dit document beschrijft welke
securityactiviteit bij welke stap in onze Scrum-cyclus hoort en wie die uitvoert.

## Overzicht per stap

| Stap | Securityactiviteit | Wie | Bewijs |
|---|---|---|---|
| **Idee / Inbox** | eerste inschatting security-, privacy- en compliance-impact | PO + melder | velden op het board |
| **Discovery** | misbruikscenario's benoemen ("abuse stories") | Developers (UX- en security-expertise) | issuebeschrijving |
| **Refinement** | verplichte risicoscan; securityeisen als acceptatiecriteria | Scrum Team, governance op afroep | acceptatiecriteria |
| **Epicstart** | threat modelling met de [epic-checklist](../architecture/epic-threat-checklist.md) | Developers (security-expertise) + tech lead | [`../architecture/threat-model.md`](../architecture/threat-model.md) |
| **Ontwerp** | ADR met security-impact | Tech lead | ADR |
| **Bouw** | veilige codeerpraktijken, geen secrets, invoervalidatie | Developers | code |
| **Commit** | pre-commit secret scan (optioneel), ondertekende commits | Developers | commit |
| **Pull request** | code review met securitycheck; CODEOWNERS bij gevoelige paden | Reviewers | review |
| **CI** | secret scan, SAST, dependency review, container- en IaC-scan, SBOM, licenties | pipeline | workflowruns |
| **Test** | securitytests in `tests/security/` | Developers | testresultaten |
| **Definition of Done** | geen kritieke/hoge openstaande bevindingen (U4) | Developers | scanresultaten |
| **Release** | securitycheck; een openstaande kritieke/hoge bevinding blokkeert de release | security officer (governance) | releasechecklist |
| **Productie** | monitoring, alarmering, auditlogging | Ops | dashboards |
| **Doorlopend** | kwetsbaarhedenopvolging, patchen, hertesten | Security | issues |
| **Periodiek** | pentest, herziening threat model, toegangsreview | Security | rapporten |

## Praktische richtlijnen per rol

### Developers
* Vraag bij elke story: *wie mag dit, en hoe controleer ik dat serverseitig?*
* Schrijf minimaal één test die aantoont dat een **onbevoegde** het niet kan.
* Log nooit persoonsgegevens, bedragen, tokens of wachtwoorden.
* Voeg geen afhankelijkheid toe zonder de licentie en het onderhoud te bekijken.
* Twijfel je? Vraag het de securityverantwoordelijke vóór de merge, niet erna.

### Reviewers
Controleer minimaal: autorisatie op objectniveau · invoervalidatie · geen secrets ·
foutafhandeling zonder informatielek · logging zonder gevoelige gegevens · nieuwe
afhankelijkheden · gevolgen voor bestaande maatregelen.

### Product Owner
* Prioriteer securitywerk zichtbaar; het concurreert niet met features, het is
  onderdeel van "af".
* Een increment met openstaande kritieke of hoge bevindingen is per definitie niet Done
  (criterium U4) — dat is geen afweging maar een vaststelling.

### Securityverantwoordelijke
* Wees vroeg aanwezig (refinement), niet alleen aan het einde.
* Vertaal dreigingen naar testbare acceptatiecriteria.
* Houd de kwetsbaarhedenlijst en de SLA's actueel.

## Security in de sprint

Elke sprint bevat minimaal:

1. de securitytaken die bij de stories van die sprint horen;
2. opvolging van openstaande kritieke/hoge bevindingen;
3. een moment waarop nieuwe scanresultaten worden bekeken.

Een sprint zonder enige securityactiviteit is een signaal, geen prestatie.

## Trainingen en bewustzijn

| Onderwerp | Frequentie | Doelgroep |
|---|---|---|
| Veilige ontwikkeling en OWASP Top 10 | jaarlijks | developers |
| Phishing en social engineering | jaarlijks | iedereen |
| Omgaan met persoonsgegevens | bij indiensttreding + jaarlijks | iedereen |
| Threat modelling | bij aanvang project | developers + tech lead |
| Incidentresponsoefening | halfjaarlijks | team |

Registratie en bewijs: [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md).
