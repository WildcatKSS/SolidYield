# Labels

Bron van waarheid: [`../../.github/labels.yml`](../../.github/labels.yml). Toepassen met
de workflow `labels-sync.yml` (handmatig te starten).

## Waarom deze set?

Labels beantwoorden vier vragen: *wat is het?* (`type:`), *hoe urgent?* (`priority:`),
*hoe risicovol?* (`risk:`) en *wat is de situatie?* (`status:`, `feedback:`). Meer labels
dan dat maakt het board onleesbaar; velden op het Projects-board zijn geschikter voor
gestructureerde gegevens.

## Verplichte labels

| Groep | Labels | Regel |
|---|---|---|
| Type | `type:epic`, `type:feature`, `type:user-story`, `type:bug`, `type:technical-task`, `type:research`, `type:security`, `type:privacy`, `type:compliance`, `type:documentation` | **precies één** per issue |
| Prioriteit | `priority:critical`, `priority:high`, `priority:medium`, `priority:low` | precies één; toegekend door de PO |
| Risico | `risk:high`, `risk:medium`, `risk:low` | verplicht vanaf *Ready for refinement* |
| Status | `status:blocked` | zolang het item geblokkeerd is; altijd met uitleg in het issue |
| Feedback | `feedback:test-group` | alles wat uit of naar de testgroep gaat |
| Instap | `good-first-issue` | klein, duidelijk afgebakend, laag risico |

## Aanbevolen aanvullingen

| Label | Gebruik |
|---|---|
| `needs:refinement` | voldoet nog niet aan de Definition of Ready |
| `needs:decision` | wacht op een besluit van PO, security, privacy of compliance |
| `needs:legal-review` | te valideren door een bevoegde juridische of compliancespecialist |
| `accessibility` | toegankelijkheidswerk (WCAG) |
| `tech-debt` | bewust genomen technische schuld |

## Prioriteitsafspraken

| Label | Betekenis | Reactie |
|---|---|---|
| `priority:critical` | gebruikers kunnen niet bij hun geld of gegevens, of er is een beveiligings-/privacyrisico | direct oppakken, desnoods het sprintdoel loslaten |
| `priority:high` | belangrijk voor het sprintdoel of een naderende deadline | deze sprint |
| `priority:medium` | waardevol, kan wachten | binnen enkele sprints |
| `priority:low` | wenselijk | wanneer er ruimte is |

## Risicoafspraken

`risk:high` wordt toegekend als het item geld, persoonsgegevens, toegang of een
regulatoire verplichting raakt. Gevolgen: twee reviews, verplichte CODEOWNERS-review,
securityverantwoordelijke betrokken bij refinement, en expliciete securitytests.

## Wat we bewust **niet** labelen

* Geen labels voor sprint, status in de flow of verantwoordelijke — dat zijn boardvelden.
* Geen componentlabels tot het team er daadwerkelijk last van heeft.
* Geen labels op basis van personen of teams.

## Gevoelige informatie

Labels zijn zichtbaar voor iedereen met leestoegang. Gebruik nooit labels die op zichzelf
al een kwetsbaarheid verraden (bijvoorbeeld `sql-injection-in-login`). Kwetsbaarheden
horen niet in publieke issues — zie [`../../SECURITY.md`](../../SECURITY.md).
