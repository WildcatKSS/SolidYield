# Toegangsbeheer

Wie mag wat, op basis waarvan, en hoe tonen we dat aan? Uitgangspunt is **least
privilege**: minimale rechten, zo kort mogelijk, altijd controleerbaar.

## 1. Rollen in de applicatie

| Rol | Mag | Mag niet | MFA | Auditing |
|---|---|---|---|---|
| **Gebruiker** | eigen gegevens zien en beheren, toestemming geven/intrekken, exporteren, account verwijderen | gegevens van anderen; systeeminstellingen | verplicht | inloggen, gevoelige acties |
| **Supportmedewerker** | beperkte gegevens inzien **met aanleiding**, status van verzoeken | financiële details wijzigen; exporteren; bulkinzage | verplicht | elke inzage, met reden |
| **Beheerder** | configuratie, gebruikersbeheer, uitrol | ongemotiveerde inzage in klantgegevens | verplicht + vier-ogen | alles |
| **Auditor** | alleen-lezen op bewijs en logs | wijzigen; klantgegevens | verplicht | alle inzage |
| **Systeem/service** | precies wat de taak vereist | alles daarbuiten | n.v.t. (mTLS/OIDC) | alle acties |

**Regel:** support en beheer krijgen geen standaardtoegang tot klantgegevens. Toegang is
just-in-time, tijdelijk (`[4]` uur), met vastgelegde aanleiding, en de gebruiker wordt
geïnformeerd wanneer dat passend is.

## 2. Autorisatiemodel

* **RBAC** voor grofmazige rechten (welke functies) **plus** eigenaarschapscontrole per
  object (welke gegevens).
* Elke autorisatiecontrole gebeurt **serverseitig**, bij **elk** verzoek.
* Standaard weigeren; toegang is expliciet.
* Rollen komen nooit uit clientgegevens of uit een aanpasbaar token-veld zonder validatie.
* Elke endpoint heeft een test die aantoont dat gebruiker A niet bij de gegevens van
  gebruiker B kan (dreiging T-05).

## 3. Toegang tot omgevingen

| Omgeving | Wie | Voorwaarden |
|---|---|---|
| development | developers | eigen credentials, synthetische data |
| test | team | geen productiedata, aparte sleutels |
| staging | team + testgroep (testaccounts) | representatief, synthetische data |
| **production** | strikt beperkte groep | MFA, just-in-time, aanleiding vastgelegd, vier-ogen bij wijzigingen, volledige auditlog |

Directe databasetoegang in productie is een uitzondering: alleen bij incidenten, met
goedkeuring, met een tweede persoon en met vastlegging.

## 4. Toegang tot de repository en pipeline

| Onderwerp | Instelling |
|---|---|
| Standaardrechten | read; write alleen voor teamleden |
| Branch protection op `main` | verplichte PR, reviews, CODEOWNERS, statuschecks, geen force push, geen directe commits |
| Ondertekende commits | verplicht zodra alle teamleden sleutels hebben (ADR) |
| GitHub Actions-rechten | `permissions: contents: read` als standaard; verhoog per job |
| Deploycredentials | environment secrets; bij voorkeur OIDC in plaats van langlevende sleutels |
| Beheerdersrechten op de repository | minimaal, met MFA |

## 5. Levenscyclus van toegang

| Moment | Actie |
|---|---|
| Indiensttreding / toetreden tot het team | rechten op basis van rol; vastgelegd in `[SYSTEEM]` |
| Rolwijziging | oude rechten intrekken vóór nieuwe toekennen |
| Vertrek | alle toegang binnen `[24]` uur intrekken; sleutels roteren |
| Tijdelijke verhoging | maximaal `[4]` uur, met aanleiding en automatische intrekking |
| Periodieke review | elk kwartaal: klopt de lijst nog? |

## 6. Sterke authenticatie voor het team

* MFA verplicht op GitHub, cloud, secrets manager en e-mail.
* Bij voorkeur hardware- of passkey-gebaseerd voor beheerderstoegang.
* Geen gedeelde accounts. Nooit.
* Beheerderstoegang loopt via een persoonlijk account, niet via een generiek "admin".

## 7. Aantoonbaarheid

| Bewijs | Waar | Frequentie |
|---|---|---|
| Overzicht van rollen en rechten | `[SYSTEEM]` | doorlopend |
| Kwartaalreview toegang | [`../compliance/audit-evidence.md`](../compliance/audit-evidence.md) | per kwartaal |
| Auditlog van inzage door support/beheer | auditlogopslag | doorlopend |
| Intrekking bij vertrek | `[HR/IT-PROCES]` | per geval |

## 8. Openstaande beslissingen

| Onderwerp | Eigenaar | Status |
|---|---|---|
| Identiteitsprovider en MFA-methode | Security | ADR te schrijven |
| Just-in-time-toegangsoplossing | Security + Ops | open |
| Duur van tijdelijke rechten (`[4]` uur is een aanname) | Security | te bevestigen |
| Informeren van gebruikers bij inzage door support | Privacy + PO | **te valideren door bevoegde specialist** |
