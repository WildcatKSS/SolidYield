# Developer onboarding

> **Doel:** als developer productief zijn op dag één, zonder eerst alle documentatie te
> lezen.
> **Wanneer gebruiken:** bij het aansluiten bij het team; daarna als naslag.
> **Wie:** iedereen die aan het increment werkt — ontwikkeling, UX, test, security,
> privacy, operations.
> **Adoptieniveau:** Core.
> **Gerelateerd:** [`../../CONTRIBUTING.md`](../../CONTRIBUTING.md) · [`../testing/test-strategy.md`](../testing/test-strategy.md) · [`../architecture/architecture-principles.md`](../architecture/architecture-principles.md)

---

## Dag 1 — draaiend krijgen

```bash
git clone https://github.com/[ORGANISATIE]/[REPOSITORY].git
cd [REPOSITORY]
cp .env.example .env         # lokale, niet-productie waarden
./scripts/bootstrap.sh       # detecteert de stack en installeert
./scripts/ci/all.sh          # dezelfde keten als CI, lokaal
./scripts/verify-template.sh # controleert de repository zelf
```

**Wat je in `.env` zet:** nooit echte secrets, nooit productiewaarden. `PROVIDER_MODE`
blijft `mock`. Het bestand staat in `.gitignore` en hoort daar te blijven.

**Structuur in één blik**

| Map | Wat |
|---|---|
| `src/` | applicatiecode; indeling volgt uit de stack ([`../../src/README.md`](../../src/README.md)) |
| `tests/` | unit, integration, security, accessibility, end-to-end |
| `scripts/` | bootstrap en alles wat CI draait — je kunt het lokaal aanroepen ([overzicht](../../scripts/README.md)) |
| `.github/workflows/` | CI, security, dependency review, code quality, release |
| `docs/` | procesdocumentatie ([`../README.md`](../README.md)) |

**Lees op dag 1 (± 30 min):**

1. [`../security/security-principles.md`](../security/security-principles.md) §2 — de
   concrete eisen (authenticatie, autorisatie, invoervalidatie, logging).
2. [`../scrum/definition-of-done.md`](../scrum/definition-of-done.md) — U1–U8 en de
   conditionele criteria.
3. [`../architecture/architecture-principles.md`](../architecture/architecture-principles.md)
   — de kaders waarbinnen je ontwerpt.

**Lees nog niet:** compliance-register, control matrix, auditbewijs, DPIA-sjabloon,
platform-readiness, governance. Die zijn relevant wanneer je werk ze raakt — en dan wijst
de DoD je er vanzelf naartoe.

**Vijf regels die je meteen moet kennen**

1. Geen secrets in code, logs, foutmeldingen of URL's.
2. Autorisatie serverseitig, per object — nooit vertrouwen op de client.
3. Geld nooit in floating point; afronding expliciet en getest.
4. Geen persoonsgegevens in logs of monitoring.
5. Testdata is synthetisch. Altijd.

---

## Je eerste pull request

1. **Kies een item** uit *Sprint backlog* dat aan de
   [Definition of Ready](../scrum/definition-of-ready.md) voldoet. Twijfel je? Vraag het
   in de daily — niet zelf iets anders oppakken.
2. **Branch:** `feat/12-korte-titel` (of `fix/`, `chore/`, `docs/`, `sec/`).
3. **Bouw klein en test mee.** Welke tests waar horen:
   [`../testing/test-strategy.md`](../testing/test-strategy.md).
4. **Loop de conditionele DoD langs**: raakt je wijziging UI, autorisatie, geldstromen,
   migraties, persoonsgegevens, operations of release-impact? Dan geldt het bijbehorende
   criterium (C1–C12). Wat je overslaat, licht je in één regel toe.
5. **PR-template invullen**, inclusief de security-, privacy- en compliancevelden. Koppel
   met `Relates to #12` — `Closes` sluit het issue te vroeg.
6. **CI lezen.** Wat betekent rood?

   | Job | Betekenis | Eerste actie |
   |---|---|---|
   | `build` / `lint` | code compileert of stijl klopt niet | lokaal `./scripts/ci/lint.sh` |
   | `unit-tests` / `integration-tests` | gedrag klopt niet | lokaal reproduceren |
   | `coverage` | dekking onder de drempel | test toevoegen, niet de drempel verlagen |
   | `secret-scan` | mogelijk secret gevonden | **eerst roteren**, dan opruimen |
   | `sast` | Semgrep-bevinding | oplossen; false positive expliciet onderdrukken met onderbouwing |
   | `dependency-review` | kwetsbare of niet-toegestane afhankelijkheid | alternatief of gepatchte versie |
   | `security-gate` | een verplichte securityjob is niet geslaagd | kijk welke job rood is; skipped telt óók als niet geslaagd |
   | `template-consistency` | bestand ontbreekt, YAML kapot, of action niet op SHA gepind | melding in de joblog volgen |

7. **Review verwerken.** Twee reviews en CODEOWNERS-akkoord bij gevoelige paden
   (auth, betalingen, transacties, crypto, migraties, pipeline). Reageer op elke opmerking;
   "opgelost" met een commitverwijzing volstaat.

---

## Je eerste sprint

* **Refinement:** stel vragen tot je het item snapt. Een item dat jij niet begrijpt, is
  niet Ready — dat zeggen is je werk, niet lastig doen.
* **Splitsen:** past het niet in één sprint, splits dan per stap van de gebruikersreis,
  gelukkig-pad-eerst of per variant — **niet** in "eerst backend, dan frontend"
  ([`../scrum/refinement.md`](../scrum/refinement.md) §3).
* **Risico's benoemen:** technische onzekerheid hoort in refinement op tafel, niet
  halverwege de sprint. Te veel onzekerheid? Stel een spike voor met timebox.
* **Sprint Goal:** je werkt aan het doel, niet aan "je eigen ticket". Loopt het doel
  gevaar, dan is dat een gespreksonderwerp in de daily.
* **Gebruikers observeren:** sluit aan bij een sessie wanneer je aan die functionaliteit
  werkt. Zelf zien dat iemand vastloopt, verandert meer dan een rapport.
* **Increment naar de testomgeving:** C11 uit de DoD — geverifieerd met synthetische data,
  niet alleen "het draait lokaal".

---

## Je eerste release

Je hoeft niet zelf te releasen om te snappen wat er gebeurt
([`../releases/release-process.md`](../releases/release-process.md)):

| Stap | Wat jij bijdraagt |
|---|---|
| Releasenotes | duidelijke commitberichten (Conventional Commits) — die worden de notes |
| Artifact | reproduceerbare build; geen lokale artefacten meesturen |
| SBOM | ontstaat automatisch; controleer of je nieuwe afhankelijkheid erin hoort te staan |
| Deploymentchecks | de pipeline rolt alleen uit bij een tag-push op de hoofdbranch, met de juiste variabelen |
| Rollback | elke PR met impact heeft een rollbackplan — schrijf dat vóór de merge, niet erna |
| Monitoring | wat moet er na de uitrol zichtbaar zijn als jouw wijziging misgaat? (C9) |

---

## Waar vraag ik wat?

| Vraag | Waar |
|---|---|
| "Hoe zit dit item in elkaar?" | daily of refinement |
| "Mag ik deze afhankelijkheid toevoegen?" | PR + dependency review; bij twijfel de Security Champion |
| "Is dit een securityprobleem?" | Security Champion; bij een echte kwetsbaarheid: [`../../SECURITY.md`](../../SECURITY.md), **nooit** een publiek issue |
| "Mogen we deze gegevens opslaan?" | privacyverantwoordelijke, via een compliance-/privacytaak |
| "Klopt mijn architectuurkeuze?" | tech lead; leg het vast als ADR |
| "Is dit Done?" | de DoD-checklist, niet je onderbuik |
