# tests/security/

Geautomatiseerde tests op de misbruikscenario's uit
[`../../docs/architecture/threat-model.md`](../../docs/architecture/threat-model.md).
Deze tests bewaken dat een securitymaatregel niet stilletjes verdwijnt bij een refactor.

## Verplichte set

| Test | Dreiging | Wat het aantoont |
|---|---|---|
| `S-1` | T-05 | gebruiker A kan objecten van gebruiker B niet lezen, wijzigen of verwijderen |
| `S-2` | T-08 | elk beschermd endpoint weigert een verzoek zonder geldig token |
| `S-3` | T-08 | rolinformatie uit clientgegevens wordt genegeerd |
| `S-4` | T-01, T-07 | snelheidsbeperking treedt op na `[N]` mislukte pogingen |
| `S-5` | T-15 | sessie verloopt; uitloggen maakt het token serverseitig ongeldig |
| `S-6` | T-01 | gevoelige handeling vraagt herauthenticatie |
| `S-7` | T-03, T-13 | bedragen en limieten worden serverseitig herberekend en afgedwongen |
| `S-8` | T-06 | foutmeldingen bevatten geen stacktrace of interne details |
| `S-9` | T-06 | logregels bevatten geen wachtwoorden, tokens, bedragen of persoonsgegevens |
| `S-10` | T-04 | auditlog wordt geschreven bij inloggen, rechtenwijziging, inzage en export |
| `S-11` | T-03 | onverwachte invoer wordt geweigerd, niet verwerkt |
| `S-12` | T-06 | beveiligingsheaders aanwezig (HSTS, CSP, X-Content-Type-Options, Referrer-Policy) |
| `S-13` | privacy | toestemming intrekken maakt toegang tot externe gegevens direct ongeldig |
| `S-14` | privacy | verwijderverzoek verwijdert of anonimiseert binnen de afgesproken termijn |

## Schrijfwijze

* Test het **gedrag** ("weigert toegang"), niet de implementatie.
* Gebruik twee testgebruikers (A en B) met synthetische data.
* Falen van een securitytest is **altijd** blokkerend; nooit tijdelijk uitzetten zonder
  vastgelegde risicoacceptatie.
* Bevat geen exploitdetails die buiten deze repository schade kunnen doen.

Volledige context: [`../../docs/security/security-testing.md`](../../docs/security/security-testing.md).
