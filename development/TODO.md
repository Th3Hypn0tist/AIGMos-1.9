# AIGMos 1.9 — TODO

Tilat: `[ ]` avoin · `[x]` toteutettu ja todennettu. Tehtäviä ei kuitata valmiiksi pelkän suunnitelman perusteella.

## P0 — Minimal Core, ensin

- [ ] Hanki/tarkasta AIGMos 1.8:n lähtökoodi ja määritä siirrettävä lähtöversio.
- [ ] Inventoi 1.8:n moduulit, importit, käynnistysketju ja alustariippuvuudet.
- [ ] Mittaa 1.8:n nykyiset RAM-/flash-/käynnistysvaatimukset soveltuvassa testissä.
- [ ] Erottele pakolliset Core-toiminnot: INPUT, STATE, TER, CS, Runnerin `&`.
- [ ] Luokittele muu toiminnallisuus valinnaiseksi USE- tai USER-moduuliksi; kirjaa perustelut.
- [ ] Selvitä `#`-rakenteisen puutilan ja `&`-rutiinien toteutusriippuvuudet; `&` pysyy Coressa.
- [ ] Irrota Full View, valinnaiset palvelut ja ylimääräiset paketit Coresta.
- [ ] Varmista, ettei Core importoi Build Engineä, Full View'tä tai USER-moduuleja.
- [ ] Määritä minimaalisen STATE:n datamalli, rekisteröinti ja elinkaari.
- [ ] Määritä INPUT-moduulin suora STATE-päivitys ilman CS-parseria.
- [ ] Toteuta/todenna Trigger → Event → Runner → CS -ketju ja usean Eventin sidonta.
- [ ] Toteuta/todenna `&`-arrayn komennot järjestyksessä CS:n kautta.
- [ ] Määritä C6-N16:n MicroPython-firmware-/ominaisuusrajoitukset ja muisti-/flash-budjetti.
- [ ] Suorita yhteiset Core-käyttäytymistestit CPythonissa ja ESP32-C6:lla.
- [ ] Mittaa C6-laitteella RAM, flash, käynnistys, toimintaviiveet; dokumentoi mittaustapa.
- [ ] Todenna C6-Minimal Coren hyväksymiskriteerit.

## P1 — LMTS UI → AIGMos View

- [ ] Tarkasta LMTS:n UI-palikan nykyinen koodi ja jo suunniteltu irrotettava rajapinta.
- [ ] Määritä View-moduulin rajapinta ja riippuvuudet ilman Coreen tehtävää View-sidosta.
- [ ] Integroi LMTS UI yhden View-toteutuksen pohjaksi.
- [ ] Todenna View'n käynnistys, irrotettavuus ja Core-only-ajon toiminta.
- [ ] Dokumentoi View-integraation esimerkit ja testit.

## P2 — Self-Projection Build

- [ ] Formalisoi USE-/USER-moduulien manifesti (identiteetti, versio, tarjoaa/vaatii, target, entrypointit, riippuvuudet).
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

- AIGMos 2.0:n kaikkien metamoduulien toteutus.
- LLM:n vaatimus ohjausketjuun.
- Build Engine tai Full View pakollisena sulautetussa Core-runtimeympäristössä.
