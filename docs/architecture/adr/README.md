# Architecture Decision Records (ADR)

Een ADR legt vast **waarom** een technische keuze is gemaakt, welke alternatieven zijn
overwogen en welke gevolgen zijn geaccepteerd. Zonder ADR's verdwijnt die kennis met de
mensen die het team verlaten — bij een financiële dienst is dat ook een auditprobleem.

Toetsingskader voor elke ADR: [`../architecture-principles.md`](../architecture-principles.md).
Wijk je af van een principe, dan hoort dat expliciet in de ADR onder *Negatieve gevolgen*.

## Werkwijze

1. Kopieer [`0001-architecture-decision-template.md`](0001-architecture-decision-template.md)
   naar `000X-korte-titel.md` (oplopend nummer, kleine letters, koppeltekens).
2. Vul de ADR in met status *Voorgesteld* en open een pull request.
3. Bespreek de ADR met het team; security en privacy reviewen bij impact.
4. Bij akkoord: status naar *Geaccepteerd*, mergen.
5. Achterhaald? Schrijf een **nieuwe** ADR en zet de oude op *Vervangen door ADR-000Y*.
   Een geaccepteerde ADR wordt nooit herschreven.

## Wanneer wel, wanneer niet?

| Wel een ADR | Geen ADR |
|---|---|
| keuze van stack, database, cloud, identiteitsprovider | de naam van een variabele |
| architectuurpatroon (monolith vs. services) | een lokale refactor |
| authenticatie- en autorisatiemodel | keuze van een lint-regel |
| encryptie- en sleutelbeheerstrategie | bibliotheekversie-upgrade |
| dataresidency en opslaglocatie | tijdelijke workaround (wel een issue) |
| keuze van een externe leverancier | |
| afwijking van een securityprincipe | |

## Register

| Nr | Titel | Status | Datum | Security-impact |
|---|---|---|---|---|
| 0001 | Sjabloon voor architectuurbesluiten | Geaccepteerd | `[JJJJ-MM-DD]` | n.v.t. |
| 0002 | `[Keuze technologiestack]` | **Te schrijven** | | hoog |
| 0003 | `[Keuze cloudprovider en regio]` | **Te schrijven** | | hoog |
| 0004 | `[Keuze identiteitsprovider en MFA]` | **Te schrijven** | | hoog |
| 0005 | `[Encryptie- en sleutelbeheerstrategie]` | **Te schrijven** | | hoog |

De vier "te schrijven" ADR's zijn openstaande beslissingen uit de README; zij horen bij de
eerste sprints.
