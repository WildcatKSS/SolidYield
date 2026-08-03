# Persona's

Persona's zijn **onderzoeksgebaseerde samenvattingen**, geen verzonnen personages. Zolang
er geen onderzoek is, staan ze hier als **aanname** en zijn ze als zodanig gemarkeerd.

> Alle gegevens hieronder zijn fictief. Neem nooit echte gegevens, foto's of citaten met
> herleidbare informatie van deelnemers op.

## Persona A — `[PERSONA-A]` *(status: aanname, te valideren in sprint 1–2)*

| Veld | Invulling |
|---|---|
| Korte typering | `[BIJV. "Houdt overzicht, maar mist grip op onverwachte uitgaven"]` |
| Levensfase / context | `[CONTEXT]` |
| Financiële situatie | `[BIJV. wisselend inkomen, kleine buffer]` |
| Doelen | `[DOEL 1]`, `[DOEL 2]` |
| Frustraties | `[FRUSTRATIE 1]`, `[FRUSTRATIE 2]` |
| Digitale vaardigheid | laag / gemiddeld / hoog |
| Vertrouwen in financiële apps | laag / gemiddeld / hoog |
| Toegankelijkheidsbehoeften | `[BIJV. groter lettertype, kleurenblindheid, schermlezer]` |
| Belangrijkste taak in ons product | `[TAAK]` |
| Waarom zou deze persoon afhaken? | `[AFHAAKREDEN]` |
| Bewijs | `[INTERVIEWS Pn, DATA, DESK RESEARCH]` — **nog te verzamelen** |

## Persona B — `[PERSONA-B]` *(status: aanname)*

| Veld | Invulling |
|---|---|
| Korte typering | `[TYPERING]` |
| Doelen | `[DOELEN]` |
| Frustraties | `[FRUSTRATIES]` |
| Belangrijkste taak | `[TAAK]` |
| Bewijs | **nog te verzamelen** |

## Persona C — `[PERSONA-C]` *(status: aanname)*

| Veld | Invulling |
|---|---|
| Korte typering | `[TYPERING]` |
| Doelen | `[DOELEN]` |
| Frustraties | `[FRUSTRATIES]` |
| Belangrijkste taak | `[TAAK]` |
| Bewijs | **nog te verzamelen** |

## Interne persona's

| Persona | Behoefte | Waarom relevant |
|---|---|---|
| Supportmedewerker | snel kunnen zien wat er misging, zonder onnodige toegang tot gegevens | bepaalt autorisatiemodel en auditlogging |
| Beheerder | veilig configureren, vier-ogenprincipe | bepaalt rollen en rechten |
| Auditor / toezicht | aantoonbaarheid van controls | bepaalt bewijsvoering |

## Kwetsbare gebruikers

Bij een financiële dienst verdienen sommige gebruikers extra aandacht. Neem dit mee in
elke story met financiële informatie:

* mensen met betalingsproblemen of schulden — vermijd schaamte en drang;
* laaggeletterden — taalniveau B1, geen jargon;
* mensen met een visuele, motorische of cognitieve beperking — WCAG 2.2 AA;
* ouderen en digitaal minder vaardige gebruikers — voorspelbare, rustige interactie;
* mensen die onder druk staan of slachtoffer zijn van dwang/fraude — bied altijd een
  veilige uitweg en heldere hulpinformatie.

## Anti-persona's

Wie bedienen we bewust **niet**, en welke misbruikers moeten we juist tegenhouden?

| Anti-persona | Waarom niet | Consequentie |
|---|---|---|
| `[NIET-DOELGROEP]` | `[REDEN]` | scope, marketing |
| Fraudeur / accountovernemer | misbruik van geld en gegevens | zie [`../architecture/threat-model.md`](../architecture/threat-model.md) |
| Scriptmatige misbruiker (bots) | schaalbaar misbruik | rate limiting, botdetectie |
