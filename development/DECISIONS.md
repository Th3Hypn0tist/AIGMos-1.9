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

## Avoimet päätökset

- **O-001:** `#`-puutilan sijoitus: Core vai USE? Lähtöhypoteesi on USE, ei vielä lukittu.
- **O-002:** STATE:n minimisemantiikka ja datan elinkaari.
- **O-003:** `&`-rutiinien tallennus sekä sähkökatkosta palautuminen.
- **O-004:** Moduulimanifestin lopullinen skeema, rekisteröinti ja versiointikäytännöt.
- **O-005:** View-rajapinnan ja LMTS UI -palikan täsmällinen toteutussopimus.
- **O-006:** ESP32-C6:n firmware-tuki, suoritusympäristö ja mitatut resurssirajat.
- **O-007:** Build-tuloksen muoto (MicroPython-paketti tai valmis firmware-image).
- **O-008:** CPythonin ja MicroPythonin yhteisen koodipohjan tosiasialliset rajat.

## Kehitysehdotus vs. toteutettu

AIGMos 1.9 self-projection -dokumentti v0.1.0 on kehitysehdotus. Aiemmista suunnitelmista johdetut käyttö- ja hyväksymiskriteerit kirjataan tavoitteiksi, kunnes lähdekoodi ja testitulokset todentavat ne. Ei hiljaisia arkkitehtuurioletuksia.
