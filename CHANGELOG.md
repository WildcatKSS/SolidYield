# Changelog

Alle noemenswaardige wijzigingen aan dit project worden in dit bestand vastgelegd.

Het formaat volgt [Keep a Changelog](https://keepachangelog.com/nl/1.1.0/) en dit project
volgt [Semantic Versioning](https://semver.org/lang/nl/).

Rubrieken: `Toegevoegd`, `Gewijzigd`, `Verouderd`, `Verwijderd`, `Opgelost`, `Security`.
Vermeld bij elke regel het issue- of PR-nummer. Regels met privacy-, compliance- of
security-impact worden expliciet gemarkeerd.

> **Deze changelog begint leeg, en dat is de bedoeling.** Hij hoort bij *jouw* product.
> De ontwikkelgeschiedenis van de template zelf staat in de
> [Releases](../../releases) van de templaterepository, niet hier — anders zou elke
> nieuwe repository beginnen met releases die nooit hebben plaatsgevonden.
>
> Vul hieronder je eigen wijzigingen in en vervang `[ORGANISATIE]/[REPOSITORY]` in de
> linkregels onderaan door je eigen repository.

## [Unreleased]

### Toegevoegd
- **Besluit 6 — sprintduur.** SolidYield werkt met sprints van **twee weken** (veertien
  kalenderdagen), met een vaste start- en einddag. Iedere sprint bevat minimaal sprint
  planning, dagelijkse afstemming, backlog refinement, sprint review en retrospective.
  Vastgelegd in [`docs/scrum/scrum-guide.md`](docs/scrum/scrum-guide.md) §2 (#1)
- **Eén gezamenlijke productbacklog:** architectuur-, security-, privacy-, compliance-,
  operations- en documentatiewerk staat in dezelfde geprioriteerde backlog als functionele
  ontwikkeling en wordt niet in een afzonderlijk parallel traject uitgevoerd (#1)
- **Cadansuitgangspunten vastgelegd:** de Scrum Master bewaakt de cadans, de Product Owner
  bepaalt prioriteit en sprintdoel, het ontwikkelteam bepaalt de op te nemen hoeveelheid
  werk; onvoltooid werk schuift niet automatisch door maar wordt opnieuw beoordeeld en
  geprioriteerd; urgente productie- en security-incidenten mogen de sprint onderbreken
  volgens het incidentproces; compliance- of juridische blokkades worden zichtbaar als
  backlogitem, afhankelijkheid of releasevoorwaarde (#1)
- **Richtlijnen per ceremonie** toegevoegd aan de scrumgids: doelen van de sprint planning,
  de vijftienminutengrens en het buiten de dagelijkse afstemming houden van inhoudelijke
  probleemoplossing, refinement minimaal één keer per sprint inclusief architectuur-,
  security-, privacy- en compliance-impact, de sprint review met de Definition of Done als
  maatstaf, en verbeteracties uit de retrospective met een eigenaar (#1)
- **Begrenzing vastgelegd:** een sprintcadans is **geen toestemming** om echte klantgelden,
  bindende rendementcontracten of productiegebruik toe te staan zolang de wettelijke
  grondslag niet is bevestigd (#1)
- **Besluit 5 — technologiestack en hosting.** **ADR-0002** (technologiestack) en
  **ADR-0003** (cloudprovider en hostingarchitectuur) toegevoegd, beide
  **Geaccepteerd**. Kotlin/Spring Boot met Spring Modulith als modulaire monoliet,
  React/TypeScript/Vite als statische frontend achter Nginx, PostgreSQL, jOOQ en
  Flyway; achtergrondverwerking via een PostgreSQL job queue met Transactional Outbox
  (#1)
- **Hosting:** TransIP met twee afzonderlijke VPS'en (Ubuntu Server LTS) voor productie
  en test, volledig gescheiden; test uitsluitend bereikbaar via WireGuard. Provisioning
  met Ansible, Git en systemd; geen handmatige productieconfiguratie (#1)
- **Financiële administratie:** immutable double-entry ledger — append-only, geen
  updates of deletes, correcties uitsluitend via tegenboekingen, idempotency keys,
  correlation IDs en geen floating point (#1)
- **Security:** dreigingen T-24 t/m T-28 toegevoegd (VPS-toegang, schemawijziging buiten
  de applicatie om, object-storagecredentials, productiegegevens in test, uitval van de
  enige productie-VPS); controls C-24 t/m C-26 toegevoegd (omgevingsscheiding,
  onveranderlijkheid van de administratie, maker-checker) (#1)
- **ADR-0007** (Vergunningplicht en rol in de keten) toegevoegd: geaccepteerd voor de
  **bedrijfs- en keteninrichting**; wettelijke grondslag en juridische uitvoerbaarheid
  blijven te valideren (#1)
- **ADR-0008** (Geld- en contractstroom, met sequencediagrammen) toegevoegd: geaccepteerd
  als **functioneel ontwerp**, uitsluitend uitvoerbaar met synthetische data en
  sandboxintegraties totdat de wettelijke grondslag is bevestigd (#1)
- **Besluit 4 genomen:** het bedrijfs- en ketenmodel is vastgesteld. SolidYield is
  contractspartij, houdt de wallet, investeert voor eigen rekening en risico, betaalt
  een vast rendement en betaalt de volledige nominale inleg terug; betalingen verlopen
  via vergunninghoudende betaalpartners (#1)
- **Betaalpartners:** de MVP is ontworpen voor integratie met vergunninghoudende
  betaalpartners. De eerste implementatierichting is Mollie (iDEAL/SEPA) en bunq (IBAN,
  uitbetalingen, reconciliatie). De definitieve selectie en rolverdeling worden
  contractueel en regulatoir vastgesteld; er is nog geen overeenkomst gesloten (RD-22) (#1)
- **MVP-beperkingen vastgelegd** tot de wettelijke grondslag is bevestigd: toegestaan
  zijn UX, werkende MVP, sandboxbetalingen, synthetische data, besloten demonstraties
  en technische integraties; niet toegestaan zijn echte klantgelden, bindende
  rendementcontracten, werkelijke rendementuitkeringen en productiegebruik (#1)
- **Compliance:** RD-23 t/m RD-27 toegevoegd voor de wettelijke route, vergunning,
  wettelijke uitzondering, vrijstelling en ontheffing; controls C-27 t/m C-31
  toegevoegd. C-01 gesloten met de motivatie dat bedrijfsmodel en ketenrol zijn
  vastgesteld en de juridische grondslag afzonderlijk wordt bepaald (#1)
- **Security:** dreigingen T-19 t/m T-23 toegevoegd aan het threat model, waaronder
  onveranderlijkheid van gesloten contracten, idempotentie van rendementuitkeringen en
  een blokkade op echte klantgelden vóór bevestiging van de wettelijke grondslag (#1)
- Productparameters vastgelegd: looptijden 3, 6, 12, 24, 36 en 60 maanden; minimum
  inleg € 50; geen vastgesteld maximum; vast rendement, maandelijks uitgekeerd;
  volledige inleg terug aan het einde van de looptijd (#1)
- Walletrol vastgelegd: storten, opnemen naar de eigen tegenrekening en vastzetten;
  geen P2P-betalingen en geen betalingen aan derden (#1)
- MVP-doelgroep vastgelegd: Nederlandse consumenten, zzp'ers en rechtspersonen, met
  start uitsluitend in een besloten testgroep (#1)
- **Compliance:** RD-20 (werking van administratieve vermogensscheiding bij
  faillissement), RD-21 (houdbaarheid en communicatie van de positie als concurrent
  schuldeiser) en RD-22 (definitieve rolverdeling met betaalpartners) toegevoegd;
  controls C-21 t/m C-23 toegevoegd aan het complianceregister (#1)
- Productvisie ingevuld voor SolidYield: doelgroep, probleem, productdoel en
  marktafbakening (Nederland, NL, EUR) (#1)
- Productdoel PD-1 vastgelegd, met meetwaarden en PD-0 (validatie) als voorliggend
  doel (#1)
- **Compliance:** RD-15 en RD-16 toegevoegd aan het register van regulatoire
  besluiten — presentatie als product zonder beleggingsrisico, en de constructie
  onder het rendement (#1)

### Gewijzigd
- **`[SPRINTDUUR]` overal ingevuld.** README, `placeholders.md`, `project-board.md`,
  `scrum-guide.md`, `sprint-planning.md`, `sprint-review.md`, `retrospective.md`,
  `refinement.md`, `roadmap.md` en `mvp-scope.md` spreken nu consequent van twee weken; de
  keuzetabel met 1 week versus 2 weken is vervallen. Rij 6 van de openstaande
  besluitentabel staat op **besloten** (#1)
- **MVP-aannames:** de aanname "sprintduur van 2 weken past bij het team" is gesloten door
  besluit 6; of de cadans blijft passen is voortaan een terugkerend onderwerp in de
  retrospective, geen openstaande MVP-aanname. Dubbele aanname-ID's A6 en A7 opgelost: de
  bestaande template-aannames zijn hernummerd naar **A9** en **A10** (#1)
- **Roadmap:** de afhankelijkheid "keuze technologiestack en cloud" is gesloten met
  verwijzing naar ADR-0002 en ADR-0003; de wettelijke grondslag is als blokkerende
  afhankelijkheid toegevoegd; sprintnummers zijn geduid als sprints van twee weken, met de
  expliciete kanttekening dat dit een ordegrootte is en geen releasetoezegging (#1)
- **Reviewbevindingen op besluit 5 verwerkt.** **Provider- en accountrisico** worden nu
  onderscheiden: een geografisch gescheiden secundaire locatie bij dezelfde provider
  beperkt locatiegebonden uitval, maar neemt providerbrede, accountgebonden en
  control-plane-risico's niet weg. Dat concentratierisico wordt bewust geaccepteerd voor
  de MVP, periodiek herbeoordeeld en is een herzieningstrigger voor ADR-0003. Vastgelegd
  als **T-29**, restrisico **RR-2** en control **C-32**. TransIP is vastgelegd als de
  gekozen **startprovider**; een latere onafhankelijke back-uplocatie bij een andere
  partij is niet langer architectonisch uitgesloten (#1)
- **Object Store-scheiding aangescherpt.** Generieke bucketnamen zijn vervangen door
  `solidyield-production-documents`, `solidyield-production-exports`,
  `solidyield-production-backups`, `solidyield-test-documents`, `solidyield-test-exports`
  en `solidyield-test-backups`. Productie en test gebruiken afzonderlijke credentials,
  access keys, endpoints/accounts of IAM-principals, encryptiesleutels en
  lifecycle-/retentieconfiguraties: een verkeerde productiecredential mag technisch geen
  toegang geven tot test en omgekeerd (C-24, T-27) (#1)
- **Authenticatie losgekoppeld van besluit 8.** Passkeys/WebAuthn, TOTP, veilige
  sessiecookies en sterke MFA zijn verplichte authenticatiemogelijkheden. Argon2id is
  verplicht wanneer SolidYield zelf wachtwoorden beheert; bij uitbesteding aan een
  identity-provider moet die provider een aantoonbaar gelijkwaardig of sterker mechanisme
  gebruiken. Argon2id is daarmee geen onvoorwaardelijke implementatiekeuze meer (#1)
- **Outbox-garantie gecorrigeerd:** de Transactional Outbox waarborgt atomische opslag van
  domeinwijziging en event, maar aflevering is **at-least-once** en geen exactly-once;
  consumers en jobhandlers moeten daarom idempotent zijn (#1)
- **Flyway-migratieconventie vastgelegd:** eigen migratielocatie per module met één
  gedeelde schemahistorie en **globaal unieke, tijdgebonden versienummers**
  (`V<jjjjMMddHHmm>__<module>_<beschrijving>.sql`), bewaakt met een CI-check op dubbele
  versienummers (#1)
- **Complianceregister:** dubbele control-ID's opgelost. De bij besluit 4 toegevoegde rijen
  botsten met de bestaande C-16 t/m C-20; zij zijn hernummerd naar **C-21 t/m C-23** en
  **C-27 t/m C-31**. C-24 t/m C-26 zijn ongewijzigd (#1)
- **ADR-0006 aangepast:** "één secundaire EER-regio" is vervangen door "één geografisch
  gescheiden secundaire locatie binnen de Europese Economische Ruimte". Die locatie hoeft
  niet in een ander land te liggen, mits de oplossing aantoonbaar voldoende bescherming
  biedt tegen uitval van de primaire locatie. Definities, motivatie, gevolgen en
  vervolgacties zijn hierop aangepast; de term is repositorybreed bijgewerkt (#1)
- Achterhaalde verwijzingen naar AWS, Azure, GCP, Kubernetes en Docker vervangen door de
  vastgestelde architectuur (#1)
- Besluit 3 verwerkt: markt Nederland, taal Nederlands, valuta EUR. Opslag en reguliere
  verwerking binnen de EER, primaire productieomgeving in Nederland, back-up en disaster
  recovery op één geografisch gescheiden secundaire locatie binnen de EER. Vastgelegd als
  **ADR-0006**; `[REGIO]` is daarmee overal ingevuld (#1)
- **Privacy:** toegang vanuit derde landen is standaard uitgesloten; een vooraf
  goedgekeurde uitzondering geldt als internationale doorgifte en wordt als zodanig
  geregistreerd (ADR-0006) (#1)
- **Compliance:** RD-07 op de beleidskant gesloten — opslag en reguliere verwerking
  uitsluitend binnen de EER. De juridische beoordeling van een concrete uitzondering
  blijft een taak voor Privacy en Compliance (#1)
- Type financiële dienst vastgesteld: digitaal contractueel rendementproduct. De
  werking is beschreven in de productvisie §6 (#1)
- **Compliance:** RD-17 t/m RD-19 toegevoegd (kwalificatie van de wallet,
  kwalificatie van het product, kapitaalvereisten); RD-16 deels beantwoord; RD-01
  herschreven naar de vraag via welke wettelijke route het besloten bedrijfsmodel
  mag worden uitgevoerd (#1)
- Productdoel PD-1 uitkomstgericht geherformuleerd: een inleg die binnen vijftien
  minuten zelfstandig af te ronden is, en die de gebruiker daarna aantoonbaar
  begrijpt (uitkering én risico). Meetwaarde voor doorlooptijd toegevoegd (#1)

<!--
Voorbeeld van een ingevulde release. Verwijder dit commentaar zodra je eigen releases
hier staan.

## [1.1.0] - 2026-03-12

### Toegevoegd
- Maandoverzicht per uitgavencategorie op het dashboard (#123)

### Security
- Sessie-timeout teruggebracht van 60 naar 15 minuten (#131) — security-impact: hoog

### Opgelost
- Bedragen werden afgerond weergegeven in het transactieoverzicht (#128)
-->

[Unreleased]: https://github.com/[ORGANISATIE]/[REPOSITORY]/commits/main
