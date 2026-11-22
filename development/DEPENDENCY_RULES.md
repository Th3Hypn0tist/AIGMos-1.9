# AIGMos 1.9 — Dependency Rules

**Tila:** riippuvuusrajat päätetty; migraatio ja tekninen validaattori vielä `unlocked`.  
**Kohde:** AIGMos 1.9:n 1.8-pohjainen modularisointi. Nämä ovat tämän toteutuksen rajat, eivät sellaisenaan uusi alustariippumattoman AIGM-standardin määräys.  
**Perussääntö:** **ZERO HIDDEN DEPENDENCIES** — jokainen riippuvuus ilmoitetaan moduulin manifestissa. Manifesti ei kuitenkaan saa oikeuttaa kiellettyä riippuvuutta.

## 1. Core vs. Core-moduulit — tärkeä ero

**Core** on yhteinen minimaalinen ajonaikainen perusta, jonka vakaisiin rajapintoihin kuuluu mm. `CORE.STATE`. Muut Core-palvelut ja niiden tarkka API-jako täsmennetään 1.8-koodin analyysissä.

**Core-moduuli** on tähän perustaan tukeutuva rajattu moduuli. Se:

- **saa riippua Coresta ja sen julkisista palveluista** (esimerkiksi `CORE.STATE`);
- **ei saa riippua toisesta Core-moduulista** suoraan eikä välillisesti;
- **ei saa riippua System-, AIGM User-, User- tai ulkoisista moduuleista**.

**Esimerkki:** `#` tarvitsee Coren `STATE`-palvelun.

```text
      ┌─────────────────────┐
      │ CORE                │
      │  └── STATE API      │
      └──────────▲──────────┘
                 │ sallittu
       ┌─────────┴─────────┐
       │ CORE MODULE: #    │
       └───────────────────┘

CORE MODULE: # ──► CORE MODULE: toinen   KIELLETTY
```

Tässä `STATE API` kuuluu **Core-perustaan**, eikä sitä luokitella erilliseksi *toiseksi Core-moduuliksi* tämän riippuvuussäännön vastaisesti. Näin `# → CORE.STATE` on sallittu ja `# → jokin toinen Core-moduuli` on kielletty.

**Moduulien yhteistoiminta ei tarkoita keskinäistä moduuliriippuvuutta.** Mahdollinen viestinvälitys, STATE-luku/kirjoitus tai Coreen kuuluvan CS-pinnan käyttö kulkee Coren vakaan rajapinnan kautta. Core-alustan API:a ei kuitenkaan saa käyttää kiertotienä toisen Core-moduulin piilokutsuun.

## 2. Neljä riippuvuusluokkaa

| Riippuva moduuli | Sallitut moduuli- ja palveluriippuvuudet | Kielletyt riippuvuudet |
|---|---|---|
| **CORE MODULE** | **CORE** (sen julkiset API:t ja perustason palvelut, esimerkiksi `CORE.STATE`) | Toiset Core-moduulit; System; AIGM User; User; ulkoiset |
| **SYSTEM MODULE** | **CORE** ja sen Core-moduulien määritellyt rajapinnat | AIGM User; User; ulkoiset. System→System ei ole erikseen sallittu tässä rajauksessa |
| **AIGM USER MODULE** | **CORE** ja **SYSTEM** sekä niiden määritellyt rajapinnat | Ulkoiset kirjastot, palvelut ja moduulit riippuvuuksina; tavalliset USER-moduulit. AIGM User→AIGM User ei ole erikseen sallittu tässä rajauksessa |
| **USER MODULE** | **Mikä tahansa**, myös ulkoiset kirjastot, moduulit ja palvelut | Ei alkuperään perustuvaa riippuvuusrajoitusta — manifesti, yhteensopivuus ja erilliset käyttöoikeussäännöt ovat edelleen pakollisia |

**System→System- ja AIGM User→AIGM User -riippuvuuksien asema:** käyttäjän nimenomaisesti luettelemat sallitut riippuvuuskohteet eivät vielä sisällä samantasoista moduuliriippuvuutta. Siksi näitä ei automaattisesti sallita tulkinnalla, vaan mahdollinen poikkeus tarvitsee eksplisiittisen päätöksen. Tämä ei estä saman tason moduuleja käyttämästä yhteistä Core-palvelua.

### Riippuvuuden ja käyttöoikeuden ero

**USER MODULE saa olla riippuvainen mistä tahansa**, mutta tämä ei automaattisesti anna sille oikeutta muuttaa SYSTEM-tilaa, kiertää hyväksyntää tai suorittaa mielivaltaisia operaatioita järjestelmäoikeuksin. Manifestin `requires` kertoo **tarpeesta**, ei oikeuden myöntämisestä; valtuutus, effect policy ja palveluiden rajapinnat tarkistetaan erikseen. Näitä ei pidä sekoittaa moduuliriippuvuuksien kerrosrajoihin.

**AIGM USER** ja **USER** ovat kaksi eri riippuvuusluokkaa. Ne eivät ole sama luokka kahdella eri nimellä, vaikka käyttävät yhteistä moduulipakettimallia.

## 3. Riippuvuudet ovat manifestissa — aina

Jokaisella moduulilla, **myös Core-moduulilla**, on oma manifesti, joka ilmoittaa sen suorat riippuvuudet.

Tietosisältövaatimukset (ei vielä lopullinen JSON-skeema):

| Kenttä / tieto | Tarkoitus |
|---|---|
| Identiteetti | Vakaa moduulitunniste, versio, riippuvuusluokka ja toiminnallinen tyyppi (command/input/output/adapter/panel...) |
| `requires` | Kaikki pakolliset **suorat** riippuvuudet: Core API, muu sallittu moduuli, resurssi, palvelu tai ympäristöominaisuus |
| `optional_requires` | Ehdolliset riippuvuudet, aktivointiehto ja puuttumisen eksplisiittinen käyttäytyminen |
| `provides` | Julkiset rajapinnat ja capabilityt, joita muut saavat käyttää |
| `target_requirements` | CPython/MicroPython, firmware, stdlib, ajuri, OS-palvelu, laiteperiferia, resurssibudjetti |
| `resources` | Tiedostot, Viewt, Panelit, konfiguraatiot, template-/dataresurssit, ulkoiset sidonnat |
| `entrypoints`, `lifecycle`, `tests` | Lataus, käynnistys, pysäytys ja tarkistukset |

**Core-moduulin ulkoinen runtime-paketti on kielletty,** vaikka se merkittäisiin manifestiin. Kohdealustan sisäänrakennettu API on eri asia kuin erikseen lisättävä kolmannen osapuolen riippuvuus. Alustavaatimukset on silti kirjattava.

Manifestin luokka ratkaisee, mitä riippuvuusreunoja saa olla. Hakemistopolku `system/library/` tai `library/` ei yksin määrää luokkaa eikä oikeuksia. Lähdespesifikaation mahdollinen ero merkitään 1.9:n versioituun manifestisopimukseen; locked-lähdetiedostoja ei muokata hiljaisesti.

## 4. Validointisääntö

Validaattori käy läpi kaikki moduulit ennen rakentamista ja tarkistaa:

1. **Manifestin läsnäolo:** moduulilta puuttuva manifesti tai tuntematon riippuvuusluokka → **FAIL**.
2. **Sallitut reunat:** jokainen `requires`-reuna verrataan yllä olevaan kerrosrajaan → kielletty reuna **FAIL**, vaikka se olisi ilmoitettu.
3. **Core-moduulien riippumattomuus:** `Core-moduuli → Core-moduuli` suoraan tai transitiivisesti → **FAIL**. `Core-moduuli → CORE.STATE` → sallittu, jos manifestissa ilmoitettu.
4. **Koko riippuvuusverkko:** riippuvuuksien tarjoajat, identiteetit, versiot, ehdot ja transitiivinen sulkeuma ratkaistaan deterministisesti. Tuntematon tai ristiriitainen tarjoaja → **FAIL**.
5. **Todellinen käyttö:** staattiset ja ehdolliset importit, palvelukytkennät, tiedostot, resurssit ja käynnistysaikaiset vaikutukset verrataan manifestiin. Ilmoittamaton riippuvuus → **FAIL**.
6. **Kielletyn riippuvuuden transitiivinen vuoto:** esimerkiksi AIGM User→System→ulkoinen olisi **FAIL** jo System→ulkoinen-reunan vuoksi.
7. **Alustan tarkistus:** CPython-yhteensopivuus ei kelpaa todistukseksi MicroPython/ESP32-C6-yhteensopivuudesta; kohteen puuttuva ominaisuus → **FAIL**.
8. **Oikeudet erillään:** moduulin riippuvuuden löytyminen ei anna oikeutta käyttää sen rajapintaa ilman sallittua operation/capability-sidontaa.
9. **Karsinta:** kohdeartefaktiin sisällytetään vain valittu Core-perusta, valitut moduulit ja niiden eksplisiittiset transitiiviset riippuvuudet ja resurssit.
10. **Negatiiviset testit:** jokainen kielletty kerrosreuna testataan, mukaan lukien samantasoiset Core-moduulit sekä manifestiin oikein kirjattu mutta **kielletty** ulkoinen riippuvuus.

### Esimerkkitulokset

```text
# -> CORE.STATE                             PASS (manifestissa)
# -> toinen CORE MODULE                    FAIL
SYSTEM.osc -> CORE.STATE                   PASS (manifestissa)
AIGM_USER.panel -> SYSTEM.view_engine      PASS (manifestissa)
AIGM_USER.example -> external.requests     FAIL
USER.custom -> external.requests           PASS (manifestissa)
USER.custom -> external.requests           FAIL (ei manifestissa)
```

## 5. Toteutuksen työjärjestys

- [ ] Kartoitus: 1.8:n todellinen Core-perusta ja sen palvelut, mukaan lukien `STATE`.
- [ ] Erota Core-alustan palvelut (`CORE.STATE` jne.) toisistaan riippumattomista Core-moduuleista.
- [ ] Luokittele `#`:n ja muiden nykyisten symboli-/komentototeutusten omistajuus ja vaaditut Core-rajapinnat.
- [ ] Lisää joka moduulille eksplisiittinen manifesti ja kerrosluokka.
- [ ] Toteuta sallittujen reunojen validaattori ennen laajaa siirtotyötä.
- [ ] Todista Core-moduulien keskinäinen riippumattomuus import-/call-/resurssitestein.
- [ ] Tarkista SYSTEM- ja AIGM USER -moduulien sulkeumista ulkoiset riippuvuudet.
- [ ] Todenna vapaan USER-moduulin ulkoisten riippuvuuksien manifesti-, target- ja lupatarkistus.
- [ ] Todenna regressiot ja ESP32-C6:n valitun komposition todelliset resurssikulut.

**Hyväksyntä:** ei piiloriippuvuuksia, ei kiellettyjä riippuvuuksia, ei automaattista oikeuksien laajentamista. Sopimuksen kirjautuminen dokumentaatioon ei tarkoita, että 1.8-koodi olisi jo tämän mukainen.
