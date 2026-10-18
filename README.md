# Files for the Hackschule Workspace

Files that students download with `wget` in the activities of the
[Hackschule Workspace](https://github.com/specht/workspace), above all the
classroom datasets. Each SQL dataset folder has the same files, named after the
dataset: `countries.sql` (tables and data), `countries-schema.sql` (tables only),
`countries-data.sql` (data only, for tables built in class),
`countries-data-*.sql` (the data in parts), `countries-neo4j.dump` (for
`neo4j_bolt load`), the source data as JSON Lines (`*.txt`) and a `README.md`
with what each column means. The datasets are built by the scripts
in `src/scripts/collect-*` of the Workspace and published with
`src/scripts/publish-datasets.rb`, which also writes this file.

## Countries of the world: [`country-archive/`](country-archive/)

The continents, the 197 countries of the world, every city with at least 100,000 inhabitants and every capital, the land borders between the countries (each in both directions), their currencies and official languages. `countries-basic.sql` has only continents, countries and cities, for the first steps.

| Table | Rows |
| --- | ---: |
| `continent` | 7 |
| `currency` | 143 |
| `language` | 183 |
| `country` | 197 |
| `city` | 4,748 |
| `border` | 636 |
| `country_language` | 372 |

Source: [Wikidata](https://www.wikidata.org/), CC0 1.0. Built 2026-10-17. Used by: *Einführung in SQL*, the Query Stepper.
What each column means: [`country-archive/README.md`](country-archive/README.md).

## Movies: [`movie-archive/`](movie-archive/)

Well-known feature films, their genres and the people who made them: cast, direction, writing, music, production, camera and editing.

| Table | Rows |
| --- | ---: |
| `genre` | 20 |
| `movie` | 2,735 |
| `movie_genre` | 8,299 |
| `crew` | 14,445 |
| `job` | 7 |
| `movie_crew` | 45,890 |

Source: [Wikidata](https://www.wikidata.org/), CC0 1.0; IMDb votes only to choose the films. Built 2026-10-17. Used by: *Filmdatenbank* (MySQL and Neo4j), the Query Stepper.
What each column means: [`movie-archive/README.md`](movie-archive/README.md).
Still there under the names before October 2026, for old links, until the end of the
school year: `mysql.sql`, `mysql-schema.sql`, `mysql-data.sql`, `mysql-data-movies.sql`, `mysql-data-crew.sql`, `neo4j.dump`.

## Streets of Berlin: [`street-archive/`](street-archive/)

Every street, path and stair of Berlin and of each of its twelve Bezirke, one way per line with its kind, one-way flag, name and points, compressed; next to each the public places to start from and go to: sights, squares and every school. Never addresses.

| File | Size |
| --- | ---: |
| `berlin-places.tsv` | 67 KB |
| `berlin.tsv.gz` | 20,280 KB |
| `charlottenburg-wilmersdorf-places.tsv` | 7 KB |
| `charlottenburg-wilmersdorf.tsv.gz` | 1,598 KB |
| `friedrichshain-kreuzberg-places.tsv` | 5 KB |
| `friedrichshain-kreuzberg.tsv.gz` | 966 KB |
| `lichtenberg-places.tsv` | 5 KB |
| `lichtenberg.tsv.gz` | 1,344 KB |
| `marzahn-hellersdorf-places.tsv` | 4 KB |
| `marzahn-hellersdorf.tsv.gz` | 1,782 KB |
| `mitte-places.tsv` | 8 KB |
| `mitte.tsv.gz` | 1,714 KB |
| `neukoelln-places.tsv` | 4 KB |
| `neukoelln.tsv.gz` | 1,529 KB |
| `pankow-places.tsv` | 7 KB |
| `pankow.tsv.gz` | 1,841 KB |
| `reinickendorf-places.tsv` | 4 KB |
| `reinickendorf.tsv.gz` | 1,591 KB |
| `spandau-places.tsv` | 4 KB |
| `spandau.tsv.gz` | 1,224 KB |
| `steglitz-zehlendorf-places.tsv` | 6 KB |
| `steglitz-zehlendorf.tsv.gz` | 2,039 KB |
| `tempelhof-schoeneberg-places.tsv` | 5 KB |
| `tempelhof-schoeneberg.tsv.gz` | 1,629 KB |
| `treptow-koepenick-places.tsv` | 4 KB |
| `treptow-koepenick.tsv.gz` | 2,047 KB |

Source: [OpenStreetMap](https://www.openstreetmap.org/copyright), © OpenStreetMap contributors, ODbL 1.0. Built 2026-10-18. Used by: *Ein Routenplaner für Berlin* (`server.rb` of the template loads a Bezirk from here).
What each column means: [`street-archive/README.md`](street-archive/README.md).

## Music: [`music-archive/`](music-archive/)

The albums of a chosen list of artists and bands, with their tracks, genres and who plays in which band.

| Table | Rows |
| --- | ---: |
| `artist` | 1,019 |
| `genre` | 15 |
| `album` | 3,130 |
| `album_genre` | 5,145 |
| `track` | 45,270 |
| `artist_part_of` | 854 |

Source: [Discogs data dumps](https://data.discogs.com/), CC0 1.0. Built 2026-10-13. Used by: no activity yet.
What each column means: [`music-archive/README.md`](music-archive/README.md).

## Other files

- `snake.c`: a small game in C, not used by an activity at the moment
- `terra1.sql`: the old country database of the *Einführung in SQL* (until October 2026), kept for old links
- `users.sql`: a table of users with passwords for *Bobby Tables* (SQL injection)
- `working-with-files.tar.gz`: the files to explore in *Arbeiten mit Dateien*
