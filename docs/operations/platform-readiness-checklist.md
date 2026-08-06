# Platform-readinesschecklist

> **Doel:** vaststellen of het platform klaar is voor test, voor productie, en voor
> verantwoording achteraf.
> **Wanneer gebruiken:** vóór de eerste uitrol naar staging, vóór de eerste
> productie-uitrol, en daarna elk kwartaal.
> **Wie:** Developers met operationsexpertise, samen met de tech lead; security en privacy
> bij de betreffende onderwerpen.
> **Adoptieniveau:** Advanced (staging), Regulated (productie met bewijs).
> **Volgorde:** deze checklist hoort **vóór** de betreffende uitrol af te zijn — vóór
> staging voor de test-items, vóór de eerste productie-uitrol voor de rest. Zij is een
> voorwaarde voor productie, geen opruimactie erna
> ([`../adoption-levels.md`](../adoption-levels.md#regulated--enterprise)).
> **Gerelateerd:** [`deployment.md`](deployment.md) · [`sre-principles.md`](sre-principles.md) · [`../architecture/architecture-principles.md`](../architecture/architecture-principles.md)

Cloud- en stack-agnostisch. Per onderwerp kies je één status:

| Status | Betekenis |
|---|---|
| **N.v.t.** | niet van toepassing — mét reden |
| **Te ontwerpen** | erkend, nog geen keuze gemaakt |
| **Gereed voor test** | werkt in staging |
| **Gereed voor productie** | werkt, is beproefd en heeft een eigenaar |
| **Bewijs aanwezig** | vastgelegd in [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md) |

---

## Identiteit en toegang

| # | Onderwerp | Waar je op let | Status | Eigenaar |
|---|---|---|---|---|
| P1 | Identity federation / OIDC | pipeline en diensten authenticeren zonder langlevende sleutels | | |
| P2 | Secrets management | centrale kluis, rotatiebeleid, geen secrets in repo of image | | |
| P3 | Toegang tot productie | just-in-time, MFA, aanleiding vastgelegd, geaudit | | |
| P4 | Functiescheiding | wie deployt is niet automatisch wie goedkeurt | | |

## Netwerk en gegevens

| # | Onderwerp | Waar je op let | Status | Eigenaar |
|---|---|---|---|---|
| P5 | Netwerksegmentatie | database niet vanaf internet bereikbaar; uitgaand verkeer beperkt | | |
| P6 | Encryptie in transport | TLS 1.2+, HSTS, moderne ciphers | | |
| P7 | Encryptie in rust | opslag én back-ups; sleutels in KMS/HSM | | |
| P8 | Datalocatie | opslag en reguliere verwerking binnen de EER; primaire productieomgeving in Nederland (TransIP VPS); één geografisch gescheiden secundaire locatie binnen de EER voor back-up en disaster recovery, onderbouwd en getest (ADR-0003, ADR-0006) | | |
| P8a | Toegang vanuit derde landen | standaard uitgesloten; goedgekeurde uitzonderingen zijn geregistreerd als internationale doorgifte (ADR-0006) | | |
| P9 | Omgevingsscheiding | eigen accounts, netwerken, sleutels per omgeving | | |
| P10 | Geen productiedata buiten productie | technisch én organisatorisch afgedwongen | | |

## Waarneembaarheid

| # | Onderwerp | Waar je op let | Status | Eigenaar |
|---|---|---|---|---|
| P11 | Logging | gestructureerd, correlatie-ID, zonder persoonsgegevens, bewaartermijn ingesteld | | |
| P12 | Auditlog | append-only, eigen rechten en bewaartermijn | | |
| P13 | Metrics | gouden signalen + functionele en securitymeetwaarden | | |
| P14 | Tracing | over componentgrenzen heen | | |
| P15 | Alerting | actiegericht, verwijst naar het runbook, iemand ontvangt het daadwerkelijk | | |

## Continuïteit

| # | Onderwerp | Waar je op let | Status | Eigenaar |
|---|---|---|---|---|
| P16 | Back-up | versleuteld, gescheiden bewaard, onveranderlijk waar mogelijk | | |
| P17 | Hersteltest | daadwerkelijk uitgevoerd in een aparte omgeving, met verslag | | |
| P18 | Rollback | beproefd; verwachte hersteltijd bekend | | |
| P19 | Autoscaling | schaalt mee, met een bovengrens tegen kostenexplosie | | |
| P20 | Resource limits | CPU/geheugen begrensd; geen enkele component kan alles opeten | | |

## Leverketen en uitrol

| # | Onderwerp | Waar je op let | Status | Eigenaar |
|---|---|---|---|---|
| P21 | Artifact registry | versiebeheerd, toegang beperkt, retentie ingesteld | | |
| P22 | Image scanning | bij build én periodiek opnieuw | | |
| P23 | Infrastructure as code | omgeving reproduceerbaar, in versiebeheer, gereviewd | | |
| P24 | Staging representatief | zelfde vorm als productie, synthetische data | | |
| P25 | Productie-approvals | required reviewers op de environment | | |
| P26 | Kostenbewaking | budgetalarm; kosten zichtbaar per omgeving | | |
| P27 | Leveranciersafhankelijkheden | wat gebeurt er bij uitval; exitmogelijkheid; verwerkersovereenkomst | | |

---

## Aandachtspunten voor onze architectuur

Twee zelf beheerde TransIP VPS'en met Ubuntu Server LTS, zonder containers of orkestratie
([ADR-0003](../architecture/adr/0003-cloudprovider.md)). Kort en bewust zonder
implementatiecode — die hoort in de Ansible-repository.

**Besturingssysteem en netwerk** — Ubuntu Server LTS met automatische securityupdates ·
firewall standaard dicht, alleen expliciet geopende poorten · SSH-beheer uitsluitend via
**WireGuard**, geen wachtwoordauthenticatie · test is **niet publiek bereikbaar**.

**Provisioning** — alles via **Ansible** vanuit Git; geen handmatige productieconfiguratie ·
drift zichtbaar maken · systemd-units met minimale rechten en een eigen serviceaccount per
proces (API en Worker gescheiden).

**PostgreSQL** — vier gescheiden gebruikers (migraties, runtime, readonly, backup) ·
runtime mag geen schemawijzigingen uitvoeren · Flyway voert migraties uit · geen netwerk-
toegang van buiten de VPS.

**Object storage (TransIP Object Store)** — **unieke bucketnamen per omgeving**, geen
generieke namen: `solidyield-production-documents`, `solidyield-production-exports`,
`solidyield-production-backups`, `solidyield-test-documents`, `solidyield-test-exports`,
`solidyield-test-backups` · versioning, encryptie en lifecycle policies aan ·
uitsluitend **korte presigned URL's**; de frontend krijgt nooit credentials.

**Gescheiden Object Store-toegang** — productie en test hebben afzonderlijke credentials,
access keys, endpoints/accounts of IAM-principals, encryptiesleutels en
lifecycle-/retentieconfiguraties. **Aantoonbaar maken:** een productiecredential geeft
technisch **geen** toegang tot test, en omgekeerd — op autorisatieniveau, niet alleen via
de bucketnaam (C-24, T-27).

**Scheiding productie en test** — nooit gedeeld: databases, databasegebruikers,
Unix-accounts, secrets, signing keys, buckets, provideraccounts, monitoring, logging en
back-ups. Test draait uitsluitend met synthetische data.

**Secrets** — buiten Git, met beperkte rechten op de VPS · rotatiebeleid · aparte secrets
per omgeving; sleutelbeheer wordt uitgewerkt in ADR-0005.

---

## Afronding

| Moment | Wat vastleggen |
|---|---|
| Vóór staging | alle onderwerpen minimaal *Te ontwerpen*, kernonderwerpen *Gereed voor test* |
| Vóór productie | P1–P18 en P21–P25 op *Gereed voor productie* |
| **Vóór start van de besloten testgroep** | zie de Go/No-Go hieronder — dit is het eerste moment waarop er echte klantgegevens en echte geldstromen op het platform staan |
| Regulated | alle relevante onderwerpen op *Bewijs aanwezig* |

### Openstaande vervolgacties vóór productie

Deze onderwerpen zijn **nog niet ingericht**. Zij staan hier als **open vervolgactie**, niet
als beschreven proces of genomen besluit.

| # | Vervolgactie | Eigenaar |
|---|---|---|
| 1 | **Operationeel patchmanagementproces vaststellen.** Minimaal uit te werken: reguliere updates · spoedpatches · onderhoudsvensters · rollback · testvolgorde. Zelf beheerde VPS'en betekent dat patchen terugkerend eigen werk is ([ADR-0003](../architecture/adr/0003-cloudprovider.md)) | Ops + Security |
| 2 | **Operationele runbooks opstellen** voor onder andere: account recovery · providerstoringen · mislukte betalingen · reconciliation · dead letter jobs · KYC-herbeoordeling · incidentafhandeling. Zie [`runbook.md`](runbook.md) §12 | Ops + Support |
| 3 | **Beschikbaarheidsdoelstelling onderbouwen** met hersteltests, back-uptests, disaster recovery-tests en operationele metingen ([`service-level-objectives.md`](service-level-objectives.md) §7) | Ops + PO |

> Hier staan **geen procedures**. Het vaststellen ervan is werk dat nog moet gebeuren; dit
> document legt uitsluitend vast **dát** het vóór productie moet bestaan.

### Go/No-Go vóór start van de besloten testgroep

De besloten testgroep (besluit 7) is de **eerste gecontroleerde productie-uitrol**. Zij mag
uitsluitend starten wanneer aan **alle** onderstaande voorwaarden is voldaan (C-34):

| # | Voorwaarde | Bewijs |
|---|---|---|
| 1 | Besluiten 1 tot en met 8 zijn vastgesteld | besluitentabel in [`../../README.md`](../../README.md) §10 |
| 2 | **De wettelijke grondslag uit besluit 4 is bevestigd** | RD-23 t/m RD-27; controls C-27 t/m C-31 |
| 3 | De MVP voldoet aan de [Definition of Done](../scrum/definition-of-done.md) | groene CI, DoD-verantwoording per item |
| 4 | Alle kritieke en hoge beveiligingsbevindingen zijn opgelost of formeel geaccepteerd | security-gate; [`../security/vulnerability-management.md`](../security/vulnerability-management.md); risicoacceptatie volgens [`../../GOVERNANCE.md`](../../GOVERNANCE.md) §4 |
| 5 | Een **succesvolle hersteltest** van back-up en disaster recovery is uitgevoerd | C-12; [`backup-and-recovery.md`](backup-and-recovery.md) |

> Dit is een **operationele vrijgavevoorwaarde**, geen wijziging van eerdere besluiten. Zij
> voegt niets toe aan en haalt niets weg van de besluiten 1 t/m 6; zij bepaalt uitsluitend
> wanneer de knop om mag. Volledige uitwerking:
> [`../product/closed-test-group.md`](../product/closed-test-group.md) §10.
>
> **Let op bij voorwaarde 5:** met één productie-VPS is er **geen automatische failover**
> (T-28). De hersteltest toont aan dat herstel wérkt, niet dat uitval wordt voorkomen.

**Laatst doorgenomen:** `[JJJJ-MM-DD]` door `[NAAM]` · **Volgende:** `[DATUM]`
