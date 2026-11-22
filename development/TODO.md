# AIGMos 1.9 — TODO

Tilat: `[ ]` avoin · `[x]` toteutettu ja todennettu. Tehtäviä ei kuitata valmiiksi pelkän suunnitelman perusteella.

## Aktiivinen työ: AIGMos 1.8:n optimointi ja modularisointi

P0 on ainoa aktiivinen toteutusvaihe. P1 ja P2 säilyvät 1.9-roadmapissa myöhempinä vaiheina.

## P0 — Minimal Core, ensin

- [ ] Hanki/tarkasta AIGMos 1.8:n lähtökoodi ja määritä siirrettävä lähtöversio.
- [ ] Kirjaa 1.8:n nykyiset käyttäytymiset, käytössä olevat komennot, rajapinnat ja regressiotestien lähtötaso.
- [ ] Korjaa tai validoi `RISKS.md`-auditoinnin R-01–R-08 riskit ennen laajaa tiedostojen siirtoa (View/Panel-sopimus, bootstrap-importit, loader-polut, template-semanttiikka, UI-dispatch, moduuli-identiteetit, MicroPython-discovery, polkurajat).
- [ ] Määritä mitattava optimointibaseline (RAM, flash/paketin koko, käynnistysaika, suoritusaika sekä mittausympäristö).
- [ ] Inventoi 1.8:n moduulit, importit, käynnistysketju ja alustariippuvuudet.
- [ ] Inventoi myös resurssit, ulkoiset palvelut, dynaamiset importit, implisiittinen aktivointi ja ehdolliset riippuvuudet; dokumentoi todellinen riippuvuusverkko.
- [ ] Erota Core-alustan palvelut (esim. `CORE.STATE`) Core-moduuleista (esim. `#`) ja dokumentoi niiden julkiset rajapinnat.
- [ ] Määritä jokaisen moduulin riippuvuusluokka: Core Module, System Module, AIGM User Module tai User Module.
- [ ] Kirjaa kaikki suorat riippuvuudet jokaisen moduulin manifestiin, mukaan lukien `# → CORE.STATE`.
- [ ] Ota `DEPENDENCY_RULES.md` pakolliseksi **FAIL**-portiksi: ilmoittamaton riippuvuus, Core-moduuli→Core-moduuli, kielletty kerrosriippuvuus, tuntematon provider, väärä target tai yllättävä import estää buildin.
- [ ] Testaa, että AIGM User -moduuli ei voi ottaa ulkoista riippuvuutta, mutta User-moduulin manifestoitu ulkoinen riippuvuus hyväksytään, kun target- ja käyttöoikeusvaatimukset täyttyvät.
- [ ] Toteuta/todenna resolverin deterministinen transitiivinen riippuvuussulkeuma ja riippuvuuksien syyketjut.
- [ ] Lisää Minimal Core -testi, jossa kaikki valinnaiset moduulit ja View on fyysisesti poistettu; ei implisiittisiä latauksia.
- [ ] Tee `SYSTEM_MODULES.md`-dokumentin mukainen SYSTEM-module/engine/resource-inventaario; selvitä `system/cs/commands`, `system/inputs`, `system/adapters`, `system/layout/modules` ja `system/library/layout`.
- [x] Päätä UI-moduulin uusi nimi: **Panel**. View tarkoittaa entistä template-kompositiota (päätös kirjattu; koodia ei vielä muutettu).
- [ ] Versioi USER-moduulien vanhan `type=view`-sopimuksen semanttinen muutos 1.9:ään; älä muuta lähteen locked-sopimusta hiljaisesti.
- [ ] Yhtenäistä SYSTEM-moduulipakettien sijainnit ehdotettuun `system/library/{commands,inputs,outputs,adapters,panels}/<module_id>/`-rakenteeseen ja sijoita deklaratiiviset View-määritykset `system/library/views/<view_id>/`-rakenteeseen. Panel-nimi on vahvistettu; tiedostomuoto ja manifestisopimus vahvistetaan ennen koodisiirtoja.
- [ ] Erottele View (kokonainen näkymä), Panel (yksittäinen UI-toiminto) ja valinnainen View Engine (runtime) sekä tee vanhoille `layout`, `module`, `.tmpl` ja `view` -nimille migraatiokartta.
- [ ] Päivitä moduulien discovery, importit, reload, template-resoluutio ja polkuviittaukset hallitusti; todenna regressiot.
- [ ] Selvitä ja erota Core-/engine-infrastruktuuri varsinaisista SYSTEM-moduuleista. SYSTEM-/USER-identiteetti ei yksin anna runtime-valtuuksia.
- [ ] Mittaa 1.8:n nykyiset RAM-/flash-/käynnistysvaatimukset soveltuvassa testissä.
- [ ] Erottele pakolliset Core-toiminnot: INPUT, STATE, TER, CS, Runnerin `&`; tee `CORE_SPLIT.md`:n pohjalta tiedostokohtainen riippuvuus- ja luokittelutodennus.
- [ ] Erota Core-perusta ja Core-moduulit: `#` tarvitsee `CORE.STATE`, mutta Core-moduulit eivät saa importoida toisiaan.
- [ ] Luokittele muu toiminnallisuus valinnaiseksi USE- tai USER-moduuliksi; kirjaa perustelut.
- [ ] Vertaile 1.8:n USER-moduulirakennetta aiemmin lukittuun viiteen primitiiviin: command, input, output, adapter, view.
- [ ] Selvitä valmiin USER-manifestin, #UM-namespace-eristyksen ja elinkaarisopimuksen toteutettavuus 1.8-pohjassa; säilytä sopimusten rajat.
- [ ] Inventoi 1.8:n ulkoiset web-/verkko-/human-pinnat; sovita ne Expose = nanoCMS + NetworkService -omistajuuksiin irrottamatta Minimal Coreen uusia pakollisia riippuvuuksia.
- [ ] Selvitä `#`-rakenteisen puutilan ja `&`-rutiinien toteutusriippuvuudet; `&` pysyy Coressa.
- [ ] Irrota Full View, valinnaiset palvelut ja ylimääräiset paketit Coresta.
- [ ] Tunnista todelliset muistia, koodikokoa ja käynnistystä kuormittavat rakenteet; optimoi vain havaittujen ongelmien perusteella.
- [ ] Todenna, että refaktorointi säilyttää sovitut 1.8-käyttäytymiset tai dokumentoi eksplisiittiset muutokset.
- [ ] Varmista, ettei Core importoi Build Engineä, Full View'tä tai USER-moduuleja.
- [ ] Määritä minimaalisen STATE:n datamalli, rekisteröinti ja elinkaari.
- [ ] Määritä INPUT-moduulin suora STATE-päivitys ilman CS-parseria.
- [ ] Toteuta/todenna Trigger → Event → Runner → CS -ketju ja usean Eventin sidonta.
- [ ] Toteuta/todenna `&`-arrayn komennot järjestyksessä CS:n kautta.
- [ ] Määritä C6-N16:n MicroPython-firmware-/ominaisuusrajoitukset ja muisti-/flash-budjetti.
- [ ] Suorita yhteiset Core-käyttäytymistestit CPythonissa ja ESP32-C6:lla.
- [ ] Mittaa C6-laitteella RAM, flash, käynnistys, toimintaviiveet; dokumentoi mittaustapa.
- [ ] Todenna C6-Minimal Coren hyväksymiskriteerit.

## P1 — LMTS UI → AIGMos View Engine / renderer

Edellytys: P0:n View/Panel-nimeämisen migraatio ja erilliset moduuli-/View-discoveryt on toteutettu ja testattu.

- [ ] Tarkasta LMTS:n UI-palikan nykyinen koodi ja jo suunniteltu irrotettava rajapinta.
- [ ] Määritä View-renderöintitoteutuksen rajapinta ilman Coreen tehtävää View-sidosta; sovita se uusiin View/Panel-käsitteisiin ja Expose-rajaukseen.
- [ ] Integroi LMTS UI yhden View-toteutuksen pohjaksi.
- [ ] Todenna View'n käynnistys, irrotettavuus ja Core-only-ajon toiminta.
- [ ] Dokumentoi View-integraation esimerkit ja testit.

## P2 — Self-Projection Build

- [ ] Ota pohjaksi aiempi lukittu USER module.json -sopimus; määritä 1.9:n buildin target-/riippuvuustietojen tarvitsemat lisäkentät eksplisiittisesti muuttamatta lähtösopimusta hiljaisesti.
- [ ] Toteuta moduulien rekisteröinti/discovery ilman builderin lähdekoodimuutoksia.
- [ ] Toteuta deterministinen riippuvuusratkaisu ja ristiriitojen näkyvä raportointi.
- [ ] Määritä target-profiilit ja kyvykkyys-/resurssivalidaatio (C6 ensimmäisenä).
- [ ] Toteuta Build Engine valinnaiseksi USE-moduuliksi ja tarjoa CS-rajapinta.
- [ ] Toteuta LMTS-pohjaiseen View'hun `|BUILD`-näkymä.
- [ ] Muodosta valittujen moduulien koodi ja riippuvuudet sisältävä rajattu kompositio.
- [ ] Määritä target-paketointi, firmware-työkaluketjun kutsu ja artefaktin muoto.
- [ ] Tuota build-manifesti, lukittu riippuvuusjoukko ja jäljitettävyysraportti.
- [ ] Todenna discovery, kaksi erilaista kompositiota, ristiriitatilanteet ja ylimääräisen runtimen poissulku.

## Avoimet kysymykset

- [ ] Valitaanko ja miten valinnainen `#` toteutetaan?
- [ ] Mitkä pysyvyystoiminnot kuuluvat Coreen ja mitkä USEen?
- [ ] Mitkä ovat ESP32-C6:n MicroPythonin todelliset rajoitteet käytettävällä firmwarella?
- [ ] Mikä on LMTS View -palikan tarkka kytkentäsopimus?
- [ ] Missä muodossa ensimmäinen self-projection-tuotos toimitetaan?

## Ei tässä vaiheessa

- LLM:n vaatimus ohjausketjuun.
- Build Engine tai Full View pakollisena sulautetussa Core-runtimeympäristössä.
