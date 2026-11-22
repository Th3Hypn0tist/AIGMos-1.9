# AIGMos 1.9 — View, Widget ja View Engine

**Tila:** nimeämisehdotus, ei vielä lukittu.  
**Vahvistettu semanttinen suunta:** nykyinen `.tmpl`-template vastaa **View'tä**, ja View muodostuu pienemmistä UI-moduuleista.  
**Ehdotettu nimi pienelle UI-moduulille:** **Widget**.

## 1. Käsitteet eivät saa mennä päällekkäin

| Uusi käsite | Nykyinen AIGMos 1.8 | Omistaa | Ei omista |
|---|---|---|---|
| **View** | `system/library/layout/*.tmpl` | deklaratiivinen UI-rakenne, widgetien yhdistely, järjestys, sidonnat | widgetin toteutuskoodi, rendering runtime |
| **Widget** (nimiehdotus) | `system/layout/modules/*.py` | yksi rajattu esitys-/vuorovaikutustoiminto, esim. label, list, cs, q, monitor | koko View'n rakenne |
| **View Engine** | `system/layout/` | View'n lataus, sidonta, layoutin laskenta, fokuksen/inputin hallinta, renderöintielinkaari | View'n käyttötapauskohtainen sisältö |
| **View backend/renderer** | 1.8:n TUI-toteutus; tuleva LMTS UI -integraatio | vaihtoehtoinen View Engineen sidottu käyttöliittymätoteutus | CS-/STATE-/TER-semanttiikka |

**Sääntö:** `View = koostumus(Widget[])`. `Widget` on ehdotettu käyttöliittymämoduulin nimi. `View` ei ole yksittäisen widgetin synonyymi. `Layout` viittaa tarvittaessa vain View'n tilalliseen asetteluun, ei erilliseen moduulityyppiin.

## 2. Todellinen esimerkki 1.8:sta

Vanha `system/library/layout/help.tmpl` sisältää `<layout>`-juuren sekä `<label>`, `<q>` ja `<cs>`-osat. Niiden toteutus on erillisinä Python-tiedostoina `system/layout/modules/`-hakemistossa.

Uusi käsitteellinen tulkinta:

```text
View: help
├── Widget: label
├── Widget: q
└── Widget: cs
```

Yksi Widget voi olla käytössä useassa View'ssä. Yksi View voi sisältää useita saman Widgetin instansseja. Widget ei saa toista identiteettiä vain siksi, että se esiintyy eri View'ssä.

## 3. Ehdotettu hakemistorakenne

```text
AIGMos-1.9/
├── system/
│   ├── cs/                       # CS parser ja dispatch, ei komentomoduuleita
│   ├── state/                    # Coren state
│   ├── runtime/                  # TER + muut tarkistettavat runtimet
│   ├── view/                     # valinnainen View Engine (entinen layout/)
│   └── library/
│       ├── commands/<module_id>/
│       ├── inputs/<module_id>/
│       ├── outputs/<module_id>/
│       ├── adapters/<module_id>/
│       ├── widgets/<widget_id>/  # Widgetin koodi + manifesti + testit
│       └── views/<view_id>/      # deklaratiivinen View, ei widget
└── library/                      # USER-puolen vastaava jako
    ├── commands/<module_id>/
    ├── inputs/<module_id>/
    ├── outputs/<module_id>/
    ├── adapters/<module_id>/
    ├── widgets/<widget_id>/
    └── views/<view_id>/
```

Vanhojen `.tmpl`-tiedostojen muuttaminen `.view`-tiedostoiksi on **nimiehdotus**, ei vielä lukittu tiedostomuotopäätös. View'n sisältö voidaan alkuvaiheessa pitää samana. Ensimmäisenä muutetaan käsitteellinen vastuu ja vasta testien jälkeen tiedostonimet, latauspolut ja mahdolliset skeemat.

`views` on tässä **View-määritysten kirjasto**, ei erillinen kuudes primitiivimoduulityyppi.

## 4. USER-primitiivien vaikutus

Aiemmissa, pinnaatuissa 2.0-lähdesopimuksissa viiden tyypin joukko on `command / input / output / adapter / view`, missä `view` tarkoittaa deklaratiivista UI-kompositiota.

Käyttäjän nyt määrittelemä 1.9-nimimalli **erottaa komposition ja sen toteuttavan pienemmän moduulin**. Siksi mahdollinen uusi viiden **käyttöliittymämoduulin toteutusluokan** joukko olisi:

```text
command / input / output / adapter / widget
```

`view` olisi tällöin **deklaratiivinen kompositio**, ei Widgetin moduuliluokka. Tämä on 1.9:ään ehdotettu **tietoinen skeemamuutos**, ei alkuperäisen locked USER-sopimuksen tämänhetkinen sisältö. Sitä EI saa ottaa käyttöön pelkällä hakemiston uudelleennimeämisellä:

- [ ] Päätä onko uusi moduulityyppi `widget` (nimiehdotus).
- [ ] Määritä uuden `widget`-manifestin sopimus 1.9:n omana versiona, mukaan lukien identiteetti ja näkyvät entrypointit.
- [ ] Määritä erillinen View-komposition tiedostomuoto ja mahdollinen metadata (ei oleteta `module.json`:ia View'lle).
- [ ] Tee vanhan `type=view` -moduulisopimuksen eksplisiittinen migraatiokartta: mikä muuttuu Widgetiksi, mikä View-määritykseksi.
- [ ] Säilytä alkuperäiset pinnaatut lähdesopimukset muuttumattomina. Ero kirjataan 1.9-versiointiin.

**Ei päätetä kuudetta tasavertaista USER-primitiiviä hiljaisesti.** Tavoite on pitää varsinaiset toiminnalliset moduulit järkeistettyinä ja erottaa deklaratiivinen View omaksi kompositioartefaktikseen.

## 5. UI-renderöinnin riippuvuusrajat

- Minimal Core ei tarvitse View Engineä, Widget-lataajaa eikä LMTS UI:ta.
- P1: LMTS:n UI-palikka toteutetaan **yhdeksi valinnaiseksi View-toteutus-/renderöintiratkaisuksi**, ei itsenäiseksi View-kompositioksi.
- P2: `|BUILD` on View, joka kokoaa tarvittavia Widgetejä ja käyttää Build Engineä deklaroitujen komentojen/toimintojen kautta.
- Widget ei saa käyttöoikeutta, CS-komentojen suoritusvaltaa tai mielivaltaisia STATE-kirjoitusoikeuksia pelkän View-sidonnan perusteella.
- Expose säilyy erillisenä ulkoisten näkyvyys-/verkkopintojen omistajuusmallina; View-nimen muutos ei määrittele Exposea uudelleen.

## 6. P0-migraatio ja testit

- [ ] Pinnaa 1.8:n nykyinen View/layout-resolver, loader, templatet ja widgetit.
- [ ] Inventoi `system/layout/modules/` ja `extensions/layout/modules/` — mitkä ovat itsenäisiä Widgetejä ja mitkä sisäisiä helper-toteutuksia?
- [ ] Todenna olemassa oleva `help.tmpl`-View ja sen `label`, `q`, `cs`-komponentit regressiotestillä.
- [ ] Siirrä yksi widget uudelle polulle, säilytä täsmälleen sama näkyvä ja vuorovaikutteinen käytös.
- [ ] Siirrä muut widgetit; keskitetty discovery korvaa `system/layout/loader.py`:n kovakoodatut moduulipolut.
- [ ] Siirrä View-määritykset `views/`-kirjastoon ja päivitä `system/layout/definitions.py`:n resolver hallitusti.
- [ ] Selvitä ja toteuta `system/layout/` → `system/view/` -rename ilman rikottuja Python-importteja.
- [ ] Tarkista kaikkien templateiden, dokumenttien, help-teksteiden, testien ja `new |name /view`-komentojen polut.
- [ ] Todennetaan View- ja Widget-discovery erikseen; Minimal Core ei importoi kumpaakaan, kun View on pois käytöstä.

**Koodimigraatio ei ole alkanut:** tämä on nimet ja omistajuudet selkeyttävä 1.9-kehitysehdotus.
