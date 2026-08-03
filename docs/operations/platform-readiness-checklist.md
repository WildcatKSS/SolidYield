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
| P8 | Datalocatie | gegevens binnen `[REGIO]`; doorgifte beoordeeld | | |
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

## Aandachtspunten per platform

Kort en bewust zonder implementatiecode — die hoort in je eigen infrastructuurrepository.

**AWS** — OIDC via IAM Roles for Service Accounts of GitHub OIDC-provider in plaats van
access keys · Secrets Manager of Parameter Store (SecureString) · KMS met key rotation ·
VPC met private subnets voor data · CloudTrail als auditbron, apart account voor logs ·
S3-objectversioning en Object Lock voor onveranderlijke back-ups.

**Azure** — Workload Identity Federation in plaats van clientsecrets · Key Vault met
purge protection · Private Endpoints voor PaaS-diensten · Managed Identity per component ·
diagnostic settings naar een aparte Log Analytics-workspace · resource locks op
productieresources.

**GCP** — Workload Identity Federation · Secret Manager met versiebeheer · VPC Service
Controls rond gevoelige diensten · Cloud KMS met rotatie · Cloud Audit Logs apart bewaard ·
organisatiebeleid dat publieke buckets verbiedt.

**Kubernetes** — geen `latest`-tags; images op digest · NetworkPolicies standaard dicht ·
secrets uit een externe kluis (CSI-driver of operator), niet als plain Secret · resource
requests én limits · PodSecurity-standaarden op `restricted` · aparte namespaces én
liefst clusters per omgeving · read-only rootfilesystem waar mogelijk.

---

## Afronding

| Moment | Wat vastleggen |
|---|---|
| Vóór staging | alle onderwerpen minimaal *Te ontwerpen*, kernonderwerpen *Gereed voor test* |
| Vóór productie | P1–P18 en P21–P25 op *Gereed voor productie* |
| Regulated | alle relevante onderwerpen op *Bewijs aanwezig* |

**Laatst doorgenomen:** `[JJJJ-MM-DD]` door `[NAAM]` · **Volgende:** `[DATUM]`
