-- Country dataset of the Hackschule Workspace (https://github.com/specht/workspace),
-- built from Wikidata (CC0 1.0) by src/scripts/collect-countries on 2026-10-17.
-- See README.md for what each column means.
-- This file: schema only.
-- Import into an existing database, for example:  mysql < countries-schema.sql

SET NAMES utf8mb4;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `country_language`;
DROP TABLE IF EXISTS `border`;
DROP TABLE IF EXISTS `city`;
DROP TABLE IF EXISTS `country`;
DROP TABLE IF EXISTS `language`;
DROP TABLE IF EXISTS `currency`;
DROP TABLE IF EXISTS `continent`;

CREATE TABLE `continent` (
  `name` VARCHAR(50) NOT NULL,
  `area` INT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `currency` (
  `code` CHAR(3) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `language` (
  `code` CHAR(3) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `country` (
  `code` CHAR(3) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `population` INT NULL,
  `area` DECIMAL(12,2) NULL,
  `continent` VARCHAR(50) NOT NULL,
  `currency_code` CHAR(3) NULL,
  `tld` VARCHAR(10) NULL,
  `calling_code` VARCHAR(10) NULL,
  `driving_side` ENUM('left', 'right') NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `uq_country_name` (`name`),
  KEY `idx_country_continent` (`continent`),
  KEY `idx_country_currency` (`currency_code`),
  CONSTRAINT `fk_country_continent`
    FOREIGN KEY (`continent`) REFERENCES `continent` (`name`),
  CONSTRAINT `fk_country_currency`
    FOREIGN KEY (`currency_code`) REFERENCES `currency` (`code`)
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

CREATE TABLE `country_language` (
  `country_code` CHAR(3) NOT NULL,
  `language_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`country_code`, `language_code`),
  KEY `idx_country_language_language` (`language_code`),
  CONSTRAINT `fk_country_language_country`
    FOREIGN KEY (`country_code`) REFERENCES `country` (`code`),
  CONSTRAINT `fk_country_language_language`
    FOREIGN KEY (`language_code`) REFERENCES `language` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
