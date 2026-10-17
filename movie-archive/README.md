# Movie dataset (Wikidata)

Films, genres and the people who made them, for the *Filmdatenbank mit MySQL*
activity of the Hackschule Workspace. Built with `src/scripts/collect-movies` from
https://github.com/specht/workspace.

Generated: 2026-10-13T22:08:07Z

## Source and licence

All data comes from [Wikidata](https://www.wikidata.org/), which is available
under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/): it may be
copied, changed and shared without asking. Each film and person in `movies.txt`
and `crew.txt` carries its Wikidata item ID (`wikidata`).

Which films are included was decided with the number of user votes in IMDb's
public `title.ratings` file: non-adult feature films with at least 100000
votes. Those films were looked up in Wikidata by their IMDb ID (property P345).
Nothing else from IMDb is used or included.

- `title`: English label; `german_title`: German label, if different;
  `original_title`: P1476, if different
- `year`: earliest publication date (P577); `runtime`: duration in minutes (P2047)
- genres: P136, mapped to 20 names (Action, Adventure, Animation, Biography, Comedy, Crime, Documentary, Drama, Family, Fantasy, History, Horror, Musical, Mystery, Romance, Sci-Fi, Sport, Thriller, War, Western);
  a film may have none
- people: cast member (P161, the 10 best known per film), director (P57),
  screenwriter (P58, as `writer`), composer (P86), producer (P162), director of
  photography (P344, as `cinematographer`) and film editor (P1040, as `editor`),
  only humans; best known means: most Wikipedia articles
- `birth_year`, `death_year`: P569, P570; may be empty

Wikidata is edited by many people. A wrong date or a missing genre is best fixed
there, and the next build picks it up.

## Files

- `movies.txt` — 2735 movies, one JSON object per line
- `crew.txt` — 14445 people, one JSON object per line
- `genres.txt` — 20 genres, one JSON object per line
- `mysql.sql` — schema and complete data
- `mysql-schema.sql` — schema only
- `mysql-data.sql` — data only, for a schema built in class
- `mysql-data-movies.sql` — data only: `genre`, `movie`, `movie_genre`
- `mysql-data-crew.sql` — data only: `crew`, `job`, `movie_crew`
- `neo4j.dump` — logical Neo4jBolt dump for `neo4j_bolt load`

Every classroom dataset (also the music dataset) uses these file names.

## MySQL

One line per table, the primary key first, `→` for a foreign key:

```
movie(id, title, original_title, german_title, year, runtime)
genre(id, name)
movie_genre(movie_id → movie, genre_id → genre)
crew(id, name, birth_year, death_year)
job(id, title)
movie_crew(movie_id → movie, crew_id → crew, job_id → job)
```

`movie_crew` connects a movie, a person and a job; a person appears once per job
and movie. `job.title` is one of `actor`, `director`, `writer`, `composer`,
`producer`, `cinematographer`, `editor`. Titles are not unique, so a film is identified by its `id`, or by
title and year.

```sh
mysql < mysql.sql                 # everything
mysql < mysql-data-movies.sql     # or step by step into tables built in class
mysql < mysql-data-crew.sql
```

## Neo4j

`Movie`, `Person` and `Genre` nodes; `(Movie)-[:IN_GENRE]->(Genre)` and
`(Person)-[:ACTOR|DIRECTOR|WRITER|…]->(Movie)`.

```sh
neo4j_bolt load neo4j.dump
```
