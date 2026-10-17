-- Generated from the Discogs monthly data dumps at https://data.discogs.com/
-- Dump date: 20261001
-- Generated: 2026-10-13T22:18:54Z
-- This file: schema only.
-- Import into an existing database, for example:  mysql < music-schema.sql

SET NAMES utf8mb4;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `artist_part_of`;
DROP TABLE IF EXISTS `track`;
DROP TABLE IF EXISTS `album_genre`;
DROP TABLE IF EXISTS `album`;
DROP TABLE IF EXISTS `genre`;
DROP TABLE IF EXISTS `artist`;

CREATE TABLE `artist` (
  `id` INT NOT NULL,
  `name` TEXT NOT NULL,
  `born` INT NULL,
  `died` INT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `genre` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genre_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `album` (
  `id` INT NOT NULL,
  `discogs_release_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `title` TEXT NOT NULL,
  `year` INT NOT NULL,
  `country` VARCHAR(255) NULL,
  `versions` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_album_artist` (`artist_id`),
  KEY `idx_album_year` (`year`),
  KEY `idx_album_versions` (`versions`),
  CONSTRAINT `fk_album_artist`
    FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `track` (
  `album_id` INT NOT NULL,
  `number` INT NOT NULL,
  `title` TEXT NOT NULL,
  `duration` INT NULL,
  PRIMARY KEY (`album_id`, `number`),
  CONSTRAINT `fk_track_album`
    FOREIGN KEY (`album_id`) REFERENCES `album` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `album_genre` (
  `album_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`album_id`, `genre_id`),
  KEY `idx_album_genre_genre` (`genre_id`),
  CONSTRAINT `fk_album_genre_album`
    FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  CONSTRAINT `fk_album_genre_genre`
    FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `artist_part_of` (
  `member_id` INT NOT NULL,
  `band_id` INT NOT NULL,
  PRIMARY KEY (`member_id`, `band_id`),
  KEY `idx_artist_part_of_band` (`band_id`),
  CONSTRAINT `fk_artist_part_of_member`
    FOREIGN KEY (`member_id`) REFERENCES `artist` (`id`),
  CONSTRAINT `fk_artist_part_of_band`
    FOREIGN KEY (`band_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
