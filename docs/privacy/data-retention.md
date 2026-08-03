# Bewaartermijnen

Elk gegeven heeft een bewaartermijn en een mechanisme dat het daadwerkelijk verwijdert.
"Voor altijd bewaren" is geen termijn, en een termijn zonder verwijderroutine is een
papieren belofte.

> ⚖️ **Alle termijnen hieronder zijn voorstellen.** Wettelijke bewaarplichten en
> -verboden verschillen per land en per type financiële dienst. Laat elke regel
> bevestigen door een bevoegde specialist en registreer dat in
> [`../compliance/regulatory-decisions.md`](../compliance/regulatory-decisions.md).

## 1. Uitgangspunten

1. Bewaar niet langer dan nodig voor het vastgelegde doel.
2. Een wettelijke bewaarplicht kan verwijdering **blokkeren**; dat moet vastliggen, niet
   worden aangenomen.
3. Verwijderen betekent verwijderen — ook uit back-ups (of: back-ups verlopen binnen een
   vastgelegde termijn).
4. Anonimiseren mag als alternatief, mits de gegevens echt niet meer herleidbaar zijn.
5. Elke termijn heeft een geautomatiseerde routine en een controle dat die routine draait.

## 2. Termijnen

| # | Gegevenscategorie | Klasse | Termijn (voorstel) | Start van de termijn | Actie na afloop | Wettelijke plicht? | Status |
|---|---|---|---|---|---|---|---|
| R1 | Accountgegevens | C2 | `[30]` dagen na accountverwijdering | verwijderverzoek | verwijderen | mogelijk | **te valideren** |
| R2 | Wachtwoordhash en MFA-geheimen | C4 | direct bij accountverwijdering | verwijderverzoek | verwijderen | nee | voorstel |
| R3 | Sessies en tokens | C4 | einde sessie, max. `[8]` uur | aanmaak | verwijderen | nee | voorstel |
| R4 | Financiële transacties en saldi | C3 | `[7 jaar]` óf `[30]` dagen na verwijdering | ontvangst | verwijderen of anonimiseren | **waarschijnlijk ja** | **te valideren** |
| R5 | Toestemmingsregistratie | C2 | `[termijn]` na intrekking | intrekking | archiveren, daarna verwijderen | waarschijnlijk ja | **te valideren** |
| R6 | Auditlog | C2/C3 | `[1–7 jaar]` | gebeurtenis | verwijderen | waarschijnlijk ja | **te valideren** |
| R7 | Applicatielogs | C1 | `[30]` dagen | schrijven | automatisch verwijderen | nee | voorstel |
| R8 | Beveiligingslogs (detectie) | C2 | `[180]` dagen | schrijven | verwijderen | mogelijk | **te valideren** |
| R9 | Back-ups | mixed | `[35]` dagen rollend | maken | overschrijven | nee | voorstel |
| R10 | Supportcorrespondentie | C2 | `[24]` maanden | laatste contact | verwijderen | mogelijk | **te valideren** |
| R11 | Onderzoeksopnames | C2 | `[30]` dagen | opname | verwijderen | nee | vast |
| R12 | Contactgegevens testgroep | C2 | einde deelname + `[3]` maanden | einde deelname | verwijderen | nee | vast |
| R13 | Geanonimiseerde onderzoeksbevindingen | C1 | onbeperkt | — | — | nee | vast |
| R14 | Analytics (geaggregeerd) | C1 | `[26]` maanden | meting | verwijderen | nee | voorstel |
| R15 | Toegangsrechten en reviews | C1 | `[3 jaar]` | vastlegging | archiveren | mogelijk | **te valideren** |

## 3. Verwijderroutines

| Routine | Frequentie | Verantwoordelijk | Controle |
|---|---|---|---|
| Verlopen sessies opruimen | continu | applicatie | metriek |
| Applicatielogs roteren | dagelijks | platform | alert bij uitblijven |
| Accountverwijdering afhandelen | dagelijks | applicatie | rapport per week |
| Onderzoeksopnames verwijderen | wekelijks | UX | agenda-afspraak |
| Back-uprotatie | dagelijks | platform | maandelijkse steekproef |
| Kwartaalcontrole op alle termijnen | per kwartaal | Privacy | bewijs in `audit-evidence.md` |

## 4. Verwijdering versus bewaarplicht

Botsen een verwijderverzoek en een bewaarplicht, dan geldt:

1. leg vast **welke** gegevens om **welke** reden bewaard blijven en tot wanneer;
2. beperk de toegang tot die gegevens tot het minimum ("bevroren" opslag);
3. verwijder alles wat niet onder de plicht valt;
4. informeer de gebruiker begrijpelijk over wat wel en niet is verwijderd;
5. laat de onderbouwing **valideren door een bevoegde specialist**.

## 5. Back-ups en het recht op verwijdering

Back-ups worden niet doorzocht om één record te verwijderen. In plaats daarvan:

* back-ups hebben een korte, vastgelegde rotatie (`[35]` dagen);
* bij herstel uit een back-up worden verwijderverzoeken opnieuw toegepast (een
  "verwijderlijst" die na herstel wordt afgespeeld);
* dit wordt vastgelegd en uitgelegd aan de betrokkene.

## 6. Aantoonbaarheid

| Bewijs | Waar |
|---|---|
| Dit document, met datum van laatste beoordeling | Git-historie |
| Draaiende verwijderroutines | monitoring, `../operations/monitoring.md` |
| Kwartaalcontrole | [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md) |
| Afgehandelde verwijderverzoeken | `[SYSTEEM]`, geaggregeerd gerapporteerd |

**Laatst beoordeeld:** `[JJJJ-MM-DD]` door `[NAAM]` · **Volgende beoordeling:** `[DATUM]`
