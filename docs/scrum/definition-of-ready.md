# Definition of Ready

De Definition of Ready (DoR) is de afspraak wanneer een backlogitem de sprint in mag. Het
is **geen poortwachter om werk tegen te houden**, maar een middel om te voorkomen dat het
team halverwege de sprint vastloopt op onduidelijkheid.

> De DoR geldt voor items die het team in een sprint oppakt. Een spike of onderzoek heeft
> een lichtere variant (zie §4).

## 1. Criteria

Een backlogitem is **Ready** wanneer:

| # | Criterium | Waaraan zie je dat? |
|---|---|---|
| 1 | Het **probleem en de gebruikerswaarde** zijn duidelijk | het issue beschrijft het probleem, de persona en de verwachte waarde; niet alleen een oplossing |
| 2 | De **acceptatiecriteria zijn controleerbaar** | Given/When/Then, testbaar, inclusief foutpaden en lege staten |
| 3 | **Relevante afhankelijkheden zijn bekend** | genoemd in het issue, met status; externe afhankelijkheden hebben een eigenaar |
| 4 | **Designs of functionele uitgangspunten zijn beschikbaar** | link naar design/prototype, of een beschreven functioneel uitgangspunt |
| 5 | **Security-, privacy- en compliance-impact zijn voorlopig beoordeeld** | de drie velden zijn ingevuld (mag "Geen"), bij Hoog is de securityverantwoordelijke betrokken geweest |
| 6 | De **testaanpak is duidelijk** | welke tests op welk niveau, en welke synthetische testdata nodig is |
| 7 | Het item is **klein genoeg voor één sprint** | schatting ≤ `[8]` story points; anders splitsen |
| 8 | Het **team begrijpt het item** | besproken in refinement, geschat, geen openstaande "wat bedoel je?"-vragen |
| 9 | **Openstaande blokkades zijn zichtbaar** | geen onbekende blokkades; bekende blokkades staan in het issue en op het board |

## 2. Aanvullend bij een financiële dienst

| Situatie | Extra eis vóór Ready |
|---|---|
| Item raakt **geld** (bedragen, transacties, limieten) | rekenregels, afronding en valuta zijn expliciet beschreven; randgevallen benoemd |
| Item raakt **persoonsgegevens** | gegevenscategorieën, doel en bewaartermijn zijn benoemd; privacyverantwoordelijke heeft meegekeken |
| Item raakt **authenticatie of autorisatie** | securityverantwoordelijke heeft de eisen bevestigd; misbruikscenario's zijn benoemd |
| Item raakt een **externe partij** | koppeling, sandbox en foutscenario's zijn bekend; geen live-koppeling in test |
| Item raakt een **regulatoir onderwerp** | de vraag staat in `../compliance/compliance-register.md`; markering "te valideren door bevoegde specialist" waar nodig |
| Item raakt de **UI** | toegankelijkheidseisen benoemd; teksten op taalniveau B1 beschikbaar of belegd |

## 3. Praktisch: de Ready-check in refinement

Loop deze vragen hardop langs. Duurt 2 minuten per item:

1. Welk probleem van welke gebruiker lossen we op — en hoe weten we dat het bestaat?
2. Hoe weten we straks dat het werkt? (lees de acceptatiecriteria voor)
3. Wat gaat er mis als een kwaadwillende dit gebruikt?
4. Welke gegevens raken we, en hebben we ze echt allemaal nodig?
5. Wat zit hier níét in?
6. Waar zijn we van afhankelijk?
7. Past dit binnen één sprint? Zo niet: hoe splitsen we het?
8. Wie test dit, en waarmee?

## 4. Lichtere DoR voor onderzoek en spikes

Een spike is Ready wanneer: de onderzoeksvraag helder is, de timebox vaststaat, het
op te leveren resultaat is beschreven, en duidelijk is welke beslissing erop wacht.
Acceptatiecriteria, designs en testaanpak zijn dan niet van toepassing.

## 5. Wat als iets niet Ready is?

* Het item blijft in **Ready for refinement** of gaat terug naar **Discovery**.
* Er wordt een concrete actie met eigenaar afgesproken om het Ready te maken.
* Het komt **niet** de sprint in "omdat er toch ruimte is". Werk aan half-heldere items
  levert herwerk en risico op — bij een financiële dienst is dat duur.

Uitzondering: een productieverstoring of een kritieke kwetsbaarheid gaat altijd voor. Die
kent per definitie onzekerheid; leg dan wel direct vast wat bekend is.

## 6. Onderhoud

De DoR wordt geëvalueerd in de retrospective. Loopt het team structureel vast op één
criterium, dan wordt de DoR aangescherpt — nooit stilzwijgend versoepeld.
Wijzigingen: pull request met review door PO en Scrum Master.
