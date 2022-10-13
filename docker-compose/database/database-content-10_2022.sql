# ************************************************************
# Sequel Ace SQL dump
# Version 20035
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 34.135.233.55 (MySQL 5.5.5-10.7.3-MariaDB-1:10.7.3+maria~focal)
# Database: carpooling
# Generation Time: 2022-10-13 15:20:08 +0000
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

LOCK TABLES `automobili` WRITE;
/*!40000 ALTER TABLE `automobili` DISABLE KEYS */;

INSERT INTO `automobili` (`idAutomobile`, `marca`, `modello`, `idUtente`, `annoImm`, `img`, `targa`, `eliminata`)
VALUES
	(2,'Opel','Corsa',7,2015,'ciappe1.jpg','1234567','n'),
	(3,'Audi','A4',7,2017,'ciappe2.jpg','1234567','n'),
	(4,'Fiat','600',8,2016,'pomi1.png','1234567','n');

/*!40000 ALTER TABLE `automobili` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table prenotazioni
# ------------------------------------------------------------

LOCK TABLES `prenotazioni` WRITE;
/*!40000 ALTER TABLE `prenotazioni` DISABLE KEYS */;

INSERT INTO `prenotazioni` (`idPrenotazione`, `stato`, `idUtente`, `idViaggio`, `votazioneA`, `feedback`, `valutato`)
VALUES
	(1,'r',2,5,3,'sinceramente canta troppo','y'),
	(2,'r',2,6,1,'continuava a deridermi perchè non ho la patente','y'),
	(3,'u',2,7,NULL,NULL,'y'),
	(7,'u',2,4,NULL,NULL,'n');

/*!40000 ALTER TABLE `prenotazioni` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table utenti
# ------------------------------------------------------------

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;

INSERT INTO `utenti` (`idUtente`, `cognome`, `nome`, `username`, `password`, `dataNascita`, `email`, `tel`, `ruolo`, `npatente`, `scadenza`, `img`, `idcard`)
VALUES
	(2,'Melzi','Marco','marco','9c62af132638c02bd04c2bd04325bbb289f448c00bcf2b497ac1d6a1b742b0337bf3611d2e26cdb90e69a44f53b6541d49ee676842ff2eb4100e59f9197801cf','2003-01-22','cppsml03r03e507t@iisbadoni.edu.it','3314062640','p','null','null','marco.jpg','null'),
	(7,'Ciappesoni','Samuel','ciappe','5406e327ea09afc39d6a047f26f78fccac2bb7ea7eaecd60aa155a04e15ac8d01fb0345670d63ddbf0b93f439de12e970bbcddf6dabd94ad7901e58e0804a10d','2003-10-03','samu.ciappesoni@gmail.com','3240853895','a','a1234','2025-07','ciappe.png','ciappe.png'),
	(8,'Pomi','Luigi','pomi','0f509f0a9beb22aed36eda80043dccd139940845e6f5060127d0d0cab48a2b17afc49384a29902f113ae0d2fece9650fae43e1a9230b132870a0c7beeb83d2a4','2003-11-03','ciao@ciao.com','43434334','a','sfqe','2027-03','pomi.png','pomi.png');

/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table viaggi
# ------------------------------------------------------------

LOCK TABLES `viaggi` WRITE;
/*!40000 ALTER TABLE `viaggi` DISABLE KEYS */;

INSERT INTO `viaggi` (`idViaggio`, `dataInizio`, `oraPartenza`, `bagagli`, `nPasseggeri`, `animali`, `sosta`, `fermata1`, `fermata2`, `partenza`, `arrivo`, `durata`, `contributo`, `idAutomobile`, `completato`)
VALUES
	(2,'2022-06-22','12:00','y',3,'n','y','Milano','','Lecco','Roma',6,20,2,'y'),
	(3,'2022-08-20','20:00','n',2,'y','n',NULL,NULL,'Milano','Genova',2,5,3,'y'),
	(4,'2022-07-20','19:00','y',1,'n','n',NULL,NULL,'Mandello del Lario','Novara',7,15,4,'y'),
	(5,'2022-06-12','12:00','y',1,'n','y','Bellano','','Calolziocorte','Dervio',1,5,3,'y'),
	(6,'2022-06-08','10:00','n',1,'y','y','Cesana Brianza','','Lecco','Como',1,5,2,'y'),
	(7,'2022-03-17','10:30','y',3,'y','n',NULL,NULL,'Premana','Trento',10,3,4,'y');

/*!40000 ALTER TABLE `viaggi` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table votazioniP
# ------------------------------------------------------------

LOCK TABLES `votazioniP` WRITE;
/*!40000 ALTER TABLE `votazioniP` DISABLE KEYS */;

INSERT INTO `votazioniP` (`idVotazione`, `idViaggio`, `idPasseggero`, `voto`, `descrizione`)
VALUES
	(1,5,2,4,'consigliato'),
	(2,6,2,5,'guidato bene,  non ha neanche la patente'),
	(4,7,2,3,'abbastanza movimentato ma tutto bene');

/*!40000 ALTER TABLE `votazioniP` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
