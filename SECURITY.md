# Securitybeleid

> **Meld een kwetsbaarheid nooit via een publiek GitHub Issue, publieke discussie, pull
> request of social media.** Publieke meldingen stellen gebruikers en hun financiële
> gegevens onnodig bloot.

## 1. Een kwetsbaarheid melden (responsible disclosure)

Gebruik bij voorkeur **GitHub Private Vulnerability Reporting**:
`Security` → `Report a vulnerability` (moet ingeschakeld zijn onder
*Settings → Code security and analysis → Private vulnerability reporting*).

Alternatief: mail `[SECURITY-CONTACT-EMAIL]`, versleuteld met PGP-sleutel
`[PGP-FINGERPRINT]` (publiceer de sleutel op `[SECURITY-PGP-URL]`).

Vermeld in de melding:

* een beschrijving van de kwetsbaarheid en de mogelijke impact;
* reproductiestappen of proof of concept;
* getroffen versie, omgeving en component;
* of de kwetsbaarheid al bij derden bekend is;
* hoe je genoemd wilt worden bij publicatie (of anoniem wilt blijven).

**Voeg geen echte persoonsgegevens, betaalgegevens of inloggegevens toe** aan je melding.
Maskeer waar nodig.

## 1a. Vermoedt u een incident of datalek? Meld het onmiddellijk

Een *kwetsbaarheid* melden (§1) en een *incident* melden zijn twee verschillende dingen.
Gaat het om een vermoeden dat er nú iets misgaat — onbevoegde toegang, gegevens bij de
verkeerde persoon, een gelekt secret, verdacht gedrag in productie — dan geldt:

> **Meld een vermoeden van een beveiligingsincident of datalek onmiddellijk via het
> incidentproces. Wacht niet op bevestiging, volledigheid of eigen onderzoek.**

* Melden mag op basis van een vermoeden. Een onterechte melding is geen fout; te laat
  melden wél.
* Ga niet eerst zelf onderzoeken, testen of "even kijken of het echt zo is". Dat kost tijd
  en kan bewijs vernietigen.
* Beoordeel **niet zelf** of het meldingsplichtig is bij een toezichthouder. Externe
  meldtermijnen zijn kort en worden **bepaald door bevoegde specialisten**.
* Route: `[SECURITY-CONTACT-EMAIL]` en `[INCIDENTKANAAL]`, bij persoonsgegevens ook
  `[PRIVACY-CONTACT-EMAIL]`. **Nooit** via een publiek GitHub Issue.

Volledige procedure: [`docs/security/incident-response.md`](docs/security/incident-response.md).

## 2. Responstijden (streefwaarden, te bevestigen door `[SECURITY-OWNER]`)

| Stap | Streeftijd |
|---|---|
| Ontvangstbevestiging | 2 werkdagen |
| Eerste inhoudelijke beoordeling en triage | 5 werkdagen |
| Statusupdate | elke 10 werkdagen |
| Fix kritiek (CVSS ≥ 9.0) | 7 kalenderdagen |
| Fix hoog (CVSS 7.0–8.9) | 30 kalenderdagen |
| Fix middel (CVSS 4.0–6.9) | 90 kalenderdagen |
| Fix laag (CVSS < 4.0) | volgens backlogprioriteit |
| Gecoördineerde publicatie | in overleg, standaard 90 dagen na melding |

## 3. Scope

**In scope:** de code in deze repository, de bijbehorende build- en releasepipeline, en de
door `[ORGANISATIE]` beheerde omgevingen op `[STAGING-URL]` en `[PRODUCTIE-URL]`.

**Buiten scope:** systemen van derden, social engineering, fysieke toegang,
(D)DoS-aanvallen, volume- of geautomatiseerd scanverkeer, en bevindingen die uitsluitend
uit ontbrekende best-practice-headers bestaan zonder aantoonbare impact.

**Niet toegestaan:** toegang tot gegevens van andere gebruikers, wijzigen of verwijderen
van data, verstoren van de dienstverlening, en het gebruik van echte klantaccounts.
Gebruik uitsluitend je eigen testaccount in de daarvoor bedoelde testomgeving.

## 4. Veilige-havenverklaring

`[ORGANISATIE]` onderneemt geen juridische stappen tegen onderzoekers die zich aan dit
beleid houden, te goeder trouw handelen, geen schade veroorzaken en geen gegevens
exfiltreren of publiceren. **Deze verklaring moet vóór publicatie worden gevalideerd door
een bevoegd jurist.**

## 5. Ondersteunde versies

| Versie | Ondersteund |
|---|---|
| `[LAATSTE MINOR]` (huidig) | ✅ |
| vorige minor | ✅ beveiligingsfixes tot `[DATUM]` |
| ouder | ❌ |

## 6. Hoe wij security intern borgen

* **Ontwerp:** threat modelling per epic — [`docs/architecture/threat-model.md`](docs/architecture/threat-model.md)
* **Bouw:** secure development lifecycle — [`docs/security/secure-development-lifecycle.md`](docs/security/secure-development-lifecycle.md)
* **Toegang:** least privilege en MFA — [`docs/security/access-control.md`](docs/security/access-control.md)
* **Pipeline:** secret scanning, SAST, dependency- en containerscans, SBOM en licentiecontrole — [`.github/workflows/security-scan.yml`](.github/workflows/security-scan.yml)
* **Kwetsbaarheden:** triage en SLA's — [`docs/security/vulnerability-management.md`](docs/security/vulnerability-management.md)
* **Incidenten:** [`docs/security/incident-response.md`](docs/security/incident-response.md)
* **Testen:** [`docs/security/security-testing.md`](docs/security/security-testing.md)

## 7. Data in security-onderzoek

In development, test, demo, testgroepsessies en securityonderzoek wordt **uitsluitend
synthetische data** gebruikt. Echte persoonsgegevens, betaalgegevens,
authenticatiemiddelen en financiële productiedata zijn verboden — zonder uitzondering.
Zie [`docs/privacy/data-classification.md`](docs/privacy/data-classification.md).
