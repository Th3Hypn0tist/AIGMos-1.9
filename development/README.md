# AIGMos 1.9 — Development

Tämä hakemisto kokoaa AIGMos 1.9:n **tavoitteet, tehtävät ja arkkitehtuuripäätökset**.

- [GOALS.md](GOALS.md) — tavoitetila, vaiheistus ja hyväksymiskriteerit
- [TODO.md](TODO.md) — toteutettava työ vaiheittain
- [DECISIONS.md](DECISIONS.md) — vahvistetut linjaukset ja avoimet päätökset

## Roadmap (järjestys)

1. **Minimal Core / ESP32-C6:** modularisoidaan AIGMos 1.8:n ylimääräinen toiminnallisuus irti Coresta, kunnes minimi toimii ESP32-C6-N16:lla.
2. **LMTS View:** integroidaan LMTS:n käyttöliittymäpalikka yhdeksi valinnaiseksi AIGMos View -toteutukseksi.
3. **Self-Projection Build:** rakennetaan tälle käyttöliittymälle `|BUILD` ja sen taustalle itsenäinen Build Engine, joka muodostaa rajattuja kompositioita valituista moduuleista.

Vaiheet toteutetaan tässä järjestyksessä. Uusia ominaisuuksia ei saa käyttää perusteluna Minimal Coren kasvattamiselle.

## Rajat

- **AIGM** on alustariippumaton standardi; **AIGMos** sen tekninen referenssitoteutus.
- **TER** (Trigger → Event → Runner) on AIGMos:n sisäinen toimintamekanismi, ei AIGM-standardin pakollinen piirre.
- **Core:** INPUT, STATE, TER ja CS. Runnerin `&`-rutiinilista kuuluu Coreen.
- **USE:** valinnaiset järjestelmämoduulit, esimerkiksi Full View ja Build Engine.
- **USER:** käyttäjän asentamat/kehittämät toiminnallisuus- ja Input-moduulit.
- **View ja Build Engine eivät ole Minimal Coren riippuvuuksia.**
- Dokumentoitu tavoite ei tarkoita valmista toteutusta: hyväksyntä edellyttää testinäyttöä.

## Työtapa

- Pidetään tehtävätila eksplisiittisenä: `[ ]` avoin, `[x]` valmis vain todennetun tuloksen jälkeen.
- Kirjataan todelliset riippuvuudet, alustarajoitukset ja mittaustulokset. Tuntemattomia ei päätellä nimistä tai hakemistorakenteesta.
- Muutokset, jotka muuttavat Coren rajoja, moduulivastuita tai roadmapia, kirjataan DECISIONS.md-tiedostoon.
- Aiempi 2.0-suunnittelu on tavoite- ja vaatimusaineistoa, ei peruste pakottaa vanhaa toteutusrakennetta 1.9:n Coreen.

Lähtöaineisto: *AIGMos 1.9 — sisäinen kompositio- ja self-projection-build-järjestelmä*, kehitysehdotus v0.1.0 (ei toteutusraportti).
