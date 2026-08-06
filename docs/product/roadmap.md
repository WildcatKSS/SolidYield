# Roadmap

Deze roadmap is **op resultaat gericht**, niet op datums met vaste functionaliteit. Hij
beschrijft welk probleem we wanneer willen oplossen en welke onzekerheid we dan hebben
weggenomen. Alles na de huidige horizon is een intentie, geen belofte.

> **Sprintnummers in dit document verwijzen naar sprints van twee weken** (besluit 6,
> [`../scrum/scrum-guide.md`](../scrum/scrum-guide.md) §2). Een horizon van vier sprints
> beslaat dus ongeveer acht weken. Dat is een **ordegrootte, geen toezegging**: de
> roadmap blijft op resultaat gericht en er is geen releasedatum vastgelegd.

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
| Increment | bèta → **besloten testgroep** als eerste gecontroleerde productie-uitrol |
| Onderwerpen | betrouwbaarheid van gegevens, meldingen, support, monitoring, pentest, DPIA afgerond |
| Validatie | besloten testgroep van **maximaal tien uitgenodigde deelnemers** met echte gegevens en echte geldstromen ([`closed-test-group.md`](closed-test-group.md)) |
| Klaar wanneer | de afrondingscriteria uit `closed-test-group.md` §9 zijn gehaald: MVP functioneel compleet, geen kritieke defects, alle functionaliteit gevalideerd, akkoord van Compliance en een Go-besluit van de Product Owner |
| Voorwaarde | **regulatoire toets afgerond en bevestigd door een bevoegde specialist**, plus de volledige Go/No-Go-lijst uit `closed-test-group.md` §10 |

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
| ~~Keuze technologiestack en cloud~~ | sprint 1 | Tech lead | ✅ **besloten 2026-08-05** — [ADR-0002](../architecture/adr/0002-technologiestack.md) en [ADR-0003](../architecture/adr/0003-cloudprovider.md) |
| **Vergunningstraject** — de vereiste vergunning of een andere rechtsgeldige toestemming van de bevoegde toezichthouder (besluit 4A; RD-23 t/m RD-27) | vóór echte klantgelden en productiegebruik | PO + Compliance | **strategie besloten**, traject open — **blokkerend** |
| Juridisch advies over het rendementproduct in Nederland (RD-01) | Horizon 2 | Compliance | open |
| Contract en DPA met `[LEVERANCIER]` | Horizon 2 | Inkoop + Privacy | open |
| Pentest gepland | vóór productie | Security | open |
| ~~Samenstelling besloten testgroep~~ | sprint 1 | Product Owner | ✅ **besloten 2026-08-05** — maximaal 10 uitgenodigde deelnemers ([`closed-test-group.md`](closed-test-group.md)) |
| Werving en spreiding voor de **onderzoekssessies** (synthetische data) | sprint 1 | UX | open |

## Herziening

De roadmap wordt elke **2 sprints** — dus ongeveer elke vier weken — herzien in de Sprint
Review, op basis van bewijs uit de testgroep en van gewijzigde risico's. Wijzigingen worden
hier met datum vastgelegd.

| Datum | Wijziging | Reden | Door |
|---|---|---|---|
| `[JJJJ-MM-DD]` | eerste versie | — | `[NAAM]` |
