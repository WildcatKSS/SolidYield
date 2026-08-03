# Architectuurprincipes

> **Doel:** de kaders waarbinnen technische keuzes worden gemaakt, zodat niet elke
> discussie opnieuw bij nul begint.
> **Wanneer gebruiken:** bij ontwerp, in refinement, bij code review en bij het schrijven
> van een ADR.
> **Wie:** Developers en tech lead.
> **Adoptieniveau:** Core (principes 1–6), Advanced (de rest).
> **Gerelateerd:** [`architecture-overview.md`](architecture-overview.md) · [`adr/README.md`](adr/README.md) · [`threat-model.md`](threat-model.md) · [`../onboarding/developer-onboarding.md`](../onboarding/developer-onboarding.md)

Een principe is geen wet maar een **standaardkeuze**. Afwijken mag — maar dan met een
[ADR](adr/) waarin staat waarom, en wat je in ruil daarvoor accepteert.

---

## 1. Secure by default *(Core)*

**Definitie:** de veilige variant is de standaardinstelling; onveilig gedrag vraagt een
expliciete keuze.
**Waarom:** wat je moet aanzetten om veilig te zijn, blijft in de praktijk uit staan.
**Consequentie:** nieuwe endpoints zijn standaard afgeschermd; nieuwe velden worden
standaard niet gelogd; nieuwe integraties krijgen de smalste scope.
**Voorbeeld:** een nieuwe API-route erft de authenticatiemiddleware; je moet expliciet
`public` markeren, niet expliciet `protected`.
**Afwijken via ADR:** wanneer een publiek endpoint noodzakelijk is.

## 2. Privacy by design *(Core)*

**Definitie:** gegevens die je niet verzamelt, kunnen niet lekken.
**Waarom:** minimalisatie is de enige maatregel die 100% werkt.
**Consequentie:** elk veld verdedigt zijn bestaan; standaardinstellingen zijn de meest
privacyvriendelijke; analytics is geaggregeerd.
**Voorbeeld:** toon een categorie in plaats van de volledige omschrijving van een
tegenrekening, als de categorie het doel dient.
**Afwijken via ADR:** wanneer een nieuwe gegevenscategorie structureel nodig is — met
privacybeoordeling.

## 3. Least privilege *(Core)*

**Definitie:** iedereen en alles krijgt de minimale rechten, zo kort mogelijk.
**Waarom:** beperkt de schade wanneer iets misgaat — en er gáát iets mis.
**Consequentie:** servicetokens per functie in plaats van één almachtige sleutel;
just-in-time toegang tot productie; databasegebruikers met beperkte rechten.
**Voorbeeld:** de rapportageservice krijgt leesrechten op drie tabellen, niet op het schema.
**Afwijken via ADR:** vrijwel nooit; documenteer de compenserende maatregel.

## 4. Fail closed *(Core)*

**Definitie:** bij twijfel weigeren, niet toestaan.
**Waarom:** een fout die toegang geeft is erger dan een fout die toegang blokkeert.
**Consequentie:** valt de autorisatiecheck uit, dan is het antwoord "nee"; valt een
limietcontrole uit, dan gaat de transactie niet door.
**Voorbeeld:** de pipeline blokkeert wanneer een securityjob niet is uitgevoerd — een
overgeslagen controle telt niet als geslaagd.
**Afwijken via ADR:** alleen bij beschikbaarheidseisen die zwaarder wegen, met analyse.

## 5. Eenvoud vóór complexiteit *(Core)*

**Definitie:** kies de eenvoudigste oplossing die het probleem aantoonbaar oplost.
**Waarom:** complexiteit is een permanente kostenpost, ook nadat de reden ervoor is
verdwenen. Microservices lossen organisatieproblemen op die een klein team niet heeft.
**Consequentie:** begin met een goed gestructureerde monolith; voeg een cache, wachtrij of
service pas toe bij een gemeten knelpunt.
**Voorbeeld:** geen event bus voor twee modules die elkaar rechtstreeks kunnen aanroepen.
**Afwijken via ADR:** met de meting die de complexiteit rechtvaardigt.

## 6. Expliciete afhankelijkheden *(Core)*

**Definitie:** afhankelijkheden zijn zichtbaar, vastgezet en bewust gekozen.
**Waarom:** de toeleveringsketen is een reëel aanvalspad, en verborgen koppelingen maken
wijzigen riskant.
**Consequentie:** lockfiles committen; GitHub Actions op commit-SHA; een nieuwe bibliotheek
is een afweging (onderhoud, licentie, alternatief), geen reflex.
**Voorbeeld:** een SBOM per release, zodat je bij een nieuwe CVE binnen een uur weet of je
geraakt bent.

## 7. Defense in depth *(Advanced)*

**Definitie:** meerdere lagen; het falen van één maatregel is geen ramp.
**Waarom:** elke enkele maatregel faalt ooit.
**Consequentie:** validatie in de client én op de server; rate limiting op de rand én per
account; encryptie in transport én in rust.
**Voorbeeld:** de deployguards in de releaseworkflow staan zowel op jobniveau als als
eerste stap ín de job.

## 8. Duidelijke domeingrenzen *(Advanced)*

**Definitie:** modules hebben een eigen taal, eigen gegevens en een expliciete
buitenkant.
**Waarom:** zonder grenzen wordt elke wijziging een wijziging in alles.
**Consequentie:** domeinlogica staat los van infrastructuur; geen directe databasetoegang
over domeingrenzen heen.
**Voorbeeld:** `transactions/` levert een berekend overzicht op; `insights/` weet niets van
de databasestructuur eronder.

## 9. API first waar passend *(Advanced)*

**Definitie:** het contract komt vóór de implementatie, en wordt versiebeheerd.
**Waarom:** dwingt tot nadenken over gebruik, maakt parallel werken mogelijk en voorkomt
lekkende interne structuren.
**Consequentie:** schema vooraf, strikte validatie, expliciete versionering.
**Wanneer níét:** een intern hulpmiddel met één gebruiker — dan is dit overhead.

## 10. Observability by design *(Advanced)*

**Definitie:** je bouwt de mogelijkheid om te zien wat er gebeurt tegelijk met de
functionaliteit.
**Waarom:** monitoring die je achteraf toevoegt, mist precies wat je tijdens een incident
nodig hebt.
**Consequentie:** correlatie-ID's door alle lagen; gestructureerde logs zonder
persoonsgegevens; per functie de vraag "waaraan zie ik dat dit misgaat?".
**Voorbeeld:** DoD-criterium C9 — logging, metrics of alerts bij operationele wijzigingen.

## 11. Automatisering boven handmatige herhaling *(Advanced)*

**Definitie:** wat twee keer handmatig gebeurt, is kandidaat voor automatisering.
**Waarom:** handwerk is inconsistent, niet auditbaar en schaalt niet.
**Consequentie:** controles in de pipeline in plaats van in een checklist; infrastructuur
als code.
**Grens:** automatiseer geen proces dat je nog niet begrijpt — dan stol je een fout.

## 12. Omkeerbare beslissingen waar mogelijk *(Advanced)*

**Definitie:** kies bij twijfel de optie die je later nog kunt terugdraaien.
**Waarom:** de meeste beslissingen zijn omkeerbaar; die kun je snel nemen. De rest verdient
juist tijd.
**Consequentie:** feature flags voor onzekere functionaliteit; expand/contract bij
migraties; abstractie rond een leverancier waar realistisch.
**Voorbeeld:** eerst een adapter rond `[PROVIDER]`, zodat wisselen geen herbouw is.

## 13. Immutable en reproduceerbare deployments *(Advanced)*

**Definitie:** een artifact wordt één keer gebouwd en ongewijzigd door de omgevingen
gepromoveerd; je kunt elke release opnieuw bouwen.
**Waarom:** "werkte op staging" moet iets betekenen; en bij een incident wil je precies
weten wat er draait.
**Consequentie:** geen wijzigingen op een draaiende server; configuratie via omgeving, niet
via een aangepast artifact; rollback is een herdeploy van de vorige tag.

## 14. Minimaliseer gevoelige data in beweging *(Advanced)*

**Definitie:** houd gevoelige gegevens op zo min mogelijk plekken en zo kort mogelijk.
**Waarom:** elke kopie is een extra plek die kan lekken en die je moet opruimen.
**Consequentie:** geen gevoelige gegevens in caches, wachtrijen, logs, exports of
foutmeldingen zonder noodzaak; korte TTL's; verwijderroutines die aantoonbaar draaien.

---

## Hoe gebruik je deze principes?

* **In refinement:** botst een oplossing met een principe? Dan is dat een gespreksonderwerp,
  geen detail voor later.
* **In code review:** verwijs naar het nummer ("dit botst met principe 4, fail closed").
* **In een ADR:** de sectie *Besliscriteria* verwijst naar de principes die meewegen; wijk
  je af, dan staat dat expliciet onder *Negatieve gevolgen*.
* **In de retrospective:** merk je dat een principe structureel niet werkt, pas het dan aan
  in plaats van het stilzwijgend te negeren.

**Herziening:** minimaal jaarlijks, en telkens wanneer een ADR van een principe afwijkt.
