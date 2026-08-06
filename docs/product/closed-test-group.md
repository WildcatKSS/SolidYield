# Besloten testgroep — eerste gecontroleerde productie-uitrol

> **Doel:** de inrichting van de eerste besloten testgroep vastleggen.
> **Wanneer gebruiken:** bij het voorbereiden, starten, uitvoeren en afronden van de
> besloten test.
> **Wie:** Product Owner, met Compliance, Security, Privacy en Ops.
> **Adoptieniveau:** Regulated.
> **Gerelateerd:** [`mvp-scope.md`](mvp-scope.md) · [`../research/test-group-plan.md`](../research/test-group-plan.md) · [`../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md`](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md)

* **Besluit 7** · **Eigenaar:** Product Owner · **Status:** ✅ **besloten 2026-08-05**

> [!IMPORTANT]
> **De besloten testgroep start uitsluitend nadat de wettelijke grondslag uit besluit 4 is
> bevestigd.** Tot dat moment blijven de beperkingen uit besluit 4 **onverkort** van kracht:
> geen echte klantgelden, geen bindende rendementcontracten, geen werkelijke
> rendementuitkeringen en geen productiegebruik.
>
> **Dit besluit wijzigt besluit 4 niet.** Besluit 4 bepaalt *dat* deze activiteiten vóór
> bevestiging van de wettelijke grondslag niet zijn toegestaan. Besluit 7 beschrijft
> uitsluitend *hoe* de eerste gecontroleerde uitrol eruitziet **ná** die bevestiging. De
> wettelijke kwalificatie zelf blijft volledig open en wordt vastgesteld door Compliance en
> een gespecialiseerde financieel-regulatoire jurist (RD-23 t/m RD-27, controls C-27 t/m
> C-31).

## 0. Twee dingen die allebei "testgroep" heten

De term *testgroep* dekt in deze repository **twee verschillende activiteiten**. Ze mogen
niet door elkaar lopen, omdat de ene met synthetische data werkt en de andere met echte
persoonsgegevens.

| | **Onderzoekssessies** ([`../research/test-group-plan.md`](../research/test-group-plan.md)) | **Besloten testgroep** (dit document, besluit 7) |
|---|---|---|
| Wat het is | interviews, prototypetests, usabilitytests | eerste gecontroleerde **productie**-uitrol |
| Omgeving | **testomgeving** | **productieomgeving** |
| Data | **uitsluitend synthetisch** | **echte persoonsgegevens**, echte KYC |
| Geldstromen | geen | echt, ná bevestiging van de wettelijke grondslag |
| Wanneer | doorlopend vanaf sprint 1 | pas ná de Go/No-Go in §10 |
| Voorwaarde | toestemming per sessie | volledige Go/No-Go-lijst |

> ⚠️ Besluit 7 verruimt **niets** aan de regel dat er nooit echte persoonsgegevens of
> productiedata in de test-, ontwikkel- of demo-omgeving staan. Die regel blijft
> onverkort gelden (DoD-criterium U5, dreigingen T-17 en T-27,
> [ADR-0003](../architecture/adr/0003-cloudprovider.md)). Sandboxgegevens zijn uitsluitend
> toegestaan voor interne ontwikkel- en acceptatietesten **buiten** de besloten testgroep.

## 1. Doel van de besloten testgroep

De besloten testgroep valideert:

| # | Doel |
|---|---|
| 1 | de **volledige gebruikerservaring** |
| 2 | de **technische werking** van de MVP |
| 3 | de **commerciële bruikbaarheid** |
| 4 | de **operationele processen** |
| 5 | de **supportprocessen** |
| 6 | de **complianceprocessen** |
| 7 | de **beheerprocessen** in de praktijk |

Dit is dus geen usabilityronde met een nieuwe naam: het is de eerste keer dat het hele
systeem — product, techniek, support, compliance en beheer — in samenhang onder echte
omstandigheden draait.

## 2. Samenstelling

| Onderwerp | Invulling |
|---|---|
| **Omvang** | **maximaal tien deelnemers** |
| **Samenstelling** | oprichters · ontwikkelaars · familie · vrienden · persoonlijk uitgenodigde bekenden |
| **Toelating** | **uitsluitend op uitnodiging** van SolidYield |
| **Open inschrijving** | **maakt geen onderdeel uit van de MVP** |

Een groep van maximaal tien mensen is klein genoeg om elke deelnemer persoonlijk te
begeleiden en elke transactie handmatig te kunnen narekenen. Dat is bij een eerste echte
geldstroom geen luxe.

> **Gevolg voor het onderzoek:** deze samenstelling is bewust **niet representatief** voor
> de doelgroep. Bevindingen uit de besloten testgroep zeggen iets over werking en
> betrouwbaarheid, en **weinig tot niets** over adoptie, begrijpelijkheid voor
> buitenstaanders of marktvraag. Dat blijft het werk van de onderzoekssessies uit
> [`../research/test-group-plan.md`](../research/test-group-plan.md), met de daar
> vastgelegde spreiding en toegankelijkheidseisen.

## 3. Functionaliteit

* Functionaliteit wordt **gefaseerd per sprint** beschikbaar gesteld.
* **Niet iedere deelnemer hoeft op hetzelfde moment toegang te hebben** tot alle
  functionaliteit.
* Nieuwe functionaliteit wordt **uitsluitend vrijgegeven nadat deze voldoet aan de
  [Definition of Done](../scrum/definition-of-done.md)**.

## 4. Persoonsgegevens en KYC

De besloten testgroep gebruikt:

* **echte persoonsgegevens**;
* de **volledige KYC-procedure**;
* **echte identificatie**;
* **echte verificatie**.

**Gebruik van sandboxgegevens is alleen toegestaan voor interne ontwikkel- en
acceptatietesten buiten deze besloten testgroep.**

Omdat hier voor het eerst echte persoonsgegevens van echte betrokkenen worden verwerkt,
gelden onverkort: grondslag per verwerking, dataminimalisatie, bewaartermijnen, de rechten
van betrokkenen en de DPIA — zie [`../privacy/`](../privacy/) en de controls C-03 t/m C-08.
Dat een deelnemer familie of bekende is, verandert daar niets aan.

## 5. Financiële transacties

Nadat de wettelijke grondslag is bevestigd, mogen deelnemers:

* daadwerkelijk **geld storten**;
* daadwerkelijke **rendementcontracten sluiten**;
* daadwerkelijke **maandelijkse rendementuitkeringen** ontvangen;
* aan het einde van de looptijd de **nominale inleg terugontvangen**.

> **Dit is geen wijziging van besluit 4.** Besluit 4 bepaalt uitsluitend dat deze
> activiteiten **vóór** bevestiging van de wettelijke grondslag niet zijn toegestaan.
> Besluit 7 beschrijft de eerste gecontroleerde uitrol **ná** die bevestiging. De
> productparameters, de geldstroom, de contractstroom en de rolverdeling in de keten blijven
> exact zoals vastgelegd in [ADR-0007](../architecture/adr/0007-vergunningplicht-en-rol-in-de-keten.md)
> en [ADR-0008](../architecture/adr/0008-geld-en-contractstroom.md).

Deelnemers zijn vanaf dat moment **echte klanten met een echte vordering op SolidYield**.
De risico's die voor iedere klant gelden — debiteurenrisico, de positie als concurrent
schuldeiser bij faillissement (RD-20, RD-21) — gelden onverkort voor hen, en worden vóór
deelname op dezelfde manier gecommuniceerd als aan iedere andere klant.

## 6. Support

| Kanaal | Status |
|---|---|
| **E-mail** | onderdeel van de MVP |
| **WhatsApp** | onderdeel van de MVP |
| **Ingebouwde feedbackfunctie** | onderdeel van de MVP |
| Sociale media en openbare kanalen | **geen onderdeel van de MVP** |

**Alle feedback wordt geregistreerd in het centrale ticketsysteem.** Ook wat via WhatsApp
of informeel binnenkomt: een melding die alleen in een chat staat, bestaat voor het proces
niet. Zie [`../../SUPPORT.md`](../../SUPPORT.md) en
[`../research/feedback-log.md`](../research/feedback-log.md).

> **Aandachtspunt voor Privacy:** WhatsApp als supportkanaal betekent verwerking van
> persoonsgegevens via een derde partij. Grondslag, verwerkersrelatie, doorgifte en
> bewaartermijn moeten vóór de start zijn beoordeeld en vastgelegd (C-33).

## 7. Vertrouwelijkheid

Deelnemers accepteren vooraf minimaal de **privacyverklaring**.

Daarnaast geldt:

> Deelnemers mogen zonder voorafgaande schriftelijke toestemming van SolidYield geen
> screenshots, video's, schermopnamen of andere informatie over de besloten test openbaar
> maken.

**Reikwijdte.** Deze vertrouwelijkheid heeft **uitsluitend** betrekking op niet-openbare
informatie over de besloten test en doet **geen afbreuk aan toepasselijke wettelijke rechten
van deelnemers** — waaronder hun rechten als betrokkene onder de AVG, het recht om een
melding te doen bij een toezichthouder, en het recht om misstanden aan de orde te stellen.

## 8. Beëindiging van deelname

Een deelnemer wordt uit de besloten testgroep verwijderd:

* **op eigen verzoek**;
* bij **misbruik**;
* bij **overtreding van de voorwaarden**.

**De Product Owner neemt hierover het besluit.**

> Beëindiging van *deelname* is niet hetzelfde als beëindiging van een *lopend
> rendementcontract*. Wat er gebeurt met een lopend contract van een verwijderde deelnemer,
> volgt uit de contractvoorwaarden en niet uit dit besluit; vastzetten is onomkeerbaar tot
> de einddatum (ADR-0008). Dit punt wordt vóór de start uitgewerkt in de
> contractvoorwaarden — zie vervolgactie 3.

## 9. Afronding

De besloten testgroep is **succesvol afgerond** wanneer:

| # | Voorwaarde |
|---|---|
| 1 | de MVP **functioneel compleet** is |
| 2 | er **geen kritieke defects** meer openstaan |
| 3 | **alle MVP-functionaliteit is gevalideerd** |
| 4 | **Compliance akkoord geeft** voor de volgende fase |
| 5 | de **Product Owner een Go-besluit** neemt |

**De Product Owner beslist over de overgang naar een bredere uitrol.** Dit besluit gaat
niet over publieke bèta of algemene marktintroductie; die blijven onderwerp van latere
besluiten.

### Testaccounts na afloop

Iedere deelnemer kiest na afloop tussen:

1. **omzetting** van het testaccount naar een productieaccount, voor zover **technisch,
   juridisch en operationeel verantwoord**; of
2. **beëindiging** van het account.

Bij beëindiging worden persoonsgegevens bewaard of verwijderd overeenkomstig:

* de **AVG**;
* **wettelijke bewaartermijnen**;
* het **privacybeleid**;
* overige toepasselijke regelgeving.

Zie [`../privacy/data-retention.md`](../privacy/data-retention.md). Welke termijnen precies
gelden, is nog **te valideren door een bevoegde specialist** (C-04, besluit 9).

## 10. Go/No-Go voor start van de besloten testgroep

De besloten testgroep mag **uitsluitend starten** wanneer aan **alle** onderstaande
voorwaarden is voldaan:

| # | Voorwaarde | Bewijs |
|---|---|---|
| 1 | **Besluiten 1 tot en met 8 zijn vastgesteld** | besluitentabel in [`../../README.md`](../../README.md) §10 |
| 2 | **De wettelijke grondslag uit besluit 4 is bevestigd** | RD-23 t/m RD-27; controls C-27 t/m C-31 |
| 3 | **De MVP voldoet aan de [Definition of Done](../scrum/definition-of-done.md)** | groene CI, DoD-verantwoording per item |
| 4 | **Alle kritieke en hoge beveiligingsbevindingen zijn opgelost of formeel geaccepteerd** | security-gate; [`../security/vulnerability-management.md`](../security/vulnerability-management.md); risicoacceptatie volgens [`../../GOVERNANCE.md`](../../GOVERNANCE.md) §4 |
| 5 | **Een succesvolle hersteltest van back-up en disaster recovery is uitgevoerd** | C-12; [`../operations/backup-and-recovery.md`](../operations/backup-and-recovery.md) |

> **Dit is een operationele vrijgavevoorwaarde, geen wijziging van eerdere besluiten.** De
> lijst voegt niets toe aan en haalt niets weg van de besluiten 1 t/m 6; zij bepaalt
> uitsluitend wanneer de knop om mag.

**No-Go betekent niet uitstellen zonder eigenaar.** Elke niet-gehaalde voorwaarde wordt een
backlogitem met eigenaar, conform besluit 6 (compliance- en juridische blokkades worden
zichtbaar als backlogitem, afhankelijkheid of releasevoorwaarde).

## 11. Vervolgacties

| # | Actie | Eigenaar |
|---|---|---|
| 1 | Deelnemersvoorwaarden en vertrouwelijkheidsafspraak opstellen en juridisch laten toetsen | PO + Compliance |
| 2 | Privacyverklaring en grondslagen afstemmen op echte persoonsgegevens en volledige KYC in de besloten test | Privacy |
| 3 | Contractuele gevolgen van beëindiging van deelname bij een lopend rendementcontract uitwerken | PO + Compliance |
| 4 | WhatsApp als supportkanaal privacy-technisch beoordelen en vastleggen (C-33) | Privacy + Support |
| 5 | Route van WhatsApp- en e-mailfeedback naar het centrale ticketsysteem inrichten | Support + Scrum Master |
| 6 | Go/No-Go-lijst (§10) als vrijgaveformulier opnemen in het releaseproces | PO + Ops |
| 7 | Omzetting van test- naar productieaccount technisch, juridisch en operationeel uitwerken | Tech lead + Compliance |

## 12. Wat dit besluit uitdrukkelijk níét regelt

Identiteitsprovider · authenticatie-implementatie · MFA-keuze · functionele requirements ·
publieke bèta · algemene marktintroductie. Deze blijven onderwerp van latere besluiten.

> *Inmiddels deels ingevuld:* het **IAM-model** is vastgesteld in besluit 8
> ([ADR-0004](../architecture/adr/0004-identity-and-access-management.md)). De **definitieve
> keuze van de Identity Provider** valt daar uitdrukkelijk buiten en blijft open.
