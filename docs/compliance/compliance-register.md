# Complianceregister

> **Doel:** bijhouden welke verplichtingen mogelijk gelden, wie ze bewaakt en hoe ver we zijn.
> **Wanneer gebruiken:** bij een nieuw onderwerp, en maandelijks bij de herbeoordeling.
> **Wie:** compliance officer, met privacy en security.
> **Adoptieniveau:** Regulated/Enterprise (Core-teams gebruiken alleen de rijen die zij echt raken).
> **Gerelateerd:** [`control-mapping.md`](control-mapping.md) (hoe borgen we het) · [`regulatory-decisions.md`](regulatory-decisions.md) (mag dit juridisch) · [`audit-evidence.md`](audit-evidence.md) (bewijs)

Overzicht van onderwerpen die mogelijk een verplichting met zich meebrengen, met status,
eigenaar en bewijs. Dit register is een **werkinstrument**, geen juridisch oordeel.

> [!IMPORTANT]
> **Een control in dit register betekent niet dat de maatregel bestaat.** Een regel legt
> vast *dat* een onderwerp beheerst moet worden en *wie* dat bewaakt — niet dat er al iets
> werkt. Er is in deze repository nog **geen applicatiecode**; **geen enkele control is
> daarom operationeel**, en verificatie vindt pas plaats tijdens implementatie en
> acceptatie.

### Fasen: ontwerp, implementatie en bewijs uit elkaar

De kolom **Fase** geeft aan hoe ver een control is. De vier fasen zijn opeenvolgend:

| Fase | Betekenis | Wat het **niet** betekent |
|---|---|---|
| **Ontworpen** | het ontwerpbesluit ligt vast in een ADR of document | dat er iets gebouwd of ingericht is |
| **Nog te implementeren** | het ontwerp staat vast; de maatregel moet nog worden gebouwd of ingericht | dat de maatregel bestaat |
| **Nog te verifiëren** | de maatregel bestaat; werking is nog **niet** aangetoond | dat de maatregel aantoonbaar werkt |
| **Operationeel** | de maatregel werkt **aantoonbaar** en het bewijs is vastgelegd in [`audit-evidence.md`](audit-evidence.md) | — |

*Nog te ontwerpen* gaat aan deze vier vooraf: het onderwerp is geregistreerd, maar er ligt
nog geen ontwerpbesluit.

> **Fase en Status zijn verschillende dingen.** *Fase* zegt hoe ver de **maatregel** is;
> *Status* zegt hoe ver de **beoordeling van de verplichting** is. Een control kan
> juridisch bevestigd zijn en technisch nog niet bestaan, en omgekeerd.

**Soort verplichting** (kolom *Type*) — zie
[`../privacy/privacy-by-design.md`](../privacy/privacy-by-design.md) §0:

| Code | Soort | Wie stelt vast wat geldt |
|---|---|---|
| `GB` | gegevensbescherming (wet) | privacy officer/DPO + juridische validatie |
| `IB` | intern beleid | privacy officer / security officer + PO |
| `IS` | informatiebeveiliging (algemeen) | security officer |
| `FR` | sectorspecifieke financiële regelgeving | **bevoegde specialist** |
| `CT` | contractueel of leveranciersvereist | compliance + inkoop |

> ⚖️ **Het team stelt niet zelfstandig vast welke vergunningen of wettelijke regimes van
> toepassing zijn.** Elk onderwerp krijgt de status *te valideren door een bevoegde
> specialist* totdat een gekwalificeerde jurist of compliance officer schriftelijk heeft
> bevestigd wat geldt. Zie [`regulatory-decisions.md`](regulatory-decisions.md).

## Kolommen

| Kolom | Betekenis |
|---|---|
| Type | soort verplichting: `GB` · `IB` · `IS` · `FR` · `CT` (zie hierboven) |
| Fase | hoe ver de **maatregel** is: Nog te ontwerpen · Ontworpen · Nog te implementeren · Nog te verifiëren · Operationeel |
| Mogelijke verplichting | waar het onderwerp over gaat |
| Toepassingsgebied | op welk deel van product of organisatie het ziet |
| Eigenaar | wie het onderwerp bewaakt |
| Status | open · in onderzoek · **te valideren door specialist** · bevestigd · niet van toepassing |
| Bewijs | waar het bewijs staat |
| Openstaande actie | de eerstvolgende stap |
| Laatst beoordeeld | datum |
| Goedkeurder | wie de status heeft bevestigd |

## Register

| # | Type | Fase | Mogelijke verplichting | Toepassingsgebied | Eigenaar | Status | Bewijs | Openstaande actie | Laatst beoordeeld | Goedkeurder |
|---|---|---|---|---|---|---|---|---|---|---|
| C-01 | `FR` | Ontworpen | **Bedrijfs- en ketenmodel** (besluit 4): SolidYield is contractspartij, houdt de wallet, investeert voor eigen rekening en risico, betaalt vast rendement en de nominale inleg terug; betalingen via vergunninghoudende betaalpartners | hele dienst | PO + Compliance | **BESLOTEN** 2026-08-05 | [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) · [ADR-0008](../architecture/adr/0008-geld-en-contractstroom.md) | Bedrijfsmodel en ketenrol zijn vastgesteld. De juridische grondslag voor uitvoering wordt afzonderlijk vastgesteld — zie C-27 t/m C-31 | 2026-08-05 | Product Owner |
| C-02 | `FR` | Ontworpen | Informatieverplichtingen richting consumenten (kosten, voorwaarden, risico's) | web + app | PO + Compliance | **te valideren** | `[link]` | teksten laten toetsen | | |
| C-03 | `GB` | Ontworpen | Gegevensbescherming: grondslagen en transparantie | hele dienst | Privacy | in onderzoek | `docs/privacy/` | grondslagen per verwerking vastleggen | | |
| C-04 | `GB` | Ontworpen | Bewaartermijnen en bewaarplichten | gegevens | Privacy | **te valideren** | `docs/privacy/data-retention.md` | termijnen laten bevestigen | | |
| C-05 | `GB` | Ontworpen | Rechten van betrokkenen (inzage, correctie, verwijdering, portabiliteit) | applicatie | Privacy | open | acceptatiecriteria E3 | functionaliteit bouwen en testen | | |
| C-06 | `GB` | Ontworpen | Verwerkersovereenkomsten met leveranciers | leveranciers | Privacy + Inkoop | open | `control-mapping.md` | DPA's afsluiten vóór ingebruikname | | |
| C-07 | `GB` | Ontworpen | Internationale gegevensdoorgifte | infrastructuur + toegangsbeheer | Privacy | **te valideren** | [ADR-0006](../architecture/adr/0006-dataresidency-en-opslaglocatie.md) | regio ligt vast (EER, primair Nederland); goedkeurings- en registratieproces voor toegang vanuit derde landen inrichten en elke goedgekeurde uitzondering als doorgifte vastleggen | | |
| C-08 | `GB` | Ontworpen | DPIA voor risicovolle verwerkingen | gegevens | Privacy | open | `privacy-impact-assessment-template.md` | DPIA uitvoeren vóór bèta | | |
| C-09 | `IS` | Ontworpen | Toegangscontrole en functiescheiding | organisatie + techniek | Security | in onderzoek | `docs/security/access-control.md` | kwartaalreview inrichten | | |
| C-10 | `IS` | Ontworpen | Audit trail en onweerlegbaarheid | applicatie | Security | open | threat model T-04 | auditlog implementeren en testen | | |
| C-11 | `IS` | Ontworpen | Wijzigingsbeheer (change management) | pipeline | Tech lead | in onderzoek | branch protection + PR-template · [ADR-0002](../architecture/adr/0002-technologiestack.md) | branch protection aanzetten en aantonen; geen handmatige productieconfiguratie, Infrastructure as Code leidend | | |
| C-12 | `IS` | Ontworpen | Beschikbaarheid, continuïteit en herstel | platform | Ops | open | `docs/operations/backup-and-recovery.md` · [ADR-0003](../architecture/adr/0003-cloudprovider.md) | hersteltest uitvoeren; geen automatische failover met één productie-VPS, SLO's herijken; geografische scheiding van de secundaire locatie onderbouwen (ADR-0006) | | |
| C-13 | `GB` | Ontworpen | Incidentmelding (security en privacy) | organisatie | Security + Privacy | **te valideren** | `docs/security/incident-response.md` | meldroutes en termijnen bevestigen | | |
| C-14 | `CT` | Ontworpen | Beheersing van uitbestede diensten | leveranciers | Compliance | open | leveranciersregister | risicobeoordeling per leverancier | | |
| C-15 | `FR` | Ontworpen | Fraudepreventie en transactiemonitoring | applicatie | Security + Compliance | **te valideren** | threat model T-13 | limieten en detectie inrichten | | |
| C-16 | `FR` | Nog te ontwerpen | Identificatie en verificatie van klanten | onboarding | Compliance | **te valideren** | — | **uitgewerkt in C-21** voor SolidYield (KYC/AML, inclusief zzp'ers en rechtspersonen); deze rij blijft staan als algemene templateregel | | |
| C-17 | `IB` | Ontworpen | Toegankelijkheid (WCAG) | web + app | UX | in onderzoek | a11y-workflow | niveau AA aantoonbaar maken | | |
| C-18 | `IB` | Ontworpen | Bewaren van bewijs voor controles | organisatie | Compliance | open | `audit-evidence.md` | bewijsroutine inrichten | | |
| C-19 | `IS` | Ontworpen | Beveiliging van broncode en toeleveringsketen | pipeline | Security | in onderzoek | `security-scan.yml`, SBOM | SBOM per release archiveren | | |
| C-20 | `IB` | Nog te ontwerpen | Rapportage aan bestuur/toezicht | organisatie | Compliance | open | — | rapportageritme afspreken | | |
| C-21 | `FR` | Ontworpen | Identificatie en verificatie van cliënten (KYC/AML), inclusief zzp'ers en rechtspersonen | onboarding | Compliance | **te valideren** | [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) · RD-05 | verplichtingen laten vaststellen; fase 1 wordt intern uitgevoerd, fase 2 (externe partner) staat op de roadmap | | |
| C-22 | `CT` | Ontworpen | Selectie van en rolverdeling met vergunninghoudende betaalpartners (eerste implementatierichting: Mollie, bunq) | keten | Compliance | **te valideren** | [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) · RD-22 | partners definitief selecteren, contracteren en de regulatoire rolverdeling laten beoordelen vóór de eerste echte geldstroom; een betaalpartner is betaalpartner, geen productuitgever | | |
| C-23 | `FR` | Ontworpen | Vermogensscheiding en positie van de gebruiker bij faillissement | administratie + contractvoorwaarden | Compliance | **te valideren** | RD-20 · RD-21 | laten vaststellen of administratieve scheiding bescherming biedt, en hoe de positie als concurrent schuldeiser moet worden gecommuniceerd | | |
| C-24 | `IS` | Ontworpen | Scheiding van productie- en testomgeving, inclusief **Object Store-scheiding** | platform | Tech lead + Security | open | [ADR-0003](../architecture/adr/0003-cloudprovider.md) | aantonen dat databases, databasegebruikers, Unix-accounts, secrets, signing keys, buckets, provideraccounts, monitoring, logging en back-ups nooit gedeeld zijn. **Geldt ook voor Keycloak** (besluit 8A): afzonderlijke instanties, databases, realms, clients, signing keys, secrets, beheerdersaccounts, configuraties en e-mailconfiguraties per omgeving; geen identitygegevens, credentials, sleutels of sessies gedeeld en geen productie-identiteiten in test. Voor object storage specifiek: **unieke bucketnamen** (`solidyield-production-documents`/`-exports`/`-backups` en `solidyield-test-documents`/`-exports`/`-backups`) en **afzonderlijke** credentials, access keys, endpoints/accounts of IAM-principals, encryptiesleutels en lifecycle-/retentieconfiguraties — met een **negatieve toegangstest** die aantoont dat een productiecredential geen toegang geeft tot test en omgekeerd (T-27) **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-25 | `IS` | Ontworpen | Onveranderlijkheid van de financiële administratie | applicatie | Tech lead + Compliance | open | [ADR-0002](../architecture/adr/0002-technologiestack.md) | append-only double-entry ledger aantonen: geen updates of deletes, correcties uitsluitend via tegenboekingen, idempotency keys en correlation IDs **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-26 | `IS` | Ontworpen | Functiescheiding bij correcties (maker-checker) | beheerinterface | Compliance + Security | open | [ADR-0002](../architecture/adr/0002-technologiestack.md) | maker-checker inrichten; directe databasecorrecties technisch en organisatorisch verbieden **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-27 | `FR` | Ontworpen | **Vergunningstrategie en wettelijke route** om het besloten bedrijfsmodel uit te voeren | hele dienst | PO + Compliance | **uitgangspunt besloten 2026-08-06 (besluit 4A); route te valideren door specialist** | RD-23 · [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) §4A | **Uitgangspunt: vergunningplicht** — er wordt gebouwd alsof een vergunning vereist is. De exacte vergunning, grondslag en voorwaarden laten vaststellen door een gespecialiseerde financieel-regulatoire jurist tijdens het vergunningstraject, vóór gebruik met echte gebruikers **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-28 | `FR` | Ontworpen | **Vergunning** — is er een vereist, en zo ja welke? | hele dienst | Compliance | **te valideren door specialist** | RD-24 | laten vaststellen; bij een vergunningtraject doorlooptijd en organisatorische eisen in kaart brengen **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-29 | `FR` | Ontworpen | **Wettelijke uitzondering** — is er een van toepassing? | hele dienst | Compliance | **te valideren door specialist** | RD-25 | laten vaststellen; drempelbedragen betrekken (geen vastgesteld maximum op de inleg) **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-30 | `FR` | Ontworpen | **Vrijstelling** — is er een van toepassing, en onder welke voorwaarden? | hele dienst | Compliance | **te valideren door specialist** | RD-26 | laten vaststellen; voorwaarden vertalen naar productregels en controls **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-31 | `FR` | Ontworpen | **Ontheffing** — is die nodig of mogelijk, en onder welke voorwaarden? | hele dienst | Compliance | **te valideren door specialist** | RD-27 | laten vaststellen als vergunning noch uitzondering of vrijstelling passend blijkt **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-32 | `CT` | Ontworpen | **Concentratierisico bij één provider**: productie, test, objectopslag en back-ups staan alle bij TransIP | platform + continuïteit | Tech lead + Ops | open | [ADR-0003](../architecture/adr/0003-cloudprovider.md) · T-29 · RR-2 | risico **periodiek herbeoordelen**; vóór echte klantgelden beoordelen of een back-upkopie buiten het provideraccount nodig is. Een geografisch gescheiden secundaire locatie bij dezelfde provider dekt account-, control-plane-, contract- en providerbrede uitval **niet** af **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-33 | `GB` | Ontworpen | **Besloten testgroep — verwerking van echte persoonsgegevens en volledige KYC** (besluit 7) | onboarding besloten testgroep | Privacy + PO | open | [`../product/closed-test-group.md`](../product/closed-test-group.md) | grondslag per verwerking, dataminimalisatie, bewaartermijnen, rechten van betrokkenen en DPIA afgerond vóór de start; privacyverklaring afgestemd op echte gegevens en volledige KYC; **WhatsApp als supportkanaal** beoordeeld op grondslag, verwerkersrelatie, doorgifte en bewaartermijn **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-34 | `FR` | Ontworpen | **Go/No-Go vóór start van de besloten testgroep** — operationele vrijgavevoorwaarde | release | PO + Compliance + Security + Ops | open | [`../product/closed-test-group.md`](../product/closed-test-group.md) §10 | aantonen dat aan alle vijf voorwaarden is voldaan: besluiten 1 t/m 8 vastgesteld · **de vereiste vergunning of een andere rechtsgeldige toestemming van de bevoegde toezichthouder is verleend** (besluit 4A; C-27 t/m C-31) · MVP voldoet aan de DoD · alle kritieke en hoge beveiligingsbevindingen opgelost of formeel geaccepteerd · succesvolle hersteltest van back-up en disaster recovery (C-12) **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-35 | `CT` | Ontworpen | **Deelnemersvoorwaarden en vertrouwelijkheid besloten testgroep** | deelnemersvoorwaarden | PO + Compliance | open | [`../product/closed-test-group.md`](../product/closed-test-group.md) §7 · RD-28 · RD-29 | voorwaarden opstellen en juridisch laten toetsen; vastleggen dat de vertrouwelijkheid uitsluitend ziet op niet-openbare informatie over de besloten test en geen afbreuk doet aan wettelijke rechten van deelnemers; contractuele gevolgen van beëindiging van deelname bij een lopend rendementcontract uitwerken **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-36 | `IS` | Ontworpen | **Leverancieronafhankelijkheid van het IAM** (besluit 8): geen leveranciersspecifieke IAM-code buiten de IdP-adapter | platform + domeinmodules | Tech lead + Security | open | [ADR-0004](../architecture/adr/0004-identity-and-access-management.md) | **architectuurtest** in CI die imports van leveranciersspecifieke IAM-code buiten de adapter laat falen; aantonen dat een andere OIDC-conforme provider bruikbaar is zonder wijziging aan de domeinlogica (T-33) **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-37 | `IS` | Ontworpen | **IAM-productiegereedheid** (besluit 8) | authenticatie, autorisatie, sessies, audit | Security + Ops | open | [ADR-0004](../architecture/adr/0004-identity-and-access-management.md) | aantoonbaar: passkeys functioneren · MFA werkt · recoveryprocedures getest (T-30) · sessiebeheer werkt · auditlogging werkt · autorisaties getest per rol · **penetratietest zonder kritieke of hoge IAM-bevindingen**. Onderdeel van de Go/No-Go vóór de besloten testgroep (C-34, voorwaarden 3 en 4) **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |
| C-38 | `CT` | Ontworpen | **Identity Provider: keuze, privacybeoordeling en beschikbaarheid** | platform + leveranciers | Security Architect + Tech lead + Privacy | open | [ADR-0004](../architecture/adr/0004-identity-and-access-management.md) §8A | **Leverancierskeuze gesloten (besluit 8A): Keycloak, self-hosted** — geen externe IdP-verwerker voor de kernverwerking, dus geen DPA voor de IdP zelf. **Nog open:** privacybeoordeling vóór productie (persoonsgegevens, logging, bewaartermijnen, verwerkerspositie); afzonderlijke beoordeling van gekoppelde externe e-mail- en supportdiensten; beoordeling van de SCIM-functionaliteit van de gebruikte versie — een previewfunctie wordt geen kritieke productieafhankelijkheid; beschikbaarheids- en herstelscenario (T-32) **Verificatie vindt pas plaats tijdens implementatie en acceptatie**; deze control beschrijft een nog te realiseren maatregel. | | |

## Werkwijze

1. **Nieuw onderwerp?** Maak een issue via `compliance-task.yml` en voeg een regel toe.
2. **Onderzoek** door de eigenaar; leg vast wat wél en niet duidelijk is.
3. **Validatie** door een bevoegde specialist bij alles wat juridisch of regulatoir is.
4. **Bewijs** vastleggen in [`audit-evidence.md`](audit-evidence.md).
5. **Herbeoordeling** minimaal elk kwartaal, en direct bij: nieuwe functionaliteit,
   nieuwe regio, nieuwe leverancier, of een wijziging in het type dienst.

## Wat dit register **niet** is

* Geen bewijs dat wij aan wet- en regelgeving voldoen.
* Geen vervanging van juridisch advies.
* Geen volledige lijst van toepasselijke regelgeving — die stelt een bevoegde specialist
  vast op basis van het type dienst (digitaal contractueel rendementproduct) en de markt
  (Nederland).
