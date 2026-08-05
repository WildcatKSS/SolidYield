# Back-up en herstel

Een back-up die nooit is teruggezet, is geen back-up maar een aanname.

## 1. Doelstellingen

| Begrip | Waarde (voorstel) | Betekenis |
|---|---|---|
| **RPO** (maximaal gegevensverlies) | `[15]` minuten | hoeveel gegevens we in het ergste geval kwijtraken |
| **RTO** (maximale hersteltijd) | `[4]` uur | hoe snel de dienst weer draait |
| Bewaartermijn back-ups | `[35]` dagen rollend | zie `../privacy/data-retention.md` |
| Hersteltest | elk kwartaal | aantoonbaar in `../compliance/audit-evidence.md` |

RPO en RTO zijn **bedrijfsbeslissingen**: laat ze bevestigen door de opdrachtgever. Een
kortere RPO/RTO kost meer.

## 2. Wat back-uppen we?

| Onderdeel | Methode | Frequentie | Encryptie | Locatie |
|---|---|---|---|---|
| Primaire database | volledige back-up + continue transactielogs | dagelijks + continu | in rust, aparte sleutel | tweede zone in Nederland |
| Auditlog | append-only met eigen back-up | dagelijks | in rust | gescheiden van de applicatieback-up |
| Objectopslag (TransIP Object Store) | versioning + replicatie | continu | in rust, eigen sleutel per omgeving | Nederland; replicatie binnen de EER |
| Configuratie en infrastructuur | infrastructure as code in Git | per wijziging | n.v.t. | repository |
| Secrets | secrets manager met eigen back-up | volgens tool | ja | `[LOCATIE]` |

**Niet** in back-ups: gegevens uit test- en onderzoeksomgevingen (die zijn synthetisch en
reproduceerbaar).

## 3. Beveiliging van back-ups

* Aparte sleutels en aparte rechten; wie de productie beheert, beheert niet automatisch de
  back-ups.
* MFA op toegang tot back-ups.
* Onveranderlijkheid (immutability / object lock) waar mogelijk — beschermt tegen
  ransomware en tegen fouten.
* Toegang tot back-ups wordt geaudit.
* Back-ups liggen binnen de **EER**: primair Nederland, met disaster recovery op één
  **geografisch gescheiden secundaire locatie binnen de EER** (ADR-0006). Die locatie hoeft
  niet in een ander land te liggen, mits de scheiding aantoonbaar voldoende bescherming
  biedt tegen uitval van de primaire locatie — onderbouwd vastgelegd en periodiek getest.
  Opslag buiten de EER vindt niet plaats.
* Back-ups van **productie en test zijn volledig gescheiden** en worden nooit gedeeld
  (ADR-0003). Objectopslag loopt via **unieke buckets per omgeving** — generieke namen zijn
  niet toegestaan:

  | Omgeving | Back-upbucket | Overige buckets |
  |---|---|---|
  | Productie | `solidyield-production-backups` | `solidyield-production-documents` · `solidyield-production-exports` |
  | Test | `solidyield-test-backups` | `solidyield-test-documents` · `solidyield-test-exports` |

  Productie en test gebruiken **afzonderlijke** Object Store-credentials, access keys,
  endpoints/accounts of IAM-principals, encryptiesleutels en
  lifecycle-/retentieconfiguraties. Versioning, encryptie en lifecycle policies staan per
  bucket aan.

  > **Harde eis:** een verkeerde *productie*credential mag technisch **geen** toegang geven
  > tot test, en omgekeerd. Voor back-ups weegt dit dubbel: een herstelactie die per
  > ongeluk de testbucket raakt, of een testrestore die de productieback-ups overschrijft,
  > mag op autorisatieniveau niet mogelijk zijn — niet alleen op basis van een correct
  > ingevulde bucketnaam. Toetsbaar gemaakt in control **C-24** en dreiging **T-27**.
* Herstelwerkzaamheden worden binnen de EER uitgevoerd. Toegang tot back-ups vanuit een
  derde land is standaard uitgesloten en alleen mogelijk bij een vooraf goedgekeurde
  uitzondering, die als internationale doorgifte wordt geregistreerd.

### Wat de secundaire locatie wél en niet afdekt

Productie, test, objectopslag én back-ups staan alle bij **TransIP**, de gekozen
startprovider (ADR-0003). Drie risico's die vaak op één hoop worden gegooid, worden **niet**
door dezelfde maatregel afgedekt:

| Risicosoort | Wat het is | Wordt afgedekt door |
|---|---|---|
| **Locatiegebonden uitval** | uitval van één fysiek datacenter: stroom, koeling, brand, netwerk | geografisch gescheiden secundaire locatie (ADR-0006) |
| **Concentratierisico** | alle omgevingen én de back-ups staan bij dezelfde provider | **niet afgedekt** — bewust geaccepteerd voor de MVP |
| **Account-, control-plane-, contract- en providerbrede uitval** | compromittering of blokkade van het provideraccount, uitval van het beheerportaal of de API, contractbeëindiging, faillissement van de provider | **niet afgedekt** — bewust geaccepteerd voor de MVP |

> Een geografisch gescheiden secundaire locatie bij dezelfde provider beperkt
> locatiegebonden uitval, maar neemt providerbrede, accountgebonden en
> control-plane-risico's niet weg. SolidYield accepteert dit concentratierisico voor de
> MVP. Het risico wordt periodiek herbeoordeeld en vormt een herzieningstrigger voor
> ADR-0003.

Praktisch gevolg voor back-ups: een herstelscenario dat **uitgaat van een werkend
TransIP-account** dekt de laatste rij niet. Vóór echte klantgelden wordt beoordeeld of een
back-upkopie **buiten het TransIP-account** — of bij een andere partij — nodig is. Dit
besluit verbiedt zo'n aanvullende locatie niet; TransIP is de gekozen startprovider, geen
permanente uitsluiting van een tweede partij (ADR-0003, vervolgactie 4a).

## 4. Herstelscenario's

| Scenario | Aanpak | Streeftijd |
|---|---|---|
| Eén record per ongeluk verwijderd | herstel uit de applicatie of point-in-time kopie | < 1 uur |
| Foute migratie | migratie terugdraaien of point-in-time recovery | < `[2]` uur |
| Database verloren | volledige restore + transactielogs | < RTO |
| Zone-uitval | uitwijken naar tweede zone | < RTO |
| Ransomware / compromittering | herstel uit onveranderlijke back-up in een schone omgeving | `[8]` uur |
| Volledig verlies van de omgeving | infrastructuur opnieuw uitrollen (IaC) + restore | `[24]` uur |
| Provideraccount of control plane niet beschikbaar | **nog niet afgedekt** — herstel veronderstelt een werkend TransIP-account; zie *Wat de secundaire locatie wél en niet afdekt* | **te bepalen** vóór echte klantgelden |

## 5. Hersteltest (elk kwartaal)

1. Kies een scenario uit §4 (roteer, test niet altijd hetzelfde).
2. Zet terug in een **aparte** omgeving, nooit over productie heen.
3. Meet: hoelang duurde het, klopten de gegevens, wat ontbrak?
4. Controleer of verwijderverzoeken opnieuw zijn toegepast na herstel.
5. Leg het verslag vast (`../compliance/audit-evidence.md`, E-005).
6. Maak backlogitems van wat misging.

| Datum | Scenario | RTO gehaald | RPO gehaald | Bevindingen | Uitvoerder |
|---|---|---|---|---|---|
| `[datum]` | | ⬜ | ⬜ | | |

## 6. Herstel en privacy

Bij een restore kunnen gegevens terugkomen die eerder zijn verwijderd. Daarom:

* houd een verwijderlijst bij die na elk herstel opnieuw wordt toegepast;
* leg het herstel en de nabehandeling vast;
* informeer de privacyverantwoordelijke bij elk herstel dat persoonsgegevens raakt.

## 7. Verantwoordelijkheden

| Taak | Wie |
|---|---|
| Back-ups inrichten en bewaken | Ops |
| Bewaken dat back-ups slagen (alarm bij falen) | Ops |
| Hersteltest uitvoeren | Ops + één developer |
| Beoordeling van bewaartermijnen | Privacy |
| Goedkeuring RPO/RTO | opdrachtgever |
