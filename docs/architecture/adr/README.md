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
| 0006 | [Dataresidency en opslaglocatie](0006-dataresidency-en-opslaglocatie.md) | Geaccepteerd | 2026-08-03 | midden |
| 0007 | [Vergunningplicht en rol in de keten](0007-vergunningplicht-en-rol-in-de-keten.md) | Geaccepteerd | 2026-08-05 | hoog |
| 0008 | [Geld- en contractstroom](0008-geld-en-contractstroom.md) | Geaccepteerd | 2026-08-05 | hoog |

De vier "te schrijven" ADR's zijn openstaande beslissingen uit de README; zij horen bij de
eerste sprints. ADR-0006 loopt daarop vooruit: dataresidency is vastgesteld vóór de
providerkeuze, zodat ADR-0003 binnen die randvoorwaarde moet passen in plaats van haar
stilzwijgend te bepalen.

ADR-0007 en ADR-0008 leggen het **bedrijfs- en ketenmodel** vast (besluit 4, geaccepteerd)
en houden dat scherp gescheiden van de **wettelijke grondslag** om dat model uit te voeren.
Die grondslag staat nog open (RD-23 t/m RD-27): de gekozen productinrichting kan
vergunningplichtig zijn, en de toepasselijke wettelijke grondslag wordt vastgesteld door
Compliance. De Definition of Done in ADR-0007 benoemt wat er moet gebeuren voordat het
model met echte gebruikers mag worden uitgevoerd.
