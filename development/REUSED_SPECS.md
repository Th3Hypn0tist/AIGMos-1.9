# AIGMos 1.9 — Reused specifications

## Rajattu poikkeus: mitä vanhemmista 2.0-määrityksistä käytetään

**Vain kaksi olemassa olevaa määrityskokonaisuutta siirretään AIGMos 1.9:n suunnittelun lähtötiedoksi:**

1. **USER-moduulien järkeistetty primitiivimalli ja siihen kuuluvat modulaariset sopimukset.**
2. **Expose-kokonaisuus ja sen ulospäin näkyvien rajapintojen omistajuusrajat.**

Muita 2.0:n Meta-/business-/domain-/universaali-/kompositiomäärityksiä **ei tuoda 1.9:n toteutusscopeen**. Viittaukset Meta-rakenteisiin alkuperäisissä sopimuksissa kuvaavat lähdespesifikaatiota; ne eivät itsessään aktivoi näitä AIGMos 1.9:ssä.

**Lähde:** `Th3Hypn0tist/AIGMos_docs` / Git-commit `535c1dacfc4ee72f1fbc00dedea3f3672178dbe2` (pinnattu lähdeversio). Lähdesopimusten `locked`-tila tarkoittaa lähteen omaa tilaa. 1.9-integraatio ei ole automaattisesti toteutettu tai validoitu. **Ei suunnitella näitä kahta kokonaisuutta uudestaan:** kartoitetaan 1.8-koodin vastaavuus, käytetään valmiita sopimuksia ja dokumentoidaan mahdolliset 1.9-yhteensopivuuserot eksplisiittisesti.

## 1. USER-moduulit — viisi alkuperäistä primitiiviä

**1.9-nimeämishuomio:** nämä ovat pinnaatun lähdesopimuksen alkuperäiset tyypit. Uudessa 1.9-käsitteistössä `View` on deklaratiivinen näkymä (nykyinen template) ja sen pienelle UI-moduulille on päätetty nimeksi `Panel`. Jos moduulin `type=view` muutetaan `type=panel`, kyseessä on 1.9:n **versioitu sopimusmuutos**, ei alkuperäisen lähdesopimuksen sisältö. Ks. [VIEW_NAMING.md](VIEW_NAMING.md).

| Tyyppi | Omistajuus / rajattu tehtävä | Ei saa muuttua |
|---|---|---|
| `command` | `um.<module_id>`-komennot, kontrolloitu toiminto | yleinen input-kuuntelija tai adapteri |
| `input` | lähdedatan vastaanotto ja kirjoitus omaan `#UM.<module_id>`-haaraan | komentosuorittaja tai ulostulon lähettäjä |
| `output` | validoitu ulostulo deklaroituun kohteeseen | mielivaltaisen kohteen valitsija tai komentoparseri |
| `adapter` | yhden deklaroidun symbolijuuren rajattu luku/kirjoitus-silta | polleri, komento tai output |
| `view` | esitys ja deklaroitu käyttöliittymäsidonta | suoritusmoottori, ulkoinen vaikutus tai oma autorisointipolku |

- Yksi USER-moduuli kuuluu **täsmälleen yhteen** primitiivityyppiin. Monimutkainen toiminnallisuus muodostetaan kompositiolla, ei lisäämällä päällekkäisiä moduulityyppejä.
- `layout` **ei** ole kuudes USER-moduulityyppi, vaan `view`-tyypin sisäinen esityskäsite.
- `module.json` sisältää deklaroidut entrypointit, capabilityt, roots, policies ja testit. Capabilities ovat pyyntöjä, eivät automaattisia oikeuksia.
- `#UM` on inertti ja moduulikohtaisesti rajattu state-namespace; toisen moduulin haaraan tai system-juuriin ei kirjoiteta implisiittisesti.
- USER ei saa laajentaa Coren pakollista riippuvuusjoukkoa vain siksi, että kyseinen moduuli on asennettu.
- Alkuperäisen USER-primitiivin `view`, 1.9:n View-komposition, pienemmän Panel-moduulin (valittu nimi) ja LMTS-pohjaisen valinnaisen View-renderöintitoteutuksen suhde on ratkaistava eksplisiittisesti. Vanhan `.tmpl`/Layout Engine -määrittelyä ei saa tulkita Full View'n pakolliseksi Minimal Core -riippuvuudeksi.

## 2. Expose — alkuperäiset rajat säilytetään

Lähdesopimuksen ydin: **`Expose = nanoCMS + NetworkService`**. Kaikki tarkoituksellisesti ulospäin näkyvät AIGMos-pinnat kulkevat jommankumman Expose-haaran kautta. Tämä on **rajapintaomistajuuden sääntö**, ei vaatimus käynnistää web-palvelinta tai porttikuuntelijaa Minimal Coressa.

- **nanoCMS** omistaa rakenteiset human/web-näkymät: `#WEB`, rekursiiviset Page-rakenteet, näkyvien osien sijoittelun, järjestyksen ja esitysprojektion.
- **NetworkService** omistaa nimetyn protokolla-/palveluinstanssin identiteetin, listen/bind-portin/transportin, deklaroidun vs. käynnissä olevan tilan ja elinkaariohjaustoiminnot.
- Jos nanoCMS-näkymä tarjotaan NetworkService-instanssin kautta, kummankin semanttinen omistajuus säilyy. Expose ei saa ottaa alla olevan toiminnallisuuden data- tai autorisointivaltaa.
- **Web Base** pysyy viidessä primitiivissä: `Text`, `List`, `Table`, `Reference`, `Form`. Se ei vaadi JavaScriptiä eikä frontend-frameworkia.
- UI-tekstien kieliversiot ovat erillisiä esitysarvoja; ne eivät muuta kanonisia tunnisteita, komentoja, rajapintoja tai toimintaa.
- Lähteen Port Editor -sopimus nimeää palvelut (esim. `rest:api`) erillään porttinumerosta. Portti ei ole identiteetti.
- Expose ei automaattisesti kuulu ESP32-C6:n Minimal Core -kompositioon. Käytössä olevien 1.8:n web/REST/network-pintojen siirto selvitettävä ennen muutoksia.

## 3. Lähdesopimukset — pinnatut, ei uudelleenkirjoitetut

- [`runtime/modules/00_Primitive_UserModule_Profiles.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/00_Primitive_UserModule_Profiles.json): five primitive types: command, input, output, adapter, view.
- [`runtime/modules/01_Extension_Lifecycle.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/01_Extension_Lifecycle.json): discovery, validation, installation, enable/disable, removal and cleanup.
- [`runtime/modules/02_Module_Manifest_Schema.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/02_Module_Manifest_Schema.json): module.json, type, entrypoints, capabilities, roots, policies, tests.
- [`runtime/modules/03_User_Adapter.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/03_User_Adapter.json): bounded symbol-mounted read/write bridge.
- [`runtime/modules/04_User_Command.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/04_User_Command.json): bounded um.<module_id> command dispatch.
- [`runtime/modules/05_User_Input.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/05_User_Input.json): bounded ingress, own #UM.<module_id> state.
- [`runtime/modules/06_User_Output.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/06_User_Output.json): bounded egress and declared external effects.
- [`runtime/modules/07_User_View.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/07_User_View.json): presentation-only view; layout remains view-internal.
- [`runtime/modules/08_UM.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/runtime/modules/08_UM.json): #UM user-module-scoped inert runtime state.
- [`expose/00_Web_Base_Element_Library.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/expose/00_Web_Base_Element_Library.json): five link-capable web primitives.
- [`expose/01_nanoCMS_Meta_Web_Architecture.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/expose/01_nanoCMS_Meta_Web_Architecture.json): Expose = nanoCMS + NetworkService.
- [`expose/02_Port_Editor_Contract.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/expose/02_Port_Editor_Contract.json): named network listener service configuration and lifecycle.
- [`expose/03_Web_Base_Contract.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/expose/03_Web_Base_Contract.json): Web Base boundaries, no mandatory JS/framework.
- [`expose/04_Web_Label_Catalog_Contract.json`](https://github.com/Th3Hypn0tist/AIGMos_docs/blob/535c1dacfc4ee72f1fbc00dedea3f3672178dbe2/canonical/json/expose/04_Web_Label_Catalog_Contract.json): web label localization without changing canonical identities.

## 4. Toteutussiirron hyväksymisen ehdot

- [ ] Kartoitettu, mitkä AIGMos 1.8:n nykyiset USER-tyypit ja rekisteröintipolut vastaavat viittä primitiiviä.
- [ ] Kirjattu 1.8:n ja lähdespesifikaation väliset ristiriidat sekä päätetty tarvittavat toteutusmuutokset erikseen.
- [ ] Toteutettu tai todettu jo toimiviksi USER-manifesti, eristetyt symbolijuuret ja moduulien elinkaari hyväksymistesteineen.
- [ ] Tunnistettu 1.8:n nykyiset ulkoiset pinnat ja luokiteltu ne nanoCMS- tai NetworkService-omistajuuteen.
- [ ] Todenettu Expose-rajojen säilyminen ilman pakollista View/NetworkService-riippuvuutta Minimal Coressa.
- [ ] LMTS UI:n valinnainen View-renderöinti ja View/Panel-erottelu tarkistettu ilman semanttista päällekkäisyyttä; tyyppimuutos dokumentoitu versioidusti, jos se hyväksytään.

**Muutoskäytäntö:** tarvittavat 1.9-erot kirjataan ensin `DECISIONS.md`- ja `TODO.md`-tiedostoihin. Lähteen locked-kontrakteja ei muokata hiljaisesti eikä toteutusväittämiä tehdä ennen mittauksia ja testejä.
