# Country dataset (Wikidata)

The continents, the countries of the world, their cities, which countries share
a border, their currencies and official languages, for the *Einführung in SQL*
of the Hackschule Workspace and what comes after it. Built with
`src/scripts/collect-countries` from https://github.com/specht/workspace.

Two versions: `countries-basic.sql` has only `continent`, `country` (with its
first five columns) and `city`, for the first steps; `countries.sql` has
everything. Importing `countries.sql` later replaces the basic tables.

Generated: 2026-10-17T07:24:37Z

## Source and licence

All data comes from [Wikidata](https://www.wikidata.org/), which is available
under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/): it may be
copied, changed and shared without asking. Every continent, country and city in
the `.txt` files carries its Wikidata item ID (`wikidata`).

Which countries: the 193 members of the United Nations, its two
observer states (Vatican City, Palestine), Kosovo and Taiwan. For Denmark and the
Netherlands, the country in Europe (without Greenland, the Faroe Islands and the
Caribbean islands), not the kingdom as a whole.

- `name`: the German label; NRU is called Nauru, CHN is called China, FSM is called Mikronesien
  instead of their labels
- `population` (P1082) and `area` (P2046, in km²): the value with the latest
  date, not a value for a part only (P518), of several with that date the one
  with preferred rank, of several with the same rank as well the middle one, the
  lower of two; may be empty
- `continent`: the continent (P30), by its name; a country on several
  continents counts where its capital lies, as in atlases
  (RUS, TUR, KAZ, AZE, GEO, ARM, EGY, CYP, IDN, PNG, TLS, PAN, FRA, ESP, PRT, ITA, GRC, NLD, DNK, NOR, USA, CHL, ECU, COL, VEN, YEM, JPN, NZL, AUS are set by hand)
- `tld` (P78): the country's internet domain of two letters; of several the one
  with preferred rank, else the one of its two-letter code (`.de`, not
  `.deutschland`); `calling_code` (P474) with a `+`; `driving_side` (P1622),
  `left` or `right`
- `currency_code` (P38): the current currency by its ISO 4217 code, of several the
  one with preferred rank; set by hand for FRA (EUR), POL (PLN), ZWE (ZWG), PAN (PAB), LSO (LSL), NAM (NAD).
  `currency.name` is its German label
- `country_language` (P37): the official languages of the whole country (not of
  a region, as the languages of Russia's republics), by their ISO 639-3 code
  (P220); a variety without a code of its own counts as its language
  (8 items set by hand), a language without a code is left out.
  AZE, URY have no official language in Wikidata and get the
  language of the state
- `is_capital`: the capital of its country (P36); with several in Wikidata,
  the one with preferred rank; set by hand for ZAF, BEN, NIC
- cities: every human settlement (P31, a subclass of Q486972, or a
  commune of France, municipality of Brazil, municipality of Tunisia) in a country that
  had at least 100000 inhabitants at its latest count, and every capital,
  however small; population as Wikidata counts it, by the city's own borders;
  `latitude` and `longitude` from P625. Left out:
  - an area, a part of a city or a unit of administration: an item of one of
    61 kinds (urban district of the Netherlands, metropolitan area, urban agglomeration, conurbation, urban area, functional urban area, …, listed
    in the script as `NOT_A_CITY`), unless it is a kind of city (a subclass of
    city, Q515) too, other than metropolis, megacity, megalopolis, global city, city-state, border city: Wikidata
    calls Berlin a federated state and Lagos a metropolitan area as well
  - an item that is no more than a human settlement or a metropolis and has other
    cities of the dataset in it (P131), as the union of Bordeaux and its neighbours
  - a place that lies in (P131) another city of the dataset, such as a borough of Berlin
  - single items: Pamplona metropolitan area; Swansea Bay City Region; Greater Malang; Greater Donetsk; Kangemi Ward; Latina (a district of Madrid); Spotsylvania County; Dublin City (the council area beside Dublin); Kansai Science City
- the same city twice: two items with the same name in the same country less
  than 8 km apart (a municipality and its city, »Stadt Madrid« and
  Madrid) count once
- a city that Wikidata places in two countries of the dataset goes with the
  country whose capital is nearer: Crimea and Donetsk with Ukraine, Prizren with
  Kosovo
- borders: land borders only, from the border items of Wikidata that are an
  instance of land boundary (Q15104814), with the two countries (P17); not
  shares border with (P47), which also counts sea borders. A border of an
  overseas part counts where Wikidata records it as a land border (France and
  Brazil, through French Guiana; Spain and the United Kingdom, through
  Gibraltar; Cyprus and the United Kingdom, through its bases on the island);
  Canada and Denmark (Hans Island, Greenland) does not, since Greenland is not
  part of this Denmark, nor France and the United Kingdom (in the Channel
  Tunnel)

Wikidata is edited by many people. A wrong number or a missing border is best
fixed there, and the next build picks it up.

## Files

- `continents.txt` — 7 continents, one JSON object per line
- `countries.txt` — 197 countries, one JSON object per line, with their languages and neighbours
- `cities.txt` — 4748 cities, one JSON object per line
- `currencies.txt` — 143 currencies, `languages.txt` — 183 languages
- `countries-basic.sql` — the basic version: `continent`, `country`, `city`, schema and data
- `countries.sql` — everything, schema and data
- `countries-schema.sql` — schema only
- `countries-data.sql` — data only, for a schema built in class
- `countries-data-cities.sql` — data only: `continent`, `currency`, `country`, `city`
- `countries-data-borders.sql` — data only: `border`
- `countries-data-languages.sql` — data only: `language`, `country_language`
- `countries-neo4j.dump` — logical Neo4jBolt dump for `neo4j_bolt load`

Every classroom dataset names its files this way, after the dataset (`countries`, `movies`, `music`).

## MySQL

```
continent(name, area)
currency(code, name)
language(code, name)
country(code, name, population, area, continent → continent, currency_code → currency, tld, calling_code, driving_side)
city(id, name, country_code → country, population, latitude, longitude, is_capital)
border(country_code → country, neighbor_code → country)
country_language(country_code → country, language_code → language)
```

The basic version: `continent`, `country(code, name, population, area,
continent → continent)` and `city` as above.

A continent is identified by its name, a country by its ISO 3166-1 alpha-3 code
(`DEU`, `FRA`; Kosovo, which has none, by `XKS`), a city by its `id`, numbered
by country and name; city names are not unique. Every country has
exactly one city with `is_capital` = 1 (TRUE). `border` has a row in both directions for
each pair of neighbours: Germany and France are `('DEU', 'FRA')` and
`('FRA', 'DEU')`: a deliberate redundancy, so that a plain `JOIN` finds the
neighbours of a country. A currency is identified by its ISO 4217 code (`EUR`), a
language by its ISO 639-3 code (`deu`, `fra`). A continent has no population of its own; it is the sum of its
countries (`GROUP BY`). Antarctica has no countries.

```sh
mysql < countries.sql
```

## Neo4j

`Continent`, `Country`, `City`, `Currency` and `Language` nodes;
`(Country)-[:ON]->(Continent)`, `(City)-[:IN]->(Country)`,
`(Country)-[:CAPITAL]->(City)`, `(Country)-[:PAYS_WITH]->(Currency)`,
`(Country)-[:SPEAKS]->(Language)` and
`(Country)-[:BORDERS]->(Country)` once per pair, to be followed either way:
`(a:Country)-[:BORDERS]-(b:Country)`.

```sh
neo4j_bolt load countries-neo4j.dump
```
