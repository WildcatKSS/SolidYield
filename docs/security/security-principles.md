# Securityprincipes

De uitgangspunten waar elk backlogitem, elke pull request en elke release aan wordt
getoetst. Wie hiervan wil afwijken, doorloopt de procedure voor risicoacceptatie uit
[`../../GOVERNANCE.md`](../../GOVERNANCE.md).

## 1. Kernprincipes

| Principe | Betekenis in de praktijk |
|---|---|
| **Secure by design** | security zit in het ontwerp en in de acceptatiecriteria, niet in een controle achteraf |
| **Privacy by design & default** | de standaardinstelling is de meest privacyvriendelijke |
| **Least privilege** | iedereen en alles krijgt de minimale rechten, tijdelijk waar mogelijk |
| **Defence in depth** | meerdere lagen; het falen van één maatregel is geen ramp |
| **Fail secure** | bij twijfel weigeren, niet toestaan |
| **Complete mediation** | elk verzoek wordt opnieuw geautoriseerd; nooit vertrouwen op een eerdere controle |
| **Geen security by obscurity** | verborgenheid is geen maatregel |
| **Traceerbaarheid** | wie deed wat, wanneer — aantoonbaar |
| **Zo min mogelijk gegevens** | wat je niet hebt, kan niet lekken |

## 2. Concrete eisen

### 2.1 Authenticatie
* Wachtwoorden: minimaal 12 tekens, gecontroleerd tegen bekende gelekte wachtwoorden,
  geen verplichte periodieke wijziging, opgeslagen met een moderne, trage hashfunctie.
  Voor SolidYield geldt ([ADR-0004](../architecture/adr/0004-identity-and-access-management.md)):
  **Argon2id is verplicht wanneer SolidYield zelf wachtwoorden opslaat**; voert de Identity
  Provider het wachtwoordbeheer uit, dan moet die provider **aantoonbaar minimaal een
  gelijkwaardig beveiligingsniveau** bieden. Argon2id is dus **geen onvoorwaardelijke
  implementatiekeuze**. Met **Keycloak** als gekozen provider (besluit 8A) beheert de
  Identity Provider de wachtwoorden; dat het geboden niveau aantoonbaar gelijkwaardig of
  sterker is, moet vóór productie worden **geverifieerd** — het is nu ontwerp, geen bewijs.
* **Passkeys (WebAuthn) zijn de primaire authenticatiemethode** voor klanten. Wachtwoord is
  een **fallback zolang dat operationeel nodig is**, geen gelijkwaardig alternatief.
  Passkeys/WebAuthn, TOTP, veilige sessiecookies en sterke MFA zijn **verplichte**
  authenticatiemogelijkheden, ongeacht de leverancier.
* **Niet toegestaan:** SMS-authenticatie · social login · gedeelde accounts · hardcoded
  accounts · embedded secrets (ADR-0004).
* Meerdere passkeys per account; gebruikers kunnen apparaten benoemen, verwijderen en
  passkeys intrekken. **Privésleutels verlaten nooit het apparaat van de gebruiker.**
* Snelheidsbeperking en progressieve vertraging op inlogpogingen; account nooit permanent
  blokkeren op basis van invoer van derden (dat is zelf een aanvalsmiddel).
* Neutrale foutmeldingen: nooit onthullen of een account bestaat.
* Melding aan de gebruiker bij inloggen vanaf een nieuw apparaat, wachtwoordwijziging en
  wijziging van MFA.

### 2.2 Multifactor-authenticatie
* **Verplicht** voor inloggen en voor gevoelige handelingen (gegevens koppelen, exporteren,
  account verwijderen, `[TRANSACTIE]`).
* Voorkeursvolgorde: **passkeys/WebAuthn → authenticator-app (TOTP)**. **SMS is geen
  toegestane factor** (ADR-0004) — ook niet als laatste optie.
* Medewerkers: **MFA verplicht**, individuele accounts, voorkeur voor passkeys en hardware
  security keys; TOTP uitsluitend als fallback. Bij **verhoogde rechten** hebben hardware
  security keys of hardware-backed passkeys de voorkeur.
* Herstelcodes: eenmalig, veilig getoond, herbruikbaarheid uitgesloten.
* MFA moet toegankelijk zijn: bied een alternatief voor wie geen smartphone heeft. Omdat
  SMS is uitgesloten, moet dat alternatief uit de toegestane middelen komen — bijvoorbeeld
  een TOTP-app op desktop of een hardware security key. **Dit is een reëel
  toegankelijkheidsrisico voor minder digitaal vaardige gebruikers** en een expliciet
  aandachtspunt voor de usabilityvalidatie.

### 2.3 Sessies
* Korte inactiviteitstime-out (`[15]` minuten), absolute maximale duur (`[8]` uur).
* **Sessierotatie** en **centrale intrekking**; gebruikers kunnen **actieve sessies
  bekijken**, **individuele sessies beëindigen** en **alle sessies beëindigen**
  (ADR-0004).
* Cookies: `Secure`, `HttpOnly`, `SameSite=Lax` of strikter; sessie-ID vernieuwen bij
  inloggen en rechtenwijziging.
* Serverseitig intrekbaar; "log overal uit" beschikbaar voor de gebruiker.
* Herauthenticatie vóór gevoelige handelingen, ook binnen een geldige sessie.

### 2.4 Autorisatie
* **RBAC, afgedwongen in de servicelaag** — niet in controllers en niet uitsluitend in de
  frontend (ADR-0004) — **plus** eigenaarschapscontrole per object bij élk verzoek
  (voorkomt IDOR).
* Autorisatie altijd serverseitig; de client verbergt hooguit, hij beslist nooit.
* **Geen algemene super administrator.** `Administrator` en `Security Administrator` zijn
  gescheiden rollen. ABAC kan later worden toegevoegd zonder RBAC te vervangen.
* Standaard weigeren; toegang expliciet toekennen.
* Support- en beheerrechten zijn tijdelijk, beperkt en volledig geaudit.

### 2.5 Encryptie
* In transport: TLS 1.2+ (bij voorkeur 1.3), HSTS, moderne cipher suites.
* In rust: volledige-schijf- of database-encryptie; extra encryptie op veldniveau voor
  bijzonder gevoelige gegevens.
* Sleutels in een KMS/HSM, met rotatiebeleid; nooit in code, image of repository.
* Alleen standaardalgoritmen; nooit zelf cryptografie bedenken.

### 2.6 Secrets management
* Secrets in een secrets manager of GitHub Actions Secrets, nooit in de repository.
* Secret scanning **en** push protection ingeschakeld.
* Rotatie: periodiek en direct bij elk vermoeden van blootstelling.
* Een gepusht secret is per definitie gecompromitteerd: eerst roteren, dan opruimen.
* In CI/CD OIDC-federatie in plaats van langlevende cloudsleutels.

### 2.7 Invoervalidatie en uitvoer
* Valideren op de server, op basis van een allowlist (type, lengte, bereik, formaat).
* Nooit vertrouwen op clientvalidatie of verborgen velden.
* Geparametriseerde queries; geen stringconcatenatie in queries of commando's.
* Contextafhankelijke codering bij uitvoer; strikte Content Security Policy.
* Bestandsuploads: type en grootte beperken, buiten de webroot opslaan, scannen.

### 2.8 Veelvoorkomende webkwetsbaarheden
Neem de OWASP Top 10 als ondergrens en toets die aantoonbaar:
kapotte toegangscontrole · cryptografische fouten · injectie · onveilig ontwerp ·
onveilige configuratie · verouderde componenten · fouten in identificatie en
authenticatie · integriteitsfouten in software en data · onvoldoende logging en
monitoring · server-side request forgery.

### 2.9 Audit logging
* Vastleggen: inloggen (geslaagd/mislukt), MFA-wijzigingen, rechtenwijzigingen,
  toegang tot gegevens door support/beheer, wijzigingen aan financiële gegevens,
  toestemming geven en intrekken, export en verwijdering, en configuratiewijzigingen.
* Per gebeurtenis: tijdstip (UTC), actor, actie, object, resultaat, correlatie-ID.
* **Nooit** wachtwoorden, tokens, volledige rekeninginformatie of onnodige
  persoonsgegevens in de log.
* Append-only opslag, aparte rechten, eigen bewaartermijn.

### 2.10 Fraude en limieten
* Limieten en controles altijd **serverseitig**: bedrag per keer, per dag, snelheid,
  aantal pogingen.
* Afwijkingsdetectie op ongebruikelijk gedrag; escalatie naar handmatige controle boven
  `[BEDRAG]`.
* Wachttijd of extra verificatie na wijziging van kritieke gegevens (bijvoorbeeld een
  tegenrekening).
* Vier-ogenprincipe voor handmatige correcties.

### 2.11 Foutafhandeling
* Gebruiker ziet een begrijpelijke melding met een correlatie-ID; nooit stacktraces,
  querygegevens, versies of interne paden.
* Fouten worden intern volledig gelogd, zonder gevoelige gegevens.
* Time-outs en degradatie zijn expliciet ontworpen, niet toevallig.

### 2.12 Rate limiting en misbruikbescherming
* Limieten per IP **en** per account op inloggen, registreren, herstellen, exporteren en
  zware queries.
* Botbescherming op registratie; bij voorkeur zonder onnodige toegankelijkheidsdrempel.
* Monitoring en alarmering op afwijkende patronen.

### 2.13 API's
* Authenticatie op elke endpoint (ook interne); geen impliciet vertrouwen.
* Expliciet schema, strikte validatie, versiebeheer.
* Geen gevoelige gegevens in URL's of querystrings.
* Beperkte CORS-configuratie; geen wildcards met credentials.
* Paginering en limieten om massale uitlezing te voorkomen.

### 2.14 Afhankelijkheden en supply chain
* Lockfiles vastgelegd; reproduceerbare builds.
* Dependabot, dependency review, kwetsbaarhedenscans en SBOM in de pipeline.
* Major-upgrades zijn een bewuste beslissing met eigen backlogitem.
* Nieuwe afhankelijkheid = expliciete afweging (onderhoud, licentie, alternatieven).
* GitHub Actions vastgezet op een **volledige commit-SHA**, niet op een tag: een tag kan
  worden verplaatst naar andere code, een SHA niet. De leesbare versie staat als
  commentaar achter de SHA (`uses: actions/checkout@3d3c42e… # v7.0.1`) en Dependabot
  werkt beide bij. Workflowrechten minimaal (`permissions: contents: read` als standaard).

### 2.15 Kwetsbaarheidsscans
Zie [`vulnerability-management.md`](vulnerability-management.md). Kort: secret scanning,
SAST, dependency- en containerscans bij elke pull request en wekelijks opnieuw.

### 2.16 Back-up en herstel
Zie [`../operations/backup-and-recovery.md`](../operations/backup-and-recovery.md).
Back-ups zijn versleuteld, gescheiden bewaard en worden **getest** — een ongeteste
back-up is geen back-up.

### 2.17 Incidentrespons
Zie [`incident-response.md`](incident-response.md).

### 2.18 Monitoring en alarmering
Zie [`../operations/monitoring.md`](../operations/monitoring.md). Minimaal alarmering op:
piek in mislukte inlogpogingen, ongebruikelijke exports, foutratio, mislukte transacties
en het wegvallen van auditlogging.

### 2.19 Scheiding van omgevingen
* `development` · `test` · `staging` · `production` zijn technisch gescheiden: aparte
  accounts/projecten, aparte netwerken, aparte sleutels, aparte credentials.
* **Geen productiedata buiten productie.** Testdata is synthetisch.
* Toegang tot productie is beperkt, tijdelijk, met MFA en volledig geaudit.
* **De Identity Provider is self-hosted** (Keycloak, besluit 8A) en draait op dezelfde
  VPS'en. Productie en test gebruiken **afzonderlijke Keycloak-instanties, databases,
  realms, clients, signing keys, secrets, beheerdersaccounts, configuraties, logging,
  monitoring en back-ups**; er worden **geen identitygegevens, credentials, sleutels of
  sessies** tussen omgevingen gedeeld, en **geen productie-identiteiten naar test
  gekopieerd** ([ADR-0004](../architecture/adr/0004-identity-and-access-management.md) §8A.1).
  **Nog te implementeren en nog te verifiëren.**
* **De besloten testgroep (besluit 7) draait in productie, niet in test.** Zij werkt met
  echte persoonsgegevens, volledige KYC en — ná verlening van de vereiste vergunning of een andere rechtsgeldige toestemming van de bevoegde toezichthouder —
  echte geldstromen. Dat verruimt de regel hierboven **niet**: er komen nooit echte
  gegevens in `development`, `test`, `staging`, demo-omgevingen of securityonderzoek.
  Sandboxgegevens blijven daar de norm. Zie
  [`../product/closed-test-group.md`](../product/closed-test-group.md).

## 3. Toetsing

| Moment | Controle |
|---|---|
| Refinement | risicoscan op elk item (zie [`security-champions.md`](security-champions.md)) |
| Pull request | securityvelden ingevuld; CODEOWNERS-review bij gevoelige paden |
| CI | secret scan, SAST, dependency- en containerscan, SBOM, licenties |
| Definition of Done | securitycontroles geslaagd, geen kritieke/hoge bevindingen |
| Release | securitycheck; openstaande kritieke/hoge bevinding blokkeert de release |
| **Start besloten testgroep** | alle kritieke en hoge bevindingen opgelost **of formeel geaccepteerd** volgens [`../../GOVERNANCE.md`](../../GOVERNANCE.md) §4, plus een geslaagde hersteltest van back-up en disaster recovery — Go/No-Go-voorwaarden 4 en 5 uit [`../product/closed-test-group.md`](../product/closed-test-group.md) §10 (C-34) |
| Periodiek | threat model per epic en per kwartaal; pentest vóór productie |
