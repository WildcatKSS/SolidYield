# tests/unit/

Snelle, geïsoleerde tests zonder database, netwerk of bestandssysteem.

## Wat hier hoort

* financiële berekeningen: optellen, afronden, valuta, negatieve bedragen, nul;
* validatiefuncties (invoer, formaten, grenzen);
* domeinregels: limieten, categorisering, statusovergangen;
* hulpfuncties voor datum en tijd (let op tijdzones en zomertijd).

## Aandachtspunten bij een financiële dienst

| Testgeval | Waarom |
|---|---|
| Afronding op twee decimalen, ook bij `0,005` | onjuiste afronding is een zichtbare fout |
| Som van delen = totaal | gebruikers controleren dit zelf |
| Negatieve bedragen en terugboekingen | vaak vergeten, altijd zichtbaar |
| Bedrag `0` en lege dataset | lege staat mag geen fout geven |
| Zeer grote bedragen | overflow en weergave |
| Maandgrenzen, schrikkeljaren, zomertijd | "deze maand" is minder eenduidig dan het lijkt |
| Verschillende valuta's (indien van toepassing) | mengen van valuta's moet onmogelijk zijn |

Gebruik geen floating point voor geld — zie [`../../src/README.md`](../../src/README.md).
