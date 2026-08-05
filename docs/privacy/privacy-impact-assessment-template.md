# Privacy Impact Assessment (DPIA) — sjabloon

Een DPIA brengt privacyrisico's in kaart **voordat** een verwerking start. Dit sjabloon
helpt het team gestructureerd na te denken; het vervangt geen beoordeling door de
privacyverantwoordelijke of, waar nodig, een bevoegde specialist.

> **Wanneer:** de screening (§0) gebeurt **vóór de implementatie** van functionaliteit die
> persoonsgegevens verwerkt — niet nadat de verwerking is gestart. Een DPIA die pas na
> ingebruikname wordt gedaan, kan het ontwerp niet meer bijsturen.
> **Wie:** opsteller uit de Developers of de operationele privacyfunctie; de **DPO
> adviseert onafhankelijk** over de uitkomst; de **mandaathouder besluit**.

## 0. Wanneer is een DPIA nodig?

Doe minimaal de **voortoets** hieronder bij elke nieuwe verwerking, vóór de implementatie. Een volledige DPIA is
in elk geval aan de orde bij grootschalige verwerking van financiële gegevens, bij
systematische monitoring, bij geautomatiseerde besluitvorming met gevolgen voor mensen, en
bij het combineren van datasets.

### Voortoets

| Vraag | Ja/Nee |
|---|---|
| Verwerken we financiële gegevens op grote schaal? | |
| Combineren we gegevens uit verschillende bronnen? | |
| Nemen we geautomatiseerde besluiten met gevolgen voor de gebruiker? | |
| Volgen of profileren we systematisch gedrag? | |
| Verwerken we gegevens van kwetsbare personen? | |
| Gebruiken we een nieuwe technologie of nieuwe leverancier? | |
| Kan de verwerking mensen belemmeren in het uitoefenen van een recht? | |

Twee of meer keer "ja" → volledige DPIA. Eén keer "ja" → beoordeling door de
privacyverantwoordelijke.

---

## 1. Kop

| Veld | Invulling |
|---|---|
| DPIA-ID | `DPIA-[NR]` |
| Onderwerp | `[VERWERKING]` |
| Aanleiding | `[EPIC/FEATURE #]` |
| Opsteller | `[NAAM]` |
| Datum | `[JJJJ-MM-DD]` |
| Status | concept / in beoordeling / vastgesteld / herzien |
| Beoordeeld door | `[PRIVACYVERANTWOORDELIJKE]` |
| Extern gevalideerd | ⬜ ja, door `[SPECIALIST]` ⬜ nee — **vereist vóór productie** |

## 2. Beschrijving van de verwerking

* **Wat doen we?** …
* **Waarom?** (doel) …
* **Voor wie?** (betrokkenen) …
* **Welke gegevens?** (per categorie, met klasse uit `data-classification.md`) …
* **Hoeveel personen?** …
* **Hoe lang bewaren we het?** …
* **Wie heeft toegang?** …
* **Waar staan de gegevens?** (land, leverancier) …
* **Gegevensstroom:** verwijzing naar [`../architecture/data-flow.md`](../architecture/data-flow.md)

## 3. Rechtmatigheid en noodzaak

| Vraag | Antwoord |
|---|---|
| Grondslag (voorlopig) | `[toestemming / overeenkomst / verplichting / gerechtvaardigd belang]` |
| Is de verwerking noodzakelijk voor het doel? | |
| Kan het met minder gegevens? | |
| Kan het met geanonimiseerde of geaggregeerde gegevens? | |
| Is de verwerking proportioneel t.o.v. de inbreuk? | |
| Verwacht de gebruiker dit? | |
| Hoe informeren we de gebruiker? | |

## 4. Risico's voor betrokkenen

Denk vanuit de **gebruiker**, niet vanuit de organisatie.

| # | Risico | Gevolg voor de persoon | Kans | Impact | Maatregel | Restrisico |
|---|---|---|---|---|---|---|
| P1 | Onbevoegde toegang tot financiële gegevens | financiële schade, fraude, verlies van privacy | | | encryptie, MFA, autorisatie op objectniveau, auditlog | |
| P2 | Gegevens langer bewaard dan nodig | blijvende blootstelling | | | bewaartermijnen + verwijderroutines | |
| P3 | Onjuiste gegevens leiden tot verkeerde conclusies | verkeerde financiële beslissing | | | correctierecht, bronvermelding, validatie | |
| P4 | Gegevens gebruikt voor een ander doel | verlies van controle | | | doelbinding, technische scheiding | |
| P5 | Doorgifte naar een derde land | minder bescherming | | | **beoordeling vereist** | |
| P6 | Profilering leidt tot uitsluiting | ongelijke behandeling | | | geen besluitvorming met rechtsgevolg in de MVP | |

## 5. Maatregelen

| Maatregel | Type | Status | Eigenaar | Issue |
|---|---|---|---|---|
| | technisch / organisatorisch | | | # |

## 6. Rechten van betrokkenen

| Recht | Hoe geregeld | Getest |
|---|---|---|
| Inzage | | ⬜ |
| Correctie | | ⬜ |
| Verwijdering | | ⬜ |
| Beperking | | ⬜ |
| Dataportabiliteit | | ⬜ |
| Bezwaar | | ⬜ |

## 7. Leveranciers

| Leverancier | Rol | Locatie | Verwerkersovereenkomst | Doorgifte buiten de EER (uitgesloten, ADR-0006) | Beoordeeld |
|---|---|---|---|---|---|
| | verwerker / verwerkingsverantwoordelijke | | ⬜ | ⬜ | ⬜ |

## 8. Conclusie

* **Restrisico aanvaardbaar?** ⬜ ja ⬜ nee ⬜ alleen met aanvullende maatregelen
* **Onderbouwing:** …
* **Voorwaarden vóór ingebruikname:** …
* **Advies DPO:** `[ADVIES]`, uitgebracht op `[DATUM]`
* **Besluit mandaathouder:** `[NAAM/ROL]` op `[DATUM]` — bij afwijking van het DPO-advies:
  gemotiveerd vastgelegd in `[LOCATIE]`
* **Herziening:** `[DATUM of GEBEURTENIS]`

> Blijft het restrisico hoog na alle maatregelen, dan is voorafgaande raadpleging van de
> toezichthouder mogelijk verplicht. **Te beoordelen door een bevoegde specialist.**

## 9. Bewijs

Vastgelegd in [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md), met
verwijzing naar dit DPIA-ID en de bijbehorende issues.
