# Toestemmings- en privacycheck voor onderzoek

Vóór **elke** sessie met deelnemers doorloopt de onderzoeker deze checklist. Geen
toestemming = geen sessie.

## 1. Checklist vooraf

- [ ] Doel van het onderzoek is in gewone taal beschreven
- [ ] Duidelijk welke gegevens worden vastgelegd (aantekeningen, opname, meetgegevens)
- [ ] Bewaartermijn per soort gegeven vastgesteld (zie `../privacy/data-retention.md`)
- [ ] Alleen gegevens die echt nodig zijn (minimalisatie)
- [ ] Deelnemer krijgt een **testaccount met synthetische data**
- [ ] Testomgeving toont zichtbaar dat het een testomgeving is
- [ ] Deelnemer is geïnformeerd dat er geen echte gegevens gebruikt mogen worden
- [ ] Vastlegging gebeurt onder een deelnemerscode (P1, P2, …)
- [ ] Namen/contactgegevens staan **buiten** de repository, in `[AFGESCHERMDE LOCATIE]`
- [ ] Deelnemer weet dat deelname vrijwillig is en op elk moment kan stoppen
- [ ] Deelnemer weet hoe die zijn of haar gegevens kan laten verwijderen
- [ ] Bij opnames: expliciete, aparte toestemming, en een sessie is ook zonder opname mogelijk
- [ ] Bij kwetsbare deelnemers: extra zorgvuldigheid en verwijsmogelijkheid naar hulp
- [ ] Privacyverantwoordelijke heeft de opzet gezien bij nieuwe soorten gegevens

## 2. Toestemmingsformulier (sjabloon)

> **Onderzoek naar `[ONDERWERP]` — SolidYield**
>
> **Wat gaan we doen?** Je gebruikt een product in ontwikkeling en we stellen je daar
> vragen over. Dat duurt ongeveer `[45]` minuten.
>
> **Waarom?** We willen begrijpen wat wel en niet werkt, zodat we het kunnen verbeteren.
> We testen het product, niet jou.
>
> **Welke gegevens leggen we vast?**
> * aantekeningen over wat je doet en zegt, onder een code (bijvoorbeeld "P3"), niet onder je naam;
> * `[wel/geen]` een opname van scherm en/of geluid;
> * je contactgegevens, alleen om de afspraak en de vergoeding te regelen.
>
> **Wat leggen we niet vast?** Geen echte financiële gegevens. Je werkt met een
> testaccount met verzonnen gegevens. Deel geen echte rekeningnummers, bedragen of
> wachtwoorden.
>
> **Hoe lang bewaren we het?**
> * opnames: maximaal `[30]` dagen;
> * contactgegevens: tot `[TERMIJN]` na afloop;
> * geanonimiseerde bevindingen: onbeperkt (deze zijn niet naar jou te herleiden).
>
> **Wie ziet het?** Alleen het projectteam van `[ORGANISATIE]`. We publiceren nooit iets
> waaruit blijkt wie je bent.
>
> **Jouw rechten.** Je doet vrijwillig mee en kunt op elk moment stoppen, zonder reden en
> met behoud van de vergoeding. Je kunt je gegevens laten inzien of verwijderen via
> `[PRIVACY-CONTACT-EMAIL]`.
>
> **Toestemming**
> * ⬜ Ik doe vrijwillig mee en begrijp bovenstaande.
> * ⬜ Ik geef toestemming voor een opname *(optioneel — je kunt ook zonder meedoen)*.
> * ⬜ Ik geef toestemming om geanonimiseerde citaten intern te gebruiken.
> * ⬜ Ik mag benaderd worden voor een vervolgsessie.
>
> Naam: ………  Datum: ………  Handtekening: ………
>
> *Dit formulier bewaren we buiten de projectrepository, in `[AFGESCHERMDE LOCATIE]`.*

> ⚖️ **Te valideren door een bevoegde specialist:** de juiste grondslag, de formulering en
> de bewaartermijnen. Deze tekst is een werkbaar startpunt, geen juridisch advies.

## 3. Tijdens de sessie

- [ ] Toestemming mondeling herhaald en bevestigd
- [ ] Deelnemer eraan herinnerd geen echte gegevens te gebruiken
- [ ] Bij ongemak of emotie: pauzeren, aanbieden te stoppen
- [ ] Gaat het gesprek over een echt financieel probleem van de deelnemer: geen advies
      geven, wel verwijzen naar `[HULPINSTANTIE]`

## 4. Na de sessie

- [ ] Aantekeningen ontdaan van herleidbare gegevens
- [ ] Opnamen opgeslagen op `[AFGESCHERMDE LOCATIE]`, met verwijderdatum in de agenda
- [ ] Bevindingen vastgelegd onder deelnemerscode
- [ ] Niets met persoonsgegevens in Git, issues of screenshots
- [ ] Vergoeding geregeld
- [ ] Terugkoppeling ingepland (binnen `[2]` weken)

## 5. Incidenten

Zijn er per ongeluk toch echte persoonsgegevens vastgelegd of gedeeld?

1. Meld dit **onmiddellijk** via het incidentproces: `[PRIVACY-CONTACT-EMAIL]` én
   `[SECURITY-CONTACT-EMAIL]`. Wacht niet op bevestiging, volledigheid of eigen onderzoek.
2. Volg [`../security/incident-response.md`](../security/incident-response.md).
3. Verwijder de gegevens waar mogelijk en leg vast wat er is gebeurd — maar laat het melden
   daar niet op wachten.
4. **Beoordeel niet zelf** of dit meldingsplichtig is bij een toezichthouder. Externe
   meldtermijnen zijn kort en worden bepaald door bevoegde specialisten.
