# Securitytesten

Wat testen we, op welk niveau, en hoe voorkomen we dat een maatregel stilletjes verdwijnt?

## 1. Testpiramide voor security

| Niveau | Wat | Waar | Wanneer |
|---|---|---|---|
| **Unit** | validatiefuncties, rekenregels, limieten, hashing | `tests/unit/` | elke PR |
| **Integratie** | autorisatie per endpoint, sessiegedrag, rate limiting | `tests/integration/` | elke PR |
| **Security** | misbruikscenario's uit het threat model | `tests/security/` | elke PR |
| **End-to-end** | volledige reis inclusief MFA en uitloggen | `tests/end-to-end/` | elke PR |
| **Statisch** | SAST, secret scanning, IaC-scan | pipeline | elke PR |
| **Afhankelijkheden** | bekende kwetsbaarheden, licenties, SBOM | pipeline | elke PR + wekelijks |
| **Dynamisch** | DAST-scan tegen staging | pipeline of periodiek | `[wekelijks]` |
| **Handmatig** | pentest, threat-modelverificatie | extern/security | vóór productie, jaarlijks |

## 2. Verplichte securitytests

Elk van deze tests hoort te bestaan zodra de bijbehorende functionaliteit er is:

| # | Test | Dreiging |
|---|---|---|
| S-1 | Gebruiker A kan een object van gebruiker B **niet** opvragen, wijzigen of verwijderen | T-05 |
| S-2 | Verzoek zonder geldig token wordt geweigerd op **elke** beschermde endpoint | T-08 |
| S-3 | Rol uit clientgegevens wordt genegeerd; rechten komen van de server | T-08 |
| S-4 | Na `[N]` mislukte inlogpogingen treedt snelheidsbeperking op | T-01, T-07 |
| S-5 | Sessie verloopt na `[15]` minuten inactiviteit; uitloggen maakt het token ongeldig | T-15 |
| S-6 | Gevoelige handeling vraagt om herauthenticatie | T-01 |
| S-7 | Bedragen en limieten worden serverseitig herberekend en afgedwongen | T-03, T-13 |
| S-8 | Foutmeldingen bevatten geen stacktrace, querygegevens of persoonsgegevens | T-06 |
| S-9 | Logregels bevatten geen wachtwoorden, tokens, bedragen of persoonsgegevens | T-06 |
| S-10 | Auditlog wordt geschreven bij inloggen, rechtenwijziging, inzage en export | T-04 |
| S-11 | Invoer met onverwachte tekens/lengte wordt geweigerd, niet verwerkt | T-03 |
| S-12 | Beveiligingsheaders aanwezig (HSTS, CSP, X-Content-Type-Options, Referrer-Policy) | T-06 |
| S-13 | Toestemming intrekken maakt toegang tot externe gegevens direct ongeldig | privacy |
| S-14 | Verwijderverzoek verwijdert of anonimiseert de gegevens binnen de afgesproken termijn | privacy |

Zie ook [`../../tests/security/README.md`](../../tests/security/README.md).

## 3. Testdata

* **Uitsluitend synthetisch.** Nooit productiedata, ook niet "geanonimiseerd" —
  anonimisering van financiële gegevens is lastiger dan het lijkt.
* Genereer testdata reproduceerbaar (vaste seed), zodat tests stabiel zijn.
* Gebruik duidelijk herkenbare fictieve waarden (`test.user+p1@example.invalid`,
  bedragen als 12,34). Voor bank- en betaalgegevens: uitsluitend testwaarden die de
  gekozen provider-sandbox publiceert, of bewust **ongeldige** waarden. Een structureel
  geldig rekening- of kaartnummer is nooit automatisch een veilig voorbeeld — zie
  [`../testing/test-strategy.md`](../testing/test-strategy.md) §4.
* Geen echte namen, adressen, telefoonnummers of kaartnummers — ook niet als voorbeeld in
  documentatie.

## 4. Dynamische scan (DAST)

| Onderwerp | Invulling |
|---|---|
| Doel | staging, met synthetische data |
| Tool | `[BIJV. OWASP ZAP]` |
| Frequentie | `[wekelijks]` en vóór elke release |
| Afspraak | scan **nooit** tegen productie zonder expliciete toestemming en afstemming |
| Opvolging | bevindingen via `security-issue.yml`, SLA volgens `vulnerability-management.md` |

## 4a. Statische analyse (SAST) is blokkerend

De Semgrep-stap in `security-scan.yml` mag falen en doet dat ook: faalt de scan, dan
faalt de job `sast`, en daarmee de `security-gate` die de merge tegenhoudt. Dat is het
verschil tussen een control en een rapportage.

| Situatie | Wat je doet |
|---|---|
| Terechte bevinding | oplossen, met een test die het gedrag vastlegt |
| Onterechte bevinding (false positive) | expliciet onderdrukken: regel in `.semgrepignore` of een `nosemgrep`-annotatie op de betreffende regel, **met** onderbouwing, beoordelaar en houdbaarheidsdatum in [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md) §4 |
| Scan valt uit door een storing bij de leverancier | opnieuw draaien; blijft het falen, dan is dat een belemmering voor de Scrum Master — niet iets om weg te vinken |

Alleen het uploaden van de SARIF-resultaten is "best effort": dat vereist Code scanning
in de repository, en het ontbreken daarvan mag de scan zelf niet ongedaan maken. De
bevindingen staan dan in de joblog.

## 5. Regressie op security

Elke opgeloste kwetsbaarheid krijgt een test die aantoont dat het probleem terug zou
worden gesignaleerd. Zonder die test is de fix niet af:

1. reproduceer het probleem in een test (die faalt);
2. los het op (test slaagt);
3. laat de test staan als regressiebewaking.

## 6. Wat geautomatiseerde tests **niet** vangen

* Ontwerpfouten (verkeerd autorisatiemodel) → threat modelling.
* Bedrijfslogicamisbruik (limieten omzeilen via een omweg) → pentest en abuse stories.
* Sociale aanvallen (phishing, supportmanipulatie) → procedures en training.
* Cumulatieve privacyrisico's → DPIA.

Daarom blijven threat modelling, pentest en menselijke review verplicht.
