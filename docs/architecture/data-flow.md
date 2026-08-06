# Gegevensstromen

Beschrijft welke gegevens waarheen stromen, met welk doel en met welke bescherming. Dit
document is de basis voor het [threat model](threat-model.md), de
[gegevensclassificatie](../privacy/data-classification.md) en de DPIA.

> **Context.** Het bedrijfs- en ketenmodel is vastgesteld (besluit 4,
> [`adr/0007-vergunningplicht-en-rol-in-de-keten.md`](adr/0007-vergunningplicht-en-rol-in-de-keten.md)):
> SolidYield is contractspartij en houdt de wallet; betalingen verlopen via
> **vergunninghoudende betaalpartners**. De eerste implementatierichting is Mollie
> (iDEAL/SEPA) en bunq (IBAN, uitbetalingen, reconciliatie); die partijen zijn **nog niet
> definitief geselecteerd en niet gecontracteerd** (RD-22). Een betaalpartner is **geen
> productuitgever**. De geld- en contractstroom staat met sequencediagrammen in
> [`adr/0008-geld-en-contractstroom.md`](adr/0008-geld-en-contractstroom.md).
>
> SolidYield gaat uit van een **vergunningplicht** (besluit 4A) en bouwt alsof een
> vergunning vereist is; de exacte vergunning en grondslag worden vastgesteld tijdens het
> vergunningstraject (RD-23 t/m RD-27). Tot die bevestiging lopen
> deze stromen met **sandboxbetalingen en synthetische data**; er stromen geen echte
> klantgelden.

## 1. Overzicht

```mermaid
sequenceDiagram
    autonumber
    actor U as Gebruiker
    participant W as Webapplicatie
    participant A as API
    participant I as [IDP]
    participant D as Opslag
    participant P as Betaalpartner<br/>(richting: Mollie/bunq)
    participant L as Auditlog

    U->>W: opent applicatie (HTTPS)
    W->>I: authenticatie (OIDC + MFA)
    I-->>W: identiteitstoken
    W->>A: verzoek met token
    A->>A: token valideren, autorisatie op objectniveau
    A->>L: gebeurtenis vastleggen (wie, wat, wanneer)
    A->>D: gegevens lezen/schrijven (versleuteld)
    A->>P: gegevens ophalen (alleen met geldige toestemming)
    P-->>A: gegevens (beperkte scope)
    A-->>W: antwoord (alleen gegevens van deze gebruiker)
    W-->>U: weergave
```

## 2. Stromen per doel

| # | Stroom | Gegevens | Doel | Grondslag (voorlopig) | Bescherming |
|---|---|---|---|---|---|
| DF-1 | Gebruiker → applicatie | inloggegevens, MFA-code | authenticatie | uitvoering overeenkomst | TLS, geen logging van geheimen, rate limiting |
> **Vrij walletsaldogeld:** de juridische positie is **niet vastgesteld** — rechthebbende,
> tenaamstelling van de bankrekening, vermogensscheiding en faillissementspositie zijn open
> (**RD-32**). Het rekening- en ledgerontwerp mag daar niet op vooruitlopen (C-39). Het
> **vastgezette** bedrag valt hier niet onder: dat wordt een contractuele vordering en is
> volgens besluit 4A gedurende de looptijd eigendom van SolidYield.

| DF-2 | Applicatie → `[IDP]` | identiteitsclaims | authenticatie | uitvoering overeenkomst | OIDC, PKCE, korte tokenlevensduur |
| DF-3 | Gebruiker → applicatie | profielgegevens | account beheren | uitvoering overeenkomst | validatie, minimalisatie |
| DF-4 | Applicatie ↔ `[PROVIDER]` | financiële gegevens | het kerninzicht leveren | **toestemming** (intrekbaar) | scopebeperking, tokens in secrets manager, mTLS/OAuth |
| DF-5 | Applicatie → opslag | financiële en profielgegevens | dienstverlening | uitvoering overeenkomst | encryptie in rust, least privilege |
| DF-6 | Applicatie → auditlog | wie deed wat, wanneer | aantoonbaarheid, misbruikdetectie | gerechtvaardigd belang / verplichting — **te valideren** | append-only, aparte rechten |
| DF-7 | Applicatie → monitoring | technische telemetrie | beschikbaarheid | gerechtvaardigd belang | **geen persoonsgegevens**, geen bedragen |
| DF-8 | Applicatie → berichtendienst | e-mailadres, neutrale inhoud | transactionele berichten | uitvoering overeenkomst | geen financiële details in de berichtinhoud |
| DF-9 | Support → applicatie | inzage in gegevens | hulp bij een vraag | gerechtvaardigd belang | minimale rechten, aanleiding vastleggen, volledig geaudit |
| DF-10 | Gebruiker → export/verwijdering | eigen gegevens | rechten van betrokkenen | wettelijke verplichting | identiteitscontrole, veilige aflevering |

> Alle grondslagen zijn **voorlopig** en moeten worden bevestigd door de privacy-
> verantwoordelijke; regulatoire conclusies zijn **te valideren door een bevoegde
> specialist**.

## 3. Wat wij bewust **niet** doen

* Geen financiële gegevens naar analytics of marketing.
* Geen persoonsgegevens in applicatielogs, URL's, foutmeldingen of monitoring.
* Geen productiedata in test-, demo- of testgroepomgevingen.
* Geen **structurele** doorgifte naar derde landen (ADR-0006). Eventuele uitzonderingen
  vereisen afzonderlijke beoordeling, passende juridische waarborgen en registratie als
  internationale doorgifte.
* Toegang vanuit een derde land is **standaard uitgesloten** en alleen mogelijk bij een
  vooraf door Privacy en Compliance goedgekeurde uitzondering. Zo'n uitzondering geldt zelf
  als internationale doorgifte.
* Geen profilering met rechtsgevolg zonder aparte beoordeling.

## 4. Gegevens in rust

| Opslag | Inhoud | Encryptie | Toegang | Back-up |
|---|---|---|---|---|
| Primaire database | account- en financiële gegevens | in rust (`[KMS]`), gevoelige velden aanvullend | alleen de applicatie, least privilege | dagelijks, versleuteld, hersteltest per kwartaal |
| Auditlog | gebeurtenissen | in rust | schrijven door app, lezen door security | conform bewaartermijn |
| Back-ups | volledige dataset | in rust, aparte sleutel | strikt beperkt, MFA | offsite op één geografisch gescheiden secundaire locatie binnen de EER (ADR-0006) |
| Cache | tijdelijke gegevens | in rust waar mogelijk | alleen applicatie | geen |
| Onderzoeksdata | interviewaantekeningen | buiten deze systemen | UX + privacy | volgens onderzoeksbeleid |

## 5. Gegevens in transport

| Traject | Protocol | Extra |
|---|---|---|
| Gebruiker → rand | HTTPS (TLS 1.2+, bij voorkeur 1.3) | HSTS, veilige cookievlaggen |
| Rand → applicatie | TLS binnen het netwerk | netwerkisolatie |
| Applicatie → database | TLS | alleen vanaf toegestane bronnen |
| Applicatie → externe partij | TLS, mTLS waar mogelijk | uitgaande allowlist |
| Beheer → omgeving | versleuteld, MFA, just-in-time | volledig geaudit |

## 6. Bewaartermijnen

Zie [`../privacy/data-retention.md`](../privacy/data-retention.md). Elke stroom die
gegevens opslaat, heeft daar een regel — zonder uitzondering.

## 7. Onderhoud van dit document

Bijwerken bij: elke nieuwe externe koppeling, elke nieuwe gegevenscategorie, elke
wijziging in doel of grondslag, en minimaal elk kwartaal. Wijzigingen lopen via een pull
request met review door privacy en security.
