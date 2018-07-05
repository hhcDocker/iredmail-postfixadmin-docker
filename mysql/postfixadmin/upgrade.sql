ALTER TABLE `admin`
  CHANGE `username` `username` varchar(255) NOT NULL,
  CHANGE `password` `password` varchar(255) NOT NULL,
  ADD `superadmin` tinyint(1) NOT NULL DEFAULT '0' AFTER `password`,
  CHANGE `name` `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `language` `language` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `settings` `settings` text CHARACTER SET utf8,
  CHANGE `created` `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  CHANGE `modified` `modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:00';

ALTER TABLE `alias`
  CHANGE `address` `address` varchar(255) NOT NULL,
  CHANGE `name` `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `accesspolicy` `accesspolicy` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `domain` `domain` varchar(255) NOT NULL,
  CHANGE `created` `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  CHANGE `modified` `modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  ADD `goto` text NOT NULL;

ALTER TABLE `alias_domain`
  CHANGE `alias_domain` `alias_domain` varchar(255) NOT NULL DEFAULT '',
  CHANGE `target_domain` `target_domain` varchar(255) NOT NULL DEFAULT '',
  CHANGE `created` `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  CHANGE `modified` `modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:00';

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `value` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='PostfixAdmin settings';
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `domain`
  CHANGE `domain` `domain` varchar(255) NOT NULL,
  CHANGE `description` `description` varchar(255) CHARACTER SET utf8 NOT NULL,
  CHANGE `disclaimer` `disclaimer` text CHARACTER SET utf8,
  CHANGE `transport` `transport` varchar(255) NOT NULL,
  CHANGE `settings` `settings` text CHARACTER SET utf8,
  CHANGE `created` `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  CHANGE `modified` `modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:00';

ALTER TABLE `domain_admins`
  CHANGE `username` `username` varchar(255) NOT NULL,
  CHANGE `domain` `domain` varchar(255) NOT NULL,
  CHANGE `created` `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00';

DROP TABLE IF EXISTS `fetchmail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fetchmail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) DEFAULT '',
  `mailbox` varchar(255) NOT NULL,
  `src_server` varchar(255) NOT NULL,
  `src_auth` enum('password','kerberos_v5','kerberos','kerberos_v4','gssapi','cram-md5','otp','ntlm','msn','ssh','any') CHARACTER SET utf8 DEFAULT NULL,
  `src_user` varchar(255) NOT NULL,
  `src_password` varchar(255) NOT NULL,
  `src_folder` varchar(255) NOT NULL,
  `poll_time` int(11) unsigned NOT NULL DEFAULT '10',
  `fetchall` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keep` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `protocol` enum('POP3','IMAP','POP2','ETRN','AUTO') CHARACTER SET utf8 DEFAULT NULL,
  `usessl` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sslcertck` tinyint(1) NOT NULL DEFAULT '0',
  `sslcertpath` varchar(255) CHARACTER SET utf8 DEFAULT '',
  `sslfingerprint` varchar(255) DEFAULT '',
  `extra_options` text,
  `returned_text` text,
  `mda` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `fetchmail` WRITE;
/*!40000 ALTER TABLE `fetchmail` DISABLE KEYS */;
/*!40000 ALTER TABLE `fetchmail` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `timestamp` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `username` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `data` text NOT NULL,
  KEY `timestamp` (`timestamp`),
  KEY `domain_timestamp` (`domain`,`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Log';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

ALTER TABLE `mailbox`
  CHANGE `username` `username` varchar(255) NOT NULL,
  CHANGE `password` `password` varchar(255) NOT NULL,
  CHANGE `name` `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  CHANGE `language` `language` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `storagebasedirectory` `storagebasedirectory` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '/var/vmail',
  CHANGE `storagenode` `storagenode` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT 'vmail1',
  CHANGE `maildir` `maildir` varchar(255) NOT NULL,
  CHANGE `domain` `domain` varchar(255) NOT NULL,
  CHANGE `transport` `transport` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `department` `department` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `rank` `rank` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT 'normal',
  CHANGE `employeeid` `employeeid` varchar(255) CHARACTER SET utf8 DEFAULT '',
  CHANGE `allow_nets` `allow_nets` text CHARACTER SET utf8,
  CHANGE `lastloginprotocol` `lastloginprotocol` char(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  CHANGE `disclaimer` `disclaimer` text CHARACTER SET utf8,
  CHANGE `allowedsenders` `allowedsenders` text CHARACTER SET utf8,
  CHANGE `rejectedsenders` `rejectedsenders` text CHARACTER SET utf8,
  CHANGE `allowedrecipients` `allowedrecipients` text CHARACTER SET utf8,
  CHANGE `rejectedrecipients` `rejectedrecipients` text CHARACTER SET utf8,
  CHANGE `settings` `settings` text CHARACTER SET utf8,
  CHANGE `created` `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  CHANGE `modified` `modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  ADD `local_part` varchar(255) NOT NULL;

DROP TABLE IF EXISTS `quota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota` (
  `username` varchar(255) CHARACTER SET latin1 NOT NULL,
  `path` varchar(100) CHARACTER SET latin1 NOT NULL,
  `current` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`path`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `quota` WRITE;
/*!40000 ALTER TABLE `quota` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `quota2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota2` (
  `username` varchar(100) CHARACTER SET latin1 NOT NULL,
  `bytes` bigint(20) NOT NULL DEFAULT '0',
  `messages` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `quota2` WRITE;
/*!40000 ALTER TABLE `quota2` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota2` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `vacation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacation` (
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 NOT NULL,
  `body` text CHARACTER SET utf8 NOT NULL,
  `activefrom` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `activeuntil` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `cache` text NOT NULL,
  `domain` varchar(255) NOT NULL,
  `interval_time` int(11) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`email`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Vacation';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vacation` WRITE;
/*!40000 ALTER TABLE `vacation` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacation` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `vacation_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacation_notification` (
  `on_vacation` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notified` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `notified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`on_vacation`,`notified`),
  CONSTRAINT `vacation_notification_pkey` FOREIGN KEY (`on_vacation`) REFERENCES `vacation` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Postfix Admin - Virtual Vacation Notifications';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vacation_notification` WRITE;
/*!40000 ALTER TABLE `vacation_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacation_notification` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'version','1836');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO `domain` VALUES ('ALL','',NULL,0,0,0,0,0,'',0,NULL,'2018-01-27 10:56:53','2018-01-27 10:56:53','9999-12-31 00:00:00',1);

/*INSERT INTO `used_quota` VALUES ('postmaster@DOMAIN',19268,7,'DOMAIN');*/

INSERT INTO `admin` (`username`,`password`,`superadmin`,`name`,`language`,`passwordlastchange`,`settings`,`created`,`modified`,`expired`,`active`) VALUES ('postmaster@DOMAIN','TEMP_POSTMASTER_PASSWORD',1,'','','1970-01-01 01:01:01',NULL,'2000-01-01 00:00:00','2000-01-01 00:00:00','9999-12-31 00:00:00',1);

/*INSERT INTO domain (domain,description,disclaimer,transport,settings) VALUES ('DOMAIN','',NULL,'dovecot','default_user_quota:1024;');*/
INSERT INTO alias (address, domain, goto) VALUES ('abuse@DOMAIN', 'DOMAIN', 'postmaster@DOMAIN'),('hostmaster@DOMAIN', 'DOMAIN', 'postmaster@DOMAIN'),('webmaster@DOMAIN', 'DOMAIN', 'postmaster@DOMAIN');
