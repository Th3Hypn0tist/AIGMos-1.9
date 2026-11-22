# AIGMos 1.9 — Ansat ja regressioriskit

**Tila:** ensimmäinen lähdekoodipohjainen riskiarvio, ei toteutus- tai turvallisuusauditoinnin lopputulos.  
**Kohde:** AIGMos 1.8:n optimointi/modularisointi, SYSTEM/USER-yhtenäistäminen ja View/Panel-nimeäminen.  
**Katsottu 1.8-revisio:** `20383e681dd49f3be33070dba41bbcdc4034ef63`.

Riskit on asetettu järjestykseen vaikutuksen perusteella. Korkea tarkoittaa ensisijaista ratkaisua **ennen laajaa massasiirtoa**; havaittu rakenne ja sen mahdollinen vaikutus erotellaan toisistaan.

| ID | Vakavuus | Ansa | Koodista havaittu peruste | Torjunta / todennus |
|---|---|---|---|---|
| R-01 | **Kriittinen, sopimusrakenne** | `view` on jo locked USER-primitiivi, mutta 1.9:n **View** tarkoittaa nyt deklaratiivista kompositiota ja **Panel** sen komponenttimoduulia. Suora `type=view → type=panel` rikkoo lähdesopimuksen. | Pinnaattu USER Primitive Profiles + Module Manifest Schema: tyypit `command,input,output,adapter,view`; `view`-entrypoint `template`. | Tee eksplisiittinen 1.9:n sopimusmappaus/migraatioversio ja erottele Panel-manifesti View-kompositiosta. Ei hiljaista kuudetta tyyppiä eikä lähteen muokkausta. |
| R-02 | **Kriittinen, Core-eristys** | Minimal Core voi edelleen importoida täyden View-/TUI-stackin, vaikka hakemistot siivotaan. | `system/bootstrap.py` tuo suoraan `system.layout.render.push_live_line` ja runtime/OSC/SQLite-kytkentöjä. `system/layout/lib/editor.py` ja `system/layout/modules/list.py` käyttävät `curses`-kirjastoa. | Erottele bootstrapin Core-entrypoint ja valinnaiset alustaprofiilit. Testaa käynnistys ilman View-, curses-, SQLite- tai verkkopakettien saatavuutta sekä mitattu ESP32-C6-ajokelpoisuus. |
| R-03 | **Korkea, migraatiokatkokset** | Pelkkä polkujen siirto rikkoo rekisteröinnin, latauksen, `new |name /name` -reitityksen ja reloadin. | `system.cs.commands` / `extensions.commands` ovat hardcoded `command_registry.py`:ssä, `system/layout/loader.py` etsii kaksi layout/modules-polkujuurta, `system/layout/definitions.py` käyttää kahta template-hakemistoa. | Keskitetty resolve/discovery yli SYSTEM+USER-pakettien, testaa kaikki vanhat komennot, Viewt, restartit ja reloadit ennen vanhojen polkujen poistoa. |
| R-04 | **Korkea, tiedostonimi vs. semantiikka** | `.tmpl`-päätteen nimeäminen `.view`:ksi ei yksin muuta XML-like-rakenteen `<layout>`-juurta eikä panelien `<label>`-tyylisiä tageja. | `help.tmpl`: `<layout>`, `<label>`, `<q>`, `<cs>`; `system/layout/parser.py` vaatii `<layout>`; `definitions.py` etsii `.tmpl`-päätettä. | Tee erillinen **konseptien**, **hakemistojen**, **tiedostopäätteiden**, **tekstisisällön** ja **julkisten komentojen** migraatiokartta. Päätettä ei muuteta automaattisesti. |
| R-05 | **Korkea, suoritusvalta** | Panelin 'vain esitys' -raja voi olla ristiriidassa nykyisen CS-panelin syötteen dispatch-ketjun kanssa; oikeudet eivät saa syntyä UI-sidonnasta. | `system/layout/modules/cs.py` käyttää `layout_editor.handle_key`; `system/layout/lib/editor.py` kutsuu `registry.dispatch_line` ja reititysketju voi päätyä parseriin. | Määritä hyväksytty input-intent / View Engine → CS -ketju: Panel tuottaa rajatun syötepyynnön, varsinainen oikeuksien tarkistus ja dispatch tapahtuvat runtime-rajalla. Testaa, ettei eri Panel saa uusia oikeuksia. |
| R-06 | **Korkea, identiteetit & prioriteetit** | Yhtenäinen SYSTEM/USER-discovery voi synnyttää samannimisten moduulien hiljaisia ylikirjoituksia. | `system/inputs/registry.py` ja `system/adapters/registry.py` keräävät molemmista lähteistä `discovered[clean]`-avainrekisteriin; myöhemmin luettu USER/extension voi korvata samannimisen SYSTEM-toteutuksen. | Vaadi yksiselitteinen `(origin,type,module_id)`-identiteetti, ristiriidan eksplisiittinen päätös / fail-closed, deterministinen prioriteetti. Ei automaattista SYSTEM-oikeuksien periytymistä. |
| R-07 | **Korkea, C6-resurssit** | Pythonin dynaaminen discovery ja reload voivat muodostua ongelmaksi MicroPythonin pienessä laitteessa. | `system/extensions.py`: `importlib`, `pkgutil`, `pathlib`, `sys.modules` reload; `system/layout/loader.py`: `importlib.util.spec_from_file_location`. | Builder tekee raskaan discovery/validoinnin **build-aikana**; kohdelaitteella vain valittujen moduulien pieni staattinen rekisteri tai osoitetusti sopiva mekanismi. Todellinen flash/RAM-mittaus vaaditaan. |
| R-08 | **Korkea, polkurajat** | View-resolverin nykyinen vapaamuotoinen tiedostopolun haku voi sallia haun kirjastorajan ulkopuolelta tietyillä syötteillä. | `system/layout/definitions.py:_resolve_layout_path` hyväksyy `Path(token)`-polun ennen sallittuja juuria eikä normalisoi jokaista ehdokasta `relative_to`-rajalla; `new.py` / `require_route` eivät estä `..`-segmenttejä. | Manifestin mukaan ratkaistut nimiviittaukset, sallittu juuri, canonical path -containment, syötteen merkkisäännöt; regressiot path traversal -yrityksille. Ei väitetä tästä yksin todettua tietovuotoa. |
| R-09 | **Keskisuuri, jaetut resurssit** | Sama template/Panel voi olla monen View'n käytössä; kopiointi joka View-pakettiin synnyttää versioeroja. | `system/library/layout/*.tmpl` viittaa samoihin `<label>`, `<q>`, `<cs>`-elementteihin. | Panel-rekisteri yhteiseksi, View viittaa Panel-identiteetteihin. Yksi omistaja ja versio per jaettu Panel, ei koodin klooneja. |
| R-10 | **Keskisuuri, näkyvyysrajat** | TUI View / Panel / renderer ja Expose (nanoCMS + NetworkService) voivat sekoittua 'kaikki näkyvä = web' -tulkinnaksi. | Lähteen Expose-sopimus koskee ulospäin projisoituja human/web/network-pintoja; 1.8:n View on paikallinen terminal/runtime-rakenne. | Dokumentoi, milloin View renderöidään paikallisena TUI:na ja milloin sen sisältö julkaistaan Expose-rajapinnan kautta. Expose ei saa tuoda web-/verkko-riippuvuutta Minimal Coreen. |

## Ehdoton sääntö: nolla piiloriippuvuutta

Yksikään tässä dokumentissa tunnistettu implisiittinen riippuvuus ei saa jäädä tuotantoon. Ennen kuin 1.9:n modularisointia voidaan pitää valmiina, kaikki koodi-, konfiguraatio-, tiedosto-, palvelu- ja alusta-riippuvuudet täytyy deklaroida, ratkaista transitiivisesti ja vahvistaa todellista import-/paketointigraafia vasten. **Tuntematon tai ilmoittamaton riippuvuus = FAIL.** Katso [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md).

## Välittömät etenemisportit

1. **Sopimusportti:** View vs. Panel vs. renderer + USER-lähteen `type=view` ratkaistu eksplisiittisesti, ilman uusia implisiittisiä moduulityyppejä.
2. **Riippuvuusportti:** Minimal Core bootstrap ei importoi valinnaista View-/network-/storage-toteutusta.
3. **Migraatioportti:** yhden `label`-tyyppisen Panelin ja yhden `help.tmpl`-tyyppisen View'n end-to-end-testi kulkee vanhaa ja uutta resoluutiota vasten.
4. **Turvaportti:** pakettien identiteetti, hakupolut, näkyvyys ja CS-syötteen auktoriteetti testattu.
5. **Resurssiportti:** CPythonin refaktorointi ei kelpaa ESP32-C6-hyväksynnäksi ilman MicroPythonin todellista target-testiä.

## Epävarmuudet

- Arvio perustuu tarkastettuihin 1.8:n tiedostoihin, ei koko riippuvuusverkon mekaaniseen import- tai suoritusanalyysiin.
- Yksittäinen tiedostossa näkyvä turvariskin mahdollisuus ei itsessään osoita hyödynnettävää haavoittuvuutta ulkoisesta rajapinnasta.
- 1.9:n uusi tiedostopääte, manifestisopimus ja lopullinen View Engine -rajapinta ovat edelleen `unlocked`.
