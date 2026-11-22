# AIGMos 1.9 — Roadmap

**Tila:** suunniteltu, ei toteutettu.  
**Toteutusjärjestys:** **Core → Core Modules → System Modules → Build Tool → ESP32-C6 Build**.

Tämä on AIGMos 1.9 -kehityksen ensisijainen vaiheistus. AIGMos 1.8 on toteutuksen lähtöaineisto; uusien vastuurajojen ja rajapintojen toteuttaminen on 1.9-työtä. Vaiheiden hyväksyntä edellyttää testinäyttöä, ei pelkkää tiedostojen luomista.

## 1. Core — Hardcore

**Tavoite:** toimiva, minimaalinen ja samaa lähdekoodia CPythonissa sekä MicroPythonissa ajava Hardcore. MicroPython-yhteensopivuus on tarkoituksellinen, koneellisesti validoitava rajaus; koko muuta AIGMos-järjestelmää se ei rajoita.

Hardcoren viisi mekanismia:

- **INPUT:** vastaanottaa syötteet ja **vain kirjoittaa STATEen MEM-adapterilla**. Ei STATE-lukua, CS-kutsua eikä AccessCore-riippuvuutta.
- **STATE:** julkiset READ/WRITE-rajapinnat, adapterireititys ja Minimalin **MEM**- ja **FILE**-adapterit. INPUT-kirjoitukset eivät automaattisesti kirjoita FILEen; pysyvyys on eksplisiittinen.
- **TER:** Trigger (`!`) → Event (`@`) → Runner (`%`); `&` on järjestetty komentorutiini Runnerille. TER **lukee STATEa mutta ei kirjoita siihen**. TER välittää komennot CSi:lle.
- **CS:** CSi (command input), CSo (command output), parseri, dispatcher ja rekisteri. CS **lukee ja kirjoittaa STATEa** STATE API:n kautta; esimerkiksi `$foo:bar = $bar:foo` lukee oikeanpuoleisen symbolin ja kirjoittaa vasemmanpuoleiseen. AccessCore on valinnainen CS:n sisäinen kontrolli-integraatio, ei pakollinen Core-riippuvuus.
- **EXPOSE:** Hardcoren mekanismi, joka määrää, mitä kaksisuuntaisen ulkoisen kommunikaation portit tarjoavat. Se **ei** ole verkkopino, transport-protokolla eikä suoraan julkaistava STATE API.

`boot.config` määrittelee käynnistyksessä adapterien, Exposen, porttien ja bindingien kokoonpanon. Expose ei tarvitse pakollista CS-hallintakomentoa. Serial, Telnet, HTTP ja OSC ovat **valinnaisia Transport-toteutuksia**, eivät Hardcoren sisäisiä riippuvuuksia.

**Hyväksymiskriteerit**
- [ ] Hardcore käynnistyy ilman Core-, System- tai User-moduuleita sekä ilman IAM:ia, AC:tä, Build Toolia ja käyttöliittymää.
- [ ] INPUT → STATE(MEM) → TER → CSi → CS → STATE / CSo -suoritusketju on testattu; TER ei kirjoita STATEen.
- [ ] STATE.READ, STATE.WRITE, adapterireititys, MEM ja eksplisiittinen FILE-pysyvyys on testattu.
- [ ] CSi/CSo, symboliviittaukset, `&`-rutiinit, suorituskonteksti, virheet ja rajatut puskurit on testattu.
- [ ] Sama Hardcore-lähdekoodi toimii CPythonissa ja MicroPythonissa ilman alustan vaatimia Core-koodimuutoksia.
- [ ] Ei piiloriippuvuuksia eikä ylimääräisiä pakollisia kirjastoja.

## 2. Core Modules

**Tavoite:** toteuttaa ensimmäiset erilliset Core-moduulit ja todentaa Core-moduulisopimus.

- Ensimmäinen tunnistettu Core-moduuliehdokas: **`structured`**, rakenteisen `#`-datan käsittelyyn. **Structure** tarkoittaa erillistä työkalua; nimiä ei sekoiteta.
- Core-moduulit käyttävät vain Coren julkisia palveluita eivätkä riipu toisistaan.
- Moduuli ei saa ohittaa STATE-rajapintoja tai tuoda implisiittisiä riippuvuuksia.
- Core-moduulin MicroPython-yhteensopivuus arvioidaan erikseen kohdeprofiilia varten; Core-moduulit eivät ole sama asia kuin pakollinen Hardcore.

**Hyväksymiskriteerit**
- [ ] Core-moduulin manifesti, entrypointit ja riippuvuudet voidaan validoida.
- [ ] `structured`-moduulin vastuuraja suhteessa STATEen on määritelty ja testattu.
- [ ] Core-only-kokoonpano toimii edelleen ilman Core-moduuleita.
- [ ] Core Module → toinen Core Module on kielletty; testit hylkäävät ohituksen.

## 3. System Modules

**Tavoite:** erottaa 1.8:n toiminnallisuudet itsenäisiksi System-moduuleiksi ja siirtää käyttöliittymä, transportit ja muut valinnaiset toteutukset Hardcoren ulkopuolelle.

- Yhtenäinen moduulirakenne: `system/library/` ja selkeä jako komentoihin, inputteihin, outputteihin, adaptereihin, Paneleihin ja View-kompositioihin.
- **Transport-kirjasto:** `serial`, `telnet`, `http`, `osc` ja mahdolliset muut toteutukset. Vain verkkopohjaiset toteutukset tarvitsevat verkkopinon.
- **View/Panel:** View on deklaratiivinen näkymäkompositio, Panel yksittäinen UI-komponentti. Valinnainen View Engine voidaan integroida olemassa olevasta LMTS:n UI-komponentista.
- **IAM ja AccessCore:** sovitetaan olemassa olevista spesifikaatioistaan AIGMos 1.9:n rajapintoihin. IAM/AC eivät ole AIGMos 1.8:n migroitavia osia. Ne eivät ole pakollisia Hardcoressa; lopullinen moduuliluokka määräytyy niiden todellisista riippuvuuksista.
- **AC-riippuvainen moduuli:** CSi- ja STATE READ/WRITE -kutsut vain AC:n kautta. CS:n sisäinen AC-kontrollipiste voi olla käytössä valitussa kokoonpanossa, mutta Minimal ei edellytä AC:tä.

**Hyväksymiskriteerit**
- [ ] Moduulit ovat erikseen asennettavia, löydettäviä ja riippuvuuksiltaan eksplisiittisiä.
- [ ] Serial toimii ilman verkkoriippuvuutta; Telnet/HTTP/OSC lataavat vain omat tarvittavat riippuvuutensa.
- [ ] Expose julkaisee vain `boot.config`-määritysten mukaiset rajapinnat, ei suoraa STATE API:a.
- [ ] IAM/AC-yhteensopivuus ja AC-ohitusten estäminen on testattu niissä kokoonpanoissa, joissa AC on käytössä.
- [ ] Core-only-kokoonpano toimii, vaikka kaikki System-moduulit jätetään pois.

## 4. Build Tool

**Tavoite:** luoda itsenäinen Build Engine, joka tuottaa valittujen moduulien ja targetin mukaisen rajatun AIGMos-komposition.

- Moduulien discovery, manifestien tarkistus ja deterministinen riippuvuuksien ratkaisu.
- Kohde-runtimejen ilmoittaminen ja tarkistus: **MicroPython** / **CPython** sekä target-kohtaiset tekniset rajoitteet.
- Paketin muodostus: vain valittu Core + sallitut moduulit ja niiden välttämättömät resurssit, `boot.config`, käynnistys ja rakennusraportti.
- Tarvittaessa LMTS-pohjainen View ja `|BUILD` käyttöliittymäksi. Build Engine ei saa edellyttää UI:ta.
- Ei implisiittisiä importteja, ulkopuolisia riippuvuuksia, sallimattomia kerrosriippuvuuksia eikä hiljaisia fallbackeja.

**Hyväksymiskriteerit**
- [ ] Eri moduulivalinnat tuottavat eri riippuvuussulkeumat ja pakatut artefaktit.
- [ ] Puuttuva, kielletty tai targetille yhteensopimaton riippuvuus pysäyttää buildin.
- [ ] Valitsematon toiminnallisuus ja Build Tool itse eivät päädy kohdeajoympäristöön.
- [ ] Tuotos sisältää version, valinnat, runtime- ja target-tiedot, riippuvuudet sekä validointiraportin.

## 5. ESP32-C6 Build

**Tavoite:** muodostaa Build Toolilla toimiva AIGMos 1.9 -kokoonpano **ESP32-C6-N16**-laitteelle ilman PSRAMia ja mitata sen todellinen resurssikäyttö.

**Expose/Transport valitaan buildissä; mikään seuraavista ei ole kaikissa C6-kokoonpanoissa pakollinen:**

| C6 Expose -valinta | Riippuvuudet | Tarkoitus | Hyväksyntä |
|---|---|---|---|
| **Serial** | UART / USB, ei verkkopinoa | Paikallinen CSi/CSo-komentoyhteys | Ensimmäinen vertailu- ja debug-kokoonpano |
| **Telnet** | Wi-Fi + TCP + Telnet-toteutus | Kevyt etä-CSi/CSo | Valittava, jos mahtuu resurssibudjettiin ja testit läpäistään |
| **Web + REST** | Wi-Fi + TCP + HTTP-palvelin, web-resurssit ja REST-bindingit | Selainkäyttö sekä REST-rajapinta CS-toiminnoille | **Ehdollinen:** mukaan vain, jos mitattu RAM-, flash- ja suorituskykybudjetti riittää |

- Buildissä voidaan valita yksi tai useampi yhteensopiva Expose/Transport-toteutus, jos yhteinen resurssibudjetti sen sallii.
- **Web + REST** on kevyt, valinnainen web-käyttöliittymä ja REST-reititys; se ei tarkoita täyden View Enginen pakollista sisällyttämistä C6:een.
- REST ja muut portit käyttävät Exposen määriteltyä CSi/CSo-julkaisua, eivät suoraa STATE-rajapintaa.
- `boot.config` asettaa valitut portit ja bindingit käynnistyksessä. Verkkopino ladataan vain verkkotransportteja varten.
- Verkkoyhteyksiä ei oletusarvoisesti avata epäluotettuihin verkkoihin; Telnet ei tarjoa salausta. Tarvittavat käyttöoikeus- ja verkkorajaukset on validoitava erikseen.
- Jos Web + REST ei mahdu budjettiin, build **raportoi hylkäyksen** eikä poista ominaisuuksia hiljaisesti.

**Hyväksymiskriteerit**
- [ ] Build Tool muodostaa käynnistyvän C6-N16 / MicroPython -paketin ilman PSRAMia.
- [ ] Serial-CSo/CSi toimii ja koko INPUT → STATE → TER → CS -ketju on todettu laitteella.
- [ ] MEM-päivitykset eivät aiheuta automaattisia FILE-/flash-kirjoituksia.
- [ ] Telnet-valinta testataan laitteella ja sen lisäkulutus mitataan suhteessa Serialiin.
- [ ] Web + REST -valinnan soveltuvuus ratkaistaan **todellisella laitemittauksella**; hyväksytään vain, jos resurssit riittävät.
- [ ] RAM, flash, käynnistysaika, suoritusviiveet ja valittujen Transport-toteutusten lisäkulutus raportoidaan.
- [ ] Muutosten jälkeen kaikki yhteensopivuus- ja regressiotestit läpäistään.

## Läpäisevät säännöt

1. **MicroPython-yhteensopivuus on pakollinen Hardcoressa**, mutta muille moduuleille runtime määritellään manifestissa ja validoidaan targettia vastaan.
2. **Core → module -riippuvuus on kielletty**; Core-moduulit eivät riipu toisistaan. System- ja User-moduulien sallitut riippuvuudet ratkaistaan `DEPENDENCY_RULES.md`-sääntöjen mukaisesti.
3. **AC ja IAM ovat valinnaisia integraatioita.** AC-vaatimuksen ilmoittanutta moduulia ei saa ajaa ilman vaadittua kontrollia; Minimal ei tarvitse AC:tä.
4. **Expose kertoo, mitä portit tarjoavat. Transport toteuttaa yhteyden.** Serial ei edellytä Networkia; verkkotoiminnot eivät kuulu Hardcoreen.
5. **AIGM on alustariippumaton standardi.** MicroPython/CPython-valinta koskee vain AIGMos-referenssitoteutusta.

Tämä roadmap korvaa vanhan `Core → LMTS View → Build` -kolmivaiheisen vaiheistuskuvauksen. Vanhojen dokumenttien yksityiskohtaiset tehtävät voivat edelleen olla hyödyllisiä, mutta toteutusjärjestyksessä tämä dokumentti on ensisijainen.
