# AIGMos 1.9 — Goals

## Päätavoite

AIGMos 1.8:n **olemassa oleva toteutus** optimoidaan ja modularisoidaan niin, että yhteinen **Minimal Core** toimii ESP32-C6-N16-ympäristössä. Tämän jälkeen LMTS:n UI-komponentti integroidaan valinnaiseksi View-toteutukseksi ja sen päälle rakennetaan AIGMos:n oma self-projection-build-työkalu.

## Phase 1 — Minimal Core / ESP32-C6

**Tavoite:** ajaa mahdollisimman pieni, toimiva AIGMos samalla yhteisellä Core-arkkitehtuurilla myös rajoitetulla laitteella. Lähtökohta on **1.8-koodin refaktorointi ja mitattu optimointi**, ei uuden Coren suunnittelu tyhjästä.

**Rakenneperiaate:** SYSTEM-moduulien hajallaan olevat toteutukset kootaan yhtenäisen `system/library/`-juuren alle. CS-parseri, STATE, TER sekä valinnaiset ajomoottorit erotetaan moduulipaketeista. **View** tarkoittaa näkymäkompositiota (nykyinen template), joka koostuu pienemmistä UI-moduuleista; niille vahvistettu nimi on **Panel**. Alustava rakenne: `system/library/{commands,inputs,outputs,adapters,panels}/<module_id>/` sekä erilliset `system/library/views/<view_id>/`-määritykset. Lopullinen nimi, manifesti ja migraatio täsmennetään ennen toteutusta. [SYSTEM_MODULES.md](SYSTEM_MODULES.md), [VIEW_NAMING.md](VIEW_NAMING.md).

**Työperiaate:** ensin 1.8:n nykytilan kartoitus ja käyttäytymisen regressiotestit, sitten riippuvuuksien irrotus ja resurssien optimointi. Toimiva käytös säilytetään, ellei muutosta päätetä erikseen.

Pakollinen Core:
- INPUT: Input-moduulit voivat päivittää STATEa suoraan, ilman CS-parseria.
- STATE: Coren tarvitsema minimaalinen tila.
- TER: Trigger (`!`) → Event (`@`) → Runner (`%`).
- CS: yhteinen komentojen suorituspinta, myös Eventin välittämille komennoille.
- `&`: Runneriin kuuluva järjestetty CS-komentojen rutiinilista; **pakollinen Core-ominaisuus**, ei USE-moduuli.

Periaate: Triggeriin voidaan sitoa useita Eventtejä; yksittäinen Event välittää yhden CS-komennon. Runner suorittaa komennon/rutiinin CS:n kautta. Yllä oleva on suunnittelutavoite, jonka vastaavuus nykyiseen 1.8-toteutukseen on tutkittava.

**Alustava hyväksymisnäyttö:**
- SYSTEM-moduulit löytyvät vakioidun `system/library/`-rakenteen alta; kunkin paketin toteutus, manifesti ja omat resurssit ovat yhdessä. Yhteiset ajomoottorit eivät muutu implisiittisesti moduuleiksi.
- 1.8:n olennaiset toiminnallisuudet ja rajapinnat on kartoitettu ja niiden säilyminen tai tarkoituksellinen siirto moduuliin on osoitettu.
- Optimointia edeltävä resurssitaso ja optimoinnin jälkeinen taso on mitattu vertailukelpoisesti.
- C6-N16 käynnistää Minimal Coren ilman PSRAMia.
- INPUT → STATE → TER → CS -ketju ja `&`-rutiinin järjestetty suoritus toimivat.
- Core ei edellytä Full View'tä, Build Engineä eikä yksittäisiä USER-moduuleja.
- Muistin käyttö, firmware/flash-koko, käynnistys ja keskeinen suoritusaika mitataan todellisella laitteella.
- CPython- ja MicroPython-yhteensopivuus tarkistetaan soveltuvilla yhteisillä testeillä.

## Rajattu sopimusten uudelleenkäyttö

Aiemmista 2.0-määrityksistä otetaan lähtökohdaksi **vain USER-moduulien järkeistetty primitiivimalli** (alkuperäisessä lukitussa sopimuksessa command, input, output, adapter, view) ja **Expose** (nanoCMS + NetworkService). View-termin uusi merkitys vaatii 1.9:ssä eksplisiittisen, versioidun käsitemigraation; pienemmälle UI-moduulille on ehdotettu nimeä panel. Käytetään olemassa olevia lähdesopimuksia, ei suunnitella niitä uudelleen. Toteutus sovitetaan 1.8:n todelliseen koodiin ja Minimal Coren rajauksiin. Lähteet ja 1.9-siirron avoimet tarkistukset: [REUSED_SPECS.md](REUSED_SPECS.md).

## Phase 2 — LMTS UI as View

**Tavoite:** LMTS:n kehityksessä uudelleenkäytettäväksi suunniteltu käyttöliittymäpalikka integroidaan **yhdeksi valinnaiseksi View-renderöintitoteutukseksi**, ei yksittäiseksi View-kompositioksi. View'n rakenne koostuu pienemmistä UI-moduuleista (vahvistettu nimi: Panel).

**Alustava hyväksymisnäyttö:**
- UI-komponentti toimii View-rajapinnan kautta ilman Core-riippuvuutta.
- UI-rajapinnan ja toteutuksen vastuut dokumentoidaan.
- Sama Minimal Core toimii ilman kyseistä View-toteutusta.

## Phase 3 — Build Engine + |BUILD

**Tavoite:** täysi AIGMos muodostaa valittujen USE/USER-moduulien, riippuvuuksien ja target-profiilin perusteella itsenäisen rajatun AIGMos-komposition.

- Build Engine on valinnainen USE-järjestelmämoduuli, jossa on CS-rajapinta.
- `|BUILD` on LMTS-pohjaisen View-toteutuksen näkymä Build Enginelle, ei rakennuslogiikan ainoa käyttöliittymä.
- Builder löytää moduulit manifesteista, ratkaisee riippuvuudet ja ristiriidat, tarkistaa targetin sekä tuottaa komposition ja raportin.
- Valitsematon koodi, Build Engine ja Full View eivät tule kohdekompositioon automaattisesti.

**Alustava hyväksymisnäyttö:**
- Uusi kelvollinen USER-moduuli löytyy ilman builderin lähdekoodin muuttamista.
- Kaksi eri moduulivalintaa tuottavat kaksi erilaista toimivaa kompositiota.
- Puuttuva riippuvuus tai kohdealustaristiriita ilmoitetaan eksplisiittisesti; ei hiljaista fallbackia.
- Buildistä syntyy jäljitettävä raportti (versiot, valinnat, target, riippuvuudet ja todentamistulokset).

## Ei vielä vahvistettu

- AIGMos 1.8:n todellinen riippuvuus- ja muistiprofiili.
- Minimal STATE:n yksityiskohtainen sisältö ja `#`-puutilan lopullinen sijoitus.
- Persistence-mekanismi ja turvallinen käynnistys/resetointi targeteittain.
- LMTS UI -palikan täsmällinen rajapinta.
- USE/USER-manifestin lopullinen formaatti ja build-artefaktin tarkka muoto.

Nämä ovat avoimia päätöksiä, eivät valmiita spesifikaatioita.
