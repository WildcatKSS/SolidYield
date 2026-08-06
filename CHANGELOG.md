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
- **Besluit 4A — vergunningstrategie.** SolidYield gaat uit van een **vergunningplicht**
  voor de voorgenomen dienstverlening en baseert ontwikkeling, architectuur,
  complianceprocessen en operationele inrichting op dat uitgangspunt. De repository gaat
  **niet langer uit van een mogelijke vergunning of uitzondering als primaire aanname**.
  Vastgelegd als sectie **4A** in
  [ADR-0007](docs/architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md) (#1)
- **Uitgangspunten van de dienstverlening expliciet vastgelegd:** SolidYield is
  contractspartij, ontvangt de gelden van klanten en beheert de wallets; het ingelegde geld
  wordt gedurende de looptijd eigendom van SolidYield en de klant ontvangt daarvoor een
  contractuele vordering; het rendement staat vooraf contractueel vast en wordt maandelijks
  uitgekeerd; de nominale inleg wordt aan het einde van de looptijd terugbetaald;
  contracten zijn niet overdraagbaar; er is geen tussentijdse uitstapmogelijkheid; het
  product is bedoeld voor particuliere én zakelijke klanten (#1)
- **Go-live-voorwaarde aangescherpt:** de formulering "bevestiging van de wettelijke
  grondslag" is repositorybreed vervangen door **"verlening van de vereiste vergunning of
  een andere rechtsgeldige toestemming van de bevoegde toezichthouder"**. Zolang die er niet
  is: **productie mag niet starten**, **de besloten testgroep met echte klantgelden mag niet
  starten** en **klantgelden mogen niet worden geaccepteerd** (#1)
- **Besluit 8A — gekozen Identity Provider.** SolidYield kiest **Keycloak**, **self-hosted**
  en native op Ubuntu Server LTS onder **systemd**. De productie-instantie draait op de
  bestaande productie-VPS, de test-instantie op de bestaande test-VPS. Vastgelegd als
  afzonderlijke sectie in
  [ADR-0004](docs/architecture/adr/0004-identity-and-access-management.md) §8A; er is geen
  nieuw ADR-nummer aangemaakt omdat ADR-0004 de providerselectie al als vervolgactie
  bevatte (#1)
- **Volledige scheiding tussen productie en test voor Keycloak:** afzonderlijke instanties,
  databases, databasegebruikers, realms, clients, signing keys, secrets,
  beheerdersaccounts, configuraties, e-mailconfiguraties, logging, monitoring en back-ups.
  Er worden **geen identitygegevens, accounts, credentials, sleutels of sessies** tussen
  productie en test gedeeld, en **geen productie-identiteiten naar test gekopieerd** (#1)
- **Kandidatenafweging vastgelegd:** Keycloak gekozen vanwege open source en self-hosting,
  volwassenheid, community, aansluiting op Spring Security, OIDC/OAuth, WebAuthn en
  passkeys, TOTP en recovery codes, sessiebeheer, rollen en groepen, ondersteuning van
  meerdere applicaties, beschikbare commerciële ondersteuning en beperkte vendor lock-in —
  en omdat het native op de vastgestelde Ubuntu/systemd-architectuur past. **Authentik**
  afgevallen omdat het gedocumenteerde installatiepad sterker containergericht is;
  **FusionAuth** omdat passkeys/WebAuthn een geactiveerde licentie vereisen (#1)
- **Hybride eigenaarschap van gegevens:** Keycloak beheert authenticatiecredentials,
  passkeys/WebAuthn, wachtwoorden waar van toepassing, TOTP, identitysessies en technische
  IdP-rollen; SolidYield beheert klantprofiel, KYC-status, klantacceptatie,
  risicoclassificatie, contracten, wallets, betalingen, domeinrollen en de audit van
  bedrijfsacties. **Er worden geen financiële domeingegevens in Keycloak opgeslagen** (#1)
- **Keycloak opgenomen in** systemd-processen, monitoring, back-upscope, de
  patchmanagementvervolgactie, de restore- en disaster-recoverytest en capaciteitsplanning.
  Keycloak deelt het faalscenario van de productie-VPS (T-28) en biedt **geen hoge
  beschikbaarheid**; bij strengere eisen kan een afzonderlijke VPS nodig zijn (#1)
- **Besluit 8 — Identity & Access Management.** **ADR-0004** toegevoegd: identiteit,
  authenticatie, autorisatie, accountlevenscyclus, sessiebeheer, beveiliging, audit en de
  koppeling met KYC. `identity` is een **zelfstandige module** die uitsluitend publieke
  interfaces levert aan `customer`, `compliance`, `notification`, `administration` en
  `audit`, en **nooit rechtstreeks communiceert met `ledger` of `reconciliation`** (#1)
- **Leverancieronafhankelijk IAM.** Authenticatie loopt via een externe **OIDC**-provider
  met OAuth 2.1, WebAuthn, MFA, RBAC, session- en device management, audit logging en
  SCIM-provisioning. De koppeling loopt via **één adapter**; dat is de enige plek waar
  leveranciersspecifieke code mag staan. De leverancierskeuze viel buiten besluit 8 en is
  gesloten in **besluit 8A** (Keycloak); de eis dat er geen leveranciersafhankelijkheid in
  architectuur of broncode terechtkomt, blijft onverkort gelden (#1)
- **Authenticatie:** **passkeys (WebAuthn) zijn de primaire methode** voor klanten;
  e-mailadres, TOTP en wachtwoord als fallback zolang operationeel nodig. Meerdere passkeys
  per account, met apparaatbeheer en intrekking; **privésleutels verlaten nooit het apparaat
  van de gebruiker**. Voor medewerkers zijn MFA en individuele accounts verplicht, met
  voorkeur voor passkeys en hardware security keys (#1)
- **Niet toegestaan:** SMS-authenticatie · social login · gedeelde accounts · hardcoded
  accounts · embedded secrets · autorisatie uitsluitend in de frontend · leveranciers-
  specifieke IAM-code in domeinmodules. De eerdere voorkeursvolgorde met "sms als laatste
  optie" is daarmee vervallen (#1)
- **Autorisatie:** **RBAC, afgedwongen in de servicelaag** — niet in controllers en niet
  uitsluitend in de frontend — plus eigenaarschapscontrole per object. **Geen algemene super
  administrator:** `Administrator` en `Security Administrator` zijn gescheiden rollen naast
  `Investor`, `Support`, `Compliance Analyst`, `Operations`, `Finance` en `Auditor`. ABAC
  kan later worden toegevoegd zonder RBAC te vervangen (#1)
- **Accountlevenscyclus** vastgelegd (Registered → EmailVerified → PendingKYC → Active →
  Suspended → Blocked → Closed → Archived), met volledige audit op iedere statuswijziging;
  **sessiebeheer** met sessierotatie, centrale intrekking en inzage en beëindiging van
  sessies door de gebruiker; **recovery** dat nooit een lager beveiligingsniveau heeft dan
  reguliere authenticatie (#1)
- **Security:** dreigingen **T-30 t/m T-33** toegevoegd (recovery als omweg om MFA heen,
  rechtentoekenning door een beheerder, uitval van de Identity Provider, en
  leveranciersspecifieke IAM-code die de domeinmodules in lekt); controls **C-36**
  (architectuurtest op leverancieronafhankelijkheid), **C-37** (IAM-productiegereedheid
  inclusief penetratietest) en **C-38** (Identity Provider: keuze, privacybeoordeling en
  beschikbaarheid) toegevoegd (#1)
- **Compliance:** **RD-30** en **RD-31** toegevoegd voor eisen aan sterke
  cliëntauthenticatie en aan uitbesteding van authenticatie aan een externe provider (#1)
- **Besluit 7 — besloten testgroep.** Nieuw document
  [`docs/product/closed-test-group.md`](docs/product/closed-test-group.md): de eerste
  besloten testgroep telt **maximaal tien deelnemers** — oprichters, ontwikkelaars,
  familie, vrienden en persoonlijk uitgenodigde bekenden — **uitsluitend op uitnodiging**.
  Open inschrijving maakt geen onderdeel uit van de MVP (#1)
- **De besloten testgroep is de eerste gecontroleerde productie-uitrol** en **start
  uitsluitend nadat de wettelijke grondslag uit besluit 4 is bevestigd**. Tot dat moment
  blijven de beperkingen uit besluit 4 onverkort van kracht; **besluit 4 zelf is inhoudelijk
  ongewijzigd** (#1)
- **Echte gegevens en echte geldstromen in de besloten testgroep:** echte
  persoonsgegevens, de volledige KYC-procedure, echte identificatie en verificatie; na
  bevestiging van de wettelijke grondslag ook echte stortingen, rendementcontracten,
  maandelijkse uitkeringen en terugbetaling van de nominale inleg. Sandboxgegevens blijven
  uitsluitend toegestaan voor interne ontwikkel- en acceptatietesten daarbuiten (#1)
- **Go/No-Go voor start van de besloten testgroep** vastgelegd als operationele
  vrijgavevoorwaarde (control **C-34**): besluiten 1 t/m 8 vastgesteld · wettelijke
  grondslag bevestigd · MVP voldoet aan de Definition of Done · alle kritieke en hoge
  beveiligingsbevindingen opgelost of formeel geaccepteerd · succesvolle hersteltest van
  back-up en disaster recovery. Opgenomen in de
  [platform-readinesschecklist](docs/operations/platform-readiness-checklist.md) (#1)
- **Support, vertrouwelijkheid, beëindiging en afronding vastgelegd:** support via e-mail,
  WhatsApp en de ingebouwde feedbackfunctie, met registratie in het centrale ticketsysteem;
  geen support via sociale media. Deelnemers accepteren vooraf de privacyverklaring en maken
  geen informatie over de besloten test openbaar zonder schriftelijke toestemming — die
  vertrouwelijkheid ziet uitsluitend op niet-openbare informatie en doet **geen afbreuk aan
  wettelijke rechten van deelnemers**. Na afloop kiest iedere deelnemer tussen omzetting naar
  een productieaccount of beëindiging (#1)
- **Compliance:** controls **C-33** (verwerking van echte persoonsgegevens en volledige KYC,
  inclusief WhatsApp als supportkanaal), **C-34** (Go/No-Go) en **C-35** (deelnemersvoorwaarden
  en vertrouwelijkheid) toegevoegd; **RD-28** en **RD-29** toegevoegd voor de informatie- en
  zorgplichtverplichtingen richting deelnemers en de toelaatbaarheid van de
  vertrouwelijkheidsafspraak. RD-14 aangevuld met de besloten testgroep (#1)
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
- **Rij 4a van de openstaande besluitentabel gesloten** — van "wettelijke grondslag, te
  valideren" naar **vergunningstrategie, besloten**. Bijgewerkt in README, ADR-0007,
  ADR-register, complianceregister (**C-27**), regulatoire besluiten (**RD-23 t/m RD-27**),
  architectuuroverzicht, roadmap, platform-readinesschecklist, MVP-scope, customer journey,
  productvisie, `closed-test-group.md`, threat model, `release-process.md`, `SUPPORT.md`,
  `scrum-guide.md`, `test-group-plan.md` en `data-flow.md` (#1)
- **Besluit 4 blijft inhoudelijk ongewijzigd.** Besluit 4A concretiseert uitsluitend het
  juridische uitgangspunt; bedrijfsmodel, geldstroom, contractstroom, walletrol en ketenrol
  zijn niet aangeraakt. Besluit 7 blijft afhankelijk van besluit 4A; besluit 8 is
  ongewijzigd (#1)
- **RD-24 t/m RD-27 aangepast op het nieuwe uitgangspunt:** een wettelijke uitzondering,
  vrijstelling of ontheffing is **niet langer de primaire aanname** maar een mogelijke
  uitkomst van het vergunningstraject. Het team wijst **geen vergunningcategorie en geen
  toezichthouder** aan; dat blijft het werk van Compliance en een gespecialiseerde
  financieel-regulatoire jurist (#1)
- **Open gebleven als vervolgactiviteit, niet als besluit:** de exacte vergunningcategorie,
  de definitieve vergunningsvoorwaarden, eventuele aanvullende eisen van de toezichthouder
  en de planning van het vergunningstraject (#1)
- **Rij 8a van de openstaande besluitentabel gesloten**; `[IDP]` ingevuld met Keycloak.
  Keycloak wordt niet langer als "uitsluitend MVP-referentie" gepresenteerd maar als de
  **gekozen provider** — bijgewerkt in README, ADR-register, architectuuroverzicht,
  systeemcontext, `security-principles.md`, `access-control.md`, `deployment.md`,
  `backup-and-recovery.md`, `platform-readiness-checklist.md`, het threat model, het
  complianceregister en `placeholders.md` (#1)
- **De adaptergrens blijft onverkort gelden.** Keycloak wordt uitsluitend gekoppeld via
  OIDC, gestandaardiseerde claims en één IdP-adapter. Buiten die grens niet toegestaan:
  Keycloak-specifieke imports, datamodellen, directe toegang tot de Keycloak-database,
  Keycloak-specifieke domeinregels en autorisatie die uitsluitend op Keycloak-rollen steunt
  zonder controle in de SolidYield-servicelaag. **T-33** is hierop aangescherpt: nu de
  leverancier vaststaat, wordt dit risico groter in plaats van kleiner (#1)
- **C-38 herzien:** de leverancierskeuze is gesloten; open blijven de privacybeoordeling
  vóór productie, de afzonderlijke beoordeling van gekoppelde externe diensten zoals
  e-mailverzending, de beoordeling van de SCIM-functionaliteit van de gebruikte versie, en
  het beschikbaarheids- en herstelscenario. **RD-31** aangevuld: Keycloak is self-hosted en
  introduceert daardoor geen externe IdP-verwerker voor de kernverwerking (#1)
- **SCIM blijft een architectuureis, geen aangenomen Keycloak-functie.** De
  SCIM-functionaliteit van de gebruikte versie wordt vóór productie beoordeeld; een
  previewfunctie wordt **niet** als kritieke productieafhankelijkheid gebruikt. Voor de MVP
  kan provisioning via de adapter en ondersteunde beheer-API's plaatsvinden (#1)
- **Fasering van besluit 8A vastgelegd:** de **keuze** is besloten en ontworpen;
  installatie, realms, clients, passkeyflows, MFA, back-ups, monitoring, recovery,
  penetratietest en adaptertest zijn **nog te implementeren of nog te verifiëren**. Keycloak
  recovery codes mogen als technische mogelijkheid worden onderzocht maar vormen niet
  automatisch het operationele recoveryproces; die vervolgactie blijft ongewijzigd (#1)
- **Ontwerp, implementatie en bewijs expliciet uit elkaar getrokken.** Vastgelegd dat een
  ADR een **ontwerpbesluit** is en dat een control **niet** betekent dat de maatregel
  bestaat; verificatie vindt pas plaats tijdens implementatie en acceptatie. Het
  complianceregister heeft een kolom **Fase** gekregen (Nog te ontwerpen · Ontworpen · Nog
  te implementeren · Nog te verifiëren · Operationeel) met een definitie per fase, het
  ADR-register een kolom **Fase**, en README, ADR-register, complianceregister en threat
  model een banner die vastlegt dat er nog **geen applicatiecode** is en **geen enkele
  maatregel operationeel** is. De vijftien in deze PR toegevoegde controls (C-24 t/m C-38)
  vermelden expliciet dat verificatie pas bij implementatie en acceptatie plaatsvindt (#1)
- **Threat model:** de kolommen *Maatregelen* en *Verificatie* zijn geëxpliciteerd als
  **ontworpen** respectievelijk **nog uit te voeren**; een dreiging met een ingevulde
  maatregel is niet afgedekt maar voorzien van een plan (#1)
- **IAM-recovery verduidelijkt** (geen nieuw besluit): vastgelegd dat vóór productie een
  **operationeel recoveryproces** moet bestaan, met als vervolgactie de minimaal uit te
  werken scenario's — verlies van alle passkeys, verlies van TOTP, verlies van
  e-mailadres, verloren apparaat, recovery van medewerkeraccounts en recovery van accounts
  met verhoogde rechten. Er wordt bewust **geen oplossing** beschreven (#1)
- **Reikwijdte van de Docker-uitsluiting verduidelijkt:** de uitsluiting geldt uitsluitend
  voor productie, test en de deploymentarchitectuur. Lokale ontwikkelhulpmiddelen zoals
  Testcontainers zijn daardoor **niet automatisch uitgesloten**. Dit is een verduidelijking
  van de reikwijdte, **geen nieuw technisch besluit** (#1)
- **SLO's:** vastgelegd dat de beschikbaarheidsdoelstelling (SLO-1) en de RTO (SLO-8) pas
  definitief kunnen worden vastgesteld nadat hersteltests, back-uptests, disaster
  recovery-tests en operationele metingen beschikbaar zijn. Tot dan zijn `99,5%` en
  `< 4 uur` **voorlopige waarden**. Opgenomen als vervolgactie; de gekozen architectuur
  verandert niet (#1)
- **Patchmanagement** als open vervolgactie opgenomen: vóór productie moet een operationeel
  proces worden vastgesteld voor reguliere updates, spoedpatches, onderhoudsvensters,
  rollback en testvolgorde (#1)
- **Operationele runbooks** als open vervolgactie opgenomen voor onder andere account
  recovery, providerstoringen, mislukte betalingen, reconciliation, dead letter jobs,
  KYC-herbeoordeling en incidentafhandeling. Er worden **geen procedures beschreven** (#1)
- **WhatsApp verduidelijkt** (besluit ongewijzigd): WhatsApp is **uitsluitend een eerste
  contactkanaal**. Authenticatie, identiteitsvaststelling, rekeningwijzigingen, gevoelige
  persoonsgegevens en andere beveiligingsgevoelige verzoeken worden **nooit uitsluitend via
  WhatsApp** afgehandeld; alle verzoeken gaan naar het centrale ticketsysteem (#1)
- **Toegankelijkheid bij recovery:** de keuze om SMS niet te gebruiken blijft ongewijzigd.
  Vastgelegd dat vóór productie een **toegankelijk alternatief** moet worden vastgesteld
  voor gebruikers die geen passkeys kunnen gebruiken. Dit blijft een **open ontwerpvraag**;
  er wordt geen oplossing gekozen (#1)
- **Functiescheiding:** alle rollen blijven ongewijzigd. Vastgelegd dat vóór productie een
  **functiescheidingsmatrix** moet worden opgesteld met toegestane en verboden
  rolcombinaties en de toepassing van maker-checker in kleine teams (#1)
- **Traceerbaarheid:** als vervolgactie opgenomen dat vóór merge een traceerbaar
  GitHub-issue wordt aangemaakt dat besluiten 1 t/m 8, de resterende open besluiten en de
  vervolgacties met deze pull request verbindt (DoD-criterium U7). Alle vervolgacties staan
  gebundeld als **V-1 t/m V-7** in `README.md` §10 (#1)
- **`[IDP]` ingevuld op modelniveau** en rij 8 van de openstaande besluitentabel op
  **besloten** gezet, met een nieuwe rij **8a** voor de nog openstaande definitieve
  leverancierskeuze. Bijgewerkt in README, `architecture-overview.md`, `system-context.md`,
  `access-control.md`, `security-principles.md`, `customer-journey.md`, `mvp-scope.md` en
  `placeholders.md` (#1)
- **Argon2id blijft conditioneel geformuleerd:** verplicht wanneer SolidYield zelf
  wachtwoorden opslaat, en anders een aantoonbaar minimaal gelijkwaardig beveiligingsniveau
  bij de Identity Provider. Het ankerpunt is verplaatst van ADR-0002 naar **ADR-0004** (#1)
- **MVP-aanname A9 aangescherpt:** niet langer "MFA is acceptabel voor de doelgroep", maar
  of **passkeys en MFA werkbaar zijn zonder smartphone en bij lage digitale vaardigheid** —
  omdat SMS als factor is uitgesloten. Te toetsen met minimaal twee deelnemers met lage
  digitale vaardigheid (#1)
- **Systeemcontext:** dubbele aanname-ID's opgelost — de bij besluit 5 toegevoegde regel
  over gescheiden productie- en testomgevingen botste met de bestaande SA-2 en is
  hernummerd naar **SA-5**. De tabel "nog te beslissen" is bijgewerkt: technologiestack,
  cloudprovider en IAM zijn gesloten (#1)
- **"Testgroep" uit elkaar getrokken in twee begrippen.** De repository gebruikte één term
  voor twee verschillende activiteiten. Vastgelegd is nu het onderscheid tussen
  **onderzoekssessies** (testomgeving, uitsluitend synthetische data, representatieve
  spreiding — [`docs/research/test-group-plan.md`](docs/research/test-group-plan.md)) en de
  **besloten testgroep** (productieomgeving, echte gegevens, echte geldstromen — besluit 7).
  Bijgewerkt in het testgroepplan, `SUPPORT.md`, `GOVERNANCE.md`,
  `security-principles.md`, `release-process.md`, de customer journey en de MVP-scope (#1)
- **Security:** expliciet vastgelegd dat besluit 7 de regel *geen productiedata buiten
  productie* **niet** verruimt: de besloten testgroep draait in productie, en er komen nooit
  echte gegevens in development, test, staging, demo-omgevingen of securityonderzoek
  (#1)
- **`[TESTGROEP]` ingevuld** en rij 7 van de openstaande besluitentabel op **besloten**
  gezet; de roadmapafhankelijkheid "samenstelling testgroep" is gesloten en gesplitst in een
  resterende actie voor de werving van onderzoeksdeelnemers (#1)
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
