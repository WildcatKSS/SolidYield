# Epic-threatchecklist

> **Doel:** threat modelling praktisch maken op het niveau waarop je het echt doet — per
> epic, vóórdat er code is.
> **Wanneer gebruiken:** bij de start van elke epic, en opnieuw wanneer een epic een
> vertrouwensgrens verandert.
> **Wie:** de Developers (met security-expertise / Security Champion) en de tech lead;
> privacy sluit aan wanneer er gegevens in het spel zijn.
> **Adoptieniveau:** Advanced.
> **Gerelateerd:** [`threat-model.md`](threat-model.md) (het systeembrede model) ·
> [`../security/security-champions.md`](../security/security-champions.md) ·
> [`../scrum/refinement.md`](../scrum/refinement.md)

Dit vervangt het systeembrede [threat model](threat-model.md) niet: dat blijft de plek waar
dreigingen, risico's en restrisico's worden bijgehouden. Deze checklist is het **werkblad**
waarmee je per epic bepaalt wat er aan dat model verandert.

**Tijdsbeslag:** 45–60 minuten per epic. Duurt het langer, dan is de epic te groot.

**STRIDE is hier een hulpmiddel, geen doel.** Kom je met gewone vragen tot dezelfde
dreigingen, dan is dat prima.

---

## Werkblad

Kopieer dit blok in het epic-issue of in een notitie bij de epic.

**Epic:** `#[nr] — [titel]` · **Datum:** `[JJJJ-MM-DD]` · **Deelnemers:** `[namen]`

### 1. Assets — wat valt hier te halen of te beschadigen?

- [ ] Welke gegevens raakt deze epic? (klassen uit [`../privacy/data-classification.md`](../privacy/data-classification.md))
- [ ] Raakt het geld, saldi, limieten of transacties?
- [ ] Raakt het authenticatiemiddelen, sleutels of tokens?
- [ ] Wat is de schade als dit lekt, wijzigt of wegvalt?

Antwoord: …

### 2. Actoren en vertrouwensgrenzen

- [ ] Komen er nieuwe actoren bij (gebruiker, support, systeem, leverancier)?
- [ ] Verandert er een vertrouwensgrens uit [`system-context.md`](system-context.md) (TB-1 t/m TB-5)?
- [ ] Krijgt iemand toegang tot iets waar die eerder niet bij kon?
- [ ] Is er een nieuw pad van buiten naar binnen?

Antwoord: …

### 3. Gegevensstromen

- [ ] Welke nieuwe stroom ontstaat er, en met welk doel?
- [ ] Verlaten gegevens onze grens? Naar wie, waarheen, onder welke afspraak?
- [ ] Wordt er meer verzameld dan nodig? (minimalisatie)
- [ ] Moet [`data-flow.md`](data-flow.md) worden bijgewerkt? ⬜ ja ⬜ nee

### 4. Authenticatie en autorisatie

- [ ] Wie mag dit, en hoe wordt dat **serverseitig** afgedwongen?
- [ ] Is er een objecteigenaarcontrole (kan gebruiker A bij de gegevens van B)?
- [ ] Is herauthenticatie nodig (gevoelige handeling)?
- [ ] Verandert er iets aan rollen, rechten of sessies?

### 5. Misbruikscenario's ("abuse stories")

Schrijf er minimaal drie, in dezelfde vorm als een user story:

> Als **[aanvaller]** wil ik **[misbruik]** zodat **[voordeel]**.

1. …
2. …
3. …

Hulpvragen per STRIDE-categorie:

| Categorie | Vraag |
|---|---|
| Spoofing | kan iemand zich voordoen als een ander? |
| Tampering | kan invoer, bedrag of parameter worden gemanipuleerd? |
| Repudiation | kan iemand ontkennen dat die dit deed? |
| Information disclosure | kan iets zichtbaar worden voor de verkeerde persoon? |
| Denial of service | kan iemand dit onbruikbaar maken of overbelasten? |
| Elevation of privilege | kan iemand meer rechten krijgen dan bedoeld? |

### 6. Financiële manipulatie

Specifiek voor een financiële dienst — niet overslaan als er bedragen in het spel zijn:

- [ ] Kan een bedrag, koers, limiet of afronding worden beïnvloed door de client?
- [ ] Kan een handeling dubbel worden uitgevoerd (idempotentie)?
- [ ] Zijn limieten en snelheidscontroles serverseitig afgedwongen?
- [ ] Bestaat er een volgorde van handelingen die tot een onbedoeld voordeel leidt?
- [ ] Is er een pad waarlangs iemand zichzelf of een ander financieel benadeelt zonder dat
      wij het zien?

### 7. Logging en detectie

- [ ] Welke gebeurtenissen horen in het **auditlog** (wie, wat, wanneer, resultaat)?
- [ ] Waaraan zouden we misbruik hérkennen? Welke meting of alert hoort daarbij?
- [ ] Staat er niets gevoeligs in de gewone applicatielog (bedragen, tokens, persoonsgegevens)?

### 8. Afhankelijkheden en leveranciers

- [ ] Komt er een nieuwe bibliotheek, API of leverancier bij?
- [ ] Wat gebeurt er als die partij uitvalt, traag is of onjuiste gegevens levert?
- [ ] Welke gegevens krijgt die partij te zien, en op basis waarvan?
- [ ] Is er een verwerkersovereenkomst nodig? → compliance-taak aanmaken

### 9. Privacy-impact

- [ ] Nieuwe gegevenscategorie, nieuw doel of nieuwe ontvanger? → privacybeoordeling
- [ ] Bewaartermijn bekend en afdwingbaar? ([`../privacy/data-retention.md`](../privacy/data-retention.md))
- [ ] DPIA-toets nodig? ([`../privacy/privacy-impact-assessment-template.md`](../privacy/privacy-impact-assessment-template.md))

### 10. Benodigde securitytests

Welke tests uit [`../../tests/security/README.md`](../../tests/security/README.md) gelden
hier, en welke moeten nieuw worden geschreven?

| Test | Bestaat al | Nieuw nodig |
|---|---|---|
| S-1 autorisatie op objectniveau | ⬜ | ⬜ |
| S-4 snelheidsbeperking | ⬜ | ⬜ |
| S-7 bedragen en limieten serverseitig | ⬜ | ⬜ |
| S-10 auditlogging | ⬜ | ⬜ |
| `[eigen test]` | ⬜ | ⬜ |

### 11. Uitkomst

| Nr | Dreiging | Risico (H/M/L) | Maatregel | Wordt | Eigenaar |
|---|---|---|---|---|---|
| 1 | | | | acceptatiecriterium / eigen issue / test | |
| 2 | | | | | |
| 3 | | | | | |

**Restrisico's** (niet weggenomen, bewust geaccepteerd):

| Restrisico | Compenserende maatregel | Houdbaar tot | Goedgekeurd door |
|---|---|---|---|
| | | | |

Risicoacceptatie loopt via [`../../GOVERNANCE.md`](../../GOVERNANCE.md) §4; kritieke en
hoge risico's kunnen de Developers niet zelf accepteren.

### 12. Afronding

- [ ] Dreigingen met risico Hoog of hoger toegevoegd aan [`threat-model.md`](threat-model.md)
- [ ] Maatregelen zijn acceptatiecriterium of eigen backlogitem geworden
- [ ] [`data-flow.md`](data-flow.md) en [`system-context.md`](system-context.md) bijgewerkt waar nodig
- [ ] Securitytests benoemd in de betreffende stories
- [ ] Raakt het een control: bewijs belegd ([`../compliance/control-mapping.md`](../compliance/control-mapping.md))

---

## Wanneer sla je dit over?

Bij een epic die aantoonbaar geen gegevens, geld, toegang of externe koppeling raakt —
bijvoorbeeld een puur interne refactor of documentatiewerk. Noteer dan in het epic-issue
in één regel **waarom** je het oversloeg. Dat is de controle; het lege werkblad niet.
