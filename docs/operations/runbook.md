# Runbook

Praktische instructies voor als er iets misgaat. Kort, concreet en uitvoerbaar onder druk.

> **Eerste regel:** meld een vermoeden van een beveiligingsincident of datalek
> **onmiddellijk** via het incidentproces
> ([`../security/incident-response.md`](../security/incident-response.md)). Wacht niet op
> bevestiging, volledigheid of eigen onderzoek. Melden mag op basis van een vermoeden.

> **Gerelateerd:** [`sre-principles.md`](sre-principles.md) (incidentniveaus en
> post-mortems) · [`../security/incident-response.md`](../security/incident-response.md)

## 0. Contact

| Rol | Contact | Wanneer |
|---|---|---|
| Dienstdoende engineer | `[KANAAL/NUMMER]` | eerste opvang |
| Incident lead | `[NAAM/ROL]` | P1/P2 |
| Security | `[SECURITY-CONTACT-EMAIL]` | securityvermoeden |
| Privacy | `[PRIVACY-CONTACT-EMAIL]` | persoonsgegevens geraakt |
| Product Owner | `[CONTACT]` | gebruikersimpact, communicatie |
| Leverancier `[PROVIDER]` | `[CONTACT]` | koppelingsstoring |

## 1. Algemene aanpak

1. **Stabiliseren** vóór begrijpen: beperk de schade.
2. **Vastleggen** vanaf minuut nul: tijdstempel, waarneming, actie.
3. **Communiceren**: intern altijd, extern via de PO/communicatie.
4. **Escaleren** bij twijfel — te vroeg escaleren is nooit fout.
5. **Evalueren** achteraf: blameless post-mortem.

## 2. Scenario: applicatie onbereikbaar (P1)

1. Bevestig de storing (statuspagina, healthcheck, meerdere bronnen).
2. Kijk naar de laatste deploy: recent? → **rollback** (`docs/operations/deployment.md` §7).
3. Controleer infrastructuur: instanties, database, netwerk, certificaten.
4. Controleer afhankelijkheden: `[IDP]`, `[PROVIDER]`, cloudstatus.
5. Nog geen oorzaak? Schaal op en meld het incident; blijf vastleggen.
6. Informeer gebruikers via `[KANAAL]` zodra de storing > `[15]` minuten duurt.

## 3. Scenario: verhoogde foutratio

1. Welke endpoints? Welke foutcodes? Sinds wanneer?
2. Correleer met deploys, migraties, configuratiewijzigingen en leveranciersstatus.
3. Beperkt tot één functie? → feature flag uit.
4. Breed? → rollback overwegen.
5. Controleer of gebruikers onjuiste **bedragen** kunnen zien; zo ja → P1.

## 4. Scenario: koppeling met `[PROVIDER]` valt uit

1. Bevestig via de statuspagina van de leverancier.
2. Controleer of de circuit breaker werkt en of de degradatie klopt (laatst bekende
   gegevens mét tijdstempel).
3. Zorg dat de gebruiker een begrijpelijke melding ziet — nooit een technische fout.
4. Neem contact op met `[PROVIDER]` en registreer een incident bij de leverancier.
5. Volg de achterstand; plan het bijwerken zodra de koppeling terug is.

## 5. Scenario: piek in mislukte inlogpogingen

1. Bekijk het patroon: één account, één IP, of breed?
2. Controleer of de snelheidsbeperking werkt.
3. Breed en gericht? → tijdelijk strengere limieten; overweeg extra verificatie.
4. Aanwijzing van geslaagde accountovername? → **security incident**, sessies intrekken,
   getroffen gebruiker informeren.
5. Blokkeer nooit permanent op basis van invoer van derden.

## 6. Scenario: gelekt secret

1. **Roteer eerst.** Een gepusht secret is gecompromitteerd, ook als de commit is verwijderd.
2. Trek de oude sleutel in bij de leverancier.
3. Onderzoek of er misbruik heeft plaatsgevonden (logs bij de leverancier).
4. Verwijder het secret uit de historie; ga niet uit van geheimhouding daarvóór.
5. Meld als securityincident; leg vast hoe het kon gebeuren en verbeter de controle.

## 7. Scenario: onjuiste bedragen of berekeningen (P1)

1. Bepaal de omvang: welke gebruikers, welke periode, welk verschil?
2. Zet de betreffende functie uit (feature flag) om verdere schade te voorkomen.
3. Betrek de PO en compliance: dit raakt vertrouwen en mogelijk verplichtingen.
4. Corrigeer de gegevens met vier-ogencontrole en volledige vastlegging.
5. Informeer getroffen gebruikers duidelijk en feitelijk.
6. Voeg een regressietest toe vóór de fix live gaat.

## 8. Scenario: achterstand in wachtrijen

1. Meet de achterstand en de verwerkingssnelheid.
2. Schaal workers op als de oorzaak volume is.
3. Bekijk de dead-letter-wachtrij op terugkerende fouten.
4. Duurt de achterstand > `[60]` minuten? Toon de gebruiker de versheid van de gegevens.

## 9. Scenario: databaseherstel nodig

Volg [`backup-and-recovery.md`](backup-and-recovery.md). Kern:

1. Zet de dienst in onderhoudsmodus.
2. Herstel naar een **aparte** omgeving en controleer de gegevens.
3. Schakel om, controleer opnieuw, en pas verwijderverzoeken opnieuw toe.
4. Leg vast en informeer privacy als persoonsgegevens zijn geraakt.

## 10. Na elk incident

- [ ] Tijdlijn compleet
- [ ] Post-mortem binnen 5 werkdagen
- [ ] Verbeteracties als issues, met eigenaar
- [ ] Monitoring/alarmering aangescherpt waar nodig
- [ ] Runbook bijgewerkt met wat we hebben geleerd
- [ ] Bewijs vastgelegd in `../compliance/audit-evidence.md`

## 11. Onderhoud van dit runbook

Bijwerken na elk incident en minimaal elk kwartaal. Een instructie die niet klopt onder
druk, is erger dan geen instructie.

## 12. Nog te schrijven runbooks — open vervolgactie

De scenario's hierboven dekken de generieke gevallen. **Vóór productie moeten daarnaast
operationele runbooks bestaan** voor onder andere:

| # | Onderwerp |
|---|---|
| 1 | **account recovery** — inclusief de scenario's uit [ADR-0004](../architecture/adr/0004-identity-and-access-management.md) vervolgactie 8 |
| 2 | **providerstoringen** — betaalpartner, Identity Provider, hosting |
| 3 | **mislukte betalingen** |
| 4 | **reconciliation** |
| 5 | **dead letter jobs** |
| 6 | **KYC-herbeoordeling** |
| 7 | **incidentafhandeling** |

> **Dit is een open vervolgactie, geen beschrijving van bestaande procedures.** De
> procedures zelf worden later uitgewerkt en vastgesteld; hier wordt uitsluitend vastgelegd
> **dát** zij vóór productie moeten bestaan. Er wordt hiermee geen beheerbesluit genomen.
>
> **Eigenaar:** Ops + Support. Zie ook
> [`platform-readiness-checklist.md`](platform-readiness-checklist.md).
