# Discogs-derived music dataset

This directory was generated from the monthly Discogs data dumps published at:

https://data.discogs.com/

Discogs dump date: 20261001
Generated: 2026-10-13T22:18:55Z

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
- `music.sql` — schema and complete data
- `music-schema.sql` — schema only
- `music-data.sql` — data only, for a schema built in class
- `music-data-albums.sql` — data only: `artist`, `genre`, `album`, `album_genre`
- `music-data-tracks.sql` — data only: `track` (load after the albums)
- `music-data-members.sql` — data only: `artist_part_of` (load after the albums)
- `music-neo4j.dump` — logical Neo4jBolt dump ready for `neo4j_bolt load`

Every classroom dataset names its files this way, after the dataset (`countries`, `movies`, `music`).

The dataset also contains 854 artist-to-band membership links.

## MySQL

One line per table, the primary key first, `→` for a foreign key:

```
artist(id, name, born, died)
genre(id, name)
album(id, discogs_release_id, artist_id → artist, title, year, country, versions)
track(album_id → album, number, title, duration)
album_genre(album_id → album, genre_id → genre)
artist_part_of(member_id → artist, band_id → artist)
```

- `artist`: `born` and `died` are years read from the artist's Discogs
  profile; empty for bands and where the profile does not say
- `album`: `id` is the Discogs master-release ID, `discogs_release_id` the
  canonical concrete release that country and tracks come from; `year` the
  year of the master release, `country` where that release came out;
  `versions` how many release versions Discogs has for the master (useful
  for sorting, it decides nothing about inclusion)
- `track`: `number` counts from 1 within the album, `duration` is in
  seconds; empty where Discogs has no time
- `album_genre`: an album may have several genres
- `artist_part_of`: an artist (`member_id`) is or was a member of a band
  (`band_id`); both are rows of `artist`

Import it into an existing database with, for example:

```sh
mysql < music.sql
```

## Neo4j / Neo4jBolt

`music-neo4j.dump` uses Neo4jBolt's textual logical dump format. It contains:

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
neo4j_bolt load music-neo4j.dump
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
