# Security Champions

> **Doel:** securitykennis binnen de Developers verspreiden, zonder de onafhankelijke
> Security Officer te vervangen.
> **Wanneer gebruiken:** zodra het team groter is dan twee of drie mensen en security niet
> meer vanzelf in elk gesprek meeloopt.
> **Wie:** een developer die deze taak op zich neemt, plus de Security Officer.
> **Adoptieniveau:** Advanced (in Core mag het informeel).
> **Gerelateerd:** [`secure-development-lifecycle.md`](secure-development-lifecycle.md) · [`../scrum/roles.md`](../scrum/roles.md) · [`../architecture/epic-threat-checklist.md`](../architecture/epic-threat-checklist.md)

---

## 1. Wat het wel en niet is

Een Security Champion is een **developer met extra securityfocus**. Dat is vakexpertise
binnen de Developers — **geen vierde Scrum-accountability** en geen functie met een eigen
mandaat.

| | Security Champion | Security Officer |
|---|---|---|
| Positie | binnen de Developers (Scrum Team) | governance, onafhankelijk van het team |
| Doet | meebouwen, meedenken, kennis verspreiden | kaders stellen, onafhankelijk beoordelen |
| Beslist over | niets formeels; adviseert en signaleert | securityeisen; een openstaande kritieke/hoge bevinding blokkeert de release |
| Accepteert risico | **nee** | kritiek/hoog: nee (dat gaat naar de mandaathouder); overige binnen mandaat |
| Verantwoordelijk voor | dat security zichtbaar is in het werk | dat security aantoonbaar geborgd is |

> **De valkuil:** de Champion wordt "de security-persoon" en de rest van het team stopt met
> nadenken. Dat is precies het tegenovergestelde van het doel. De hele groep Developers
> blijft verantwoordelijk voor de securitycriteria in de Definition of Done.

## 2. Selectie en roulatie

* **Vrijwillig**, niet aangewezen. Interesse werkt beter dan een aanstelling.
* **Eén Champion per team**; bij meer dan acht developers eventueel twee.
* **Roulatie elke `[6]` maanden** — dat verspreidt de kennis en voorkomt afhankelijkheid
  van één persoon. Draag over met een korte overdrachtsnotitie.
* **Tijdsbeslag:** richtlijn `[4]` uur per sprint van twee weken. Staat dat structureel
  onder druk, dan is dat een belemmering voor de Scrum Master — geen reden om het stil te
  laten vallen.

## 3. Verantwoordelijkheden

| Wel | Niet |
|---|---|
| meedenken bij refinement over misbruikscenario's | securityrisico's formeel accepteren |
| helpen securityacceptatiecriteria te formuleren | het enige teamlid zijn dat securitywerk doet |
| scanresultaten uitleggen en helpen prioriteren | scanbevindingen zelfstandig onderdrukken zonder onderbouwing |
| veilige patronen delen (voorbeelden, code review) | een eigen goedkeuringsstempel vormen naast de DoD |
| bewaken dat securitytaken zichtbaar in de backlog staan | de backlog prioriteren (dat doet de PO) |
| threat modelling per epic begeleiden | de rol van pentester of auditor vervullen |
| securityonderwerpen inbrengen in de retrospective | de Security Officer vervangen |

## 4. Activiteiten per ritme

**Elke sprint**

* aanwezig bij refinement wanneer een item security-impact heeft;
* nieuwe scanbevindingen doornemen en vertalen naar backlogitems of een fix;
* meelezen op pull requests die gevoelige paden raken (samen met CODEOWNERS).

**Per epic**

* de [epic-threat-checklist](../architecture/epic-threat-checklist.md) doorlopen met het
  team en de tech lead;
* daaruit securityacceptatiecriteria en `tests/security/`-tests laten volgen.

**Per maand of kwartaal**

* kort kennismoment (30 minuten): één patroon, één recente bevinding, één les;
* controleren of openstaande kwetsbaarheden binnen de SLA blijven
  ([`vulnerability-management.md`](vulnerability-management.md));
* bijdragen aan een securityretrospective: welke signalen hebben we gemist, en waarom?

## 5. Escalatie

| Situatie | Actie |
|---|---|
| Kritieke of hoge kwetsbaarheid | direct naar de Security Officer; volg de SLA's uit [`vulnerability-management.md`](vulnerability-management.md) |
| Vermoeden van actief misbruik of datalek | **onmiddellijk** melden via [`incident-response.md`](incident-response.md), inclusief privacy zodra persoonsgegevens in beeld zijn; wacht niet op bevestiging of eigen onderzoek |
| Gelekt secret | eerst roteren, dan opruimen, dan melden |
| Twijfel over acceptabel restrisico | **niet zelf beslissen** → risicoacceptatie volgens [`../../GOVERNANCE.md`](../../GOVERNANCE.md) §4 |
| Structureel te weinig tijd voor securitywerk | Scrum Master (belemmering), niet stilzwijgend accepteren |

## 6. Hoe weet je of het werkt?

Niet aan het aantal gevonden kwetsbaarheden — dat zegt evenveel over de scanner als over
het team. Wel aan:

* securitytaken staan zichtbaar in de sprint, niet alleen in de documentatie;
* misbruikscenario's komen in refinement ter sprake vóórdat er code is;
* het aantal bevindingen dat pas in de pipeline wordt gevonden, daalt;
* meer dan één teamlid kan een scanresultaat uitleggen.

## 7. Invulling

| Veld | Waarde |
|---|---|
| Huidige Security Champion | `[NAAM]` |
| Sinds | `[JJJJ-MM-DD]` |
| Roulatie gepland | `[JJJJ-MM-DD]` |
| Security Officer (governance) | `[NAAM]` |
| Tijdsbeslag per sprint | `[4]` uur |
