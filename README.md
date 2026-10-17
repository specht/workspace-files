# Files for the Hackschule Workspace

Files that students download with `wget` in the activities of the
[Hackschule Workspace](https://github.com/specht/workspace), above all three
classroom datasets. Each dataset folder has the same files: `mysql.sql` (tables
and data), `mysql-schema.sql` (tables only), `mysql-data.sql` (data only, for
tables built in class), `mysql-data-*.sql` (the data in parts), `neo4j.dump`
(for `neo4j_bolt load`), the source data as JSON Lines (`*.txt`) and a
`README.md` with what each column means. The datasets are built by the scripts
in `src/scripts/collect-*` of the Workspace and published with
`src/scripts/publish-datasets.rb`, which also writes this file.

## Countries of the world: [`country-archive/`](country-archive/)

The continents, the 197 countries of the world, every city with at least 100,000 inhabitants and every capital, and the land borders between the countries, each in both directions.

| Table | Rows |
| --- | ---: |
| `continent` | 7 |
| `country` | 197 |
| `city` | 4,748 |
| `border` | 636 |

Source: [Wikidata](https://www.wikidata.org/), CC0 1.0. Built 2026-10-17. Used by: *Einführung in SQL*, the SQL-Zeitlupe.
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

Source: [Wikidata](https://www.wikidata.org/), CC0 1.0; IMDb votes only to choose the films. Built 2026-10-13. Used by: *Filmdatenbank* (MySQL and Neo4j), the SQL-Zeitlupe.
What each column means: [`movie-archive/README.md`](movie-archive/README.md).

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
