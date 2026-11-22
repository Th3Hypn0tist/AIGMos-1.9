# AIGMos 1.9 — Development

Tämä hakemisto kokoaa AIGMos 1.9:n **tavoitteet, tehtävät ja arkkitehtuuripäätökset**.

**Nykyinen aktiivinen työ:** AIGMos 1.8:n toiminnasta johdettava MicroPython-yhteensopiva Hardcore (vaihe 1). Sen jälkeen Core Modules, System Modules, Build Tool ja vasta lopuksi varsinainen ESP32-C6-build ja mittaukset. Katso ensisijainen [ROADMAP.md](ROADMAP.md).

- [ROADMAP.md](ROADMAP.md) — ensisijainen viisivaiheinen toteutusjärjestys ja C6:n Expose/Transport-valinnat
- [GOALS.md](GOALS.md) — taustatavoitteet ja aiemmat hyväksymiskriteerit (vaiheistusksessa ROADMAP.md on ensisijainen)
- [TODO.md](TODO.md) — toteutettava työ vaiheittain
- [DECISIONS.md](DECISIONS.md) — vahvistetut linjaukset ja avoimet päätökset
- [REUSED_SPECS.md](REUSED_SPECS.md) — ainoat aiemmista 2.0-määrityksistä säilytettävät kokonaisuudet: USER ja Expose
- [SYSTEM_MODULES.md](SYSTEM_MODULES.md) — 1.8:n hajallaan olevien SYSTEM-moduulien yhtenäistämis- ja migraatiomalli
- [VIEW_NAMING.md](VIEW_NAMING.md) — View on kompositio; nykyisille View-moduuleille valittu nimi Panel sekä migraatiokysymykset

- [RISKS.md](RISKS.md) — 1.8-lähdekoodista tunnistetut modularisoinnin riskit ja migraation estoehdot
- [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md) — kerroksittaiset riippuvuussäännöt, ei piiloriippuvuuksia
- [CORE_SPLIT.md](CORE_SPLIT.md) — 1.8-koodista johdettu kovaytimen ja modularisoitavien osien hakemistopuu

## Roadmap (järjestys)

**Voimassa oleva vaiheistus:** **Core → Core Modules → System Modules → Build Tool → ESP32-C6 Build**.

Katso [ROADMAP.md](ROADMAP.md). C6-buildissä Expose/Transport voidaan valita: Serial, Telnet sekä ehdollisesti Web + REST, jos todellinen laitteella mitattu resurssibudjetti riittää. Tämä korvaa aiemman kolmivaiheisen järjestyksen.

## Ehdoton riippuvuussääntö

**Piiloriippuvuuksia ei sallita.** Neljä moduulien riippuvuusluokkaa: **Core-moduuli → vain Core-alustan palvelut** (esim. `# → CORE.STATE`), ei toisia Core-moduuleita; **System → Core**; **AIGM User → Core ja System**, ei ulkoisia; **User → mitä tahansa**, mutta kaikki riippuvuudet on ilmoitettava manifestissa. Core-perusta erotetaan Core-moduuleista. Validointi hylkää sekä ilmoittamattomat että luokkarajoja rikkovat riippuvuudet. Pakollinen hyväksymisportti: [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md).

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
- Nykyisen toteutuksen toimivuus varmennetaan regressiotestein ennen optimointia ja sen jälkeen. Vältetään tarpeetonta uudelleenkirjoitusta.
- Kehitystehtävät rajataan **AIGMos 1.9:n** tarpeisiin: nykyinen 1.8-koodipohja, optimointi, modularisointi, myöhemmin View ja Build.
- SYSTEM-moduulit organisoidaan yhtenäisen `system/library/`-juuren alle; moduulirakenne ja SYSTEM/USER-oikeudet pidetään erillisinä kysymyksinä.
- View tarkoittaa 1.9:ssä kokonaisen näkymän deklaratiivista rakennetta (nykyinen template), ei yksittäistä UI-moduulia. Pienemmille moduuleille on ehdotettu nimeä **Panel**; Panel-nimi on vahvistettu; vanhan locked USER-view-sopimuksen versioitu yhteensovitus on vielä auki.
- **Ainoa poikkeus aiemman 2.0-suunnittelun sivuuttamiseen:** säilytetään USER-moduulien viiden primitiivin malli sekä Expose-kokonaisuuden valmiit sopimukset. Katso REUSED_SPECS.md. Muuta 2.0-arkkitehtuuria ei tuoda mukaan.

Lähtöaineisto: *AIGMos 1.9 — sisäinen kompositio- ja self-projection-build-järjestelmä*, kehitysehdotus v0.1.0 (ei toteutusraportti).
