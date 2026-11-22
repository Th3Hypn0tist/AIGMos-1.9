# AIGMos 1.9 — SYSTEM-moduulien yhtenäistäminen

**Tila:** `unlocked` — View/Panel-nimet päätetty; toteutuksen yksityiskohdat tarkistetaan 1.8:n koodia vasten.  
**Lähtöpiste:** [AIGMos 1.8 / tarkasteltu Git-revisio](https://github.com/Th3Hypn0tist/AIGMos/tree/20383e681dd49f3be33070dba41bbcdc4034ef63).  
**Aktiivinen kehitysvaihe:** P0, optimointi ja modularisointi. Ei vielä tehtyjä koodisiirtoja.

## Päätavoite

SYSTEM-moduuleilla on yksi looginen sijoituspaikka ja USER-moduulien kanssa yhteensopiva luokittelu. **View on kokonainen deklaratiivinen näkymäkompositio (nykyinen template), ei pienmoduuli.** Pienemmän UI-moduulin nimeksi on vahvistettu `panel`; manifestin tyyppimuutos ja sopimus ovat vielä avoinna. Ks. [VIEW_NAMING.md](VIEW_NAMING.md).

**SYSTEM ja USER erotetaan omistajuuden ja oikeuksien mukaan, ei viemällä niiden moduulirakenteita eri periaatteilla toteutettuihin järjestelmiin.** SYSTEM-moduuli voi tarvita rajatumpia tai laajempia järjestelmäoikeuksia kuin USER-moduuli; USER-moduulin rajoituksia ei poisteta, eikä SYSTEM saa oikeuksia pelkän tiedostopolun perusteella.

Tämä on vanhojen SYSTEM-moduulien järjestely ja latausmekanismien selkeytys. **Coreen kuuluvat suoritusmoottorit eivät automaattisesti muutu moduuleiksi.** INPUT, STATE, TER, CS ja Runnerin `&` ovat Core-rajan lähtökohta.

## 1. Todettu nykytila (1.8, yllä oleva revisio)

| Vastuu | Nykyinen polku | Havainto / migraation vaikutus |
|---|---|---|
| CS-komentototeutukset | `system/cs/commands/*.py` | `system/cs/command_registry.py` lataa kiinteät Python-paketit `system.cs.commands` ja `extensions.commands`. |
| Input-lähteet | `system/inputs/*.py` | `system/inputs/registry.py` tuntee paketit `system.inputs` ja `extensions.inputs`. |
| State-adapterit | `system/adapters/*.py` | `system/adapters/registry.py` tuntee paketit `system.adapters` ja `extensions.adapters`. Kaikki adapterit eivät välttämättä ole valinnaisia. |
| Pienet UI-moduulit (vahvistettu nimi: Panel) | `system/layout/modules/*.py` | `system/layout/loader.py` etsii moduuleja `system/layout/modules`- ja `extensions/layout/modules`-hakemistoista. |
| View-kompositiot (nykyiset templatet) | `system/library/layout/*.tmpl` | `system/layout/definitions.py` etsii templateja erillisestä hakemistosta (`extensions/layout` on toinen). |
| View/layout-ajomoottori | `system/layout/*.py` | Erillinen runtime/engine, **ei** sama asia kuin View-moduuli tai sen template. |
| Komentoparseri ja rekisteröinti | `system/cs/*.py` | Core-infrastruktuuria; ei siirretä pelkän järjestelytyön vuoksi. |
| STATE ja TER | `system/state/*.py`, `system/runtime/*.py` | Core-rajaan kuuluvat toiminnot erotetaan ennen uudelleensijoittelua. |
| Muut kirjastoaineistot | `system/library/{help,docs,prompts,roles,routines}` | Ovat pääosin tukiaineistoa, **eivät** automaattisesti uusia moduulityyppejä. |

**Nykytilan johtopäätös:** saman aihealueen moduulikoodi ja konfiguraatio-/templateaineisto ovat hajallaan. Myös moduulien discovery ja reload ovat useassa paikassa. Muutos tarvitsee muutakin kuin tiedostojen siirtämisen.

## 2. Ehdotettu hakemistorakenne

Käytetään valmiiden USER-sopimusten SYSTEM-referenssijuuren mukaista yleistä mallia `system/library/<type>/<module_id>/`, mutta erotetaan View-kompositio sen pienmoduuleista. Vahvistettu `panel`-nimi vaatii aiemman locked USER-view-sopimuksen eksplisiittisen 1.9-migraation.

```text
AIGMos-1.9/
├── system/
│   ├── cs/                  # CS parser, dispatch, registry: ei komentomoduulien varasto
│   ├── state/               # Minimal Coren state-infrastruktuuri
│   ├── runtime/             # TER- ja muut erikseen arvioitavat runtime-osat
│   ├── view/                # ehdotettu valinnaisen View Engine -ajomoottorin uusi nimi (nykyinen layout/)
│   └── library/
│       ├── commands/
│       │   └── <module_id>/
│       │       ├── module.json
│       │       ├── ...      # komennon toteutus ja omat resurssit
│       │       └── tests/
│       ├── inputs/
│       │   └── <module_id>/...
│       ├── outputs/
│       │   └── <module_id>/...
│       ├── adapters/
│       │   └── <module_id>/...
│       ├── panels/              # ehdotettu pienmoduulin nimi
│       │   └── <module_id>/
│       │       ├── module.json
│       │       ├── ...      # Panelin toteutus ja testit
│       │       └── tests/
│       ├── views/
│       │   └── <view_id>/... # deklaratiivinen View-kompositio
│       ├── help/            # ei moduuli: tukiaineisto
│       ├── docs/            # ei moduuli: tukiaineisto
│       ├── prompts/         # ei moduuli: tukiaineisto
│       ├── roles/           # ei moduuli: tukiaineisto
│       └── routines/        # ei moduuli: Runnerin &-toteutus
└── library/                 # USER-moduulien vastaava jako
    ├── commands/<module_id>/...
    ├── inputs/<module_id>/...
    ├── outputs/<module_id>/...
    ├── adapters/<module_id>/...
    ├── panels/<module_id>/...
    └── views/<view_id>/...
```

Yllä oleva on **tavoite-esitys**, ei väite 1.9:ään jo tehdyistä muutoksista. USER-kirjaston lopullinen sijoitus varmistetaan osana 1.8:n siirtoa. Esimerkin `module.json` ei tarkoita, että 1.8:n SYSTEM-moduuleilla olisi jo manifestit.

### Vastuunjako

- **Runtime-ydin:** CS-parseri, tilamoottori, TER ja mahdollinen View-ajomoottori toteuttavat mekanismin.
- **SYSTEM-moduulit:** järjestelmän mukana toimitetut, rajatusti rekisteröidyt toiminnallisuuspaketit — vastaava toiminnallisten moduulien luokittelu kuin USER-puolella, mutta View-kompositio ei ole pieni UI-moduuli.
- **USER-moduulit:** erilliset käyttäjän paketit; eivät saa SYSTEM-oikeuksia SYSTEM-rakenteen kaltaisuudesta.
- **Resurssit:** yksi moduuli omistaa omat erikoisresurssinsa ja template-sidontansa; yleinen käyttöapu/help tai yhteinen alustaomisteinen ajomoottori voi olla yhteinen resurssi.
- **View ja Panel:** 1.9:n View tarkoittaa kokonaisen näkymän deklaratiivista kompositiota. `system/layout/modules/*.py` sisältää pienempiä UI-moduuleita, joiden nimi on Panel. Aiemman lukitun `type=view`-sopimuksen muuttamista ei piiloteta polkusiirtoon; tarvitaan oma versioitu 1.9-päätös.

## Ehdoton riippuvuusraja

SYSTEM- ja USER-moduulien sijaintien yhdenmukaistaminen ei saa jättää piiloriippuvuuksia. Core-moduulit saavat käyttää vain Core-perustan palveluita (esim. `# → CORE.STATE`), eivät toisia Core-moduuleita. System-moduulit saavat riippua Coresta, AIGM User Coresta ja Systemistä ilman ulkoisia riippuvuuksia, ja vapaat User-moduulit voivat käyttää ulkoisia riippuvuuksia. Jokainen moduulien välinen import, ilmoitettu rajapinta, template/Panel-viittaus, resurssi ja alustavaatimus on kirjattava **moduulin manifestiin**. Resolver muodostaa riippuvuuksien sulkeuman, ja ilmoittamaton reuna johtaa kovaan virheeseen. [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md) on pakollinen validointiehto.

## 3. Siirtosäännöt

1. **Luokittele ensin, siirrä vasta sitten.** Jokaiselle tiedostolle määritellään: Core-infrastruktuuri, valinnainen runtime-moottori, SYSTEM-moduuli, USER-moduuli tai resurssi. Pelkkä hakemistopolku ei ratkaise semantiikkaa.
2. **Yksi löydettävä moduuli, yksi pääomistaja.** Toteutus, deklaratiivinen metadata, moduulin omat templatet ja testit koottava yhteen. Jaetut kirjastot erotetaan riippuvuuksiksi, ei kopioida joka pakettiin.
3. **Yksi yhteinen discovery-malli.** SYSTEM/USER-lähteet ovat eksplisiittisiä rekisteröinti- tai manifestirajoja; moduulien kyvykkyydet ja riippuvuudet ratkaistaan deklaroidusta tiedosta. Ei implisiittisiä oikeuksia hakemistonimistä.
4. **SYSTEM ei tarkoita pakollista Core-riippuvuutta.** Moduuli voidaan valita kompositioon, mutta vain Minimal Coren aito toiminnallinen minimi on pakollinen.
5. **Lataus, reload ja poisto ovat testattuja.** Vanhat importit, polkuresolverit, template-viitteet ja dokumentaatio on löydettävä ja päivitettävä tai migroitava kontrolloidusti. Ei pysyvää rinnakkaista totuutta.
6. **Ei USER:n privilege-eskalaatiota.** Valmiin USER-manifestin perusrakennetta voidaan hyödyntää, mutta SYSTEM-identiteetti ja valtuutus vaativat oman eksplisiittisen sopimuksensa. Lähteen locked USER-sopimusta ei muuteta hiljaisesti.
7. **Ei sokeaa engine-koodin muuttamista moduuleiksi.** Esimerkiksi `system/cs/parser.py` tai `system/layout/render.py` ei ole automaattisesti `command`- tai `view`-moduuli.
8. **Ei pelkkää hakemistokosmetiikkaa.** Edellytetään regressiotestit, target-yhteensopivuus ja tarvittaessa resurssimittaukset ennen/jälkeen.

## 4. Migraatiojärjestys (P0)

- [ ] Pinnaa 1.8:n lähtörevisio ja tallenna toiminta-/import-/startup-regressiot.
- [ ] Laadi todellinen inventory: command/input/output/adapter + pienet UI-moduulit (Panel) + View-kompositiot + engine/runtime/resurssit.
- [ ] Päätä jokaisen inventoidun komponentin Core-, USE-, SYSTEM-, USER- tai resurssivastuu. Erota **moduulityyppi** ja **auktoriteetti**.
- [ ] Lukitse SYSTEM-moduulin manifesti- ja discovery-sopimus niin, että se on yhteensopiva viiden primitiivin kanssa eikä tulkitse USER-oikeuksia uusiksi.
- [ ] Muodosta uudet pakettijuuret sekä yhtenäiset resolvointi-, rekisteröinti- ja reload-rajapinnat.
- [ ] Siirrä yksi ei-kriittinen komentomoduuli ja todenna register/help/dispatch/reload.
- [ ] Siirrä muut luokitellut komentomoduulit; pidä CS-parseri ja dispatcher erillään.
- [ ] Siirrä valinnaiset Input-/Adapter-/Output-paketit; säilytä Coren tarvitsemat state- ja IO-perusmekanismit.
- [ ] Nimeä pienet UI-moduulit (Panel) erilleen View-kompositioista; siirrä koodi ja View-määritykset omiin vakioituihin luokkiinsa. Erota jaetut helperit ja moottori.
- [ ] Poista vanhojen hakemistorakenteiden pakolliset runtime-riippuvuudet; päivitä testit, help ja dokumentaatio.
- [ ] Varmista, ettei Minimal Coren käynnistyminen importoi valinnaisia SYSTEM- tai View-moduuleja.
- [ ] Testaa toiminnallinen vastaavuus ja mittaa käynnistys, muisti sekä koodikoko CPythonissa ja ESP32-C6:lla.

## 5. Hyväksymiskriteerit

- SYSTEM-moduulit löytyvät vakioidun hakemistorakenteen alta; View-kompositiot ja pienet UI-moduulit ovat eri tyyppejä.
- Jokaisen paketin omistajuus, lataus ja riippuvuudet ovat jäljitettäviä.
- Komento-, Input-, Adapter- ja View-toiminnallisuus toimii siirron jälkeen. Output-toiminnallisuuden todellinen 1.8-tilanne inventoidaan; sitä ei oleteta olevaksi.
- `system/cs/`, `system/state/`, `system/runtime/` ja valinnaisen View-ajomoottorin koodi ovat edelleen infrastruktuuria, eivät modulaarisen pakkauksen perusteella automaattisia USER-tyyppejä.
- Vanhat kovakoodatut polkuoletukset on poistettu tai eksplisiittisesti migroitu.
- SYSTEM- ja USER-moduulien auktoriteetit eivät sekoitu.
- Minimal Coren käynnistyminen C6:lla ei riipu valinnaisista SYSTEM-moduuleista eikä Full View'stä.

## 6. Avoimet toteutusvalinnat

- Mitkä 1.8:n `system/cs/commands`-komennot ovat Coren minimikomentoja, mitkä siirrettäviä SYSTEM-moduuleita?
- Mitkä `system/adapters`- ja `system/inputs`-toteutukset ovat alusta-IO:n minimiä, mitkä valinnaisia?
- Miten vanhan `system/layout/modules`-pienmoduulin ja `system/library/layout/*.tmpl`-View'n identiteetit ja sidonnat migroidaan ilman nimipohjaista arvailua?
- Panel on vahvistettu nimeksi. Säilytetäänkö `.tmpl`-pääte vai vaihdetaanko `.view`-päätteeseen?
- Mikä on Python-/MicroPython-yhteensopiva, resurssitehokas manifesti- ja discovery-toteutus? Tarvitaanko laitteelle vain build-vaiheessa resolvoitu lukittu pakettijoukko?
- Missä siirtymävaiheessa vanhat polut poistetaan lopullisesti?
