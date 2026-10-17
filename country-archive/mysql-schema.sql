-- Country dataset of the Hackschule Workspace (https://github.com/specht/workspace),
-- built from Wikidata (CC0 1.0) by src/scripts/collect-countries on 2026-10-17.
-- See README.md for what each column means.
-- This file: schema only.
-- Import into an existing database, for example:  mysql < mysql-schema.sql

SET NAMES utf8mb4;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `border`;
DROP TABLE IF EXISTS `city`;
DROP TABLE IF EXISTS `country`;
DROP TABLE IF EXISTS `continent`;

CREATE TABLE `continent` (
  `name` VARCHAR(50) NOT NULL,
  `area` INT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `country` (
  `code` CHAR(3) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `population` INT NULL,
  `area` DECIMAL(12,2) NULL,
  `continent` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `uq_country_name` (`name`),
  KEY `idx_country_continent` (`continent`),
  CONSTRAINT `fk_country_continent`
    FOREIGN KEY (`continent`) REFERENCES `continent` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `city` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `country_code` CHAR(3) NOT NULL,
  `population` INT NULL,
  `latitude` DECIMAL(8,4) NOT NULL,
  `longitude` DECIMAL(8,4) NOT NULL,
  `is_capital` BOOLEAN NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_city_country` (`country_code`),
  CONSTRAINT `fk_city_country`
    FOREIGN KEY (`country_code`) REFERENCES `country` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `border` (
  `country_code` CHAR(3) NOT NULL,
  `neighbor_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`country_code`, `neighbor_code`),
  KEY `idx_border_neighbor` (`neighbor_code`),
  CONSTRAINT `fk_border_country`
    FOREIGN KEY (`country_code`) REFERENCES `country` (`code`),
  CONSTRAINT `fk_border_neighbor`
    FOREIGN KEY (`neighbor_code`) REFERENCES `country` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
