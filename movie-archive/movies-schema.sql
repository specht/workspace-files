-- Movie data from Wikidata (https://www.wikidata.org/), CC0 1.0.
-- Films chosen by number of IMDb votes (>= 100000); no IMDb data is included.
-- Generated: 2026-10-17T07:13:00Z
-- This file: schema only.
-- Import into an existing database, for example:  mysql < movies-schema.sql

SET NAMES utf8mb4;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `movie_crew`;
DROP TABLE IF EXISTS `job`;
DROP TABLE IF EXISTS `crew`;
DROP TABLE IF EXISTS `movie_genre`;
DROP TABLE IF EXISTS `movie`;
DROP TABLE IF EXISTS `genre`;

CREATE TABLE `genre` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genre_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `movie` (
  `id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `original_title` VARCHAR(255) NULL,
  `german_title` VARCHAR(255) NULL,
  `year` INT NOT NULL,
  `runtime` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `movie_genre` (
  `movie_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `genre_id`),
  KEY `idx_movie_genre_genre` (`genre_id`),
  CONSTRAINT `fk_movie_genre_movie`
    FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `fk_movie_genre_genre`
    FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `crew` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `birth_year` INT NULL,
  `death_year` INT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job` (
  `id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_job_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `movie_crew` (
  `movie_id` INT NOT NULL,
  `crew_id` INT NOT NULL,
  `job_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `crew_id`, `job_id`),
  KEY `idx_movie_crew_crew` (`crew_id`),
  KEY `idx_movie_crew_job` (`job_id`),
  CONSTRAINT `fk_movie_crew_movie`
    FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `fk_movie_crew_crew`
    FOREIGN KEY (`crew_id`) REFERENCES `crew` (`id`),
  CONSTRAINT `fk_movie_crew_job`
    FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
