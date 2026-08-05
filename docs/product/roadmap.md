# Roadmap

Deze roadmap is **op resultaat gericht**, niet op datums met vaste functionaliteit. Hij
beschrijft welk probleem we wanneer willen oplossen en welke onzekerheid we dan hebben
weggenomen. Alles na de huidige horizon is een intentie, geen belofte.

## Horizon 1 — Valideren (sprint 1–4)

| Doel | Los de vraag op: *bestaat het probleem en vertrouwt de doelgroep ons?* |
|---|---|
| Increment | interne prototypeversie → testgroepversie |
| Belangrijkste epics | E1 (account en toegang), E2 (kerninzicht, dun), E3 (toestemming en transparantie) |
| Validatie | 8–12 interviews, 2 usabilityrondes |
| Klaar wanneer | aannames A1–A3 uit [`mvp-scope.md`](mvp-scope.md) zijn bevestigd of weerlegd |
| Risico dat we wegnemen | bouwen we het juiste product? |

## Horizon 2 — MVP afronden en beperkt uitrollen (sprint 5–8)

| Doel | Los de vraag op: *werkt het in de praktijk, veilig en betrouwbaar?* |
|---|---|
| Increment | bèta → beperkte productie-uitrol |
| Onderwerpen | betrouwbaarheid van gegevens, meldingen, support, monitoring, pentest, DPIA afgerond |
| Validatie | testgroep in een realistische omgeving, meting van terugkeergedrag |
| Klaar wanneer | de succescriteria uit `mvp-scope.md` zijn gehaald en er geen kritieke of hoge kwetsbaarheden openstaan |
| Voorwaarde | **regulatoire toets afgerond en bevestigd door een bevoegde specialist** |

## Horizon 3 — Verbreden (sprint 9+)

| Doel | Los de vraag op: *kunnen we dit opschalen en verbreden?* |
|---|---|
| Kandidaten | `[TWEEDE PROBLEEM]`, extra `[KOPPELINGEN]`, mobiele app, meertaligheid, gefaseerde uitbreiding naar andere EER-landen |
| Voorwaarde | Horizon 2 aantoonbaar geslaagd |
| Status | intentie — expliciet **geen** toezegging |

## Wat we bewust níét plannen

* Functionaliteit waarvoor geen bewijs van behoefte is.
* Uitbreiding naar nieuwe landen vóór juridische bevestiging.
* Vervanging van technologie zonder ADR en aantoonbare noodzaak.

## Afhankelijkheden en openstaande beslissingen

| Onderwerp | Nodig vóór | Eigenaar | Status |
|---|---|---|---|
| Keuze technologiestack en cloud | sprint 1 | Tech lead | open |
| Juridisch advies over het rendementproduct in Nederland (RD-01) | Horizon 2 | Compliance | open |
| Contract en DPA met `[LEVERANCIER]` | Horizon 2 | Inkoop + Privacy | open |
| Pentest gepland | vóór productie | Security | open |
| Samenstelling testgroep compleet | sprint 1 | UX | open |

## Herziening

De roadmap wordt elke `[2]` sprints herzien in de Sprint Review, op basis van bewijs uit de
testgroep en van gewijzigde risico's. Wijzigingen worden hier met datum vastgelegd.

| Datum | Wijziging | Reden | Door |
|---|---|---|---|
| `[JJJJ-MM-DD]` | eerste versie | — | `[NAAM]` |
