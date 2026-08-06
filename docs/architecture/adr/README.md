# Architecture Decision Records (ADR)

Een ADR legt vast **waarom** een technische keuze is gemaakt, welke alternatieven zijn
overwogen en welke gevolgen zijn geaccepteerd. Zonder ADR's verdwijnt die kennis met de
mensen die het team verlaten — bij een financiële dienst is dat ook een auditprobleem.

Toetsingskader voor elke ADR: [`../architecture-principles.md`](../architecture-principles.md).
Wijk je af van een principe, dan hoort dat expliciet in de ADR onder *Negatieve gevolgen*.

> [!IMPORTANT]
> **Een ADR is een ontwerpbesluit, geen implementatie en geen bewijs.** Status
> *Geaccepteerd* betekent dat het team het eens is over de richting — niet dat er iets is
> gebouwd, ingericht of aangetoond. Er is in deze repository nog **geen applicatiecode**;
> elke ADR staat daarmee in de fase **Ontworpen**.
>
> | | Waar het staat | Wat het aantoont |
> |---|---|---|
> | **Ontwerp** | ADR | *waarom* een keuze is gemaakt en welke gevolgen zijn geaccepteerd |
> | **Implementatie** | code, Ansible, configuratie | dat de maatregel bestaat |
> | **Bewijs** | [`../../compliance/audit-evidence.md`](../../compliance/audit-evidence.md), testresultaten | dat de maatregel aantoonbaar werkt |
>
> **Verificatie vindt pas plaats tijdens implementatie en acceptatie.** De fasen zijn
> gedefinieerd in
> [`../../compliance/compliance-register.md`](../../compliance/compliance-register.md).

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

Alle geaccepteerde ADR's staan in de fase **Ontworpen**: het besluit ligt vast, de
maatregel is nog niet gebouwd of aangetoond.

| Nr | Titel | Status | Fase | Datum | Security-impact |
|---|---|---|---|---|---|
| 0001 | Sjabloon voor architectuurbesluiten | Geaccepteerd | n.v.t. (sjabloon) | `[JJJJ-MM-DD]` | n.v.t. |
| 0002 | [Technologiestack](0002-technologiestack.md) | Geaccepteerd | Ontworpen | 2026-08-05 | hoog |
| 0003 | [Cloudprovider en hostingarchitectuur](0003-cloudprovider.md) | Geaccepteerd | Ontworpen | 2026-08-05 | hoog |
| 0004 | [Identity & Access Management](0004-identity-and-access-management.md) | Geaccepteerd — **leverancieronafhankelijk model** (besluit 8) én **gekozen provider: Keycloak, self-hosted** (besluit 8A) | Ontworpen | 2026-08-06 | hoog |
| 0005 | `[Encryptie- en sleutelbeheerstrategie]` | **Te schrijven** | Nog te ontwerpen | | hoog |
| 0006 | [Dataresidency en opslaglocatie](0006-dataresidency-en-opslaglocatie.md) | Geaccepteerd | Ontworpen | 2026-08-03 | midden |
| 0007 | [Vergunningplicht en rol in de keten](0007-vergunningplicht-en-rol-in-de-keten.md) | Geaccepteerd **voor de bedrijfs- en keteninrichting**; wettelijke grondslag nog te valideren | Ontworpen | 2026-08-05 | hoog |
| 0008 | [Geld- en contractstroom](0008-geld-en-contractstroom.md) | Geaccepteerd **als functioneel ontwerp**; alleen uitvoerbaar met synthetische data en sandboxintegraties | Ontworpen | 2026-08-05 | hoog |

ADR-0005 (sleutelbeheer) is de laatste "te schrijven" ADR uit de openstaande beslissingen in
de README en hoort bij de eerste sprints.

**ADR-0004 bevat twee besluiten.** Besluit 8 legt het **leverancieronafhankelijke
IAM-model** vast; besluit 8A kiest **Keycloak** als Identity Provider voor de MVP,
self-hosted en native onder systemd. Die keuze verandert niets aan de adaptergrens:
Keycloak-specifieke code mag **uitsluitend** binnen de IdP-adapter of de
infrastructuurconfiguratie voorkomen, zodat een andere OIDC-conforme provider bruikbaar
blijft zonder wijziging aan de domeinlogica (control **C-36**, dreiging **T-33**).

**Keycloak is gekozen, niet ingericht.** Installatie, realms, clients, authenticatieflows,
back-ups, monitoring en de adaptertest staan alle in de fase *nog te implementeren* of *nog
te verifiëren* — zie ADR-0004 §8A.9.

ADR-0006 loopt vooruit op ADR-0003: dataresidency is vastgesteld vóór de
providerkeuze, zodat ADR-0003 binnen die randvoorwaarde moet passen in plaats van haar
stilzwijgend te bepalen.

ADR-0007 en ADR-0008 leggen het **bedrijfs- en ketenmodel** vast (besluit 4) en houden dat
scherp gescheiden van de **wettelijke grondslag** om dat model uit te voeren. Die grondslag
staat nog open (RD-23 t/m RD-27): de gekozen productinrichting kan vergunningplichtig zijn,
en de toepasselijke wettelijke grondslag wordt vastgesteld door Compliance.

**"Geaccepteerd" betekent hier niet dat productiegebruik of echte geldstromen juridisch
zijn toegestaan.** ADR-0007 is geaccepteerd voor de product- en keteninrichting; ADR-0008
als functioneel doelmodel dat uitsluitend met synthetische data en sandboxintegraties mag
worden uitgevoerd. De Definition of Done in ADR-0007 benoemt wat er moet gebeuren voordat
het model met echte gebruikers mag worden uitgevoerd.

De **betaalpartners zijn nog niet definitief geselecteerd of gecontracteerd**; Mollie en
bunq vormen de eerste implementatierichting (RD-22).
