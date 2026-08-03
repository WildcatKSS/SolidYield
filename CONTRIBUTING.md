# Bijdragen

Dank voor je bijdrage aan SolidYield. Dit is een financiële dienst: kwaliteit,
security, privacy en traceerbaarheid wegen zwaarder dan snelheid.

## 1. Voordat je begint

* Lees [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) en [`SECURITY.md`](SECURITY.md).
* Kwetsbaarheid gevonden? **Geen issue openen** — volg [`SECURITY.md`](SECURITY.md).
* Werk alleen aan items die in **Sprint backlog** staan en aan de
  [Definition of Ready](docs/scrum/definition-of-ready.md) voldoen. Zie je iets anders?
  Maak een issue aan; de Product Owner prioriteert.

## 2. Issues

Gebruik altijd een Issue Form uit [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/):
user story, bug report, technical task, security issue (alleen niet-gevoelig),
compliance task, research spike, epic, feature of testgroepfeedback.
Labels volgen [`docs/scrum/labels.md`](docs/scrum/labels.md).

## 3. Branches

| Prefix | Gebruik |
|---|---|
| `feat/` | nieuwe functionaliteit |
| `fix/` | bugfix |
| `chore/` | onderhoud, tooling |
| `docs/` | documentatie |
| `sec/` | securityverbetering |
| `refactor/` | herstructurering zonder gedragswijziging |
| `spike/` | tijdgebonden onderzoek |

Formaat: `feat/123-transactieoverzicht-filter`. Werk nooit direct op `main`.

## 4. Commits

[Conventional Commits](https://www.conventionalcommits.org/):

```
feat(dashboard): toon maandsaldo per categorie

Relates to #123
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`,
`chore`, `revert`. `feat!:` of een `BREAKING CHANGE:`-voetnoot betekent een major-release.
Onderteken commits (`git commit -S`) zodra commit signing verplicht is gesteld.

## 5. Pull requests

1. Vul het [PR-template](.github/PULL_REQUEST_TEMPLATE.md) volledig in — ook de
   security-, privacy- en compliancevelden. "n.v.t." mag, maar dan met één regel uitleg.
2. Koppel het issue met `Relates to #123`. Gebruik `Closes #123` **alleen** wanneer de
   merge het werk aantoonbaar volledig afrondt — anders sluit het issue vóórdat de
   Definition of Done is gehaald en springt het item te vroeg naar een eindstatus
   ([`docs/scrum/project-board.md`](docs/scrum/project-board.md#gebruik-van-sluitwoorden-in-pull-requests)).
3. Houd PR's klein (richtlijn: < 400 gewijzigde regels).
4. Alle verplichte checks moeten slagen; merge is geblokkeerd bij een falende kritieke
   kwaliteits- of securitycheck.
5. Minimaal 1 goedkeurende review; **2 reviews** bij wijzigingen aan authenticatie,
   autorisatie, betaal-/transactielogica, persoonsgegevens, cryptografie, migraties of
   pipelineconfiguratie.
6. CODEOWNERS-review is verplicht voor de paden in [`.github/CODEOWNERS`](.github/CODEOWNERS).
7. Squash merge. De PR-titel wordt de changelogregel.

## 6. Reviewcriteria

Reviewers letten op: klopt het met de acceptatiecriteria · leesbaarheid en onderhoud ·
tests op het juiste niveau · invoervalidatie en autorisatie · geen gevoelige gegevens in
logs, foutmeldingen of URL's · geen secrets in code · afhankelijkheden verantwoord ·
foutafhandeling · observability · documentatie bijgewerkt · universele DoD-criteria
afgevinkt en elk overgeslagen conditioneel criterium onderbouwd.

## 7. Testen

```bash
./scripts/ci/all.sh   # build, lint, unit, integratie, coverage, security, a11y
```

Nieuwe functionaliteit zonder tests wordt niet gemerged. Gebruik uitsluitend synthetische
testdata ([`docs/privacy/data-classification.md`](docs/privacy/data-classification.md)).

## 8. Documentatie

Wijzig je gedrag, API, datamodel of infrastructuur, werk dan de bijbehorende documentatie
bij. Belangrijke technische keuzes leg je vast als ADR in
[`docs/architecture/adr/`](docs/architecture/adr/).

## Branch protection

Adviesconfiguratie voor `main` (*Settings → Branches → Add rule*, of een ruleset):

* [x] Require a pull request before merging
* [x] Require approvals: **1** (**2** voor gevoelige paden, via CODEOWNERS-teams)
* [x] Dismiss stale pull request approvals when new commits are pushed
* [x] Require review from Code Owners
* [x] Require status checks to pass before merging, met als verplichte checks:
  `build`, `lint`, `unit-tests`, `integration-tests`, `coverage`, `secret-scan`,
  `sast`, `dependency-review`, `license-check`, `accessibility`
* [x] Require branches to be up to date before merging
* [x] Require conversation resolution before merging
* [x] Require signed commits *(zodra alle teamleden sleutels hebben — zie ADR)*
* [x] Require linear history
* [x] Block force pushes
* [x] Restrict deletions
* [x] Do not allow bypassing the above settings (ook niet voor admins)
* [ ] Restrict who can push to matching branches — alleen als het team dat nodig heeft

Aanvullend: productie-deployments lopen via een GitHub **Environment** `production` met
*required reviewers* en beperkte secrets; zie
[`docs/operations/deployment.md`](docs/operations/deployment.md).
