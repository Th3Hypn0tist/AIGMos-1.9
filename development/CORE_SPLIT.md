# AIGMos 1.9 — Core hard kernel and modularization inventory

**Status:** 1.8-source-based proposed partition, **unlocked**. No 1.9 source migration has been performed.  
**Source:** [AIGMos 1.8 @ 20383e681dd49f3be33070dba41bbcdc4034ef63](https://github.com/Th3Hypn0tist/AIGMos/tree/20383e681dd49f3be33070dba41bbcdc4034ef63).  
**Dependency rule:** [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md).

## Target directory tree

```text
AIGMos-1.9/
├── system/
│   │
│   ├── core/                            # [K] HARD KERNEL — yhteinen perusta
│   │   ├── boot.py                      # [K] minimi init / shutdown, ei automaattista IO-/UI-käynnistystä
│   │   ├── lifecycle.py                 # [K] komponentin käynnistyksen/sammutuksen hallinta
│   │   ├── state/                       # [K] CORE.STATE API + RAM-perusta
│   │   │   ├── api.py                   #     get / set / delete / read / write, valtuutettu rajapinta
│   │   │   ├── memory.py                #     minimi muistissa toimiva state (ei pakollista SQLitea)
│   │   │   └── symbols.py               #     symbolien perusidentiteetti/validointi
│   │   ├── cs/                          # [K] CORE.CS — komentopinta, ei feature-komentopaketteja
│   │   │   ├── parser.py                #     minimoitu syntaksi ja jäsennys
│   │   │   ├── dispatch.py              #     komennon suorittaminen rekisteröidyn rajapinnan kautta
│   │   │   └── registry.py              #     eksplisiittinen, valitun komposition command registry
│   │   ├── input.py                     # [K] CORE.INPUT — geneerinen syöteportti, ei OSC-laitetoteutusta
│   │   ├── bus.py                       # [K] abstrakti signaali-/event-välitys TER:lle
│   │   └── api.py                       # [K] Core-moduulien vakaa käyttörajapinta
│   │
│   ├── core_modules/                    # [C] Core-moduulit; riippuvuus VAIN system/core/-perustaan
│   │   ├── structure/                   # [C] # — rakenteinen symboli-/puuoperaatio
│   │   │   └── module.json              #     requires: CORE.STATE
│   │   ├── trigger/                     # [C] ! — Trigger (perusvertailu/muutos)
│   │   │   └── module.json              #     requires: CORE.STATE + CORE.BUS
│   │   ├── event/                       # [C] @ — Event / CS-command binding
│   │   │   └── module.json              #     requires: CORE.STATE + CORE.BUS + CORE.CS
│   │   └── runner/                      # [C] % Runner + & Routine array SAMASSA moduulissa
│   │       └── module.json              #     requires: CORE.STATE + CORE.CS
│   │                                     #     ei trigger/event/structure-importteja
│   │
│   └── library/                         # [S] SYSTEM-MODULES — vain sallitut Core-riippuvuudet
│       ├── commands/                    #     1.8 system/cs/commands/* inventoidaan
│       ├── inputs/                      #     1.8 system/inputs/* (esim. OSC, jos rajat täyttyvät)
│       ├── outputs/                     #     eksplisiittiset output-moduulit, ei oleteta 1.8:ssa
│       ├── adapters/                    #     esim. mem/state-backend-sovittimet
│       ├── panels/                      #     1.8 system/layout/modules/*
│       ├── views/                       #     1.8 system/library/layout/*.tmpl
│       ├── services/                    #     valinnaisen View Engine/Expose -ajopalvelut: sijoitus tarkistettava
│       └── help/                        #     erilliset ei-suoritettavat resurssit
│
├── aigm_user/                           # [A] AIGM USER -MODULES
│   └── library/                         #     riippuvuudet vain Core + SYSTEM, ei ulkoisia
│       ├── commands/
│       ├── inputs/
│       ├── outputs/
│       ├── adapters/
│       ├── panels/
│       └── views/
│
├── library/                             # [U] USER-MODULES — myös ulkoiset riippuvuudet sallittu
│   ├── commands/
│   ├── inputs/
│   ├── outputs/
│   ├── adapters/
│   ├── panels/
│   ├── views/
│   └── integrations/                    #     ulkoisten palveluiden pakkausluokka vain ehdotus
│
└── development/
    ├── CORE_SPLIT.md
    └── DEPENDENCY_RULES.md
```

**Huomio:** nimet `system/core/`, `core_modules/`, `aigm_user/`, `services/`, `integrations/` ja tiedostonimet ovat **1.9-hakemistoehdotuksia** eivätkä 1.8:n todettuja polkuja. `views` on deklaratiivinen kompositioarkisto eikä kuudes Panel-/moduulityyppi. Käytettävien luokkien lopulliset juuret ja manifestiformaatti varmistetaan ennen koodisiirtoja.

## Core-perustan raja (K)

Core-alustaan jää vain se mikä on välttämätöntä, jotta valitut Core-moduulit voivat toimia ilman keskinäisiä riippuvuuksia:
- kevyt elinkaari/kompositiokäynnistys: **ei suorita optional module discoveryä import-aikana**;
- CORE.STATE (sisäinen muistiperusta ja rajapinta), mutta **ei** pysyvyyden/SQL:n pakollista toteutusta;
- CORE.CS (minimi parser/dispatcher/rekisteri), mutta **ei** kaikkia 1.8:n komentototeutuksia;
- CORE.INPUT (geneerinen syötteen vastaanottorajapinta), mutta **ei** pakollista OSC-/network-ajuria;
- CORE.BUS (välittää tapahtumat/komentopyynnöt), mutta **ei** oletusarvoisia rinnakkaissäikeitä;
- vakaa Core API, jonka kautta Core-moduulit voivat kommunikoida, **ei moduuli→moduuli-importteja**.

### Riippuvuuskuva

```text
CORE.STATE  ◄──  # structure
CORE.STATE  ◄──  ! trigger  ──► CORE.BUS
CORE.STATE  ◄──  @ event    ──► CORE.BUS / CORE.CS
CORE.STATE  ◄──  % runner + & routines ──► CORE.CS

! ──x──► @      @ ──x──► %      % ──x──► #
```

TER-ketju toimii **Core.BUS/CORE.CS-rajapintojen kautta**, ei core-moduulien keskinäisillä import-riippuvuuksilla. `%` ja `&` ovat samassa Runner-moduulissa siksi, että & on Runnerin sisäinen pakollinen toimintamalli, ei erillinen toisiin Core-moduuleihin sidottu plugin. Omat manifestit ja suorat Core-riippuvuudet ovat pakollisia.

`#` on esimerkin mukaisesti **Core-moduuli**, ei sama asia kuin `CORE.STATE`. Sen pakollisuus jokaisessa kohdekompositiossa on erillinen päätös; esimerkissä sen suora riippuvuus on `CORE.STATE`.

## 1.8-koodin alustava siirtokartta

| 1.8-polku | 1.9-sijoitus | Miksi / ehto |
|---|---|---|
| `system/core.py` | `system/core/boot.py` + valinnainen runtime host | Nykyinen `run()` kutsuu suoraan `system.layout.run_loop`; UI-irrotus on välttämätön. |
| `system/bootstrap.py` | Core-käynnistys + erilliset valinnaiset composition-/target-startupit | Rakentaa SQLite-, OSC-, View-, TER-, Runner- ja Q-kontekstin yhdessä. Ei sellaisenaan kovaytimeen. |
| `system/state/api.py`, `state/engine.py`, `state/request.py` | `system/core/state/` + irrotettavat adapterit | API on lähellä peruspalvelua; nykyinen engine sisältää thread/queue-rakenteita, ja state/api importoi extensions-oikeustarkistukset. Tarvitaan refaktorointi. |
| `system/cs/parser.py`, `command_registry.py` | `system/core/cs/` | CS-perusjäsennys/dispatch jää; automaattinen komentojen pakettien lataus ja UI-viittaukset irrotetaan. |
| `system/cs/commands/*.py` | `system/library/commands/` tai perustellusti Core-/Core-moduulin komento | Ei siirretä kaikkia Coreen. `run` ja `&` sidotaan Runnerin vastuuseen; `trig` Triggeriin; `emit/on/bind` arvioidaan Eventin vastuuksi. |
| `system/runtime/triggers.py`, `system/lib/trigger/*` | `core_modules/trigger/` + mahdolliset erilliset ajuri-/cron-laajennukset | Core-triggerin minimi vs. cron/kellopalvelut erotellaan. Ei suoraa riippuvuutta Event-moduuliin. |
| `system/runtime/events.py` | `core_modules/event/` | Nykyinen EventLoop käyttää `threading`, `queue` ja `boot_log`; riippuvuudet korvataan Core-rajapinnoilla. |
| `system/runtime/runner.py`, `runner_store.py`, `cs/commands/run.py` | `core_modules/runner/` + mahdollinen persistence-provider | `%` ja `&` pysyvät yhdessä. `ThreadPoolExecutor`, `uuid`, threadit ja pysyvyyden kytkentä eivät sellaisenaan sovi C6-minimiin. |
| `system/inputs/osc.py`, `system/runtime/osc.py` | `system/library/inputs/` tai kohderiippuva USER-module | OSC on **input-toteutus**, ei Core.INPUT. Class/target/external requirements ratkaistaan manifestista. |
| `system/adapters/mem.py` | Core STATE:n sisäinen RAM-toteutus **tai** system adapter (valittava) | Älä pidä kahden erillisen muistisovittimen päällekkäistä lähdetotuutta. |
| `system/adapters/sqlite.py`, `psql.py` | valinnaiset adapterit; ei Coreen | Ulkoinen driveri tai palvelu voi pakottaa USER-luokan. Target-tuki ja riippuvuudet tarkistettava erikseen. |
| `system/layout/*.py` | valinnainen View Engine; ei Coreen | curses, terminal, render, focus, input ja View-runloop; Core ei saa importoida. |
| `system/layout/modules/*.py` | `system/library/panels/` tai käyttäjäpuolen vastaava | Panel on UI-moduuli, ei View. |
| `system/library/layout/*.tmpl` | `system/library/views/` | View on Panelien kompositio; tiedostopääte ja `<layout>`-parserin muutos avoin. |
| `system/lib/q/*` + `cs/commands/q*.py` | **ei Coreen**; luokka ratkaistava ulkoisten provider-riippuvuuksien perusteella | Q/LLM-integraatio vaatii omat manifestit. Ei siirretä Systemiin, jos se tuo kielletyn ulkoisen riippuvuuden. |
| `system/lib/map/*`, `lib/reload_ops.py`, `lib/library_reload.py` | valinnaiset SYSTEM/USER-komennot tai host/helper, ei Core | Tiedostokartoitus ja reload ovat kehitys-/hallintatoimintoja, eivät minimisuorituksen edellytys. |
| `system/boot.py`, `system/config.py`, `system/init.cs` | Core-minimi + valinnainen boot/banner/config/skriptit | Nykyinen config vaatii myös Q- ja OSC-asetuksia; poistetaan vaatimus Core-only-profiilista. |

## Toteutusrajoitteet

- Core MODULE → vain CORE public APIs (esim. `# → CORE.STATE`), **ei Core MODULE → Core MODULE**.
- System MODULE → vain sallitut Core-riippuvuudet. AIGM User → Core/System, ei ulkoisia. User → ulkoiset sallittu, mutta suoraan manifestissa.
- **AIGM User** ja tavallinen **User** ovat eri riippuvuusluokkia. Yhdenmukainen moduulirakenne ei poista rajaa.
- Pelkkä hakemistojen siirto ei korjaa 1.8:n import-/käynnistyskytköksiä. Kaikki importit, resurssit, driverit ja target-API:t validoidaan.
- Arkkitehtuurikaavio ei ole vahvistettu speksi eikä mittaustulos. Vasta riippuvuusgraafin tarkistus, regressiot ja ESP32-C6-testit voivat merkitä siirron valmiiksi.

## Seuraava todentaminen

- [ ] 1.8:n kaikkien `system/`-tiedostojen import-/call-/resurssiriippuvuusgraafi.
- [ ] Mitkä CS-komennot ovat pakollinen Core API ja mitkä voidaan erottaa Core-/System-moduuleihin?
- [ ] TER:n Core.BUS-injektiorajapinnat ja ilman Core-moduuli→Core-moduuli -reunoja toimiva suoritus.
- [ ] Muistissa toimivan STATE:n minimi vs. SQLite/psql-pysyvyys.
- [ ] Oikea MicroPython-/C6-budjetti, käynnistys ja moduulien dynaamisen latauksen raja.
