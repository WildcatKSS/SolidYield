# Monitoring en alarmering

Wij meten om te weten of gebruikers geholpen worden en of er misbruik plaatsvindt — niet
om gedrag te profileren. **Geen persoonsgegevens in monitoring.**

> **Gerelateerd:** [`sre-principles.md`](sre-principles.md) (waarom we meten wat we meten) ·
> [`service-level-objectives.md`](service-level-objectives.md) · [`runbook.md`](runbook.md)

## 1. Vier lagen

| Laag | Vraag | Voorbeelden |
|---|---|---|
| Infrastructuur | draait het? | CPU, geheugen, schijf, netwerk |
| Applicatie | werkt het? | foutratio, latency, doorvoer, wachtrijlengte |
| Functioneel | helpt het? | geslaagde registraties, geslaagde koppelingen, tijd tot eerste inzicht |
| Security | is het veilig? | mislukte inlogpogingen, ongebruikelijke exports, rechtenwijzigingen |

## 2. Gouden signalen

| Signaal | Meting | Alarmdrempel (voorstel) |
|---|---|---|
| Latency | p95 en p99 per endpoint | p95 > `[500]` ms gedurende 5 min |
| Verkeer | verzoeken per minuut | afwijking > `[50]%` t.o.v. normaal |
| Fouten | 5xx-ratio | > `[1]%` gedurende 5 min |
| Verzadiging | CPU/geheugen/verbindingen | > `[80]%` gedurende 10 min |

## 3. Functionele en securitymeetwaarden

| Meetwaarde | Waarom | Alarm |
|---|---|---|
| Mislukte inlogpogingen per minuut | accountovername, brute force | > `[X]`/min of piek t.o.v. baseline |
| Mislukte MFA-verificaties | aanval of stukke flow | piek |
| Geslaagde registraties | trechterbewaking | daling > `[50]%` |
| Mislukte koppelingen met `[PROVIDER]` | leveranciersstoring | > `[5]%` |
| Mislukte transacties/berekeningen | financiële juistheid | elke stijging |
| Exports en verwijderverzoeken | misbruik of piek in rechten | ongebruikelijk volume |
| Rechtenwijzigingen | privilege-escalatie | elke wijziging buiten proces |
| Auditlogvolume | **wegvallen van logging is zelf een incident** | volume = 0 |
| Achterstand in wachtrijen | verouderde gegevens voor gebruikers | > `[X]` minuten |
| Verwijderroutines | bewaartermijnen worden echt uitgevoerd | routine niet gedraaid |

## 4. Logging

* Gestructureerd (JSON), met correlatie-ID over componenten heen.
* Niveaus: `error` (actie nodig), `warn` (aandacht), `info` (gebeurtenissen), `debug`
  (alleen niet-productie).
* **Verboden in logs:** wachtwoorden, tokens, sessie-ID's, volledige rekeninggegevens,
  bedragen gekoppeld aan een persoon, e-mailadressen, BSN-achtige identificatoren.
* Toegang tot logs is beperkt en zelf geaudit.
* Bewaartermijnen: zie [`../privacy/data-retention.md`](../privacy/data-retention.md).

## 5. Auditlog versus applicatielog

| | Applicatielog | Auditlog |
|---|---|---|
| Doel | storingsanalyse | aantoonbaarheid en misbruikdetectie |
| Inhoud | technische gebeurtenissen | wie deed wat, wanneer, met welk resultaat |
| Bewaartermijn | `[30]` dagen | `[1–7 jaar]` — **te valideren** |
| Wijzigbaar | roteert | append-only |
| Toegang | ontwikkelaars/ops | security, compliance, auditor |

## 6. Alarmering

| Ernst | Voorbeeld | Route | Reactietijd |
|---|---|---|---|
| **P1** | dienst onbereikbaar; datalekverdenking; auditlog stil | direct oproepen `[KANAAL]` | direct, 24/7 |
| **P2** | foutratio boven drempel; koppeling uitgevallen | `[KANAAL]` | ≤ 1 uur |
| **P3** | verhoogde latency; achterstand in wachtrij | dagelijkse controle | ≤ 1 werkdag |
| **P4** | trends, capaciteit | sprintoverzicht | sprint |

Regels: elk alarm is **actiegericht** (er is iets te doen) en verwijst naar het runbook.
Een alarm dat niemand oppakt, wordt verwijderd of aangepast — alarm-moeheid is een
veiligheidsrisico.

## 7. Dashboards

| Dashboard | Voor wie | Inhoud |
|---|---|---|
| Operationeel | team | gouden signalen, deploys, alerts |
| Functioneel | PO + UX | trechter, tijd tot eerste inzicht, terugkeergedrag |
| Security | Security | inlogpogingen, rechtenwijzigingen, exports, scanstatus |
| Kwaliteit | team | testresultaten, dekking, ontsnapte defecten |

## 7a. Checks die in productie draaien

Monitoring is niet passief: sommige controles voeren actief iets uit tegen productie. Dat
mag, binnen de grens uit [`../testing/test-strategy.md`](../testing/test-strategy.md) §4a:

> In productie draaien alleen vooraf ontworpen, begrensde en veilige checks die geen echte
> klantdata wijzigen, geen ongecontroleerde transacties veroorzaken en geen gebruikers
> benadelen.

| Check | Wat het doet | Voorwaarde |
|---|---|---|
| Healthcheck / readiness probe | read-only status van de dienst en zijn afhankelijkheden | geen schrijfacties |
| Synthetische monitoring | doorloopt periodiek de kernreis met een synthetische identiteit | herkenbaar testaccount, geen echte transacties, eigen markering in logs en metrics |
| Canaryverificatie | vergelijkt het gedrag van de nieuwe versie op een klein deel van het verkeer | automatische terugval bij afwijking |
| Post-deploymentcheck | bevestigt dat de uitrol werkt | vooraf gedefinieerd, begrensd in tijd en omvang |
| Configuratie- en autorisatiecontrole | controleert instellingen zonder klantimpact | read-only |

Voor elke check geldt: **herkenbaar, traceerbaar en uitschakelbaar**, onder wijzigingsbeheer
en incidentrespons, met opruimen en kostenbeheersing geregeld. Synthetische identiteiten
representeren geen echte personen en tellen niet mee in functionele of financiële
rapportages.

## 8. Nog te bepalen

| Onderwerp | Eigenaar |
|---|---|
| Monitoringplatform `[TOOL]` | Ops |
| Oproepregeling buiten kantoortijd | Ops + management |
| Concrete drempelwaarden (nu voorstellen) | team, na eerste metingen |
| Bewaartermijn van technische logs bevestigen | Privacy |
