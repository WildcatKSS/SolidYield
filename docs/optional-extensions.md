# Optionele uitbreidingen

> **Doel:** zicht houden op wat je bewust nog niet hebt ingebouwd.
> **Wanneer gebruiken:** bij de overgang naar een hoger [adoptieniveau](adoption-levels.md).
> **Wie:** Developers en tech lead.
> **Gerelateerd:** [`adoption-levels.md`](adoption-levels.md)

Deze template is bewust een **minimale maar werkende** versie: alles wat erin zit, wordt
vanaf sprint 1 gebruikt. Onderstaande uitbreidingen zijn nuttig, maar voegen complexiteit
toe die je pas wilt betalen als je er iets voor terugkrijgt.

Volgorde per blok: van "meestal snel de moeite waard" naar "alleen bij aantoonbare behoefte".

## 1. Proces en backlog

| Uitbreiding | Wat het oplevert | Wanneer |
|---|---|---|
| GitHub Projects-automatisering met `actions/add-to-project` | items komen automatisch op het board, met velden voorgevuld | zodra het board dagelijks wordt gebruikt |
| Issue-sjablonen voor incidenten en post-mortems | uniforme incidentafhandeling | na het eerste incident |
| Sprintrapport-workflow (velocity, doorlooptijd, ontsnapte defecten) | objectieve retro-input | vanaf sprint 4 |
| Automatische stale-issuebot | schone backlog | bij > 200 open issues |
| Roadmapweergave met iteraties | zicht op de lange lijn | bij meerdere epics parallel |

## 2. Kwaliteit en tests

| Uitbreiding | Wat het oplevert | Wanneer |
|---|---|---|
| Mutatietesten (bijv. Stryker, mutmut) | meet of tests écht iets aantonen | als dekking hoog is maar bugs blijven |
| Contracttesten (Pact) tussen services of met `[PROVIDER]` | voorkomt integratiebreuk | bij meerdere teams of services |
| Prestatie-/belastingtests (k6, Gatling) in CI | bewaakt latency-SLO's | vóór bredere uitrol |
| Visuele regressietests | voorkomt onbedoelde UI-wijzigingen | bij een volwassen designsysteem |
| Property-based tests op financiële berekeningen | vindt randgevallen in afronding en valuta | zodra er rekenlogica is — **sterk aanbevolen** |
| Reconciliatiecontroles (som van delen = totaal) | detecteert stille rekenfouten | zodra bedragen worden getoond |

## 3. Security

| Uitbreiding | Wat het oplevert | Wanneer |
|---|---|---|
| SLSA-provenance en ondertekende artifacts (Sigstore/cosign) | aantoonbare herkomst van builds | vóór productie |
| Dependabot ook op de SHA-pins van actions laten draaien | pins blijven actueel zonder handwerk (actief: `.github/dependabot.yml`) | al ingericht |
| Verplichte commit signing | herkomst van code | zodra alle teamleden sleutels hebben |
| DAST in de pipeline (OWASP ZAP tegen staging) | vindt runtime-problemen | zodra staging stabiel is |
| Runtime-bescherming / WAF-regels als code | blokkeert misbruik vroeg | vóór productie |
| Bug bounty of gestructureerd disclosureprogramma | externe blik | na de eerste productie-uitrol |
| Secret scanning met push protection op organisatieniveau | voorkomt lekken vóór de push | direct, als GitHub-plan het toestaat |
| Chaos-/faalinjectie op koppelingen | test degradatie echt | na de eerste storing |

## 4. Privacy en compliance

| Uitbreiding | Wat het oplevert | Wanneer |
|---|---|---|
| Verwerkingsregister als gestructureerd bestand (YAML) met validatie in CI | actueel register zonder handwerk | bij > 10 verwerkingen |
| Geautomatiseerde controle op bewaartermijnen (job + alarm) | termijnen worden echt uitgevoerd | zodra er productiedata is |
| Policy as code (OPA/Conftest) op infrastructuur | voorkomt onveilige configuratie | bij infrastructure as code |
| Bewijsverzameling automatiseren (workflowruns → bewijsregister) | minder handwerk bij audits | vóór de eerste audit |
| Toegankelijkheidsaudit door een externe partij | onafhankelijke bevestiging | vóór algemene beschikbaarheid |

## 5. Operatie

| Uitbreiding | Wat het oplevert | Wanneer |
|---|---|---|
| Statuspagina voor gebruikers | minder supportvragen bij storing | vóór productie |
| Foutbudget-dashboard | maakt de afweging tempo/stabiliteit zichtbaar | na de eerste maand meten |
| Automatische rollback op basis van metrieken | sneller herstel | bij frequente releases |
| Multi-regio uitwijk | hogere beschikbaarheid | alleen bij een harde eis (duur) |
| On-call-rooster met escalatiematrix | betrouwbare reactie buiten kantoortijd | vóór productie |

## 6. Ontwikkelervaring

| Uitbreiding | Wat het oplevert | Wanneer |
|---|---|---|
| Devcontainer / Nix / Docker Compose voor lokale omgeving | iedereen start identiek | zodra de stack vaststaat |
| Pre-commit hooks (lint, format, secret scan) | fouten vóór de push | direct na stackkeuze |
| `Makefile` of `just` als eenduidige taakrunner | één ingang voor alle commando's | bij meer dan 10 scripts |
| Automatische changeloggeneratie uit Conventional Commits | minder handwerk bij releases | zodra releases regelmatig zijn |
| Monorepo-tooling | schaalbaarheid bij meerdere pakketten | alleen bij meerdere componenten |

## 7. Bewust **niet** opgenomen

| Niet opgenomen | Waarom |
|---|---|
| Microservices-opzet vanaf dag één | lost een organisatieprobleem op dat dit team nog niet heeft; verhoogt security- en operationele complexiteit |
| Zware compliance-automatisering vóór de eerste regel code | je weet nog niet welk regime geldt (RD-01 staat open) |
| Uitgebreide analytics en experimentplatform | verleidt tot meten van het verkeerde; begin met usabilitytests |
| Kubernetes vanaf de MVP | vaak zwaarder dan nodig; kies op basis van een aangetoonde behoefte |
| Meertaligheid vanaf de start | verdubbelt contentwerk vóór productmarktfit |
| Eigen authenticatie-implementatie | onnodig risico; besteed uit tenzij er een dwingende reden is |

## Hoe voeg je iets toe?

1. Maak een issue met de reden: welk probleem lost dit op, en hoe weten we dat het werkt?
2. Weeg het als elk ander backlogitem (visie, impact, risico, haalbaarheid).
3. Raakt het architectuur of security: schrijf een ADR.
4. Werk deze lijst bij zodat de volgende keer duidelijk is waarom iets er wél of niet is.
