# AIGMos 1.9 — Architecture decisions

Tämä tiedosto erottaa **vahvistetut** linjaukset ehdotuksista ja avoimista suunnittelukysymyksistä. Kirjaus ei muuta AIGM- tai CW-standardia.

## Vahvistetut linjaukset

### D-001 — 1.9:n varsinainen kehitysrepo
**Päätös:** `Th3Hypn0tist/AIGMos-1.9` on 1.9-kehityksen repository.

### D-002 — Kehityksen vaiheistus
**Päätös:** (1) modularisoi Core ESP32-C6:lle; (2) integroi LMTS UI yhdeksi View-toteutukseksi; (3) toteuta build-työkalu tämän käyttöliittymän päälle.

### D-003 — Pakollinen Core
**Päätös:** INPUT, STATE, TER ja CS muodostavat Minimal Coren.

### D-004 — `&` kuuluu Coreen
**Päätös:** `&` on Runnerin olennainen, järjestetty komentolista (array). Se on pakollinen Core-toiminto, **ei** valinnainen USE-moduuli. Tämä täsmentää aiemman 1.9-kehitysehdotuksen avointa kohtaa.

### D-005 — Valinnainen View
**Päätös:** LMTS:n UI-komponentista tehdään yksi vaihtoehtoinen View-moduulin toteutus. Minimal Core ei tarvitse Full View'tä.

### D-006 — Build-työkalun sijoitus
**Päätös:** Build-työkalu tehdään LMTS-pohjaiseen View-toteutukseen. Build Engine pidetään erillisenä valinnaisena USE-moduulina, jonka toiminta ei saa riippua yksinomaan käyttöliittymästä.

### D-007 — Standardi ja toteutus erillään
**Päätös:** AIGM on alustariippumaton standardi; AIGMos on referenssitoteutus. TER on AIGMos:n mekanismi eikä AIGM-yhteensopivuuden ehto.

### D-008 — Nykyinen kehitysfokus on 1.8-pohjainen optimointi ja modularisointi
**Päätös:** 1.9 rakennetaan nykyisen AIGMos 1.8 -toteutuksen pohjalta. Ensimmäinen ja ainoa aktiivinen vaihe on 1.8:n riippuvuuksien kartoitus, Coren modulaarinen irrotus ja mitattava optimointi ESP32-C6-N16-tavoitetta varten. Uudelleenkirjoitus ei ole itseisarvo. LMTS View ja Build Engine jäävät myöhemmiksi 1.9-vaiheiksi.

### D-009 — Vain 1.9:n toteutustarpeet ohjaavat nykyistä kehitystä
**Päätös:** Ei oteta tulevien tuoteversioiden uusia moduleita, domain-kompositioita tai arkkitehtuurivaatimuksia tämänhetkiseen työlistaan. Valmis 1.9-modularisointi tuottaa myöhemmin uudelleenkäytettävän pohjan ilman ennakoivaa laajentamista.

### D-010 — Aiemmista määrityksistä säilytetään vain USER ja Expose
**Päätös:** Aiemmista 2.0-määrityksistä tuodaan AIGMos 1.9:ään **vain** (1) USER-moduulien järkeistetty viiden primitiivin malli sopimuksineen ja (2) Expose-kokonaisuus (nanoCMS + NetworkService). Näiden valmista määrittelytyötä ei toisteta. Lähdespesifikaatioiden sisältö ja Git-revisio on dokumentoitu [REUSED_SPECS.md](REUSED_SPECS.md). Kaikki muut 2.0-määritykset jäävät pois 1.9:n kehitysscopesta. Lähteen locked-tila ei tarkoita, että 1.9-integraatio olisi tehty.

### D-011 — SYSTEM-moduulien yhtenäinen hakemistorakenne
**Päätös:** 1.8:n hajallaan olevat SYSTEM-moduulien toteutukset ja omat resurssit kootaan yhden `system/library/`-juuren alle. View tarkoittaa jatkossa nykyistä deklaratiivista näkymätemplatea; sen pienemmät toteutusmoduulit saavat erillisen nimen (ehdotus: widget). Alustavat juuret: `system/library/{commands,inputs,outputs,adapters,widgets}/<module_id>/` ja `system/library/views/<view_id>/`. Core-/engine-koodi ei muutu moduuleiksi pelkän polkusiirron vuoksi. SYSTEM- ja USER-moduulien oikeudet pidetään eksplisiittisesti erillään. Todelliset vanhat polut, lataajat sekä migraatio on kuvattu [SYSTEM_MODULES.md](SYSTEM_MODULES.md). Yhdenmukaistaminen on sovittu tavoite; lopullinen pienmoduulin nimi ja tiedostomuoto ovat avoimia ja migraatio on vielä toteuttamatta.

### D-012 — View tarkoittaa kompositiota, ei pienmoduulia
**Päätös:** 1.9:n **View** on nykyistä View-templatea vastaava kokonainen, deklaratiivinen näkymä, joka koostuu pienemmistä UI-moduuleista. Näiden UI-moduulien uusi nimi on vielä avoin; **Widget** on ehdotus. Nykyinen `system/layout/modules/*.py` ja `system/library/layout/*.tmpl` erotetaan omiin tehtäviinsä. Mahdollinen `view → widget` -tyyppimuutos poikkeaa aiemmasta lukitusta USER-sopimuksesta ja tehdään vain eksplisiittisenä, versionhallittuna 1.9-muutoksena. Ks. [VIEW_NAMING.md](VIEW_NAMING.md).

## Avoimet päätökset

- **O-001:** `#`-puutilan sijoitus: Core vai USE? Lähtöhypoteesi on USE, ei vielä lukittu.
- **O-002:** STATE:n minimisemantiikka ja datan elinkaari.
- **O-003:** `&`-rutiinien tallennus sekä sähkökatkosta palautuminen.
- **O-004:** Moduulimanifestin lopullinen skeema, rekisteröinti ja versiointikäytännöt.
- **O-005:** View-rajapinnan ja LMTS UI -palikan täsmällinen toteutussopimus.
- **O-006:** ESP32-C6:n firmware-tuki, suoritusympäristö ja mitatut resurssirajat.
- **O-007:** Build-tuloksen muoto (MicroPython-paketti tai valmis firmware-image).
- **O-008:** CPythonin ja MicroPythonin yhteisen koodipohjan tosiasialliset rajat.
- **O-009:** USER-view-primitiivin ja USE-tason LMTS View -toteutuksen rajapinnan yhteensovitus ilman Core-riippuvuutta.
- **O-010:** Expose-omistajuuksien käytännön sovittaminen nykyisen 1.8:n olemassa oleviin verkko-/web-/UI-pintoihin.
- **O-011:** Mitkä vanhat SYSTEM-toteutukset ovat oikeasti moduuleita ja mitkä Core-/View-engine-komponentteja, ja miten yhteinen discovery toteutetaan ESP32-C6:ssa resurssitehokkaasti?
- **O-012:** Hyväksytäänkö UI-pienmoduulin nimeksi Widget ja miten erotetaan sen manifesti View-kompositiosta?
- **O-013:** Vaihdetaanko vanha `.tmpl`-pääte `.view`-päätteeksi vai pidetäänkö tiedostomuoto erillisenä päätöksenä?

## Kehitysehdotus vs. toteutettu

AIGMos 1.9 self-projection -dokumentti v0.1.0 on kehitysehdotus. Aiemmista suunnitelmista johdetut käyttö- ja hyväksymiskriteerit kirjataan tavoitteiksi, kunnes lähdekoodi ja testitulokset todentavat ne. Ei hiljaisia arkkitehtuurioletuksia.
