# AIGMos 1.9 — Goals

## Päätavoite

AIGMos 1.8 modularisoidaan niin, että yhteinen **Minimal Core** toimii ESP32-C6-N16-ympäristössä. Tämän jälkeen LMTS:n UI-komponentti integroidaan valinnaiseksi View-toteutukseksi ja sen päälle rakennetaan AIGMos:n oma self-projection-build-työkalu.

## Phase 1 — Minimal Core / ESP32-C6

**Tavoite:** ajaa mahdollisimman pieni, toimiva AIGMos samalla yhteisellä Core-arkkitehtuurilla myös rajoitetulla laitteella.

Pakollinen Core:
- INPUT: Input-moduulit voivat päivittää STATEa suoraan, ilman CS-parseria.
- STATE: Coren tarvitsema minimaalinen tila.
- TER: Trigger (`!`) → Event (`@`) → Runner (`%`).
- CS: yhteinen komentojen suorituspinta, myös Eventin välittämille komennoille.
- `&`: Runneriin kuuluva järjestetty CS-komentojen rutiinilista; **pakollinen Core-ominaisuus**, ei USE-moduuli.

Periaate: Triggeriin voidaan sitoa useita Eventtejä; yksittäinen Event välittää yhden CS-komennon. Runner suorittaa komennon/rutiinin CS:n kautta. Yllä oleva on suunnittelutavoite, jonka vastaavuus nykyiseen 1.8-toteutukseen on tutkittava.

**Alustava hyväksymisnäyttö:**
- C6-N16 käynnistää Minimal Coren ilman PSRAMia.
- INPUT → STATE → TER → CS -ketju ja `&`-rutiinin järjestetty suoritus toimivat.
- Core ei edellytä Full View'tä, Build Engineä eikä yksittäisiä USER-moduuleja.
- Muistin käyttö, firmware/flash-koko, käynnistys ja keskeinen suoritusaika mitataan todellisella laitteella.
- CPython- ja MicroPython-yhteensopivuus tarkistetaan soveltuvilla yhteisillä testeillä.

## Phase 2 — LMTS UI as View

**Tavoite:** LMTS:n kehityksessä uudelleenkäytettäväksi suunniteltu käyttöliittymäpalikka integroidaan **yhdeksi** AIGMos View -toteutukseksi.

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

## Myöhempi suunta: AIGMos 2.0

Aiemmin suunnitellut ylemmän tason moduulit, kompositiot ja domainit säilyvät vaatimusaineistona. Niitä ei toteuteta 1.9:n pakollisina Core-riippuvuuksina.

## Ei vielä vahvistettu

- AIGMos 1.8:n todellinen riippuvuus- ja muistiprofiili.
- Minimal STATE:n yksityiskohtainen sisältö ja `#`-puutilan lopullinen sijoitus.
- Persistence-mekanismi ja turvallinen käynnistys/resetointi targeteittain.
- LMTS UI -palikan täsmällinen rajapinta.
- USE/USER-manifestin lopullinen formaatti ja build-artefaktin tarkka muoto.

Nämä ovat avoimia päätöksiä, eivät valmiita spesifikaatioita.
