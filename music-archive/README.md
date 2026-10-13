# Discogs-derived music dataset

This directory was generated from the monthly Discogs data dumps published at:

https://data.discogs.com/

Discogs dump date: 20261001
Generated: 2026-10-13T14:44:19Z

Source files used:

- https://data.discogs.com/?download=data%2F2026%2Fdiscogs_20261001_artists.xml.gz
- https://data.discogs.com/?download=data%2F2026%2Fdiscogs_20261001_masters.xml.gz
- https://data.discogs.com/?download=data%2F2026%2Fdiscogs_20261001_releases.xml.gz

The generated data contains canonical, single-artist albums by artists listed in
`wanted-artists.txt`. Compilations, unofficial releases,
reissues, remasters and tour recordings are excluded. Albums also need a usable
year, genre and canonical track list, as required by the generated classroom schema.

The `versions` field contains the number of Discogs release versions attached to
each master release. It is retained as useful catalog metadata and can be used for
sorting or classroom queries, but it does not decide which artists or albums are
included. Artist selection comes only from `wanted-artists.txt`.

## Generated files

- `artists.txt` — 1019 artists, one JSON object per line
- `albums.txt` — 3130 albums, one JSON object per line
- `tracks.txt` — 45270 tracks, one JSON object per line
- `genres.txt` — 15 genres, one JSON object per line
- `mysql.sql` — schema and complete data
- `mysql-schema.sql` — schema only
- `mysql-data.sql` — data only, for a schema built in class
- `mysql-data-albums.sql` — data only: `artist`, `genre`, `album`, `album_genre`
- `mysql-data-tracks.sql` — data only: `track` (load after the albums)
- `mysql-data-members.sql` — data only: `artist_part_of` (load after the albums)
- `neo4j.dump` — logical Neo4jBolt dump ready for `neo4j_bolt load`

Every classroom dataset (also the IMDb movie dataset) uses these file names.

The dataset also contains 854 artist-to-band membership links.

## MySQL

`mysql.sql` creates these tables:

- `artist`
- `album`
- `track`
- `genre`
- `album_genre`
- `artist_part_of`

Import it into an existing database with, for example:

```sh
mysql < mysql.sql
```

`album.id` is the Discogs master-release ID and `album.discogs_release_id` is the
canonical concrete release used for country and track information. `album.versions`
contains the number of Discogs release versions for that master, so it is useful
for sorting and classroom queries without affecting inclusion.

## Neo4j / Neo4jBolt

`neo4j.dump` uses Neo4jBolt's textual logical dump format. It contains:

- `Artist` nodes
- `Album` nodes
- `Track` nodes
- `Genre` nodes
- `(Artist)-[:RELEASED]->(Album)` relationships
- `(Album)-[:HAS_TRACK]->(Track)` relationships
- `(Album)-[:IN_GENRE]->(Genre)` relationships
- `(Artist)-[:MEMBER_OF]->(Artist)` relationships for known band members

Load it into an empty Neo4j database with:

```sh
neo4j_bolt load neo4j.dump
```

Neo4jBolt uses dump-local integer node IDs in this file to reconnect
relationships while loading; these are not Neo4j database-internal IDs.

## Rebuilding

The builder automatically looks for the newest complete monthly Discogs dump:

```sh
./collect-music.rb
```

Useful options:

```sh
./collect-music.rb --wanted-artists wanted-artists.txt
./collect-music.rb --dump-date 20260801
./collect-music.rb --force-download
./collect-music.rb --output /path/to/discogs
```

The original compressed Discogs files are cached in `.downloads/` so subsequent
runs can reuse them. `--force-download` refreshes the selected dump.

Discogs publishes the database dump under CC0. See the Discogs data page and API
terms for the conditions that apply to source data and other Discogs content.
