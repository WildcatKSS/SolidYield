# tests/accessibility/

Geautomatiseerde toegankelijkheidscontroles, streefniveau **WCAG 2.2 AA**.

> Geautomatiseerde tests vinden ongeveer een derde van de problemen. Handmatige controle
> blijft onderdeel van de [Definition of Done](../../docs/scrum/definition-of-done.md).

## Geautomatiseerd

| Controle | Voorbeeld |
|---|---|
| Contrast van tekst en UI-elementen | ≥ 4.5:1 (tekst), ≥ 3:1 (grote tekst en randen) |
| Alternatieve teksten bij afbeeldingen en iconen | betekenisvolle beschrijving |
| Formulierlabels en foutmeldingen | gekoppeld en voorleesbaar |
| Kopstructuur | logische volgorde zonder overgeslagen niveaus |
| Taalattribuut van de pagina | `lang="nl"` |
| ARIA-gebruik | geen tegenstrijdige of overbodige rollen |
| Focus zichtbaar | duidelijke focusindicator |

## Handmatig (checklist per UI-story)

- [ ] Volledige kernreis bedienbaar met alleen het toetsenbord
- [ ] Logische tabvolgorde; geen focusval
- [ ] Schermlezer leest bedragen, categorieën en foutmeldingen begrijpelijk voor
- [ ] Betekenis niet uitsluitend via kleur (belangrijk bij plus/min-bedragen)
- [ ] Bruikbaar bij 200% zoom en bij tekstvergroting
- [ ] Bewegende of automatisch wisselende content is te pauzeren
- [ ] Time-outs waarschuwen en zijn te verlengen (relevant bij sessieverloop)
- [ ] Teksten op streefniveau B1; financiële termen uitgelegd

## Waarom dit bij een financiële dienst zwaarder weegt

Wie zijn geld niet kan overzien, kan geen goede beslissing nemen. Toegankelijkheid is hier
geen extraatje maar onderdeel van de zorgplicht: laaggeletterden, ouderen en mensen met
een beperking horen tot de doelgroep, niet tot een randgeval.
