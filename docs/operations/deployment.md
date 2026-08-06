# Deployment

Hoe code van een pull request in productie komt, en welke waarborgen daarbij horen.

> **Gerelateerd:** [`platform-readiness-checklist.md`](platform-readiness-checklist.md) ·
> [`../releases/release-process.md`](../releases/release-process.md)

## 1. Omgevingen

| Omgeving | Doel | Data | Toegang | Deploy |
|---|---|---|---|---|
| **development** | lokaal werken | synthetisch | developer zelf | lokaal |
| **test** | geautomatiseerde tests | synthetisch, per run weggegooid | pipeline | automatisch bij PR |
| **staging** | representatieve verificatie, testgroepsessies | synthetisch, stabiel | team + testgroep (testaccounts) | automatisch na merge/tag |
| **production** | echte gebruikers | echte gegevens | strikt beperkt, MFA, JIT | **alleen na handmatige goedkeuring** |

**Harde regels**

* Omgevingen zijn technisch gescheiden: eigen accounts/projecten, netwerken, sleutels en
  credentials.
* **Nooit productiedata in een niet-productieomgeving.** Ook niet "even", ook niet
  "geanonimiseerd".
* Staging is zichtbaar gemarkeerd als testomgeving.
* Productie-credentials bestaan alleen in de `production`-environment van GitHub.

## 2. Promotiepad

```
pull request → CI groen → review + CODEOWNERS → merge naar main
   → tag vX.Y.Z op main
     → release-pipeline: validatie (build, tests, scans, SBOM, releasenotes)
       → deploy naar staging          [alleen bij tag-push + STAGING_DEPLOY_ENABLED]
         → verificatie + gebruikersvalidatie
           → handmatige goedkeuring (environment production)
             → gefaseerde uitrol naar productie
                                       [+ stabiele SemVer + productiekanaal
                                        + PRODUCTION_DEPLOY_ENABLED]
               → monitoring en evaluatie
```

Een handmatige run van de workflow doorloopt alleen de validatiefase — dat is bewust:
zo kun je een kandidaat controleren zonder de tag, de versiehistorie en het releasebewijs
te omzeilen.

## 3. Goedkeuring voor productie

Ingericht via *Settings → Environments → production*:

* **Required reviewers:** minimaal Product Owner én Security/Compliance.
* **Wait timer:** optioneel `[10]` minuten, als bedenktijd.
* **Deployment branches:** alleen `main` en tags `v*.*.*`.
* **Environment secrets:** alleen daar; nooit als repository secret.

Zonder goedkeuring blijft de job wachten en gebeurt er niets.

## 4. Uitrolstrategie

| Strategie | Wanneer | Terugval |
|---|---|---|
| **Gefaseerd (canary)** — standaard | reguliere releases | automatisch terug bij stijgende foutratio |
| Blue/green | grotere wijzigingen | omschakelen naar de vorige omgeving |
| Feature flag | onzekere functionaliteit | vlag uitzetten (snelste terugval) |
| Big bang | alleen bij noodzaak | herdeploy van de vorige tag |

Advies bij canary: 5% → 25% → 100%, met minimaal `[15]` minuten observatie per stap.

## 5. Databasemigraties

Gebruik het **expand/contract**-patroon zodat oude en nieuwe code naast elkaar werken:

1. *Expand* — voeg toe (nieuwe kolom/tabel), zonder iets te breken.
2. Deploy code die beide vormen aankan.
3. Vul en migreer data in de achtergrond, in porties.
4. Deploy code die alleen de nieuwe vorm gebruikt.
5. *Contract* — verwijder het oude, in een aparte release.

Regels: elke migratie is terugdraaibaar of vooruit-herstelbaar; getest op een
representatieve datasetgrootte; raakt een migratie persoonsgegevens, dan is
privacybeoordeling verplicht; migraties draaien nooit ongecontroleerd tijdens piekuren.

## 6. Configuratie en secrets

| Type | Waar | Rotatie |
|---|---|---|
| Niet-gevoelige configuratie | environment variables / repository variables | per wijziging |
| Applicatiesecrets | secrets manager `[TOOL]` | `[90]` dagen of bij vermoeden |
| Deploycredentials | OIDC-federatie (voorkeur) of environment secrets | OIDC: n.v.t.; anders `[90]` dagen |
| Encryptiesleutels | KMS/HSM | volgens sleutelbeleid |
| Object Store-credentials en access keys | secrets manager `[TOOL]`, **per omgeving apart** | `[90]` dagen of bij vermoeden |

Nieuwe variabele? Voeg hem toe aan `.env.example` én aan dit document.

### Identity Provider per omgeving

De Identity Provider is **Keycloak**, self-hosted en native onder systemd op dezelfde
VPS'en als de applicatie (besluit 8A,
[ADR-0004](../architecture/adr/0004-identity-and-access-management.md) §8A). Productie en
test draaien **afzonderlijke instanties** met eigen databases, databasegebruikers, realms,
clients, signing keys, secrets, beheerdersaccounts, configuraties, e-mailconfiguraties,
logging, monitoring en back-ups.

> **Harde eis:** er worden **geen identitygegevens, accounts, credentials, sleutels of
> sessies** tussen productie en test gedeeld, en **geen productie-identiteiten naar test
> gekopieerd**. Dit valt onder dezelfde omgevingsscheiding als C-24 en T-27.
>
> **Fase: nog te implementeren.** Keycloak is gekozen, niet ingericht. Concrete
> systemd-units, realm- en clientconfiguratie horen bij de implementatie en staan hier
> bewust niet.

### Object Store per omgeving

Productie en test gebruiken **unieke bucketnamen** — generieke namen zijn niet toegestaan,
omdat een verkeerd geconfigureerde omgeving dan stilzwijgend de verkeerde bucket raakt:

| Omgeving | Buckets |
|---|---|
| Productie | `solidyield-production-documents` · `solidyield-production-exports` · `solidyield-production-backups` |
| Test | `solidyield-test-documents` · `solidyield-test-exports` · `solidyield-test-backups` |

Naast de bucketnamen zijn ook **afzonderlijk** per omgeving: Object Store-credentials,
access keys, endpoints/accounts of IAM-principals, encryptiesleutels en
lifecycle-/retentieconfiguraties.

> **Harde eis bij deployment:** een verkeerde *productie*credential mag technisch **geen**
> toegang geven tot test, en omgekeerd. De scheiding berust niet op een correct ingevulde
> bucketnaam, maar is op autorisatieniveau afdwingbaar. Zie
> [ADR-0003](../architecture/adr/0003-cloudprovider.md), control **C-24** en dreiging
> **T-27**.

### Repository-variabelen die het gedrag van de pipeline sturen

Instellen via *Settings → Secrets and variables → Actions → Variables*.

| Variabele | Effect zolang niet gezet | Zet wanneer |
|---|---|---|
| `TEMPLATE_STRICT` | ontbrekende build-, test- en scanstappen waarschuwen in plaats van te falen | op `true` zodra de technologiestack in de repository staat |
| `STAGING_DEPLOY_ENABLED` | de job `deploy-staging` wordt **overgeslagen**; niets uitgerold, geen deploymentbewijs | op `true` zodra de deploystappen in `release.yml` echt zijn ingevuld voor `[CLOUD]` |
| `PRODUCTION_DEPLOY_ENABLED` | de job `deploy-production` wordt **overgeslagen** | idem, voor productie |
| `RELEASE_CHANNEL` | kanaal `test-group` → productie is uitgesloten | op `limited-production` of `general-availability` zodra productie-uitrol de bedoeling is |
| `CODEQL_LANGUAGES` | CodeQL draait niet; Semgrep dekt de statische analyse | zodra de talen bekend zijn, bijv. `javascript-typescript` |
| `COVERAGE_MIN` | drempel 70% | wanneer het team een andere drempel afspreekt |
| `STAGING_URL`, `PRODUCTION_URL` | placeholder-URL's in de environmentweergave | zodra de omgevingen bestaan |

### Wanneer rolt de pipeline daadwerkelijk uit?

De releaseworkflow is **fail-closed**: alles wat niet expliciet is toegestaan, gebeurt niet.

| Trigger | Wat er gebeurt |
|---|---|
| **Handmatig (`workflow_dispatch`)** | **droogrun**: build, tests, coverage, toegankelijkheid, securityscans, SBOM en releasenotes draaien. Er wordt **nooit** uitgerold, ook niet met de deploymentvariabelen aan. |
| **Tag-push `v*.*.*` op de hoofdbranch** | staging rolt uit als `STAGING_DEPLOY_ENABLED=true`. Productie rolt uit als álle voorwaarden hieronder waar zijn. |
| **Tag-push op een commit buiten de hoofdbranch** | geen deployment; de workflow meldt dit als waarschuwing. |
| **Ongeldige versie** (geen SemVer) | de workflow **faalt** direct in `release-candidate`. |

**Voorwaarden voor productie — alle vijf vereist:**

1. `github.event_name == 'push'` met een tag onder `refs/tags/v…`;
2. de getagde commit is bereikbaar vanaf de hoofdbranch;
3. de versie is geldig SemVer en **geen prerelease** (`-rc`, `-alpha`, `-beta`);
4. `RELEASE_CHANNEL` staat op `limited-production` of `general-availability` —
   `internal-prototype`, `test-group` en `beta` komen nooit in productie;
5. `PRODUCTION_DEPLOY_ENABLED == 'true'`.

Daarbovenop blijft de goedkeuring door de *required reviewers* op de environment
`production` altijd verplicht. De voorwaarden worden twee keer gecontroleerd: op
jobniveau (`if`) en nogmaals als eerste stap ín de job, zodat een wijziging aan één van
beide niet stilzwijgend een deur openzet.

> **Waarom een schakelaar en geen "gewoon draaien"?** De deploystappen zijn placeholders
> zolang `[CLOUD]` niet is gekozen. Een job die niets uitrolt en tóch groen afsluit met
> "deploy vastgelegd als bewijs", levert vals bewijs voor een control die niet heeft
> gedraaid — precies wat een audit onbruikbaar maakt. Daarom geldt:
>
> * variabele **niet gezet** → job wordt overgeslagen (grijs, geen deployment, geen bewijs);
>   de job `deployment-status` maakt expliciet zichtbaar dát en waarom er niets gebeurde;
> * variabele **op `true`** maar de placeholder nog niet vervangen → de job **faalt** met
>   een duidelijke melding. Wie zegt dat hij uitrolt, moet dat waarmaken;
> * variabele **op `true`** en echte deploystappen ingevuld → uitrol, rooktest, en pas
>   daarna het deploymentbewijs.

## 7. Rollback

| Situatie | Actie | Streeftijd |
|---|---|---|
| Functioneel probleem achter een vlag | vlag uitzetten | < 1 minuut |
| Foute release zonder migratie | herdeploy vorige tag | < `[15]` minuten |
| Foute release met migratie | vooruit herstellen (fix) of migratie terugdraaien volgens plan | < `[60]` minuten |
| Datacorruptie | back-up terugzetten volgens `backup-and-recovery.md` | volgens RTO |

Elke pull request bevat een rollbackplan. Geen plan = niet mergen.

## 8. Checklist per deploy naar productie

- [ ] Alle verplichte checks groen
- [ ] Geen openstaande kritieke/hoge kwetsbaarheden
- [ ] Releasechecklist doorlopen ([`../releases/release-checklist.md`](../releases/release-checklist.md))
- [ ] Goedkeuring PO, Security en Compliance vastgelegd
- [ ] Migratieplan en rollbackplan bekend
- [ ] Monitoring en alarmering actief; iemand kijkt daadwerkelijk mee
- [ ] Communicatie geregeld als gebruikers iets merken
- [ ] Post-deploymentchecks vooraf ontworpen en begrensd (read-only healthchecks,
      synthetische monitoring, canaryverificatie) — zie
      [`../testing/test-strategy.md`](../testing/test-strategy.md) §4a en
      [`monitoring.md`](monitoring.md) §7a
- [ ] Deploy vastgelegd als bewijs (`../compliance/audit-evidence.md`)

## 9. Nog te bepalen

| Onderwerp | Eigenaar |
|---|---|
| ~~Cloudprovider~~ — vastgesteld: **TransIP**, twee VPS'en, primair Nederland ([ADR-0003](../architecture/adr/0003-cloudprovider.md)) | ✅ besloten |
| ~~Infrastructure as code~~ — vastgesteld: **Ansible**, Git en systemd; geen handmatige productieconfiguratie ([ADR-0002](../architecture/adr/0002-technologiestack.md)) | ✅ besloten |
| Containerisatie en runtime | Tech lead |
| Secrets manager | Security |
| Deployvenster en changekalender | Ops |
