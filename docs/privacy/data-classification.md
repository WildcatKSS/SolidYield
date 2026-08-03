# Gegevensclassificatie

Classificatie bepaalt hoe een gegeven beschermd, gelogd, bewaard en gedeeld mag worden.
Elk nieuw gegevensveld krijgt een klasse — dat is onderdeel van de Definition of Ready.

## 1. Klassen

| Klasse | Omschrijving | Voorbeelden | Encryptie | Logging | In testomgeving |
|---|---|---|---|---|---|
| **C0 — Openbaar** | mag iedereen zien | marketingteksten, publieke API-documentatie | standaard TLS | toegestaan | toegestaan |
| **C1 — Intern** | alleen binnen de organisatie | architectuurschetsen, geaggregeerde statistiek | TLS + in rust | toegestaan zonder ID's | synthetisch |
| **C2 — Vertrouwelijk (persoonsgegevens)** | herleidbaar tot een persoon | naam, e-mailadres, IP-adres, apparaat-ID, gebruikers-ID | TLS + in rust | **niet loggen** | **uitsluitend synthetisch** |
| **C3 — Zeer vertrouwelijk (financieel/bijzonder)** | financiële gegevens en gevoelige identificatoren | rekeninggegevens, transacties, saldi, inkomensgegevens, identiteitsbewijsgegevens | TLS + in rust + veldniveau | **nooit loggen** | **uitsluitend synthetisch** |
| **C4 — Geheim** | compromittering raakt het hele systeem | wachtwoordhashes, tokens, API-sleutels, privésleutels | in een secrets manager / KMS | **nooit loggen** | eigen testsecrets |

## 2. Regels per klasse

| Regel | C0 | C1 | C2 | C3 | C4 |
|---|---|---|---|---|---|
| In applicatielogs | ✅ | ⚠️ zonder ID's | ❌ | ❌ | ❌ |
| In URL of querystring | ✅ | ❌ | ❌ | ❌ | ❌ |
| In foutmeldingen aan de gebruiker | ✅ | ❌ | ❌ | ❌ | ❌ |
| In analytics/monitoring | ✅ | geaggregeerd | ❌ | ❌ | ❌ |
| In screenshots / issues / PR's | ✅ | ⚠️ | ❌ | ❌ | ❌ |
| In een testomgeving | ✅ | ✅ | alleen synthetisch | alleen synthetisch | eigen testwaarden |
| Naar een externe partij | ✅ | met afspraak | met DPA en grondslag | met DPA, grondslag en beoordeling | nooit |
| Bewaartermijn vastgelegd | n.v.t. | ✅ | ✅ | ✅ | rotatiebeleid |
| Toegang beperkt tot | iedereen | team | rol + noodzaak | rol + noodzaak + audit | strikt beperkt |

## 3. Register van gegevenscategorieën

| Categorie | Klasse | Doel | Grondslag (voorlopig) | Bewaartermijn | Locatie | Eigenaar |
|---|---|---|---|---|---|---|
| Accountgegevens (e-mail, naam) | C2 | account beheren | uitvoering overeenkomst | account + `[termijn]` | primaire opslag | PO |
| Wachtwoordhash | C4 | authenticatie | uitvoering overeenkomst | zolang account bestaat | primaire opslag | Security |
| MFA-geheimen | C4 | authenticatie | uitvoering overeenkomst | zolang account bestaat | secrets/opslag | Security |
| Sessietokens | C4 | sessiebeheer | uitvoering overeenkomst | minuten–uren | cache | Security |
| Financiële transacties | C3 | het kerninzicht | toestemming | `[termijn]` — **te valideren** | primaire opslag | PO |
| Saldi en categorieën | C3 | het kerninzicht | toestemming | `[termijn]` | primaire opslag | PO |
| Toestemmingsregistratie | C2 | aantoonbaarheid | wettelijke verplichting | `[termijn]` — **te valideren** | primaire opslag | Privacy |
| Auditlog | C2/C3 | aantoonbaarheid, misbruikdetectie | verplichting / gerechtvaardigd belang | `[termijn]` — **te valideren** | auditopslag | Security |
| Applicatielogs | C1 | storingsanalyse | gerechtvaardigd belang | `[30]` dagen | logopslag | Ops |
| Supportcorrespondentie | C2 | hulp bieden | uitvoering overeenkomst | `[termijn]` | `[SYSTEEM]` | Support |
| Onderzoeksgegevens (testgroep) | C2 | productverbetering | toestemming | zie testgroepplan | buiten de repository | UX |
| Geanonimiseerde bevindingen | C1 | productverbetering | n.v.t. | onbeperkt | repository | UX |

## 4. Herkennen van C3 in een financiële dienst

Behandel als C3 zodra een gegeven iets zegt over iemands financiële situatie: bedragen,
saldi, tegenrekeningen, schulden, inkomen, betaalgedrag, categorieën van uitgaven. Ook een
combinatie kan C3 worden: "gebruiker X winkelde op locatie Y" is samen gevoeliger dan de
delen apart.

## 5. Praktische controles

| Controle | Hoe |
|---|---|
| Geen C2/C3 in logs | logfilter + codereviewcheck + steekproef per kwartaal |
| Geen C2/C3 in issues/PR's | verplichte bevestiging in de issue forms |
| Geen productiedata in test | technische scheiding + review + expliciet verbod |
| Nieuwe velden geclassificeerd | Definition of Ready |
| Register actueel | kwartaalreview door de privacyverantwoordelijke |
