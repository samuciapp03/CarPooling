# ************************************************************
# Sequel Ace SQL dump
# Version 20033
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: gigachungus.duckdns.org (MySQL 5.5.5-10.7.3-MariaDB-1:10.7.3+maria~focal)
# Database: carpooling
# Generation Time: 2022-06-03 07:22:31 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table automobili
# ------------------------------------------------------------

DROP TABLE IF EXISTS `automobili`;

CREATE TABLE `automobili` (
  `idAutomobile` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `marca` varchar(20) NOT NULL,
  `modello` varchar(20) NOT NULL,
  `idUtente` int(11) unsigned NOT NULL,
  `annoImm` int(4) NOT NULL,
  `img` varchar(30) DEFAULT NULL,
  `targa` varchar(7) DEFAULT NULL,
  `eliminata` char(1) DEFAULT NULL,
  PRIMARY KEY (`idAutomobile`),
  KEY `utente-auto` (`idUtente`),
  CONSTRAINT `utente-auto` FOREIGN KEY (`idUtente`) REFERENCES `utenti` (`idUtente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table comuni
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comuni`;

CREATE TABLE `comuni` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `lat` varchar(255) NOT NULL,
  `lng` varchar(255) NOT NULL,
  `codice_provincia_istat` varchar(255) NOT NULL,
  `codice_comune_istat` varchar(255) NOT NULL,
  `codice_alfanumerico_istat` varchar(255) NOT NULL,
  `capoluogo_provincia` tinyint(1) NOT NULL,
  `capoluogo_regione` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table prenotazioni
# ------------------------------------------------------------

DROP TABLE IF EXISTS `prenotazioni`;

CREATE TABLE `prenotazioni` (
  `idPrenotazione` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stato` varchar(1) NOT NULL,
  `idUtente` int(11) unsigned NOT NULL,
  `idViaggio` int(11) unsigned NOT NULL,
  `votazioneA` int(11) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `valutato` char(1) DEFAULT NULL,
  PRIMARY KEY (`idPrenotazione`),
  KEY `preno-viaggio` (`idViaggio`),
  KEY `utente-preno` (`idUtente`),
  CONSTRAINT `preno-viaggio` FOREIGN KEY (`idViaggio`) REFERENCES `viaggi` (`idViaggio`),
  CONSTRAINT `utente-preno` FOREIGN KEY (`idUtente`) REFERENCES `utenti` (`idUtente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table utenti
# ------------------------------------------------------------

DROP TABLE IF EXISTS `utenti`;

CREATE TABLE `utenti` (
  `idUtente` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cognome` varchar(30) DEFAULT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `dataNascita` date DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `ruolo` char(1) DEFAULT NULL,
  `npatente` varchar(100) DEFAULT NULL,
  `scadenza` varchar(20) DEFAULT NULL,
  `img` varchar(30) DEFAULT NULL,
  `idcard` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idUtente`),
  CONSTRAINT `utenti_CHECK2` CHECK (`ruolo` in ('a','p','x'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table viaggi
# ------------------------------------------------------------

DROP TABLE IF EXISTS `viaggi`;

CREATE TABLE `viaggi` (
  `idViaggio` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataInizio` date NOT NULL,
  `oraPartenza` varchar(5) NOT NULL,
  `bagagli` varchar(1) DEFAULT NULL,
  `nPasseggeri` int(11) DEFAULT NULL,
  `animali` varchar(1) DEFAULT NULL,
  `sosta` varchar(1) DEFAULT NULL,
  `fermata1` varchar(30) DEFAULT NULL,
  `fermata2` varchar(30) DEFAULT NULL,
  `partenza` varchar(30) DEFAULT NULL,
  `arrivo` varchar(30) DEFAULT NULL,
  `durata` int(11) DEFAULT NULL,
  `contributo` int(11) DEFAULT NULL,
  `idAutomobile` int(10) unsigned DEFAULT NULL,
  `completato` char(1) DEFAULT NULL,
  PRIMARY KEY (`idViaggio`),
  KEY `viaggi_FK` (`idAutomobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table votazioniP
# ------------------------------------------------------------

DROP TABLE IF EXISTS `votazioniP`;

CREATE TABLE `votazioniP` (
  `idVotazione` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idViaggio` int(11) unsigned NOT NULL,
  `idPasseggero` int(11) unsigned NOT NULL,
  `voto` int(1) NOT NULL,
  `descrizione` text DEFAULT NULL,
  PRIMARY KEY (`idVotazione`),
  KEY `votazioniP_FK` (`idViaggio`),
  KEY `votazioniP_FK_1` (`idPasseggero`),
  CONSTRAINT `votazioniP_FK` FOREIGN KEY (`idViaggio`) REFERENCES `viaggi` (`idViaggio`),
  CONSTRAINT `votazioniP_FK_1` FOREIGN KEY (`idPasseggero`) REFERENCES `utenti` (`idUtente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
