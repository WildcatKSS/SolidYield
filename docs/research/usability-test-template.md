# Usabilitytest (sjabloon)

Doel: vaststellen of mensen de taak **zelfstandig** kunnen uitvoeren, en waar ze
vastlopen. We testen het product, nooit de deelnemer.

## Vooraf

| Veld | Invulling |
|---|---|
| Sessiecode | `UT-[SPRINT]-[NR]` |
| Datum | `[JJJJ-MM-DD]` |
| Deelnemer | `P[n]` |
| Profiel | `[persona, digitale vaardigheid, toegankelijkheidsbehoefte]` |
| Testobject | `[prototype / increment op [STAGING-URL]]` |
| Versie/commit | `[v0.3.0 / abc1234]` |
| Facilitator / observator | `[NAAM]` / `[NAAM]` |
| Hulpmiddelen deelnemer | `[eigen laptop, schermlezer, vergroting …]` |
| Toestemming vastgelegd | ⬜ ja |
| Testdata | uitsluitend synthetisch, testaccount `[TESTACCOUNT-CODE]` |

## Hypothese en succescriteria

> **Hypothese:** wij denken dat `[PERSONA]` `[TAAK]` binnen `[TIJD]` zelfstandig kan
> uitvoeren, omdat `[ONDERBOUWING]`.

| Criterium | Streefwaarde |
|---|---|
| Taaksucces (zonder hulp) | ≥ `[5]` van `[6]` deelnemers |
| Tijd tot voltooiing | ≤ `[X]` minuten |
| Kritieke fouten (onopgemerkt fout resultaat) | 0 |
| Zelfgerapporteerde moeite (1 = zeer makkelijk … 7 = zeer moeilijk) | ≤ 3 |
| Begrip van het getoonde bedrag/inzicht | ≥ `[80]%` legt het correct uit |

## Introductie (5 min)

> "Dit is een product in ontwikkeling. We testen het product, niet jou — als iets niet
> lukt, is dat waardevolle informatie voor ons.
>
> Denk graag hardop: wat je ziet, wat je verwacht, waar je naar zoekt en wat je verwart.
>
> Ik help je bewust niet meteen; ik wil zien hoe ver je zelf komt. Je mag altijd stoppen.
>
> Alle gegevens die je ziet zijn **verzonnen**. Gebruik alsjeblieft geen echte gegevens
> van jezelf."

Opname: ⬜ scherm ⬜ audio ⬜ geen — verwijderd binnen `[30]` dagen.

## Taken

Geef een **situatie**, geen instructie met de knopnamen erin.

### Taak 1 — `[TITEL]`
> "Stel je voor: `[SITUATIE]`. Wat zou je nu doen?"

| Observatie | Invulling |
|---|---|
| Succes | ⬜ zelfstandig ⬜ met hint ⬜ niet gelukt |
| Tijd | `[mm:ss]` |
| Aantal aarzelingen / verkeerde paden | |
| Kritieke fout (fout resultaat, niet opgemerkt) | ⬜ nee ⬜ ja: … |
| Citaat | "…" |
| Moeite (1–7) | |

### Taak 2 — `[TITEL]`
*(zelfde tabel)*

### Taak 3 — foutpad `[TITEL]`
> "Stel dat er iets misgaat: `[FOUTSITUATIE]`. Wat zou je doen?"

Let hier extra op: begrijpt de deelnemer wat er is gebeurd, weet die wat te doen, en
ontstaat er onterecht paniek over geld?

## Vaste observatiepunten bij een financiële dienst

| Punt | Waarneming |
|---|---|
| Begrijpt de deelnemer het getoonde bedrag en waar het vandaan komt? | |
| Wekt iets ten onrechte vertrouwen of juist wantrouwen? | |
| Weet de deelnemer wat er met de gegevens gebeurt (toestemmingsscherm)? | |
| Voelt de deelnemer zich onder druk gezet (drang, urgentie, dark pattern)? | |
| Zijn foutmeldingen begrijpelijk en handelingsgericht? | |
| Werkt de kernreis met toetsenbord / vergroting / schermlezer? | |

## Na afloop (10 min)

* Wat was het makkelijkst? Wat het lastigst?
* Als je één ding mocht veranderen, wat dan?
* Wat denk je dat dit product voor je doet?
* Zou je dit met je eigen financiële gegevens gebruiken? Waarom (niet)?
* Wat zou je tegenhouden?

## Resultaat (binnen 1 werkdag invullen)

**Samenvatting per criterium**

| Criterium | Streefwaarde | Gemeten | Gehaald |
|---|---|---|---|
| Taaksucces | | | ⬜ |
| Tijd | | | ⬜ |
| Kritieke fouten | 0 | | ⬜ |
| Moeite | | | ⬜ |

**Bevindingen** (elk als issue via `test-group-feedback.yml`)

| # | Bevinding | Classificatie | Frequentie | Impact | Bewijssterkte | Issue |
|---|---|---|---|---|---|---|
| 1 | | kritiek probleem / gebruiksprobleem / ontbrekende behoefte / verbetering / compliment / nieuwe hypothese / buiten scope | `[n van m]` | blokkerend / groot / matig / klein | sterk / middel / zwak | # |

**Conclusie t.o.v. de hypothese:** ⬜ bevestigd ⬜ weerlegd ⬜ onduidelijk

**Besluit:** ⬜ doorgaan ⬜ aanpassen ⬜ opnieuw testen ⬜ stoppen — onderbouwing: …

**Vervolgacties:** zie [`feedback-log.md`](feedback-log.md).
